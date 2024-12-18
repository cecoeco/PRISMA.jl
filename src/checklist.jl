"""
    checklist_dataframe()::DataFrame

returns a template PRISMA checklist as a `DataFrame`

## Returns

- `DataFrame`: the template dataframe

## Example

```jldoctest
julia> using PRISMA

julia> isa(checklist_dataframe(), DataFrame)
true
```

"""
function checklist_dataframe()::DataFrame
    cols::Vector{String} = [
        "Section and Topic",
        "Item #",
        "Checklist Item",
        "Location where item is reported"
    ]
    rows::Vector{Tuple{String,String,String,String}} = [
        (
            "TITLE",
            "",
            "",
            ""
        ),
        (
            "Title",
            "1",
            "Identify the report as a systematic review.",
            ""
        ),
        (
            "ABSTRACT",
            "",
            "",
            ""
        ),
        (
            "Abstract",
            "2",
            "See the PRISMA 2020 for Abstracts checklist",
            ""
        ),
        (
            "INTRODUCTION",
            "",
            "",
            ""
        ),
        (
            "Rationale",
            "3",
            "Describe the rationale for the review in the context of existing knowledge.",
            ""
        ),
        (
            "Objectives",
            "4",
            "Provide an explicit statement of the objective(s) or question(s) the review addresses.",
            ""
        ),
        (
            "METHODS",
            "",
            "",
            ""
        ),
        (
            "Eligibility criteria",
            "5",
            "Specify the inclusion and exclusion criteria for the review and how studies were grouped for the syntheses.",
            ""
        ),
        (
            "Information sources",
            "6",
            "Specify all databases, registers, websites, organisations, reference lists and other sources searched or consulted to identify studies. Specify the date when each source was last searched or consulted.",
            ""
        ),
        (
            "Search strategy",
            "7",
            "Present the full search strategies for all databases, registers and websites, including any filters and limits used.",
            ""
        ),
        (
            "Selection process",
            "8",
            "Specify the methods used to decide whether a study met the inclusion criteria of the review, including how many reviewers screened each record and each report retrieved, whether they worked independently, and if applicable, details of automation tools used in the process.",
            ""
        ),
        (
            "Data collection process",
            "9",
            "Specify the methods used to collect data from reports, including how many reviewers collected data from each report, whether they worked independently, any processes for obtaining or confirming data from study investigators, and if applicable, details of automation tools used in the process.",
            ""
        ),
        (
            "Data items",
            "10a",
            "List and define all outcomes for which data were sought. Specify whether all results that were compatible with each outcome domain in each study were sought (e.g. for all measures, time points, analyses), and if not, the methods used to decide which results to collect.",
            ""
        ),
        (
            "",
            "10b",
            "List and define all other variables for which data were sought (e.g. participant and intervention characteristics, funding sources). Describe any assumptions made about any missing or unclear information.",
            ""
        ),
        (
            "Study risk of bias assessment",
            "11",
            "Specify the methods used to assess risk of bias in the included studies, including details of the tool(s) used, how many reviewers assessed each study and whether they worked independently, and if applicable, details of automation tools used in the process.",
            ""
        ),
        (
            "Effect measures",
            "12",
            "Specify for each outcome the effect measure(s) (e.g. risk ratio, mean difference) used in the synthesis or presentation of results.",
            ""
        ),
        (
            "Synthesis methods",
            "13a",
            "Describe the processes used to decide which studies were eligible for each synthesis (e.g. tabulating the study intervention characteristics and comparing against the planned groups for each synthesis (item #5)).",
            ""
        ),
        (
            "",
            "13b",
            "Describe any methods required to prepare the data for presentation or synthesis, such as handling of missing summary statistics, or data conversions.",
            ""
        ),
        (
            "",
            "13c",
            "Describe any methods used to tabulate or visually display results of individual studies and syntheses.",
            ""
        ),
        (
            "",
            "13d",
            "Describe any methods used to synthesize results and provide a rationale for the choice(s). If meta-analysis was performed, describe the model(s), method(s) to identify the presence and extent of statistical heterogeneity, and software package(s) used.",
            ""
        ),
        (
            "",
            "13e",
            "Describe any methods used to explore possible causes of heterogeneity among study results (e.g. subgroup analysis, meta-regression).",
            ""
        ),
        (
            "",
            "13f",
            "Describe any sensitivity analyses conducted to assess robustness of the synthesized results.",
            ""
        ),
        (
            "Reporting bias assessment",
            "14",
            "Describe any methods used to assess risk of bias due to missing results in a synthesis (arising from reporting biases).",
            ""
        ),
        (
            "Certainty assessment",
            "15",
            "Describe any methods used to assess certainty (or confidence) in the body of evidence for an outcome.",
            ""
        ),
        (
            "RESULTS",
            "",
            "",
            ""
        ),
        (
            "Study selection",
            "16a",
            "Describe the results of the search and selection process, from the number of records identified in the search to the number of studies included in the review, ideally using a flow diagram.",
            ""
        ),
        (
            "",
            "16b",
            "Cite studies that might appear to meet the inclusion criteria, but which were excluded, and explain why they were excluded.",
            ""
        ),
        (
            "Study characteristics",
            "17",
            "Cite each included study and present its characteristics.",
            ""
        ),
        (
            "Risk of bias in studies",
            "18",
            "Present assessments of risk of bias for each included study.",
            ""
        ),
        (
            "Results of individual studies",
            "19",
            "For all outcomes, present, for each study: (a) summary statistics for each group (where appropriate) and (b) an effect estimate and its precision (e.g. confidence/credible interval), ideally using structured tables or plots.",
            ""
        ),
        (
            "Results of syntheses",
            "20a",
            "For each synthesis, briefly summarise the characteristics and risk of bias among contributing studies.",
            ""
        ),
        (
            "",
            "20b",
            "Present results of all statistical syntheses conducted. If meta-analysis was done, present for each the summary estimate and its precision (e.g. confidence/credible interval) and measures of statistical heterogeneity. If comparing groups, describe the direction of the effect.",
            ""
        ),
        (
            "",
            "20c",
            "Present results of all investigations of possible causes of heterogeneity among study results.",
            ""
        ),
        (
            "",
            "20d",
            "Present results of all sensitivity analyses conducted to assess the robustness of the synthesized results.",
            ""
        ),
        (
            "Reporting biases",
            "21",
            "Present assessments of risk of bias due to missing results (arising from reporting biases) for each synthesis assessed.", ""
        ),
        (
            "Certainty of evidence",
            "22",
            "Present assessments of certainty (or confidence) in the body of evidence for each outcome assessed.",
            ""
        ),
        (
            "DISCUSSION",
            "",
            "",
            ""
        ),
        (
            "Discussion",
            "23a",
            "Provide a general interpretation of the results in the context of other evidence.",
            ""
        ),
        (
            "",
            "23b",
            "Discuss any limitations of the evidence included in the review.",
            ""
        ),
        (
            "",
            "23c",
            "Discuss any limitations of the review processes used.",
            ""
        ),
        (
            "",
            "23d",
            "Discuss implications of the results for practice, policy, and future research.",
            ""
        ),
        (
            "OTHER INFORMATION",
            "",
            "",
            ""
        ),
        (
            "Registration and protocol",
            "24a",
            "Provide registration information for the review, including register name and registration number, or state that the review was not registered.",
            ""
        ),
        (
            "",
            "24b",
            "Indicate where the review protocol can be accessed, or state that a protocol was not prepared.",
            ""
        ),
        (
            "",
            "24c",
            "Describe and explain any amendments to information provided at registration or in the protocol.",
            ""
        ),
        (
            "Support",
            "25",
            "Describe sources of financial or non-financial support for the review, and the role of the funders or sponsors in the review.",
            ""
        ),
        (
            "Competing interests",
            "26",
            "Identify the report as a systematic review.",
            ""
        ),
        (
            "Availability of data, code and other materials",
            "27",
            "Report which of the following are publicly available and where they can be found: template data collection forms; data extracted from included studies; data used for all analyses; analytic code; any other materials used in the review.",
            ""
        )
    ]
    return DataFrame(rows, cols)
end

"""
    Checklist(dataframe::DataFrame=checklist_dataframe(), metadata::OrderedDict=OrderedDict())

this types represents a PRISMA checklist in the form of a `DataFrame` and
the metadata of the paper that was used to generate it as a `OrderedDict`.

## Fields

- `dataframe::DataFrame`: the checklist as a `DataFrame`
- `metadata::OrderedDict`: the metadata of the paper

## Example

```julia
using PRISMA

cl::Checklist = checklist("paper.pdf")

title = cl.metadata["title"]
println(title)

pages = cl.metadata["pages"]
println(pages)
```

"""
@kwdef mutable struct Checklist
    dataframe::DataFrame = checklist_dataframe()
    metadata::OrderedDict = OrderedDict()
end

function safe_match(pattern::Regex, text::AbstractString)::String
    mtc::Union{Nothing,RegexMatch} = Base.match(pattern, text)

    if Base.isnothing(mtc)
        return ""
    else
        return mtc.captures[1]
    end
end

function complete_metadata(paper::AbstractString)::OrderedDict{String,String}
    paper_info::String = Base.read(`$(Poppler_jll.pdfinfo()) $paper`, String)

    return OrderedDict{String,String}(
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
end

function create_questions()::OrderedDict{String,String}
    questions::OrderedDict{String,String} = OrderedDict{String,String}()

    for row in Base.eachrow(checklist_dataframe())
        if Base.isempty(row["Item #"])
            continue
        end

        if row["Checklist Item"] == "See the PRISMA 2020 for Abstracts checklist"
            continue
        end

        questions[row["Item #"]] = "Where does the manuscript " * Base.replace(
            Base.Unicode.lowercasefirst(row["Checklist Item"]),
            r"\.$" => "?"
        )
    end

    return questions
end

function create_prompt(question::AbstractString, paper_text::AbstractString)::String
    return Base.string(question, "\n\n", paper_text)
end

function generate_location(prompt)::String
    return prompt
end

function complete_dataframe(paper::AbstractString)::DataFrame
    paper_text::String = Base.read(`$(Poppler_jll.pdftotext()) $paper -`, String)
    checklist_results::DataFrame = checklist_dataframe()
    item_numbers::Vector{String} = checklist_results[!, "Item #"]
    locations::Vector{String} = Base.fill("", Base.length(item_numbers))
    for (item_number, question) in create_questions()
        if item_number in item_numbers
            index::Union{Nothing,Int} = Base.findfirst(item_numbers .== item_number)
            if !Base.isnothing(index)
                locations[index] = generate_location(create_prompt(question, paper_text))
                if !Base.isempty(locations[index])
                    Base.println("item $item_number was found")
                else
                    Base.println("item $item_number was not found")
                end
            end
        end
    end

    checklist_results[!, "Location where item is reported"] = locations

    return checklist_results
end

"""
    checklist(paper::AbstractString)::Checklist
    checklist(paper::Vector{UInt8})::Checklist

This function returns a completed PRISMA checklist as the type `Checklist`. 
The `Checklist` type includes a completed checklist as a `DataFrame` and the 
metadata of the paper as a `OrderedDict`. The `paper` argument can be a path 
to a pdf file or an array of bytes. This function uses the C++ library `Poppler` 
via `Poppler_jll` to parse the pdf and the natural language processing functionality 
in Julia via [`Transformers.jl`](https://github.com/chengchingwen/Transformers.jl) 
to find items from the checklist in the paper and populate the 
`Comments or location in manuscript` and `Yes/No/NA` columns in the `DataFrame` 
from `checklist_dataframe`.

The following metadata is parsed from the pdf file and stored in the `OrderedDict` as:

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
- `paper::Vector{UInt8}`: the pdf data as an array of bytes

## Returns

- `Checklist`: a completed checklist with the paper's metadata

"""
function checklist(paper::AbstractString)::Checklist
    return Checklist(
        dataframe=complete_dataframe(paper),
        metadata=complete_metadata(paper)
    )
end

function checklist(paper::Vector{UInt8})::Checklist
    temp_pdf::String = Base.Filesystem.tempname()
    Base.Filesystem.write(temp_pdf, paper)
    try
        return checklist(temp_pdf)
    catch ex
        Base.rethrow(ex)
    finally
        Base.Filesystem.rm(temp_pdf, force=true)
    end
end

function Base.show(io::IO, cl::Checklist)::Nothing
    Base.print(io, "$(cl.metadata["title"])")
    Base.print(io, "\n\nMetadata:\n\n")
    Base.print(io, cl.metadata)
    Base.print(io, "\n\n2020 PRISMA Checklist:\n\n")
    Base.print(io, cl.dataframe)

    return nothing
end

function Base.show(io::IO, ::MIME"text/plain", cl::Checklist)::Nothing
    Base.print(io, "$(cl.metadata["title"])")
    Base.print(io, "\n\nMetadata:\n\n")
    Base.print(io, cl.metadata)
    Base.print(io, "\n\n2020 PRISMA Checklist:\n\n")
    Base.print(io, cl.dataframe)

    return nothing
end

function Base.show(io::IO, ::MIME"text/csv", cl::Checklist)::Nothing
    Base.print(io, "$(cl.metadata["title"])")
    Base.print(io, "\n\nMetadata:\n\n")
    Base.print(io, CSV.write(io, DataFrame(cl.metadata)))
    Base.print(io, "\n\n2020 PRISMA Checklist:\n\n")
    Base.print(io, CSV.write(io, cl.dataframe))

    return nothing
end

"""
    checklist_read(fn::AbstractString)::DataFrame

reads the template data to a `DataFrame`

## Arguments

- `fn::AbstractString`: the name of the file to read

## Returns

- `DataFrame`: the template dataframe

## Example

```jldoctest
julia> using PRISMA

julia> checklist_template()
"checklist.csv"

julia> isa(checklist_read("checklist.csv"), DataFrame)
true
```

"""
function checklist_read(fn::AbstractString="checklist.csv")::DataFrame
    return CSV.read(fn, DataFrame)
end

"""
    checklist_save(out::Any, cl::Checklist)
    checklist_save(out::Any, df::DataFrame)

saves a `Checklist` as a CSV.

## Arguments

- `out::Any`: Accepts the same types as [`CSV.write`](https://csv.juliadata.org/stable/writing.html#CSV.write)
- `cl::Checklist`: the checklist to save
- `df::DataFrame`: the dataframe to save

"""
function checklist_save(out::Any, cl::Checklist)
    return CSV.write(out, cl.dataframe)
end

function checklist_save(out::Any, df::DataFrame)
    return CSV.write(out, df)
end

"""
    checklist_template(out::Any="checklist.csv")

saves a template checklist `DataFrame` as a CSV.

## Arguments

- `out::Any`: Accepts the same types as [`CSV.write`](https://csv.juliadata.org/stable/writing.html#CSV.write)

## Example

```jldoctest
julia> using PRISMA

julia> checklist_template()
"checklist.csv"
```

"""
function checklist_template(out::Any="checklist.csv")
    return CSV.write(out, checklist_dataframe())
end
