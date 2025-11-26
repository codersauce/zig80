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

    const cli_opts_opt = cli.parse(tests.CliOptions, args) catch |err| {
        switch (err) {
            error.InvalidParam, error.InvalidCharacter => {
                const stdout = std.fs.File.stdout();
                var buffer: [4096]u8 = undefined;
                var file_writer = stdout.writer(&buffer);
                try cli.help_for(tests.CliOptions, &file_writer.interface);
                file_writer.interface.flush() catch {};
                return;
            },
            else => return err,
        }
    };

    if (cli_opts_opt) |cli_opts| {
        const options = cli_opts.toOptions();
        try tests.run(alloc, options);
    }
}
