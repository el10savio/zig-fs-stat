# zig-fs-stat
A clone of unix stat in zig 

```
$ ./main README.md build.zig 
path: README.md
inode: 22701932
size: 43
mode: 33188
kind: Kind.File
atime: 1632593825174805264
mtime: 1632593781207011493
ctime: 1632593781207011493

path: build.zig
inode: 20860442
size: 980
mode: 33188
kind: Kind.File
atime: 1632728848298594704
mtime: 1632422546071417157
ctime: 1632593811694859253
```