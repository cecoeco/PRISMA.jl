"""
    PRISMA.checklist_df()::DataFrame

Returns a template PRISMA checklist as a `DataFrame`

You can export the `DataFrame` to an Excel spreadsheet or CSV file and edit 
the checklist using a spreadsheet program. You can also edit the `DataFrame` 
directly in a Julia program using the DataFrames.jl package. 

## Examples

```julia
using PRISMA, CSV

CSV.write("checklist.csv", checklist_df())

using PRISMA, XLSX

XLSX.writetable("checklist.xlsx", "PRISMA Checklist" => checklist_df())

using PRISMA, DataFrames

df = checklist_df()
df[3, "Location where item is reported"] = "Sysemtatic review is in the title."
df[3, "Location where item is reported"] = "The completed abastract is located on page one."
```

Additionally, the `checklist()` function uses `checklist_df()` as a template 
but takes a paper in PDF format, parses it using natural language processing 
via [`Flux.jl`](https://github.com/FluxML/Flux.jl) and 
[`Transformers.jl`](https://github.com/chengchingwen/Transformers.jl), and returns a 
completed checklist along with the paper's metadata, represented by the type `Checklist`.

"""
function checklist_df()::DataFrame
    cols::Vector{String} = ["Section and Topic", "Item #", "Checklist Item", "Location where item is reported"]
    rows::Vector{Tuple{String,String,String,String}} = [
        ("TITLE", "", "", ""),
        ("Title", "1", "Identify the report as a systematic review", ""),
        ("ABSTRACT", "", "", ""),
        ("Abstract", "2", "See the PRISMA 2020 for Abstracts checklist", ""),
        ("INTRODUCTION", "", "", ""),
        ("Rationale", "3", "Describe the rationale for the review in the context of existing knowledge.", ""),
        ("Objectives", "4", "Provide an explicit statement of the objective(s) or question(s) the review addresses.", ""),
        ("METHODS", "", "", ""),
        ("Eligibility criteria", "5", "Specify the inclusion and exclusion criteria for the review and how studies were grouped for the syntheses.", ""),
        ("Information sources", "6", "Specify all databases, registers, websites, organisations, reference lists and other sources searched or consulted to identify studies. Specify the date when each source was last searched or consulted.", ""),
        ("Search strategy", "7", "Present the full search strategies for all databases, registers and websites, including any filters and limits used.", ""),
        ("Selection process", "8", "Specify the methods used to decide whether a study met the inclusion criteria of the review, including how many reviewers screened each record and each report retrieved, whether they worked independently, and if applicable, details of automation tools used in the process.", ""),
        ("Data collection process", "9", "Specify the methods used to collect data from reports, including how many reviewers collected data from each report, whether they worked independently, any processes for obtaining or confirming data from study investigators, and if applicable, details of automation tools used in the process.", ""),
        ("Data items", "10a", "List and define all outcomes for which data were sought. Specify whether all results that were compatible with each outcome domain in each study were sought (e.g. for all measures, time points, analyses), and if not, the methods used to decide which results to collect.", ""),
        ("", "10b", "List and define all other variables for which data were sought (e.g. participant and intervention characteristics, funding sources). Describe any assumptions made about any missing or unclear information.", ""),
        ("Study risk of bias assessment", "11", "Specify the methods used to assess risk of bias in the included studies, including details of the tool(s) used, how many reviewers assessed each study and whether they worked independently, and if applicable, details of automation tools used in the process.", ""),
        ("Effect measures", "12", "Specify for each outcome the effect measure(s) (e.g. risk ratio, mean difference) used in the synthesis or presentation of results.", ""),
        ("Synthesis methods", "13a", "Describe the processes used to decide which studies were eligible for each synthesis (e.g. tabulating the study intervention characteristics and comparing against the planned groups for each synthesis (item #5)).", ""),
        ("", "13b", "Describe any methods required to prepare the data for presentation or synthesis, such as handling of missing summary statistics, or data conversions.", ""),
        ("", "13c", "Describe any methods used to tabulate or visually display results of individual studies and syntheses.", ""),
        ("", "13d", "Describe any methods used to synthesize results and provide a rationale for the choice(s). If meta-analysis was performed, describe the model(s), method(s) to identify the presence and extent of statistical heterogeneity, and software package(s) used.", ""),
        ("", "13e", "Describe any methods used to explore possible causes of heterogeneity among study results (e.g. subgroup analysis, meta-regression).", ""),
        ("", "13f", "Describe any sensitivity analyses conducted to assess robustness of the synthesized results.", ""),
        ("Reporting bias assessment", "14", "Describe any methods used to assess risk of bias due to missing results in a synthesis (arising from reporting biases).", ""),
        ("Certainty assessment", "15", "Describe any methods used to assess certainty (or confidence) in the body of evidence for an outcome.", ""),
        ("RESULTS", "", "", ""),
        ("Study selection", "16a", "Describe the results of the search and selection process, from the number of records identified in the search to the number of studies included in the review, ideally using a flow diagram.", ""),
        ("", "16b", "Cite studies that might appear to meet the inclusion criteria, but which were excluded, and explain why they were excluded.", ""),
        ("Study characteristics", "17", "Cite each included study and present its characteristics.", ""),
        ("Risk of bias in studies", "18", "Present assessments of risk of bias for each included study.", ""),
        ("Results of individual studies", "19", "For all outcomes, present, for each study: (a) summary statistics for each group (where appropriate) and (b) an effect estimate and its precision (e.g. confidence/credible interval), ideally using structured tables or plots.", ""),
        ("Results of syntheses", "20a", "For each synthesis, briefly summarise the characteristics and risk of bias among contributing studies.", ""),
        ("", "20b", "Present results of all statistical syntheses conducted. If meta-analysis was done, present for each the summary estimate and its precision (e.g. confidence/credible interval) and measures of statistical heterogeneity. If comparing groups, describe the direction of the effect.", ""),
        ("", "20c", "Present results of all investigations of possible causes of heterogeneity among study results.", ""),
        ("", "20d", "Present results of all sensitivity analyses conducted to assess the robustness of the synthesized results.", ""),
        ("Reporting biases", "21", "Present assessments of risk of bias due to missing results (arising from reporting biases) for each synthesis assessed.", ""),
        ("Certainty of evidence", "22", "Present assessments of certainty (or confidence) in the body of evidence for each outcome assessed.", ""),
        ("DISCUSSION", "", "", ""),
        ("Discussion", "23a", "Provide a general interpretation of the results in the context of other evidence.", ""),
        ("", "23b", "Discuss any limitations of the evidence included in the review.", ""),
        ("", "23c", "Discuss any limitations of the review processes used.", ""),
        ("", "23d", "Discuss implications of the results for practice, policy, and future research.", ""),
        ("OTHER INFORMATION", "", "", ""),
        ("Registration and protocol", "24a", "Provide registration information for the review, including register name and registration number, or state that the review was not registered.", ""),
        ("", "24b", "Indicate where the review protocol can be accessed, or state that a protocol was not prepared.", ""),
        ("", "24c", "Describe and explain any amendments to information provided at registration or in the protocol.", ""),
        ("Support", "25", "Describe sources of financial or non-financial support for the review, and the role of the funders or sponsors in the review.", ""),
        ("Competing interests", "26", "Identify the report as a systematic review", ""),
        ("Availability of data, code and other materials", "27", "Report which of the following are publicly available and where they can be found: template data collection forms; data extracted from included studies; data used for all analyses; analytic code; any other materials used in the review.", "")
    ]
    return DataFrame(rows, cols)
end

"""
    PRISMA.Checklist

This types represents a PRISMA checklist in the form of a `DataFrame` and
the metadata of the paper that was used to generate it as a `LittleDict` or
an small ordered dictionary withs keys and values.

## Keyword Arguments

- `df::DataFrame`: the checklist as a `DataFrame`
- `metadata::LittleDict`: the metadata of the paper

"""
@kwdef mutable struct Checklist
    df::DataFrame = checklist_df()
    metadata::LittleDict = LittleDict()
end

function safe_match(pattern::Regex, text::AbstractString)::String
    m::Union{Nothing,RegexMatch} = match(pattern, text)

    if isnothing(m)
        return ""
    else
        return m.captures[1]
    end
end

function fillchecklist(paper::AbstractString)::DataFrame
    textencoder, bert_model = hgf"bert-base-uncased"
    results::DataFrame = deepcopy(checklist_df())

    for (i, row) in enumerate(eachrow(results))
        number::String = row["Item #"]
        recommendation::String = row["Checklist Item"]

        if occursin(r"^\d", number) && !isempty(recommendation)
            encoded_text = encode(textencoder, [[recommendation]])
            text_embedding = mean(bert_model(encoded_text).hidden_state, dims=2)

            paragraphs::Vector{String} = split(paper, r"\n\n")

            best_similarity::Float64 = 0.0
            best_snippet::String = ""

            for paragraph in paragraphs
                paragraph_sample = encode(textencoder, [[paragraph]])
                paragraph_embedding = mean(bert_model(paragraph_sample).hidden_state, dims=2)

                similarity::Float64 = dot(text_embedding, paragraph_embedding) / (norm(text_embedding) * norm(paragraph_embedding))

                if similarity > 0.4
                    best_similarity = similarity
                    best_snippet = paragraph
                    break
                end
            end

            if best_similarity > 0.4
                row["Location where item is reported"] = best_snippet
            else
                row["Location where item is reported"] = ""
            end
        end

        println("processed item $i of $(nrow(results))")
    end

    return results
end

"""
    PRISMA.checklist(paper::AbstractString)::Checklist
    PRISMA.checklist(bytes::Vector{UInt8})::Checklist

Returns a completed PRISMA checklist as the type `Checklist`. The `Checklist`
type includes a completed checklist as a `DataFrame` and the metadata of the
paper as a `LittleDict`. The `paper` argument can be a path to a pdf file or
an array of bytes. This function uses the C++ library `Poppler` via `Poppler_jll`
to parse the pdf and the natural language processing functionality in Julia via
[`Flux.jl`](https://github.com/FluxML/Flux.jl) and
[`Transformers.jl`](https://github.com/chengchingwen/Transformers.jl) to 
find items from the checklist in the paper and populate the 
`Comments or location in manuscript` and `Yes/No/NA` columns in the `DataFrame` 
from `checklist_df()`.

The following metadata is parsed from the pdf file and stored in the `LittleDict` as:

- `"title"`: the title of the paper
- `"subject"`: the subject of the paper
- `"author"`: the author of the paper
- `"creator"`: the creator of the paper
- `"producer"`: the producer of the paper
- `"creation date"`: the date the paper was created
- `"modification date"`: the date the paper was last modified
- `"pages"`: the number of pages in the paper
- `"paper size"`: the size of the paper
- `"paper rotation"`: the rotation of the paper
- `"file size"`: the size of the pdf file
- `"optimized"`: whether the pdf was optimized
- `"pdf version"`: the version of the pdf

All keys and values in the dictionary ar eof type `String`.
If the parsing fails the value will be an empty string.

## Arguments

- `paper::AbstractString`: a path to a pdf file as a string
- `bytes::Vector{UInt8}`: the pdf data as an array of bytes

## Returns

- `Checklist`: a completed checklist with paper metadata

## Examples

Export a completed checklist to an Microsoft® Excel spreadsheet using the `XLSX` package.

```julia
using PRISMA, XLSX

clist = checklist("manuscript.pdf")

XLSX.writetable("checklist.xlsx", "PRISMA Checklist" => clist.df)
```

Export a completed checklist as a CSV file using the `CSV` package.

```julia
using PRISMA, CSV

clist = checklist("manuscript.pdf")

CSV.write("checklist.csv", clist.df)
```

It is also possible to view the completed checklist directly 
in a Julia program and using the `DataFrames.jl` package to 
edit the `DataFrame` directly to add values that the fubction 
could not find or to add new items or quick edits.

```julia
using PRISMA, DataFrames

clist = checklist("manuscript.pdf")

println(clist.df)

clist.df[02, "Yes/No/NA"] = "Yes"
clist.df[09, "Yes/No/NA"] = "Yes"
clist.df[10, "Yes/No/NA"] = "Yes"

```

"""
function checklist(paper::AbstractString)::Checklist
    paper_info::String = Base.read(`$(pdfinfo()) $paper`, String)
    paper_text::String = Base.read(`$(pdftotext()) $paper -`, String)

    metadata::LittleDict{String,String} = LittleDict(
        "title" =>             safe_match(r"Title:\s*(.*)",        paper_info),
        "subject" =>           safe_match(r"Subject:\s*(.*)",      paper_info),
        "author" =>            safe_match(r"Author:\s*(.*)",       paper_info),
        "creator" =>           safe_match(r"Creator:\s*(.*)",      paper_info),
        "producer" =>          safe_match(r"Producer:\s*(.*)",     paper_info),
        "creation date" =>     safe_match(r"CreationDate:\s*(.*)", paper_info),
        "modification date" => safe_match(r"ModDate:\s*(.*)",      paper_info),
        "pages" =>             safe_match(r"Pages:\s*(\d+)",       paper_info),
        "paper size" =>        safe_match(r"Page size:\s*(.*)",    paper_info),
        "paper rotation" =>    safe_match(r"Page rot:\s*(.*)",     paper_info),
        "file size" =>         safe_match(r"File size:\s*(.*)",    paper_info),
        "optimized" =>         safe_match(r"Optimized:\s*(.*)",    paper_info),
        "pdf version" =>       safe_match(r"PDF version:\s*(.*)",  paper_info)
    )

    return Checklist(df=fillchecklist(paper_text), metadata=metadata)
end

function checklist(bytes::Vector{UInt8})::Checklist
    paper::String = tempname() * ".pdf"
    Base.Filesystem.write(paper, bytes)

    try
        return checklist(paper)
    catch e
        rethrow(e)
    finally
        rm(paper, force=true)
    end
end

"""
    checklist_save(fn::AbstractString, cl::Checklist; overwrite::Bool=false, kwargs...)::String

saves as either `Checklist` a JSON, CSV, XLSX, or HTML.

## Arguments

- `fn::AbstractString`: the name of the file to save
- `cl::Checklist`: the checklist to save
- `overwrite::Bool`: whether to overwrite the file if it already exists
- `kwargs...`: additional arguments to be passed to the underlying 
`CSV.write`, `XLSX.writetable`, `HTMLTables.write`, and `JSON3.write` functions

## Returns

- `String`: the path to the saved file

## Examples

```julia
using PRISMA: Checklist, checklist, checklist_save

clist::Checklist = checklist("manuscript.pdf")

checklist_save("checklist.csv", clist)
checklist_save("checklist.xlsx", clist)
checklist_save("checklist.json", clist)
checklist_save("checklist.html", clist)
```

"""
function checklist_save(
    fn::AbstractString,
    cl::Checklist;
    sheetname::AbstractString="PRISMA Checklist",
    overwrite::Bool=false,
    kwargs...)::String

    check_overwrite(fn, overwrite)

    return save_dataframe(fn, cl.df, sheetname; kwargs...)
end

"""
    checklist_save(fn::AbstractString, cl::Checklist; overwrite::Bool=false, kwargs...)::String

saves as either `Checklist` a JSON, CSV, XLSX, or HTML.

## Arguments

- `fn::AbstractString`: the name of the file to save
- `df::DataFrame=checklist_df()`: the dataframe to save
- `overwrite::Bool`: whether to overwrite the file if it already exists
- `kwargs...`: additional arguments to be passed to the underlying 
`CSV.write`, `XLSX.writetable`, `HTMLTables.write`, and `JSON3.write` functions

## Returns

- `String`: the path to the saved file

## Examples

```julia
using PRISMA: checklist, checklist_save
using DataFrames: DataFrame

df::DataFrame = checklist_df()

checklist_save("checklist.csv", df)
checklist_save("checklist.xlsx", df)
checklist_save("checklist.json", df)
checklist_save("checklist.html", df)

```

"""
function checklist_save(
    fn::AbstractString,
    df::DataFrame=checklist_df();
    sheetname::AbstractString="PRISMA Checklist",
    overwrite::Bool=false,
    kwargs...)::String

    check_overwrite(fn, overwrite)

    return save_dataframe(fn, df, sheetname; kwargs...)
end
