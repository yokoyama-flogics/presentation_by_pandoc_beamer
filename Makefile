INPUTFILES=slides.md defaults.yaml metadata.yaml

.PNONY: all png watch clean

all: slides.pdf

slides.pdf: slides.tex
	latexmk -use-make -pdf -xelatex $<

slides.tex: $(INPUTFILES)
	pandoc -d defaults.yaml

png: slides.pdf
	convert -density 300 slides.pdf -scale 800x output/presentation_by_pandoc_beamer_slide-%02d.png

watch:
	fswatch -0 $(INPUTFILES) |	\
	while read -d "" event;		\
	do				\
		make all;		\
	done

clean:
	rm -f slides.aux slides.log slides.nav slides.pdf slides.snm
	rm -f slides.tex slides.toc slides.vrb
	rm -f slides.fdb_latexmk slides.fls slides.xdv
