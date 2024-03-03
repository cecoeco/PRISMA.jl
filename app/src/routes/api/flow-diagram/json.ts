interface FlowDiagramRow {
    node_id: number;
    node_tooltip: string;
    node_text: string;
    num: number | null;
}

function flow_diagram_df(): FlowDiagramRow[] {
    const flow_diagram_rows: FlowDiagramRow[] = [
        {
            node_id: 1,
            node_tooltip: "Previous studies",
            node_text: "Previous studies",
            num: null
        },
        {
            node_id: 2,
            node_tooltip: "Identification of new studies via databases and registers",
            node_text: "Identification of new studies via databases and registers",
            num: null
        },
        {
            node_id: 3,
            node_tooltip: "Identification of new studies via other methods",
            node_text: "Identification of new studies via other methods",
            num: null
        },
        {
            node_id: 4,
            node_tooltip: "Identification",
            node_text: "Identification",
            num: null
        },
        {
            node_id: 5,
            node_tooltip: "Screening",
            node_text: "Screening",
            num: null
        },
        {
            node_id: 6,
            node_tooltip: "Included",
            node_text: "Included",
            num: null
        },
        {
            node_id: 7,
            node_tooltip: "Studies included in previous version of review",
            node_text: "Studies included in previous version of review",
            num: null
        },
        {
            node_id: 7,
            node_tooltip: "Studies included in previous version of review",
            node_text: "Reports of studies included in previous version of review",
            num: null
        },
        {
            node_id: 8,
            node_tooltip: "Databases and Registers",
            node_text: "Records identified from:",
            num: null
        },
        {
            node_id: 8,
            node_tooltip: "Databases and Registers",
            node_text: "Database or Register 1",
            num: 0
        },
        {
            node_id: 8,
            node_tooltip: "Databases and Registers",
            node_text: "Database or Register 2",
            num: 0
        },
        {
            node_id: 8,
            node_tooltip: "Databases and Registers",
            node_text: "Database or Register 3",
            num: 0
        },
        {
            node_id: 9,
            node_tooltip: "Records removed before screening",
            node_text: "Records removed before screening:",
            num: null
        },
        {
            node_id: 9,
            node_tooltip: "Records removed before screening",
            node_text: "Duplicate records removed",
            num: 0
        },
        {
            node_id: 9,
            node_tooltip: "Records removed before screening",
            node_text: "Records marked as ineligible by automation tools",
            num: 0
        },
        {
            node_id: 9,
            node_tooltip: "Records removed before screening",
            node_text: "Records removed for other reasons",
            num: 0
        },
        {
            node_id: 10,
            node_tooltip: "Records Screened",
            node_text: "Records screened",
            num: 0
        },
        {
            node_id: 11,
            node_tooltip: "Records excluded",
            node_text: "Records excluded",
            num: 0
        },
        {
            node_id: 12,
            node_tooltip: "Reports sought for retrieval",
            node_text: "Reports sought for retrieval",
            num: 0
        },
        {
            node_id: 13,
            node_tooltip: "Reports not retrieved",
            node_text: "Reports not retrieved",
            num: 0
        },
        {
            node_id: 14,
            node_tooltip: "Reports assessed for eligibility",
            node_text: "Reports assessed for eligibility",
            num: 0
        },
        {
            node_id: 15,
            node_tooltip: "Reports exluded",
            node_text: "Reports excluded:",
            num: null
        },
        {
            node_id: 15,
            node_tooltip: "Reports exluded",
            node_text: "Reason 1",
            num: 0
        },
        {
            node_id: 15,
            node_tooltip: "Reports exluded",
            node_text: "Reason 2",
            num: 0
        },
        {
            node_id: 15,
            node_tooltip: "Reports exluded",
            node_text: "Reason 3",
            num: 0
        },
        {
            node_id: 16,
            node_tooltip: "New studies",
            node_text: "New studies included in review",
            num: 0
        },
        {
            node_id: 16,
            node_tooltip: "New studies",
            node_text: "Reports of new included studies",
            num: 0
        },
        {
            node_id: 17,
            node_tooltip: "Total studies",
            node_text: "Total studies included in review",
            num: 0
        },
        {
            node_id: 17,
            node_tooltip: "Total studies",
            node_text: "Reports of total included studies",
            num: 0
        },
        {
            node_id: 18,
            node_tooltip: "Websites, Organizations, Citation searching, etc.",
            node_text: "Records identified from:",
            num: null
        },
        {
            node_id: 18,
            node_tooltip: "Websites, Organizations, Citation searching, etc.",
            node_text: "Websites",
            num: 0
        },
        {
            node_id: 18,
            node_tooltip: "Websites, Organizations, Citation searching, etc.",
            node_text: "Organisations",
            num: 0
        },
        {
            node_id: 18,
            node_tooltip: "Websites, Organizations, Citation searching, etc.",
            node_text: "Citation searching",
            num: 0
        },
        {
            node_id: 18,
            node_tooltip: "Websites, Organizations, Citation searching, etc.",
            node_text: "Other",
            num: 0
        },
        {
            node_id: 19,
            node_tooltip: "Reports sought for retrieval (via other methods)",
            node_text: "Reports sought for retrieval",
            num: 0
        },
        {
            node_id: 20,
            node_tooltip: "Reports not retrieved (via other methods)",
            node_text: "Reports not retrieved",
            num: 0
        },
        {
            node_id: 21,
            node_tooltip: "Reports assessed for eligibility (via other methods)",
            node_text: "Reports assessed for eligibility",
            num: 0
        },
        {
            node_id: 22,
            node_tooltip: "Reports exluded (via other methods)",
            node_text: "Reports excluded:",
            num: null
        },
        {
            node_id: 22,
            node_tooltip: "Reports exluded (via other methods)",
            node_text: "Reason 1",
            num: 0
        },
        {
            node_id: 22,
            node_tooltip: "Reports exluded (via other methods)",
            node_text: "Reason 2",
            num: 0
        },
        {
            node_id: 22,
            node_tooltip: "Reports exluded (via other methods)",
            node_text: "Reason 3",
            num: 0
        }
    ];
    return flow_diagram_rows;
}

const flowDiagramData: FlowDiagramRow[] = flow_diagram_df();

export async function GET() {
    try {
        const json_data = JSON.stringify(flowDiagramData);
        
        return new Response(json_data, {
            headers: {
                'Content-Type': 'application/json',
                'Content-Disposition': 'attachment; filename="flow_diagram.json"'
            }
        });
    } catch (error) {
        console.error('Error generating JSON:', error);
        return new Response(null, { status: 500 });
    }
}