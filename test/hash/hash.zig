const c = @cImport({
    @cInclude("kklib.h");
    @cInclude("xxhash.h");
});

export fn kk_xxh32(v: c.kk_vector_t, seed: u32, ctx: *c.kk_context_t) u32 {
    defer c.kk_vector_drop(v,ctx);
    var maybe_len: c.kk_ssize_t = -1;
    const p = c.kk_vector_buf_borrow(v,&maybe_len);
    const len = @intCast(usize, maybe_len);
    const intflen: usize = @sizeOf(c.kk_intf_t) * len;
    const buffer = @ptrCast([*]c.kk_intf_t, @alignCast(8, c.kk_malloc(@intCast(i64, intflen), ctx)));
    defer c.kk_free(buffer, ctx);
    var i: usize = 0;
    while (i < len) : (i += 1) {
        buffer[i] = c.kk_intf_unbox(p[i]);
    }
    return c.XXH32(buffer, intflen, seed);
}
