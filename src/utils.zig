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
