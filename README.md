# Support Files for Using R in LyX

This repository provides some (unofficial) support files for using R with LyX.

## The `scripts` directory

This directory contains R scripts which can be used for the Sweave converter. Due to the fact that currently LyX modules are not configurable, only one script can be used per LyX installation. To use an R script here, you have to rename it to `lyxsweave.R` and put it under the `scripts` directory of your user directory, which can be found in the menu `Help` --> `About LyX` (e.g. `~/.lyx/`).

- `lyxknitr.R` is for the [**knitr** package](https://github.com/yihui/knitr)
- `lyxpgfsweave.R` is for the [**pgfSweave** package](http://cran.r-project.org/package=pgfSweave)

## The `examples` directory

Aside from the official manual of Sweave in LyX, which is an example file itself, I have a few other examples demonstrating how to use Sweave with beamer in LyX, and how to use **knitr** and **pgfSweave**, etc.

## Other files

- `add-R-path-win.R` is a dirty R script to help Windows users who are reluctant to learn what is the `PATH` variable add the bin path of R to the `PATH` variable of the system (use with care; I have no guarantee).

## Contributions? Comments?

I'd love to include more contributions from LyX/Sweave users; please feel free to email me or open [an issue](https://github.com/yihui/lyx/issues) here if you have any requests, comments or questions.
