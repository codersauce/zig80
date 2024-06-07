const std = @import("std");

pub fn build(b: *std.Build) void {
    const target = b.standardTargetOptions(.{});
    const opt = b.standardOptimizeOption(.{});

    const exe = b.addExecutable(.{
        .name = "zig80",
        .root_source_file = b.path("src/main.zig"),
        .target = target,
        .optimize = opt,
    });

    exe.linkSystemLibrary("z80");
    b.installArtifact(exe);
}
