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

- `Checklist`: a completed checklist with paper metadata

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
julia> println(isa(checklist_df(), DataFrame))
true
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
julia> println(isa(checklist_read("checklist.csv"), DataFrame))
true
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
julia> println(isfile("checklist.csv"))
true
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
