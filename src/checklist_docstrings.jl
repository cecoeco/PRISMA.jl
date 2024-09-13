const docstring_Checklist::String = 
"""
    PRISMA.Checklist

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

const docstring_checklist::String = 
"""
    PRISMA.checklist(paper::AbstractString)::Checklist
    PRISMA.checklist(bytes::Vector{UInt8})::Checklist

Returns a completed PRISMA checklist as the type `Checklist`. The `Checklist`
type includes a completed checklist as a `DataFrame` and the metadata of the
paper as a `OrderedDict`. The `paper` argument can be a path to a pdf file or
an array of bytes. This function uses the C++ library `Poppler` via `Poppler_jll`
to parse the pdf and the natural language processing functionality in Julia via
[`Transformers.jl`](https://github.com/chengchingwen/Transformers.jl) to 
find items from the checklist in the paper and populate the 
`Comments or location in manuscript` and `Yes/No/NA` columns in the `DataFrame` 
from `checklist_df()`.

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
- `bytes::Vector{UInt8}`: the pdf data as an array of bytes

## Returns

- `Checklist`: a completed checklist with the paper's metadata

"""

const docstring_checklist_df::String = 
"""
    PRISMA.checklist_df()::DataFrame

returns a template PRISMA checklist as a `DataFrame`

## Returns

- `DataFrame`: the template dataframe

## Example

```jldoctest
julia> using PRISMA

julia> println(checklist_df())
49×4 DataFrame
 Row │ Section and Topic                  Item #  Checklist Item                     Location where item is reported 
     │ String                             String  String                             String                          
─────┼───────────────────────────────────────────────────────────────────────────────────────────────────────────────
   1 │ TITLE
   2 │ Title                              1       Identify the report as a systema…
   3 │ ABSTRACT
   4 │ Abstract                           2       See the PRISMA 2020 for Abstract…
   5 │ INTRODUCTION
   6 │ Rationale                          3       Describe the rationale for the r…
   7 │ Objectives                         4       Provide an explicit statement of…
   8 │ METHODS
   9 │ Eligibility criteria               5       Specify the inclusion and exclus…
  10 │ Information sources                6       Specify all databases, registers…
  11 │ Search strategy                    7       Present the full search strategi…
  12 │ Selection process                  8       Specify the methods used to deci…
  13 │ Data collection process            9       Specify the methods used to coll…
  14 │ Data items                         10a     List and define all outcomes for…
  15 │                                    10b     List and define all other variab…
  16 │ Study risk of bias assessment      11      Specify the methods used to asse…
  17 │ Effect measures                    12      Specify for each outcome the eff…
  18 │ Synthesis methods                  13a     Describe the processes used to d…
  19 │                                    13b     Describe any methods required to…
  20 │                                    13c     Describe any methods used to tab…
  21 │                                    13d     Describe any methods used to syn…
  22 │                                    13e     Describe any methods used to exp…
  23 │                                    13f     Describe any sensitivity analyse…
  24 │ Reporting bias assessment          14      Describe any methods used to ass…
  25 │ Certainty assessment               15      Describe any methods used to ass…
  26 │ RESULTS
  27 │ Study selection                    16a     Describe the results of the sear…
  28 │                                    16b     Cite studies that might appear t…
  29 │ Study characteristics              17      Cite each included study and pre…
  30 │ Risk of bias in studies            18      Present assessments of risk of b…
  31 │ Results of individual studies      19      For all outcomes, present, for e…
  32 │ Results of syntheses               20a     For each synthesis, briefly summ…
  33 │                                    20b     Present results of all statistic…
  34 │                                    20c     Present results of all investiga…
  35 │                                    20d     Present results of all sensitivi…
  36 │ Reporting biases                   21      Present assessments of risk of b…
  37 │ Certainty of evidence              22      Present assessments of certainty…
  38 │ DISCUSSION
  39 │ Discussion                         23a     Provide a general interpretation…
  40 │                                    23b     Discuss any limitations of the e…
  41 │                                    23c     Discuss any limitations of the r…
  42 │                                    23d     Discuss implications of the resu…
  43 │ OTHER INFORMATION
  44 │ Registration and protocol          24a     Provide registration information…
  45 │                                    24b     Indicate where the review protoc…
  46 │                                    24c     Describe and explain any amendme…
  47 │ Support                            25      Describe sources of financial or…
  48 │ Competing interests                26      Identify the report as a systema…
  49 │ Availability of data, code and o…  27      Report which of the following ar…

```

"""

const docstring_checklist_read::String = 
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

julia> println(checklist_read("checklist.csv"))
49×4 DataFrame
 Row │ Section and Topic                  Item #  Checklist Item                     Location where item is reported 
     │ String                             String  String                             String                          
─────┼───────────────────────────────────────────────────────────────────────────────────────────────────────────────
   1 │ TITLE
   2 │ Title                              1       Identify the report as a systema…
   3 │ ABSTRACT
   4 │ Abstract                           2       See the PRISMA 2020 for Abstract…
   5 │ INTRODUCTION
   6 │ Rationale                          3       Describe the rationale for the r…
   7 │ Objectives                         4       Provide an explicit statement of…
   8 │ METHODS
   9 │ Eligibility criteria               5       Specify the inclusion and exclus…
  10 │ Information sources                6       Specify all databases, registers…
  11 │ Search strategy                    7       Present the full search strategi…
  12 │ Selection process                  8       Specify the methods used to deci…
  13 │ Data collection process            9       Specify the methods used to coll…
  14 │ Data items                         10a     List and define all outcomes for…
  15 │                                    10b     List and define all other variab…
  16 │ Study risk of bias assessment      11      Specify the methods used to asse…
  17 │ Effect measures                    12      Specify for each outcome the eff…
  18 │ Synthesis methods                  13a     Describe the processes used to d…
  19 │                                    13b     Describe any methods required to…
  20 │                                    13c     Describe any methods used to tab…
  21 │                                    13d     Describe any methods used to syn…
  22 │                                    13e     Describe any methods used to exp…
  23 │                                    13f     Describe any sensitivity analyse…
  24 │ Reporting bias assessment          14      Describe any methods used to ass…
  25 │ Certainty assessment               15      Describe any methods used to ass…
  26 │ RESULTS
  27 │ Study selection                    16a     Describe the results of the sear…
  28 │                                    16b     Cite studies that might appear t…
  29 │ Study characteristics              17      Cite each included study and pre…
  30 │ Risk of bias in studies            18      Present assessments of risk of b…
  31 │ Results of individual studies      19      For all outcomes, present, for e…
  32 │ Results of syntheses               20a     For each synthesis, briefly summ…
  33 │                                    20b     Present results of all statistic…
  34 │                                    20c     Present results of all investiga…
  35 │                                    20d     Present results of all sensitivi…
  36 │ Reporting biases                   21      Present assessments of risk of b…
  37 │ Certainty of evidence              22      Present assessments of certainty…
  38 │ DISCUSSION
  39 │ Discussion                         23a     Provide a general interpretation…
  40 │                                    23b     Discuss any limitations of the e…
  41 │                                    23c     Discuss any limitations of the r…
  42 │                                    23d     Discuss implications of the resu…
  43 │ OTHER INFORMATION
  44 │ Registration and protocol          24a     Provide registration information…
  45 │                                    24b     Indicate where the review protoc…
  46 │                                    24c     Describe and explain any amendme…
  47 │ Support                            25      Describe sources of financial or…
  48 │ Competing interests                26      Identify the report as a systema…
  49 │ Availability of data, code and o…  27      Report which of the following ar…

```

"""

const docstring_checklist_template::String = 
"""
    checklist_template(fn::AbstractString="checklist.csv")

saves a template checklist `DataFrame` as a CSV.

## Arguments

- `fn::AbstractString`: the name of the file to save

## Example

```jldoctest
julia> using PRISMA

julia> checklist_template()
"checklist.csv"
```

"""

const docstring_checklist_save::String = 
"""
    checklist_save(fn::AbstractString, cl::Checklist)

saves a `Checklist` as a CSV.

## Arguments

- `fn::AbstractString`: the name of the file to save
- `cl::Checklist`: the checklist to save

"""
