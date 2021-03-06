# cov-report

_Generates aggregate go code coverage results._

[![Build Status](https://travis-ci.org/go-phorce/cov-report.svg?branch=master)](https://travis-ci.org/go-phorce/cov-report)
[![Coverage Status](https://coveralls.io/repos/github/go-phorce/cov-report/badge.svg?branch=master)](https://coveralls.io/github/go-phorce/cov-report?branch=master)


`go test` can generate code coverage results and an overall coverage percentage, however it can
only do this one package at at time, also there are no mechanisms to exclude certain source
files from the calculation (e.g. you may want to exclude code generated files).

This tool will take one or more cover profiles generated by GO test and generate a summary
of the aggregate coverage across the set of cover profiles results. In addition you can
provide a regex to exclude files from the calculation, and get a summary of the files with
the least coverage.

## Dependencies

    go get github.com/juju/errors
    go get golang.org/x/tools

## Usage

    go install github.com/go-phorce/cov-report/cmd/cov-report

`cov-report [-fmt txt|json|xml] [-o results.file] [-u <num top uncovered files>] [-ex source file name exclusion regex] [-cc combined output filename] <coverprofileFile> ...`

e.g.

```.sh
./cov-report -ex "query_console|.*.pb.go" ~/code/ekspand/cov-report/cpt.out ~/code/ekspand/cov-report/cp.out
Statements
total:     203
covered:   182
uncovered: 21
excluded:
result:    89.7%

Top uncovered source files [name, uncovered count, total uncovered %]
 github.com/go-phorce/cov-report/cmd/cov-report/main.go     19    9.4%
 github.com/go-phorce/cov-report/version/versioninfo.go      1    0.5%
 github.com/go-phorce/cov-report/version/current.go          1    0.5%
```

## Contribution

* `make all` complete build and test
* `make get` fetches the pinned dependencies from repos
* `make build` build the executable tool
* `make test` run the tests
* `make testshort` runs the tests skipping the end-to-end tests and the code coverage reporting
* `make covtest` runs the tests with end-to-end and the code coverage reporting
* `make coverage` view the code coverage results from the last make test run.
* `make generate` runs go generate to update any code generated files
* `make fmt` runs go fmt on the project.
* `make lint` runs the go linter on the project.

run `make get` once, then run `make build` or `make test` as needed.

First run:

    make all

Subsequent builds:

    make build

Tests:

    make test

Optionally run golang race detector with test targets by setting RACE flag:

    make test RACE=true

Review coverage report:

    make covtest coverage
