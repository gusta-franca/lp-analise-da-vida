CONWAYS_DIR=conways

.PHONY: build build-conways conways run-conways

build: build-conways

build-conways:
	@cd $(CONWAYS_DIR) && cabal build

conways: build-conways run-conways

run-conways:
	@cd $(CONWAYS_DIR) && cabal run
