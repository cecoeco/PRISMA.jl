"""
    checklist_df()

Returns the checklist dataframe.
"""
function checklist_df()
    names::Vector{String} = [
        "Section and Topic",
        "Item #",
        "Checklist Item",
        "Location where item is reported"
    ]
    rows::Vector{Tuple{Union{String,Missing},Union{String,Missing},Union{String,Missing},Union{String,Missing}}} = [
        (
            "TITLE",
            missing,
            missing,
            missing
        ),
        (
            "Title",
            "1",
            "Identify the report as a systematic review",
            missing
        ),
        (
            "ABSTRACT",
            missing,
            missing,
            missing
        ),
        (
            "Abstract",
            "2",
            "See the PRISMA 2020 for Abstracts checklist",
            missing
        ),
        (
            "INTRODUCTION",
            missing,
            missing,
            missing
        ),
        (
            "Rationale",
            "3",
            "Describe the rationale for the review in the context of existing knowledge.",
            missing
        ),
        (
            "Objectives",
            "4",
            "Provide an explicit statement of the objective(s) or question(s) the review addresses.",
            missing
        ),
        (
            "METHODS",
            missing,
            missing,
            missing
        ),
        (
            "Eligibility criteria",
            "5",
            "Specify the inclusion and exclusion criteria for the review and how studies were grouped for the syntheses.",
            missing
        ),
        (
            "Information sources",
            "6",
            "Specify all databases, registers, websites, organisations, reference lists and other sources searched or consulted to identify studies. Specify the date when each source was last searched or consulted.",
            missing
        ),
        (
            "Search strategy",
            "7",
            "Present the full search strategies for all databases, registers and websites, including any filters and limits used.",
            missing
        ),
        (
            "Selection process",
            "8",
            "Specify the methods used to decide whether a study met the inclusion criteria of the review, including how many reviewers screened each record and each report retrieved, whether they worked independently, and if applicable, details of automation tools used in the process.",
            missing
        ),
        (
            "Data collection process",
            "9",
            "Specify the methods used to collect data from reports, including how many reviewers collected data from each report, whether they worked independently, any processes for obtaining or confirming data from study investigators, and if applicable, details of automation tools used in the process.",
            missing
        ),
        (
            "Data items",
            "10a",
            "List and define all outcomes for which data were sought. Specify whether all results that were compatible with each outcome domain in each study were sought (e.g. for all measures, time points, analyses), and if not, the methods used to decide which results to collect.",
            missing
        ),
        (
            missing,
            "10b",
            "List and define all other variables for which data were sought (e.g. participant and intervention characteristics, funding sources). Describe any assumptions made about any missing or unclear information.",
            missing
        ),
        (
            "Study risk of bias assessment",
            "11",
            "Specify the methods used to assess risk of bias in the included studies, including details of the tool(s) used, how many reviewers assessed each study and whether they worked independently, and if applicable, details of automation tools used in the process.",
            missing
        ),
        (
            "Effect measures",
            "12",
            "Specify for each outcome the effect measure(s) (e.g. risk ratio, mean difference) used in the synthesis or presentation of results.",
            missing
        ),
        (
            "Synthesis methods",
            "13a",
            "Describe the processes used to decide which studies were eligible for each synthesis (e.g. tabulating the study intervention characteristics and comparing against the planned groups for each synthesis (item #5)).",
            missing
        ),
        (
            missing,
            "13b",
            "Describe any methods required to prepare the data for presentation or synthesis, such as handling of missing summary statistics, or data conversions.",
            missing
        ),
        (
            missing,
            "13c",
            "Describe any methods used to tabulate or visually display results of individual studies and syntheses.",
            missing
        ),
        (
            missing,
            "13d",
            "Describe any methods used to synthesize results and provide a rationale for the choice(s). If meta-analysis was performed, describe the model(s), method(s) to identify the presence and extent of statistical heterogeneity, and software package(s) used.",
            missing
        ),
        (
            missing,
            "13e",
            "Describe any methods used to explore possible causes of heterogeneity among study results (e.g. subgroup analysis, meta-regression).",
            missing
        ),
        (
            missing,
            "13f",
            "Describe any sensitivity analyses conducted to assess robustness of the synthesized results.",
            missing
        ),
        (
            "Reporting bias assessment",
            "14",
            "Describe any methods used to assess risk of bias due to missing results in a synthesis (arising from reporting biases).",
            missing
        ),
        (
            "Certainty assessment",
            "15",
            "Describe any methods used to assess certainty (or confidence) in the body of evidence for an outcome.",
            missing
        ),
        (
            "RESULTS",
            missing,
            missing,
            missing
        ),
        (
            "Study selection",
            "16a",
            "Describe the results of the search and selection process, from the number of records identified in the search to the number of studies included in the review, ideally using a flow diagram.",
            missing
        ),
        (
            missing,
            "16b",
            "Cite studies that might appear to meet the inclusion criteria, but which were excluded, and explain why they were excluded.",
            missing
        ),
        (
            "Study characteristics",
            "17",
            "Cite each included study and present its characteristics.",
            missing
        ),
        (
            "Risk of bias in studies",
            "18",
            "Present assessments of risk of bias for each included study.",
            missing
        ),
        (
            "Results of individual studies",
            "19",
            "For all outcomes, present, for each study: (a) summary statistics for each group (where appropriate) and (b) an effect estimate and its precision (e.g. confidence/credible interval), ideally using structured tables or plots.",
            missing
        ),
        (
            "Results of syntheses",
            "20a",
            "For each synthesis, briefly summarise the characteristics and risk of bias among contributing studies.",
            missing
        ),
        (
            missing,
            "20b",
            "Present results of all statistical syntheses conducted. If meta-analysis was done, present for each the summary estimate and its precision (e.g. confidence/credible interval) and measures of statistical heterogeneity. If comparing groups, describe the direction of the effect.",
            missing
        ),
        (
            missing,
            "20c",
            "Present results of all investigations of possible causes of heterogeneity among study results.",
            missing
        ),
        (
            missing,
            "20d",
            "Present results of all sensitivity analyses conducted to assess the robustness of the synthesized results.",
            missing
        ),
        (
            "Reporting biases",
            "21",
            "Present assessments of risk of bias due to missing results (arising from reporting biases) for each synthesis assessed.",
            missing
        ),
        (
            "Certainty of evidence",
            "22",
            "Present assessments of certainty (or confidence) in the body of evidence for each outcome assessed.",
            missing
        ),
        (
            "DISCUSSION",
            missing,
            missing,
            missing
        ),
        (
            "Discussion",
            "23a",
            "Provide a general interpretation of the results in the context of other evidence.",
            missing
        ),
        (
            missing,
            "23b",
            "Discuss any limitations of the evidence included in the review.",
            missing),
        (
            missing,
            "23c",
            "Discuss any limitations of the review processes used.",
            missing
        ),
        (
            missing,
            "23d",
            "Discuss implications of the results for practice, policy, and future research.",
            missing
        ),
        (
            "OTHER INFORMATION",
            missing,
            missing,
            missing
        ),
        (
            "Registration and protocol",
            "24a",
            "Provide registration information for the review, including register name and registration number, or state that the review was not registered.",
            missing
        ),
        (
            missing,
            "24b",
            "Indicate where the review protocol can be accessed, or state that a protocol was not prepared.",
            missing
        ),
        (
            missing,
            "24c",
            "Describe and explain any amendments to information provided at registration or in the protocol.",
            missing
        ),
        (
            "Support",
            "25",
            "Describe sources of financial or non-financial support for the review, and the role of the funders or sponsors in the review.",
            missing
        ),
        (
            "Competing interests",
            "26",
            "Identify the report as a systematic review",
            missing
        ),
        (
            "Availability of data, code and other materials",
            "27",
            "Report which of the following are publicly available and where they can be found: template data collection forms; data extracted from included studies; data used for all analyses; analytic code; any other materials used in the review.",
            missing
        )
    ]
    df::DataFrame = DataFrames.DataFrame(rows, names)
    return df
end

"""
    checklist_csv(; save_location::String=Base.pwd(), filename::String="checklist")

Writes the checklist dataframe to a CSV file.

# Arguments
- `save_location::String`: The directory to save the CSV file.
- `filename::String`: The name of the CSV file.

# Returns
- `String`: The path to the CSV file.
"""
function checklist_csv(; 
    save_location::String=Base.pwd(), 
    filename::String="checklist"
)
    df::DataFrame = checklist_df()
    path::String = Base.joinpath(save_location, "$filename.csv")
    CSV.write(path, df)
    return path
end

"""
    checklist_json(; save_location::String=Base.pwd(), filename::String="checklist")

Writes the checklist dataframe to a JSON file.

# Arguments
- `save_location::String`: The directory to save the JSON file.
- `filename::String`: The name of the JSON file.

# Returns
- `String`: The path to the JSON file.
```
"""
function checklist_json(; 
    save_location::String=Base.pwd(), 
    filename::String="checklist"
)
    df::DataFrame = checklist_df()
    path::String = Base.joinpath(save_location, "$filename.json")
    dictionary::OrderedDict = DataStructures.OrderedDict(
        "Section and Topic" => df[!, "Section and Topic"],
        "Item #" => df[!, "Item #"],
        "Checklist Item" => df[!, "Checklist Item"],
        "Location where item is reported" => df[!, "Location where item is reported"]
    )
    JSON3.write(path, dictionary)
    return path
end

"""
    checklist_xlsx(; save_location::String=Base.pwd(), filename::String="checklist", sheetname::String="checklist")

Writes the checklist dataframe to an XLSX file.

# Arguments
- `save_location::String`: The directory to save the XLSX file.
- `filename::String`: The name of the XLSX file.
- `sheetname::String`: The name of the sheet in the XLSX file.

# Returns
- `String`: The path to the XLSX file.
"""
function checklist_xlsx(; 
    save_location::String=Base.pwd(), 
    filename::String="checklist", 
    sheetname::String="checklist"
)
    df::DataFrame = checklist_df()
    path::String = Base.joinpath(save_location, "$filename.xlsx")
    XLSX.writetable(path, sheetname => df)
    return path
end

"""
    checklist_read(; file::String="", excel_sheetname::Union{Nothing,String}=nothing)

Reads the checklist dataframe from a CSV, XLSX, or JSON file.

# Arguments
- `file::String`: The path to the CSV, XLSX, or JSON file.
- `excel_sheetname::Union{Nothing,String}`: The name of the sheet in the XLSX file.

# Returns
- `DataFrame`: The checklist dataframe.
"""
function checklist_read(; 
    file::String="", 
    excel_sheetname::Union{Nothing,String}=nothing
)
    ext::String = Base.lowercase(Base.splitext(file)[2])
    if ext == ".csv"
        df = CSV.read(file, DataFrame)
        Base.println("DataFrame successfully read from $file")
    elseif ext == ".xlsx"
        if Base.isnothing(excel_sheetname)
            df = XLSX.readtable(file, "checklist") |> DataFrame
        else
            df = XLSX.readtable(file, excel_sheetname) |> DataFrame
        end
        Base.println("DataFrame successfully read from $file")
    elseif ext == ".json"
        df = JSON3.read(file) |> DataFrame
        Base.println("DataFrame successfully read from $file")
    else
        Base.throw(Base.ArgumentError("Unsupported file format: $ext"))
    end
    return df
end

"""
    
"""
struct Checklist
end

"""
    checklist(df::DataFrame=checklist_df(); plot::Bool=false, save::Bool=false, save_location::String=Base.pwd(), save_format::String="html", filename::String="checklist")

Writes the checklist dataframe to an HTML table.

# Arguments
- `df::DataFrame`: The dataframe to write.
- `plot::Bool`: Whether to plot the checklist. Default is `false`.
- `save::Bool`: Whether to save the checklist. Default is `false`.
- `save_location::String`: The directory to save the HTML file. Default is the current working directory.
- `save_format::String`: The format to save the HTML file. Default is "html".
- `filename::String`: The name of the HTML file. Default is "checklist".

# Returns
- `String`: The HTML table.
"""
function checklist(df::DataFrame=checklist_df();
    plot::Bool=false,
    save::Bool=false,
    save_location::String=Base.pwd(),
    save_format::String="html",
    filename::String="checklist"
)
    nrows, ncols = Base.size(df)

    html_table = "<table>\n"
    html_table *= "<tr>"

    for col in Base.names(df)
        html_table *= "<th>$col</th>"
    end
    html_table *= "</tr>\n"

    for i in 1:nrows
        html_table *= "<tr>"
        for j in 1:ncols
            html_table *= "<td>$(df[i, j])</td>"
        end
        html_table *= "</tr>\n"
    end

    html_table *= "</table>"

    if plot == true
        checklist_plot(html_table)
    end

    if save == true
        checklist_save(
            html_table=html_table,
            name=filename,
            save_location=save_location,
            save_format=save_format
        )
    end

    return html_table
end

"""
    checklist_plot(html_table::String=checklist())

Plots the checklist dataframe in a web browser.

# Arguments
- `html_table::String=checklist()`: The HTML table to plot.

# Returns
- `Void`: Nothing.
"""
function checklist_plot(html_table::String=checklist())
    tmpfile = Base.tempname() * ".html"
    Base.open(tmpfile, "w") do file
        Base.write(file, "<!DOCTYPE html>\n")
        Base.write(file, "<html>\n")
        Base.write(file, "<head><title>PRISMA 2020 Checklist</title></head>\n")
        Base.write(file, "<body>\n")
        Base.write(file, html_table)
        Base.write(file, "</body>\n")
        Base.write(file, "</html>\n")
    end

    Base.run(`open $tmpfile`)
end

"""
    checklist_save(; html_table::String=checklist(), name::String="checklist", save_location::String=Base.pwd(), save_format::String="html")

Saves the checklist dataframe to an HTML file.

# Arguments
- `html_table::String=checklist()`: The HTML table to save.
- `name::String="checklist"`: The name of the HTML file.
- `save_location::String=Base.pwd()`: The directory to save the HTML file.
- `save_format::String="html"`: The format to save the HTML file.
"""
function checklist_save(;
    html_table::String=checklist(),
    name::String="checklist",
    save_location::String=Base.pwd(),
    save_format::String="html"
)
    Base.open(Base.joinpath(save_location, "$name.$save_format"), "w") do file
        Base.write(file, html_table)
    end
end