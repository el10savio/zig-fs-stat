const std = @import("std");
const eql = std.mem.eql;
const fs = std.fs;

// todo: unit tests

pub fn main() anyerror!void {
    // Process input arguments
    var allocator = std.heap.page_allocator;
    var iter = std.process.args();

    // Skip binary name
    // which is the first argument
    _ = iter.skip();

    // Iterate through all paths
    while (iter.next(allocator)) |arg| {
        const path = arg catch break;
        defer allocator.free(path);
        try getFileStat(path);
    }
}

// todo: input validation
pub fn getFileStat(path: []const u8) anyerror!void {
    var file = try fs.cwd().openFile(path, .{});
    defer file.close();

    const stat = try file.stat();
    try printFileStat(path, stat);
}

// Get fs stat details and print
pub fn printFileStat(path: []const u8, stat: fs.File.Stat) anyerror!void {
    const stdout = std.io.getStdOut().writer();
    try stdout.print("path: {s}\n", .{path});
    try stdout.print("inode: {}\n", .{stat.inode});
    try stdout.print("size: {}\n", .{stat.size});
    try stdout.print("mode: {}\n", .{stat.mode});
    try stdout.print("kind: {}\n", .{stat.kind});
    try stdout.print("atime: {}\n", .{stat.atime});
    try stdout.print("mtime: {}\n", .{stat.mtime});
    try stdout.print("ctime: {}\n", .{stat.ctime});
    try stdout.print("\n", .{});
}
