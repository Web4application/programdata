#!/bin/bash
#--------------------------------------------
# Fast LLVM/Clang build using Ninja
#--------------------------------------------

set -e

LLVM_VERSION="17.0.6"            # Change to desired version
SRC_DIR="$HOME/llvm-project"     # Where sources will be cloned
BUILD_DIR="$HOME/llvm-build"     # Where LLVM will be built
INSTALL_DIR="$HOME/llvm-install" # Where LLVM will be installed
NPROC=$(nproc)                   # Number of parallel build jobs

# ----------------------
# Clone LLVM project if missing
# ----------------------
if [ ! -d "$SRC_DIR" ]; then
    echo "Cloning LLVM $LLVM_VERSION..."
    git clone --branch llvmorg-$LLVM_VERSION https://github.com/llvm/llvm-project.git "$SRC_DIR"
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
      "$SRC_DIR/llvm"

ninja -j "$NPROC"
ninja install

echo "----------------------------------"
echo "LLVM/Clang $LLVM_VERSION installed at $INSTALL_DIR"
echo "----------------------------------"
