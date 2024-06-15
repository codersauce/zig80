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

    var options = tests.Options.init();
    if (!try cli.parse(args, tests.Options, &options)) {
        return;
    }

    try tests.run(alloc, options);
}
