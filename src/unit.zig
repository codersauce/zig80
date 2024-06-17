const std = @import("std");
const cpu_import = @import("cpu.zig");
const utils = @import("utils.zig");
const Allocator = std.mem.Allocator;

pub fn main() !void {
    var gpa = std.heap.GeneralPurposeAllocator(.{ .safety = true }){};
    defer _ = gpa.deinit();

    const alloc = gpa.allocator();

    const tests = try loadTests(alloc);
    defer tests.deinit();

    const results = try loadTestResults(alloc);
    defer results.deinit();

    var cpu = cpu_import.Z80.init(alloc);
    for (tests.value, 0..) |t, n| {
        std.debug.print("Running test '{s}'...\n", .{t.name});
        loadTest(&cpu, t);
        // TODO: execute n steps (based on memory?)
        cpu.execute();

        const r = results.value[n];
        compareResult(&cpu, r);
    }
}

fn compareResult(cpu: *cpu_import.Z80, result: TestResult) void {
    if (result.state.af != cpu.af) {
        std.debug.print("AF mismatch: expected 0x{X:0>4}, got 0x{X:0>4}\n", .{ result.state.af, cpu.af });
        var expected_flag = cpu_import.Flag.init(utils.lo(result.state.afDash));
        var actual_flag = cpu_import.Flag.init(utils.lo(cpu.getF()));
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

fn loadTest(cpu: *cpu_import.Z80, t: TestCase) void {
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
