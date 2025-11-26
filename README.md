# Zig Z80

A Z80 CPU emulator written in Zig, validated against the [redcode/Z80](https://github.com/redcode/Z80) reference implementation and [redcode/SingleStepTests-z80](https://github.com/redcode/SingleStepTests-z80) test suites.

## Requirements

- Zig 0.15.x
- [redcode/Z80](https://github.com/redcode/Z80) C library (for benchmark comparison)

## Installation

### Installing the Z80 Reference Library

The project uses the [redcode/Z80](https://github.com/redcode/Z80) C library for benchmark comparisons against a reference implementation. This library must be built from source.

#### Prerequisites

- CMake 3.14+
- C compiler (clang or gcc)

#### Build and Install

```bash
# Create a build directory
mkdir -p ~/code/z80-deps && cd ~/code/z80-deps

# Clone the required repositories
git clone https://github.com/redcode/Zeta.git
git clone https://github.com/redcode/Z80.git

# Build and install Zeta (header-only dependency)
cd Zeta
mkdir build && cd build
cmake \
    -DCMAKE_BUILD_TYPE=Release \
    -DCMAKE_INSTALL_PREFIX=/opt/homebrew \
    -DZeta_WITH_CMAKE_SUPPORT=YES \
    -DZeta_WITH_PKGCONFIG_SUPPORT=YES \
    ..
sudo cmake --install . --config Release

# Build and install Z80
cd ../../Z80
mkdir build && cd build
cmake \
    -DBUILD_SHARED_LIBS=YES \
    -DCMAKE_BUILD_TYPE=Release \
    -DCMAKE_INSTALL_NAME_DIR=/opt/homebrew/lib \
    -DCMAKE_INSTALL_PREFIX=/opt/homebrew \
    -DZ80_WITH_CMAKE_SUPPORT=YES \
    -DZ80_WITH_PKGCONFIG_SUPPORT=YES \
    -DZ80_WITH_EXECUTE=YES \
    ..
cmake --build .
sudo cmake --install . --config Release
```

#### Alternative: Install to User Directory (no sudo)

```bash
mkdir -p ~/code/z80-deps && cd ~/code/z80-deps
git clone https://github.com/redcode/Zeta.git
git clone https://github.com/redcode/Z80.git

cd Zeta
mkdir build && cd build
cmake \
    -DCMAKE_BUILD_TYPE=Release \
    -DCMAKE_INSTALL_PREFIX="$HOME/.local" \
    -DZeta_WITH_CMAKE_SUPPORT=YES \
    ..
cmake --install . --config Release

cd ../../Z80
mkdir build && cd build
cmake \
    -DBUILD_SHARED_LIBS=YES \
    -DCMAKE_BUILD_TYPE=Release \
    -DCMAKE_INSTALL_NAME_DIR="$HOME/.local/lib" \
    -DCMAKE_INSTALL_PREFIX="$HOME/.local" \
    -DZ80_WITH_CMAKE_SUPPORT=YES \
    -DZ80_WITH_EXECUTE=YES \
    ..
cmake --build .
cmake --install . --config Release
```

If installing to `~/.local`, add the library path to your environment:

```bash
export LIBRARY_PATH="$HOME/.local/lib:$LIBRARY_PATH"
export LD_LIBRARY_PATH="$HOME/.local/lib:$LD_LIBRARY_PATH"
```

## Building

```bash
zig build
```

The executable will be placed in `zig-out/bin/zig80-test`.

## Running Tests

```bash
# Run all tests
./zig-out/bin/zig80-test run

# Run a specific test by name
./zig-out/bin/zig80-test run <test_name>

# Compare against reference C emulator
./zig-out/bin/zig80-test run --bench

# Run on both emulators and show differences
./zig-out/bin/zig80-test run --both

# Stop on first failure
./zig-out/bin/zig80-test run --stop

# Display test information
./zig-out/bin/zig80-test show <test_name>
```

## Development

```bash
# Format source code
zig fmt src

# Run CLI unit tests
zig test src/cli.zig
```

## Current Status

**Test Coverage:** 99.6% (3 of ~750 tests failing)

The remaining 3 failures are port I/O tests (`IN r,(C)` instructions) that require test infrastructure updates to pass port data from `busActivity`.

### Recently Completed

- [x] **Port I/O Improvements** - Fixed all port-related instructions to use proper 16-bit addressing
  - IN r,(C) and OUT (C),r instructions now use full BC register (16-bit port)
  - IN A,(n) and OUT (n),A instructions properly form port from A (high) and n (low)
  - Port callbacks updated to u16 with floating bus simulation
  - Fixed setInFlags() to properly set Sign, HalfCarry, and XY flags
- [x] **Instruction Fixes**
  - Fixed ED 53 (LD (nn), DE) - missing cycle count and double fetchWord bug
  - Fixed LDI/LDD integer overflow in flag calculation
- [x] **Test Coverage** - All basic port I/O tests now pass with `--both` flag

### In Progress

- [ ] Update test infrastructure to support port I/O from busActivity data
- [ ] Get full coverage from all test suites

### Completed

- [x] Core Z80 instruction set implementation
- [x] IX/IY indexed addressing modes with proper cycle timing
- [x] DD CB / FD CB indexed bit operations
- [x] ED prefix instructions (NEG, RETN, RETI, IM 0/1/2, LD I/R,A)
- [x] Run integration tests validating against [redcode/Z80](https://github.com/redcode/Z80)
- [x] Port test suite execution from [redcode/Z80](https://github.com/redcode/Z80) and [redcode/SingleStepTests-z80](https://github.com/redcode/SingleStepTests-z80)
- [x] Set up initial project structure

## Architecture

See [CLAUDE.md](CLAUDE.md) for detailed architecture documentation.

## License

See LICENSE file for details.
