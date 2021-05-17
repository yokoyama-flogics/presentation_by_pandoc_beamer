DOCBASE=slides
INPUTFILES=$(DOCBASE).md defaults.yaml metadata.yaml

.PNONY: all png watch clean

all: $(DOCBASE).pdf

$(DOCBASE).pdf: ${DOCBASE}.tex
	latexmk -use-make -pdf -xelatex $<

$(DOCBASE).tex: $(INPUTFILES)
	pandoc -d defaults.yaml

png: $(DOCBASE).pdf
	convert -density 300 $(DOCBASE).pdf -scale 800x output/presentation_by_pandoc_beamer_slide-%02d.png

watch:
	fswatch -0 $(INPUTFILES) |	\
	while read -d "" event;		\
	do				\
		make all;		\
	done

clean:
	rm -f $(DOCBASE).aux ${DOCBASE}.log ${DOCBASE}.nav ${DOCBASE}.pdf   \
		$(DOCBASE).snm ${DOCBASE}.tex ${DOCBASE}.toc ${DOCBASE}.vrb \
		$(DOCBASE).fdb_latexmk ${DOCBASE}.fls ${DOCBASE}.xd
