import React, { ChangeEvent, DragEvent, useRef, useState } from "react";

import "../assets/scss/checklist.scss";

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

interface FileItem {
  selected: boolean;
  title: string;
  checklist: string;
}

const Checklist: React.FC = () => {
  const [files, setFiles] = useState<FileItem[]>([]);
  const [currentPage, setCurrentPage] = useState<number>(0);
  const [searchQuery, setSearchQuery] = useState<string>("");
  const [file, setFile] = useState<File | null>(null);
  const [dragActive, setDragActive] = useState<boolean>(false);
  const [sortOrder, setSortOrder] = useState<"asc" | "desc">("asc");
  const [openedFile, setOpenedFile] = useState<FileItem | null>(null);

  const uploadInputRef = useRef<HTMLInputElement>(null);

  const allSelected = (): boolean =>
    files.length > 0 && files.every((file) => file.selected);

  const handleFileChange = (event: ChangeEvent<HTMLInputElement>): void => {
    const uploadedFile = event.target.files?.[0];
    if (uploadedFile && uploadedFile.type === "application/pdf") {
      setFile(uploadedFile);
    } else {
      setFile(null);
    }
  };

  const handleFileRemove = (): void => {
    setFile(null);
    if (uploadInputRef.current) {
      uploadInputRef.current.value = "";
    }
  };

  const handleDragOver = (event: DragEvent<HTMLDivElement>): void => {
    event.preventDefault();
    event.stopPropagation();
    setDragActive(true);
  };

  const handleDragLeave = (event: DragEvent<HTMLDivElement>): void => {
    event.preventDefault();
    event.stopPropagation();
    setDragActive(false);
  };

  const handleDrop = (event: DragEvent<HTMLDivElement>): void => {
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

  const handleSubmit = async (): Promise<void> => {
    if (!file) {
      alert("No file selected for submission");
      return;
    }
    const formData = new FormData();
    formData.append("file", file);
    try {
      const response = await fetch("/api/checklist/generate", {
        method: "POST",
        body: formData,
      });

      if (!response.ok) {
        const errorData = await response.json();
        const errorMessage = `Error generating checklist: ${errorData.error}`;
        alert(errorMessage);
        throw new Error(errorMessage);
      }

      const result = await response.json();
      const newFile: FileItem = {
        selected: false,
        title: result.title && result.title.trim() !== "" ? result.title : file.name,
        checklist: result.checklist,
      };
      setFiles([...files, newFile]);
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

  const filteredFiles = (): FileItem[] => {
    return files.filter((file) =>
      file.title.toLowerCase().includes(searchQuery.toLowerCase())
    );
  };

  const totalPages = (): number => Math.max(Math.ceil(filteredFiles().length / 5), 1);

  const goToFirstPage = (): void => setCurrentPage(0);
  const goToPreviousPage = (): void => setCurrentPage((prev) => Math.max(prev - 1, 0));
  const goToNextPage = (): void => setCurrentPage((prev) => Math.min(prev + 1, totalPages() - 1));
  const goToLastPage = (): void => setCurrentPage(totalPages() - 1);

  const handleSort = (): void => {
    const sortedFiles = [...files];
    if (sortOrder === "asc") {
      sortedFiles.sort((a, b) => a.title.localeCompare(b.title));
      setSortOrder("desc");
    } else {
      sortedFiles.sort((a, b) => b.title.localeCompare(a.title));
      setSortOrder("asc");
    }
    setFiles(sortedFiles);
  };

  const toggleFileSelection = (index: number): void => {
    const updatedFiles = [...files];
    updatedFiles[index].selected = !updatedFiles[index].selected;
    setFiles(updatedFiles);
  };

  const toggleAllFilesSelection = (): void => {
    const updatedFiles = files.map((file) => ({
      ...file,
      selected: !allSelected(),
    }));
    setFiles(updatedFiles);
  };

  const renderButtons = (): JSX.Element[] => {
    const buttons: JSX.Element[] = [];
    const maxButtons = 5;
    const current = currentPage;
    const start = Math.max(
      0,
      Math.min(current - Math.floor(maxButtons / 2), totalPages() - maxButtons)
    );
    const end = Math.min(totalPages(), start + maxButtons);

    for (let i = start; i < end; i++) {
      buttons.push(
        <button
          key={i}
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

  const renderFiles = (): JSX.Element => {
    const filtered = filteredFiles();
    const start = currentPage * filesPerPage;
    const end = Math.min(start + filesPerPage, filtered.length);

    if (files.length === 0) {
      return (
        <tbody className="files-table-body">
          <tr className="file-table-body-row-empty">
            <td colSpan={3} className="no-files-uploaded">
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
            <td colSpan={3} className="no-files-uploaded">
              No results found
            </td>
          </tr>
        </tbody>
      );
    }

    return (
      <tbody className="files-table-body">
        {filtered.slice(start, end).map((fileItem, index) => (
          <tr className="file-table-body-row" key={index}>
            <td title="select file" className="file-select">
              {fileItem.selected ? (
                <SquareCheck
                  title={`deselect ${fileItem.title}`}
                  className={`file-select-icon selected`}
                  onMouseDown={() => toggleFileSelection(index)}
                />
              ) : (
                <Square
                  title={`select ${fileItem.title}`}
                  className="file-select-icon"
                  onMouseDown={() => toggleFileSelection(index)}
                />
              )}
            </td>
            <td title={fileItem.title} className="file-titles">
              {fileItem.title}
            </td>
            <td title="edit checklist" className="file-edit">
              <Edit
                className="file-edit-icon"
                onMouseDown={() => setOpenedFile(fileItem)}
              />
            </td>
          </tr>
        ))}
      </tbody>
    );
  };

  const exportSelectedFiles = async (): Promise<void> => {
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
      const response = await fetch("/api/checklist/export", {
        method: "POST",
        headers: { "Content-Type": "application/json" },
        body: JSON.stringify({ checklists }),
      });

      if (!response.ok) {
        const errorData = await response.json();
        const errorMessage = `Failed to export files: ${errorData.error}`;
        alert(errorMessage);
        throw new Error(errorMessage);
      }

      const csvFiles: { [filename: string]: string } = await response.json();
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

  const removeSelectedFiles = (): void => {
    const updatedFiles = files.filter((file) => !file.selected);
    if (updatedFiles.length === files.length) {
      alert("No files selected");
      return;
    }
    setFiles(updatedFiles);
  };

  const clearSearch = (): void => {
    setSearchQuery("");
  };

  const renderChecklist = (): JSX.Element => {
    return (
      <div className="checklist-container">
        <h1 className="checklist-title">Checklist</h1>
        <div
          className="checklist-content"
          dangerouslySetInnerHTML={{
            __html: openedFile
              ? openedFile.checklist
              : '<p class="checklist-text">No paper selected</p>',
          }}
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
            className={`upload ${dragActive ? "drag-active" : ""}`}
            onMouseDown={() => uploadInputRef.current?.click()}
            onDragOver={handleDragOver}
            onDragLeave={handleDragLeave}
            onDrop={handleDrop}
          >
            <Cloud className="upload-icon" />
            {file ? (
              <span className="upload-file">
                {file.name}
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
              onChange={handleFileChange}
              ref={uploadInputRef}
            />
          </div>
          <button
            title="submit paper"
            type="button"
            className="upload-button"
            onMouseDown={handleSubmit}
          >
            Submit
          </button>
        </div>
        <div className="files-container">
          <form
            className="files-search"
            onSubmit={(e) => e.preventDefault()}
          >
            <MagnifyingGlass className="files-search-icon" />
            <input
              title="search files"
              name="search"
              className="files-search-input"
              type="text"
              placeholder="Search files..."
              value={searchQuery}
              onChange={(e) => setSearchQuery(e.target.value)}
            />
            {searchQuery.length > 0 && (
              <X
                className="files-search-clear-icon"
                onMouseDown={clearSearch}
                style={{ cursor: "pointer" }}
              />
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
                    sortOrder === "asc" ? "ascending" : "descending"
                  }`}
                  className="file-title"
                  onMouseDown={handleSort}
                  style={{ cursor: "pointer" }}
                >
                  Title
                  {sortOrder === "asc" ? (
                    <AtoZ className="files-sort-icon" />
                  ) : (
                    <ZtoA className="files-sort-icon" />
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
                disabled={currentPage === 0}
              >
                <DoubleLeft className="files-pagination-button-icon" />
              </button>
              <button
                title="previous page"
                className="files-pagination-button"
                type="button"
                onMouseDown={goToPreviousPage}
                disabled={currentPage === 0}
              >
                <Left className="files-pagination-button-icon" />
              </button>
              {renderButtons()}
              <button
                title="next page"
                className="files-pagination-button"
                type="button"
                onMouseDown={goToNextPage}
                disabled={currentPage === totalPages() - 1}
              >
                <Right className="files-pagination-button-icon" />
              </button>
              <button
                title="last page"
                className="files-pagination-button"
                type="button"
                onMouseDown={goToLastPage}
                disabled={currentPage === totalPages() - 1}
              >
                <DoubleRight className="files-pagination-button-icon" />
              </button>
            </div>
            <div className="files-actions-buttons">
              <button
                title="download selected checklist(s)"
                className="files-actions-button export-button"
                type="button"
                onMouseDown={exportSelectedFiles}
              >
                <Download className="files-actions-button-icon export-button-icon" />
                Export
              </button>
              <button
                title="remove selected file(s)"
                className="files-actions-button remove-button"
                type="button"
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
};

export default Checklist;
