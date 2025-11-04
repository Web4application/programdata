build:
	dune build

test:
	dune runtest

clean:
	dune clean

coverage:
	dune runtest --instrument-with bisect_ppx
	bisect-ppx-report html
