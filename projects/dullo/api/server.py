from fastapi import FastAPI
import subprocess
from fastapi.responses import JSONResponse, FileResponse
import os

app = FastAPI(title="Dullo Executables API")

# Directory where binaries are built
BIN_DIR = "/app/_build/default/"

executables = ["moc", "mo_ld", "mo_doc", "didc", "deser"]

@app.get("/exec/{name}")
def run_exec(name: str):
    if name not in executables:
        return JSONResponse({"error": "Executable not found"}, status_code=404)
    bin_path = os.path.join(BIN_DIR, name)
    if not os.path.isfile(bin_path):
        return JSONResponse({"error": "Binary not built yet"}, status_code=500)
    result = subprocess.run([bin_path], capture_output=True, text=True)
    return {"stdout": result.stdout, "stderr": result.stderr, "returncode": result.returncode}

@app.get("/coverage")
def coverage_report():
    coverage_file = os.path.join(BIN_DIR, "coverage.html")
    if os.path.isfile(coverage_file):
        return FileResponse(coverage_file, media_type="text/html")
    return JSONResponse({"error": "Coverage report not found"}, status_code=404)
