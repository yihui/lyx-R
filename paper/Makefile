RJwrapper.pdf: RJwrapper.Rnw RJournal-lyx.Rnw RJournal-lyx.bib
	Rscript -e "library(knitr); opts_knit[['set']](progress=FALSE); knit2pdf('RJwrapper.Rnw')"

clean:
	rm -f *.tex *.bbl *.blg *.aux *.out *.log *.spl *tikzDictionary

