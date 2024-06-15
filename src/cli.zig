const std = @import("std");
const Allocator = std.mem.Allocator;

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

pub fn parse(args: [][]const u8, comptime T: type, obj: *T) !bool {
    const fields = std.meta.fields(T);
    var it = ArgIterator.init(args);

    const first_arg = it.peek();
    if (first_arg != null and std.mem.eql(u8, first_arg.?, "--help")) {
        std.debug.print("Usage: {s}", .{args[0]});

        inline for (fields) |field| {
            const optional = @typeInfo(field.type) == .Optional or field.type == bool;
            if (optional) {
                std.debug.print(" [", .{});
            } else {
                std.debug.print(" ", .{});
            }
            std.debug.print("{s}", .{"--" ++ field.name});
            switch (field.type) {
                ?u32 => {
                    std.debug.print(" <u32>", .{});
                },
                u32 => {
                    std.debug.print(" <u32>", .{});
                },
                ?[]const u8 => {
                    std.debug.print(" <string>", .{});
                },
                []const u8 => {
                    std.debug.print(" <string>", .{});
                },
                bool => {},
                else => {},
            }
            if (optional) {
                std.debug.print("]", .{});
            }
        }

        std.debug.print("\n", .{});
        return false;
    }

    while (it.next()) |arg| {
        inline for (fields) |field| {
            const name = "--" ++ field.name;
            if (std.mem.eql(u8, arg, name)) {
                switch (field.type) {
                    ?u32 => {
                        const val = it.next();
                        if (val != null) {
                            @field(obj, field.name) = try std.fmt.parseInt(u32, val.?, 10);
                        }
                    },
                    u32 => {
                        const val = it.next() orelse return std.debug.panic("missing value for {s}\n", .{field.name});
                        @field(obj, field.name) = try std.fmt.parseInt(u32, val, 10);
                    },
                    ?[]const u8 => {
                        const val = it.next();
                        if (val != null) {
                            @field(obj, field.name) = val.?;
                        }
                    },
                    []const u8 => {
                        const val = it.next() orelse return std.debug.panic("missing value for {s}\n", .{field.name});
                        std.debug.print("val={s}\n", .{val});
                        @field(obj, field.name) = val;
                    },
                    bool => {
                        @field(obj, field.name) = true;
                    },
                    else => {},
                }
            }
        }
    }

    return true;
}

const Options = struct {
    num: ?u32,
    name: ?[]const u8,
    include: bool = false,

    pub fn init() Options {
        return Options{
            .num = null,
            .name = null,
            .include = false,
        };
    }
};

test "all arguments present" {
    var args: [5][]const u8 = .{
        "--num",     "42",
        "--name",    "hello",
        "--include",
    };

    var opts = Options.init();
    try parse(&args, Options, &opts);

    try std.testing.expect(opts.num == 42);
    try std.testing.expect(std.mem.eql(u8, opts.name.?, "hello"));
    try std.testing.expect(opts.include == true);
}

test "no arguments present" {
    var args = [_][]const u8{};

    var opts = Options.init();
    try parse(&args, Options, &opts);

    try std.testing.expect(opts.num == null);
    try std.testing.expect(opts.name == null);
    try std.testing.expect(opts.include == false);
}

test "some arguments present" {
    var args = [_][]const u8{
        "--num",     "42",
        "--include",
    };

    var opts = Options.init();
    try parse(&args, Options, &opts);

    try std.testing.expect(opts.num == 42);
    try std.testing.expect(opts.name == null);
    try std.testing.expect(opts.include == true);
}
