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
    const body = try request.reader().readAllAlloc(alloc, content_length);
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

pub fn dumpMemoryWithPointer(memory: []const u8, pc: u16, range: u8) void {
    for (0..range) |i| {
        const j: i16 = @intCast(i);
        const rr: i32 = j - (range / 2);
        const ix: usize = @intCast(pc + rr);
        if (ix >= 0) {
            if (ix == pc) {
                std.debug.print(" [{X:0>2}]", .{memory[ix]});
            } else {
                std.debug.print(" {X:0>2}", .{memory[ix]});
            }
        }
    }
}
