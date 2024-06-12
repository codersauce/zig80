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
var a: u8 = 0xFF;
var zx_spectrum_print_hook_address: u16 = 0;

pub fn run(alloc: Allocator) !void {
    try downloadAndExtract(alloc);

    var cpu = Z80.init();
    for (Tests, 0..) |t, i| {
        if (i >= 0) {
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
    if (address == zx_spectrum_print_hook_address) {
        std.debug.print("hook: {x}\n", .{address});
    }

    const cpu: *c.Z80 = @ptrCast(@alignCast(context.?));
    const cv: u8 = @intCast(cpu.bc.uint16_value >> 8);

    if (cv == 2) {
        const char: u8 = @intCast(cpu.de.uint16_value & 0xFF);
        std.debug.print("{c}", .{char});
    } else if (cv == 9) {
        var i = cpu.de.uint16_value;
        var ci: u8 = 255;

        while (ci > 0) {
            ci -= 1;
            const char: u8 = memory[i];
            i += 1;
            if (char == 0x24) {
                return 0xC9;
            } else if (char == 0x0A) {
                std.debug.print("\n", .{});
            } else if (char == 0x0D) {
                continue;
            } else {
                std.debug.print("{c}", .{char});
            }
        }
    }

    // if (Z80_C(cpu) == 2) {
    //   hash = Z_FNV1_32_UPDATE(hash, (character = Z80_E(cpu)));
    //
    //   switch (character) {
    //   case 0x0A: /* LF */
    //     cr();
    //   case 0x0D: /* CR */
    //     break;
    //
    //   default:
    //     if (show_test_output)
    //       putchar(character);
    //     cursor_x++;
    //   }
    // }
    //
    // /* BDOS function 9 (C_WRITESTR) - Output string */
    // else if (Z80_C(cpu) == 9) {
    //   zuint16 i = Z80_DE(cpu);
    //   zuint c = 255;
    //
    //   while (c--) {
    //     hash = Z_FNV1_32_UPDATE(hash, (character = memory[i++]));
    //
    //     switch (character) {
    //     case 0x24: /* $  */
    //       return OPCODE_RET;
    //     case 0x0A: /* LF */
    //       cr();
    //     case 0x0D: /* CR */
    //       break;
    //
    //     default:
    //       if (show_test_output)
    //         putchar(character);
    //       cursor_x++;
    //     }
    //   }
    //
    //   if (show_test_output)
    //     puts(" [TRUNCATED]");
    // }

    return 0xC9;
}

fn spectrumWrite(self: *Z80, address: u16, value: u8) void {
    if (address > 0x3FFF) {
        self.memory[address] = value;
    }
}

fn spectrumCpuWrite(context: ?*anyopaque, address: c_ushort, value: u8) callconv(.C) void {
    _ = context;
    if (address > 0x3FFF) {
        memory[address] = value;
    }
}

fn spectrumCpuHook(context: ?*anyopaque, address: c_ushort) callconv(.C) u8 {
    if (context == null) {
        return 0x00;
    }
    const cpu: *c.Z80 = @ptrCast(@alignCast(context.?));
    const av: u8 = @intCast(cpu.af.uint16_value >> 8);
    if (address != zx_spectrum_print_hook_address) {
        return 0x00;
    }
    // std.debug.print("** {X:0>4}  {X:0>2} ** ", .{ address, av });

    switch (av) {
        0x0D => {
            // CR
            std.debug.print("\n", .{});
        },
        0x17 => {
            // TAB
            // zx_spectrum_tab = 2;
        },
        0x7F => {
            // ©
            std.debug.print("©", .{});
            // cursor_x++;
        },
        else => if (av >= 32 and av < 127) {
            std.debug.print("{c}", .{av});
            // cursor_x++;
        } else {
            // zx_spectrum_bad_character = true;
        },
    }

    return 0x00;
}

fn cpuHook(cpu: *Z80, address: u16) u8 {
    if (address != zx_spectrum_print_hook_address) {
        return 0x00;
    }

    switch (cpu.getA()) {
        0x0D => {
            // CR
            std.debug.print("\n", .{});
        },
        0x17 => {
            // TAB
            // zx_spectrum_tab = 2;
        },
        0x7F => {
            // ©
            std.debug.print("©", .{});
            // cursor_x++;
        },
        else => if (cpu.getA() >= 32 and cpu.getA() < 127) {
            std.debug.print("{c}", .{cpu.getA()});
            // cursor_x++;
        } else {
            // zx_spectrum_bad_character = true;
        },
    }

    return 0xC9; // RET
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
    // std.debug.print("before - bench pc = {X:0>4} cur_byte = {X:0>2}\n", .{ bench_cpu.pc.uint16_value, memory[bench_cpu.pc.uint16_value] });
    // FIXME: if we make this less than 5 then the bench CPU will not advance PC or SP.
    const run_cycles: u32 = switch (bench_opcode) {
        0xDD => 5,
        0xFD => 5,
        // 0x71 => 19,
        else => 1,
    };
    bench_cpu.context = bench_cpu;
    const cycles = c.z80_run(bench_cpu, run_cycles);
    // const cycles = c.z80_run(bench_cpu, 1);
    // std.debug.print("cycles: {d}\n", .{cycles});
    // std.debug.print("after  - bench pc = {X:0>4} cur_byte = {X:0>2}\n", .{ bench_cpu.pc.uint16_value, memory[bench_cpu.pc.uint16_value] });
    _ = cycles;
    const bench_state = try dumpCpuState(alloc, bench_cpu);
    defer alloc.free(bench_state);

    // steps the cpu
    cpu.run(1);
    const cpu_state = try cpu.dumpState(alloc);
    defer alloc.free(cpu_state);

    // const addr = 0x00FE;
    // const bench_mem = memory[addr];
    // const cpu_mem = cpu.memory[addr];
    //
    // if (bench_mem != cpu_mem) {
    //     std.debug.print("\nError: {X:0>4} mismatch - theirs: {X:0>2} ours: {X:0>2}\n", .{ addr, bench_mem, cpu_mem });
    //     return error.BenchmarkCpuMismatch;
    // }

    if (!try compare(alloc, cpu, bench_cpu)) {
        std.debug.print("[ours]   op_code = {X:0>2} last_bytes =", .{cpu_opcode});
        utils.dumpMemoryWithPointer(&cpu.memory, cpu.pc, 20);
        std.debug.print("\n", .{});

        std.debug.print("[theirs] op_code = {X:0>2} last_bytes =", .{bench_opcode});
        utils.dumpMemoryWithPointer(&memory, bench_cpu.pc.uint16_value, 20);
        std.debug.print("\n", .{});

        std.debug.print("before: {s}\n", .{bench_state_bef});
        std.debug.print("before: {s}\n", .{cpu_state_bef});
        std.debug.print("\n", .{});

        std.debug.print("after : {s}\n", .{bench_state});
        std.debug.print("after : {s}\n", .{cpu_state});
        return error.Benchmar8kCpuMismatch;
    }

    // std.debug.print("\n", .{});
}

fn compare(alloc: Allocator, cpu: *Z80, bench_cpu: *c.Z80) !bool {
    var errors: u8 = 0;

    const av = bench_cpu.af.uint16_value >> 8;
    const fv = bench_cpu.af.uint16_value & 0xFF;
    const bv = bench_cpu.bc.uint16_value >> 8;
    const cv = bench_cpu.bc.uint16_value & 0xFF;
    const dv = bench_cpu.de.uint16_value >> 8;
    const ev = bench_cpu.de.uint16_value & 0xFF;
    const hv = bench_cpu.hl.uint16_value >> 8;
    const lv = bench_cpu.hl.uint16_value & 0xFF;
    const af_ = bench_cpu.af_.uint16_value;
    const bc_ = bench_cpu.bc_.uint16_value;
    const de_ = bench_cpu.de_.uint16_value;
    const hl_ = bench_cpu.hl_.uint16_value;
    const ix = bench_cpu.ix_iy[0].uint16_value;
    const iy = bench_cpu.ix_iy[1].uint16_value;
    const r = bench_cpu.r;
    const i = bench_cpu.i;

    if (cpu.af_ != af_) {
        std.debug.print("af_ expected: {X:0>4} actual: {X:0>4}\n", .{ af_, cpu.af_ });
        errors += 1;
    }

    if (cpu.bc_ != bc_) {
        std.debug.print("bc_ expected: {X:0>4} actual: {X:0>4}\n", .{ bc_, cpu.bc_ });
        errors += 1;
    }

    if (cpu.de_ != de_) {
        std.debug.print("de_ expected: {X:0>4} actual: {X:0>4}\n", .{ de_, cpu.de_ });
        errors += 1;
    }

    if (cpu.hl_ != hl_) {
        std.debug.print("hl_ expected: {X:0>4} actual: {X:0>4}\n", .{ hl_, cpu.hl_ });
        errors += 1;
    }

    if (cpu.r != r) {
        std.debug.print("r expected: {X:0>2} actual: {X:0>2}\n", .{ r, cpu.r });
        errors += 1;
    }

    if (cpu.i != i) {
        std.debug.print("i expected: {X:0>2} actual: {X:0>2}\n", .{ i, cpu.i });
        errors += 1;
    }

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

    if (cpu.ix != ix) {
        std.debug.print("ix expected: {X:0>4} actual: {X:0>4}\n", .{ ix, cpu.ix });
        errors += 1;
    }

    if (cpu.iy != iy) {
        std.debug.print("iy expected: {X:0>4} actual: {X:0>4}\n", .{ iy, cpu.iy });
        errors += 1;
    }

    if (!std.mem.eql(u8, &cpu.memory, &memory)) {
        std.debug.print("memory mismatch\n", .{});
        utils.showMismatch(alloc, &cpu.memory, &memory);
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

    if (t.format == 0) {
        std.debug.print("CP/M Format\n", .{});
        // CP/M Format
        // cpu.fetch_opcode = cpu_read;
        // cpu.write = cpm_cpu_write;
        // cpu.hook = cpm_cpu_hook;
        // memory[0] = OPCODE_HALT;
        // memory[5] = Z80_HOOK; /* PRINT */
        bench_cpu.write = cpmCpuWrite;
        bench_cpu.hook = cpmCpuHook;
        memory[0] = 0x76; // halt
        memory[5] = 0x64; // print
        cpu.memory[0] = 0x76; // HALT
        cpu.memory[5] = 0x64; // print
    } else {
        std.debug.print("ZX Spectrum Format\n", .{});
        // ZX Spectrum Format
        // cpu.write = zx_spectrum_cpu_write;
        // cpu.hook = zx_spectrum_cpu_hook;
        // cpu.im = 1;
        // cpu.i = 0x3F;
        zx_spectrum_print_hook_address = 0x0010;
        bench_cpu.write = spectrumCpuWrite;
        bench_cpu.hook = spectrumCpuHook;
        bench_cpu.im = 1;
        bench_cpu.i = 0x3F;
        memory[zx_spectrum_print_hook_address] = 0x64; // Hook (print?)
        memory[0x0D6B] = 0xC9; // ret
        memory[0x1601] = 0xC9; // ret

        cpu.write = spectrumWrite;
        cpu.im = 1;
        cpu.i = 0x3F;
        cpu.memory[zx_spectrum_print_hook_address] = 0x64; // Hook (print?)
        cpu.memory[0x0D6B] = 0xC9; // ret
        cpu.memory[0x1601] = 0xC9; // ret
        cpu.trap = &cpuHook;
        // cpu.fetch_opcode = cpu_read;
        //
        // /* 0010: THE 'PRINT A CHARACTER' RESTART */
        // memory[zx_spectrum_print_hook_address = 0x0010] = Z80_HOOK;
        //
        // /* 0D6B: THE 'CLS' COMMAND ROUTINE */
        // memory[0x0D6B] = OPCODE_RET;
        //
        // /* 1601: THE 'CHAN_OPEN' SUBROUTINE */
        // memory[0x1601] = OPCODE_RET;
    }
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
