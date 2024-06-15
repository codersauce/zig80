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

    var options = Options.init();
    try cli.parse(args, Options, &options);

    std.debug.print("Running {any}\n", .{options});

    try tests.run(alloc, options.@"test");
}

const Options = struct {
    /// Number of the test to run
    @"test": ?u32,

    pub fn init() Options {
        return Options{
            .@"test" = null,
        };
    }
};
