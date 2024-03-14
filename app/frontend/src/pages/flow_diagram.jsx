import { createSignal } from "solid-js";

import "../assets/scss/flow_diagram.scss";

function FlowDiagram() {
    function Clear() {

    }
    function Undo() {

    }

    function Redo() {

    }

    async function getCSV() {
        try {
            await fetch("http://0.0.0.0:5050/csv")
                .then((response) => {
                    if (!response.ok) {
                        throw new Error("Failed to fetch CSV");
                    }
                    return response.text();
                })
                .then((csvData) => {
                    const blob = new Blob([csvData], { type: "text/csv" });
                    const url = URL.createObjectURL(blob);
                    const link = document.createElement("a");
                    link.href = url;
                    link.download = "flow_diagram.csv";
                    link.click();
                    URL.revokeObjectURL(url);
                })
                .catch((error) => {
                    console.error("Error fetching and saving CSV:", error);
                });
        } catch (error) {
            console.error("Error fetching and saving CSV:", error);
        }
    }

    async function getJSON() {
        try {
            await fetch("http://0.0.0.0:5050/json")
                .then((response) => {
                    if (!response.ok) {
                        throw new Error("Failed to fetch JSON");
                    }
                    return response.text();
                })
                .then((jsonData) => {
                    const blob = new Blob([jsonData], { type: "application/json" });
                    const url = URL.createObjectURL(blob);
                    const link = document.createElement("a");
                    link.href = url;
                    link.download = "flow_diagram.json";
                    link.click();
                    URL.revokeObjectURL(url);
                })
                .catch((error) => {
                    console.error("Error fetching and saving JSON:", error);
                });
        } catch (error) {
            console.error("Error fetching and saving JSON:", error);
        }
    }

    async function getXLSX() {
        try {
            await fetch("http://0.0.0.0:5050/xlsx")
                .then((response) => {
                    if (!response.ok) {
                        throw new Error("Failed to fetch XLSX");
                    }
                    return response.text();
                })
                .then((xlsxData) => {
                    const blob = new Blob([xlsxData],
                        { type: "application/vnd.openxmlformats-officedocument.spreadsheetml.sheet" });
                    const url = URL.createObjectURL(blob);
                    const link = document.createElement("a");
                    link.href = url;
                    link.download = "flow_diagram.xlsx";
                    link.click();
                    URL.revokeObjectURL(url);
                })
                .catch((error) => {
                    console.error("Error fetching and saving XLSX:", error);
                });
        } catch (error) {
            console.error("Error fetching and saving XLSX:", error);
        }
    }

    let uploadedFile = null;

    function uploadSpreadsheet(event) {
        const file = event.target.files[0];
        uploadedFile = file;
        console.log("Uploaded file:", file);
        const formData = new FormData();
        formData.append("file", file);
        fetch("http://example.com/upload", {
            method: "POST",
            body: formData,
        })
            .then((response) => {
                if (!response.ok) {
                    throw new Error("Failed to upload file");
                }
                return response.json();
            })
            .then((data) => {
                console.log("Server response:", data);
            })
            .catch((error) => {
                console.error("Error uploading file:", error);
            });
    }

    return (
        <>
            <div class="flow-diagram">
                <div class="options">
                    <div class="top-buttons">
                        <div>
                            <button
                                class="clear-button"
                                onClick={Clear}
                            >
                                Clear
                            </button>
                        </div>
                        <div class="flow-diagram-edit-buttons">
                            <button
                                class="flow-diagram-edit-button"
                                onClick={Undo}
                            >
                                <img
                                    draggable="false"
                                    class="flow-diagram-edit-button-svg"
                                    src="src/assets/svg/undo.svg"
                                    alt="undo"
                                />
                            </button>
                            <button
                                class="flow-diagram-edit-button"
                                onClick={Redo}
                            >
                                <img
                                    draggable="false"
                                    class="flow-diagram-edit-button-svg"
                                    src="src/assets/svg/redo.svg"
                                    alt="redo"
                                />
                            </button>
                        </div>
                    </div>
                    <div class="upload-spreadsheet">
                        <h3>Upload Spreadsheet</h3>
                        <h4>Download Template:</h4>
                        <div class="upload-buttons">
                            <button
                                onClick={getCSV}
                                class="spreadsheet-button"
                            >
                                CSV
                            </button>
                            <button
                                onClick={getJSON}
                                class="spreadsheet-button"
                            >
                                JSON
                            </button>
                            <button
                                onClick={getXLSX}
                                class="spreadsheet-button"
                            >
                                XLSX
                            </button>
                        </div>
                        <div class="upload">
                            <p class="upload-text">
                                Drag and drop or click to upload files.
                                <input
                                    onChange={uploadSpreadsheet}
                                    class="upload-input"
                                    type="file"
                                    accept=".csv, .json, .xlsx"
                                />
                            </p>
                        </div>
                    </div>
                    <div>
                        <div>
                            <div>
                                <h3>Data</h3>
                            </div>
                            <div>
                                <h4>Identification</h4>
                                <div>
                                    <label>Previous Studies</label>
                                    <input type="number" placeholder="0" />
                                </div>
                                <div>
                                    <label>Previous Reports</label>
                                    <input type="number" placeholder="0" />
                                </div>
                                <div>
                                    <label>Database 1</label>
                                    <input type="text" placeholder="Database 1" />
                                    <input type="number" placeholder="0" />
                                </div>
                                <div>
                                    <label>Database 2</label>
                                    <input type="text" placeholder="Database 2" />
                                    <input type="number" placeholder="0" />
                                </div>
                                <div>
                                    <label>Database 3</label>
                                    <input type="text" placeholder="Database 3" />
                                    <input type="number" placeholder="0" />
                                </div>
                                <div>
                                    <label>Duplicates Removed</label>
                                    <input type="number" placeholder="0" />
                                </div>
                                <div>
                                    <label>Automatically Excluded</label>
                                    <input type="number" placeholder="0" />
                                </div>
                                <div>
                                    <label>Other Reasons</label>
                                    <input type="number" placeholder="0" />
                                </div>
                                <div>
                                    <label>Websites</label>
                                    <input type="number" placeholder="0" />
                                </div>
                                <div>
                                    <label>Organizations</label>
                                    <input type="number" placeholder="0" />
                                </div>
                                <div>
                                    <label>Citations</label>
                                    <input type="number" placeholder="0" />
                                </div>
                            </div>
                            <div>
                                <h4>Screening</h4>
                                <div>
                                    <label>Record Screened</label>
                                    <input type="number" placeholder="0" />
                                </div>
                                <div>
                                    <label>Record Excluded</label>
                                    <input type="number" placeholder="0" />
                                </div>
                                <div>
                                    <label>Reports Sought</label>
                                    <input type="number" placeholder="0" />
                                </div>
                                <div>
                                    <label>Reports Not Retrieved</label>
                                    <input type="number" placeholder="0" />
                                </div>
                                <div>
                                    <label>Other Reports Sought</label>
                                    <input type="number" placeholder="0" />
                                </div>
                                <div>
                                    <label>Other Reports Not Retrieved</label>
                                    <input type="number" placeholder="0" />
                                </div>
                                <div>
                                    <label>Reports Assessed</label>
                                    <input type="number" placeholder="0" />
                                </div>
                                <div>
                                    <label>Reason 1</label>
                                    <input type="text" placeholder="Reason 1" />
                                    <input type="number" placeholder="0" />
                                </div>
                                <div>
                                    <label>Reason 2</label>
                                    <input type="text" placeholder="Reason 2" />
                                    <input type="number" placeholder="0" />
                                </div>
                                <div>
                                    <label>Reason 3</label>
                                    <input type="text" placeholder="Reason 3" />
                                    <input type="number" placeholder="0" />
                                </div>
                                <div>
                                    <label>Other Reports Assessed</label>
                                    <input type="number" placeholder="0" />
                                </div>
                                <div>
                                    <label>Reason 1</label>
                                    <input type="text" placeholder="Reason 1" />
                                    <input type="number" placeholder="0" />
                                </div>
                                <div>
                                    <label>Reason 2</label>
                                    <input type="text" placeholder="Reason 2" />
                                    <input type="number" placeholder="0" />
                                </div>
                                <div>
                                    <label>Reason 3</label>
                                    <input type="text" placeholder="Reason 3" />
                                    <input type="number" placeholder="0" />
                                </div>
                            </div>
                            <div>
                                <h4>Included</h4>
                                <div>
                                    <label>New Studies</label>
                                    <input type="number" placeholder="0" />
                                </div>
                                <div>
                                    <label>New Reports</label>
                                    <input type="number" placeholder="0" />
                                </div>
                                <div>
                                    <label>Total Studies</label>
                                    <input type="number" placeholder="0" />
                                </div>
                                <div>
                                    <label>Total Reports</label>
                                    <input type="number" placeholder="0" />
                                </div>
                            </div>
                        </div>
                        <div>
                            <div>
                                <h3>Visual</h3>
                            </div>
                            <div>
                                <h4>Background</h4>
                                <div>
                                    <label>Background Color</label>
                                    <input type="color" value="#ffffff" />
                                </div>
                            </div>
                            <div>
                                <h4>Boxes</h4>
                                <div>
                                    <label>Previous Studies</label>
                                    <select name="Previous Studies">
                                        <option value="true">True</option>
                                        <option value="false">False</option>
                                    </select>
                                </div>
                                <div>
                                    <label>Other Methods</label>
                                    <select name="Other Methods">
                                        <option value="true">True</option>
                                        <option value="false">False</option>
                                    </select>
                                </div>
                                <div>
                                    <label>Gray Boxes</label>
                                    <select name="Gray Boxes">
                                        <option value="true">True</option>
                                        <option value="false">False</option>
                                    </select>
                                </div>
                                <div>
                                    <label>Gray Boxes Color</label>
                                    <input type="color" value="#f0f0f0" />
                                </div>
                                <div>
                                    <label>Top Boxes</label>
                                    <select name="Top Boxes">
                                        <option value="true">True</option>
                                        <option value="false">False</option>
                                    </select>
                                </div>
                                <div>
                                    <label>Top Boxes Border</label>
                                    <select name="Top Boxes Border">
                                        <option value="true">True</option>
                                        <option value="false">False</option>
                                    </select>
                                </div>
                                <div>
                                    <label>Top Boxes Color</label>
                                    <input type="color" value="#ffc000" />
                                </div>
                                <div>
                                    <label>Side Boxes</label>
                                    <select name="Side Boxes">
                                        <option value="true">True</option>
                                        <option value="false">False</option>
                                    </select>
                                </div>
                                <div>
                                    <label>Side Boxes Border</label>
                                    <select name="Side Boxes Border">
                                        <option value="true">True</option>
                                        <option value="false">False</option>
                                    </select>
                                </div>
                                <div>
                                    <label>Side Boxes Color</label>
                                    <input type="color" value="#95cbff" />
                                </div>
                                <div>
                                    <label>Border Width</label>
                                    <input type="number" placeholder="0" />
                                </div>
                                <div>
                                    <label>Border Color</label>
                                    <input type="color" value="#000000" />
                                </div>
                            </div>
                            <div>
                                <h4>Arrows</h4>
                                <div>
                                    <label>Arrow Head</label>
                                    <input type="text" placeholder=":utriangle" />
                                </div>
                                <div>
                                    <label>Arrow Head Size</label>
                                    <input type="number" placeholder="0" />
                                </div>
                                <div>
                                    <label>Arrow Width</label>
                                    <input type="number" placeholder="0" />
                                </div>
                                <div>
                                    <label>Arrow Color</label>
                                    <input type="color" />
                                </div>
                            </div>
                            <div>
                                <h4>Text</h4>
                                <div>
                                    <label>Text Font</label>
                                    <select name="Text Font">
                                        <option value="Arial">Arial</option>
                                        <option value="Avenir">Avenir</option>
                                        <option value="Baskerville">Baskerville</option>
                                        <option value="Calibri">Calibri</option>
                                        <option value="Cambria">Cambria</option>
                                        <option value="Garamond">Garamond</option>
                                        <option value="Georgia">Georgia</option>
                                        <option value="Futura">Futura</option>
                                        <option value="Helvetica">Helvetica</option>
                                        <option value="Times New Roman">Times New Roman</option>
                                    </select>
                                </div>
                                <div>
                                    <label>Text Size</label>
                                    <input type="number" placeholder="0" />
                                </div>
                                <div>
                                    <label>Text Color</label>
                                    <input type="color" />
                                </div>
                            </div>
                        </div>
                        <div class="download-container">
                            <h3>Download</h3>
                            <div class="download-buttons">
                                <button class="download-button">SVG</button>
                                <button class="download-button">JPG</button>
                                <button class="download-button">PNG</button>
                                <button class="download-button">PDF</button>
                                <button class="download-button">HTML</button>
                            </div>
                        </div>
                    </div>
                </div>
                <div class="figure-container">
                    <svg></svg>
                </div>
            </div>
        </>
    );
}

export default FlowDiagram;
