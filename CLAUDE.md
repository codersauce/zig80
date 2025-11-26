# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## Project Overview

Zig Z80 is a Z80 CPU emulator written in Zig, validated against the [redcode/Z80](https://github.com/redcode/Z80) reference implementation and [redcode/SingleStepTests-z80](https://github.com/redcode/SingleStepTests-z80) test suites.

## Build and Development Commands

```bash
zig build                    # Build zig80-test executable
zig build install            # Build and install to zig-out/bin/
zig fmt src                  # Format all Zig source files
```

### Running Tests

```bash
# Embedded unit tests (CLI parsing tests)
zig test src/cli.zig

# Integration tests via zig80-test
./zig-out/bin/zig80-test run                    # Run all tests
./zig-out/bin/zig80-test run <test_name>        # Run specific test by name
./zig-out/bin/zig80-test run --bench            # Compare against reference C emulator
./zig-out/bin/zig80-test run --both             # Run on both emulators and diff
./zig-out/bin/zig80-test run --stop             # Stop on first failure
./zig-out/bin/zig80-test show <test_name>       # Display test information
```

## Architecture

### Core Modules

- **cpu.zig** - Z80 CPU emulator core: register state, memory, instruction execution (`run()`), state save/load
- **Z80.zig** - C bindings to redcode/Z80 reference implementation for benchmark comparison
- **runner.zig** - JSON test parser: loads test descriptions, applies state, drives execution, compares results
- **tests.zig** - Test orchestration and integration with CLI options
- **unit.zig** - Main test executable entry point with `show`/`run` subcommands
- **cli.zig** - Generic type-driven argument parser with subcommand support
- **utils.zig** - Bit manipulation, file I/O, and string helpers

### Test Format

Tests use JSON format describing CPU state transitions:
- Initial state (registers, flags, memory)
- Expected final state after N cycles
- Memory access cycles for validation

### Key Patterns

- **Callback-based I/O**: CPU uses function pointers for memory write hooks and port I/O
- **Sparse state serialization**: Only non-zero memory bytes are saved/loaded
- **Generic CLI parser**: Uses comptime introspection; `opt_*` prefix for optional flags, union types for subcommands

## Dependencies

- Requires `z80` system library (linked via build.zig) for benchmark comparison
- Nix environment available via `shell.nix` (includes zig_0_13, zls, cmake, clang)

## Commit Style

Use conventional commits: `feat:`, `fix:`, `chore:`, etc. See `git log` for examples.
