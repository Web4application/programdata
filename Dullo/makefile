# Dullo Makefile
# Fully self-contained build + test + coverage

.PHONY: all build test clean coverage install uninstall deps check-ocaml

# Minimum OCaml version
OCAML_MIN_VERSION := 5.1.0

# Default target
all: check-ocaml deps build

# Check OCaml version
check-ocaml:
	@ocamlc -version | awk '{if($$1 < "$(OCAML_MIN_VERSION)") exit 1}' \
		&& echo "OCaml version OK" || (echo "OCaml version too old, upgrade required"; exit 1)

# Install dependencies
deps:
	@echo "Installing dependencies..."
	opam install . --deps-only -y

# Build all executables
build:
	@echo "Building Dullo executables..."
	dune build @all

# Run all tests
test:
	@echo "Running Dullo tests..."
	dune runtest

# Clean build artifacts
clean:
	@echo "Cleaning..."
	dune clean

# Generate coverage report
coverage:
	@echo "Running tests with coverage instrumentation..."
	dune runtest --instrument-with bisect_ppx
	@echo "Generating HTML coverage report..."
	bisect-ppx-report html --coverage-path _build/default
	@echo "Coverage report available at ./_coverage/index.html"

# Install binaries system-wide (optional)
install:
	dune install

# Uninstall binaries
uninstall:
	dune uninstall
