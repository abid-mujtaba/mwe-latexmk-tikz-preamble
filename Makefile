TEXOPT=--shell-escape
NONSTOP=--interaction=nonstopmode

LATEXMK=latexmk
LATEXMKOPT=-pdf

MAIN=document
SOURCES=$(MAIN).tex dynamic-preamble.tex Makefile


all: show


# Use mupdf to display the created file. If already compiled the file is shown directly.
show: $(MAIN).pdf
	mupdf $(MAIN).pdf &


# latexmk uses pdflatex to compile tex files by default. To change specify the engine use -xelatex .etc
$(MAIN).pdf: $(SOURCES) preamble.fmt
	$(LATEXMK) $(LATEXMKOPT) $(TEXOPT) $(NONSTOP) $(MAIN)


# Precompilation magic. Create preamble.fmt so that this step doesn't have to be repeated every time.
preamble.fmt: preamble.tex
	pdftex -ini -jobname=preamble "&pdflatex preamble.tex\dump"


clean:
	$(LATEXMK) -C $(MAIN)
	rm -f $(MAIN).pdfsync
	rm -rf *~ *.tmp
	rm -f *.fmt *.bbl *.blg *.aux *.end *.fls *.log *.out *.fdb_latexmk


.PHONY: clean all show
# Source: https://drewsilcock.co.uk/using-make-and-latexmk
