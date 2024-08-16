import { createSignal } from "solid-js";

import "../assets/css/checklist.css";

import Cloud from "../assets/svgs/cloud.svg?component-solid";
import CircleX from "../assets/svgs/circle-x.svg?component-solid";
import MagnifyingGlass from "../assets/svgs/magnifying-glass.svg?component-solid";
import X from "../assets/svgs/x.svg?component-solid";
import Square from "../assets/svgs/square.svg?component-solid";
import SquareCheck from "../assets/svgs/square-check.svg?component-solid";
import AtoZ from "../assets/svgs/atoz.svg?component-solid";
import ZtoA from "../assets/svgs/ztoa.svg?component-solid";
import Edit from "../assets/svgs/edit.svg?component-solid";
import DoubleLeft from "../assets/svgs/double-left.svg?component-solid";
import Left from "../assets/svgs/left.svg?component-solid";
import Right from "../assets/svgs/right.svg?component-solid";
import DoubleRight from "../assets/svgs/double-right.svg?component-solid";
import Download from "../assets/svgs/download.svg?component-solid";
import Trash from "../assets/svgs/trash.svg?component-solid";

export default function Checklist() {
  const [files, setFiles] = createSignal([]);
  const [currentPage, setCurrentPage] = createSignal(0);
  const [searchQuery, setSearchQuery] = createSignal("");
  const [file, setFile] = createSignal(null);
  const [dragActive, setDragActive] = createSignal(false);
  const [sortOrder, setSortOrder] = createSignal("asc");
  const [openedFile, setOpenedFile] = createSignal(null);

  const allSelected = () => files().length > 0 && files().every((file) => file.selected);

  const handleFileChange = (event) => {
    const uploadedFile = event.target.files[0];
    if (uploadedFile && uploadedFile.type === "application/pdf") {
      setFile(uploadedFile);
    } else {
      setFile(null);
    }
  };

  const handleFileRemove = () => {
    setFile(null);
    document.getElementById("upload-input").value = "";
  };

  const handleDragOver = (event) => {
    event.preventDefault();
    event.stopPropagation();
    setDragActive(true);
  };

  const handleDragLeave = (event) => {
    event.preventDefault();
    event.stopPropagation();
    setDragActive(false);
  };

  const handleDrop = (event) => {
    event.preventDefault();
    event.stopPropagation();
    setDragActive(false);
    const uploadedFile = event.dataTransfer.files[0];
    if (uploadedFile && uploadedFile.type === "application/pdf") {
      setFile(uploadedFile);
    } else {
      setFile(null);
    }
  };

  const handleSubmit = async () => {
    if (!file()) {
      alert("No file selected for submission");
      return;
    }
    const formData = new FormData();
    formData.append("file", file());
    try {
      const response = await fetch(
        "https://prisma-jl.onrender.com/api/checklist/generate",
        {
          method: "POST",
          body: formData,
        }
      );

      if (!response.ok) {
        const errorData = await response.json();
        const errorMessage = `Error generating checklist: ${errorData.error}`;
        alert(errorMessage);
        throw new Error(errorMessage);
      }

      const result = await response.json();
      const newFile = {
        selected: false,
        title: result.title && result.title.trim() !== "" ? result.title : file().name,
        checklist: result.checklist,
      };
      setFiles([...files(), newFile]);
      setOpenedFile(newFile);
      handleFileRemove();
    } catch (error) {
      console.error("Error generating checklist:", error);
      handleFileRemove();
      if (error instanceof Error) {
        alert(`Error generating checklist: ${error.message}`);
      } else {
        alert("Error generating checklist: An unknown error occurred.");
      }
    }
  };

  const filteredFiles = () => {
    return files().filter((file) =>
      file.title.toLowerCase().includes(searchQuery().toLowerCase())
    );
  };

  const totalPages = () => Math.max(Math.ceil(filteredFiles().length / 5), 1);
  const goToFirstPage = () => setCurrentPage(0);
  const goToPreviousPage = () => setCurrentPage(Math.max(currentPage() - 1, 0));
  const goToNextPage = () =>
    setCurrentPage(Math.min(currentPage() + 1, totalPages() - 1));
  const goToLastPage = () => setCurrentPage(totalPages() - 1);

  const handleSort = () => {
    const sortedFiles = [...files()];
    if (sortOrder() === "asc") {
      sortedFiles.sort((a, b) => a.title.localeCompare(b.title));
      setSortOrder("desc");
    } else {
      sortedFiles.sort((a, b) => b.title.localeCompare(a.title));
      setSortOrder("asc");
    }
    setFiles(sortedFiles);
  };

  const toggleFileSelection = (index) => {
    const updatedFiles = [...files()];
    updatedFiles[index].selected = !updatedFiles[index].selected;
    setFiles(updatedFiles);
  };

  const toggleAllFilesSelection = () => {
    const updatedFiles = files().map((file) => ({
      ...file,
      selected: !allSelected(),
    }));
    setFiles(updatedFiles);
  };

  const renderButtons = () => {
    const buttons = [];
    const maxButtons = 5;
    const current = currentPage();
    const start = Math.max(
      0,
      Math.min(current - Math.floor(maxButtons / 2), totalPages() - maxButtons)
    );
    const end = Math.min(totalPages(), start + maxButtons);

    for (let i = start; i < end; i++) {
      buttons.push(
        <button
          title={`page ${i + 1}`}
          class="files-pagination-button"
          type="button"
          onMouseDown={() => setCurrentPage(i)}
          disabled={current === i}
        >
          {i + 1}
        </button>
      );
    }
    return buttons;
  };

  const filesPerPage = 5;

  const renderFiles = () => {
    const filtered = filteredFiles();
    const start = currentPage() * filesPerPage;
    const end = Math.min(start + filesPerPage, filtered.length);

    if (files().length === 0) {
      return (
        <tbody class="files-table-body">
          <tr class="file-table-body-row-empty">
            <td colspan="3" class="no-files-uploaded">
              No files uploaded
            </td>
          </tr>
        </tbody>
      );
    }

    if (filtered.length === 0) {
      return (
        <tbody class="files-table-body">
          <tr class="file-table-body-row-empty">
            <td colspan="3" class="no-files-uploaded">
              No results found
            </td>
          </tr>
        </tbody>
      );
    }

    return (
      <tbody class="files-table-body">
        {filtered.slice(start, end).map((file, index) => (
          <tr class="file-table-body-row" key={index}>
            <td title="select file" class="file-select">
              {file.selected ? (
                <SquareCheck
                  title={`deselect ${file.title}`}
                  class={`file-select-icon ${file.selected ? "selected" : ""}`}
                  onMouseDown={() => toggleFileSelection(index)}
                />
              ) : (
                <Square
                  title={`select ${file.title}`}
                  class={`file-select-icon ${file.selected ? "selected" : ""}`}
                  onMouseDown={() => toggleFileSelection(index)}
                />
              )}
            </td>
            <td title={file.title} class="file-titles">
              {file.title}
            </td>
            <td title="edit checklist" class="file-edit">
              <Edit class="file-edit-icon" onMouseDown={() => setOpenedFile(file)} />
            </td>
          </tr>
        ))}
      </tbody>
    );
  };

  const exportSelectedFiles = async () => {
    const selectedFiles = filteredFiles().filter((file) => file.selected);
    if (selectedFiles.length === 0) {
      alert("No files selected for export");
      return;
    }
    const checklists = selectedFiles.map((file) => ({
      title: file.title,
      checklist: file.checklist,
    }));
    try {
      const response = await fetch(
        "https://prisma-jl.onrender.com/api/checklist/export",
        {
          method: "POST",
          headers: { "Content-Type": "application/json" },
          body: JSON.stringify({ checklists }),
        }
      );

      if (!response.ok) {
        const errorData = await response.json();
        const errorMessage = `Failed to export files: ${errorData.error}`;
        alert(errorMessage);
        throw new Error(errorMessage);
      }

      const csvFiles = await response.json();
      for (const [filename, csvContent] of Object.entries(csvFiles)) {
        const blob = new Blob([csvContent], { type: "text/csv" });
        const url = window.URL.createObjectURL(blob);
        const a = document.createElement("a");
        a.href = url;
        a.download = filename;
        document.body.appendChild(a);
        a.click();
        a.remove();
      }
    } catch (error) {
      console.error("Error exporting checklist(s):", error);
      if (error instanceof Error) {
        alert(`Error exporting checklist(s): ${error.message}`);
      } else {
        alert("Error exporting checklist(s): An unknown error occurred.");
      }
    }
  };

  const removeSelectedFiles = () => {
    const updatedFiles = files().filter((file) => !file.selected);
    if (updatedFiles.length === 0) {
      alert("No files selected");
      return;
    }
    setFiles(updatedFiles);
  };

  const clearSearch = () => {
    setSearchQuery("");
  };

  const renderChecklist = () => {
    return (
      <div class="checklist-container">
        <h1 class="checklist-title">Checklist</h1>
        <div
          class="checklist-content"
          innerHTML={
            openedFile()
              ? openedFile().checklist
              : '<p class="checklist-text">No paper selected</p>'
          }
        />
      </div>
    );
  };

  return (
    <main class="checklist-page">
      <div class="upload-and-files">
        <div class="upload-container">
          <div
            title="upload file"
            class={`upload ${dragActive() ? "drag-active" : ""}`}
            onMouseDown={() => document.getElementById("upload-input").click()}
            onDragOver={handleDragOver}
            onDragLeave={handleDragLeave}
            onDrop={handleDrop}
          >
            <Cloud class="upload-icon" />
            {file() ? (
              <span class="upload-file">
                {file().name}
                <CircleX
                  title="remove file"
                  class="remove-file-icon"
                  onMouseDown={handleFileRemove}
                />
              </span>
            ) : (
              <span class="upload-text">
                Click to browse or drag and drop your PDF here
              </span>
            )}
            <input
              id="upload-input"
              type="file"
              accept=".pdf"
              onInput={handleFileChange}
            />
          </div>
          <button
            title="submit paper"
            type="submit"
            class="upload-button"
            onMouseDown={handleSubmit}
          >
            Submit
          </button>
        </div>
        <div class="files-container">
          <form class="files-search">
            <MagnifyingGlass class="files-search-icon" />
            <input
              title="search files"
              name="search"
              class="files-search-input"
              type="text"
              placeholder="Search files..."
              value={searchQuery()}
              onInput={(e) => setSearchQuery(e.target.value)}
            />
            {searchQuery().length > 0 && (
              <X class="files-search-clear-icon" onMouseDown={clearSearch} />
            )}
          </form>
          <table class="files-table">
            <thead class="files-table-head">
              <tr class="file-table-head-row">
                <th
                  title="select"
                  class="file-select"
                  onMouseDown={toggleAllFilesSelection}
                >
                  {allSelected() ? (
                    <SquareCheck title="deselect all" class="file-select-icon" />
                  ) : (
                    <Square title="select all" class="file-select-icon" />
                  )}
                </th>
                <th
                  title={`sort by title ${
                    sortOrder() === "asc" ? "ascending" : "descending"
                  }`}
                  class="file-title"
                  onMouseDown={handleSort}
                >
                  Title
                  {sortOrder() === "asc" ? (
                    <AtoZ class="files-sort-icon" />
                  ) : (
                    <ZtoA class="files-sort-icon" />
                  )}
                </th>
                <th title="edit checklist" class="file-edit">
                  Edit
                </th>
              </tr>
            </thead>
            {renderFiles()}
          </table>
          <div class="files-buttons">
            <div class="files-pagination-buttons">
              <button
                title="first page"
                class="files-pagination-button"
                type="button"
                onMouseDown={goToFirstPage}
                disabled={currentPage() === 0}
              >
                <DoubleLeft class="files-pagination-button-icon" />
              </button>
              <button
                title="previous page"
                class="files-pagination-button"
                type="button"
                onMouseDown={goToPreviousPage}
                disabled={currentPage() === 0}
              >
                <Left class="files-pagination-button-icon" />
              </button>
              {renderButtons()}
              <button
                title="next page"
                class="files-pagination-button"
                type="button"
                onMouseDown={goToNextPage}
                disabled={currentPage() === totalPages() - 1}
              >
                <Right class="files-pagination-button-icon" />
              </button>
              <button
                title="last page"
                class="files-pagination-button"
                type="button"
                onMouseDown={goToLastPage}
                disabled={currentPage() === totalPages() - 1}
              >
                <DoubleRight class="files-pagination-button-icon" />
              </button>
            </div>
            <div class="files-actions-buttons">
              <button
                title="download selected checklist(s)"
                class="files-actions-button export-button"
                onMouseDown={exportSelectedFiles}
              >
                <Download class="files-actions-button-icon export-button-icon" />
                Export
              </button>
              <button
                title="remove selected file(s)"
                class="files-actions-button remove-button"
                onMouseDown={removeSelectedFiles}
              >
                <Trash class="files-actions-button-icon remove-button-icon" />
                Remove
              </button>
            </div>
          </div>
        </div>
      </div>
      {renderChecklist()}
    </main>
  );
}
