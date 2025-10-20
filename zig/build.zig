const std = @import("std");

pub fn build(b: *std.Build) void {
    const target = b.standardTargetOptions(.{
        .default_target = .{
            .cpu_arch = .wasm32,
            .os_tag = .freestanding,
            .abi = .musl,
        },
    });

    // Use ReleaseSafe for balance between size and correctness
    const optimize = b.option(std.builtin.OptimizeMode, "optimize", "Optimize mode") orelse .ReleaseSafe;

    const exe = b.addExecutable(.{
        .name = "sha256",
        .root_source_file = b.path("sha256.zig"),
        .target = target,
        .optimize = optimize,
    });

    // Minimal WASM configuration for optimal size
    exe.rdynamic = true;
    exe.export_table = true;
    exe.import_memory = false;
    exe.initial_memory = 2162688; // 32 pages x 65536 bytes (needed for 512KB buffer + export table)
    exe.max_memory = 2162688; // +1 page
    exe.shared_memory = false;
    exe.global_base = 1024;
    exe.entry = .disabled;

    b.installArtifact(exe);
}
