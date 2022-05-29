const std = @import("std");
const mem = std.mem;
const crypto = std.crypto.hash.sha2;
//const fmt = std.fmt;

export fn initSHA256() []u8 {
    const h = crypto.Sha256.init(.{});
    return mem.toBytes(h);
}

export fn update(state: []u8, buffer: []u8) []u8 {
    const parentH = crypto.Sha256.init(.{});
    const h = mem.bytesToValue(@TypeOf(parentH), &state);
    h.update(buffer)
    return mem.toBytes(h);
}


export fn digest(state: []u8) [32]u8 {
    const parentH = crypto.Sha256.init(.{});
    const h = mem.bytesToValue(@TypeOf(parentH), &state);

    var out: [32]u8 = undefined;
    h.final(out[0..])
    return out
}


// pub fn main() !void {

//     const stdout = std.io.getStdOut().writer();
//     var out: [32]u8 = undefined;

//     var h = crypto.Sha256.init(.{});
//     h.update("a");
//     h.update("b");
//     h.update("c");
//     var m = mem.toBytes(h);
//     try stdout.print("{s}", .{std.fmt.fmtSliceHexLower(m[0..])});
//     try stdout.print("\n", .{});
//     h.final(out[0..]);

//     //try assertEqual("ba7816bf8f01cfea414140de5dae2223b00361a396177a9cb410ff61f20015ad", out[0..]);
//     try stdout.print("{s}", .{std.fmt.fmtSliceHexLower(out[0..])});
//     try stdout.print("\n", .{});

//     var hh = crypto.Sha256.init(.{});
//     var h2 = mem.bytesToValue(@TypeOf(hh), &m);
//     const m2 = mem.toBytes(h2);
//     var outm2 = std.fmt.fmtSliceHexLower(m2[0..]);
//     try stdout.print("{s}", .{outm2});
//     try stdout.print("\n", .{});
//     h2.final(out[0..]);
//     try stdout.print("{s}", .{std.fmt.fmtSliceHexLower(out[0..])});
//     try stdout.print("\n", .{});
// }