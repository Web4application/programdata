bisect-ppx-report html --coverage-path _build/default
# Install OCaml dependencies
make deps

# Build all executables
make

# Run all tests
make test

# Generate coverage report
make coverage

# Clean build artifacts
make clean
