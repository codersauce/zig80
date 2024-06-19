const std = @import("std");
const cli = @import("cli.zig");
const runner = @import("runner.zig");
const tests = @import("tests.zig");

pub fn main() !void {
    var gpa = std.heap.GeneralPurposeAllocator(.{ .safety = true }){};
    defer _ = gpa.deinit();

    const alloc = gpa.allocator();

    const args = try std.process.argsAlloc(alloc);
    defer std.process.argsFree(alloc, args);

    const options = try cli.parse(tests.Options, args);
    try tests.run(alloc, options);
}
