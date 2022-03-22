## Makefile based on http://git.io/GIs6og

## Define standard Markdown extension
MEXT = md

## All markdown files in the working directory
SRC = $(wildcard *.$(MEXT))

## Bibliography
BIB = /home/habi/P/Documents/library.bib

## Get last commit hash
ID := $(shell git log --oneline --no-color | cut -c -6 | head -n 1)

## File names
PDFS=$(SRC:.md=.pdf)
HTML=$(SRC:.md=.html)
TEX=$(SRC:.md=.tex)
DOC=$(SRC:.md=.docx)

## Targets
all:	$(PDFS) $(HTML) $(TEX) $(DOC)
pdf:	$(PDFS)
html:	$(HTML)
tex:	$(TEX)
doc:	$(DOC)

%.html: %.md
	pandoc -w html5 -s --bibliography=$(BIB) -o $@ $<
	rename.ul \. _$(ID)\. $@

%.tex:	%.md
	pandoc -w latex -s --bibliography=$(BIB) -o $@ $<
	rename.ul \. _$(ID)\. $@
	
%.pdf:	%.md
	pandoc -s --bibliography=$(BIB) -o $@ $<
	rename.ul \. _$(ID)\. $@

%.docx: %.md
	pandoc -s --bibliography=$(BIB) -o $@ $<
	rename.ul \. _$(ID)\. $@

clean:
	rm *.html *.pdf *.tex *.docx
