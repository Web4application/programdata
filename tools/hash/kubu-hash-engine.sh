#!/usr/bin/env bash
set -euo pipefail

########## CONFIG ##########
CLIENT="${1:-}"
BUILD_ID="${BUILD_ID:-local}"
EXTENSIONS=("zip" "dmg" "gz" "tar.xz" "jar")
CHECK_DIR="checksum"
AGGRegex="^eclipse\.platform\.releng\.aggregator.*\.zip$"
################################

# --- Fancy Logging (KUBU STYLE) ---
info()    { echo -e "\033[1;36m[INFO]\033[0m $*"; }
warn()    { echo -e "\033[1;33m[WARN]\033[0m $*"; }
error()   { echo -e "\033[1;31m[ERROR]\033[0m $*" >&2; }
success() { echo -e "\033[1;32m[SUCCESS]\033[0m $*"; }

# --- Arg Check ---
if [[ -z "$CLIENT" ]]; then
    error "Usage: $0 <client-name>"
    exit 1
fi

info "🔥 Starting Kubu Hash Engine"
info "Client: $CLIENT | Build: $BUILD_ID"
info "Working directory: $PWD"

# --- Prepare Output Directory ---
mkdir -p "$CHECK_DIR"
ALL_SHA="${CHECK_DIR}/${CLIENT}-${BUILD_ID}-SHA512.txt"
rm -f "$ALL_SHA"

info "📦 Generating SHA-512 checksums..."

# --- Loop Through Extensions ---
for ext in "${EXTENSIONS[@]}"; do
    for f in *."$ext"; do
        [[ ! -e "$f" ]] && continue

        if [[ "$f" =~ $AGGRegex ]]; then
            warn "Skipping aggregator file: $f"
            continue
        fi

        info "🔒 Hashing: $f"
        sha512sum -b "$f" | tee "${CHECK_DIR}/${f}.sha512" >> "$ALL_SHA"
    done
done

success "Checksums created successfully."
info "➡️  Combined checksum file: $ALL_SHA"

# --- GPG Signing Phase ---
info "🔑 Preparing GPG signing..."

if [[ -n "${KEYRING_PASSPHRASE:-}" ]]; then
    GPG_HOME="${WORKSPACE:-$PWD}/tools/${CLIENT}/gpg"

    mkdir -p "$GPG_HOME"
    info "Setting up GPG homedir: $GPG_HOME"

    export GNUPGHOME="$GPG_HOME"
    gpg --batch --import "$KEYRING"

    # Trust all imported keys
    for fpr in $(gpg --list-keys --with-colons | awk -F: '/^fpr:/ {print $10}' | sort -u); do
        info "Trusting GPG key: $fpr"
        printf "5\ny\n" | gpg --batch --command-fd 0 --expert --edit-key "$fpr" trust
    done

    SIGNATURE="${ALL_SHA}.asc"

    info "✍️  Signing checksum file..."
    gpg --batch \
        --pinentry-mode loopback \
        --passphrase "$KEYRING_PASSPHRASE" \
        --armor --detach-sign \
        --output "$SIGNATURE" \
        "$ALL_SHA"

    success "Signature created: $SIGNATURE"

else
    warn "No KEYRING_PASSPHRASE set — skipping signing. (Local dev mode)"
fi

success "🎉 KUBU Hash Engine completed successfully."
