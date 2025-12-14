
OUT_DIR := build
FILES := $(wildcard *.typ)

all:
	$(MAKE) compile

$(FILES:.typ=.pdf): %.pdf: %.typ
	@mkdir -p $(OUT_DIR)
	@echo "Compiling $< regular"
	@typst compile --pdf-standard a-2b --input handout=true $< $(OUT_DIR)/$(<:%.typ=%.pdf)

$(FILES:.typ=-dark.pdf): %-dark.pdf: %.typ
	@mkdir -p $(OUT_DIR)
	@echo "Compiling $< dark mode"
	@typst compile --pdf-standard a-2b --input handout=true --input darkmode=true $< $(OUT_DIR)/$(<:%.typ=%-dark.pdf)

compile: $(FILES:.typ=.pdf) $(FILES:.typ=-dark.pdf)
	@echo -e "\e[1;42mAll Done. PDFs can be found in \"$(OUT_DIR)\"\e[0m"

cleanBuild:
	@echo -e "\e[1;34mCleaning up build directory...$<\e[0m"
	@rm -rf $(OUT_DIR)
	@echo -e "\e[1;44mDone cleaning up build directory.$<\e[0m"

clean: cleanBuild
