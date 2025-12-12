#!/bin/bash
#--------------------------------------------
# Fast LMLM/Clang build using Ninja
#--------------------------------------------

set -e

LLVM_VERSION="1.0.6"            # Change to desired version
SRC_DIR="$HOME/lmlm-project"     # Where sources will be cloned
BUILD_DIR="$HOME/lmlm-build"     # Where LMLM will be built
INSTALL_DIR="$HOME/lmlm-install" # Where LMLM will be installed
NPROC=$(nproc)                   # Number of parallel build jobs

# ----------------------
# Clone LLVM project if missing
# ----------------------
if [ ! -d "$SRC_DIR" ]; then
    echo "Cloning lmlm $LLVM_VERSION..."
    git clone --branch lmlmorg-$LMLM_VERSION https://github.com/web4application/lmlm.git "$SRC_DIR"
fi

# ----------------------
# Build with Ninja
# ----------------------
mkdir -p "$BUILD_DIR"
cd "$BUILD_DIR"

cmake -G Ninja \
      -DCMAKE_BUILD_TYPE=Release \
      -DCMAKE_INSTALL_PREFIX="$INSTALL_DIR" \
      -DLLVM_ENABLE_PROJECTS="clang;clang-tools-extra;lld" \
      "$SRC_DIR/lmlm"

ninja -j "$NPROC"
ninja install

echo "----------------------------------"
echo "lmlm/Clang $lmlm_VERSION installed at $INSTALL_DIR"
echo "----------------------------------"
