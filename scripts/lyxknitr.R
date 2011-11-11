## This program is free software; you can redistribute it and/or
## modify it under the terms of the GNU General Public License as
## published by the Free Software Foundation; either version 2 of the
## License, or (at your option) any later version.
##
## This program is distributed in the hope that it will be useful, but
## WITHOUT ANY WARRANTY; without even the implied warranty of
## MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the GNU
## General Public License for more details.

## author Yihui Xie

## knitr is an alternative package to Sweave, and has more features
## and flexibility; see https://yihui.github.com/knitr

## Rscript $$s/scripts/lyxsweave.R $$p$$i $$p$$o $$e $$r
## $$p the path of the output (temp dir)
## $$i the file name of the input Rnw
## $$o the tex output
## $$r path to the original input file (the lyx document)
## $$e encoding (e.g. 'UTF-8')

if (!require('knitr')) {
    ## install knitr if not available; currently knitr is not on CRAN yet
    if (!require('devtools'))
        install.packages('devtools', repos = 'http://cran.r-project.org')
    library(devtools)
    install_github('knitr', 'yihui')
    library(knitr)
}

.cmdargs = commandArgs(TRUE)

.orig.enc = getOption("encoding")
options(encoding = .cmdargs[3])

## the working directory is the same with the original .lyx file; you
## can put your data files there and functions like read.table() can
## work correctly without specifying the full path
setwd(.cmdargs[4])

## copy the Rnw file to the current working directory
file.copy(.cmdargs[1], '.', overwrite = TRUE)
## run knit() to get .tex
knit(basename(.cmdargs[1]))

setwd(.cmdargs[4])
unlink(basename(.cmdargs[1]))  # remove the copied .Rnw
file.rename(basename(.cmdargs[2]), .cmdargs[2])  # move .tex to the temp dir
