#!/bin/bash

# Build script for Zig WASM with optimized 512KB buffer
echo "Building Zig SHA256 to WASM with optimized 512KB buffer..."

# Add local zig to PATH
export PATH=$PWD/../zig-linux-x86_64-0.14.0:$PATH

# Check if zig is available
if ! command -v zig &> /dev/null; then
    echo "Error: Zig is not available. Make sure zig is installed."
    exit 1
fi

echo "Using Zig version: $(zig version)"

# Build the WASM file using build.zig
zig build -Dtarget=wasm32-freestanding-musl -Doptimize=ReleaseSmall

# Copy the WASM file to build directory
if [ -f "zig-out/bin/sha256.wasm" ]; then
    cp zig-out/bin/sha256.wasm ../build/sha256.wasm
    echo "WASM file created successfully: build/sha256.wasm"
    echo "Optimized with 512KB buffer for maximum performance"
else
    echo "Error: WASM file not found after build"
    echo "Looking for files in zig-out/bin/:"
    ls -la zig-out/bin/ 2>/dev/null || echo "zig-out/bin/ directory not found"
    exit 1
fi

echo "Build completed successfully!"
