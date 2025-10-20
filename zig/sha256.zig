const std = @import("std");
const crypto = std.crypto.hash.sha2;

// Global state storage for streaming
var sha256_state: crypto.Sha256 = undefined;
var state_initialized = false;

// A dedicated, static buffer for receiving file chunks from JavaScript
const CHUNK_BUFFER_SIZE = 524288; // 512KB (optimized)
var chunk_buffer: [CHUNK_BUFFER_SIZE]u8 = undefined;

// Buffer for storing the final hash
var digest_buffer: [32]u8 = undefined;

export fn initSHA256() void {
    sha256_state = crypto.Sha256.init(.{});
    state_initialized = true;
}

export fn update(data_len: usize) void {
    if (!state_initialized) {
        initSHA256();
    }
    
    // Process data directly from the dedicated internal buffer
    const data_slice = chunk_buffer[0..data_len];
    sha256_state.update(data_slice);
}

export fn digest() void {
    if (!state_initialized) {
        initSHA256();
    }
    sha256_state.final(digest_buffer[0..]);
    // Reset state for next use
    state_initialized = false;
}

export fn getDigest() [*]const u8 {
    return &digest_buffer;
}

export fn getChunkBufferPtr() [*]u8 {
    return &chunk_buffer;
}

// Keep exports alive for the linker
comptime {
    _ = initSHA256;
    _ = update;
    _ = digest;
    _ = getDigest;
    _ = getChunkBufferPtr;
}
