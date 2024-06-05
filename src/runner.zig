const std = @import("std");
const json = std.json;
const Allocator = std.mem.Allocator;

const RamEntry = struct {
    address: u16,
    value: u8,
};

const State = struct {
    pc: u16,
    sp: u16,
    a: u8,
    b: u8,
    c: u8,
    d: u8,
    e: u8,
    f: u8,
    h: u8,
    l: u8,
    i: u8,
    r: u8,
    ei: u8,
    wz: u16,
    ix: u16,
    iy: u16,
    af_: u16,
    bc_: u16,
    de_: u16,
    hl_: u16,
    im: u8,
    p: u8,
    q: u8,
    iff1: u8,
    iff2: u8,
    ram: []RamEntry,
};

const Cycle = struct {
    address: u16,
    value: ?u8,
    code: []const u8,
};

const Test = struct {
    name: []const u8,
    initial: State,
    final: State,
    cycles: []Cycle,
};

fn parseRamEntry(entry: json.Value) !RamEntry {
    const address = entry[0].?.integer;
    const value = entry[1].?.integer;
    return RamEntry{
        .address = @as(u16, address),
        .value = @as(u8, value),
    };
}

fn parseState(alloc: Allocator, node: json.Value) !State {
    const obj = node.object;

    return State{
        .pc = @as(u16, @intCast(obj.get("pc").?.integer)),
        .sp = @as(u16, @intCast(obj.get("sp").?.integer)),
        .a = @as(u8, @intCast(obj.get("a").?.integer)),
        .b = @as(u8, @intCast(obj.get("b").?.integer)),
        .c = @as(u8, @intCast(obj.get("c").?.integer)),
        .d = @as(u8, @intCast(obj.get("d").?.integer)),
        .e = @as(u8, @intCast(obj.get("e").?.integer)),
        .f = @as(u8, @intCast(obj.get("f").?.integer)),
        .h = @as(u8, @intCast(obj.get("h").?.integer)),
        .l = @as(u8, @intCast(obj.get("l").?.integer)),
        .i = @as(u8, @intCast(obj.get("i").?.integer)),
        .r = @as(u8, @intCast(obj.get("r").?.integer)),
        .ei = @as(u8, @intCast(obj.get("ei").?.integer)),
        .wz = @as(u16, @intCast(obj.get("wz").?.integer)),
        .ix = @as(u16, @intCast(obj.get("ix").?.integer)),
        .iy = @as(u16, @intCast(obj.get("iy").?.integer)),
        .af_ = @as(u16, @intCast(obj.get("af_").?.integer)),
        .bc_ = @as(u16, @intCast(obj.get("bc_").?.integer)),
        .de_ = @as(u16, @intCast(obj.get("de_").?.integer)),
        .hl_ = @as(u16, @intCast(obj.get("hl_").?.integer)),
        .im = @as(u8, @intCast(obj.get("im").?.integer)),
        .p = @as(u8, @intCast(obj.get("p").?.integer)),
        .q = @as(u8, @intCast(obj.get("q").?.integer)),
        .iff1 = @as(u8, @intCast(obj.get("iff1").?.integer)),
        .iff2 = @as(u8, @intCast(obj.get("iff2").?.integer)),
        .ram = try parseRamEntries(alloc, obj.get("ram").?.array),
    };
}

fn parseRamEntries(alloc: Allocator, entries: std.ArrayList(json.Value)) ![]RamEntry {
    var results = std.ArrayList(RamEntry).init(alloc);
    defer results.deinit();

    for (entries.items) |item| {
        const entry = item.array.items;
        try results.append(RamEntry{
            .address = @as(u16, @intCast(entry[0].integer)),
            .value = @as(u8, @intCast(entry[1].integer)),
        });
    }

    return results.items;
}

fn parseCycles(alloc: Allocator, entries: std.ArrayList(json.Value)) ![]Cycle {
    var results = std.ArrayList(Cycle).init(alloc);
    defer results.deinit();

    for (entries.items) |item| {
        const entry = item.array.items;
        const value = switch (entry[1]) {
            .integer => @as(u8, @intCast(entry[1].integer)),
            else => return undefined,
        };

        try results.append(Cycle{
            .address = @as(u16, @intCast(entry[0].integer)),
            .value = value,
            .code = entry[2].string,
        });
    }

    return results.items;
}

fn parseTest(alloc: Allocator, node: json.Value) !Test {
    const obj = node.object;
    return Test{
        .name = obj.get("name").?.string,
        .initial = try parseState(alloc, obj.get("initial").?),
        .final = try parseState(alloc, obj.get("final").?),
        .cycles = try parseCycles(alloc, obj.get("cycles").?.array),
    };
}

pub fn runTest(alloc: Allocator, path: []const u8) !void {
    const file = try std.fs.cwd().openFile(path, .{});
    defer file.close();

    const stat = try file.stat();
    const contents = try file.readToEndAlloc(alloc, stat.size);
    defer alloc.free(contents);

    var parsed = try json.parseFromSlice(json.Value, alloc, contents, .{});
    defer parsed.deinit();

    const tests = parsed.value.array;
    std.debug.assert(tests.items.len == 1000);

    for (tests.items) |item| {
        const t = try parseTest(alloc, item);
        std.debug.print("Test: {any}\n\n", .{t});
    }
}
