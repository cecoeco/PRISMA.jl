<div align="center">
    <b><h1>PRISMA.jl</h1></b>
</div>

PRISMA.jl is a Julia package with a web-based UI that generates checklists and flow diagrams for systematic reviews and meta-analyses based on the most recent <b>P</b>referred <b>R</b>eporting <b>I</b>tems for <b>S</b>ystematic <b>R</b>eviews and <b>M</b>eta-<b>A</b>nalyses (PRISMA) statement ([Page et al., 2021](https://doi.org/10.1186/s13643-021-01626-4)).


## Getting Started

If you do not have Julia or a text-editor that supports Julia installed, then you might find this [link](https://julialang.org/learning/) helpful before continuing.
```Julia
# Install the PRISMA.jl package
import Pkg; Pkg.add("PRISMA") 
```

This example shows how a few functions in this package can be used together to create a flow diagram.
```Julia
using PRISMA
# The flow_diagram_xlsx() function generates a template Excel spreadsheet.
# The path of the template is assigned to the 'data' variable, 
# but in most scenarios the template is edited before it is assigned and read
data = PRISMA.flow_diagram_xlsx(filename="PRISMA_2020_flow_diagram_data")
# the flow_diagram_read() function reads the spreadsheet saved as 'data' and turns it into a dataframe and assigns it to 'df'
df = PRISMA.flow_diagram_read(file=data)  
# the flow_diagram() function turns data frames into flow diagrams that show the results a meta-analysis or systematic review 
f = PRISMA.flow_diagram(data=df)
# flow_diagram_save() function saves the figure and saves it in a format supported by Makie.jl, in this case an svg file.
PRISMA.flow_diagram_save(figure=f, name="PRISMA_2020_flow_diagram_example", save_format="svg")  
```

Result:

## License :balance_scale:

Copyright © 2024. Ceco E. Maples

This work is licensed under the [MIT License](https://opensource.org/license/mit/).