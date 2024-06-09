const std = @import("std");
const http = std.http;
const Allocator = std.mem.Allocator;

const utils = @import("utils.zig");
const cpu_import = @import("cpu.zig");
const Z80 = cpu_import.Z80;
const Flag = cpu_import.Flag;
const c = @import("Z80.zig");

const TestError = error{
    FileNotFound,
    FileSizeMismatch,
    BenchmarkCpuMismatch,
};

var memory: [0x10000]u8 = undefined; // 64KB

pub fn run(alloc: Allocator) !void {
    try downloadAndExtract(alloc);

    var cpu = Z80.init();
    for (Tests, 0..) |t, i| {
        if (i == 12) {
            try runTest(alloc, &cpu, t);
        }
    }
}

pub fn runTest(alloc: Allocator, cpu: *Z80, t: Test) !void {
    var bench_cpu = c.Z80{};

    bench_cpu.context = null;
    bench_cpu.nmia = null;
    bench_cpu.inta = null;
    bench_cpu.int_fetch = null;
    bench_cpu.ld_i_a = null;
    bench_cpu.ld_r_a = null;
    bench_cpu.reti = null;
    bench_cpu.retn = null;
    bench_cpu.illegal = null;
    bench_cpu.options = c.Z80_MODEL_ZILOG_NMOS;

    bench_cpu.in = cpuIn;
    bench_cpu.out = cpuOut;
    bench_cpu.nop = cpuRead;
    bench_cpu.fetch = cpuRead;
    bench_cpu.read = cpuRead;
    bench_cpu.fetch_opcode = cpuRead;
    bench_cpu.halt = cpuHalt;
    bench_cpu.write = cpmCpuWrite;
    bench_cpu.hook = cpmCpuHook;

    cpu.reset();
    try loadTest(alloc, cpu, &bench_cpu, t);
    if (t.archive_name != null) {
        std.debug.print("running test: {s}/{s}\n", .{ t.archive_name.?, t.file_path });
    } else {
        std.debug.print("running test: {s}\n", .{t.file_path});
    }

    while (!cpu.isHalted()) {
        try step(alloc, cpu, &bench_cpu);
    }
}

fn cpuIn(context: ?*anyopaque, port: u16) callconv(.C) u8 {
    _ = context;
    std.debug.print("in: {x}\n", .{port});
    return 0;
}

fn cpuOut(context: ?*anyopaque, port: u16, value: u8) callconv(.C) void {
    _ = context;
    std.debug.print("out: {x} {x}\n", .{ port, value });
}

fn cpuHalt(context: ?*anyopaque, state: u8) callconv(.C) void {
    _ = context;
    std.debug.print("halt: {x}\n", .{state});
}

fn cpuRead(context: ?*anyopaque, address: c_ushort) callconv(.C) u8 {
    _ = context;
    const opcode = memory[address];
    // std.debug.print("[bench] pc={0X:0>4} opcode={1X:0>2}\n", .{ address, opcode });
    return opcode;
}

fn cpmCpuWrite(context: ?*anyopaque, address: c_ushort, value: u8) callconv(.C) void {
    _ = context;
    // std.debug.print("write: {x} {x}\n", .{ address, value });
    memory[address] = value;
}

fn cpmCpuHook(context: ?*anyopaque, address: c_ushort) callconv(.C) u8 {
    _ = context;
    std.debug.print("hook: {x}\n", .{address});
    return 0;
}

fn dumpCpuState(alloc: Allocator, cpu: *c.Z80) ![]const u8 {
    const av = cpu.af.uint16_value >> 8;
    const fv = cpu.af.uint16_value & 0xFF;
    const bv = cpu.bc.uint16_value >> 8;
    const cv = cpu.bc.uint16_value & 0xFF;
    const dv = cpu.de.uint16_value >> 8;
    const ev = cpu.de.uint16_value & 0xFF;
    const hv = cpu.hl.uint16_value >> 8;
    const lv = cpu.hl.uint16_value & 0xFF;

    return try std.fmt.allocPrint(alloc, "[bnc] a={X:0>2} f={X:0>2} b={X:0>2} c={X:0>2} d={X:0>2} e={X:0>2} h={X:0>2} l={X:0>2} sp={X:0>4} pc={X:0>4}", .{ av, fv, bv, cv, dv, ev, hv, lv, cpu.sp.uint16_value, cpu.pc.uint16_value });
}

fn step(alloc: Allocator, cpu: *Z80, bench_cpu: *c.Z80) !void {
    const bench_state_bef = try dumpCpuState(alloc, bench_cpu);
    defer alloc.free(bench_state_bef);

    const cpu_state_bef = try cpu.dumpState(alloc);
    defer alloc.free(cpu_state_bef);

    // std.debug.print("before: {s}\n", .{bench_state_bef});
    // std.debug.print("before: {s}\n", .{cpu_state_bef});

    const bench_opcode = memory[bench_cpu.pc.uint16_value];
    const cpu_opcode = cpu.peekByte();

    if (bench_opcode != cpu_opcode) {
        std.debug.print("\nError: op_code mismatch - theirs: {X:0>2} ours: {X:0>2}\n", .{ bench_opcode, cpu_opcode });
        return error.BenchmarkCpuMismatch;
    }

    // steps the benchmark cpu
    _ = c.z80_run(bench_cpu, 1);
    const bench_state = try dumpCpuState(alloc, bench_cpu);
    defer alloc.free(bench_state);

    // steps the cpu
    cpu.run(1);
    const cpu_state = try cpu.dumpState(alloc);
    defer alloc.free(cpu_state);

    const addr = 0x00FE;
    const bench_mem = memory[addr];
    const cpu_mem = cpu.memory[addr];

    if (bench_mem != cpu_mem) {
        std.debug.print("\nError: {X:0>4} mismatch - theirs: {X:0>2} ours: {X:0>2}\n", .{ addr, bench_mem, cpu_mem });
        return error.BenchmarkCpuMismatch;
    }

    if (!try compare(cpu, bench_cpu)) {
        std.debug.print("op_code = {X:0>2}\n", .{cpu_opcode});
        std.debug.print("after : {s}\n", .{bench_state});
        std.debug.print("after : {s}\n", .{cpu_state});
        return error.Benchmar8kCpuMismatch;
    }

    // std.debug.print("\n", .{});
}

fn compare(cpu: *Z80, bench_cpu: *c.Z80) !bool {
    var errors: u8 = 0;

    const av = bench_cpu.af.uint16_value >> 8;
    const fv = bench_cpu.af.uint16_value & 0xFF;
    const bv = bench_cpu.bc.uint16_value >> 8;
    const cv = bench_cpu.bc.uint16_value & 0xFF;
    const dv = bench_cpu.de.uint16_value >> 8;
    const ev = bench_cpu.de.uint16_value & 0xFF;
    const hv = bench_cpu.hl.uint16_value >> 8;
    const lv = bench_cpu.hl.uint16_value & 0xFF;

    if (cpu.getA() != av) {
        std.debug.print("a expected: {X:0>2} actual: {X:0>2}\n", .{ av, cpu.getA() });
        errors += 1;
    }

    if (cpu.getF() != fv) {
        std.debug.print("f expected: {X:0>2} actual: {X:0>2}\n", .{ fv, cpu.getF() });

        var expected_flags = Flag.init(@as(u8, @intCast(fv)));
        std.debug.print("  their flags: ", .{});
        expected_flags.dump();

        var actual_flags = Flag.init(cpu.getF());
        std.debug.print("  our   flags: ", .{});
        actual_flags.dump();

        errors += 1;
    }

    if (cpu.getB() != bv) {
        std.debug.print("b expected: {X:0>2} actual: {X:0>2}\n", .{ bv, cpu.getB() });
        errors += 1;
    }

    if (cpu.getC() != cv) {
        std.debug.print("c expected: {X:0>2} actual: {X:0>2}\n", .{ cv, cpu.getC() });
        errors += 1;
    }

    if (cpu.getD() != dv) {
        std.debug.print("d expected: {X:0>2} actual: {X:0>2}\n", .{ dv, cpu.getD() });
        errors += 1;
    }

    if (cpu.getE() != ev) {
        std.debug.print("e expected: {X:0>2} actual: {X:0>2}\n", .{ ev, cpu.getE() });
        errors += 1;
    }

    if (cpu.getH() != hv) {
        std.debug.print("h expected: {X:0>2} actual: {X:0>2}\n", .{ hv, cpu.getH() });
        errors += 1;
    }

    if (cpu.getL() != lv) {
        std.debug.print("l expected: {X:0>2} actual: {X:0>2}\n", .{ lv, cpu.getL() });
        errors += 1;
    }

    if (cpu.pc != bench_cpu.pc.uint16_value) {
        std.debug.print("pc expected: {X:0>4} actual: {X:0>4}\n", .{ bench_cpu.pc.uint16_value, cpu.pc });
        errors += 1;
    }

    if (cpu.sp != bench_cpu.sp.uint16_value) {
        std.debug.print("sp expected: {X:0>4} actual: {X:0>4}\n", .{ bench_cpu.sp.uint16_value, cpu.sp });
        errors += 1;
    }

    if (errors > 0) {
        return false;
    }

    return true;
}

fn loadTest(alloc: Allocator, cpu: *Z80, bench_cpu: *c.Z80, t: Test) !void {
    const contents = try loadTestFile(alloc, t);
    defer alloc.free(contents);

    cpu.load(contents, t.start_address);
    cpu.memory[t.exit_address] = 0x76; // HALT
    cpu.pc = t.start_address;

    // load program into benchmark cpu memory
    @memset(&memory, 0);
    @memcpy(memory[t.start_address .. t.start_address + contents.len], contents);

    // set exit address
    memory[t.exit_address] = 0x76; // HALT

    c.z80_power(bench_cpu, true);
    bench_cpu.pc.uint16_value = t.start_address;
}

fn loadTestFile(alloc: Allocator, t: Test) ![]const u8 {
    const path = (try utils.findFile(alloc, t.file_path, &.{ "depot/POSIX", "depot/ZX Spectrum" })).?;
    defer alloc.free(path);

    const file = try std.fs.cwd().openFile(path, .{});
    defer file.close();

    const stat = try file.stat();
    if (stat.size != t.file_size) {
        return TestError.FileSizeMismatch;
    }

    const contents = try file.readToEndAlloc(alloc, stat.size);
    return contents;
}

pub fn downloadAndExtract(alloc: Allocator) !void {
    const file = try std.fs.cwd().openFile("support/software.sha3-512", .{});
    defer file.close();

    const stat = try file.stat();
    const contents = try file.readToEndAlloc(alloc, stat.size);
    defer alloc.free(contents);

    std.fs.cwd().makeDir("depot") catch {};

    var it = std.mem.split(u8, contents, "\n");
    while (it.next()) |line| {
        if (line.len == 0) {
            continue;
        }
        var iit = std.mem.split(u8, line, "  ");
        const sha = iit.next().?;
        _ = sha;
        const name = iit.next().?;
        const url = try std.fmt.allocPrint(alloc, "https://zxe.io/depot/software/{s}", .{name});
        defer alloc.free(url);

        const outname = try std.fmt.allocPrint(alloc, "depot/{s}", .{name});
        defer alloc.free(outname);

        if (utils.fileExists(outname) catch false) {
            continue;
        }

        std.debug.print("downloading: {s}\n", .{outname});
        try utils.download(alloc, url, outname);
        std.debug.print("extracting: {s}\n", .{outname});
        try utils.extract(alloc, outname);
    }
}

const Test = struct {
    /// Name of the archive if the file is compressed
    archive_name: ?[]const u8,
    /// Name of the file, or path to the file inside the archive if the file is compressed.
    file_path: []const u8,
    /// Total number of clock cycles executed when the test is passed.
    cycles: u64,
    /// FNV-1 hash of the entire text output when the test is passed (i.e., of all bytes sent by the program to the print routine).
    hash: u32,
    /// Memory address where to jump to start executing the program.
    start_address: u16,
    /// Value of the PC register once the program completes.
    exit_address: u16,
    /// Size of the file.
    file_size: u16,
    /// Size of the executable code.
    code_size: u16,
    /// Offset of the executable code inside the file.
    code_offset: u8,
    /// Format of the program.
    format: u8,
    /// Number of lines printed when the test is passed.
    lines: u8,
    /// Rightmost position reached by the cursor when the test is passed.
    columns: u8,
};

pub const Tests = [_]Test{
    Test{
        .archive_name = "Yaze v1.10 (1998-01-28)(Cringle, Frank D.)(Sources)[!].tar.gz",
        .file_path = "yaze-1.10/test/zexdoc.com",
        .cycles = 46734977146,
        .hash = 0xEDE3CB62,
        .start_address = 0x0100,
        .exit_address = 0,
        .file_size = 8704,
        .code_size = 8704,
        .code_offset = 0,
        .format = 0,
        .lines = 68,
        .columns = 34,
    },
    Test{
        .archive_name = null,
        .file_path = "Z80 Documented Instruction Set Exerciser for Spectrum (2018)(Harston, Jonathan Graham)[!].tap",
        .cycles = 46789699638,
        .hash = 0x9F8B1839,
        .start_address = 0x8000,
        .exit_address = 0x803D,
        .file_size = 8716,
        .code_size = 8624,
        .code_offset = 91,
        .format = 1,
        .lines = 69,
        .columns = 32,
    },
    Test{
        .archive_name = "Yaze v1.10 (1998-01-28)(Cringle, Frank D.)(Sources)[!].tar.gz",
        .file_path = "yaze-1.10/test/zexall.com",
        .cycles = 46734977146,
        .hash = 0xEDE3CB62,
        .start_address = 0x0100,
        .exit_address = 0,
        .file_size = 8704,
        .code_size = 8704,
        .code_offset = 0,
        .format = 0,
        .lines = 68,
        .columns = 34,
    },
    Test{
        .archive_name = null,
        .file_path = "Z80 Full Instruction Set Exerciser for Spectrum (2009)(Bobrowski, Jan)[!].tap",
        .cycles = 46789670967,
        .hash = 0xD4910BEE,
        .start_address = 0x8000,
        .exit_address = 0x803D,
        .file_size = 8656,
        .code_size = 8547,
        .code_offset = 108,
        .format = 1,
        .lines = 69,
        .columns = 31,
    },
    Test{
        .archive_name = null,
        .file_path = "Z80 Full Instruction Set Exerciser for Spectrum (2011)(Bobrowski, Jan)(Narrowed to BIT Instructions)[!].tap",
        .cycles = 1332195039,
        .hash = 0x680D4830,
        .start_address = 0x8000,
        .exit_address = 0x803D,
        .file_size = 8656,
        .code_size = 8547,
        .code_offset = 108,
        .format = 1,
        .lines = 4,
        .columns = 31,
    },
    Test{
        .archive_name = null,
        .file_path = "Z80 Full Instruction Set Exerciser for Spectrum (2017-0x)(Harston, Jonathan Graham)[!].tap",
        .cycles = 46789691206,
        .hash = 0x9F50D128,
        .start_address = 0x8000,
        .exit_address = 0x803D,
        .file_size = 8704,
        .code_size = 8612,
        .code_offset = 91,
        .format = 1,
        .lines = 69,
        .columns = 32,
    },
    Test{
        .archive_name = null,
        .file_path = "Z80 Full Instruction Set Exerciser for Spectrum (2018)(Harston, Jonathan Graham)[!].tap",
        .cycles = 46789699638,
        .hash = 0x9F50D128,
        .start_address = 0x8000,
        .exit_address = 0x803D,
        .file_size = 8716,
        .code_size = 8624,
        .code_offset = 91,
        .format = 1,
        .lines = 69,
        .columns = 32,
    },
    Test{
        .archive_name = "Z80 Instruction Set Exerciser for Spectrum 2 v0.1 (2012-11-27)(Rak, Patrik)[!].zip",
        .file_path = "zexall2-0.1/zexall2.tap",
        .cycles = 51953023094,
        .hash = 0x05C746F7,
        .start_address = 0x8000,
        .exit_address = 0x8040,
        .file_size = 9316,
        .code_size = 9228,
        .code_offset = 87,
        .format = 1,
        .lines = 76,
        .columns = 31,
    },
    Test{
        .archive_name = null,
        .file_path = "Z80 Test Suite (2008)(Woodmass, Mark)[!].tap",
        .cycles = 2620408047,
        .hash = 0xF787CA8E,
        .start_address = 0x8057,
        .exit_address = 0x80E6,
        .file_size = 5573,
        .code_size = 5452,
        .code_offset = 120,
        .format = 2,
        .lines = 50,
        .columns = 32,
    },
    Test{
        .archive_name = null,
        .file_path = "Z80 Test Suite (2008)(Woodmass, Mark)[!].tap",
        .cycles = 50904931,
        .hash = 0xF5AE5140,
        .start_address = 0x8049,
        .exit_address = 0x80E6,
        .file_size = 5573,
        .code_size = 5452,
        .code_offset = 120,
        .format = 2,
        .lines = 61,
        .columns = 32,
    },
    Test{
        .archive_name = "Zilog Z80 CPU Test Suite v1.0 (2012-12-08)(Rak, Patrik)[!].zip",
        .file_path = "z80test-1.0/z80full.tap",
        .cycles = 1124314097,
        .hash = 0xB8707D12,
        .start_address = 0x8000,
        .exit_address = 0x7003,
        .file_size = 13758,
        .code_size = 13666,
        .code_offset = 91,
        .format = 3,
        .lines = 156,
        .columns = 32,
    },
    Test{
        .archive_name = "Zilog Z80 CPU Test Suite v1.0 (2012-12-08)(Rak, Patrik)[!].zip",
        .file_path = "z80test-1.0/z80doc.tap",
        .cycles = 1131315813,
        .hash = 0x9E9DD1F5,
        .start_address = 0x8000,
        .exit_address = 0x7003,
        .file_size = 13758,
        .code_size = 13666,
        .code_offset = 91,
        .format = 3,
        .lines = 156,
        .columns = 32,
    },
    Test{
        .archive_name = "Zilog Z80 CPU Test Suite v1.0 (2012-12-08)(Rak, Patrik)[!].zip",
        .file_path = "z80test-1.0/z80flags.tap",
        .cycles = 552407516,
        .hash = 0x27CB27A2,
        .start_address = 0x8000,
        .exit_address = 0x7003,
        .file_size = 13758,
        .code_size = 13666,
        .code_offset = 91,
        .format = 3,
        .lines = 156,
        .columns = 32,
    },
    Test{
        .archive_name = "Zilog Z80 CPU Test Suite v1.0 (2012-12-08)(Rak, Patrik)[!].zip",
        .file_path = "z80test-1.0/z80docflags.tap",
        .cycles = 554744241,
        .hash = 0x3966C46C,
        .start_address = 0x8000,
        .exit_address = 0x7003,
        .file_size = 13758,
        .code_size = 13666,
        .code_offset = 91,
        .format = 3,
        .lines = 156,
        .columns = 32,
    },
    Test{
        .archive_name = "Zilog Z80 CPU Test Suite v1.0 (2012-12-08)(Rak, Patrik)[!].zip",
        .file_path = "z80test-1.0/z80ccf.tap",
        .cycles = 598439114,
        .hash = 0xB34ED107,
        .start_address = 0x8000,
        .exit_address = 0x7003,
        .file_size = 14219,
        .code_size = 14127,
        .code_offset = 91,
        .format = 3,
        .lines = 156,
        .columns = 32,
    },
    Test{
        .archive_name = "Zilog Z80 CPU Test Suite v1.0 (2012-12-08)(Rak, Patrik)[!].zip",
        .file_path = "z80test-1.0/z80memptr.tap",
        .cycles = 559739837,
        .hash = 0x840ACD96,
        .start_address = 0x8000,
        .exit_address = 0x7003,
        .file_size = 13758,
        .code_size = 13666,
        .code_offset = 91,
        .format = 3,
        .lines = 156,
        .columns = 32,
    },
    Test{
        .archive_name = "Zilog Z80 CPU Test Suite v1.2a (2023-12-02)(Rak, Patrik)[!].zip",
        .file_path = "z80test-1.2a/z80full.tap",
        .cycles = 1132649578,
        .hash = 0x4C578BC6,
        .start_address = 0x8000,
        .exit_address = 0x7003,
        .file_size = 14390,
        .code_size = 14298,
        .code_offset = 91,
        .format = 3,
        .lines = 164,
        .columns = 32,
    },
    Test{
        .archive_name = "Zilog Z80 CPU Test Suite v1.2a (2023-12-02)(Rak, Patrik)[!].zip",
        .file_path = "z80test-1.2a/z80doc.tap",
        .cycles = 1139700430,
        .hash = 0x02114A09,
        .start_address = 0x8000,
        .exit_address = 0x7003,
        .file_size = 14390,
        .code_size = 14298,
        .code_offset = 91,
        .format = 3,
        .lines = 164,
        .columns = 32,
    },
    Test{
        .archive_name = "Zilog Z80 CPU Test Suite v1.2a (2023-12-02)(Rak, Patrik)[!].zip",
        .file_path = "z80test-1.2a/z80flags.tap",
        .cycles = 556734421,
        .hash = 0x91826856,
        .start_address = 0x8000,
        .exit_address = 0x7003,
        .file_size = 14390,
        .code_size = 14298,
        .code_offset = 91,
        .format = 3,
        .lines = 164,
        .columns = 32,
    },
    Test{
        .archive_name = "Zilog Z80 CPU Test Suite v1.2a (2023-12-02)(Rak, Patrik)[!].zip",
        .file_path = "z80test-1.2a/z80docflags.tap",
        .cycles = 559087578,
        .hash = 0x408190F0,
        .start_address = 0x8000,
        .exit_address = 0x7003,
        .file_size = 14390,
        .code_size = 14298,
        .code_offset = 91,
        .format = 3,
        .lines = 164,
        .columns = 32,
    },
    Test{
        .archive_name = "Zilog Z80 CPU Test Suite v1.2a (2023-12-02)(Rak, Patrik)[!].zip",
        .file_path = "z80test-1.2a/z80ccf.tap",
        .cycles = 603147843,
        .hash = 0x27FF6693,
        .start_address = 0x8000,
        .exit_address = 0x7003,
        .file_size = 14875,
        .code_size = 14783,
        .code_offset = 91,
        .format = 3,
        .lines = 164,
        .columns = 32,
    },
    Test{
        .archive_name = "Zilog Z80 CPU Test Suite v1.2a (2023-12-02)(Rak, Patrik)[!].zip",
        .file_path = "z80test-1.2a/z80memptr.tap",
        .cycles = 564118134,
        .hash = 0xDB7B18AA,
        .start_address = 0x8000,
        .exit_address = 0x7003,
        .file_size = 14390,
        .code_size = 14298,
        .code_offset = 91,
        .format = 3,
        .lines = 164,
        .columns = 32,
    },
};
