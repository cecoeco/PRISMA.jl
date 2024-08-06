var documenterSearchIndex = {"docs":
[{"location":"checklist/#Checklist","page":"Checklist","title":"Checklist","text":"","category":"section"},{"location":"checklist/","page":"Checklist","title":"Checklist","text":"PRISMA.checklist_df\nPRISMA.checklist\nPRISMA.Checklist","category":"page"},{"location":"checklist/#PRISMA.checklist_df","page":"Checklist","title":"PRISMA.checklist_df","text":"PRISMA.checklist_df()::DataFrame\n\nReturns a template PRISMA checklist as a DataFrame\n\nYou can export the DataFrame to an Excel spreadsheet or CSV file and edit  the checklist using a spreadsheet program. You can also edit the DataFrame  directly in a Julia program using the DataFrames.jl package. \n\nExamples\n\nusing PRISMA, CSV\n\nCSV.write(\"checklist.csv\", checklist_df())\n\nusing PRISMA, XLSX\n\nXLSX.writetable(\"checklist.xlsx\", \"PRISMA Checklist\" => checklist_df())\n\nusing PRISMA, DataFrames\n\ndf = checklist_df()\ndf[3, \"Location where item is reported\"] = \"Sysemtatic review is in the title.\"\ndf[3, \"Location where item is reported\"] = \"The completed abastract is located on page one.\"\n\nAdditionally, the checklist() function uses checklist_df() as a template  but takes a paper in PDF format, parses it using natural language processing  via Flux.jl and  Transformers.jl, and returns a  completed checklist along with the paper's metadata, represented by the type Checklist.\n\n\n\n\n\n","category":"function"},{"location":"checklist/#PRISMA.checklist","page":"Checklist","title":"PRISMA.checklist","text":"PRISMA.checklist(paper::AbstractString)::Checklist\nPRISMA.checklist(bytes::Vector{UInt8})::Checklist\n\nReturns a completed PRISMA checklist as the type Checklist. The Checklist type includes a completed checklist as a DataFrame and the metadata of the paper as a LittleDict. The paper argument can be a path to a pdf file or an array of bytes. This function uses the C++ library Poppler via Poppler_jll to parse the pdf and the natural language processing functionality in Julia via Flux.jl and Transformers.jl to  find items from the checklist in the paper and populate the  Comments or location in manuscript and Yes/No/NA columns in the DataFrame  from checklist_df().\n\nThe following metadata is parsed from the pdf file and stored in the LittleDict as:\n\n\"title\": the title of the paper\n\"subject\": the subject of the paper\n\"author\": the author of the paper\n\"creator\": the creator of the paper\n\"producer\": the producer of the paper\n\"creation date\": the date the paper was created\n\"modification date\": the date the paper was last modified\n\"pages\": the number of pages in the paper\n\"paper size\": the size of the paper\n\"paper rotation\": the rotation of the paper\n\"file size\": the size of the pdf file\n\"optimized\": whether the pdf was optimized\n\"pdf version\": the version of the pdf\n\nAll keys and values in the dictionary ar eof type String. If the parsing fails the value will be an empty string.\n\nArguments\n\npaper::AbstractString: a path to a pdf file as a string\nbytes::Vector{UInt8}: the pdf data as an array of bytes\n\nReturns\n\nChecklist: a completed checklist with paper metadata\n\nExamples\n\nExport a completed checklist to an Microsoft® Excel spreadsheet using the XLSX package.\n\nusing PRISMA, XLSX\n\nclist = checklist(\"manuscript.pdf\")\n\nXLSX.writetable(\"checklist.xlsx\", \"PRISMA Checklist\" => clist.df)\n\nExport a completed checklist as a CSV file using the CSV package.\n\nusing PRISMA, CSV\n\nclist = checklist(\"manuscript.pdf\")\n\nCSV.write(\"checklist.csv\", clist.df)\n\nIt is also possible to view the completed checklist directly  in a Julia program and using the DataFrames.jl package to  edit the DataFrame directly to add values that the fubction  could not find or to add new items or quick edits.\n\nusing PRISMA, DataFrames\n\nclist = checklist(\"manuscript.pdf\")\n\nprintln(clist.df)\n\nclist.df[02, \"Yes/No/NA\"] = \"Yes\"\nclist.df[09, \"Yes/No/NA\"] = \"Yes\"\nclist.df[10, \"Yes/No/NA\"] = \"Yes\"\n\n\n\n\n\n\n","category":"function"},{"location":"checklist/#PRISMA.Checklist","page":"Checklist","title":"PRISMA.Checklist","text":"PRISMA.Checklist\n\nThis types represents a PRISMA checklist in the form of a DataFrame and the metadata of the paper that was used to generate it as a LittleDict or an small ordered dictionary withs keys and values.\n\nKeyword Arguments\n\ndf::DataFrame: the checklist as a DataFrame\nmetadata::LittleDict: the metadata of the paper\n\n\n\n\n\n","category":"type"},{"location":"references/#References","page":"References","title":"References","text":"","category":"section"},{"location":"references/","page":"References","title":"References","text":"Bezanson, J.; Edelman, A.; Karpinski, S. and Shah, V. B. (2017). Julia: A fresh approach to numerical computing. SIAM Review 59, 65–98. Publisher: SIAM.\n\n\n\nPage, M. J.; McKenzie, J. E.; Bossuyt, P. M.; Boutron, I.; Hoffmann, T. C.; Mulrow, C. D.; Shamseer, L.; Tetzlaff, J. M.; Akl, E. A.; Brennan, S. E.; Chou, R.; Glanville, J.; Grimshaw, J. M.; Hróbjartsson, A.; Lalu, M. M.; Li, T.; Loder, E. W.; Mayo-Wilson, E.; McDonald, S.; McGuinness, L. A.; Stewart, L. A.; Thomas, J.; Tricco, A. C.; Welch, V. A.; Whiting, P. and Moher, D. (2021). The PRISMA 2020 statement: an updated guideline for reporting systematic reviews. Systematic Reviews 10, 89. Accessed on Nov 16, 2023.\n\n\n\n","category":"page"},{"location":"flow_diagram/#Flow-Diagram","page":"Flow Diagram","title":"Flow Diagram","text":"","category":"section"},{"location":"flow_diagram/","page":"Flow Diagram","title":"Flow Diagram","text":"PRISMA.flow_diagram_df\nPRISMA.flow_diagram\nPRISMA.FlowDiagram\nPRISMA.flow_diagram_save","category":"page"},{"location":"flow_diagram/#PRISMA.flow_diagram_df","page":"Flow Diagram","title":"PRISMA.flow_diagram_df","text":"PRISMA.flow_diagram_df()::DataFrame\n\nReturn the template that is used to create the flow diagram as a DataFrame.\n\nExamples\n\nYou can either edit the template in a Julia program or save it as a CSV file.\n\nusing PRISMA, CSV\n\ndf = PRISMA.flow_diagram_df()\n\nCSV.write(\"flow_diagram.csv\", df)\n\nusing PRISMA, DataFrames\n\ndf = PRISMA.flow_diagram_df()\n\ndf[3, \"result\"] = 200\n\nIn order to add more databases or registers to the flow diagram, you must add them as  another row. This can either be done by saving the template as a CSV file and editing  it in a Julia program using the DataFrames package.\n\nWhen you want to add a specific text to the a specific box the box must be specificied in the box_num column. There are 22 boxes in the flow diagram. When you using the DataFrames package, you can add the new row to the DataFrame using the push! function.\n\nusing PRISMA, DataFrames\n\ndf = PRISMA.flow_diagram_df()\n\n# adding new Databases\npush!(df, (8, \"Database or Register 4\", 150))\npush!(df, (8, \"Database or Register 5\", 121))\n\n# adding new reasons for exclusion\npush!(df, (15, \"Reason 4\", 20))\npush!(df, (15, \"Reason 5\", 10))\npush!(df, (15, \"Reason 6\", 03))\n\nprintln(df)\n\nPRISMA.flow_diagram(df)\n\nWhen you want to plot the data in the flow diagram, you can use the PRISMA.flow_diagram function. If your data was saved as a CSV file, you can use must read it in using the DataFrames package. \n\nusing PRISMA, CSV, DataFrames\n\ndf = CSV.read(\"flow_diagram.csv\", DataFrame)\n\nPRISMA.flow_diagram(df)\n\n\n\n\n\n","category":"function"},{"location":"flow_diagram/#PRISMA.flow_diagram","page":"Flow Diagram","title":"PRISMA.flow_diagram","text":"PRISMA.flow_diagram(\n    data::DataFrame=flow_diagram_df(),\n    background_color::AbstractString=\"white\",\n    grayboxes::Bool=true,\n    grayboxes_color::AbstractString=\"#f0f0f0\",\n    top_boxes::Bool=true,\n    top_boxes_borders::Bool=false,\n    top_boxes_color::AbstractString=\"#ffc000\",\n    side_boxes::Bool=true,\n    side_boxes_borders::Bool=false,\n    side_boxes_color::AbstractString=\"#95cbff\",\n    previous_studies::Bool=true,\n    other_methods::Bool=true,\n    borders::Bool=true,\n    border_style::AbstractString=\"solid\",\n    border_width::Union{AbstractString,Number}=1,\n    border_color::AbstractString=\"black\",\n    font::AbstractString=\"Helvetica\",\n    font_color::AbstractString=\"black\",\n    font_size::Union{AbstractString,Number}=1,\n    arrow_head::AbstractString=\"normal\",\n    arrow_size::Union{AbstractString,Number}=1,\n    arrow_color::AbstractString=\"black\",\n    arrow_width::Union{AbstractString,Number}=1)::PRISMA.FlowDiagram\n\nGenerates the flow diagram figure from the flow diagram dataframe.\n\nArgument\n\ndata::DataFrame: The flow diagram dataframe. Default is flow_diagram_df().\n\nKeyword Arguments\n\nbackground_color::String: The background color of the flow diagram. Default is white.\ngrayboxes::Bool: Whether to show gray boxes. Default is true.\ngrayboxes_color::String: The color of the gray boxes. Default is #f0f0f0.\ntop_boxes::Bool: Whether to show top boxes. Default is true.\ntop_boxes_border::Bool: Whether to show top boxes border. Default is false.\ntop_boxes_color::String: The color of the top boxes. Default is #ffc000.\nside_boxes::Bool: Whether to show side boxes. Default is true.\nside_boxes_border::Bool: Whether to show side boxes border. Default is false.\nside_boxes_color::String: The color of the side boxes. Default is #95cbff.\nprevious_studies::Bool: Whether to show previous studies. Default is true.\nother_methods::Bool: Whether to show other methods. Default is `\nbox_border_width::Number: The border width of the boxes. Default is 1.\nbox_border_color::String: The border color of the boxes. Default is black.\nfont::String: The font of the text. Default is Helvetica.\nfont_color::String: The color of the text. Default is black.\nfont_size::Number: The font size of the text. Default is 10.\narrow_color::String: The color of the arrows. Default is black.\narrow_width::Number: The width of the arrows. Default is 1.\n\nReturns\n\nPRISMA.FlowDiagram: The flow diagram figure.\n\nExample\n\nusing PRISMA, CSV, DataFrame\n\n# create a template to edit the data in a csv\ntemplate_df::DataFrame = PRISMA.flow_diagram_df()\nCSV.write(\"flow_diagram.csv\", template_df)\n\n# create a `DataFrame` from the csv\ndf::DataFrame = CSV.read(\"flow_diagram.csv\", DataFrame)\n\n# generate the flow diagram with the `DataFrame`\nfd::PRISMA.FlowDiagram = PRISMA.flow_diagram(df, top_boxes_color=\"white\")\n\n# save the flow diagram\nPRISMA.flow_diagram_save(\"flow_diagram.svg\", fd)\n\n\n\n\n\n","category":"function"},{"location":"flow_diagram/#PRISMA.FlowDiagram","page":"Flow Diagram","title":"PRISMA.FlowDiagram","text":"PRISMA.FlowDiagram\n\nFlow diagram type for PRISMA.jl\n\nArgument\n\ndot::AbstractString: The flow diagram written in Graphviz's DOT language\n\n\n\n\n\n","category":"type"},{"location":"flow_diagram/#PRISMA.flow_diagram_save","page":"Flow Diagram","title":"PRISMA.flow_diagram_save","text":"PRISMA.flow_diagram_save(fn::AbstractString, fd::FlowDiagram; overwrite::Bool=false)::String\n\nwrites a FlowDiagram as either a file (i.e., any Graphviz supported format) or stdout\n\nArguments\n\nfn::AbstractString: The name of the file to be saved.\nfd::FlowDiagram: The flow diagram to be saved.\noverwrite::Bool=false: Whether to overwrite the file if it already exists.\n\nReturns\n\nString: The path to the saved file.\n\nExamples\n\nusing PRISMA\n\nfd = PRISMA.flow_diagram()\n\nPRISMA.flow_diagram_save(\"flow_diagram.pdf\", fd)\nPRISMA.flow_diagram_save(\"flow_diagram.png\", fd)\nPRISMA.flow_diagram_save(\"flow_diagram.svg\", fd)\n\n\n\n\n\n","category":"function"},{"location":"#Home","page":"Home","title":"Home","text":"","category":"section"},{"location":"","page":"Home","title":"Home","text":"PRISMA.PRISMA","category":"page"},{"location":"#PRISMA.PRISMA","page":"Home","title":"PRISMA.PRISMA","text":"PRISMA.jl\n\nJulia package for generating checklists and flow diagrams based on the 2020 Preferred Reporting Items for Systematic Reviews and Meta-Analyses (PRISMA) statement (Page et al., 2021).\n\nFunctions\n\nchecklist_df: returns an empty PRISMA checklist as the type DataFrame\nchecklist: returns a completed PRISMA checklist as the type Checklist\nflow_diagram_df: returns the DataFrame that is used to create the flow diagram\nflow_diagram: returns a PRISMA flow diagram as the type FlowDiagram\nflow_diagram_save: saves a FlowDiagram to any file format supported by Graphviz_jll\n\nTypes\n\nChecklist: includes a completed checklist and paper metadata\nFlowDiagram: the PRISMA flow diagram represented as Graphviz's DOT language\n\n\n\n\n\n","category":"module"}]
}