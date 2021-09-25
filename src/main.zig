const std = @import("std");

pub fn main() anyerror!void {
    const stdout = std.io.getStdOut().writer();

    var allocator = std.heap.page_allocator;

    var iter = std.process.args();
    while (iter.next(allocator)) |arg| {
        const argument = arg catch break;
        try stdout.print("arg: {}\n", .{argument});
        allocator.free(argument);
    }

    const file = try std.fs.cwd().createFile("file.txt", .{});
    defer file.close();

    const stat = try file.stat();
    try stdout.print("inode: {}\n", .{stat.inode});
    try stdout.print("size: {}\n", .{stat.size});
    try stdout.print("mode: {}\n", .{stat.mode});
    try stdout.print("kind: {}\n", .{stat.kind});
    try stdout.print("atime: {}\n", .{stat.atime});
    try stdout.print("mtime: {}\n", .{stat.mtime});
    try stdout.print("ctime: {}\n", .{stat.ctime});
}
