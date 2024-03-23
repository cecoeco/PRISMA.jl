import { createSignal } from "solid-js";
import DownloadModal from "../components/download_modal.jsx";
import "../assets/scss/flow_diagram.scss";

/**
 * Flow diagram component.
 * @function FlowDiagram
 * @returns {JSX.Element} Flow diagram component
 */
function FlowDiagram() {
    const [showDownloadModal, setShowDownloadModal] = createSignal(false);
    function openModal() {
        setShowDownloadModal(true);
    }

    const [previousStudiesIncluded, setPreviousStudiesIncluded] =
        createSignal(true);
    function handlePreviousStudiesToggle(event) {
        const value = event.target.value === "true";
        setPreviousStudiesIncluded(value);
    }

    const [otherMethodsIncluded, setOtherMethodsIncluded] = createSignal(true);
    function handleOtherMethodsToggle(event) {
        const value = event.target.value === "true";
        setOtherMethodsIncluded(value);
    }

    const [grayBoxesIncluded, setGrayBoxesIncluded] = createSignal(true);
    function handleGrayBoxesToggle(event) {
        const value = event.target.value === "true";
        setGrayBoxesIncluded(value);
    }

    const [topBoxesIncluded, setTopBoxesIncluded] = createSignal(true);
    function handleTopBoxesToggle(event) {
        const value = event.target.value === "true";
        setTopBoxesIncluded(value);
    }

    const [sideBoxesIncluded, setSideBoxesIncluded] = createSignal(true);
    function handleSideBoxesToggle(event) {
        const value = event.target.value === "true";
        setSideBoxesIncluded(value);
    }

    const [interactivityIncluded, setInteractivtyIncluded] = createSignal(true);
    function handleInteractivityToggle(event) {
        const value = event.target.value === "true";
        setInteractivtyIncluded(value);
    }

    const [numberOfDatabases, setNumberOfDatabases] = createSignal(3);
    function handleNumberOfDatabasesChange(event) {
        const newValue = parseInt(event.target.value, 10) || 0;
        setNumberOfDatabases(newValue);
    }

    const [numberOfReasons, setNumberOfReasons] = createSignal(3);
    function handleNumberOfReasonsChange(event) {
        const newValue = parseInt(event.target.value, 10) || 0;
        setNumberOfReasons(newValue);
    }

    const [numberOfOtherReasons, setNumberOfOtherReasons] = createSignal(3);
    function handleNumberOfOtherReasonsChange(event) {
        const newValue = parseInt(event.target.value, 10) || 0;
        setNumberOfOtherReasons(newValue);
    }

    function reset() {
        setPreviousStudiesIncluded(true);
        setOtherMethodsIncluded(true);
        setGrayBoxesIncluded(true);
        setTopBoxesIncluded(true);
        setSideBoxesIncluded(true);
        setInteractivtyIncluded(true);
        setNumberOfDatabases(3);
        setNumberOfReasons(3);
        setNumberOfOtherReasons(3);
    }

    return (
        <>
            <DownloadModal
                showDownloadModal={[showDownloadModal, setShowDownloadModal]}
            />
            <div class="flow-diagram">
                <div class="settings">
                    <button
                        name="reset"
                        class="reset-button"
                        onClick={reset}
                        type="button"
                        title="Reset"
                    >
                        Reset
                    </button>
                    <div name="data" id="flow-diagram-data" class="settings-section">
                        <h3>Data</h3>
                        <div>
                            <h4>Identification</h4>
                            {previousStudiesIncluded() && (
                                <>
                                    <div>
                                        <label for="previous-studies">Previous Studies</label>
                                        <input
                                            id="previous-studies"
                                            name="previous-studies"
                                            type="number"
                                            placeholder="0"
                                            min="0"
                                        />
                                    </div>
                                    <div>
                                        <label for="previous-reports">Previous Reports</label>
                                        <input
                                            id="previous-reports"
                                            name="previous-reports"
                                            type="number"
                                            placeholder="0"
                                            min="0"
                                        />
                                    </div>
                                </>
                            )}
                            <div>
                                <label for="number-of-databases">Number of Databases</label>
                                <input
                                    id="number-of-databases"
                                    name="number-of-databases"
                                    type="number"
                                    placeholder="3"
                                    min="0"
                                    value={numberOfDatabases()}
                                    onInput={handleNumberOfDatabasesChange}
                                />
                            </div>
                            {[...Array(numberOfDatabases()).keys()].map((index) => (
                                <div>
                                    <label>{`Database ${index + 1}`}</label>
                                    <input type="text" placeholder={`Database ${index + 1}`} />
                                    <input type="number" placeholder="0" min="0" />
                                </div>
                            ))}
                            <div>
                                <label for="duplicates-removed">Duplicates Removed</label>
                                <input
                                    id="duplicates-removed"
                                    name="duplicates-removed"
                                    type="number"
                                    placeholder="0"
                                    min="0"
                                />
                            </div>
                            <div>
                                <label for="automatically-excluded">
                                    Automatically Excluded
                                </label>
                                <input
                                    id="automatically-excluded"
                                    name="automatically-excluded"
                                    type="number"
                                    placeholder="0"
                                    min="0"
                                />
                            </div>
                            <div>
                                <label for="other-reasons">Other Reasons</label>
                                <input
                                    id="other-reasons"
                                    name="other-reasons"
                                    type="number"
                                    placeholder="0"
                                    min="0"
                                />
                            </div>
                            {otherMethodsIncluded() && (
                                <>
                                    <div>
                                        <label for="websites">Websites</label>
                                        <input
                                            id="websites"
                                            name="websites"
                                            type="number"
                                            placeholder="0"
                                            min="0"
                                        />
                                    </div>
                                    <div>
                                        <label for="organizations">Organizations</label>
                                        <input
                                            id="organizations"
                                            name="organizations"
                                            type="number"
                                            placeholder="0"
                                            min="0"
                                        />
                                    </div>
                                    <div>
                                        <label for="citations">Citations</label>
                                        <input
                                            id="citations"
                                            name="citations"
                                            type="number"
                                            placeholder="0"
                                            min="0"
                                        />
                                    </div>
                                </>
                            )}
                        </div>
                        <div>
                            <h4>Screening</h4>
                            <div>
                                <label for="record-screened">Record Screened</label>
                                <input
                                    id="record-screened"
                                    name="record-screened"
                                    type="number"
                                    placeholder="0"
                                    min="0"
                                />
                            </div>
                            <div>
                                <label for="record-excluded">Record Excluded</label>
                                <input
                                    id="record-excluded"
                                    name="record-excluded"
                                    type="number"
                                    placeholder="0"
                                    min="0"
                                />
                            </div>
                            <div>
                                <label for="reports-sought">Reports Sought</label>
                                <input
                                    id="reports-sought"
                                    name="reports-sought"
                                    type="number"
                                    placeholder="0"
                                    min="0"
                                />
                            </div>
                            <div>
                                <label for="reports-not-retrieved">
                                    Reports Not Retrieved
                                </label>
                                <input
                                    id="reports-not-retrieved"
                                    name="reports-not-retrieved"
                                    type="number"
                                    placeholder="0"
                                    min="0"
                                />
                            </div>
                            <div>
                                <label for="reports-assessed">Reports Assessed</label>
                                <input
                                    id="reports-assessed"
                                    name="reports-assessed"
                                    type="number"
                                    placeholder="0"
                                    min="0"
                                />
                            </div>
                            <div>
                                <label for="number-of-reasons">Number of Reasons</label>
                                <input
                                    id="number-of-reasons"
                                    name="number-of-reasons"
                                    type="number"
                                    placeholder="3"
                                    min="0"
                                    value={numberOfReasons()}
                                    onInput={handleNumberOfReasonsChange}
                                />
                            </div>
                            {[...Array(numberOfReasons()).keys()].map((index) => (
                                <div>
                                    <label>{`Reason ${index + 1}`}</label>
                                    <input
                                        type="text"
                                        placeholder={`Reason ${index + 1}`}
                                    />
                                    <input
                                        type="number"
                                        placeholder="0"
                                        min="0"
                                    />
                                </div>
                            ))}
                            {otherMethodsIncluded() && (
                                <>
                                    <div>
                                        <label for="other-reports-sought">
                                            Other Reports Sought
                                        </label>
                                        <input
                                            id="other-reports-sought"
                                            name="other-reports-sought"
                                            type="number"
                                            placeholder="0"
                                            min="0"
                                        />
                                    </div>
                                    <div>
                                        <label for="other-reports-not-retrieved">
                                            Other Reports Not Retrieved
                                        </label>
                                        <input
                                            id="other-reports-not-retrieved"
                                            name="other-reports-not-retrieved"
                                            type="number"
                                            placeholder="0"
                                            min="0"
                                        />
                                    </div>
                                    <div>
                                        <label for="other-reports-assessed">
                                            Other Reports Assessed
                                        </label>
                                        <input
                                            id="other-reports-assessed"
                                            name="other-reports-assessed"
                                            type="number"
                                            placeholder="0"
                                            min="0"
                                        />
                                    </div>
                                    <div>
                                        <label for="number-of-other-reasons">
                                            Number of Other Reasons
                                        </label>
                                        <input
                                            id="number-of-other-reasons"
                                            name="number-of-other-reasons"
                                            type="number"
                                            placeholder="3"
                                            min="0"
                                            value={numberOfOtherReasons()}
                                            onInput={handleNumberOfOtherReasonsChange}
                                        />
                                    </div>
                                    {[...Array(numberOfOtherReasons()).keys()].map((index) => (
                                        <div>
                                            <label>{`Other Reason ${index + 1}`}</label>
                                            <input
                                                type="text"
                                                placeholder={`Other Reason ${index + 1}`}
                                            />
                                            <input type="number" placeholder="0" min="0" />
                                        </div>
                                    ))}
                                </>
                            )}
                        </div>
                        <div>
                            <h4>Included</h4>
                            <div>
                                <label for="new-studies">New Studies</label>
                                <input
                                    id="new-studies"
                                    name="new-studies"
                                    type="number"
                                    placeholder="0"
                                    min="0"
                                />
                            </div>
                            <div>
                                <label for="new-reports">New Reports</label>
                                <input
                                    id="new-reports"
                                    name="new-reports"
                                    type="number"
                                    placeholder="0"
                                    min="0"
                                />
                            </div>
                            {previousStudiesIncluded() && (
                                <>
                                    <div>
                                        <label for="total-studies">Total Studies</label>
                                        <input
                                            id="total-studies"
                                            name="total-studies"
                                            type="number"
                                            placeholder="0"
                                            min="0"
                                        />
                                    </div>
                                    <div>
                                        <label for="total-reports">Total Reports</label>
                                        <input
                                            id="total-reports"
                                            name="total-reports"
                                            type="number"
                                            placeholder="0"
                                            min="0"
                                        />
                                    </div>
                                </>
                            )}
                        </div>
                    </div>
                    {interactivityIncluded() && (
                        <div name="urls" id="flow-diagram-urls" class="settings-section">
                            <h3>URLs</h3>
                            {topBoxesIncluded() && (
                                <div>
                                    <h4>Top Boxes</h4>
                                    <div>
                                        <label for="previous-studies-topbox-url">
                                            Previous Studies
                                        </label>
                                        <input
                                            id="previous-studies-topbox-url"
                                            name="previous-studies-topbox-url"
                                            type="text"
                                            placeholder="#previous_studies"
                                        />
                                    </div>
                                    <div>
                                        <label for="new-studies-topbox-url">
                                            New Studies
                                        </label>
                                        <input
                                            id="new-studies-topbox-url"
                                            name="new-studies-topbox-url"
                                            type="text"
                                            placeholder="#new_studies"
                                        />
                                    </div>
                                    <div>
                                        <label for="other-methods-url">Other Methods</label>
                                        <input
                                            id="other-methods-url"
                                            name="other-methods-url"
                                            type="text"
                                            placeholder="#other_methods"
                                        />
                                    </div>
                                </div>
                            )}
                            {sideBoxesIncluded() && (
                                <div>
                                    <h4>Side Boxes</h4>
                                    <div>
                                        <label for="identification-url">
                                            Identification
                                        </label>
                                        <input
                                            id="identification-url"
                                            name="identification-url"
                                            type="text"
                                            placeholder="#identification"
                                        />
                                    </div>
                                    <div>
                                        <label for="screening-url">Screening</label>
                                        <input
                                            id="screening-url"
                                            name="screening-url"
                                            type="text"
                                            placeholder="#screening"
                                        />
                                    </div>
                                    <div>
                                        <label for="included-url">Included</label>
                                        <input
                                            id="included-url"
                                            name="included-url"
                                            type="text"
                                            placeholder="#included"
                                        />
                                    </div>
                                </div>
                            )}
                            <div>
                                <h4>Identification</h4>
                                {previousStudiesIncluded() && (
                                    <>
                                        <div>
                                            <label for="previous-studies-url">
                                                Previous Studies
                                            </label>
                                            <input
                                                id="previous-studies-url"
                                                name="previous-studies-url"
                                                type="text"
                                                placeholder="#previous_studies"
                                            />
                                        </div>
                                        <div>
                                            <label for="previous-reports-url">
                                                Previous Reports
                                            </label>
                                            <input
                                                id="previous-reports-url"
                                                name="previous-reports-url"
                                                type="text"
                                                placeholder="#previous_reports"
                                            />
                                        </div>
                                    </>
                                )}
                                {[...Array(numberOfDatabases()).keys()].map((index) => (
                                    <div>
                                        <label>{`Database ${index + 1}`}</label>
                                        <input
                                            type="text"
                                            placeholder={`#database_${index + 1}`}
                                        />
                                    </div>
                                ))}
                                <div>
                                    <label for="duplicates-removed-url">
                                        Duplicates Removed
                                    </label>
                                    <input
                                        id="duplicates-removed-url"
                                        name="duplicates-removed-url"
                                        type="text"
                                        placeholder="#duplicates_removed"
                                    />
                                </div>
                                <div>
                                    <label for="automatically-excluded-url">
                                        Automatically Excluded
                                    </label>
                                    <input
                                        id="automatically-excluded-url"
                                        name="automatically-excluded-url"
                                        type="text"
                                        placeholder="#automatically_excluded"
                                    />
                                </div>
                                <div>
                                    <label for="other-reasons-url">Other Reasons</label>
                                    <input
                                        id="other-reasons-url"
                                        name="other-reasons-url"
                                        type="text"
                                        placeholder="#other_reasons"
                                    />
                                </div>
                                {otherMethodsIncluded() && (
                                    <>
                                        <div>
                                            <label for="websites-url">Websites</label>
                                            <input
                                                id="websites-url"
                                                name="websites-url"
                                                type="text"
                                                placeholder="#websites"
                                            />
                                        </div>
                                        <div>
                                            <label for="organizations-url">
                                                Organizations
                                            </label>
                                            <input
                                                id="organizations-url"
                                                name="organizations-url"
                                                type="text"
                                                placeholder="#organizations"
                                            />
                                        </div>
                                        <div>
                                            <label for="citations-url">Citations</label>
                                            <input
                                                id="citations-url"
                                                name="citations-url"
                                                type="text"
                                                placeholder="#citations"
                                            />
                                        </div>
                                    </>
                                )}
                            </div>
                            <div>
                                <h4>Screening</h4>
                                <div>
                                    <label for="record-screened-url">
                                        Record Screened
                                    </label>
                                    <input
                                        id="record-screened-url"
                                        name="record-screened-url"
                                        type="text"
                                        placeholder="#record_screened"
                                    />
                                </div>
                                <div>
                                    <label for="record-excluded-url">
                                        Record Excluded
                                    </label>
                                    <input
                                        id="record-excluded-url"
                                        name="record-excluded-url"
                                        type="text"
                                        placeholder="#record_excluded"
                                    />
                                </div>
                                <div>
                                    <label for="reports-sought-url">Reports Sought</label>
                                    <input
                                        id="reports-sought-url"
                                        name="reports-sought-url"
                                        type="text"
                                        placeholder="0"
                                        min="0"
                                    />
                                </div>
                                <div>
                                    <label for="reports-not-retrieved-url">
                                        Reports Not Retrieved
                                    </label>
                                    <input
                                        id="reports-not-retrieved-url"
                                        name="reports-not-retrieved-url"
                                        type="text"
                                        placeholder="#reports_not_retrieved"
                                    />
                                </div>
                                <div>
                                    <label for="reports-assessed-url">
                                        Reports Assessed
                                    </label>
                                    <input
                                        id="reports-assessed-url"
                                        name="reports-assessed-url"
                                        type="text"
                                        placeholder="#reports_assessed"
                                    />
                                </div>
                                {[...Array(numberOfReasons()).keys()].map((index) => (
                                    <div>
                                        <label>{`Reason ${index + 1}`}</label>
                                        <input type="text" placeholder={`#reason_${index + 1}`} />
                                    </div>
                                ))}
                                {otherMethodsIncluded() && (
                                    <>
                                        <div>
                                            <label for="other-reports-sought-url">
                                                Other Reports Sought
                                            </label>
                                            <input
                                                id="other-reports-sought-url"
                                                name="other-reports-sought-url"
                                                type="text"
                                                placeholder="#other_reports_sought"
                                            />
                                        </div>
                                        <div>
                                            <label for="other-reports-not-retrieved-url">
                                                Other Reports Not Retrieved
                                            </label>
                                            <input
                                                id="other-reports-not-retrieved-url"
                                                name="other-reports-not-retrieved-url"
                                                type="text"
                                                placeholder="#other_reports_not_retrieved"
                                            />
                                        </div>
                                        <div>
                                            <label for="other-reports-assessed-url">
                                                Other Reports Assessed
                                            </label>
                                            <input
                                                id="other-reports-assessed-url"
                                                name="other-reports-assessed-url"
                                                type="text"
                                                placeholder="#other_reports_assessed"
                                            />
                                        </div>
                                        {[...Array(numberOfOtherReasons()).keys()].map(
                                            (index) => (
                                                <div>
                                                    <label>{`Other Reason ${index + 1}`}</label>
                                                    <input
                                                        type="text"
                                                        placeholder={`#other_reason_${index + 1}`}
                                                    />
                                                </div>
                                            )
                                        )}
                                    </>
                                )}
                            </div>
                            <div>
                                <h4>Included</h4>
                                <div>
                                    <label for="new-studies-url">New Studies</label>
                                    <input
                                        id="new-studies-url"
                                        name="new-studies-url"
                                        type="text"
                                        placeholder="#new_studies"
                                    />
                                </div>
                                <div>
                                    <label for="new-reports-url">New Reports</label>
                                    <input
                                        id="new-reports-url"
                                        name="new-reports-url"
                                        type="text"
                                        placeholder="#new_reports"
                                    />
                                </div>
                                {previousStudiesIncluded() && (
                                    <>
                                        <div>
                                            <label for="total-studies-url">
                                                Total Studies
                                            </label>
                                            <input
                                                id="total-studies-url"
                                                name="total-studies-url"
                                                type="text"
                                                placeholder="#total_studies"
                                            />
                                        </div>
                                        <div>
                                            <label for="total-reports-url">
                                                Total Reports
                                            </label>
                                            <input
                                                id="total-reports-url"
                                                name="total-reports-url"
                                                type="text"
                                                placeholder="#total_reports"
                                            />
                                        </div>
                                    </>
                                )}
                            </div>
                        </div>
                    )}
                    <div name="visual" id="flow-diagram-visual" class="settings-section">
                        <h3>Visual</h3>
                        <div>
                            <h4>Interactivity</h4>
                            <div>
                                <label for="interactive">Interactive</label>
                                <select
                                    id="interactive"
                                    name="interactive"
                                    onChange={handleInteractivityToggle}
                                >
                                    <option value="true">True</option>
                                    <option value="false">False</option>
                                </select>
                            </div>
                            <h4>Background</h4>
                            <div>
                                <label for="background-color">Background Color</label>
                                <input
                                    id="background-color"
                                    name="background-color"
                                    type="color"
                                    value="#ffffff"
                                />
                            </div>
                        </div>
                        <div>
                            <h4>Boxes</h4>
                            <div>
                                <label for="previous-studies-included">
                                    Previous Studies
                                </label>
                                <select
                                    id="previous-studies-included"
                                    name="previous-studies-included"
                                    onChange={handlePreviousStudiesToggle}
                                >
                                    <option value="true">True</option>
                                    <option value="false">False</option>
                                </select>
                            </div>
                            <div>
                                <label for="other-methods-included">Other Methods</label>
                                <select
                                    id="other-methods-included"
                                    name="other-methods-included"
                                    onChange={handleOtherMethodsToggle}
                                >
                                    <option value="true">True</option>
                                    <option value="false">False</option>
                                </select>
                            </div>
                            <div>
                                <label for="gray-boxes">Gray Boxes</label>
                                <select
                                    id="gray-boxes"
                                    name="gray-boxes"
                                    onChange={handleGrayBoxesToggle}
                                >
                                    <option value="true">True</option>
                                    <option value="false">False</option>
                                </select>
                            </div>
                            {grayBoxesIncluded() && (
                                <div>
                                    <label for="gray-boxes-color">Gray Boxes Color</label>
                                    <input
                                        id="gray-boxes-color"
                                        name="gray-boxes-color"
                                        type="color"
                                        value="#f0f0f0"
                                    />
                                </div>
                            )}
                            <div>
                                <label for="top-boxes">Top Boxes</label>
                                <select
                                    id="top-boxes"
                                    name="top-boxes"
                                    onChange={handleTopBoxesToggle}
                                >
                                    <option value="true">True</option>
                                    <option value="false">False</option>
                                </select>
                            </div>
                            {topBoxesIncluded() && (
                                <>
                                    <div>
                                        <label for="top-boxes-border">Top Boxes Border</label>
                                        <select id="top-boxes-border" name="top-boxes-border">
                                            <option value="true">True</option>
                                            <option value="false">False</option>
                                        </select>
                                    </div>
                                    <div>
                                        <label for="top-boxes-color">Top Boxes Color</label>
                                        <input
                                            id="top-boxes-color"
                                            name="top-boxes-color"
                                            type="color"
                                            value="#ffc000"
                                        />
                                    </div>
                                </>
                            )}
                            <div>
                                <label for="side-boxes">Side Boxes</label>
                                <select
                                    id="side-boxes"
                                    name="side-boxes"
                                    onChange={handleSideBoxesToggle}
                                >
                                    <option value="true">True</option>
                                    <option value="false">False</option>
                                </select>
                            </div>
                            {sideBoxesIncluded() && (
                                <>
                                    <div>
                                        <label for="side-boxes-border">Side Boxes Border</label>
                                        <select id="side-boxes-border" name="Side Boxes Border">
                                            <option value="true">True</option>
                                            <option value="false">False</option>
                                        </select>
                                    </div>
                                    <div>
                                        <label for="side-boxes-color">Side Boxes Color</label>
                                        <input
                                            id="side-boxes-color"
                                            name="side-boxes-color"
                                            type="color"
                                            value="#95cbff"
                                        />
                                    </div>
                                </>
                            )}
                            <div>
                                <label for="border-width">Border Width</label>
                                <input
                                    id="border-width"
                                    name="border-width"
                                    type="number"
                                    placeholder="0"
                                    min="0"
                                />
                            </div>
                            <div>
                                <label for="border-color">Border Color</label>
                                <input
                                    id="border-color"
                                    name="border-color"
                                    type="color"
                                    value="#000000"
                                />
                            </div>
                        </div>
                        <div>
                            <h4>Arrows</h4>
                            <div>
                                <label for="arrow-head">Arrow Head</label>
                                <select id="arrow-head" name="arrow-head">
                                    <option value="true">True</option>
                                    <option value="false">False</option>
                                </select>
                            </div>
                            <div>
                                <label for="arrow-head-size">Arrow Head Size</label>
                                <input
                                    id="arrow-head-size"
                                    name="arrow-head-size"
                                    type="number"
                                    placeholder="0"
                                    min="0"
                                />
                            </div>
                            <div>
                                <label for="arrow-width">Arrow Width</label>
                                <input
                                    id="arrow-width"
                                    name="arrow-width"
                                    type="number"
                                    placeholder="0"
                                    min="0"
                                />
                            </div>
                            <div>
                                <label for="arrow-color">Arrow Color</label>
                                <input
                                    id="arrow-color"
                                    name="arrow-color"
                                    type="color"
                                    value="#000000"
                                />
                            </div>
                        </div>
                        <div>
                            <h4>Text</h4>
                            <div>
                                <label for="text-font">Text Font</label>
                                <select id="text-font" name="text-font">
                                    <option value="Arial">Arial</option>
                                    <option value="Avenir">Avenir</option>
                                    <option value="Baskerville">Baskerville</option>
                                    <option value="Calibri">Calibri</option>
                                    <option value="Cambria">Cambria</option>
                                    <option value="Garamond">Garamond</option>
                                    <option value="Georgia">Georgia</option>
                                    <option value="Futura">Futura</option>
                                    <option value="Helvetica">Helvetica</option>
                                    <option value="Inter">Inter</option>
                                    <option value="Times New Roman">Times New Roman</option>
                                </select>
                            </div>
                            <div>
                                <label for="text-size">Text Size</label>
                                <input
                                    id="text-size"
                                    name="text-size"
                                    type="number"
                                    placeholder="0"
                                    min="0"
                                />
                            </div>
                            <div>
                                <label for="text-color">Text Color</label>
                                <input
                                    id="text-color"
                                    name="text-color"
                                    value="#000000"
                                    type="color"
                                />
                            </div>
                            <div>
                                <label for="text-weight">Text Weight</label>
                                <select id="text-weight" name="text-weight">
                                    <option value="normal">Normal</option>
                                    <option value="bold">Bold</option>
                                </select>
                            </div>
                            <div>
                                <label for="format-numbers">Format Numbers</label>
                                <select id="format-numbers" name="format-numbers">
                                    <option value="true">True</option>
                                    <option value="false">False</option>
                                </select>
                            </div>
                        </div>
                    </div>
                    <button
                        name="download"
                        onClick={openModal}
                        class="download-button"
                        type="button"
                        title="Download Flow Diagram"
                    >
                        Download
                    </button>
                </div>
                <div class="figure-container"></div>
            </div>
        </>
    );
}

export default FlowDiagram;
