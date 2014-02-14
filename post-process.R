## This program is free software; you can redistribute it and/or
## modify it under the terms of the GNU General Public License as
## published by the Free Software Foundation; either version 2 of the
## License, or (at your option) any later version.
##
## This program is distributed in the hope that it will be useful, but
## WITHOUT ANY WARRANTY; without even the implied warranty of
## MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the GNU
## General Public License for more details.

## author Carson Sievert

## This script is intended to do some tedious post processing of the 
## last-name.tex file in your RJournal submission after exporting from LyX.

# put the file name for the .tex file exported from LyX here
file.name <- "pitchRx.tex"
# put your last name here, it should match the name of the .tex and .bib file that you submit
last.name <- "sievert"

txt <- readLines(file.name)
# remove everything before '\begin{article}'
idx1 <- grep("\\\\begin\\{article\\}", txt)
if (length(idx1)) txt <- txt[-(1:(idx1-1))]
# remove '\end{document}'
idx2 <- grep("\\\\end\\{article\\}", txt)
if (length(idx2)) txt <- txt[-((idx2+1):length(txt))]
# This piece isn't need either
idx3 <- grep("\\\\bibliographystyle", txt)
if (length(idx3)) txt <- txt[-idx3]
# LyX puts the entire directory in the bibliography piece but you only want your last name
txt <- sub("bibliography\\{.*\\}", paste0("bibliography{", last.name, "}"), txt)

# If you put \pkg{} in \section{} or \subsection{}, it needs a special prefix (can this be done in LyX?)
idx4 <- grep("\\\\section\\{.*\\\\pkg.*", txt)
if (length(idx4)) {
  suffix <- sub("\\\\section", "", txt[idx4])
  inside <- gsub("\\}", "", gsub("\\\\pkg\\{", "", sub("\\{", "", suffix)))
  txt[idx4] <- paste0("\\section[", inside, "]", suffix)
}
idx5 <- grep("\\\\subsection\\{.*\\\\pkg.*", txt)
if (length(idx5)) {
  suffix <- sub("\\\\subsection", "", txt[idx5])
  inside <- gsub("\\}", "", gsub("\\\\pkg\\{", "", sub("\\{", "", suffix)))
  txt[idx5] <- paste0("\\subsection[", inside, "]", suffix)
}

# add a % before \begin{Schunk}
txt <- sub("\\\\begin\\{Schunk\\}", "%\n\\\\begin{Schunk}", txt)
output <- file(paste0(last.name, ".tex"))
writeLines(txt, con=output)
txt <- readLines(output)
# add a % after \end{Schunk}
txt <- sub("\\\\end\\{Schunk\\}", "\\\\end{Schunk}\n%", txt)
writeLines(txt, con = output)
txt <- readLines(output)

# remove empty lines (white space) before code chunk
idx6 <- grep("\\\\begin\\{Schunk\\}", txt) - 2
idx7 <- idx6[txt[idx6] %in% c("", " ")]
while (length(idx7)) {
  txt <- txt[-idx7]
  idx7 <- idx7 - 1
  idx7 <- idx7[txt[idx7] %in% c("", " ")]
}
# remove empty lines (white space) after code chunk
idx8 <- grep("\\\\end\\{Schunk\\}", txt) + 2
idx9 <- idx8[txt[idx8] %in% c("", " ")]
while (length(idx9)) {
  txt <- txt[-idx9]
  idx9 <- idx9 + 1
  idx9 <- idx9[txt[idx9] %in% c("", " ")]
}
writeLines(txt, con = output)

# Unfortunately you still have to do the following by hand:
# (1) Remove unnecessary empty lines (to reduce white space in final doc)
# (2) \figure[h!] for animations (why?)


################################################
#There must be an intelligent way to remove white space!!! Here is a start...

#grab index to empty lines, then fill them in as needed
#lidx <- which(txt %in% c(" ", ""))
#grab line before empty lines
#text[lidx - 1]
