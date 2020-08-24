# Default target to build
TARGET = text_subfile

# Instruct latexmk to use make for dependencies
LATEXMK = latexmk -use-make

all: $(TARGET).pdf

# Intermediate files to keep
.PRECIOUS: %.jpg %.png %.tiff %.pgf %.pdf %.pytxcode

FORCE: ;

# Compile a .pdf from a LaTeX source
%.pdf: %.tex %.pytxcode
	pythontex $*
	$(LATEXMK) -M -MP -MF $*.deps $*

%.pytxcode: $(TARGET).tex
	pdflatex -synctex=1 --interaction=nonstopmode -file-line-error -shell-escape -draftmode $*

_pythontex/%.pytxmcr: %.pytxcode
	pythontex $(notdir $*)

#-----------------------------------------------------------------
# Recipes
#-----------------------------------------------------------------

.PHONY: all report draft revision checkclean clean cleanall

report: $(TARGET).pdf

draft: $(TARGET).tex
	pdflatex -interaction=nonstopmode -file-line-error -synctex=1 -shell-escape -jobname=$(TARGET)_draft "\def\classopts{,draft}\input{$(TARGET)}"

revision: $(TARGET).tex
	$(LATEXMK) -jobname=$(TARGET)_revision -M -MP -MF $*.deps -pdflatex='pdflatex %O -interaction=nonstopmode -file-line-error -synctex=1 -shell-escape "\def\classopts{,revision}\input{%S}"' $(TARGET)

checkclean:
	@echo "Are you sure? [y/N] " && read ans && [ $${ans:-N} = y ]

clean:
	rm -rf _minted-*
	rm -rf _pythontex
	latexmk -c

cleanall: checkclean
	make clean
	rm -rf temp_dir
	rm -f $(TARGET).pdf
	rm -f $(TARGET)_draft.pdf
	rm -f $(TARGET)_revision.pdf
	rm -f *.deps
	rm -f figs/*.pgf
	rm -f figs/*.deps

-include *.deps
