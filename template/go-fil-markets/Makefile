all: build
.PHONY: all

SUBMODULES=

FFI_PATH:=../filecoin-ffi/
FFI_DEPS:=.install-filcrypto
FFI_DEPS:=$(addprefix $(FFI_PATH),$(FFI_DEPS))

DEPS_OPT:
	cp -rf ../filecoin-ffi/filcrypto.pc ./extern/filecoin-ffi
	cp -rf ../filecoin-ffi/filcrypto.h ./extern/filecoin-ffi
	cp -rf ../filecoin-ffi/libfilcrypto.a ./extern/filecoin-ffi

deps: $(BUILD_DEPS)

.PHONY: deps

$(FFI_DEPS): .filecoin-build ;

.filecoin-build: $(FFI_PATH)
	$(MAKE) -C $(FFI_PATH) $(FFI_DEPS:$(FFI_PATH)%=%)
	@touch $@

.update-modules:
	git submodule update --init --recursive
	@touch $@

pieceio: .update-modules .filecoin-build DEPS_OPT
	go build ./pieceio
.PHONY: pieceio
SUBMODULES+=pieceio

filestore: DEPS_OPT
	go build ./filestore
.PHONY: filestore
SUBMODULES+=filestore

build: $(SUBMODULES)

test: build
	gotestsum -- -coverprofile=coverage.txt -timeout 5m ./...

clean:
	rm -f .filecoin-build
	rm -f .update-modules
	rm -f coverage.txt

DOTs=$(shell find docs -name '*.dot')
MMDs=$(shell find docs -name '*.mmd')
SVGs=$(DOTs:%=%.svg) $(MMDs:%=%.svg)
PNGs=$(DOTs:%=%.png) $(MMDs:%=%.png)

node_modules: package.json
	npm install

diagrams: ${MMDs} ${SVGs} ${PNGs}

%.mmd.svg: %.mmd
	node_modules/.bin/mmdc -i $< -o $@

%.mmd.png: %.mmd
	node_modules/.bin/mmdc -i $< -o $@

FORCE:

docsgen: FORCE .update-modules .filecoin-build
	go run ./docsgen

$(MMDs): docsgen node_modules

imports: FORCE
	scripts/fiximports

cbor-gen: FORCE
	go generate ./...

tidy: FORCE
	go mod tidy

lint: FORCE
	git fetch
	golangci-lint run -v --concurrency 2 --new-from-rev origin/master

prepare-pr: cbor-gen tidy diagrams imports lint
