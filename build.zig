const std = @import("std");

// Although this function looks imperative, note that its job is to
// declaratively construct a build graph that will be executed by an external
// runner.
pub fn build(b: *std.Build) void {
    const target = b.standardTargetOptions(.{});
    const optimize = b.standardOptimizeOption(.{});
    const main_module = b.addModule("driver_module", .{ .root_source_file = b.path("src/lib.zig") });

    add_module_options(main_module, b);

    const tests = b.addTest(.{ .root_source_file = b.path("src/lib.zig"), .target = target, .optimize = optimize, .test_runner = b.path("test_runner.zig") });

    b.addRunArtifact(tests);
}

pub fn add_module_options(m: *std.Build.Module, b: *std.Build) void {
    const options = b.addOptions();

    m.addOptions("build", options);
}
