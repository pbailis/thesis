# This work is dedicated to the public domain.

texargs = -interaction nonstopmode -halt-on-error -file-line-error

default: mthesis.pdf # default target if you just type "make"


# Resources and rules for the introductory chapter. Sample 'make' rule
# included to show how you can process data as you compile your thesis
# using standard GNU make constructs.

deps += intro/intro.tex background/background.tex iconfluence/iconfluence.tex isolation/isolation.tex ramp/ramp.tex constraints/constraints.tex discussion/discussion.tex relatedwork/relatedwork.tex conclusion/conclusion.tex
cleans += intro/intro.aux background/background.aux iconfluence/iconfluence.aux isolation/isolation.aux ramp/ramp.aux constraints/constraints.aux discussion/discussion.aux relatedwork/relatedwork.aux conclusion/conclusion.aux

#intro/processed.tex: intro/sample.tex
#	sed -e s/terrible/wonderful/ $< >$@


# Chapter Two

## deps += ...
## cleans += ...
## etc


# The thesis itself. We move the PDF to a new filename so that viewers
# don't keep on trying to reload the file as it's being written and
# rewritten by pdfLaTeX.

deps += myucthesis.cls uct12.clo aasmacros.sty mydeluxetable.sty \
  setup.tex thesis.bib yahapj.bst
cleans += thesis.aux thesis.bbl thesis.blg thesis.lof thesis.log \
  thesis.lot thesis.out thesis.toc mthesis.pdf setup.aux
toplevels += mthesis.pdf

mthesis.pdf: thesis.tex $(deps)
	pdflatex $(texargs) $(basename $<) >chatter.txt
	bibtex $(basename $<)
	pdflatex $(texargs) $(basename $<) >chatter.txt
	pdflatex $(texargs) $(basename $<) >chatter.txt
	mv thesis.pdf $@
#bash diff-prev.sh > ~/Dropbox/Public/pdb-dissertation.diff
#cp mthesis.pdf ~/Dropbox/Public/pbailis-thesis-draft.pdf


# Approval page

cleans += approvalpage.aux approvalpage.log approvalpage.pdf
toplevels += approvalpage.pdf

approvalpage.pdf: approvalpage.tex $(deps)
	pdflatex $(texargs) $(basename $<)


# Helpers

all: $(toplevels)

clean:
	-rm -f $(cleans)
