using DataFrames

function flow_diagram_df()
    flow_diagram_columns::Vector{String} = [
        "node_id","node_tooltip","node_text","num"
    ]
    flow_diagram_rows::Vector{Tuple{Int64,String,String,Union{Int64,Missing}}} = [
        (1,"Previous studies","Previous studies",missing),
        (2,"Identification of new studies via databases and registers","Identification of new studies via databases and registers",missing),
        (3,"Identification of new studies via other methods","Identification of new studies via other methods",missing),
        (4,"Identification","Identification",missing),
        (5,"Screening","Screening",missing),
        (6,"Included","Included",missing),
        (7,"Studies included in previous version of review","Studies included in previous version of review",000,),
        (7,"Studies included in previous version of review","Reports of studies included in previous version of review",000),
        (8,"Databases and Registers","Records identified from:",missing),
        (8,"Databases and Registers","Database or Register 1",000),
        (8,"Databases and Registers","Database or Register 2",000),
        (8,"Databases and Registers","Database or Register 3",000),
        (9,"Records removed before screening","Records removed before screening:",missing),
        (9,"Records removed before screening","Duplicate records removed",000),
        (9,"Records removed before screening","Records marked as ineligible by automation tools",000),
        (9,"Records removed before screening","Records removed for other reasons",000),
        (10,"Records Screened","Records screened",000),
        (11,"Records excluded","Records excluded",000),
        (12,"Reports sought for retrieval","Reports sought for retrieval",000),
        (13,"Reports not retrieved","Reports not retrieved",000),
        (14,"Reports assessed for eligibility","Reports assessed for eligibility",000),
        (15,"Reports exluded","Reports excluded:",missing),
        (15,"Reports exluded","Reason 1",000),
        (15,"Reports exluded","Reason 2",000),
        (15,"Reports exluded","Reason 3",000),
        (16,"New studies","New studies included in review",000),
        (16,"New studies","Reports of new included studies",000),
        (17,"Total studies","Total studies included in review",000),
        (17,"Total studies","Reports of total included studies",000),
        (18,"Websites, Organizations, Citation searching, etc.","Records identified from:",missing),
        (18,"Websites, Organizations, Citation searching, etc.","Websites",000),
        (18,"Websites, Organizations, Citation searching, etc.","Organisations",000),
        (18,"Websites, Organizations, Citation searching, etc.","Citation searching",000),
        (18,"Websites, Organizations, Citation searching, etc.","Other",000),
        (19,"Reports sought for retrieval (via other methods)","Reports sought for retrieval",000),
        (20,"Reports not retrieved (via other methods)","Reports not retrieved",000),
        (21,"Reports assessed for eligibility (via other methods)","Reports assessed for eligibility",000),
        (22,"Reports exluded (via other methods)","Reports excluded:",missing),
        (22,"Reports exluded (via other methods)","Reason 1",000),
        (22,"Reports exluded (via other methods)","Reason 2",000),
        (22,"Reports exluded (via other methods)","Reason 3",000)
    ]
    _flow_diagram_df_::DataFrame = DataFrames.DataFrame(flow_diagram_rows) |>
        (df -> DataFrames.rename(df, Base.Symbol.(flow_diagram_columns)))
    return _flow_diagram_df_
end
