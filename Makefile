# Makefile for generating PDF from Markdown

# Variables
INFOSEC_MD = ROAR-data-privacy-and-information-security-manual.md
INFOSEC_PDF = $(patsubst %.md, %.pdf, $(INFOSEC_MD))

MD_FILES = $(wildcard vendor-assessments/*.md)
VENDOR_ASSESSMENTS_DIR = vendor-assessments

# Default target
all: pdf

PANDOC_OPTS = -f gfm --template ./template/eisvogel.latex \
              -V linkcolor=blue \
			  -V header-includes:'\usepackage[export]{adjustbox} \let\includegraphicsbak\includegraphics \renewcommand*{\includegraphics}[2][]{\includegraphicsbak[frame,\#1]{\#2}}'

# Command to generate PDF from Markdown
pdf: $(INFOSEC_MD)
	@pandoc $(INFOSEC_MD) $(PANDOC_OPTS) -o $(INFOSEC_PDF)

# Command to generate PDFs for all markdown files in the vendor-assessments folder
vendor-assessments: $(MD_FILES)
	@mkdir -p $(VENDOR_ASSESSMENTS_DIR)
	@for file in $(MD_FILES); do \
		pandoc $$file $(PANDOC_OPTS) -o $(VENDOR_ASSESSMENTS_DIR)/$$(basename $$file .md).pdf; \
	done

# Command to install Pandoc
install:
	# Install pandoc (Linux or macOS). For Windows, use the installer from the official website
	which pandoc || (sudo apt-get update && sudo apt-get install -y pandoc || brew install pandoc)

# Clean command to remove the generated PDF
clean:
	rm -f $(INFOSEC_PDF)

# Phony targets
.PHONY: all pdf clean install vendor-assessments
