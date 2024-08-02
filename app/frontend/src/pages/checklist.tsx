import { useState } from "react";

import "../assets/css/checklist.css";

import Cloud from "../assets/svgs/cloud.svg?react";
import CircleX from "../assets/svgs/circle-x.svg?react";
import MagnifyingGlass from "../assets/svgs/magnifying-glass.svg?react";
import X from "../assets/svgs/x.svg?react";
import Square from "../assets/svgs/square.svg?react";
import SquareCheck from "../assets/svgs/square-check.svg?react";
import AtoZ from "../assets/svgs/atoz.svg?react";
import ZtoA from "../assets/svgs/ztoa.svg?react";
import Edit from "../assets/svgs/edit.svg?react";
import DoubleLeft from "../assets/svgs/double-left.svg?react";
import Left from "../assets/svgs/left.svg?react";
import Right from "../assets/svgs/right.svg?react";
import DoubleRight from "../assets/svgs/double-right.svg?react";
import Download from "../assets/svgs/download.svg?react";
import Trash from "../assets/svgs/trash.svg?react";

export default function Checklist() {
  const [files, setFiles] = useState([]);
  const [currentPage, setCurrentPage] = useState(0);
  const [searchQuery, setSearchQuery] = useState("");
  const [file, setFile] = useState(null);
  const [dragActive, setDragActive] = useState(false);
  const [sortOrder, setSortOrder] = useState("asc");
  const [openedFile, setOpenedFile] = useState(null);

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
      const response = await fetch("https://prisma-jl.onrender.com/checklist/generate", {
        method: "POST",
        body: formData,
      });
      if (!response.ok) {
        throw new Error("Error submitting file");
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
      console.error("Error submitting file:", error);
      handleFileRemove();
      alert("File could not be sent to the server");
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
          className="files-pagination-button"
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
        <tbody className="files-table-body">
          <tr className="file-table-body-row-empty">
            <td colspan="3" className="no-files-uploaded">
              No files uploaded
            </td>
          </tr>
        </tbody>
      );
    }

    if (filtered.length === 0) {
      return (
        <tbody className="files-table-body">
          <tr className="file-table-body-row-empty">
            <td colspan="3" className="no-files-uploaded">
              No results found
            </td>
          </tr>
        </tbody>
      );
    }

    return (
      <tbody className="files-table-body">
        {filtered.slice(start, end).map((file, index) => (
          <tr className="file-table-body-row" key={index}>
            <td title="select file" className="file-select">
              {file.selected ? (
                <SquareCheck
                  title={`deselect ${file.title}`}
                  className={`file-select-icon ${file.selected ? "selected" : ""}`}
                  onMouseDown={() => toggleFileSelection(index)}
                />
              ) : (
                <Square
                  title={`select ${file.title}`}
                  className={`file-select-icon ${file.selected ? "selected" : ""}`}
                  onMouseDown={() => toggleFileSelection(index)}
                />
              )}
            </td>
            <td title={file.title} className="file-titles">
              {file.title}
            </td>
            <td title="edit checklist" className="file-edit">
              <Edit className="file-edit-icon" onMouseDown={() => setOpenedFile(file)} />
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
      const response = await fetch("http://localhost:5050/checklist/export", {
        method: "POST",
        headers: {
          "Content-Type": "application/json",
        },
        body: JSON.stringify({ checklists }),
      });
      if (!response.ok) {
        throw new Error("Failed to export files");
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
      console.error("Error exporting files:", error);
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
      <div className="checklist-container">
        <h1 className="checklist-title">Checklist</h1>
        <div
          className="checklist-content"
          innerHTML={
            openedFile()
              ? openedFile().checklist
              : '<p className="checklist-text">No paper selected</p>'
          }
        />
      </div>
    );
  };

  return (
    <main className="checklist-page">
      <div className="upload-and-files">
        <div className="upload-container">
          <div
            title="upload file"
            className={`upload ${dragActive() ? "drag-active" : ""}`}
            onMouseDown={() => document.getElementById("upload-input").click()}
            onDragOver={handleDragOver}
            onDragLeave={handleDragLeave}
            onDrop={handleDrop}
          >
            <Cloud className="upload-icon" />
            {file() ? (
              <span className="upload-file">
                {file().name}
                <CircleX
                  title="remove file"
                  className="remove-file-icon"
                  onMouseDown={handleFileRemove}
                />
              </span>
            ) : (
              <span className="upload-text">
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
            className="upload-button"
            onMouseDown={handleSubmit}
          >
            Submit
          </button>
        </div>
        <div className="files-container">
          <form className="files-search">
            <MagnifyingGlass className="files-search-icon" />
            <input
              title="search files"
              name="search"
              className="files-search-input"
              type="text"
              placeholder="Search files..."
              value={searchQuery()}
              onInput={(e) => setSearchQuery(e.target.value)}
            />
            {searchQuery().length > 0 && (
              <X className="files-search-clear-icon" onMouseDown={clearSearch} />
            )}
          </form>
          <table className="files-table">
            <thead className="files-table-head">
              <tr className="file-table-head-row">
                <th
                  title="select"
                  className="file-select"
                  onMouseDown={toggleAllFilesSelection}
                >
                  {allSelected() ? (
                    <SquareCheck title="deselect all" className="file-select-icon" />
                  ) : (
                    <Square title="select all" className="file-select-icon" />
                  )}
                </th>
                <th
                  title={`sort by title ${
                    sortOrder() === "asc" ? "ascending" : "descending"
                  }`}
                  className="file-title"
                  onMouseDown={handleSort}
                >
                  Title
                  {sortOrder() === "asc" ? (
                    <AtoZ className="files-sort-icon" aria-label="Sort ascending" />
                  ) : (
                    <ZtoA className="files-sort-icon" aria-label="Sort descending" />
                  )}
                </th>
                <th title="edit checklist" className="file-edit">
                  Edit
                </th>
              </tr>
            </thead>
            {renderFiles()}
          </table>
          <div className="files-buttons">
            <div className="files-pagination-buttons">
              <button
                title="first page"
                className="files-pagination-button"
                type="button"
                onMouseDown={goToFirstPage}
                disabled={currentPage() === 0}
              >
                <DoubleLeft className="files-pagination-button-icon" />
              </button>
              <button
                title="previous page"
                className="files-pagination-button"
                type="button"
                onMouseDown={goToPreviousPage}
                disabled={currentPage() === 0}
              >
                <Left className="files-pagination-button-icon" />
              </button>
              {renderButtons()}
              <button
                title="next page"
                className="files-pagination-button"
                type="button"
                onMouseDown={goToNextPage}
                disabled={currentPage() === totalPages() - 1}
              >
                <Right className="files-pagination-button-icon" />
              </button>
              <button
                title="last page"
                className="files-pagination-button"
                type="button"
                onMouseDown={goToLastPage}
                disabled={currentPage() === totalPages() - 1}
              >
                <DoubleRight className="files-pagination-button-icon" />
              </button>
            </div>
            <div className="files-actions-buttons">
              <button
                title="download selected checklist(s)"
                className="files-actions-button export-button"
                onMouseDown={exportSelectedFiles}
              >
                <Download className="files-actions-button-icon export-button-icon" />
                Export
              </button>
              <button
                title="remove selected file(s)"
                className="files-actions-button remove-button"
                onMouseDown={removeSelectedFiles}
              >
                <Trash className="files-actions-button-icon remove-button-icon" />
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
