# Makefile for generating PDF from Markdown

# Variables
ACCESSIBILITY_MD = roar-accessibility-statement.md
ACCESSIBILITY_PDF = $(patsubst %.md, %.pdf, $(ACCESSIBILITY_MD))

INFOSEC_MD = roar-data-privacy-and-infosec-manual.md
INFOSEC_PDF = $(patsubst %.md, %.pdf, $(INFOSEC_MD))

SDLC_MD = roar-sdlc.md
SDLC_PDF = $(patsubst %.md, %.pdf, $(SDLC_MD))

BCDR_MD = roar-bcdr.md
BCDR_PDF = $(patsubst %.md, %.pdf, $(BCDR_MD))

MD_FILES = $(wildcard vendor-assessments/*.md)
VENDOR_ASSESSMENTS_DIR = vendor-assessments

# Default target
all: accessibility infosec sdlc bcdr

PANDOC_OPTS = -f gfm --template ./.tex-template/eisvogel.latex \
              -V linkcolor=blue \
			  -V header-includes:'\usepackage[export]{adjustbox} \let\includegraphicsbak\includegraphics \renewcommand*{\includegraphics}[2][]{\includegraphicsbak[frame,\#1]{\#2}}'

accessibility: $(ACCESSIBILITY_MD)
	@pandoc $(ACCESSIBILITY_MD) $(PANDOC_OPTS) -o $(ACCESSIBILITY_PDF)

infosec: $(INFOSEC_MD)
	@pandoc $(INFOSEC_MD) $(PANDOC_OPTS) -o $(INFOSEC_PDF)

sdlc: $(SDLC_MD)
	@pandoc $(SDLC_MD) $(PANDOC_OPTS) -o $(SDLC_PDF)

bcdr: $(BCDR_MD)
	@pandoc $(BCDR_MD) $(PANDOC_OPTS) -o $(BCDR_PDF)

# Command to generate PDFs for all markdown files in the vendor-assessments folder
vendor-assessments: $(MD_FILES)
	@mkdir -p $(VENDOR_ASSESSMENTS_DIR)
	@for file in $(MD_FILES); do \
		pandoc $$file $(PANDOC_OPTS) -o $(VENDOR_ASSESSMENTS_DIR)/$$(basename $$file .md).pdf; \
	done

check-spelling:
	@aspell --lang=en --mode=markdown -c $(INFOSEC_MD)
	@aspell --lang=en --mode=markdown -c $(SDLC_MD)
	@aspell --lang=en --mode=markdown -c $(BCDR_MD)

# Command to install Pandoc
install:
	# Install pandoc (Linux or macOS). For Windows, use the installer from the official website
	which pandoc || (sudo apt-get update && sudo apt-get install -y pandoc || brew install pandoc)

# Clean command to remove the generated PDFs
clean:
	rm -f $(INFOSEC_PDF)
	rm -f $(SDLC_PDF)
	rm -f $(BCDR_PDF)
	rm -f $(ACCESSIBILITY_PDF)

# Phony targets
.PHONY: all clean install vendor-assessments bcdr sdlc infosec accessibility check-spelling
