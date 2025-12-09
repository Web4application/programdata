# projects/dullo/Dockerfile
FROM ocaml/opam:debian-12-ocaml-5.1

WORKDIR /app

# Copy Dullo project
COPY . .

# Install dependencies
RUN sudo apt-get update && \
    sudo apt-get install -y python3 python3-pip m4 unzip && \
    opam install dune bisect_ppx --yes

# Build all executables + run tests + generate coverage
RUN dune build @dullo

# Install FastAPI & Uvicorn
RUN pip3 install fastapi uvicorn

EXPOSE 8086

# Run FastAPI API server
CMD ["uvicorn", "api.server:app", "--host", "0.0.0.0", "--port", "8086"]
