# PRISMA.jl

<!-- START HTML -->
<div>
  </br>
  <p align="center"><img src="docs/src/assets/logo.svg" width="130"></p>
  <p align="center"><strong>Interactive visualizations for evidence syntheses.</strong></p>
  <p align="center">
    <a href='https://cecoeco.github.io/PRISMA.jl/stable/'><img src='https://img.shields.io/badge/docs-stable-blue.svg' alt='Documentation Stable' /></a>
    <a href='https://www.contributor-covenant.org'><img src='https://img.shields.io/badge/Contributor%20Covenant-v2.1%20adopted-ff69b4.svg' alt='Contributor Covenant'></a>
  </p>
</div>
<!-- END HTML -->

## About

PRISMA.jl is a Julia-based software package that generates checklists and flow diagrams for systematic reviews and meta-analyses based on [the <b>P</b>referred <b>R</b>eporting <b>I</b>tems for <b>S</b>ystematic <b>R</b>eviews and <b>M</b>eta-<b>A</b>nalyses (PRISMA) statement (Page et al., 2021).](https://doi.org/10.1186/s13643-021-01626-4) Its companion web application can also be used by researchers with little to no programming experience looking to report the results from their systematic reviews and meta-analyses with efficiency and transparency: [Link coming soon.]()

## Installation

```julia
import Pkg; Pkg.add("PRISMA") 
```

If you do not have Julia or a text-editor that supports Julia installed, then you might find this [link](https://julialang.org/learning/) helpful before getting started.

## Example

This simple example shows how a few functions in this package can be used together to create a flow diagram:

```Julia
using PRISMA

# The flow_diagram_csv() function generates a csv template. 
# The path of the template is assigned to the 'data' variable, 
# but in most scenarios the template is edited before it is assigned and read.
data = PRISMA.flow_diagram_csv()

# The flow_diagram_read() function reads the csv saved as 'data' 
# and turns it into a dataframe and assigns it to 'df'.
df = PRISMA.flow_diagram_read(file=data)

# The flow_diagram() function turns data frames into 
# flow diagrams that show the results of a meta-analysis or systematic review.
figure = PRISMA.flow_diagram(data=df)

# The flow_diagram_save() function saves the figure and saves 
# it in formats supported by Makie.jl, png is the default.
PRISMA.flow_diagram_save(figure=figure) 
```

Result:
![flow diagram](docs/src/assets/figure.svg)

## License

Copyright © 2024 Ceco Elijah Maples

This work is licensed under the [MIT License](https://opensource.org/license/mit/) - see the [`LICENSE`](LICENSE.md) file for details.