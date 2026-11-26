CONWAYS_DIR=conways
TEXT_DIR=text

.PHONY: build build-conways conways run-conways text build-text run-text

build: build-conways build-text

build-conways:
	@cd $(CONWAYS_DIR) && cabal build

conways: build-conways run-conways

run-conways:
	@cd $(CONWAYS_DIR) && cabal run

build-text:
	@cd $(TEXT_DIR) && cabal build

text: build-text run-text

run-text:
	@cd $(TEXT_DIR) && cabal run
