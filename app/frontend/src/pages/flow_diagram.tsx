import React, { useState, useEffect } from "react";

import "../assets/css/flow_diagram.css";

import Download from "../assets/svgs/download.svg?react";
import Reset from "../assets/svgs/reset.svg?react";

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

const FlowDiagram: React.FC = () => {
  const [state, setState] = useState({
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
    value: number,
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
    value: string,
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
        box_text: "Previous studies",
        results: null,
      },
      {
        box_num: 2,
        box_text: "Identification of new studies via databases and registers",
        results: null,
      },
      {
        box_num: 3,
        box_text: "Identification of new studies via other methods",
        results: null,
      },
      {
        box_num: 4,
        box_text: "Identification",
        results: null,
      },
      {
        box_num: 5,
        box_text: "Screening",
        results: null,
      },
      {
        box_num: 6,
        box_text: "Included",
        results: null,
      },
      {
        box_num: 7,
        box_text: "Studies included in previous version of review",
        results: state().data.numberOfPreviousStudies,
      },
      {
        box_num: 7,
        box_text: "Reports of studies included in previous version of review",
        results: state().data.numberOfPreviousReports,
      },
      {
        box_num: 8,
        box_text: "Records identified from:",
        results: null,
      },
    ];

    state().databases.forEach((database: { name: string; value: number }) => {
      boxes.push({
        box_num: 8,
        box_text: database.name,
        results: database.value,
      });
    });

    boxes.push(
      {
        box_num: 9,
        box_text: "Records removed before screening:",
        results: null,
      },
      {
        box_num: 9,
        box_text: "Duplicate records removed",
        results: state().data.numberOfDuplicatesRemoved,
      },
      {
        box_num: 9,
        box_text: "Records marked as ineligible by automation tools",
        results: state().data.numberOfAutomaticallyExcluded,
      },
      {
        box_num: 9,
        box_text: "Records removed for other reasons",
        results: state().data.numberOfRemovedForOtherReasons,
      },
      {
        box_num: 10,
        box_text: "Records screened",
        results: state().data.numberOfRecordsScreened,
      },
      {
        box_num: 11,
        box_text: "Records excluded",
        results: state().data.numberOfRecordsExcluded,
      },
      {
        box_num: 12,
        box_text: "Reports sought for retrieval",
        results: state().data.numberOfReportsSought,
      },
      {
        box_num: 13,
        box_text: "Reports not retrieved",
        results: state().data.numberOfReportsNotRetrieved,
      },
      {
        box_num: 14,
        box_text: "Reports assessed for eligibility",
        results: state().data.numberOfReportsAssessed,
      },
      {
        box_num: 15,
        box_text: "Reports excluded:",
        results: null,
      }
    );

    state().reasons.forEach((reason: { name: string; value: number }) => {
      boxes.push({
        box_num: 15,
        box_text: reason.name,
        results: reason.value,
      });
    });

    boxes.push(
      {
        box_num: 16,
        box_text: "New studies included in review",
        results: state().data.newStudies,
      },
      {
        box_num: 16,
        box_text: "Reports of new included studies",
        results: state().data.newReports,
      },
      {
        box_num: 17,
        box_text: "Total studies included in review",
        results: state().data.totalStudies,
      },
      {
        box_num: 17,
        box_text: "Reports of total included studies",
        results: state().data.totalReports,
      },
      {
        box_num: 18,
        box_text: "Records identified from:",
        results: null,
      },
      {
        box_num: 18,
        box_text: "Websites",
        results: state().data.numberOfWebsites,
      },
      {
        box_num: 18,
        box_text: "Organizations",
        results: state().data.numberOfOrganizations,
      },
      {
        box_num: 18,
        box_text: "Citation searching",
        results: state().data.numberOfCitations,
      },
      {
        box_num: 18,
        box_text: "Other",
        results: state().data.numberOfOtherSources,
      },
      {
        box_num: 19,
        box_text: "Reports sought for retrieval",
        results: state().data.numberOfReportsSought,
      },
      {
        box_num: 20,
        box_text: "Reports not retrieved",
        results: state().data.numberOfReportsNotRetrieved,
      },
      {
        box_num: 21,
        box_text: "Reports assessed for eligibility",
        results: state().data.numberOfReportsAssessed,
      },
      {
        box_num: 22,
        box_text: "Reports excluded:",
        results: null,
      }
    );

    state().otherReasons.forEach((reason: { name: string; value: number }) => {
      boxes.push({
        box_num: 22,
        box_text: reason.name,
        results: reason.value,
      });
    });

    return boxes;
  }

  async function getFlowDiagram() {
    try {
      const response = await fetch("http://0.0.0.0:5050/flow_diagram", {
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

  useEffect(() => {
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
    <main className="flow-diagram-page">
      <div className="settings-container">
        <div className="settings">
          <h2 className="settings-title">Flow Diagram</h2>
          <div className="settings-form">
            {state().visual.previousStudiesIncluded && (
              <>
                {/* Previous Studies */}
                <div className="settings-form-group">
                  <h4 className="settings-form-heading">
                    <label htmlFor="previous-studies">Previous Studies</label>
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
                <div className="settings-form-group">
                  <h4 className="settings-form-heading">
                    <label htmlFor="previous-reports">Previous Reports</label>
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
            <div className="settings-form-group">
              <h4 className="settings-form-heading">
                <label htmlFor="number-of-databases">Databases</label>
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
              <span className="settings-form-database-group">
                <div className="settings-form-group">
                  <label htmlFor={`database-${index + 1}`}>{`Database ${
                    index + 1
                  }`}</label>
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
                <div className="settings-form-group">
                  <label htmlFor={`database-number-${index + 1}`}>Number</label>
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
            <div className="settings-form-group">
              <h4 className="settings-form-heading">
                <label htmlFor="duplicates-removed">Duplicates Removed</label>
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
            <div className="settings-form-group">
              <h4 className="settings-form-heading">
                <label htmlFor="automatically-excluded">Automatically Excluded</label>
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
            <div className="settings-form-group">
              <h4 className="settings-form-heading">
                <label htmlFor="removed-for-other-reasons">
                  Removed For Other Reasons
                </label>
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
                <div className="settings-form-group">
                  <h4 className="settings-form-heading">
                    <label htmlFor="websites">Websites</label>
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
                <div className="settings-form-group">
                  <h4 className="settings-form-heading">
                    <label htmlFor="organizations">Organizations</label>
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
                <div className="settings-form-group">
                  <h4 className="settings-form-heading">
                    <label htmlFor="citations">Citations</label>
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
                <div className="settings-form-group">
                  <h4 className="settings-form-heading">
                    <label htmlFor="other-sources">Other Sources</label>
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
            <div className="settings-form-group">
              <h4 className="settings-form-heading">
                <label htmlFor="records-screened">Records Screened</label>
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
            <div className="settings-form-group">
              <h4 className="settings-form-heading">
                <label htmlFor="records-excluded">Records Excluded</label>
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
            <div className="settings-form-group">
              <h4 className="settings-form-heading">
                <label htmlFor="reports-sought">Reports Sought</label>
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
            <div className="settings-form-group">
              <h4 className="settings-form-heading">
                <label htmlFor="reports-not-retrieved">Reports Not Retrieved</label>
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
            <div className="settings-form-group">
              <h4 className="settings-form-heading">
                <label htmlFor="reports-assessed">Reports Assessed</label>
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
            <div className="settings-form-group">
              <h4 className="settings-form-heading">
                <label htmlFor="number-of-reasons">Reasons</label>
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
              <span className="settings-form-reason-group">
                <div className="settings-form-group">
                  <label htmlFor={`reason-${index + 1}`}>{`Reason ${index + 1}`}</label>
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
                <div className="settings-form-group">
                  <label htmlFor={`reason-number-${index + 1}`}>Number</label>
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
                <div className="settings-form-group">
                  <h4 className="settings-form-heading">
                    <label htmlFor="other-reports-sought">Other Reports Sought</label>
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
                <div className="settings-form-group">
                  <h4 className="settings-form-heading">
                    <label htmlFor="other-reports-not-retrieved">
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
                <div className="settings-form-group">
                  <h4 className="settings-form-heading">
                    <label htmlFor="other-reports-assessed">Other Reports Assessed</label>
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
                <div className="settings-form-group">
                  <h4 className="settings-form-heading">
                    <label htmlFor="number-of-other-reasons">Other Reasons</label>
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
                  <span className="settings-form-reason-group">
                    <div className="settings-form-group">
                      <label htmlFor={`other-reason-${index + 1}`}>{`Other Reason ${
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
                    <div className="settings-form-group">
                      <label htmlFor={`other-reason-number-${index + 1}`}>Number</label>
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
            <div className="settings-form-group">
              <h4 className="settings-form-heading">
                <label htmlFor="new-studies">New Studies</label>
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
            <div className="settings-form-group">
              <h4 className="settings-form-heading">
                <label htmlFor="new-reports">New Reports</label>
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
                <div className="settings-form-group">
                  <h4 className="settings-form-heading">
                    <label htmlFor="total-studies">Total Studies</label>
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
                <div className="settings-form-group">
                  <h4 className="settings-form-heading">
                    <label htmlFor="total-reports">Total Reports</label>
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
            <div className="settings-form-group">
              <h4 className="settings-form-heading">
                <label htmlFor="background-color">Background Color</label>
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
            <div className="settings-form-group">
              <h4 className="settings-form-heading">
                <label htmlFor="previous-studies-included">Previous Studies</label>
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
            <div className="settings-form-group">
              <h4 className="settings-form-heading">
                <label htmlFor="other-methods-included">Other Methods</label>
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
            <div className="settings-form-group">
              <h4 className="settings-form-heading">
                <label htmlFor="gray-boxes">Gray Boxes</label>
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
              <div className="settings-form-group">
                <h4 className="settings-form-heading">
                  <label htmlFor="gray-boxes-color">Gray Boxes Color</label>
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
            <div className="settings-form-group">
              <h4 className="settings-form-heading">
                <label htmlFor="top-boxes">Top Boxes</label>
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
                <div className="settings-form-group">
                  <h4 className="settings-form-heading">
                    <label htmlFor="top-boxes-border">Top Boxes Border</label>
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
                <div className="settings-form-group">
                  <h4 className="settings-form-heading">
                    <label htmlFor="top-boxes-color">Top Boxes Color</label>
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
            <div className="settings-form-group">
              <h4 className="settings-form-heading">
                <label htmlFor="side-boxes">Side Boxes</label>
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
                <div className="settings-form-group">
                  <h4 className="settings-form-heading">
                    <label htmlFor="side-boxes-border">Side Boxes Border</label>
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
                <div className="settings-form-group">
                  <h4 className="settings-form-heading">
                    <label htmlFor="side-boxes-color">Side Boxes Color</label>
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
            <div className="settings-form-group">
              <h4 className="settings-form-heading">
                <label htmlFor="borders">Borders</label>
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
            <div className="settings-form-group">
              <h4 className="settings-form-heading">
                <label htmlFor="border-style">Border Style</label>
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
            <div className="settings-form-group">
              <h4 className="settings-form-heading">
                <label htmlFor="border-width">Border Width</label>
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
            <div className="settings-form-group">
              <h4 className="settings-form-heading">
                <label htmlFor="border-color">Border Color</label>
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
            <div className="settings-form-group">
              <h4 className="settings-form-heading">
                <label htmlFor="font">Font</label>
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
            <div className="settings-form-group">
              <h4 className="settings-form-heading">
                <label htmlFor="font-size">Font Size</label>
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
            <div className="settings-form-group">
              <h4 className="settings-form-heading">
                <label htmlFor="font-color">Font Color</label>
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
            <div className="settings-form-group">
              <h4 className="settings-form-heading">
                <label htmlFor="arrow-head">Arrow Head</label>
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
            <div className="settings-form-group">
              <h4 className="settings-form-heading">
                <label htmlFor="arrow-size">Arrow Size</label>
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
            <div className="settings-form-group">
              <h4 className="settings-form-heading">
                <label htmlFor="arrow-width">Arrow Width</label>
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
            <div className="settings-form-group">
              <h4 className="settings-form-heading">
                <label htmlFor="arrow-color">Arrow Color</label>
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
        <div className="settings-actions-buttons">
          <button
            title="download current figure"
            className="settings-actions-button export-button"
            onMouseDown={exportFlowDiagram}
          >
            <Download className="settings-actions-button-icon export-button-icon" />
            Export
          </button>
          <button
            title="reset to default settings"
            className="settings-actions-button remove-button"
            onMouseDown={resetFlowDiagramOptions}
          >
            <Reset className="settings-actions-button-icon remove-button-icon" />
            Reset
          </button>
        </div>
      </div>
      {/* flow diagram container */}
      <div className="flow-diagram-container"></div>
    </main>
  );
};

export default FlowDiagram;
