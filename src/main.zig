const std = @import("std");
const fs = std.fs;

pub fn main() anyerror!void {
    const stdout = std.io.getStdOut().writer();

    var allocator = std.heap.page_allocator;
    var iter = std.process.args();
    _ = iter.skip();

    while (iter.next(allocator)) |arg| {
        const path = arg catch break;
        defer allocator.free(path);

        try stdout.print("path: {}\n", .{path});
        var file = try fs.cwd().openFile(path, .{});
        defer file.close();

        const stat = try file.stat();
        try stdout.print("inode: {}\n", .{stat.inode});
        try stdout.print("size: {}\n", .{stat.size});
        try stdout.print("mode: {}\n", .{stat.mode});
        try stdout.print("kind: {}\n", .{stat.kind});
        try stdout.print("atime: {}\n", .{stat.atime});
        try stdout.print("mtime: {}\n", .{stat.mtime});
        try stdout.print("ctime: {}\n", .{stat.ctime});
        try stdout.print("\n", .{});
    }
}
