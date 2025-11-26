# Zig 0.13 to 0.15.2 Migration Guide

This document summarizes the breaking changes encountered when migrating this project from Zig 0.13 to Zig 0.15.2.

## Build System Changes

### `build.zig`: root_source_file → root_module

```zig
// Old (0.13)
const exe = b.addExecutable(.{
    .name = "myapp",
    .root_source_file = b.path("src/main.zig"),
    .target = target,
    .optimize = opt,
});

// New (0.15)
const exe = b.addExecutable(.{
    .name = "myapp",
    .root_module = b.createModule(.{
        .root_source_file = b.path("src/main.zig"),
        .target = target,
        .optimize = opt,
    }),
});
```

## Comment Restrictions

Zig 0.15 no longer allows tab characters in comments. Replace tabs with spaces.

```zig
// Old - causes error: "comment contains invalid byte: '\t'"
//		some comment with tabs

// New
//      some comment with spaces
```

## Type System Changes

### @typeInfo enum names: PascalCase → snake_case

```zig
// Old (0.13)
if (@typeInfo(T) == .Optional) { }
if (@typeInfo(T) == .Struct) { }
if (@typeInfo(T) == .Union) { }

// New (0.15)
if (@typeInfo(T) == .optional) { }
if (@typeInfo(T) == .@"struct") { }
if (@typeInfo(T) == .@"union") { }
```

### argsAlloc return type change

```zig
// Old (0.13) - accepted [][]const u8
fn parse(args: [][]const u8) !void { }

// New (0.15) - returns []const [:0]const u8
fn parse(args: []const [:0]const u8) !void { }
```

### StructField.default_value → defaultValue()

```zig
// Old (0.13)
if (field.default_value) |default_ptr| {
    const default = @as(*align(1) const field.type, @ptrCast(default_ptr)).*;
    @field(r, field.name) = default;
}

// New (0.15)
if (field.defaultValue()) |default| {
    @field(r, field.name) = default;
}
```

## I/O System Overhaul ("Writergate")

### std.io.getStdOut() removed

```zig
// Old (0.13)
const stdout = std.io.getStdOut().writer();
try stdout.print("Hello\n", .{});

// New (0.15)
const stdout = std.fs.File.stdout();
var buffer: [4096]u8 = undefined;
var file_writer = stdout.writer(&buffer);
try file_writer.interface.print("Hello\n", .{});
file_writer.interface.flush() catch {};
```

### file.reader().readAllAlloc() → file.readToEndAlloc()

```zig
// Old (0.13)
const data = try file.reader().readAllAlloc(alloc, max_size);

// New (0.15)
const data = try file.readToEndAlloc(alloc, max_size);
```

## Container API Changes (Unmanaged by Default)

ArrayList (and other containers) no longer store the allocator internally. Pass the allocator to each method that needs it.

```zig
// Old (0.13)
var list = std.ArrayList(u8).init(allocator);
defer list.deinit();
try list.append('A');
try list.appendSlice("hello");
const slice = list.toOwnedSlice();
const writer = list.writer();

// New (0.15)
var list = std.ArrayList(u8){};
defer list.deinit(allocator);
try list.append(allocator, 'A');
try list.appendSlice(allocator, "hello");
const slice = list.toOwnedSlice(allocator);
const writer = list.writer(allocator);
```

## Other API Changes

### callconv(.C) → callconv(.c)

```zig
// Old (0.13)
fn callback(ctx: ?*anyopaque) callconv(.C) void { }

// New (0.15)
fn callback(ctx: ?*anyopaque) callconv(.c) void { }
```

### std.mem.split() → std.mem.splitSequence()

```zig
// Old (0.13)
var iter = std.mem.split(u8, input, "\n");

// New (0.15)
var iter = std.mem.splitSequence(u8, input, "\n");
```

### std.json.stringify() → std.json.Stringify.valueAlloc()

```zig
// Old (0.13)
std.json.stringify(data, .{}, writer) catch {};

// New (0.15)
const json_output = try std.json.Stringify.valueAlloc(allocator, data, .{});
defer allocator.free(json_output);
try file.writeAll(json_output);
```

## Quick Reference

| Old (0.13) | New (0.15) |
|------------|------------|
| `.root_source_file` | `.root_module = b.createModule(...)` |
| `.Optional` | `.optional` |
| `.Struct` | `.@"struct"` |
| `.Union` | `.@"union"` |
| `field.default_value` | `field.defaultValue()` |
| `std.io.getStdOut()` | `std.fs.File.stdout()` + buffer |
| `file.reader().readAllAlloc()` | `file.readToEndAlloc()` |
| `ArrayList.init(alloc)` | `ArrayList{}` |
| `list.deinit()` | `list.deinit(alloc)` |
| `list.append(item)` | `list.append(alloc, item)` |
| `list.toOwnedSlice()` | `list.toOwnedSlice(alloc)` |
| `callconv(.C)` | `callconv(.c)` |
| `std.mem.split()` | `std.mem.splitSequence()` |
| `std.json.stringify()` | `std.json.Stringify.valueAlloc()` |

## Resources

- [Zig 0.15.1 Release Notes](https://ziglang.org/download/0.15.1/release-notes.html)
- [Zig 0.15 Migration Roadblocks](https://sngeth.com/zig/systems-programming/breaking-changes/2025/10/24/zig-0-15-migration-roadblocks/)
- [Zig 0.15.1 I/O Overhaul](https://dev.to/bkataru/zig-0151-io-overhaul-understanding-the-new-readerwriter-interfaces-30oe)
