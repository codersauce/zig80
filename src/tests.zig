const std = @import("std");
const http = std.http;
const Allocator = std.mem.Allocator;

const utils = @import("utils.zig");
const Z80 = @import("cpu.zig").Z80;

const TestError = error{
    FileNotFound,
    FileSizeMismatch,
};

pub fn run(alloc: Allocator) !void {
    try downloadAndExtract(alloc);

    var cpu = Z80.init();
    for (Tests) |t| {
        try runTest(alloc, &cpu, t);
    }
}

pub fn runTest(alloc: Allocator, cpu: *Z80, t: Test) !void {
    cpu.reset();
    try loadTest(alloc, cpu, t);
}

fn loadTest(alloc: Allocator, cpu: *Z80, t: Test) !void {
    const path = (try utils.findFile(alloc, t.file_path, &.{ "depot/POSIX", "depot/ZX Spectrum" })).?;
    defer alloc.free(path);

    std.debug.print("running test: {s}\n", .{path});
    const file = try std.fs.cwd().openFile(path, .{});
    defer file.close();

    const stat = try file.stat();
    if (stat.size != t.file_size) {
        return TestError.FileSizeMismatch;
    }

    // std.debug.print("  - code size: {d}\n", .{t.code_size});
    // std.debug.print("  - seeking to: {d}\n", .{t.code_offset});
    // const expected_code_size = t.file_size - t.code_offset;
    // std.debug.print("  - expected code size: {d}\n", .{expected_code_size});
    if (t.code_offset > 0) {
        try file.seekTo(t.code_offset + 1);
    }
    const contents = try file.readToEndAlloc(alloc, t.code_size);
    defer alloc.free(contents);

    cpu.load(contents, t.start_address);
    // const mem = try cpu.dumpMemory(alloc);
    // defer alloc.free(mem);
    // std.debug.print("{s}\n", .{mem});
    // std.debug.print("\n", .{});
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
