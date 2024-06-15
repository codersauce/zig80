const std = @import("std");
const Allocator = std.mem.Allocator;

const ArgIterator = struct {
    args: [][]const u8,
    index: usize,

    fn init(args: [][]const u8) ArgIterator {
        return ArgIterator{
            .args = args,
            .index = 0,
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
};

pub fn parse(args: [][]const u8, comptime T: type, obj: *T) !void {
    var it = ArgIterator.init(args);
    const fields = std.meta.fields(T);
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
