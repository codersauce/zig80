const std = @import("std");
const runner = @import("runner.zig");
const tests = @import("tests.zig");

pub fn main() !void {
    var gpa = std.heap.GeneralPurposeAllocator(.{ .safety = true }){};
    defer _ = gpa.deinit();

    const alloc = gpa.allocator();

    // try runner.runTest(alloc, "SingleStepTests-z80/v1/0a.json");
    // std.debug.print("SingleStepTests-z80/v1/0a.json passed\n", .{});

    try tests.downloadTests(alloc);
}
