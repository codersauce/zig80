const std = @import("std");
const Allocator = std.mem.Allocator;

const Cli = struct {
    test_name: []const u8,
    other_test_name: ?[]const u8,
    opt_env: ?[]const u8 = null,
    opt_benchmark: bool = false,

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

    const cli = try parse(Cli, args);
    std.debug.print("{any}\n", .{cli});
}

pub fn parse(comptime T: type, args: []const [:0]const u8) !?T {
    for (args) |arg| {
        if (std.mem.eql(u8, arg, "--help")) {
            const stdout = std.fs.File.stdout();
            var buffer: [4096]u8 = undefined;
            var file_writer = stdout.writer(&buffer);
            try help_for(T, &file_writer.interface);
            file_writer.interface.flush() catch {};
            return null;
        }
    }

    var r: T = undefined;

    switch (@typeInfo(T)) {
        .@"union" => |data| {
            inline for (data.fields) |field| {
                if (std.mem.eql(u8, args[1], field.name)) {
                    // let's assemble the subcommand structure
                    const subcommand = try parse(field.type, args[1..]);
                    return @unionInit(T, field.name, subcommand.?);
                }
            }
        },
        .@"struct" => |info| {
            var fields_seen = [_]bool{false} ** info.fields.len;
            var it = ArgIterator.init(args);
            var pos: usize = 0;

            while (true) {
                const arg_try = it.next();
                if (arg_try == null) {
                    break;
                }

                const arg = arg_try.?;
                if (std.mem.startsWith(u8, arg, "--")) {
                    inline for (info.fields, 0..) |field, i| {
                        if (std.mem.startsWith(u8, field.name, "opt_")) {
                            if (std.mem.eql(u8, arg[2..], field.name[4..])) {
                                switch (field.type) {
                                    []const u8 => {
                                        fields_seen[i] = true;
                                        const value = it.next();
                                        if (value == null) {
                                            return error.InvalidParam;
                                        }
                                        @field(r, field.name) = value.?;
                                    },
                                    ?[]const u8 => {
                                        fields_seen[i] = true;
                                        const value = it.next();
                                        if (value == null) {
                                            return error.InvalidParam;
                                        }
                                        @field(r, field.name) = value.?;
                                    },
                                    bool => {
                                        fields_seen[i] = true;
                                        @field(r, field.name) = true;
                                    },
                                    ?u32 => {
                                        fields_seen[i] = true;
                                        const value = it.next();
                                        if (value == null) {
                                            return error.InvalidParam;
                                        }
                                        @field(r, field.name) = try std.fmt.parseInt(u32, value.?, 10);
                                    },
                                    else => |subtype| {
                                        std.log.err("Unsupported option type '{any}' for '{s}'", .{ subtype, field.name });
                                        return error.UnsupportedType;
                                    },
                                }
                            }
                        }
                    }
                } else {
                    var fpos: u8 = 0;
                    inline for (info.fields, 0..) |field, i| {
                        if (!std.mem.startsWith(u8, field.name, "opt_")) {
                            if (fpos == pos) {
                                switch (field.type) {
                                    []const u8 => {
                                        fields_seen[i] = true;
                                        @field(r, field.name) = arg;
                                    },
                                    ?[]const u8 => {
                                        fields_seen[i] = true;
                                        @field(r, field.name) = arg;
                                    },
                                    ?u32 => {
                                        fields_seen[i] = true;
                                        @field(r, field.name) = try std.fmt.parseInt(u32, arg, 10);
                                    },
                                    bool => {
                                        return error.InvalidParam;
                                    },
                                    else => {
                                        // Check if it's a union or struct type that should be recursively parsed
                                        if (@typeInfo(field.type) == .@"union" or @typeInfo(field.type) == .@"struct") {
                                            const res = try parse(field.type, args);
                                            if (res == null) {
                                                std.log.err("res: {any}\n", .{res});
                                                return error.UnsupportedType;
                                            }
                                            fields_seen[i] = true;
                                            @field(r, field.name) = res.?;
                                        } else {
                                            std.log.err("Unsupported positional type '{any}' for '{s}'", .{ field.type, field.name });
                                            return error.UnsupportedType;
                                        }
                                    },
                                }
                            }
                            fpos += 1;
                        }
                    }
                    pos += 1;
                }
            }
            try fillDefaultStructValues(T, &r, &fields_seen);
        },
        else => {
            return error.UnsupportedType;
        },
    }

    return r;
}

fn fillDefaultStructValues(comptime T: type, r: *T, fields_seen: *[@typeInfo(T).@"struct".fields.len]bool) !void {
    inline for (@typeInfo(T).@"struct".fields, 0..) |field, i| {
        if (!fields_seen[i]) {
            if (field.defaultValue()) |default| {
                @field(r, field.name) = default;
            } else {
                if (@typeInfo(field.type) == .optional) {
                    @field(r, field.name) = null;
                } else if (field.type == bool) {
                    @field(r, field.name) = false;
                } else {
                    std.log.err("Missing field '{s}'\n", .{field.name});
                    return error.MissingField;
                }
            }
        }
    }
}

const ArgIterator = struct {
    args: []const [:0]const u8,
    index: usize,

    fn init(args: []const [:0]const u8) ArgIterator {
        return ArgIterator{
            .args = args,
            .index = 1,
        };
    }

    fn next(self: *ArgIterator) ?[:0]const u8 {
        if (self.index >= self.args.len) {
            return null;
        }
        const arg = self.args[self.index];
        self.index += 1;
        return arg;
    }

    fn peek(self: *ArgIterator) ?[:0]const u8 {
        if (self.index >= self.args.len) {
            return null;
        }
        return self.args[self.index];
    }
};

pub fn help_for(comptime T: type, writer: anytype) !void {
    const fields = std.meta.fields(T);
    var it = std.process.args();
    const program_name = std.fs.path.basename(it.next().?);

    var max_option_len: u32 = 0;
    var max_arg_len: u32 = 0;
    inline for (fields) |field| {
        if (std.mem.startsWith(u8, field.name, "opt_")) {
            std.debug.print("len: {s}\n", .{field.name});
            if (field.name.len < 4) {
                std.log.err("Invalid field len '{s}'\n", .{field.name});
            } else {
                if (field.type == bool) {
                    max_option_len = @max(max_option_len, field.name.len - 4);
                } else {
                    // twice the field name for the argument, plus 1 for space and 2 for brackets
                    max_option_len = @max(max_arg_len, (field.name.len - 4) * 2 + 3);
                }
            }
        } else {
            max_arg_len = @max(max_arg_len, field.name.len);
        }
    }

    //--- Usage
    try writer.print("Usage: {s}", .{program_name});
    var optionals = false;
    var command = false;
    inline for (fields) |field| {
        if (std.mem.startsWith(u8, field.name, "opt_")) {
            if (@typeInfo(field.type) == .optional or field.type == bool) {
                optionals = true;
            } else {
                if (field.name.len < 4) {
                    std.log.err("Invalid field len '{s}'\n", .{field.name});
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
            }
        } else {
            if (@typeInfo(field.type) == .@"union") {
                command = true;
                try writer.print(" <COMMAND>", .{});
            } else {
                if (@typeInfo(field.type) == .optional or field.type == bool) {
                    try writer.print(" [", .{});
                } else {
                    try writer.print(" <", .{});
                }
                for (field.name) |c| {
                    try writer.print("{c}", .{std.ascii.toUpper(c)});
                }
                if (@typeInfo(field.type) == .optional or field.type == bool) {
                    try writer.print("]", .{});
                } else {
                    try writer.print(">", .{});
                }
            }
        }
    }

    if (optionals) {
        try writer.print(" [OPTIONS]", .{});
    }
    try writer.print("\n", .{});

    //--- Subcommands
    if (command) {
        try writer.print("\nCommands:", .{});
        inline for (fields) |field| {
            if (@typeInfo(field.type) == .@"union") {
                const subfields = std.meta.fields(field.type);
                var max_command_len: u8 = 0;

                inline for (subfields) |subfield| {
                    max_command_len = @max(max_command_len, subfield.name.len);
                }

                inline for (subfields, 0..) |subfield, i| {
                    try writer.print("\n  {s}", .{subfield.name});

                    if (@hasDecl(field.type, "field_info")) {
                        if (field.type.field_info.len >= i) {
                            const info = field.type.field_info[i];
                            for (0..(max_command_len - subfield.name.len)) |_| {
                                try writer.print(" ", .{});
                            }
                            try writer.print("  {s}", .{info});
                        }
                    }
                }
            }
        }
        // try writer.print("\n", .{});
    }

    //--- Options
    if (optionals) {
        try writer.print("\nOptions:", .{});

        inline for (fields) |field| {
            if (std.mem.startsWith(u8, field.name, "opt_")) {
                // try writer.print("\n  --{s}", .{field.name[4..]});

                if (field.type != bool) {
                    if (@typeInfo(field.type) == .optional) {
                        try writer.print(" [", .{});
                    } else {
                        try writer.print(" <", .{});
                    }

                    // for (field.name[4..]) |c| {
                    //     try writer.print("{c}", .{std.ascii.toUpper(c)});
                    // }

                    if (@typeInfo(field.type) == .optional) {
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

    //-- Positional arguments
    if (@hasDecl(T, "field_info")) {
        var header = true;
        inline for (fields) |field| {
            if (!std.mem.startsWith(u8, field.name, "opt_")) {
                if (header) {
                    header = false;
                    try writer.print("\n\nArguments:", .{});
                }
                if (@typeInfo(field.type) == .optional) {
                    try writer.print("\n  [", .{});
                } else {
                    try writer.print("\n  <", .{});
                }
                for (field.name) |c| {
                    try writer.print("{c}", .{std.ascii.toUpper(c)});
                }

                if (@typeInfo(field.type) == .optional) {
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

test "help message with optional positional args" {
    const Options = struct {
        test_name: ?[]const u8,
        benchmark: bool,
    };

    const expected =
        \\Usage: test [TEST_NAME] [BENCHMARK]
        \\
    ;

    var l = std.ArrayList(u8).init(std.testing.allocator);
    defer l.deinit();

    try help_for(Options, l.writer());

    try std.testing.expectEqualStrings(expected, l.items);
}

test "help message with mandatory and optional positional args" {
    const Options = struct {
        test_name: []const u8,
        benchmark: bool,
    };

    const expected =
        \\Usage: test <TEST_NAME> [BENCHMARK]
        \\
    ;

    var l = std.ArrayList(u8).init(std.testing.allocator);
    defer l.deinit();

    try help_for(Options, l.writer());

    try std.testing.expectEqualStrings(expected, l.items);
}

test "help message with subcommand" {
    const TestCmd = struct {
        name: ?[]const u8,
        opt_env: ?[]const u8,
        opt_benchmark: bool,
    };

    const ShowCmd = struct {
        name: []const u8,
    };

    const SubcommandTag = enum {
        @"test",
        display,
    };

    const Subcommand = union(SubcommandTag) {
        @"test": TestCmd,
        display: ShowCmd,

        pub const field_info = .{
            "executes a test",
            "shows something",
        };
    };

    const Cmd = struct {
        subcommand: Subcommand,
        opt_verbose: bool,
    };

    var l = std.ArrayList(u8).init(std.testing.allocator);
    defer l.deinit();

    try help_for(Cmd, l.writer());

    const expected =
        \\Usage: test <COMMAND> [OPTIONS]
        \\
        \\Commands:
        \\  test     executes a test
        \\  display  shows something
        \\
        \\Options:
        \\  --verbose
        \\
    ;

    try std.testing.expectEqualStrings(expected, l.items);
}

test "parse with positional arguments" {
    var args = [_][]const u8{ "command_name", "test-01", "--env", "production", "--benchmark" };

    const actual = try parse(Cli, &args);
    // std.debug.print("{any}\n", .{actual});
    const expected = Cli{
        .test_name = "test-01",
        .other_test_name = null,
        .opt_env = "production",
        .opt_benchmark = true,
    };

    try std.testing.expectEqual(expected, actual.?);
}

test "parse with option missing an argument" {
    var args = [_][]const u8{ "command_name", "test-01", "--env" };

    try std.testing.expectError(error.InvalidParam, parse(Cli, &args));
}

test "parse with default values" {
    var args = [_][]const u8{ "command_name", "test-01" };

    const actual = try parse(Cli, &args);
    const expected = Cli{
        .test_name = "test-01",
        .other_test_name = null,
        .opt_env = null,
        .opt_benchmark = false,
    };

    try std.testing.expectEqual(expected, actual.?);
}

test "parse with only optional args" {
    const Options = struct {
        test_name: ?[]const u8,
        benchmark: bool,
    };

    var args = [_][]const u8{"command_name"};

    const actual = try parse(Options, &args);
    const expected = Options{
        .test_name = null,
        .benchmark = false,
    };

    try std.testing.expectEqual(expected, actual.?);
}

test "parse struct as first subcommand" {
    const TestCmd = struct {
        name: ?[]const u8,
        opt_env: ?[]const u8,
        opt_benchmark: bool,
    };

    const ShowCmd = struct {
        name: []const u8,
    };

    const SubcommandTag = enum {
        @"test",
        show,
    };

    const Subcommand = union(SubcommandTag) {
        @"test": TestCmd,
        show: ShowCmd,
    };

    const Cmd = struct {
        subcommand: Subcommand,
        opt_verbose: bool,
    };

    var args = [_][]const u8{ "command_name", "test", "test-01", "--env", "production", "--benchmark" };

    const expected = Cmd{
        .subcommand = Subcommand{
            .@"test" = TestCmd{
                .name = "test-01",
                .opt_env = "production",
                .opt_benchmark = true,
            },
        },
        .opt_verbose = false,
    };
    const actual = try parse(Cmd, &args);

    try std.testing.expectEqual(expected, actual.?);
}

test "parse struct as second subcommand" {
    const TestCmd = struct {
        name: ?[]const u8,
        opt_env: ?[]const u8,
        opt_benchmark: bool,
    };

    const ShowCmd = struct {
        name: []const u8,
    };

    const SubcommandTag = enum {
        @"test",
        show,
    };

    const Subcommand = union(SubcommandTag) {
        @"test": TestCmd,
        show: ShowCmd,
    };

    const Cmd = struct {
        subcommand: Subcommand,
        opt_verbose: bool,
    };

    var args = [_][]const u8{ "command_name", "show", "test-01" };

    const expected = Cmd{
        .subcommand = Subcommand{
            .show = ShowCmd{
                .name = "test-01",
            },
        },
        .opt_verbose = false,
    };
    const actual = try parse(Cmd, &args);

    try std.testing.expectEqual(expected, actual.?);
}

test "help for complex struct" {
    const Commands = enum {
        run,
        show,
    };

    const RunCmd = struct {
        test_name: ?[]const u8,
        opt_bench: bool,
        opt_both: bool,
    };

    const ShowCmd = struct {
        test_name: []const u8,
    };

    const Command = union(Commands) {
        run: RunCmd,
        show: ShowCmd,

        pub const field_info = .{
            "execute tests",
            "display information about a test",
        };
    };

    const Options = struct {
        command: Command,
    };

    var l = std.ArrayList(u8).init(std.testing.allocator);
    defer l.deinit();

    try help_for(Options, l.writer());

    const expected =
        \\Usage: test <COMMAND>
        \\
        \\Commands:
        \\  run   execute tests
        \\  show  display information about a test
        \\
    ;

    try std.testing.expectEqualStrings(expected, l.items);
    std.debug.print("{s}\n", .{l.items});
}
