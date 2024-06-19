const std = @import("std");
const Allocator = std.mem.Allocator;

const Cli = struct {
    test_name: []const u8,
    other_test_name: ?[]const u8,
    opt_env: ?[]const u8,
    opt_benchmark: bool,

    pub const field_info = std.enums.EnumFieldStruct(std.meta.FieldEnum(@This()), ?[]const u8, @as(?[]const u8, null)){
        .test_name = "name of the test to run",
        .other_test_name = "name of the other test to run",
        .opt_benchmark = "runs the test on the benchmark emulator",
        .opt_env = "environment to run the test in",
    };
};

pub fn main() !void {
    var gpa = std.heap.GeneralPurposeAllocator(.{ .safety = true }){};
    defer _ = gpa.deinit();

    const alloc = gpa.allocator();

    const args = try std.process.argsAlloc(alloc);
    defer std.process.argsFree(alloc, args);

    try help_for(Cli, std.io.getStdOut().writer());
}

pub fn parse(comptime T: type, args: [][]const u8) !T {
    var r: T = undefined;

    switch (@typeInfo(T)) {
        .Struct => |info| {
            var it = ArgIterator.init(args);
            var pos: usize = 0;

            while (true) {
                const arg_try = it.next();
                if (arg_try == null) {
                    break;
                }

                const arg = arg_try.?;
                std.debug.print("Arg: {s}\n", .{arg});
                if (std.mem.startsWith(u8, arg, "--")) {
                    inline for (info.fields) |field| {
                        if (std.mem.startsWith(u8, field.name, "opt_")) {
                            std.debug.print("Field: {s}\n", .{field.name});
                            if (std.mem.eql(u8, arg[2..], field.name[4..])) {
                                std.debug.print("Matched: {s} {s}\n", .{ arg, field.name });
                                switch (field.type) {
                                    []const u8 => {
                                        const value = it.next();
                                        if (value == null) {
                                            return error.InvalidParam;
                                        }
                                        std.debug.print("Setting {s} to {s}\n", .{ field.name, value.? });
                                        @field(r, field.name) = value.?;
                                    },
                                    ?[]const u8 => {
                                        const value = it.next();
                                        if (value == null) {
                                            return error.InvalidParam;
                                        }
                                        std.debug.print("Setting {s} to {s}\n", .{ field.name, value.? });
                                        @field(r, field.name) = value.?;
                                    },
                                    else => {
                                        std.debug.print("Unsupported type: {any}\n", .{field.type});
                                        // return error.UnsupportedType;
                                    },
                                }
                            }
                        }
                    }
                } else {
                    var fpos: u8 = 0;
                    inline for (info.fields) |field| {
                        if (!std.mem.startsWith(u8, field.name, "opt_")) {
                            if (fpos == pos) {
                                switch (field.type) {
                                    []const u8 => {
                                        @field(r, field.name) = arg;
                                    },
                                    ?[]const u8 => {
                                        @field(r, field.name) = arg;
                                    },
                                    else => {
                                        std.debug.print("Unsupported type: {any}\n", .{field.type});
                                        // return error.UnsupportedType;
                                    },
                                }
                            }
                            fpos += 1;
                        }
                    }
                    pos += 1;
                }
            }
        },
        else => |info| {
            std.debug.print("Unsupported type: {any}\n", .{info});
        },
    }

    return r;
}

const ArgIterator = struct {
    args: [][]const u8,
    index: usize,

    fn init(args: [][]const u8) ArgIterator {
        return ArgIterator{
            .args = args,
            .index = 1,
        };
    }

    fn next(self: *ArgIterator) ?[]const u8 {
        if (self.index >= self.args.len) {
            return null;
        }
        const arg = self.args[self.index];
        self.index += 1;
        return arg;
    }

    fn peek(self: *ArgIterator) ?[]const u8 {
        if (self.index >= self.args.len) {
            return null;
        }
        return self.args[self.index];
    }
};

test "parse with positional arguments" {
    std.debug.print("Test: parse with positional arguments\n", .{});
    var args = [_][]const u8{ "command_name", "test-01", "--env", "production", "--bench" };

    const actual = try parse(Cli, &args);
    std.debug.print("{any}\n", .{actual});
    const expected = Cli{
        .test_name = "test",
        .other_test_name = null,
        .opt_env = "production",
        .opt_benchmark = true,
    };

    try std.testing.expectEqual(expected, actual);
}

pub fn help_for(comptime T: type, writer: anytype) !void {
    const fields = std.meta.fields(T);
    var it = std.process.args();
    const program_name = std.fs.path.basename(it.next().?);

    var max_option_len: u32 = 0;
    var max_arg_len: u32 = 0;
    inline for (fields) |field| {
        if (std.mem.startsWith(u8, field.name, "opt_")) {
            if (field.type == bool) {
                max_option_len = @max(max_option_len, field.name.len - 4);
            } else {
                // twice the field name for the argument, plus 1 for space and 2 for brackets
                max_option_len = @max(max_arg_len, (field.name.len - 4) * 2 + 3);
            }
        } else {
            max_arg_len = @max(max_arg_len, field.name.len);
        }
    }

    //--- Usage
    try writer.print("Usage: {s}", .{program_name});
    var optionals = false;
    inline for (fields) |field| {
        if (std.mem.startsWith(u8, field.name, "opt_")) {
            if (@typeInfo(field.type) == .Optional or field.type == bool) {
                optionals = true;
            } else {
                try writer.print(" --{s}", .{field.name[4..]});
                if (field.type != bool) {
                    try writer.print(" <", .{});
                    for (field.name[4..]) |c| {
                        try writer.print("{c}", .{std.ascii.toUpper(c)});
                    }
                    try writer.print(">", .{});
                }
            }
        } else {
            if (@typeInfo(field.type) == .Optional or field.type == bool) {
                try writer.print(" [", .{});
            } else {
                try writer.print(" <", .{});
            }
            for (field.name) |c| {
                try writer.print("{c}", .{std.ascii.toUpper(c)});
            }
            if (@typeInfo(field.type) == .Optional) {
                try writer.print("]", .{});
            } else {
                try writer.print(">", .{});
            }
        }
    }

    //--- Options
    if (optionals) {
        try writer.print(" [OPTIONS]\n\nOptions:", .{});

        inline for (fields) |field| {
            if (std.mem.startsWith(u8, field.name, "opt_")) {
                try writer.print("\n  --{s}", .{field.name[4..]});

                if (field.type != bool) {
                    if (@typeInfo(field.type) == .Optional) {
                        try writer.print(" [", .{});
                    } else {
                        try writer.print(" <", .{});
                    }

                    for (field.name[4..]) |c| {
                        try writer.print("{c}", .{std.ascii.toUpper(c)});
                    }

                    if (@typeInfo(field.type) == .Optional) {
                        try writer.print("]", .{});
                    } else {
                        try writer.print(">", .{});
                    }
                }

                if (@hasDecl(T, "field_info")) {
                    if (@field(T.field_info, field.name)) |info| {
                        var len = field.name.len - 4;
                        if (field.type != bool) {
                            len = (field.name.len - 4) * 2 + 3;
                        }
                        for (0..(max_option_len - len)) |_| {
                            try writer.print(" ", .{});
                        }

                        try writer.print("  {s}", .{info});
                    }
                }
            }
        }
    }

    if (@hasDecl(T, "field_info")) {
        var header = true;
        inline for (fields) |field| {
            if (!std.mem.startsWith(u8, field.name, "opt_")) {
                if (header) {
                    header = false;
                    try writer.print("\n\nArguments:", .{});
                }
                if (@typeInfo(field.type) == .Optional) {
                    try writer.print("\n  [", .{});
                } else {
                    try writer.print("\n  <", .{});
                }
                for (field.name) |c| {
                    try writer.print("{c}", .{std.ascii.toUpper(c)});
                }

                if (@typeInfo(field.type) == .Optional) {
                    try writer.print("]", .{});
                } else {
                    try writer.print(">", .{});
                }

                if (@field(T.field_info, field.name)) |info| {
                    for (0..(max_arg_len - field.name.len)) |_| {
                        try writer.print(" ", .{});
                    }

                    try writer.print("  {s}", .{info});
                }
            }
        }
    }

    try writer.print("\n", .{});
}

test "help message with positional arguments" {
    const Params = struct {
        param_a: []const u8,
        param_b: []const u8,
    };

    const expected =
        \\Usage: test <PARAM_A> <PARAM_B>
        \\
    ;
    var l = std.ArrayList(u8).init(std.testing.allocator);
    defer l.deinit();

    try help_for(Params, l.writer());

    try std.testing.expectEqualStrings(expected, l.items);
}

test "help message with positional arguments with field info" {
    const Params = struct {
        param_a: []const u8,
        param_b: []const u8,

        pub const field_info = std.enums.EnumFieldStruct(std.meta.FieldEnum(@This()), ?[]const u8, @as(?[]const u8, null)){
            .param_a = "a info",
            .param_b = "b info",
        };
    };

    const expected =
        \\Usage: test <PARAM_A> <PARAM_B>
        \\
        \\Arguments:
        \\  <PARAM_A>  a info
        \\  <PARAM_B>  b info
        \\
    ;
    var l = std.ArrayList(u8).init(std.testing.allocator);
    defer l.deinit();

    try help_for(Params, l.writer());

    try std.testing.expectEqualStrings(expected, l.items);
}

test "help message with arguments" {
    const Params = struct {
        opt_two: []const u8,
        opt_one: []const u8,
    };

    const expected =
        \\Usage: test --two <TWO> --one <ONE>
        \\
    ;
    var l = std.ArrayList(u8).init(std.testing.allocator);
    defer l.deinit();

    try help_for(Params, l.writer());

    try std.testing.expectEqualStrings(expected, l.items);
}

test "help message with boolean argument" {
    const Params = struct {
        opt_flag: bool,
        opt_one: []const u8,
    };

    const expected =
        \\Usage: test --one <ONE> [OPTIONS]
        \\
        \\Options:
        \\  --flag
        \\  --one <ONE>
        \\
    ;
    var l = std.ArrayList(u8).init(std.testing.allocator);
    defer l.deinit();

    try help_for(Params, l.writer());

    try std.testing.expectEqualStrings(expected, l.items);
}

test "help message with mandatory and optional arguments" {
    const Params = struct {
        opt_two: []const u8,
        opt_one: []const u8,
        opt_name: ?[]const u8,
    };

    const expected =
        \\Usage: test --two <TWO> --one <ONE> [OPTIONS]
        \\
        \\Options:
        \\  --two <TWO>
        \\  --one <ONE>
        \\  --name [NAME]
        \\
    ;
    var l = std.ArrayList(u8).init(std.testing.allocator);
    defer l.deinit();

    try help_for(Params, l.writer());

    try std.testing.expectEqualStrings(expected, l.items);
}

test "help message with positional and non-positional arguments" {
    const Params = struct {
        name: []const u8,
        opt_height: u32,
        opt_flag: bool,
        opt_age: ?u32,
    };

    const expected =
        \\Usage: test <NAME> --height <HEIGHT> [OPTIONS]
        \\
        \\Options:
        \\  --height <HEIGHT>
        \\  --flag
        \\  --age [AGE]
        \\
    ;
    var l = std.ArrayList(u8).init(std.testing.allocator);
    defer l.deinit();

    try help_for(Params, l.writer());

    try std.testing.expectEqualStrings(expected, l.items);
}

test "help message with arguments and field info" {
    const Params = struct {
        opt_env: []const u8,
        opt_bench: bool,
        opt_name: ?[]const u8,

        pub const field_info = std.enums.EnumFieldStruct(std.meta.FieldEnum(@This()), ?[]const u8, @as(?[]const u8, null)){
            .opt_env = "test environment",
            .opt_bench = "run the test as a benchmark",
            .opt_name = "name info",
        };
    };

    const expected =
        \\Usage: test --env <ENV> [OPTIONS]
        \\
        \\Options:
        \\  --env <ENV>    test environment
        \\  --bench        run the test as a benchmark
        \\  --name [NAME]  name info
        \\
    ;
    var l = std.ArrayList(u8).init(std.testing.allocator);
    defer l.deinit();

    try help_for(Params, l.writer());

    try std.testing.expectEqualStrings(expected, l.items);
}
