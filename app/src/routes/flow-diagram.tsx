import { createSignal } from "solid-js";
import { Title } from "@solidjs/meta";
import jsPDF from 'jspdf';

function FlowDiagram() {
    const downloadCSV = async () => {
        try {
            const response = await fetch('api/flow-diagram/csv');
            const csvData = await response.text();
            const blob = new Blob([csvData], { type: 'text/csv' });
            const url = URL.createObjectURL(blob);
            const link = document.createElement('a');
            link.href = url;
            link.download = 'flow_diagram.csv';
            document.body.appendChild(link);
            link.click();
            document.body.removeChild(link);
        } catch (error) {
            console.error('Error downloading CSV:', error);
        }
    };

    const downloadXLSX = async () => {
        try {
            const response = await fetch('/api/flow-diagram/xlsx');
            const blob = await response.blob();
            const url = window.URL.createObjectURL(blob);
            const a = document.createElement('a');
            a.href = url;
            a.download = 'flow_diagram.xlsx';
            document.body.appendChild(a);
            a.click();
            document.body.removeChild(a);
            window.URL.revokeObjectURL(url);
        } catch (error) {
            console.error('Error downloading XLSX:', error);
        }
    };
    
    const [backgroundColor, setBackgroundColor] = createSignal(false);
    const [previousStudies, setPreviousStudies] = createSignal(true);
    const [otherMethods, setOtherMethods] = createSignal(true);
    const [grayBoxes, setGrayBoxes] = createSignal(true);
    const [grayBoxesColor, setGrayBoxesColor] = createSignal("#f0f0f0");
    const [topBoxes, setTopBoxes] = createSignal(true);
    const [topBoxesColor, setTopBoxesColor] = createSignal("#ffc000");
    const [sideBoxes, setSideBoxes] = createSignal(true);
    const [sideBoxesColor, setSideBoxesColor] = createSignal("#95cbff");
    const [borderWidth, setBorderWidth] = createSignal("1");
    const [borderColor, setBorderColor] = createSignal("#000000");
    const [arrowHead, setArrowHead] = createSignal(":utriangle");
    const [arrowHeadSize, setArrowHeadSize] = createSignal("12");
    const [arrowWidth, setArrowWidth] = createSignal("1");
    const [arrowColor, setArrowColor] = createSignal("#000000");
    const [textFont, setTextFont] = createSignal("Helvetica");
    const [textSize, setTextSize] = createSignal("10");
    const [textColor, setTextColor] = createSignal("#000000");
    const [formatNumbers, setFormatNumbers] = createSignal(true);

    const [svgData, setSvgData] = createSignal('');
    const uploadSpreadsheet = async () => {
        try {
            const formData = new FormData();
            const response = await fetch('/api/flow-diagram/svg', {
                method: 'POST',
                body: formData
            });
            const svg = await response.text();
            setSvgData(svg);
        } catch (error) {
            console.error('Error uploading spreadsheet:', error);
        }
    };

    const downloadSVG = () => {
        const svgElement: SVGSVGElement | null = document.querySelector('.figure-container svg');
        if (!svgElement) return;
        
        const svgData = new XMLSerializer().serializeToString(svgElement);
        const blob = new Blob([svgData], { type: 'image/svg+xml' });
        const url = URL.createObjectURL(blob);
        const link = document.createElement('a');
        link.href = url;
        link.download = 'flow_diagram.svg';
        document.body.appendChild(link);
        link.click();
        document.body.removeChild(link);
    };

    const downloadJPG = () => {
        const svgElement: SVGSVGElement | null = document.querySelector('.figure-container svg');
        if (!svgElement) return;

        const svgData = new XMLSerializer().serializeToString(svgElement);

        const canvas = document.createElement('canvas');
        const svgSize = svgElement.getBoundingClientRect();
        canvas.width = svgSize.width;
        canvas.height = svgSize.height;

        const img = new Image();
        img.onload = function () {
            const ctx = canvas.getContext('2d');
            ctx?.drawImage(img, 0, 0);
            const dataURL = canvas.toDataURL('image/jpeg');
            const link = document.createElement('a');
            link.href = dataURL;
            link.download = 'flow_diagram.jpg';
            document.body.appendChild(link);
            link.click();
            document.body.removeChild(link);
        };
        img.src = 'data:image/svg+xml;base64,' + btoa(svgData);
    };

    const downloadPNG = () => {
        const svgElement = document.querySelector('.figure-container svg') as SVGElement | null;
        if (!svgElement) return;

        const svgData = new XMLSerializer().serializeToString(svgElement);

        const canvas = document.createElement('canvas');
        const svgSize = svgElement.getBoundingClientRect();
        canvas.width = svgSize.width;
        canvas.height = svgSize.height;

        const img = new Image();
        img.onload = function () {
            const ctx = canvas.getContext('2d');
            if (!ctx) return;
            ctx.drawImage(img, 0, 0);
            const dataURL = canvas.toDataURL('image/png');
            const link = document.createElement('a');
            link.href = dataURL;
            link.download = 'flow_diagram.png';
            document.body.appendChild(link);
            link.click();
            document.body.removeChild(link);
        };
        img.src = 'data:image/svg+xml;base64,' + btoa(svgData);
    };

    const downloadPDF = () => {
        const svgElement = document.querySelector('.figure-container svg') as SVGElement | null;
        if (!svgElement) return;

        const svgData = new XMLSerializer().serializeToString(svgElement);

        const canvas = document.createElement('canvas');
        const svgSize = svgElement.getBoundingClientRect();
        canvas.width = svgSize.width;
        canvas.height = svgSize.height;

        const img = new Image();
        img.onload = function () {
            const pdf = new jsPDF('p', 'pt', [canvas.width, canvas.height]);
            pdf.addImage(img, 0, 0, canvas.width, canvas.height);
            pdf.save('flow_diagram.pdf');
        };
        img.src = 'data:image/svg+xml;base64,' + btoa(svgData);
    };

    const downloadHTML = () => {
        const svgElement = document.querySelector('.figure-container svg') as SVGElement | null;
        if (!svgElement) return;

        const svgData = new XMLSerializer().serializeToString(svgElement);
        const blob = new Blob([svgData], { type: 'image/svg+xml' });
        const url = URL.createObjectURL(blob);
        const link = document.createElement('a');
        link.href = url;
        link.download = 'flow_diagram.html';
        document.body.appendChild(link);
        link.click();
        document.body.removeChild(link);
    };

    return (
        <>
            <Title>Flow Diagram</Title>
            <main class="flow-diagram">
                <div class="options">
                    <div class="upload-spreadsheet-options">
                        <div>
                            <button onClick={downloadCSV}>Download CSV</button>
                            <button onClick={downloadXLSX}>Download XLSX</button>
                            <input type="file"></input>
                            <button onClick={uploadSpreadsheet}>Upload Spreadsheet</button>
                        </div>
                    </div>
                    <div>
                        <div>
                            <div>
                                <h3>Options</h3>
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
                                <button onClick={downloadSVG}>SVG</button>
                                <button onClick={downloadJPG}>JPG</button>
                                <button onClick={downloadPNG}>PNG</button>
                                <button onClick={downloadPDF}>PDF</button>
                                <button onClick={downloadHTML}>HTML</button>
                        </div>
                    </div>
                </div>
                <div class="figure-container">
                    <svg innerHTML={svgData()}></svg>
                </div>
            </main>
        </>
    );
}

export default FlowDiagram;
