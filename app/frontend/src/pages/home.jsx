import "../assets/scss/home.scss";
import { createSignal } from "solid-js";

/**
 * Function representing the Home component.
 * @function Home
 * @return {JSX.Element} The rendered Home component
 */
function Home() {
    /**
     * Fetches CSV data from the server and downloads it as a file.
     * @async
     * @function getCSV
     * @throws {Error} Throws an error if failed to fetch CSV data.
     */
    async function getCSV() {
        try {
            const response = await fetch("http://127.0.0.1:5050/flow_diagram/csv");
            if (!response.ok) {
                throw new Error("Failed to fetch CSV data from server. Status: " + response.status);
            }
            const csvData = await response.text();
            const blob = new Blob([csvData], { type: "text/csv" });
            const url = URL.createObjectURL(blob);
            const link = document.createElement("a");
            link.href = url;
            link.download = "flow_diagram.csv";
            link.click();
            URL.revokeObjectURL(url);
            console.log("CSV data received from server:", csvData);
        } catch (error) {
            console.error("Error fetching and saving CSV data from server:", error);
        }
    }

    /**
     * Fetches JSON data from the server and downloads it as a file.
     * @async
     * @function getJSON
     * @throws {Error} Throws an error if failed to fetch JSON data.
     */
    async function getJSON() {
        try {
            const response = await fetch("http://127.0.0.1:5050/flow_diagram/json");
            if (!response.ok) {
                throw new Error("Failed to fetch JSON data from server. Status: " + response.status);
            }
            const jsonData = await response.json();
            const blob = new Blob([JSON.stringify(jsonData)], {
                type: "application/json",
            });
            const url = URL.createObjectURL(blob);
            const link = document.createElement("a");
            link.href = url;
            link.download = "flow_diagram.json";
            link.click();
            URL.revokeObjectURL(url);
            console.log("JSON data received from server:", jsonData);
        } catch (error) {
            console.error("Error fetching and saving JSON data from server:", error);
        }
    }

    /**
     * Fetches XLSX data from the server and downloads it as a file.
     * @async
     * @function getXLSX
     * @throws {Error} Throws an error if failed to fetch XLSX data.
     */
    async function getXLSX() {
        try {
            const response = await fetch("http://127.0.0.1:5050/flow_diagram/xlsx");
            if (!response.ok) {
                throw new Error("Failed to fetch XLSX data from server. Status: " + response.status);
            }
            const xlsxData = await response.blob();
            const blob = new Blob([xlsxData], {
                type: "application/vnd.openxmlformats-officedocument.spreadsheetml.sheet",
            });
            const url = URL.createObjectURL(blob);
            const link = document.createElement("a");
            link.href = url;
            link.download = "flow_diagram.xlsx";
            link.click();
            URL.revokeObjectURL(url);
            console.log("XLSX data received from server:", xlsxData);
        } catch (error) {
            console.error("Error fetching and saving XLSX data from server:", error);
        }
    }

    const [dragging, setDragging] = createSignal(false);

    function handleDragOver(event) {
        event.preventDefault();
        const file = event.dataTransfer.files[0];
        const allowedTypes = [
            "application/vnd.ms-excel",
            "application/json",
            "application/vnd.openxmlformats-officedocument.spreadsheetml.sheet",
        ];
        if (file && allowedTypes.includes(file.type)) {
            setDragging(true);
            event.currentTarget.classList.remove("disabled");
        } else {
            setDragging(false);
            event.currentTarget.classList.add("disabled");
        }
    }

    function handleDragLeave(event) {
        event.preventDefault();
        setDragging(false);
        event.currentTarget.classList.remove("disabled");
    }

    function handleDrop(event) {
        event.preventDefault();
        setDragging(false);
        const file = event.dataTransfer.files[0];
        if (file) {
            handleFile(file);
        }
    }

    function handleFile(file) {
        console.log("Uploaded file:", file);
        postData(file);
    }

    function handleBrowseClick() {
        document.getElementById("upload-spreadsheet").click();
    }

    function handleFileInputChange(event) {
        const file = event.target.files[0];
        if (file) {
            handleFile(file);
        }
    }

    async function postData(file) {
        try {
            const allowedTypes = [
                "application/vnd.ms-excel",
                "application/json",
                "application/vnd.openxmlformats-officedocument.spreadsheetml.sheet",
            ];
            if (!allowedTypes.includes(file.type)) {
                throw new Error("Please upload a file of type CSV, JSON, or XLSX.");
            }
            const formData = new FormData();
            formData.append("file", file);
            const response = await fetch(
                "http://127.0.0.1:5050/flow_diagram/upload",
                {
                    method: "POST",
                    body: formData,
                }
            );
            if (!response.ok) {
                throw new Error("Failed to post data. Status: " + response.status);
            }
            const data = await response.json();
            console.log("Data received from server:", data);
            return data;
        } catch (error) {
            console.error("Error handling file:", error);
        }
    }

    return (
        <div class="home">
            <div class="upload-spreadsheet">
                <div class="spreadsheet-buttons">
                    <h3 class="home-header">Download Template:</h3>
                    <button
                        name="download-csv"
                        onClick={getCSV}
                        class="spreadsheet-button"
                        title="Download CSV"
                    >
                        CSV
                    </button>
                    <button
                        name="download-json"
                        onClick={getJSON}
                        class="spreadsheet-button"
                        title="Download JSON"
                    >
                        JSON
                    </button>
                    <button
                        name="download-xlsx"
                        onClick={getXLSX}
                        class="spreadsheet-button"
                        title="Download XLSX"
                    >
                        XLSX
                    </button>
                </div>
                <div
                    classList={{ upload: true, dragging: dragging() }}
                    onDragOver={handleDragOver}
                    onDragLeave={handleDragLeave}
                    onDrop={handleDrop}
                    onClick={handleBrowseClick}
                >
                    <p class="upload-text">
                        {dragging()
                            ? "Drop your CSV, JSON, XLSX here"
                            : "Drag and drop or click to upload modified CSV, JSON, or XLSX."}
                        <input
                            id="upload-spreadsheet"
                            onChange={handleFileInputChange}
                            class="upload-input"
                            type="file"
                            accept=".csv, .json, .xlsx"
                        />
                    </p>
                </div>
            </div>
        </div>
    );
}

export default Home;
