import { createSignal, createEffect } from "solid-js";

import "../assets/css/flow_diagram.css";

import Download from "../assets/svgs/download.svg?component-solid";
import Reset from "../assets/svgs/reset.svg?component-solid";

const initialData = {
  numberOfPreviousStudies: 0,
  numberOfPreviousReports: 0,
  numberOfDatabases: 3,
  numberOfDuplicatesRemoved: 0,
  numberOfAutomaticallyExcluded: 0,
  numberOfRemovedForOtherReasons: 0,
  numberOfWebsites: 0,
  numberOfOrganizations: 0,
  numberOfCitations: 0,
  numberOfOtherSources: 0,
  numberOfRecordsScreened: 0,
  numberOfRecordsExcluded: 0,
  numberOfReportsSought: 0,
  numberOfReportsNotRetrieved: 0,
  numberOfReportsAssessed: 0,
  numberOfReasons: 3,
  numberOfOtherReportsSought: 0,
  numberOfOtherReportsNotRetrieved: 0,
  numberOfOtherReportsAssessed: 0,
  numberOfOtherReasons: 3,
  newStudies: 0,
  newReports: 0,
  totalStudies: 0,
  totalReports: 0,
};

const initialVisual = {
  backgroundColor: "#ffffff",
  previousStudiesIncluded: "true",
  otherMethodsIncluded: "true",
  grayBoxesIncluded: "true",
  grayBoxesColor: "#f0f0f0",
  topBoxesIncluded: "true",
  topBoxesBorders: "false",
  topBoxesColor: "#ffc000",
  sideBoxesIncluded: "true",
  sideBoxesBorders: "false",
  sideBoxesColor: "#95cbff",
  borders: "true",
  borderStyle: "solid",
  borderWidth: 2,
  borderColor: "#000000",
  font: "Arial",
  fontColor: "#000000",
  fontSize: 12,
  arrowHead: "normal",
  arrowSize: 5,
  arrowColor: "#000000",
  arrowWidth: 2,
};

export default function FlowDiagram() {
  const [state, setState] = createSignal({
    data: { ...initialData },
    visual: { ...initialVisual },
    databases: Array.from({ length: initialData.numberOfDatabases }).map(() => ({
      name: "",
      value: 0,
    })),
    reasons: Array.from({ length: initialData.numberOfReasons }).map(() => ({
      name: "",
      value: 0,
    })),
    otherReasons: Array.from({ length: initialData.numberOfOtherReasons }).map(() => ({
      name: "",
      value: 0,
    })),
  });

  const handleChange = (
    field: string,
    value: any,
    category: "data" | "visual" | "databases" | "reasons" | "otherReasons"
  ) => {
    if (field === "numberOfDatabases") {
      setState((prev) => ({
        ...prev,
        [category]: { ...prev[category], [field]: value },
        databases: Array.from({ length: value }).map(() => ({
          name: "",
          value: 0,
        })),
      }));
    } else if (field === "numberOfReasons") {
      setState((prev) => ({
        ...prev,
        [category]: { ...prev[category], [field]: value },
        reasons: Array.from({ length: value }).map(() => ({
          name: "",
          value: 0,
        })),
      }));
    } else if (field === "numberOfOtherReasons") {
      setState((prev) => ({
        ...prev,
        [category]: { ...prev[category], [field]: value },
        otherReasons: Array.from({ length: value }).map(() => ({
          name: "",
          value: 0,
        })),
      }));
    } else {
      setState((prev) => ({
        ...prev,
        [category]: { ...prev[category], [field]: value },
      }));
    }
  };

  const handleItemChange = (
    index: number,
    key: string,
    value: any,
    category: "databases" | "reasons" | "otherReasons"
  ) => {
    setState((prev) => ({
      ...prev,
      [category]: prev[category].map((item, i) =>
        i === index ? { ...item, [key]: value } : item
      ),
    }));
  };

  function flowDiagramData() {
    const boxes = [
      {
        box_num: 1,
        box_lab: "Previous studies",
        results: null,
      },
      {
        box_num: 2,
        box_lab: "Identification of new studies via databases and registers",
        results: null,
      },
      {
        box_num: 3,
        box_lab: "Identification of new studies via other methods",
        results: null,
      },
      {
        box_num: 4,
        box_lab: "Identification",
        results: null,
      },
      {
        box_num: 5,
        box_lab: "Screening",
        results: null,
      },
      {
        box_num: 6,
        box_lab: "Included",
        results: null,
      },
      {
        box_num: 7,
        box_lab: "Studies included in previous version of review",
        results: state().data.numberOfPreviousStudies,
      },
      {
        box_num: 7,
        box_lab: "Reports of studies included in previous version of review",
        results: state().data.numberOfPreviousReports,
      },
      {
        box_num: 8,
        box_lab: "Records identified from:",
        results: null,
      },
    ];

    state().databases.forEach((database) => {
      boxes.push({
        box_num: 8,
        box_lab: database.name,
        results: database.value,
      });
    });

    boxes.push(
      {
        box_num: 9,
        box_lab: "Records removed before screening:",
        results: null,
      },
      {
        box_num: 9,
        box_lab: "Duplicate records removed",
        results: state().data.numberOfDuplicatesRemoved,
      },
      {
        box_num: 9,
        box_lab: "Records marked as ineligible by automation tools",
        results: state().data.numberOfAutomaticallyExcluded,
      },
      {
        box_num: 9,
        box_lab: "Records removed for other reasons",
        results: state().data.numberOfRemovedForOtherReasons,
      },
      {
        box_num: 10,
        box_lab: "Records screened",
        results: state().data.numberOfRecordsScreened,
      },
      {
        box_num: 11,
        box_lab: "Records excluded",
        results: state().data.numberOfRecordsExcluded,
      },
      {
        box_num: 12,
        box_lab: "Reports sought for retrieval",
        results: state().data.numberOfReportsSought,
      },
      {
        box_num: 13,
        box_lab: "Reports not retrieved",
        results: state().data.numberOfReportsNotRetrieved,
      },
      {
        box_num: 14,
        box_lab: "Reports assessed for eligibility",
        results: state().data.numberOfReportsAssessed,
      },
      {
        box_num: 15,
        box_lab: "Reports excluded:",
        results: null,
      }
    );

    state().reasons.forEach((reason) => {
      boxes.push({
        box_num: 15,
        box_lab: reason.name,
        results: reason.value,
      });
    });

    boxes.push(
      {
        box_num: 16,
        box_lab: "New studies included in review",
        results: state().data.newStudies,
      },
      {
        box_num: 16,
        box_lab: "Reports of new included studies",
        results: state().data.newReports,
      },
      {
        box_num: 17,
        box_lab: "Total studies included in review",
        results: state().data.totalStudies,
      },
      {
        box_num: 17,
        box_lab: "Reports of total included studies",
        results: state().data.totalReports,
      },
      {
        box_num: 18,
        box_lab: "Records identified from:",
        results: null,
      },
      {
        box_num: 18,
        box_lab: "Websites",
        results: state().data.numberOfWebsites,
      },
      {
        box_num: 18,
        box_lab: "Organizations",
        results: state().data.numberOfOrganizations,
      },
      {
        box_num: 18,
        box_lab: "Citation searching",
        results: state().data.numberOfCitations,
      },
      {
        box_num: 18,
        box_lab: "Other",
        results: state().data.numberOfOtherSources,
      },
      {
        box_num: 19,
        box_lab: "Reports sought for retrieval",
        results: state().data.numberOfReportsSought,
      },
      {
        box_num: 20,
        box_lab: "Reports not retrieved",
        results: state().data.numberOfReportsNotRetrieved,
      },
      {
        box_num: 21,
        box_lab: "Reports assessed for eligibility",
        results: state().data.numberOfReportsAssessed,
      },
      {
        box_num: 22,
        box_lab: "Reports excluded:",
        results: null,
      }
    );

    state().otherReasons.forEach((reason) => {
      boxes.push({
        box_num: 22,
        box_lab: reason.name,
        results: reason.value,
      });
    });

    return boxes;
  }

  async function getFlowDiagram() {
    try {
      const response = await fetch("http://127.0.0.1:8000/flow_diagram", {
        method: "POST",
        headers: { "Content-Type": "application/json" },
        body: JSON.stringify({
          data: flowDiagramData(),
          background_color: state().visual.backgroundColor,
          grayboxes: state().visual.grayBoxesIncluded == "true",
          grayboxes_color: state().visual.grayBoxesColor,
          top_boxes: state().visual.topBoxesIncluded == "true",
          top_boxes_borders: state().visual.topBoxesBorders == "true",
          top_boxes_color: state().visual.topBoxesColor,
          side_boxes: state().visual.sideBoxesIncluded == "true",
          side_boxes_borders: state().visual.sideBoxesBorders == "true",
          side_boxes_color: state().visual.sideBoxesColor,
          previous_studies: state().visual.previousStudiesIncluded == "true",
          other_methods: state().visual.otherMethodsIncluded == "true",
          borders: state().visual.borders == "true",
          border_style: state().visual.borderStyle,
          border_width: state().visual.borderWidth,
          border_color: state().visual.borderColor,
          font: state().visual.font,
          font_color: state().visual.fontColor,
          font_size: state().visual.fontSize,
          arrow_head: state().visual.arrowHead,
          arrow_size: state().visual.arrowSize,
          arrow_color: state().visual.arrowColor,
          arrow_width: state().visual.arrowWidth,
        }),
      });
      const svgResponse = await response.json();
      const container = document.querySelector(".figure-container");
      if (container) {
        container.innerHTML = svgResponse;
      } else {
        console.error("Container element not found");
      }
    } catch (error) {
      console.error("Error fetching data:", error);
    }
  }

  createEffect(() => {
    getFlowDiagram();
  });

  const exportFlowDiagram = () => {
    const svg = document.querySelector(".figure-container svg");
    if (svg) {
      const svgData = new XMLSerializer().serializeToString(svg);
      const blob = new Blob([svgData], { type: "image/svg+xml" });
      const url = window.URL.createObjectURL(blob);
      const a = document.createElement("a");
      a.href = url;
      a.download = "flow_diagram.svg";
      document.body.appendChild(a);
      a.click();
    }
  };

  const resetFlowDiagramOptions = () => {
    setState({
      data: { ...initialData },
      visual: { ...initialVisual },
      databases: Array.from({ length: initialData.numberOfDatabases }).map(() => ({
        name: "",
        value: 0,
      })),
      reasons: Array.from({ length: initialData.numberOfReasons }).map(() => ({
        name: "",
        value: 0,
      })),
      otherReasons: Array.from({
        length: initialData.numberOfOtherReasons,
      }).map(() => ({
        name: "",
        value: 0,
      })),
    });
  };

  return (
    <main class="flow-diagram-page">
      <div class="settings-container">
        <div class="settings">
          <h2 class="settings-title">Flow Diagram</h2>
          <div class="settings-form">
            {state().visual.previousStudiesIncluded && (
              <>
                {/* Previous Studies */}
                <div class="settings-form-group">
                  <h4 class="settings-form-heading">
                    <label for="previous-studies">Previous Studies</label>
                  </h4>
                  <input
                    id="previous-studies"
                    name="previous-studies"
                    type="number"
                    placeholder="0"
                    min="0"
                    value={state().data.numberOfPreviousStudies}
                    onInput={(event) =>
                      handleChange("numberOfPreviousStudies", event.target.value, "data")
                    }
                  />
                </div>
                {/* Previous Reports */}
                <div class="settings-form-group">
                  <h4 class="settings-form-heading">
                    <label for="previous-reports">Previous Reports</label>
                  </h4>

                  <input
                    id="previous-reports"
                    name="previous-reports"
                    type="number"
                    placeholder="0"
                    min="0"
                    value={state().data.numberOfPreviousReports}
                    onInput={(event) =>
                      handleChange("numberOfPreviousReports", event.target.value, "data")
                    }
                  />
                </div>
              </>
            )}
            {/* Number of Databases */}
            <div class="settings-form-group">
              <h4 class="settings-form-heading">
                <label for="number-of-databases">Databases</label>
              </h4>
              <input
                id="number-of-databases"
                name="number-of-databases"
                type="number"
                placeholder="3"
                min="0"
                value={state().data.numberOfDatabases}
                onInput={(event) =>
                  handleChange("numberOfDatabases", event.target.value, "data")
                }
              />
            </div>
            {state().databases.map((database, index) => (
              <span class="settings-form-database-group">
                <div class="settings-form-group">
                  <label for={`database-${index + 1}`}>{`Database ${index + 1}`}</label>
                  <input
                    id={`database-${index + 1}`}
                    type="text"
                    placeholder={`Database ${index + 1}`}
                    value={database.name}
                    onInput={(event) =>
                      handleItemChange(index, "name", event.target.value, "databases")
                    }
                  />
                </div>
                <div class="settings-form-group">
                  <label for={`database-number-${index + 1}`}>Number</label>
                  <input
                    id={`database-number-${index + 1}`}
                    type="number"
                    placeholder="0"
                    min="0"
                    value={database.value}
                    onInput={(event) =>
                      handleItemChange(index, "value", event.target.value, "databases")
                    }
                  />
                </div>
              </span>
            ))}
            {/* Number of Duplicates Removed */}
            <div class="settings-form-group">
              <h4 class="settings-form-heading">
                <label for="duplicates-removed">Duplicates Removed</label>
              </h4>
              <input
                id="duplicates-removed"
                name="duplicates-removed"
                type="number"
                placeholder="0"
                min="0"
                value={state().data.numberOfDuplicatesRemoved}
                onInput={(event) => {
                  handleChange("numberOfDuplicatesRemoved", event.target.value, "data");
                }}
              />
            </div>
            {/* Number of Automatically Excluded */}
            <div class="settings-form-group">
              <h4 class="settings-form-heading">
                <label for="automatically-excluded">Automatically Excluded</label>
              </h4>
              <input
                id="automatically-excluded"
                name="automatically-excluded"
                type="number"
                placeholder="0"
                min="0"
                value={state().data.numberOfAutomaticallyExcluded}
                onInput={(event) => {
                  handleChange(
                    "numberOfAutomaticallyExcluded",
                    event.target.value,
                    "data"
                  );
                }}
              />
            </div>
            {/* Number of Removed For Other Reasons */}
            <div class="settings-form-group">
              <h4 class="settings-form-heading">
                <label for="removed-for-other-reasons">Removed For Other Reasons</label>
              </h4>
              <input
                id="removed-for-other-reasons"
                name="removed-for-other-reasons"
                type="number"
                placeholder="0"
                min="0"
                value={state().data.numberOfRemovedForOtherReasons}
                onInput={(event) => {
                  handleChange(
                    "numberOfRemovedForOtherReasons",
                    event.target.value,
                    "data"
                  );
                }}
              />
            </div>
            {state().visual.otherMethodsIncluded && (
              <>
                {/* Websites */}
                <div class="settings-form-group">
                  <h4 class="settings-form-heading">
                    <label for="websites">Websites</label>
                  </h4>
                  <input
                    id="websites"
                    name="websites"
                    type="number"
                    placeholder="0"
                    min="0"
                    value={state().data.numberOfWebsites}
                    onInput={(event) => {
                      handleChange("numberOfWebsites", event.target.value, "data");
                    }}
                  />
                </div>
                {/* Organizations */}
                <div class="settings-form-group">
                  <h4 class="settings-form-heading">
                    <label for="organizations">Organizations</label>
                  </h4>
                  <input
                    id="organizations"
                    name="organizations"
                    type="number"
                    placeholder="0"
                    min="0"
                    value={state().data.numberOfOrganizations}
                    onInput={(event) => {
                      handleChange("numberOfOrganizations", event.target.value, "data");
                    }}
                  />
                </div>
                {/* Citations */}
                <div class="settings-form-group">
                  <h4 class="settings-form-heading">
                    <label for="citations">Citations</label>
                  </h4>
                  <input
                    id="citations"
                    name="citations"
                    type="number"
                    placeholder="0"
                    min="0"
                    value={state().data.numberOfCitations}
                    onInput={(event) => {
                      handleChange("numberOfCitations", event.target.value, "data");
                    }}
                  />
                </div>
                {/* Other Sources */}
                <div class="settings-form-group">
                  <h4 class="settings-form-heading">
                    <label for="other-sources">Other Sources</label>
                  </h4>
                  <input
                    id="other-sources"
                    name="other-sources"
                    type="number"
                    placeholder="0"
                    min="0"
                    value={state().data.numberOfOtherSources}
                    onInput={(event) => {
                      handleChange("numberOfOtherSources", event.target.value, "data");
                    }}
                  />
                </div>
              </>
            )}
            {/* Records Screened */}
            <div class="settings-form-group">
              <h4 class="settings-form-heading">
                <label for="records-screened">Records Screened</label>
              </h4>
              <input
                id="records-screened"
                name="records-screened"
                type="number"
                placeholder="0"
                min="0"
                value={state().data.numberOfRecordsScreened}
                onInput={(event) => {
                  handleChange("numberOfRecordsScreened", event.target.value, "data");
                }}
              />
            </div>
            {/* Records Excluded */}
            <div class="settings-form-group">
              <h4 class="settings-form-heading">
                <label for="records-excluded">Records Excluded</label>
              </h4>
              <input
                id="records-excluded"
                name="records-excluded"
                type="number"
                placeholder="0"
                min="0"
                value={state().data.numberOfRecordsExcluded}
                onInput={(event) => {
                  handleChange("numberOfRecordsExcluded", event.target.value, "data");
                }}
              />
            </div>
            {/* Reports Sought */}
            <div class="settings-form-group">
              <h4 class="settings-form-heading">
                <label for="reports-sought">Reports Sought</label>
              </h4>
              <input
                id="reports-sought"
                name="reports-sought"
                type="number"
                placeholder="0"
                min="0"
                value={state().data.numberOfReportsSought}
                onInput={(event) => {
                  handleChange("numberOfReportsSought", event.target.value, "data");
                }}
              />
            </div>
            {/* Reports Not Retrieved */}
            <div class="settings-form-group">
              <h4 class="settings-form-heading">
                <label for="reports-not-retrieved">Reports Not Retrieved</label>
              </h4>
              <input
                id="reports-not-retrieved"
                name="reports-not-retrieved"
                type="number"
                placeholder="0"
                min="0"
                value={state().data.numberOfReportsNotRetrieved}
                onInput={(event) => {
                  handleChange("numberOfReportsNotRetrieved", event.target.value, "data");
                }}
              />
            </div>
            {/* Reports Assessed */}
            <div class="settings-form-group">
              <h4 class="settings-form-heading">
                <label for="reports-assessed">Reports Assessed</label>
              </h4>
              <input
                id="reports-assessed"
                name="reports-assessed"
                type="number"
                placeholder="0"
                min="0"
                value={state().data.numberOfReportsAssessed}
                onInput={(event) => {
                  handleChange("numberOfReportsAssessed", event.target.value, "data");
                }}
              />
            </div>
            {/* Reasons */}
            <div class="settings-form-group">
              <h4 class="settings-form-heading">
                <label for="number-of-reasons">Reasons</label>
              </h4>
              <input
                id="number-of-reasons"
                name="number-of-reasons"
                type="number"
                placeholder="3"
                min="0"
                value={state().data.numberOfReasons}
                onInput={(event) => {
                  handleChange("numberOfReasons", event.target.value, "data");
                }}
              />
            </div>
            {state().reasons.map((reason, index) => (
              <span class="settings-form-reason-group">
                <div class="settings-form-group">
                  <label for={`reason-${index + 1}`}>{`Reason ${index + 1}`}</label>
                  <input
                    id={`reason-${index + 1}`}
                    type="text"
                    placeholder={`Reason ${index + 1}`}
                    value={reason.name}
                    onInput={(event) =>
                      handleItemChange(index, "name", event.target.value, "reasons")
                    }
                  />
                </div>
                <div class="settings-form-group">
                  <label for={`reason-number-${index + 1}`}>Number</label>
                  <input
                    id={`reason-number-${index + 1}`}
                    type="number"
                    placeholder="0"
                    min="0"
                    value={reason.value}
                    onInput={(event) =>
                      handleItemChange(index, "value", event.target.value, "reasons")
                    }
                  />
                </div>
              </span>
            ))}
            {state().visual.otherMethodsIncluded && (
              <>
                <div class="settings-form-group">
                  <h4 class="settings-form-heading">
                    <label for="other-reports-sought">Other Reports Sought</label>
                  </h4>
                  <input
                    id="other-reports-sought"
                    name="other-reports-sought"
                    type="number"
                    placeholder="0"
                    min="0"
                    value={state().data.numberOfOtherReportsSought}
                    onInput={(event) => {
                      handleChange(
                        "numberOfOtherReportsSought",
                        event.target.value,
                        "data"
                      );
                    }}
                  />
                </div>
                <div class="settings-form-group">
                  <h4 class="settings-form-heading">
                    <label for="other-reports-not-retrieved">
                      Other Reports Not Retrieved
                    </label>
                  </h4>
                  <input
                    id="other-reports-not-retrieved"
                    name="other-reports-not-retrieved"
                    type="number"
                    placeholder="0"
                    min="0"
                    value={state().data.numberOfOtherReportsNotRetrieved}
                    onInput={(event) => {
                      handleChange(
                        "numberOfOtherReportsNotRetrieved",
                        event.target.value,
                        "data"
                      );
                    }}
                  />
                </div>
                <div class="settings-form-group">
                  <h4 class="settings-form-heading">
                    <label for="other-reports-assessed">Other Reports Assessed</label>
                  </h4>
                  <input
                    id="other-reports-assessed"
                    name="other-reports-assessed"
                    type="number"
                    placeholder="0"
                    min="0"
                    value={state().data.numberOfOtherReportsAssessed}
                    onInput={(event) => {
                      handleChange(
                        "numberOfOtherReportsAssessed",
                        event.target.value,
                        "data"
                      );
                    }}
                  />
                </div>
                <div class="settings-form-group">
                  <h4 class="settings-form-heading">
                    <label for="number-of-other-reasons">Other Reasons</label>
                  </h4>
                  <input
                    id="number-of-other-reasons"
                    name="number-of-other-reasons"
                    type="number"
                    placeholder="3"
                    min="0"
                    value={state().data.numberOfOtherReasons}
                    onInput={(event) => {
                      handleChange("numberOfOtherReasons", event.target.value, "data");
                    }}
                  />
                </div>
                {state().otherReasons.map((reason, index) => (
                  <span class="settings-form-reason-group">
                    <div class="settings-form-group">
                      <label for={`other-reason-${index + 1}`}>{`Other Reason ${
                        index + 1
                      }`}</label>
                      <input
                        id={`other-reason-${index + 1}`}
                        type="text"
                        placeholder={`Other Reason ${index + 1}`}
                        value={reason.name}
                        onInput={(event) =>
                          handleItemChange(
                            index,
                            "name",
                            event.target.value,
                            "otherReasons"
                          )
                        }
                      />
                    </div>
                    <div class="settings-form-group">
                      <label for={`other-reason-number-${index + 1}`}>Number</label>
                      <input
                        id={`other-reason-number-${index + 1}`}
                        type="number"
                        placeholder="0"
                        min="0"
                        value={reason.value}
                        onInput={(event) =>
                          handleItemChange(
                            index,
                            "value",
                            event.target.value,
                            "otherReasons"
                          )
                        }
                      />
                    </div>
                  </span>
                ))}
              </>
            )}
            <div class="settings-form-group">
              <h4 class="settings-form-heading">
                <label for="new-studies">New Studies</label>
              </h4>
              <input
                id="new-studies"
                name="new-studies"
                type="number"
                placeholder="0"
                min="0"
                value={state().data.newStudies}
                onInput={(event) => {
                  handleChange("newStudies", event.target.value, "data");
                }}
              />
            </div>
            <div class="settings-form-group">
              <h4 class="settings-form-heading">
                <label for="new-reports">New Reports</label>
              </h4>
              <input
                id="new-reports"
                name="new-reports"
                type="number"
                placeholder="0"
                min="0"
                value={state().data.newReports}
                onInput={(event) => {
                  handleChange("newReports", event.target.value, "data");
                }}
              />
            </div>
            {state().visual.previousStudiesIncluded && (
              <>
                <div class="settings-form-group">
                  <h4 class="settings-form-heading">
                    <label for="total-studies">Total Studies</label>
                  </h4>
                  <input
                    id="total-studies"
                    name="total-studies"
                    type="number"
                    placeholder="0"
                    min="0"
                    value={state().data.totalStudies}
                    onInput={(event) => {
                      handleChange("totalStudies", event.target.value, "data");
                    }}
                  />
                </div>
                <div class="settings-form-group">
                  <h4 class="settings-form-heading">
                    <label for="total-reports">Total Reports</label>
                  </h4>
                  <input
                    id="total-reports"
                    name="total-reports"
                    type="number"
                    placeholder="0"
                    min="0"
                    value={state().data.totalReports}
                    onInput={(event) => {
                      handleChange("totalReports", event.target.value, "data");
                    }}
                  />
                </div>
              </>
            )}
            {/* Background Color */}
            <div class="settings-form-group">
              <h4 class="settings-form-heading">
                <label for="background-color">Background Color</label>
              </h4>
              <input
                id="background-color"
                name="background-color"
                type="color"
                value={state().visual.backgroundColor}
                onInput={(event) => {
                  handleChange("backgroundColor", event.target.value, "visual");
                }}
              />
            </div>
            {/* Previous Studies Included */}
            <div class="settings-form-group">
              <h4 class="settings-form-heading">
                <label for="previous-studies-included">Previous Studies</label>
              </h4>
              <select
                id="previous-studies-included"
                name="previous-studies-included"
                value={state().visual.previousStudiesIncluded}
                onInput={(event) => {
                  handleChange("previousStudiesIncluded", event.target.value, "visual");
                }}
              >
                <option value="true">True</option>
                <option value="false">False</option>
              </select>
            </div>
            {/* Other Methods Included */}
            <div class="settings-form-group">
              <h4 class="settings-form-heading">
                <label for="other-methods-included">Other Methods</label>
              </h4>
              <select
                id="other-methods-included"
                name="other-methods-included"
                value={state().visual.otherMethodsIncluded}
                onInput={(event) => {
                  handleChange("otherMethodsIncluded", event.target.value, "visual");
                }}
              >
                <option value="true">True</option>
                <option value="false">False</option>
              </select>
            </div>
            {/* Gray Boxes Included */}
            <div class="settings-form-group">
              <h4 class="settings-form-heading">
                <label for="gray-boxes">Gray Boxes</label>
              </h4>
              <select
                id="gray-boxes"
                name="gray-boxes"
                value={state().visual.grayBoxesIncluded}
                onInput={(event) => {
                  handleChange("grayBoxesIncluded", event.target.value, "visual");
                }}
              >
                <option value="true">True</option>
                <option value="false">False</option>
              </select>
            </div>
            {/* Gray Boxes Color */}
            {state().visual.grayBoxesIncluded && (
              <div class="settings-form-group">
                <h4 class="settings-form-heading">
                  <label for="gray-boxes-color">Gray Boxes Color</label>
                </h4>
                <input
                  id="gray-boxes-color"
                  name="gray-boxes-color"
                  type="color"
                  value={state().visual.grayBoxesColor}
                  onInput={(event) => {
                    handleChange("grayBoxesColor", event.target.value, "visual");
                  }}
                />
              </div>
            )}
            {/* Top Boxes Included */}
            <div class="settings-form-group">
              <h4 class="settings-form-heading">
                <label for="top-boxes">Top Boxes</label>
              </h4>
              <select
                id="top-boxes"
                name="top-boxes"
                value={state().visual.topBoxesIncluded}
                onInput={(event) => {
                  handleChange("topBoxesIncluded", event.target.value, "visual");
                }}
              >
                <option value="true">True</option>
                <option value="false">False</option>
              </select>
            </div>
            {state().visual.topBoxesIncluded && (
              <>
                {/* Top Boxes Borders */}
                <div class="settings-form-group">
                  <h4 class="settings-form-heading">
                    <label for="top-boxes-border">Top Boxes Border</label>
                  </h4>
                  <select
                    id="top-boxes-border"
                    name="top-boxes-border"
                    value={state().visual.topBoxesBorders}
                    onInput={(event) => {
                      handleChange("topBoxesBorders", event.target.value, "visual");
                    }}
                  >
                    <option value="true">True</option>
                    <option value="false">False</option>
                  </select>
                </div>
                {/* Top Boxes Color */}
                <div class="settings-form-group">
                  <h4 class="settings-form-heading">
                    <label for="top-boxes-color">Top Boxes Color</label>
                  </h4>
                  <input
                    id="top-boxes-color"
                    name="top-boxes-color"
                    type="color"
                    value={state().visual.topBoxesColor}
                    onInput={(event) => {
                      handleChange("topBoxesColor", event.target.value, "visual");
                    }}
                  />
                </div>
              </>
            )}
            {/* Side Boxes Included */}
            <div class="settings-form-group">
              <h4 class="settings-form-heading">
                <label for="side-boxes">Side Boxes</label>
              </h4>
              <select
                id="side-boxes"
                name="side-boxes"
                value={state().visual.sideBoxesIncluded}
                onInput={(event) => {
                  handleChange("sideBoxesIncluded", event.target.value, "visual");
                }}
              >
                <option value="true">true</option>
                <option value="false">False</option>
              </select>
            </div>
            {state().visual.sideBoxesIncluded && (
              <>
                {/* Side Boxes Borders */}
                <div class="settings-form-group">
                  <h4 class="settings-form-heading">
                    <label for="side-boxes-border">Side Boxes Border</label>
                  </h4>
                  <select
                    id="side-boxes-border"
                    name="Side Boxes Border"
                    value={state().visual.sideBoxesBorders}
                    onInput={(event) => {
                      handleChange("sideBoxesBorders", event.target.value, "visual");
                    }}
                  >
                    <option value="true">True</option>
                    <option value="false">False</option>
                  </select>
                </div>
                {/* Side Boxes Color */}
                <div class="settings-form-group">
                  <h4 class="settings-form-heading">
                    <label for="side-boxes-color">Side Boxes Color</label>
                  </h4>
                  <input
                    id="side-boxes-color"
                    name="side-boxes-color"
                    type="color"
                    value={state().visual.sideBoxesColor}
                    onInput={(event) => {
                      handleChange("sideBoxesColor", event.target.value, "visual");
                    }}
                  />
                </div>
              </>
            )}
            {/* Borders */}
            <div class="settings-form-group">
              <h4 class="settings-form-heading">
                <label for="borders">Borders</label>
              </h4>
              <select
                id="borders"
                name="borders"
                value={state().visual.borders}
                onInput={(event) => {
                  handleChange("borders", event.target.value, "visual");
                }}
              >
                <option value="true">True</option>
                <option value="false">False</option>
              </select>
            </div>
            {/* Border Style */}
            <div class="settings-form-group">
              <h4 class="settings-form-heading">
                <label for="border-style">Border Style</label>
              </h4>
              <select
                id="border-style"
                name="border-style"
                value={state().visual.borderStyle}
                onInput={(event) => {
                  handleChange("borderStyle", event.target.value, "visual");
                }}
              >
                <option value="solid">Solid</option>
                <option value="dashed">Dashed</option>
                <option value="dotted">Dotted</option>
              </select>
            </div>
            {/* Border Width */}
            <div class="settings-form-group">
              <h4 class="settings-form-heading">
                <label for="border-width">Border Width</label>
              </h4>
              <input
                id="border-width"
                name="border-width"
                type="number"
                placeholder="0"
                min="0"
                value={state().visual.borderWidth}
                onInput={(event) => {
                  handleChange("borderWidth", event.target.value, "visual");
                }}
              />
            </div>
            {/* Border Color */}
            <div class="settings-form-group">
              <h4 class="settings-form-heading">
                <label for="border-color">Border Color</label>
              </h4>
              <input
                id="border-color"
                name="border-color"
                type="color"
                value={state().visual.borderColor}
                onInput={(event) => {
                  handleChange("borderColor", event.target.value, "visual");
                }}
              />
            </div>
            <div class="settings-form-group">
              <h4 class="settings-form-heading">
                <label for="font">Font</label>
              </h4>
              <select
                id="font"
                name="font"
                value={state().visual.font}
                onInput={(event) => {
                  handleChange("font", event.target.value, "visual");
                }}
              >
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
                <option value="Lato">Lato</option>
                <option value="Roboto">Roboto</option>
                <option value="Times New Roman">Times New Roman</option>
                <option value="Verdana">Verdana</option>
              </select>
            </div>
            <div class="settings-form-group">
              <h4 class="settings-form-heading">
                <label for="font-size">Font Size</label>
              </h4>
              <input
                id="font-size"
                name="font-size"
                type="number"
                placeholder="0"
                min="0"
                value={state().visual.fontSize}
                onInput={(event) => {
                  handleChange("fontSize", event.target.value, "visual");
                }}
              />
            </div>
            <div class="settings-form-group">
              <h4 class="settings-form-heading">
                <label for="font-color">Font Color</label>
              </h4>
              <input
                id="font-color"
                name="font-color"
                type="color"
                value={state().visual.fontColor}
                onInput={(event) => {
                  handleChange("fontColor", event.target.value, "visual");
                }}
              />
            </div>
            {/* Arrow Head */}
            <div class="settings-form-group">
              <h4 class="settings-form-heading">
                <label for="arrow-head">Arrow Head</label>
              </h4>
              <input
                id="arrow-head"
                name="arrow-head"
                type="text"
                value={state().visual.arrowHead}
                onInput={(event) => {
                  handleChange("arrowHead", event.target.value, "visual");
                }}
              />
            </div>
            {/* Arrow Size */}
            <div class="settings-form-group">
              <h4 class="settings-form-heading">
                <label for="arrow-size">Arrow Size</label>
              </h4>
              <input
                id="arrow-size"
                name="arrow-size"
                type="number"
                placeholder="0"
                min="0"
                value={state().visual.arrowSize}
                onInput={(event) => {
                  handleChange("arrowSize", event.target.value, "visual");
                }}
              />
            </div>
            {/* Arrow Width */}
            <div class="settings-form-group">
              <h4 class="settings-form-heading">
                <label for="arrow-width">Arrow Width</label>
              </h4>
              <input
                id="arrow-width"
                name="arrow-width"
                type="number"
                placeholder="0"
                min="0"
                value={state().visual.arrowWidth}
                onInput={(event) => {
                  handleChange("arrowWidth", event.target.value, "visual");
                }}
              />
            </div>
            {/* Arrow Color */}
            <div class="settings-form-group">
              <h4 class="settings-form-heading">
                <label for="arrow-color">Arrow Color</label>
              </h4>
              <input
                id="arrow-color"
                name="arrow-color"
                type="color"
                value={state().visual.arrowColor}
                onInput={(event) => {
                  handleChange("arrowColor", event.target.value, "visual");
                }}
              />
            </div>
          </div>
        </div>
        {/* settings actions */}
        <div class="settings-actions-buttons">
          <button
            title="download current figure"
            class="settings-actions-button export-button"
            onMouseDown={exportFlowDiagram}
          >
            <Download class="settings-actions-button-icon export-button-icon" />
            Export
          </button>
          <button
            title="reset to default settings"
            class="settings-actions-button remove-button"
            onMouseDown={resetFlowDiagramOptions}
          >
            <Reset class="settings-actions-button-icon remove-button-icon" />
            Reset
          </button>
        </div>
      </div>
      {/* flow diagram container */}
      <div class="flow-diagram-container"></div>
    </main>
  );
}
