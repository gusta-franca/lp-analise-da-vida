CONWAYS_DIR=conways

.PHONY: build-conways conways run-conways

build-conways:
	@cd $(CONWAYS_DIR) && cabal build

conways: build-conways run-conways

run-conways:
	@cd $(CONWAYS_DIR) && cabal run
