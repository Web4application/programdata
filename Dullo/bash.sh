```
dune build bin/moc.exe
dune build @all
dune test
(instrumentation (backend bisect_ppx --bisect-silent yes))
dune runtest --instrument-with bisect_ppx
bisect-ppx-report html

dullo/
├── dune-project
├── dune
├── src/
│   ├── moc.ml
│   ├── mo_ld.ml
│   ├── mo_doc.ml
│   ├── didc.ml
│   ├── deser.ml
│   └── candid_tests.ml
└── Makefile

# Build everything
make

# Run tests
make test

# Generate coverage
make coverage

# Clean up
make clean

# GitHub CLI
gh repo create dullo --public --description "Dullo: OCaml build & test suite with Dune and coverage" --confirm

git clone https://github.com/<web4hub>/dullo.git
cd dullo
