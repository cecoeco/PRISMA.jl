import "../assets/scss/checklist.scss";
import jsPDF from "jspdf";
import autoTable from "jspdf-autotable";
import { onMount, createSignal } from "solid-js";

/**
 * Function representing the checklist page.
 * @function Checklist
 * @returns {JSX.Element} The rendered checklist page.
 */
function Checklist() {
    const [tableData, setTableData] = createSignal([]);

    onMount(async () => {
        try {
            const response = await fetch("http://127.0.0.1:5050/checklist");
            if (!response.ok) {
                throw new Error("Failed to fetch JSON data from server. Status: " + response.status);
            }
            const jsonData = await response.json();
            console.log("Fetched JSON data from server:", jsonData);
            setTableData(jsonData);
        } catch (error) {
            console.error("Error fetching JSON data from server:", error);
        }
    });

    const isEditableCell = (rowData, colIndex) => {
        const nonEmptyValues = rowData.filter(
            (value) => value !== null && value.trim() !== ""
        );
        return colIndex === 3 && nonEmptyValues.length > 1;
    };

    /**
     * Copies the content of the table to the clipboard.
     * @function copy
     * @throws {Error} Throws an error if failed to copy the table.
     */
    function copy() {
        try {
            var table = document.querySelector("table");
            if (!table) {
                throw new Error("No table found in the document.");
            }
            var tableContent = "";
            table.querySelectorAll("tr").forEach(function (row) {
                row.querySelectorAll("td").forEach(function (cell) {
                    tableContent += cell.textContent.trim() + "\t";
                });
                tableContent += "\n";
            });
            navigator.clipboard
                .writeText(tableContent)
                .then(() => {
                    console.log("Table content copied to clipboard.");
                })
                .catch((error) => {
                    console.error("Failed to copy table content to clipboard:", error);
                });
        } catch (error) {
            console.error("Error copying table content to clipboard:", error);
        }
    }

    /**
     * Exports the content of the table as an HTML file.
     * @function exportHTML
     * @throws {Error} Throws an error if failed to export HTML.
     */
    function exportHTML() {
        try {
            var table = document.querySelector("table");
            if (!table) {
                throw new Error("No table found in the document.");
            }
            var tableData = table.outerHTML;
            var blob = new Blob([tableData], { type: "text/html" });
            var url = URL.createObjectURL(blob);
            var a = document.createElement("a");
            a.href = url;
            a.download = "checklist.html";
            document.body.appendChild(a);
            a.click();
            document.body.removeChild(a);
            console.log("Table exported as HTML.");
        } catch (error) {
            console.error("Error exporting HTML:", error);
        }
    }

    /**
     * Exports the content of the table as a PDF file.
     * @function exportPDF
     * @throws {Error} Throws an error if failed to export PDF.
     */
    function exportPDF() {
        try {
            var table = document.querySelector("table");
            if (!table) {
                throw new Error("No table found in the document.");
            }
            var clonedTable = table.cloneNode(true);
            clonedTable.removeAttribute("style");
            clonedTable.querySelectorAll("td, th").forEach(function (cell) {
                cell.removeAttribute("style");
            });
            var pdf = new jsPDF({ orientation: "landscape" });
            autoTable(pdf, { html: clonedTable });
            pdf.save("checklist.pdf");
            console.log("Table exported as PDF.");
        } catch (error) {
            console.error("Error exporting PDF:", error);
        }
    }

    /**
     * Exports the content of the table as an Excel file (XLSX format).
     * @function exportExcel
     * @throws {Error} Throws an error if failed to export Excel.
     */
    function exportExcel() {
        try {
            const table = document.querySelector(".table");
            const ws = XLSX.utils.table_to_sheet(table);
            const wb = XLSX.utils.book_new();
            XLSX.utils.book_append_sheet(wb, ws, "checklist");
            const wbout = XLSX.write(wb, { bookType: "xlsx", type: "binary" });
            function s2ab(s) {
                const buf = new ArrayBuffer(s.length);
                const view = new Uint8Array(buf);
                for (let i = 0; i < s.length; i++) view[i] = s.charCodeAt(i) & 0xff;
                return buf;
            }
            const blob = new Blob([s2ab(wbout)], {
                type: "application/octet-stream",
            });
            const url = URL.createObjectURL(blob);
            const a = document.createElement("a");
            a.href = url;
            a.download = "checklist.xlsx";
            document.body.appendChild(a);
            a.click();
            document.body.removeChild(a);
            console.log("Table exported as Excel Spreadsheet.");
        } catch (error) {
            console.error("An error occurred while exporting Excel:", error);
        }
    }

    /**
     * Exports the content of the table as a CSV file.
     * @function exportCSV
     * @throws {Error} Throws an error if failed to export CSV.
     */
    function exportCSV() {
        try {
            let csvData = "";
            const table = document.querySelector(".table");
            if (!table) {
                throw new Error("No table found in the document.");
            }
            const headerCells = table.querySelectorAll("thead th");
            const headerRowData = Array.from(headerCells).map((cell) =>
                cell.innerText.trim()
            );
            const headerRowCSV = headerRowData.join(",");
            csvData += headerRowCSV + "\n";
            const rows = table.querySelectorAll("tbody > tr");
            rows.forEach((row) => {
                const rowData = [];
                const cells = row.querySelectorAll("td");
                cells.forEach((cell) => {
                    const cellContent = cell.innerHTML.trim();
                    const isHTML =
                        cellContent.startsWith("<") && cellContent.endsWith(">");
                    const cellText = isHTML ? cell.textContent.trim() : cellContent;
                    const escapedCellText = cellText.replace(/"/g, '""');
                    rowData.push(`"${escapedCellText}"`);
                });
                const csvRow = rowData.join(",");
                csvData += csvRow + "\n";
            });
            const blob = new Blob([csvData], { type: "text/csv" });
            const url = URL.createObjectURL(blob);
            const a = document.createElement("a");
            a.href = url;
            a.download = "checklist.csv";
            document.body.appendChild(a);
            a.click();
            document.body.removeChild(a);
            console.log("Table exported as CSV.");
        } catch (error) {
            console.error("Error exporting CSV:", error);
            throw new Error("Failed to export CSV: " + error.message);
        }
    }

    /**
     * Clears the content of all editable elements in the document.
     * @function clear
     * @throws {Error} Throws an error if failed to clear the content.
     */
    function clear() {
        try {
            var editableElements = document.querySelectorAll(
                '[contenteditable="true"]'
            );
            editableElements.forEach(function (element) {
                element.innerHTML = "";
            });
            console.log("Content cleared.");
        } catch (error) {
            console.error("Error clearing content:", error);
        }
    }

    /**
     * Prints the content of the table.
     * @function print
     * @throws {Error} Throws an error if failed to print the table.
     */
    function print() {
        try {
            var table = document.querySelector("table");
            if (!table) {
                throw new Error("No table found in the document.");
            }
            var clonedTable = table.cloneNode(true);
            clonedTable.removeAttribute("style");
            clonedTable.querySelectorAll("td, th").forEach(function (cell) {
                cell.removeAttribute("style");
            });
            var iframe = document.createElement("iframe");
            iframe.style.display = "none";
            document.body.appendChild(iframe);
            var iframeDocument = iframe.contentDocument;
            iframeDocument.write(
                "<html><head><title>Print Table</title></head><body>"
            );
            iframeDocument.write(clonedTable.outerHTML);
            iframeDocument.write("</body></html>");
            iframeDocument.close();
            iframe.focus();
            iframe.contentWindow.print();
            document.body.removeChild(iframe);
            console.log("Table printed.");
        } catch (error) {
            console.error("Error printing table:", error);
        }
    }

    return (
        <div class="checklist">
            <div class="table-container">
                <table class="table">
                    <thead>
                        <tr>
                            {Object.keys(tableData()).map((key, index) => (
                                <th key={index}>{key}</th>
                            ))}
                        </tr>
                    </thead>
                    <tbody>
                        {Object.keys(tableData()).length > 0 &&
                            tableData()["Section and Topic"].map((_, rowIndex) => (
                                <tr key={rowIndex}>
                                    {Object.keys(tableData()).map((key, colIndex) => (
                                        <td
                                            key={colIndex}
                                            contentEditable={isEditableCell(
                                                Object.values(tableData()).map((row) => row[rowIndex]),
                                                colIndex
                                            )}
                                            suppressContentEditableWarning={true}
                                        >
                                            {tableData()[key][rowIndex] === "See the PRISMA 2020 for Abstracts checklist" ? (
                                                <a
                                                    href="http://www.prisma-statement.org/extensions/Abstracts"
                                                    target="_blank"
                                                    rel="noopener noreferrer"
                                                    title="See the PRISMA 2020 for Abstracts checklist"
                                                >
                                                    {tableData()[key][rowIndex]}
                                                </a>
                                            ) : (
                                                tableData()[key][rowIndex]
                                            )}
                                        </td>
                                    ))}
                                </tr>
                            ))}
                    </tbody>
                </table>
            </div>
            <div class="export-buttons">
                <button
                    type="button"
                    class="export-button"
                    onClick={copy}
                    title="Copy"
                >
                    Copy
                </button>
                <button
                    type="button"
                    class="export-button"
                    onClick={exportHTML}
                    title="Export as HTML"
                >
                    HTML
                </button>
                <button
                    type="button"
                    class="export-button"
                    onClick={exportPDF}
                    title="Export as PDF"
                >
                    PDF
                </button>
                <button
                    type="button"
                    class="export-button"
                    onClick={exportExcel}
                    title="Export as Excel"
                >
                    Excel
                </button>
                <button
                    type="button"
                    class="export-button"
                    onClick={exportCSV}
                    title="Export as CSV"
                >
                    CSV
                </button>
                <button
                    type="button"
                    class="export-button"
                    onClick={print}
                    title="Print"
                >
                    Print
                </button>
                <button
                    type="button"
                    class="export-button"
                    onClick={clear}
                    title="Clear"
                >
                    Clear
                </button>
            </div>
        </div>
    );
}

export default Checklist;
