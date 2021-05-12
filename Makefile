slides.pdf: slides.tex
	latexmk -pdf -xelatex slides

slides.tex: slides.md defaults.yaml metadata.yaml
	pandoc -d defaults.yaml

png: slides.pdf
	convert -density 300 slides.pdf -scale 800x output/presentation_by_pandoc_beamer_slide-%02d.png

clean:
	rm -f slides.aux slides.log slides.nav slides.pdf slides.snm
	rm -f slides.tex slides.toc slides.vrb
	rm -f slides.fdb_latexmk slides.fls slides.xdv

all: slides.pdf
