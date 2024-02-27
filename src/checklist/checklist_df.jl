using DataFrames

function checklist_df()
    checklist_columns::Vector{String} = [
        "Section and Topic", "Item #", "Checklist Item", "Location where item is reported"
    ]

    checklist_rows::Vector{Tuple{Union{String,Missing},Union{String,Missing},Union{String,Missing},Union{String,Missing}}} = [
        ("TITLE", missing, missing, missing),
        ("Title", "1", "Identify the report as a systematic review", missing),
        ("ABSTRACT", missing, missing, missing),
        ("Abstract", "2", "See the PRISMA 2020 for Abstracts checklist", missing),
        ("INTRODUCTION", missing, missing, missing),
        ("Rationale", "3", "Describe the rationale for the review in the context of existing knowledge.", missing),
        ("Objectives", "4", "Provide an explicit statement of the objective(s) or question(s) the review addresses.", missing),
        ("METHODS", missing, missing, missing),
        ("Eligibility criteria", "5", "Specify the inclusion and exclusion criteria for the review and how studies were grouped for the syntheses.", missing),
        ("Information sources", "6", "Specify all databases, registers, websites, organisations, reference lists and other sources searched or consulted to identify studies. Specify the date when each source was last searched or consulted.", missing),
        ("Search strategy", "7", "Present the full search strategies for all databases, registers and websites, including any filters and limits used.", missing),
        ("Selection process", "8", "Specify the methods used to decide whether a study met the inclusion criteria of the review, including how many reviewers screened each record and each report retrieved, whether they worked independently, and if applicable, details of automation tools used in the process.", missing),
        ("Data collection process", "9", "Specify the methods used to collect data from reports, including how many reviewers collected data from each report, whether they worked independently, any processes for obtaining or confirming data from study investigators, and if applicable, details of automation tools used in the process.", missing),
        ("Data items", "10a", "List and define all outcomes for which data were sought. Specify whether all results that were compatible with each outcome domain in each study were sought (e.g. for all measures, time points, analyses), and if not, the methods used to decide which results to collect.", missing),
        (missing, "10b", "List and define all other variables for which data were sought (e.g. participant and intervention characteristics, funding sources). Describe any assumptions made about any missing or unclear information.", missing),
        ("Study risk of bias assessment", "11", "Specify the methods used to assess risk of bias in the included studies, including details of the tool(s) used, how many reviewers assessed each study and whether they worked independently, and if applicable, details of automation tools used in the process.", missing),
        ("Effect measures", "12", "Specify for each outcome the effect measure(s) (e.g. risk ratio, mean difference) used in the synthesis or presentation of results.", missing),
        ("Synthesis methods", "13a", "Describe the processes used to decide which studies were eligible for each synthesis (e.g. tabulating the study intervention characteristics and comparing against the planned groups for each synthesis (item #5)).", missing),
        (missing, "13b", "Describe any methods required to prepare the data for presentation or synthesis, such as handling of missing summary statistics, or data conversions.", missing),
        (missing, "13c", "Describe any methods used to tabulate or visually display results of individual studies and syntheses.", missing),
        (missing, "13d", "Describe any methods used to synthesize results and provide a rationale for the choice(s). If meta-analysis was performed, describe the model(s), method(s) to identify the presence and extent of statistical heterogeneity, and software package(s) used.", missing),
        (missing, "13e", "Describe any methods used to explore possible causes of heterogeneity among study results (e.g. subgroup analysis, meta-regression).", missing),
        (missing, "13f", "Describe any sensitivity analyses conducted to assess robustness of the synthesized results.", missing),
        ("Reporting bias assessment", "14", "Describe any methods used to assess risk of bias due to missing results in a synthesis (arising from reporting biases).", missing),
        ("Certainty assessment", "15", "Describe any methods used to assess certainty (or confidence) in the body of evidence for an outcome.", missing),
        ("RESULTS", missing, missing, missing),
        ("Study selection", "16a", "Describe the results of the search and selection process, from the number of records identified in the search to the number of studies included in the review, ideally using a flow diagram.", missing),
        (missing, "16b", "Cite studies that might appear to meet the inclusion criteria, but which were excluded, and explain why they were excluded.", missing),
        ("Study characteristics", "17", "Cite each included study and present its characteristics.", missing),
        ("Risk of bias in studies", "18", "Present assessments of risk of bias for each included study.", missing),
        ("Results of individual studies", "19", "For all outcomes, present, for each study: (a) summary statistics for each group (where appropriate) and (b) an effect estimate and its precision (e.g. confidence/credible interval), ideally using structured tables or plots.", missing),
        ("Results of syntheses", "20a", "For each synthesis, briefly summarise the characteristics and risk of bias among contributing studies.", missing),
        (missing, "20b", "Present results of all statistical syntheses conducted. If meta-analysis was done, present for each the summary estimate and its precision (e.g. confidence/credible interval) and measures of statistical heterogeneity. If comparing groups, describe the direction of the effect.", missing),
        (missing, "20c", "Present results of all investigations of possible causes of heterogeneity among study results.", missing),
        (missing, "20d", "Present results of all sensitivity analyses conducted to assess the robustness of the synthesized results.", missing),
        ("Reporting biases", "21", "Present assessments of risk of bias due to missing results (arising from reporting biases) for each synthesis assessed.", missing),
        ("Certainty of evidence", "22", "Present assessments of certainty (or confidence) in the body of evidence for each outcome assessed.", missing),
        ("DISCUSSION", missing, missing, missing),
        ("Discussion", "23a", "Provide a general interpretation of the results in the context of other evidence.", missing),
        (missing, "23b", "Discuss any limitations of the evidence included in the review.", missing),
        (missing, "23c", "Discuss any limitations of the review processes used.", missing),
        (missing, "23d", "Discuss implications of the results for practice, policy, and future research.", missing),
        ("OTHER INFORMATION", missing, missing, missing),
        ("Registration and protocol", "24a", "Provide registration information for the review, including register name and registration number, or state that the review was not registered.", missing),
        (missing, "24b", "Indicate where the review protocol can be accessed, or state that a protocol was not prepared.", missing),
        (missing, "24c", "Describe and explain any amendments to information provided at registration or in the protocol.", missing),
        ("Support", "25", "Describe sources of financial or non-financial support for the review, and the role of the funders or sponsors in the review.", missing),
        ("Competing interests", "26", "Identify the report as a systematic review", missing),
        ("Availability of data, code and other materials", "27", "Report which of the following are publicly available and where they can be found: template data collection forms; data extracted from included studies; data used for all analyses; analytic code; any other materials used in the review.", missing)
    ]

    _checklist_df_::DataFrame = DataFrames.DataFrame(checklist_rows) |>
        (df -> DataFrames.rename(df, Base.Symbol.(checklist_columns)))
    return _checklist_df_

end