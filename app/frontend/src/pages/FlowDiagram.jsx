import "../assets/scss/FlowDiagram.scss";

function FlowDiagram() {
    function getCSV() {
        fetch("http://127.0.0.1:8080/csv")
            .then((response) => response.text())
            .then((csvData) => {
                console.log(csvData);
            })
            .catch((error) => {
                console.error("Error fetching the CSV:", error);
            });
    }

    function getJSON() {
        fetch("http://127.0.0.1:8080/json")
            .then((response) => response.json())
            .then((jsonData) => {
                console.log(jsonData);
            })
            .catch((error) => {
                console.error("Error fetching the JSON:", error);
            });
    }

    function getXLSX() {
        fetch("http://127.0.0.1:8080/xlsx")
            .then((response) => response.blob())
            .then((xlsxData) => {
                console.log(xlsxData);
            })
            .catch((error) => {
                console.error("Error fetching the XLSX:", error);
            });
    }

    function uploadSpreadsheet() {

    }

    return (
        <>
            <div class="flow-diagram">
                <div class="options">
                    <div class="upload-spreadsheet-options">
                        <div>
                            <button
                                onClick={getCSV}
                                class="download-spreadsheet-button"
                            >
                                Download CSV
                            </button>
                            <button
                                onClick={getJSON}
                                class="download-spreadsheet-button"
                            >
                                Download JSON
                            </button>
                            <button
                                onClick={getXLSX}
                                class="download-spreadsheet-button"
                            >
                                Download XLSX
                            </button>
                            <input
                                class="upload-spreadsheet"
                                type="file"
                                accept=".csv, .json, .xlsx"
                            />
                            <button
                                onClick={uploadSpreadsheet}
                                class="upload-spreadsheet-button"
                            >
                                Upload Spreadsheet
                            </button>
                        </div>
                    </div>
                    <div>
                        <div>
                            <div>
                                <h3>Options</h3>
                            </div>
                            <div>
                                <h4>Canvas</h4>
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
                            <div>
                                <button>Clear</button>
                            </div>
                        </div>
                        <div>
                            <h3>Download</h3>
                            <button>SVG</button>
                            <button>JPG</button>
                            <button>PNG</button>
                            <button>PDF</button>
                            <button>HTML</button>
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
