TEXOPT=--shell-escape
NONSTOP=--interaction=nonstopmode

LATEXMK=latexmk
LATEXMKOPT=-pdf

MAIN=document
SOURCES=$(MAIN).tex dynamic-preamble.tex Makefile


all: show


show: $(MAIN).pdf
	mupdf $(MAIN).pdf


$(MAIN).pdf: $(SOURCES) preamble.fmt .refresh
	$(LATEXMK) $(LATEXMKOPT) $(TEXOPT) $(NONSTOP) $(MAIN)

.refresh:
	touch .refresh


preamble.fmt: preamble.tex
	pdftex -ini -jobname=preamble "&pdflatex preamble.tex\dump"


clean:
	$(LATEXMK) -C $(MAIN)
	rm -f $(MAIN).pdfsync
	rm -rf *~ *.tmp
	rm -f *.fmt *.bbl *.blg *.aux *.end *.fls *.log *.out *.fdb_latexmk


.PHONY: clean all show
# Source: https://drewsilcock.co.uk/using-make-and-latexmk
