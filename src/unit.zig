const std = @import("std");
const cpu_import = @import("cpu.zig");
const utils = @import("utils.zig");
const cli = @import("cli.zig");
const c = @import("Z80.zig");

const Allocator = std.mem.Allocator;
const Z80 = cpu_import.Z80;
const Flag = cpu_import.Flag;

const Options = struct {
    benchmark: bool,
};

pub fn main() !void {
    var gpa = std.heap.GeneralPurposeAllocator(.{ .safety = true }){};
    defer _ = gpa.deinit();

    const alloc = gpa.allocator();

    const args = try std.process.argsAlloc(alloc);
    defer std.process.argsFree(alloc, args);

    var options = Options{ .benchmark = false };
    if (!try cli.parse(args, Options, &options)) {
        return;
    }

    const tests = try loadTests(alloc);
    defer tests.deinit();

    const results = try loadTestResults(alloc);
    defer results.deinit();

    if (options.benchmark) {
        for (tests.value, 0..) |t, n| {
            const r = results.value[n];
            runBenchmark(t, r);
        }
        return;
    }

    var cpu = Z80.init(alloc);
    for (tests.value, 0..) |t, n| {
        std.debug.print("Running test '{s}'...\n", .{t.name});
        loadTest(&cpu, t);
        // TODO: execute n steps (based on memory?)
        cpu.execute();

        const r = results.value[n];
        compareResult(&cpu, r);
    }
}

fn runBenchmark(t: TestCase, result: TestResult) void {
    var cpu = c.Z80{};
    var memory = [_]u8{0} ** 0x10000;
    loadBench(&cpu, t, &memory);
    std.debug.print("Running test '{s}'...\n", .{t.name});

    const read = struct {
        fn read(context: ?*anyopaque, address: c_ushort) callconv(.C) u8 {
            const mem: *[0x10000]u8 = @ptrCast(@alignCast(context.?));
            return mem[address];
        }
    }.read;

    const write = struct {
        fn write(context: ?*anyopaque, address: c_ushort, value: u8) callconv(.C) void {
            const mem: *[0x10000]u8 = @ptrCast(@alignCast(context.?));
            mem[address] = value;
        }
    }.write;

    const writePort = struct {
        fn writePort(context: ?*anyopaque, port: c_ushort, value: u8) callconv(.C) void {
            _ = context;
            std.debug.print("Writing to port 0x{X:0>2}\n", .{port});
            std.debug.print("  Value: 0x{X:0>2}\n", .{value});
        }
    }.writePort;

    const readPort = struct {
        fn readPort(context: ?*anyopaque, port: c_ushort) callconv(.C) u8 {
            _ = context;
            std.debug.print("Reading from port 0x{X:0>2}\n", .{port});
            return 0;
        }
    }.readPort;

    cpu.read = read;
    cpu.fetch = read;
    cpu.write = write;
    cpu.fetch_opcode = read;
    cpu.in = readPort;
    cpu.out = writePort;
    cpu.context = &memory;
    _ = c.z80_run(&cpu, 1);

    compareBenchResult(&cpu, result, &memory);
}

fn compareBenchResult(cpu: *c.Z80, result: TestResult, memory: *[0x10000]u8) void {
    if (result.state.af != cpu.af.uint16_value) {
        std.debug.print("AF mismatch: expected 0x{X:0>4}, got 0x{X:0>4}\n", .{ result.state.af, cpu.af.uint16_value });
        var expected_flag = Flag.init(utils.lo(result.state.afDash));
        var actual_flag = Flag.init(utils.lo(cpu.af.uint16_value));
        std.debug.print("  expected: ", .{});
        expected_flag.dump();
        std.debug.print("  actual:   ", .{});
        actual_flag.dump();
    }

    if (result.state.bc != cpu.bc.uint16_value) {
        std.debug.print("BC mismatch: expected 0x{X:0>4}, got 0x{X:0>4}\n", .{ result.state.bc, cpu.bc.uint16_value });
    }

    if (result.state.de != cpu.de.uint16_value) {
        std.debug.print("DE mismatch: expected 0x{X:0>4}, got 0x{X:0>4}\n", .{ result.state.de, cpu.de.uint16_value });
    }

    if (result.state.hl != cpu.hl.uint16_value) {
        std.debug.print("HL mismatch: expected 0x{X:0>4}, got 0x{X:0>4}\n", .{ result.state.hl, cpu.hl.uint16_value });
    }

    if (result.state.afDash != cpu.af_.uint16_value) {
        std.debug.print("AF' mismatch: expected 0x{X:0>4}, got 0x{X:0>4}\n", .{ result.state.afDash, cpu.af_.uint16_value });
    }

    if (result.state.bcDash != cpu.bc_.uint16_value) {
        std.debug.print("BC' mismatch: expected 0x{X:0>4}, got 0x{X:0>4}\n", .{ result.state.bcDash, cpu.bc_.uint16_value });
    }

    if (result.state.deDash != cpu.de_.uint16_value) {
        std.debug.print("DE' mismatch: expected 0x{X:0>4}, got 0x{X:0>4}\n", .{ result.state.deDash, cpu.de_.uint16_value });
    }

    if (result.state.hlDash != cpu.hl_.uint16_value) {
        std.debug.print("HL' mismatch: expected 0x{X:0>4}, got 0x{X:0>4}\n", .{ result.state.hlDash, cpu.hl_.uint16_value });
    }

    // if (result.state.ix != cpu.ix.uint16_value) {
    //     std.debug.print("IX mismatch: expected 0x{X:0>4}, got 0x{X:0>4}\n", .{ result.state.ix, cpu.ix.uint16_value });
    // }
    //
    // if (result.state.iy != cpu.iy.uint16_value) {
    //     std.debug.print("IY mismatch: expected 0x{X:0>4}, got 0x{X:0>4}\n", .{ result.state.iy, cpu.iy.uint16_value });
    // }

    if (result.state.sp != cpu.sp.uint16_value) {
        std.debug.print("SP mismatch: expected 0x{X:0>4}, got 0x{X:0>4}\n", .{ result.state.sp, cpu.sp.uint16_value });
    }

    if (result.state.pc != cpu.pc.uint16_value) {
        std.debug.print("PC mismatch: expected 0x{X:0>4}, got 0x{X:0>4}\n", .{ result.state.pc, cpu.pc.uint16_value });
    }

    if (result.state.i != cpu.i) {
        std.debug.print("I mismatch: expected 0x{X:0>4}, got 0x{X:0>4}\n", .{ result.state.i, cpu.i });
    }

    if (result.state.r != cpu.r) {
        std.debug.print("R mismatch: expected 0x{X:0>4}, got 0x{X:0>4}\n", .{ result.state.r, cpu.r });
    }

    // if (result.state.iff1 != cpu.iff1) {
    //     std.debug.print("IFF1 mismatch: expected {}, got {}\n", .{ result.state.iff1, cpu.iff1 });
    // }
    //
    // if (result.state.iff2 != cpu.iff2) {
    //     std.debug.print("IFF2 mismatch: expected {}, got {}\n", .{ result.state.iff2, cpu.iff2 });
    // }
    //
    // if (result.state.im != cpu.im) {
    //     std.debug.print("IM mismatch: expected 0x{X:0>4}, got 0x{X:0>4}\n", .{ result.state.im, cpu.im });
    // }
    //
    // if (result.state.halted != cpu.halt_line) {
    //     std.debug.print("Halted mismatch: expected {}, got {}\n", .{ result.state.halted, cpu.halt_line });
    // }
    //
    // if (result.state.tStates != cpu.cycles - 1) {
    //     std.debug.print("TStates mismatch: expected {d}, got {d}\n", .{ result.state.tStates, cpu.cycles - 1 });
    // }
    //

    if (result.memory) |mem| {
        for (mem) |m| {
            const expected = m.data;
            const actual = memory[m.address .. m.address + expected.len];
            if (!std.mem.eql(u8, expected, actual)) {
                std.debug.print("Memory mismatch at 0x{X:0>4}:\n", .{m.address});
                for (expected, actual) |e, a| {
                    if (e != a) {
                        std.debug.print("  Expected 0x{X:0>2}, got 0x{X:0>2}\n", .{ e, a });
                    }
                }
            }
        }
    }
}

fn loadBench(cpu: *c.Z80, t: TestCase, memory: *[0x10000]u8) void {
    cpu.af.uint16_value = t.state.af;
    cpu.bc.uint16_value = t.state.bc;
    cpu.de.uint16_value = t.state.de;
    cpu.hl.uint16_value = t.state.hl;
    cpu.af_.uint16_value = t.state.afDash;
    cpu.bc_.uint16_value = t.state.bcDash;
    cpu.de_.uint16_value = t.state.deDash;
    cpu.hl_.uint16_value = t.state.hlDash;
    // cpu.ix.uint16_value = t.state.ix;
    // cpu.iy.uint16_value = t.state.iy;
    cpu.sp.uint16_value = t.state.sp;
    cpu.pc.uint16_value = t.state.pc;
    // cpu.memptr = t.state.memptr;
    cpu.i = t.state.i;
    cpu.r = t.state.r;
    cpu.iff1 = if (t.state.iff1) 1 else 0;
    cpu.iff2 = if (t.state.iff2) 1 else 0;
    cpu.im = t.state.im;
    cpu.halt_line = if (t.state.halted) 1 else 0;

    for (t.memory) |m| {
        @memcpy(memory[m.address .. m.address + m.data.len], m.data);
    }
}

fn compareResult(cpu: *Z80, result: TestResult) void {
    if (result.state.af != cpu.af) {
        std.debug.print("AF mismatch: expected 0x{X:0>4}, got 0x{X:0>4}\n", .{ result.state.af, cpu.af });
        var expected_flag = Flag.init(utils.lo(result.state.afDash));
        var actual_flag = Flag.init(utils.lo(cpu.getF()));
        std.debug.print("  expected: ", .{});
        expected_flag.dump();
        std.debug.print("  actual:   ", .{});
        actual_flag.dump();
    }

    if (result.state.bc != cpu.bc) {
        std.debug.print("BC mismatch: expected 0x{X:0>4}, got 0x{X:0>4}\n", .{ result.state.bc, cpu.bc });
    }

    if (result.state.de != cpu.de) {
        std.debug.print("DE mismatch: expected 0x{X:0>4}, got 0x{X:0>4}\n", .{ result.state.de, cpu.de });
    }

    if (result.state.hl != cpu.hl) {
        std.debug.print("HL mismatch: expected 0x{X:0>4}, got 0x{X:0>4}\n", .{ result.state.hl, cpu.hl });
    }

    if (result.state.afDash != cpu.af_) {
        std.debug.print("AF' mismatch: expected 0x{X:0>4}, got 0x{X:0>4}\n", .{ result.state.afDash, cpu.af_ });
    }

    if (result.state.bcDash != cpu.bc_) {
        std.debug.print("BC' mismatch: expected 0x{X:0>4}, got 0x{X:0>4}\n", .{ result.state.bcDash, cpu.bc_ });
    }

    if (result.state.deDash != cpu.de_) {
        std.debug.print("DE' mismatch: expected 0x{X:0>4}, got 0x{X:0>4}\n", .{ result.state.deDash, cpu.de_ });
    }

    if (result.state.hlDash != cpu.hl_) {
        std.debug.print("HL' mismatch: expected 0x{X:0>4}, got 0x{X:0>4}\n", .{ result.state.hlDash, cpu.hl_ });
    }

    if (result.state.ix != cpu.ix) {
        std.debug.print("IX mismatch: expected 0x{X:0>4}, got 0x{X:0>4}\n", .{ result.state.ix, cpu.ix });
    }

    if (result.state.iy != cpu.iy) {
        std.debug.print("IY mismatch: expected 0x{X:0>4}, got 0x{X:0>4}\n", .{ result.state.iy, cpu.iy });
    }

    if (result.state.sp != cpu.sp) {
        std.debug.print("SP mismatch: expected 0x{X:0>4}, got 0x{X:0>4}\n", .{ result.state.sp, cpu.sp });
    }

    if (result.state.pc != cpu.pc) {
        std.debug.print("PC mismatch: expected 0x{X:0>4}, got 0x{X:0>4}\n", .{ result.state.pc, cpu.pc });
    }

    if (result.state.i != cpu.i) {
        std.debug.print("I mismatch: expected 0x{X:0>4}, got 0x{X:0>4}\n", .{ result.state.i, cpu.i });
    }

    if (result.state.r != cpu.r) {
        std.debug.print("R mismatch: expected 0x{X:0>4}, got 0x{X:0>4}\n", .{ result.state.r, cpu.r });
    }

    if (result.state.iff1 != cpu.iff1) {
        std.debug.print("IFF1 mismatch: expected {}, got {}\n", .{ result.state.iff1, cpu.iff1 });
    }

    if (result.state.iff2 != cpu.iff2) {
        std.debug.print("IFF2 mismatch: expected {}, got {}\n", .{ result.state.iff2, cpu.iff2 });
    }

    if (result.state.im != cpu.im) {
        std.debug.print("IM mismatch: expected 0x{X:0>4}, got 0x{X:0>4}\n", .{ result.state.im, cpu.im });
    }

    if (result.state.halted != cpu.halt) {
        std.debug.print("Halted mismatch: expected {}, got {}\n", .{ result.state.halted, cpu.halt });
    }

    if (result.state.tStates != cpu.cycles - 1) {
        std.debug.print("TStates mismatch: expected {d}, got {d}\n", .{ result.state.tStates, cpu.cycles - 1 });
    }

    if (result.memory) |mem| {
        for (mem) |m| {
            const expected = m.data;
            const actual = cpu.memory[m.address .. m.address + expected.len];
            if (!std.mem.eql(u8, expected, actual)) {
                std.debug.print("Memory mismatch at 0x{X:0>4}:\n", .{m.address});
                for (expected, actual) |e, a| {
                    if (e != a) {
                        std.debug.print("  Expected 0x{X:0>2}, got 0x{X:0>2}\n", .{ e, a });
                    }
                }
            }
        }
    }
}

fn loadTestResults(alloc: Allocator) !std.json.Parsed([]TestResult) {
    const test_file = try std.fs.cwd().openFile("src/tests/tests.expected.json", .{});
    defer test_file.close();

    const test_json = try test_file.reader().readAllAlloc(alloc, 2_000_000);
    defer alloc.free(test_json);

    const tests = try std.json.parseFromSlice([]TestResult, alloc, test_json, .{ .allocate = .alloc_always });
    return tests;
}

fn loadTests(alloc: Allocator) !std.json.Parsed([]TestCase) {
    const test_file = try std.fs.cwd().openFile("src/tests/tests.in.json", .{});
    defer test_file.close();

    const test_json = try test_file.reader().readAllAlloc(alloc, 1_000_000);
    defer alloc.free(test_json);

    const tests = try std.json.parseFromSlice([]TestCase, alloc, test_json, .{ .allocate = .alloc_always });
    return tests;
}

fn loadTest(cpu: *Z80, t: TestCase) void {
    cpu.reset();
    cpu.af = t.state.af;
    cpu.bc = t.state.bc;
    cpu.de = t.state.de;
    cpu.hl = t.state.hl;
    cpu.af_ = t.state.afDash;
    cpu.bc_ = t.state.bcDash;
    cpu.de_ = t.state.deDash;
    cpu.hl_ = t.state.hlDash;
    cpu.ix = t.state.ix;
    cpu.iy = t.state.iy;
    cpu.sp = t.state.sp;
    cpu.pc = t.state.pc;
    // cpu.memptr = t.state.memptr;
    cpu.i = t.state.i;
    cpu.r = t.state.r;
    cpu.iff1 = t.state.iff1;
    cpu.iff2 = t.state.iff2;
    cpu.im = t.state.im;
    cpu.halt = t.state.halted;
    cpu.cycles = t.state.tStates;

    for (t.memory) |m| {
        @memcpy(cpu.memory[m.address .. m.address + m.data.len], m.data);
    }
}

const TestCase = struct {
    name: []const u8,
    state: State,
    memory: []MemoryEntry,
};

const TestResult = struct {
    name: []const u8,
    busActivity: []BusActivity,
    state: State,
    memory: ?[]MemoryEntry = null,
};

const State = struct {
    af: u16,
    bc: u16,
    de: u16,
    hl: u16,
    afDash: u16,
    bcDash: u16,
    deDash: u16,
    hlDash: u16,
    ix: u16,
    iy: u16,
    sp: u16,
    pc: u16,
    memptr: u16,
    i: u8,
    r: u8,
    iff1: bool,
    iff2: bool,
    im: u8,
    halted: bool,
    tStates: u64,
};

const MemoryEntry = struct {
    address: u16,
    data: []u8,
};

const BusActivity = struct {
    time: u64,
    type: []const u8,
    address: u16,
    value: ?u8 = null,
};
