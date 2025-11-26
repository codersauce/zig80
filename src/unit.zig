const std = @import("std");
const cpu_import = @import("cpu.zig");
const utils = @import("utils.zig");
const cli = @import("cli.zig");
const c = @import("Z80.zig");

const Allocator = std.mem.Allocator;
const Z80 = cpu_import.Z80;
const Flag = cpu_import.Flag;

const Commands = enum {
    show,
    run,
};

const Command = union(Commands) {
    show: ShowCmd,
    run: RunCmd,
};

const RunCmd = struct {
    test_name: ?[]const u8,
    opt_bench: bool,
    opt_both: bool,
    opt_stop: bool,
};

const ShowCmd = struct {
    test_name: []const u8,
};

const Cli = struct {
    command: Command,
};

pub fn main() !void {
    var gpa = std.heap.GeneralPurposeAllocator(.{ .safety = true }){};
    defer _ = gpa.deinit();

    const alloc = gpa.allocator();

    const args = try std.process.argsAlloc(alloc);
    defer std.process.argsFree(alloc, args);

    const o = try cli.parse(Cli, args);
    if (o == null) {
        return;
    }

    const options = o.?;

    const tests = try loadTests(alloc);
    defer tests.deinit();
    const results = try loadTestResults(alloc);
    defer results.deinit();

    switch (options.command) {
        Commands.show => |cmd| {
            showTest(alloc, tests, results, cmd.test_name);
        },
        Commands.run => |cmd| {
            try runTests(alloc, tests, results, cmd);
        },
    }
}

fn runTests(alloc: Allocator, tests: std.json.Parsed([]TestCase), results: std.json.Parsed([]TestResult), options: RunCmd) !void {
    if (options.opt_both) {
        std.debug.print("Running on both emulators...\n", .{});
        for (tests.value, 0..) |t, n| {
            if (options.test_name) |name| {
                if (!std.mem.eql(u8, t.name, name)) {
                    continue;
                }
            }

            var test_output = std.ArrayList(u8){};
            defer test_output.deinit(alloc);
            runTest(alloc, t, results.value[n], test_output.writer(alloc)) catch {
                std.debug.print("Failed on our emulator\n", .{});
            };

            var bench_output = std.ArrayList(u8){};
            defer bench_output.deinit(alloc);
            runBenchmark(t, results.value[n], bench_output.writer(alloc)) catch {
                std.debug.print("Failed on benchmark emulator\n", .{});
            };

            // TODO: allow mismatch detection even if ours is equals to the unit test
            if (test_output.items.len > 0 and !std.mem.eql(u8, test_output.items, bench_output.items)) {
                std.debug.print("Test {s} - output mismatch\n\n", .{t.name});

                if (bench_output.items.len > 0) {
                    const expected = try utils.indentString(alloc, bench_output.items, 4);
                    defer alloc.free(expected);
                    std.debug.print("  Expected:\n", .{});
                    std.debug.print("{s}\n", .{expected});
                }

                const actual = try utils.indentString(alloc, test_output.items, 4);
                defer alloc.free(actual);
                std.debug.print("  Actual:\n", .{});
                std.debug.print("{s}\n", .{actual});

                if (options.opt_stop) {
                    return;
                }
            }
        }
        return;
    }

    if (options.opt_bench) {
        std.debug.print("Running on benchmark emulator...\n", .{});
        for (tests.value, 0..) |t, n| {
            if (options.test_name) |name| {
                if (!std.mem.eql(u8, t.name, name)) {
                    continue;
                }
            }

            var bench_output = std.ArrayList(u8){};
            defer bench_output.deinit(alloc);

            const r = results.value[n];
            runBenchmark(t, r, bench_output.writer(alloc)) catch {
                std.debug.print("Failed on benchmark emulator\n", .{});
            };
        }
        return;
    }

    std.debug.print("Running on our emulator...\n", .{});
    for (tests.value, 0..) |t, n| {
        if (options.test_name) |name| {
            if (!std.mem.eql(u8, t.name, name)) {
                continue;
            }
        }
        var test_output = std.ArrayList(u8){};
        defer test_output.deinit(alloc);
        runTest(alloc, t, results.value[n], test_output.writer(alloc)) catch {
            std.debug.print("Failed on our emulator\n", .{});
        };
    }
}

fn showTest(alloc: Allocator, tests: std.json.Parsed([]TestCase), results: std.json.Parsed([]TestResult), name: []const u8) void {
    _ = alloc;
    for (tests.value, 0..) |t, n| {
        if (!std.mem.eql(u8, t.name, name)) {
            continue;
        }
        const r = results.value[n];
        std.debug.print("Test: {s}\n", .{t.name});
        std.debug.print("  AF: 0x{X:0>4}\n", .{t.state.af});
        std.debug.print("  BC: 0x{X:0>4}\n", .{t.state.bc});
        std.debug.print("  DE: 0x{X:0>4}\n", .{t.state.de});
        std.debug.print("  HL: 0x{X:0>4}\n", .{t.state.hl});
        std.debug.print("  AF': 0x{X:0>4}\n", .{t.state.afDash});
        std.debug.print("  BC': 0x{X:0>4}\n", .{t.state.bcDash});
        std.debug.print("  DE': 0x{X:0>4}\n", .{t.state.deDash});
        std.debug.print("  HL': 0x{X:0>4}\n", .{t.state.hlDash});
        std.debug.print("  IX: 0x{X:0>4}\n", .{t.state.ix});
        std.debug.print("  IY: 0x{X:0>4}\n", .{t.state.iy});
        std.debug.print("  SP: 0x{X:0>4}\n", .{t.state.sp});
        std.debug.print("  PC: 0x{X:0>4}\n", .{t.state.pc});
        std.debug.print("  I: 0x{X:0>4}\n", .{t.state.i});
        std.debug.print("  R: 0x{X:0>4}\n", .{t.state.r});
        std.debug.print("  IFF1: {}\n", .{t.state.iff1});
        std.debug.print("  IFF2: {}\n", .{t.state.iff2});
        std.debug.print("  IM: 0x{X:0>4}\n", .{t.state.im});
        std.debug.print("  Halted: {}\n", .{t.state.halted});
        std.debug.print("  TStates: {d}\n", .{t.state.tStates});
        for (t.memory) |m| {
            std.debug.print("  Memory at 0x{X:0>4}:\n", .{m.address});
            for (m.data) |d| {
                std.debug.print("    0x{X:0>2}\n", .{d});
            }
        }
        std.debug.print("Expected:\n", .{});
        std.debug.print("  AF: 0x{X:0>4}\n", .{r.state.af});
        std.debug.print("  BC: 0x{X:0>4}\n", .{r.state.bc});
        std.debug.print("  DE: 0x{X:0>4}\n", .{r.state.de});
        std.debug.print("  HL: 0x{X:0>4}\n", .{r.state.hl});
        std.debug.print("  AF': 0x{X:0>4}\n", .{r.state.afDash});
        std.debug.print("  BC': 0x{X:0>4}\n", .{r.state.bcDash});
        std.debug.print("  DE': 0x{X:0>4}\n", .{r.state.deDash});
        std.debug.print("  HL': 0x{X:0>4}\n", .{r.state.hlDash});
        std.debug.print("  IX: 0x{X:0>4}\n", .{r.state.ix});
        std.debug.print("  IY: 0x{X:0>4}\n", .{r.state.iy});
        std.debug.print("  SP: 0x{X:0>4}\n", .{r.state.sp});
        std.debug.print("  PC: 0x{X:0>4}\n", .{r.state.pc});
        std.debug.print("  I: 0x{X:0>4}\n", .{r.state.i});
        std.debug.print("  R: 0x{X:0>4}\n", .{r.state.r});
        std.debug.print("  IFF1: {}\n", .{r.state.iff1});
        std.debug.print("  IFF2: {}\n", .{r.state.iff2});
        std.debug.print("  IM: 0x{X:0>4}\n", .{r.state.im});
        std.debug.print("  Halted: {}\n", .{r.state.halted});
        std.debug.print("  TStates: {d}\n", .{r.state.tStates});
        if (r.memory) |mem| {
            for (mem) |m| {
                std.debug.print("  Memory at 0x{X:0>4}:\n", .{m.address});
                for (m.data) |d| {
                    std.debug.print("    0x{X:0>2}\n", .{d});
                }
            }
        }
    }
}

fn runTest(alloc: Allocator, t: TestCase, result: TestResult, writer: anytype) !void {
    var cpu = Z80.init(alloc);
    executeTest(&cpu, t, result);
    try compareResult(&cpu, result, writer);
}

fn executeTest(cpu: *Z80, t: TestCase, result: TestResult) void {
    // std.debug.print("Running test '{s}'...\n", .{t.name});
    loadTest(cpu, t);

    const initial_cycles = cpu.cycles;
    var current_cycles = cpu.cycles;
    // std.debug.print("Initial cycles: {d}\n", .{initial_cycles});
    while ((current_cycles - initial_cycles) < result.state.tStates) {
        cpu.execute();
        // std.debug.print("Cycles: {d}\n", .{cpu.cycles});
        if (current_cycles == cpu.cycles) {
            std.debug.panic("No cycles\n", .{});
            break;
        }
        current_cycles = cpu.cycles;
    }
}

fn runBenchmark(t: TestCase, result: TestResult, writer: anytype) !void {
    var cpu = c.Z80{};
    var memory = [_]u8{0} ** 0x10000;

    executeOnBenchmark(&cpu, t, result, &memory);
    try compareBenchResult(&cpu, result, &memory, writer);
}

fn executeOnBenchmark(cpu: *c.Z80, t: TestCase, result: TestResult, memory: *[0x10000]u8) void {
    loadBench(cpu, t, memory);
    // std.debug.print("Running test '{s}'...\n", .{t.name});

    const read = struct {
        fn read(context: ?*anyopaque, address: c_ushort) callconv(.c) u8 {
            const mem: *[0x10000]u8 = @ptrCast(@alignCast(context.?));
            return mem[address];
        }
    }.read;

    const write = struct {
        fn write(context: ?*anyopaque, address: c_ushort, value: u8) callconv(.c) void {
            const mem: *[0x10000]u8 = @ptrCast(@alignCast(context.?));
            mem[address] = value;
        }
    }.write;

    const writePort = struct {
        fn writePort(context: ?*anyopaque, port: c_ushort, value: u8) callconv(.c) void {
            _ = context;
            std.debug.print("Writing to port 0x{X:0>2}\n", .{port});
            std.debug.print("  Value: 0x{X:0>2}\n", .{value});
        }
    }.writePort;

    const readPort = struct {
        fn readPort(context: ?*anyopaque, port: c_ushort) callconv(.c) u8 {
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
    cpu.context = memory;

    var current_cycles: usize = 0;
    while (current_cycles < result.state.tStates) {
        const cycles = c.z80_run(cpu, 1);
        if (cycles == 0) {
            std.debug.panic("No cycles\n", .{});
            break;
        }
        current_cycles += cycles;
    }
}

fn compareBenchResult(cpu: *c.Z80, result: TestResult, memory: *[0x10000]u8, writer: anytype) !void {
    if (result.state.af != cpu.af.uint16_value) {
        try writer.print("AF mismatch: expected 0x{X:0>4}, got 0x{X:0>4}\n", .{ result.state.af, cpu.af.uint16_value });
        var expected_flag = Flag.init(utils.lo(result.state.af));
        var actual_flag = Flag.init(utils.lo(cpu.af.uint16_value));
        try writer.print("  expected: ", .{});
        try expected_flag.write(writer);
        try writer.print("  actual:   ", .{});
        try actual_flag.write(writer);
    }

    if (result.state.bc != cpu.bc.uint16_value) {
        try writer.print("BC mismatch: expected 0x{X:0>4}, got 0x{X:0>4}\n", .{ result.state.bc, cpu.bc.uint16_value });
    }

    if (result.state.de != cpu.de.uint16_value) {
        try writer.print("DE mismatch: expected 0x{X:0>4}, got 0x{X:0>4}\n", .{ result.state.de, cpu.de.uint16_value });
    }

    if (result.state.hl != cpu.hl.uint16_value) {
        try writer.print("HL mismatch: expected 0x{X:0>4}, got 0x{X:0>4}\n", .{ result.state.hl, cpu.hl.uint16_value });
    }

    if (result.state.afDash != cpu.af_.uint16_value) {
        try writer.print("AF' mismatch: expected 0x{X:0>4}, got 0x{X:0>4}\n", .{ result.state.afDash, cpu.af_.uint16_value });
    }

    if (result.state.bcDash != cpu.bc_.uint16_value) {
        try writer.print("BC' mismatch: expected 0x{X:0>4}, got 0x{X:0>4}\n", .{ result.state.bcDash, cpu.bc_.uint16_value });
    }

    if (result.state.deDash != cpu.de_.uint16_value) {
        try writer.print("DE' mismatch: expected 0x{X:0>4}, got 0x{X:0>4}\n", .{ result.state.deDash, cpu.de_.uint16_value });
    }

    if (result.state.hlDash != cpu.hl_.uint16_value) {
        try writer.print("HL' mismatch: expected 0x{X:0>4}, got 0x{X:0>4}\n", .{ result.state.hlDash, cpu.hl_.uint16_value });
    }

    // if (result.state.ix != cpu.ix.uint16_value) {
    //     try writer.print("IX mismatch: expected 0x{X:0>4}, got 0x{X:0>4}\n", .{ result.state.ix, cpu.ix.uint16_value });
    // }
    //
    // if (result.state.iy != cpu.iy.uint16_value) {
    //     try writer.print("IY mismatch: expected 0x{X:0>4}, got 0x{X:0>4}\n", .{ result.state.iy, cpu.iy.uint16_value });
    // }

    if (result.state.sp != cpu.sp.uint16_value) {
        try writer.print("SP mismatch: expected 0x{X:0>4}, got 0x{X:0>4}\n", .{ result.state.sp, cpu.sp.uint16_value });
    }

    if (result.state.pc != cpu.pc.uint16_value) {
        try writer.print("PC mismatch: expected 0x{X:0>4}, got 0x{X:0>4}\n", .{ result.state.pc, cpu.pc.uint16_value });
    }

    if (result.state.i != cpu.i) {
        try writer.print("I mismatch: expected 0x{X:0>4}, got 0x{X:0>4}\n", .{ result.state.i, cpu.i });
    }

    if (result.state.r != cpu.r) {
        try writer.print("R mismatch: expected 0x{X:0>4}, got 0x{X:0>4}\n", .{ result.state.r, cpu.r });
    }

    // if (result.state.iff1 != cpu.iff1) {
    //     try writer.print("IFF1 mismatch: expected {}, got {}\n", .{ result.state.iff1, cpu.iff1 });
    // }
    //
    // if (result.state.iff2 != cpu.iff2) {
    //     try writer.print("IFF2 mismatch: expected {}, got {}\n", .{ result.state.iff2, cpu.iff2 });
    // }
    //
    // if (result.state.im != cpu.im) {
    //     try writer.print("IM mismatch: expected 0x{X:0>4}, got 0x{X:0>4}\n", .{ result.state.im, cpu.im });
    // }
    //
    // if (result.state.halted != cpu.halt_line) {
    //     try writer.print("Halted mismatch: expected {}, got {}\n", .{ result.state.halted, cpu.halt_line });
    // }
    //
    // if (result.state.tStates != cpu.cycles - 1) {
    //     try writer.print("TStates mismatch: expected {d}, got {d}\n", .{ result.state.tStates, cpu.cycles - 1 });
    // }
    //

    if (result.memory) |mem| {
        for (mem) |m| {
            const expected = m.data;
            const actual = memory[m.address .. m.address + expected.len];
            if (!std.mem.eql(u8, expected, actual)) {
                try writer.print("Memory mismatch at 0x{X:0>4}:\n", .{m.address});
                for (expected, actual) |e, a| {
                    if (e != a) {
                        try writer.print("  Expected 0x{X:0>2}, got 0x{X:0>2}\n", .{ e, a });
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

fn compareResult(cpu: *Z80, result: TestResult, writer: anytype) !void {
    if (result.state.af != cpu.af) {
        try writer.print("AF mismatch: expected 0x{X:0>4}, got 0x{X:0>4}\n", .{ result.state.af, cpu.af });
        var expected_flag = Flag.init(utils.lo(result.state.af));
        var actual_flag = Flag.init(utils.lo(cpu.getF()));
        try writer.print("  expected: ", .{});
        try expected_flag.write(writer);
        try writer.print("  actual:   ", .{});
        try actual_flag.write(writer);
    }

    if (result.state.bc != cpu.bc) {
        try writer.print("BC mismatch: expected 0x{X:0>4}, got 0x{X:0>4}\n", .{ result.state.bc, cpu.bc });
    }

    if (result.state.de != cpu.de) {
        try writer.print("DE mismatch: expected 0x{X:0>4}, got 0x{X:0>4}\n", .{ result.state.de, cpu.de });
    }

    if (result.state.hl != cpu.hl) {
        try writer.print("HL mismatch: expected 0x{X:0>4}, got 0x{X:0>4}\n", .{ result.state.hl, cpu.hl });
    }

    if (result.state.afDash != cpu.af_) {
        try writer.print("AF' mismatch: expected 0x{X:0>4}, got 0x{X:0>4}\n", .{ result.state.afDash, cpu.af_ });
    }

    if (result.state.bcDash != cpu.bc_) {
        try writer.print("BC' mismatch: expected 0x{X:0>4}, got 0x{X:0>4}\n", .{ result.state.bcDash, cpu.bc_ });
    }

    if (result.state.deDash != cpu.de_) {
        try writer.print("DE' mismatch: expected 0x{X:0>4}, got 0x{X:0>4}\n", .{ result.state.deDash, cpu.de_ });
    }

    if (result.state.hlDash != cpu.hl_) {
        try writer.print("HL' mismatch: expected 0x{X:0>4}, got 0x{X:0>4}\n", .{ result.state.hlDash, cpu.hl_ });
    }

    if (result.state.ix != cpu.ix) {
        try writer.print("IX mismatch: expected 0x{X:0>4}, got 0x{X:0>4}\n", .{ result.state.ix, cpu.ix });
    }

    if (result.state.iy != cpu.iy) {
        try writer.print("IY mismatch: expected 0x{X:0>4}, got 0x{X:0>4}\n", .{ result.state.iy, cpu.iy });
    }

    if (result.state.sp != cpu.sp) {
        try writer.print("SP mismatch: expected 0x{X:0>4}, got 0x{X:0>4}\n", .{ result.state.sp, cpu.sp });
    }

    if (result.state.pc != cpu.pc) {
        try writer.print("PC mismatch: expected 0x{X:0>4}, got 0x{X:0>4}\n", .{ result.state.pc, cpu.pc });
    }

    if (result.state.i != cpu.i) {
        try writer.print("I mismatch: expected 0x{X:0>4}, got 0x{X:0>4}\n", .{ result.state.i, cpu.i });
    }

    if (result.state.r != cpu.r) {
        try writer.print("R mismatch: expected 0x{X:0>4}, got 0x{X:0>4}\n", .{ result.state.r, cpu.r });
    }

    if (result.state.iff1 != cpu.iff1) {
        try writer.print("IFF1 mismatch: expected {}, got {}\n", .{ result.state.iff1, cpu.iff1 });
    }

    if (result.state.iff2 != cpu.iff2) {
        try writer.print("IFF2 mismatch: expected {}, got {}\n", .{ result.state.iff2, cpu.iff2 });
    }

    if (result.state.im != cpu.im) {
        try writer.print("IM mismatch: expected 0x{X:0>4}, got 0x{X:0>4}\n", .{ result.state.im, cpu.im });
    }

    if (result.state.halted != cpu.halt) {
        try writer.print("Halted mismatch: expected {}, got {}\n", .{ result.state.halted, cpu.halt });
    }

    // tStates are not cycles
    // if (result.state.tStates != cpu.cycles - 1) {
    //     try writer.print("TStates mismatch: expected {d}, got {d}\n", .{ result.state.tStates, cpu.cycles - 1 });
    // }

    if (result.memory) |mem| {
        for (mem) |m| {
            const expected = m.data;
            const actual = cpu.memory[m.address .. m.address + expected.len];
            if (!std.mem.eql(u8, expected, actual)) {
                try writer.print("Memory mismatch at 0x{X:0>4}:\n", .{m.address});
                for (expected, actual) |e, a| {
                    if (e != a) {
                        try writer.print("  Expected 0x{X:0>2}, got 0x{X:0>2}\n", .{ e, a });
                    }
                }
            }
        }
    }
}

fn loadTestResults(alloc: Allocator) !std.json.Parsed([]TestResult) {
    const test_file = try std.fs.cwd().openFile("src/tests/tests.expected.json", .{});
    defer test_file.close();

    const test_json = try test_file.readToEndAlloc(alloc, 2_000_000);
    defer alloc.free(test_json);

    const tests = try std.json.parseFromSlice([]TestResult, alloc, test_json, .{ .allocate = .alloc_always });
    return tests;
}

fn loadTests(alloc: Allocator) !std.json.Parsed([]TestCase) {
    const test_file = try std.fs.cwd().openFile("src/tests/tests.in.json", .{});
    defer test_file.close();

    const test_json = try test_file.readToEndAlloc(alloc, 1_000_000);
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
