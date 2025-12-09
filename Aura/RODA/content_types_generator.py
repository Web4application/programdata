import os
import mimetypes
from xml.etree.ElementTree import Element, SubElement, ElementTree
from watchdog.observers import Observer
from watchdog.events import FileSystemEventHandler
import time

# -----------------------------
# CONFIG: project folders to watch
# -----------------------------
PROJECT_DIRS = ["./aura", "./sctm", "./khml", "./db", "./other"]  # add your folders
OUTPUT_FILE = "./[Content_Types].xml"

# -----------------------------
# Known extensions with MIME types
# -----------------------------
KNOWN_TYPES = {
    ".js": "application/javascript",
    ".ts": "application/typescript",
    ".json": "application/json",
    ".json5": "application/json",
    ".gql": "application/octet-stream",
    ".env": "application/octet-stream",
    ".yaml": "text/yaml",
    ".yml": "text/yaml",
    ".md": "text/markdown",
    ".mkd": "text/markdown",
    ".txt": "text/plain",
    ".rst": "text/x-rst",
    ".html": "text/html",
    ".css": "text/css",
    ".csv": "text/csv",
    ".png": "image/png",
    ".svg": "image/svg+xml",
    ".webp": "image/webp",
    ".ttf": "font/ttf",
    ".woff": "font/woff",
    ".woff2": "font/woff2",
    ".xlsm": "application/vnd.ms-excel.sheet.macroEnabled.12",
    ".xlsx": "application/vnd.openxmlformats-officedocument.spreadsheetml.sheet",
    ".xlsl": "application/octet-stream",
    ".vsixmanifest": "text/xml",
    ".khml": "application/octet-stream",
    ".sctm": "application/octet-stream",
    ".aura": "application/octet-stream",
    ".berry": "application/octet-stream",
    ".math": "application/octet-stream",
    ".ser": "application/octet-stream",
    ".r": "application/octet-stream",
    ".ml": "application/octet-stream",
    ".mli": "application/octet-stream",
    ".nix": "application/octet-stream",
    ".nex": "application/octet-stream",
}

# -----------------------------
# Function to generate XML
# -----------------------------
def generate_content_types():
    all_extensions = set(KNOWN_TYPES.keys())

    for folder in PROJECT_DIRS:
        for root, _, files in os.walk(folder):
            for file in files:
                ext = os.path.splitext(file)[1].lower()
                if ext and ext not in all_extensions:
                    all_extensions.add(ext)

    types = Element("Types", xmlns="http://schemas.openxmlformats.org/package/2006/content-types")
    for ext in sorted(all_extensions):
        ct = KNOWN_TYPES.get(ext, mimetypes.guess_type("file" + ext)[0] or "application/octet-stream")
        SubElement(types, "Default", Extension=ext.lstrip("."), ContentType=ct)

    tree = ElementTree(types)
    tree.write(OUTPUT_FILE, encoding="utf-8", xml_declaration=True)
    print(f"[+] Updated {OUTPUT_FILE} with {len(all_extensions)} extensions.")

# -----------------------------
# Watchdog handler
# -----------------------------
class WatchHandler(FileSystemEventHandler):
    def on_any_event(self, event):
        if not event.is_directory:
            generate_content_types()

# -----------------------------
# Set up observer
# -----------------------------
observer = Observer()
handler = WatchHandler()

for folder in PROJECT_DIRS:
    if os.path.exists(folder):
        observer.schedule(handler, path=folder, recursive=True)

observer.start()
print("[*] Watching folders for changes... Press Ctrl+C to stop.")

try:
    while True:
        time.sleep(1)
except KeyboardInterrupt:
    observer.stop()
observer.join()
