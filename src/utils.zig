const std = @import("std");
const http = std.http;
const Allocator = std.mem.Allocator;

pub fn fileExists(path: []const u8) !bool {
    const file = std.fs.cwd().openFile(path, .{}) catch |err| switch (err) {
        error.FileNotFound => return false,
        else => return err,
    };

    file.close();

    return true;
}

pub fn findFile(alloc: Allocator, path: []const u8, search_path: []const []const u8) !?[]const u8 {
    for (search_path) |dir| {
        const full_path = try std.fs.path.join(alloc, &[_][]const u8{ dir, path });

        if (try fileExists(full_path)) {
            return full_path;
        } else {
            alloc.free(full_path);
        }
    }

    return null;
}

pub fn download(alloc: Allocator, url: []const u8, outname: []const u8) !void {
    var client = http.Client{ .allocator = alloc };
    defer client.deinit();

    const uri = std.Uri.parse(url) catch unreachable;
    var server_header_buffer: [2048]u8 = undefined;

    var request = try client.open(.GET, uri, .{ .server_header_buffer = &server_header_buffer });
    defer request.deinit();

    try request.send();
    try request.wait();

    const content_length = request.response.content_length.?;
    var transfer_buffer: [8192]u8 = undefined;
    const reader = request.reader(&transfer_buffer);
    const body = try reader.readAlloc(alloc, content_length);
    defer alloc.free(body);

    std.fs.cwd().makeDir(std.fs.path.dirname(outname).?) catch {};
    const dest = try std.fs.cwd().createFile(outname, .{});
    defer dest.close();

    const bytes_written = try dest.writeAll(body);
    _ = bytes_written;
}

pub fn extract(alloc: Allocator, archive: []const u8) !void {
    const dir = try std.process.getCwdAlloc(alloc);
    defer alloc.free(dir);

    const archive_path = try std.fs.path.join(alloc, &[_][]const u8{ dir, archive });
    defer alloc.free(archive_path);

    const outdir_path = std.fs.path.dirname(archive_path).?;

    if (!try fileExists(archive_path)) {
        std.debug.print("Archive not found: {s}\n", .{archive_path});
        return;
    }

    if (!try fileExists(outdir_path)) {
        std.debug.print("Creating directory: {s}\n", .{outdir_path});
        try std.fs.cwd().makeDir(outdir_path);
    }

    if (std.mem.endsWith(u8, archive_path, ".tar.gz")) {
        // std.debug.print("Extracting {s} to {s}\n", .{ archive_path, outdir_path });
        try extractTarGz(alloc, archive_path, outdir_path);
    } else if (std.mem.endsWith(u8, archive_path, ".zip")) {
        // std.debug.print("Extracting {s} to {s}\n", .{ archive_path, outdir_path });
        try extractZip(alloc, archive_path, outdir_path);
    } else {
        // std.debug.print("Unknown archive type: {s}\n", .{archive_path});
    }
}

pub fn extractTarGz(alloc: Allocator, archive_path: []const u8, outdir_path: []const u8) !void {
    const proc = try std.process.Child.run(.{
        .allocator = alloc,
        .argv = &.{ "tar", "-xzf", archive_path, "-C", outdir_path },
    });
    defer alloc.free(proc.stdout);
    defer alloc.free(proc.stderr);
    // std.debug.print(" *** Output:\n{s}\n", .{proc.stdout});
}

pub fn extractZip(alloc: Allocator, archive_path: []const u8, outdir_path: []const u8) !void {
    const proc = try std.process.Child.run(.{
        .allocator = alloc,
        .argv = &.{ "unzip", archive_path, "-d", outdir_path },
    });
    defer alloc.free(proc.stdout);
    defer alloc.free(proc.stderr);
    // std.debug.print(" *** Output:\n{s}\n", .{proc.stdout});
}

pub fn countSetBits(v: u8) u32 {
    var count: u32 = 0;
    var n = v;

    while (n > 0) {
        count += 1;
        n &= n - 1;
    }

    // std.debug.print("countSetBits for {0d} = {0b} = {1d}\n", .{ v, count });
    return count;
}

pub fn parity(v: u8) bool {
    return countSetBits(v) % 2 == 0;
}

pub fn dumpMemoryWithPointer(memory: []const u8, pc: u16, range: u8) void {
    for (0..range) |i| {
        const j: i16 = @intCast(i);
        const rr: i32 = j - (range / 2);
        if (pc + rr >= 0) {
            const ix: usize = @intCast(pc + rr);
            if (ix >= 0 and ix < memory.len) {
                if (ix == pc) {
                    std.debug.print(" [{X:0>2}]", .{memory[ix]});
                } else {
                    std.debug.print(" {X:0>2}", .{memory[ix]});
                }
            }
        }
    }
}

pub fn showMismatch(alloc: Allocator, m1: []const u8, m2: []const u8) void {
    _ = alloc;
    for (m1, 0..) |a, i| {
        if (m2[i] != a) {
            std.debug.print("Mismatch at {X:0>4}: ours = {X:0>2} theirs = {X:0>2}\n", .{ i, a, m2[i] });
            std.debug.print("  ours   = ", .{});
            dumpMemoryWithPointer(m1, @intCast(i), 16);
            std.debug.print("\n  theirs = ", .{});
            dumpMemoryWithPointer(m2, @intCast(i), 16);
            std.debug.print("\n", .{});
            // } else {
            //     std.debug.print("{X:0>2} {X:0>2}\n", .{ a, m2[i] });
        }
    }
}

/// Sets the n-th bit of an u8
pub fn setBit(n: u3, val: u8) u8 {
    return val | (@as(u8, 1) << n);
}

pub fn bit(n: u5, value: u16) bool {
    return (value & (@as(i32, 1) << n)) != 0;
}

pub fn carry(n: u5, a: u16, b: u16, cy: bool) bool {
    const cy_: u8 = if (cy) 1 else 0;
    return bit(n, (a + b + cy_) ^ a ^ b);
}

pub fn hi(value: u16) u8 {
    return @as(u8, @intCast(value >> 8));
}

pub fn lo(value: u16) u8 {
    return @as(u8, @intCast(value & 0xFF));
}

pub fn setHi(value: u16, hi_val: u8) u16 {
    return (value & 0x00FF) | (@as(u16, @intCast(hi_val)) << 8);
}

pub fn setLo(value: u16, lo_val: u8) u16 {
    return (value & 0xFF00) | @as(u16, @intCast(lo_val));
}

pub fn u16FromBytes(low: u8, high: u8) u16 {
    return @as(u16, @intCast(high)) << 8 | @as(u16, @intCast(low));
}

pub fn indentString(allocator: std.mem.Allocator, input: []const u8, indent_size: usize) ![]u8 {
    var result = std.ArrayList(u8){};
    defer result.deinit(allocator);

    var lines = std.mem.splitSequence(u8, input, "\n");
    var first_line = true;

    while (lines.next()) |line| {
        if (!first_line) {
            try result.append(allocator, '\n');
        }
        try result.appendNTimes(allocator, ' ', indent_size);
        try result.appendSlice(allocator, line);
        first_line = false;
    }

    return result.toOwnedSlice(allocator);
}
