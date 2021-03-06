include ./.project/gomod-project.mk
export GO111MODULE=on
BUILD_FLAGS=-mod=vendor

# don't echo execution
.SILENT:

.DEFAULT_GOAL := help

.PHONY: *

default: help

all: clean tools version build test

#
# clean produced files
#
clean:
	go clean
	rm -rf \
		${COVPATH} \
		${PROJ_BIN}

tools:
	go install golang.org/x/tools/cmd/stringer
	go install golang.org/x/tools/cmd/gorename
	go install golang.org/x/tools/cmd/godoc
	go install golang.org/x/tools/cmd/guru
	go install github.com/jteeuwen/go-bindata/...
	go install golang.org/x/lint/golint
	go install github.com/mattn/goveralls

version:
	gofmt -r '"GIT_VERSION" -> "$(GIT_VERSION)"' version/current.template > version/current.go

build:
	echo "Building ${PROJ_NAME} with ${BUILD_FLAGS}"
	go build ${BUILD_FLAGS} -o ${PROJ_BIN}/${PROJ_NAME} ./cmd/${PROJ_NAME}
