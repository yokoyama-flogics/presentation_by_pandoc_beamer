slides.pdf: slides.tex
	latexmk -pdf -xelatex slides

slides.tex: slides.md defaults.yaml metadata.yaml
	pandoc -d defaults.yaml

clean:
	rm -f slides.aux slides.log slides.nav slides.pdf slides.snm
	rm -f slides.tex slides.toc slides.vrb
	rm -f slides.fdb_latexmk slides.fls slides.xdv

all: slides.pdf
