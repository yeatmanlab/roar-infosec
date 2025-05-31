# Makefile for generating PDF from Markdown

# Variables
ACCESSIBILITY_MD = roar-accessibility-statement.md
ACCESSIBILITY_PDF = $(patsubst %.md, %.pdf, $(ACCESSIBILITY_MD))

INFOSEC_MD = roar-data-privacy-and-infosec-manual.md
INFOSEC_PDF = $(patsubst %.md, %.pdf, $(INFOSEC_MD))

NYCPS_INFOSEC_MD = nycps/roar-nycps-data-privacy-and-infosec-manual.md
NYCPS_INFOSEC_PDF = $(patsubst %.md, %.pdf, $(NYCPS_INFOSEC_MD))

SDLC_MD = roar-sdlc.md
SDLC_PDF = $(patsubst %.md, %.pdf, $(SDLC_MD))

BCDR_MD = roar-bcdr.md
BCDR_PDF = $(patsubst %.md, %.pdf, $(BCDR_MD))

MD_FILES = $(wildcard vendor-assessments/*.md)
VENDOR_ASSESSMENTS_DIR = vendor-assessments

# Default target
all: accessibility infosec nycps sdlc bcdr

PANDOC_OPTS = -f gfm --template ./.tex-template/eisvogel.latex \
              -V linkcolor=blue \
			  -V header-includes:'\usepackage[export]{adjustbox} \let\includegraphicsbak\includegraphics \renewcommand*{\includegraphics}[2][]{\includegraphicsbak[frame,\#1]{\#2}}'

accessibility: $(ACCESSIBILITY_MD)
	@pandoc $(ACCESSIBILITY_MD) $(PANDOC_OPTS) -o $(ACCESSIBILITY_PDF)

infosec: $(INFOSEC_MD)
	@pandoc $(INFOSEC_MD) $(PANDOC_OPTS) -o $(INFOSEC_PDF)

nycps: $(NYCPS_INFOSEC_MD)
	@pandoc $(NYCPS_INFOSEC_MD) $(PANDOC_OPTS) -o $(NYCPS_INFOSEC_PDF)
	@if command -v pdftk >/dev/null 2>&1; then \
		echo "Merging NYCPS infosec manual with appendices..."; \
		echo "Creating temporary file list..."; \
		echo $(NYCPS_INFOSEC_PDF) > tmp_pdf_list.txt; \
		for file in $$(ls nycps/appendix_*.pdf | sort); do \
			echo $$file >> tmp_pdf_list.txt; \
		done; \
		pdftk $$(cat tmp_pdf_list.txt) cat output nycps/roar-nycps-data-privacy-and-infosec-manual-with-appendices.pdf; \
		rm tmp_pdf_list.txt; \
	else \
		echo "pdftk not found. Please install it to merge PDF files:"; \
	fi

sdlc: $(SDLC_MD)
	@pandoc $(SDLC_MD) $(PANDOC_OPTS) -o $(SDLC_PDF)

bcdr: $(BCDR_MD)
	@pandoc $(BCDR_MD) $(PANDOC_OPTS) -o $(BCDR_PDF)

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
	rm -f $(NYCPS_INFOSEC_PDF)

# Phony targets
.PHONY: all clean install vendor-assessments bcdr sdlc infosec accessibility nycps check-spelling
