const std = @import("std");

pub fn build(b: *std.Build) void {
    const target = b.standardTargetOptions(.{});
    const opt = b.standardOptimizeOption(.{});

    // Link z80 library from ~/.local
    const home = std.posix.getenv("HOME") orelse "/Users/fcoury";
    const lib_path = b.fmt("{s}/.local/lib", .{home});
    const include_path = b.fmt("{s}/.local/include", .{home});

    const exe = b.addExecutable(.{
        .name = "zig80",
        .root_module = b.createModule(.{
            .root_source_file = b.path("src/main.zig"),
            .target = target,
            .optimize = opt,
        }),
    });

    exe.root_module.addLibraryPath(.{ .cwd_relative = lib_path });
    exe.root_module.addIncludePath(.{ .cwd_relative = include_path });
    exe.linkSystemLibrary("z80");
    b.installArtifact(exe);

    const unit_exe = b.addExecutable(.{
        .name = "zig80-test",
        .root_module = b.createModule(.{
            .root_source_file = b.path("src/unit.zig"),
            .target = target,
            .optimize = opt,
        }),
    });

    unit_exe.root_module.addLibraryPath(.{ .cwd_relative = lib_path });
    unit_exe.root_module.addIncludePath(.{ .cwd_relative = include_path });
    unit_exe.linkSystemLibrary("z80");
    b.installArtifact(unit_exe);
}
