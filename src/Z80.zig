pub const __builtin_bswap16 = @import("std").zig.c_builtins.__builtin_bswap16;
pub const __builtin_bswap32 = @import("std").zig.c_builtins.__builtin_bswap32;
pub const __builtin_bswap64 = @import("std").zig.c_builtins.__builtin_bswap64;
pub const __builtin_signbit = @import("std").zig.c_builtins.__builtin_signbit;
pub const __builtin_signbitf = @import("std").zig.c_builtins.__builtin_signbitf;
pub const __builtin_popcount = @import("std").zig.c_builtins.__builtin_popcount;
pub const __builtin_ctz = @import("std").zig.c_builtins.__builtin_ctz;
pub const __builtin_clz = @import("std").zig.c_builtins.__builtin_clz;
pub const __builtin_sqrt = @import("std").zig.c_builtins.__builtin_sqrt;
pub const __builtin_sqrtf = @import("std").zig.c_builtins.__builtin_sqrtf;
pub const __builtin_sin = @import("std").zig.c_builtins.__builtin_sin;
pub const __builtin_sinf = @import("std").zig.c_builtins.__builtin_sinf;
pub const __builtin_cos = @import("std").zig.c_builtins.__builtin_cos;
pub const __builtin_cosf = @import("std").zig.c_builtins.__builtin_cosf;
pub const __builtin_exp = @import("std").zig.c_builtins.__builtin_exp;
pub const __builtin_expf = @import("std").zig.c_builtins.__builtin_expf;
pub const __builtin_exp2 = @import("std").zig.c_builtins.__builtin_exp2;
pub const __builtin_exp2f = @import("std").zig.c_builtins.__builtin_exp2f;
pub const __builtin_log = @import("std").zig.c_builtins.__builtin_log;
pub const __builtin_logf = @import("std").zig.c_builtins.__builtin_logf;
pub const __builtin_log2 = @import("std").zig.c_builtins.__builtin_log2;
pub const __builtin_log2f = @import("std").zig.c_builtins.__builtin_log2f;
pub const __builtin_log10 = @import("std").zig.c_builtins.__builtin_log10;
pub const __builtin_log10f = @import("std").zig.c_builtins.__builtin_log10f;
pub const __builtin_abs = @import("std").zig.c_builtins.__builtin_abs;
pub const __builtin_labs = @import("std").zig.c_builtins.__builtin_labs;
pub const __builtin_llabs = @import("std").zig.c_builtins.__builtin_llabs;
pub const __builtin_fabs = @import("std").zig.c_builtins.__builtin_fabs;
pub const __builtin_fabsf = @import("std").zig.c_builtins.__builtin_fabsf;
pub const __builtin_floor = @import("std").zig.c_builtins.__builtin_floor;
pub const __builtin_floorf = @import("std").zig.c_builtins.__builtin_floorf;
pub const __builtin_ceil = @import("std").zig.c_builtins.__builtin_ceil;
pub const __builtin_ceilf = @import("std").zig.c_builtins.__builtin_ceilf;
pub const __builtin_trunc = @import("std").zig.c_builtins.__builtin_trunc;
pub const __builtin_truncf = @import("std").zig.c_builtins.__builtin_truncf;
pub const __builtin_round = @import("std").zig.c_builtins.__builtin_round;
pub const __builtin_roundf = @import("std").zig.c_builtins.__builtin_roundf;
pub const __builtin_strlen = @import("std").zig.c_builtins.__builtin_strlen;
pub const __builtin_strcmp = @import("std").zig.c_builtins.__builtin_strcmp;
pub const __builtin_object_size = @import("std").zig.c_builtins.__builtin_object_size;
pub const __builtin___memset_chk = @import("std").zig.c_builtins.__builtin___memset_chk;
pub const __builtin_memset = @import("std").zig.c_builtins.__builtin_memset;
pub const __builtin___memcpy_chk = @import("std").zig.c_builtins.__builtin___memcpy_chk;
pub const __builtin_memcpy = @import("std").zig.c_builtins.__builtin_memcpy;
pub const __builtin_expect = @import("std").zig.c_builtins.__builtin_expect;
pub const __builtin_nanf = @import("std").zig.c_builtins.__builtin_nanf;
pub const __builtin_huge_valf = @import("std").zig.c_builtins.__builtin_huge_valf;
pub const __builtin_inff = @import("std").zig.c_builtins.__builtin_inff;
pub const __builtin_isnan = @import("std").zig.c_builtins.__builtin_isnan;
pub const __builtin_isinf = @import("std").zig.c_builtins.__builtin_isinf;
pub const __builtin_isinf_sign = @import("std").zig.c_builtins.__builtin_isinf_sign;
pub const __has_builtin = @import("std").zig.c_builtins.__has_builtin;
pub const __builtin_assume = @import("std").zig.c_builtins.__builtin_assume;
pub const __builtin_unreachable = @import("std").zig.c_builtins.__builtin_unreachable;
pub const __builtin_constant_p = @import("std").zig.c_builtins.__builtin_constant_p;
pub const __builtin_mul_overflow = @import("std").zig.c_builtins.__builtin_mul_overflow;
pub const zuint8 = u8;
pub const zsint8 = i8;
pub const zuint16 = c_ushort;
pub const zsint16 = c_short;
pub const zuint32 = c_uint;
pub const zsint32 = c_int;
pub const zuint64 = c_ulong;
pub const zsint64 = c_long;
pub const __uint128_t = u128;
pub const zuint128 = __uint128_t;
pub const __int128_t = i128;
pub const zsint128 = __int128_t;
pub const zuint_least8 = zuint8;
pub const zsint_least8 = zsint8;
pub const zuint_least16 = zuint16;
pub const zsint_least16 = zsint16;
pub const zuint_least24 = zuint32;
pub const zsint_least24 = zsint32;
pub const zuint_least32 = zuint32;
pub const zsint_least32 = zsint32;
pub const zuint_least40 = zuint64;
pub const zsint_least40 = zsint64;
pub const zuint_least48 = zuint64;
pub const zsint_least48 = zsint64;
pub const zuint_least56 = zuint64;
pub const zsint_least56 = zsint64;
pub const zuint_least64 = zuint64;
pub const zsint_least64 = zsint64;
pub const zchar = u8;
pub const zuchar = u8;
pub const zschar = i8;
pub const zushort = c_ushort;
pub const zsshort = c_short;
pub const zuint = c_uint;
pub const zsint = c_int;
pub const zulong = c_ulong;
pub const zslong = c_long;
pub const zullong = c_ulonglong;
pub const zsllong = c_longlong;
pub const zbool = bool;
pub const zusize = zuint64;
pub const zssize = zsint64;
pub const zuintmax = zuint128;
pub const zsintmax = zsint128;
pub const zintmax = zuintmax;
pub const zuintptr = zuint64;
pub const zsintptr = zsint64;
pub const zptrdiff = zsintptr;
pub const zboolean = zbool;
pub const znatural = zuint64;
pub const zinteger = zsint64;
const struct_unnamed_1 = extern struct {
    at_0: zuint8 = @import("std").mem.zeroes(zuint8),
};
const struct_unnamed_2 = extern struct {
    at_0: zsint8 = @import("std").mem.zeroes(zsint8),
};
pub const ZInt8 = extern union {
    uint8_value: zuint8 align(1),
    uint8_array: [1]zuint8 align(1),
    uint8_values: struct_unnamed_1 align(1),
    sint8_value: zsint8 align(1),
    sint8_array: zsint8 align(1),
    sint8_values: struct_unnamed_2 align(1),
};
const struct_unnamed_3 = extern struct {
    at_0: zuint16 = @import("std").mem.zeroes(zuint16),
};
const struct_unnamed_4 = extern struct {
    at_0: zsint16 = @import("std").mem.zeroes(zsint16),
};
const struct_unnamed_5 = extern struct {
    at_0: zuint8 = @import("std").mem.zeroes(zuint8),
    at_1: zuint8 = @import("std").mem.zeroes(zuint8),
};
const struct_unnamed_6 = extern struct {
    at_0: zsint8 = @import("std").mem.zeroes(zsint8),
    at_1: zsint8 = @import("std").mem.zeroes(zsint8),
};
pub const ZInt16 = extern union {
    uint16_value: zuint16 align(1),
    uint16_array: [1]zuint16 align(1),
    uint16_values: struct_unnamed_3 align(1),
    sint16_value: zsint16 align(1),
    sint16_array: zsint16 align(1),
    sint16_values: struct_unnamed_4 align(1),
    uint8_array: [2]zuint8 align(1),
    uint8_values: struct_unnamed_5 align(1),
    sint8_array: [2]zsint8 align(1),
    sint8_values: struct_unnamed_6 align(1),
};
const struct_unnamed_7 = extern struct {
    at_0: zuint32 = @import("std").mem.zeroes(zuint32),
};
const struct_unnamed_8 = extern struct {
    at_0: zsint32 = @import("std").mem.zeroes(zsint32),
};
const struct_unnamed_9 = extern struct {
    at_0: zuint16 = @import("std").mem.zeroes(zuint16),
    at_1: zuint16 = @import("std").mem.zeroes(zuint16),
};
const struct_unnamed_10 = extern struct {
    at_0: zsint16 = @import("std").mem.zeroes(zsint16),
    at_1: zsint16 = @import("std").mem.zeroes(zsint16),
};
const struct_unnamed_11 = extern struct {
    at_0: zuint8 = @import("std").mem.zeroes(zuint8),
    at_1: zuint8 = @import("std").mem.zeroes(zuint8),
    at_2: zuint8 = @import("std").mem.zeroes(zuint8),
    at_3: zuint8 = @import("std").mem.zeroes(zuint8),
};
const struct_unnamed_12 = extern struct {
    at_0: zsint8 = @import("std").mem.zeroes(zsint8),
    at_1: zsint8 = @import("std").mem.zeroes(zsint8),
    at_2: zsint8 = @import("std").mem.zeroes(zsint8),
    at_3: zsint8 = @import("std").mem.zeroes(zsint8),
};
pub const ZInt32 = extern union {
    uint32_value: zuint32 align(1),
    uint32_array: [1]zuint32 align(1),
    uint32_values: struct_unnamed_7 align(1),
    sint32_value: zsint32 align(1),
    sint32_array: zsint32 align(1),
    sint32_values: struct_unnamed_8 align(1),
    uint16_array: [2]zuint16 align(1),
    uint16_values: struct_unnamed_9 align(1),
    sint16_array: [2]zsint16 align(1),
    sint16_values: struct_unnamed_10 align(1),
    uint8_array: [4]zuint8 align(1),
    uint8_values: struct_unnamed_11 align(1),
    sint8_array: [4]zsint8 align(1),
    sint8_values: struct_unnamed_12 align(1),
};
const struct_unnamed_13 = extern struct {
    at_0: zuint64 = @import("std").mem.zeroes(zuint64),
};
const struct_unnamed_14 = extern struct {
    at_0: zsint64 = @import("std").mem.zeroes(zsint64),
};
const struct_unnamed_15 = extern struct {
    at_0: zuint32 = @import("std").mem.zeroes(zuint32),
    at_1: zuint32 = @import("std").mem.zeroes(zuint32),
};
const struct_unnamed_16 = extern struct {
    at_0: zsint32 = @import("std").mem.zeroes(zsint32),
    at_1: zsint32 = @import("std").mem.zeroes(zsint32),
};
const struct_unnamed_17 = extern struct {
    at_0: zuint16 = @import("std").mem.zeroes(zuint16),
    at_1: zuint16 = @import("std").mem.zeroes(zuint16),
    at_2: zuint16 = @import("std").mem.zeroes(zuint16),
    at_3: zuint16 = @import("std").mem.zeroes(zuint16),
};
const struct_unnamed_18 = extern struct {
    at_0: zsint16 = @import("std").mem.zeroes(zsint16),
    at_1: zsint16 = @import("std").mem.zeroes(zsint16),
    at_2: zsint16 = @import("std").mem.zeroes(zsint16),
    at_3: zsint16 = @import("std").mem.zeroes(zsint16),
};
const struct_unnamed_19 = extern struct {
    at_0: zuint8 = @import("std").mem.zeroes(zuint8),
    at_1: zuint8 = @import("std").mem.zeroes(zuint8),
    at_2: zuint8 = @import("std").mem.zeroes(zuint8),
    at_3: zuint8 = @import("std").mem.zeroes(zuint8),
    at_4: zuint8 = @import("std").mem.zeroes(zuint8),
    at_5: zuint8 = @import("std").mem.zeroes(zuint8),
    at_6: zuint8 = @import("std").mem.zeroes(zuint8),
    at_7: zuint8 = @import("std").mem.zeroes(zuint8),
};
const struct_unnamed_20 = extern struct {
    at_0: zsint8 = @import("std").mem.zeroes(zsint8),
    at_1: zsint8 = @import("std").mem.zeroes(zsint8),
    at_2: zsint8 = @import("std").mem.zeroes(zsint8),
    at_3: zsint8 = @import("std").mem.zeroes(zsint8),
    at_4: zsint8 = @import("std").mem.zeroes(zsint8),
    at_5: zsint8 = @import("std").mem.zeroes(zsint8),
    at_6: zsint8 = @import("std").mem.zeroes(zsint8),
    at_7: zsint8 = @import("std").mem.zeroes(zsint8),
};
pub const ZInt64 = extern union {
    uint64_value: zuint64 align(1),
    uint64_array: [1]zuint64 align(1),
    uint64_values: struct_unnamed_13 align(1),
    sint64_value: zsint64 align(1),
    sint64_array: zsint64 align(1),
    sint64_values: struct_unnamed_14 align(1),
    uint32_array: [2]zuint32 align(1),
    uint32_values: struct_unnamed_15 align(1),
    sint32_array: [2]zsint32 align(1),
    sint32_values: struct_unnamed_16 align(1),
    uint16_array: [4]zuint16 align(1),
    uint16_values: struct_unnamed_17 align(1),
    sint16_array: [4]zsint16 align(1),
    sint16_values: struct_unnamed_18 align(1),
    uint8_array: [8]zuint8 align(1),
    uint8_values: struct_unnamed_19 align(1),
    sint8_array: [8]zsint8 align(1),
    sint8_values: struct_unnamed_20 align(1),
};
const struct_unnamed_21 = extern struct {
    at_0: zuint128 = @import("std").mem.zeroes(zuint128),
};
const struct_unnamed_22 = extern struct {
    at_0: zsint128 = @import("std").mem.zeroes(zsint128),
};
const struct_unnamed_23 = extern struct {
    at_0: zuint64 = @import("std").mem.zeroes(zuint64),
    at_1: zuint64 = @import("std").mem.zeroes(zuint64),
};
const struct_unnamed_24 = extern struct {
    at_0: zsint64 = @import("std").mem.zeroes(zsint64),
    at_1: zsint64 = @import("std").mem.zeroes(zsint64),
};
const struct_unnamed_25 = extern struct {
    at_0: zuint32 = @import("std").mem.zeroes(zuint32),
    at_1: zuint32 = @import("std").mem.zeroes(zuint32),
    at_2: zuint32 = @import("std").mem.zeroes(zuint32),
    at_3: zuint32 = @import("std").mem.zeroes(zuint32),
};
const struct_unnamed_26 = extern struct {
    at_0: zsint32 = @import("std").mem.zeroes(zsint32),
    at_1: zsint32 = @import("std").mem.zeroes(zsint32),
    at_2: zsint32 = @import("std").mem.zeroes(zsint32),
    at_3: zsint32 = @import("std").mem.zeroes(zsint32),
};
const struct_unnamed_27 = extern struct {
    at_0: zuint16 = @import("std").mem.zeroes(zuint16),
    at_1: zuint16 = @import("std").mem.zeroes(zuint16),
    at_2: zuint16 = @import("std").mem.zeroes(zuint16),
    at_3: zuint16 = @import("std").mem.zeroes(zuint16),
    at_4: zuint16 = @import("std").mem.zeroes(zuint16),
    at_5: zuint16 = @import("std").mem.zeroes(zuint16),
    at_6: zuint16 = @import("std").mem.zeroes(zuint16),
    at_7: zuint16 = @import("std").mem.zeroes(zuint16),
};
const struct_unnamed_28 = extern struct {
    at_0: zsint16 = @import("std").mem.zeroes(zsint16),
    at_1: zsint16 = @import("std").mem.zeroes(zsint16),
    at_2: zsint16 = @import("std").mem.zeroes(zsint16),
    at_3: zsint16 = @import("std").mem.zeroes(zsint16),
    at_4: zsint16 = @import("std").mem.zeroes(zsint16),
    at_5: zsint16 = @import("std").mem.zeroes(zsint16),
    at_6: zsint16 = @import("std").mem.zeroes(zsint16),
    at_7: zsint16 = @import("std").mem.zeroes(zsint16),
};
const struct_unnamed_29 = extern struct {
    at_0: zuint8 = @import("std").mem.zeroes(zuint8),
    at_1: zuint8 = @import("std").mem.zeroes(zuint8),
    at_2: zuint8 = @import("std").mem.zeroes(zuint8),
    at_3: zuint8 = @import("std").mem.zeroes(zuint8),
    at_4: zuint8 = @import("std").mem.zeroes(zuint8),
    at_5: zuint8 = @import("std").mem.zeroes(zuint8),
    at_6: zuint8 = @import("std").mem.zeroes(zuint8),
    at_7: zuint8 = @import("std").mem.zeroes(zuint8),
    at_8: zuint8 = @import("std").mem.zeroes(zuint8),
    at_9: zuint8 = @import("std").mem.zeroes(zuint8),
    at_10: zuint8 = @import("std").mem.zeroes(zuint8),
    at_11: zuint8 = @import("std").mem.zeroes(zuint8),
    at_12: zuint8 = @import("std").mem.zeroes(zuint8),
    at_13: zuint8 = @import("std").mem.zeroes(zuint8),
    at_14: zuint8 = @import("std").mem.zeroes(zuint8),
    at_15: zuint8 = @import("std").mem.zeroes(zuint8),
};
const struct_unnamed_30 = extern struct {
    at_0: zsint8 = @import("std").mem.zeroes(zsint8),
    at_1: zsint8 = @import("std").mem.zeroes(zsint8),
    at_2: zsint8 = @import("std").mem.zeroes(zsint8),
    at_3: zsint8 = @import("std").mem.zeroes(zsint8),
    at_4: zsint8 = @import("std").mem.zeroes(zsint8),
    at_5: zsint8 = @import("std").mem.zeroes(zsint8),
    at_6: zsint8 = @import("std").mem.zeroes(zsint8),
    at_7: zsint8 = @import("std").mem.zeroes(zsint8),
    at_8: zsint8 = @import("std").mem.zeroes(zsint8),
    at_9: zsint8 = @import("std").mem.zeroes(zsint8),
    at_10: zsint8 = @import("std").mem.zeroes(zsint8),
    at_11: zsint8 = @import("std").mem.zeroes(zsint8),
    at_12: zsint8 = @import("std").mem.zeroes(zsint8),
    at_13: zsint8 = @import("std").mem.zeroes(zsint8),
    at_14: zsint8 = @import("std").mem.zeroes(zsint8),
    at_15: zsint8 = @import("std").mem.zeroes(zsint8),
};
pub const ZInt128 = extern union {
    uint128_value: zuint128 align(1),
    uint128_array: [1]zuint128 align(1),
    uint128_values: struct_unnamed_21 align(1),
    sint128_value: zsint128 align(1),
    sint128_array: zsint128 align(1),
    sint128_values: struct_unnamed_22 align(1),
    uint64_array: [2]zuint64 align(1),
    uint64_values: struct_unnamed_23 align(1),
    sint64_array: [2]zsint64 align(1),
    sint64_values: struct_unnamed_24 align(1),
    uint32_array: [4]zuint32 align(1),
    uint32_values: struct_unnamed_25 align(1),
    sint32_array: [4]zsint32 align(1),
    sint32_values: struct_unnamed_26 align(1),
    uint16_array: [8]zuint16 align(1),
    uint16_values: struct_unnamed_27 align(1),
    sint16_array: [8]zsint16 align(1),
    sint16_values: struct_unnamed_28 align(1),
    uint8_array: [16]zuint8 align(1),
    uint8_values: struct_unnamed_29 align(1),
    sint8_array: [16]zsint8 align(1),
    sint8_values: struct_unnamed_30 align(1),
};
pub const Z80Read = ?*const fn (?*anyopaque, zuint16) callconv(.C) zuint8;
pub const Z80Write = ?*const fn (?*anyopaque, zuint16, zuint8) callconv(.C) void;
pub const Z80Halt = ?*const fn (?*anyopaque, zuint8) callconv(.C) void;
pub const Z80Notify = ?*const fn (?*anyopaque) callconv(.C) void;
pub const Z80 = struct_Z80;
pub const Z80Illegal = ?*const fn ([*c]Z80, zuint8) callconv(.C) zuint8;
pub const struct_Z80 = extern struct {
    cycles: zusize = @import("std").mem.zeroes(zusize),
    cycle_limit: zusize = @import("std").mem.zeroes(zusize),
    context: ?*anyopaque = @import("std").mem.zeroes(?*anyopaque),
    fetch_opcode: Z80Read = @import("std").mem.zeroes(Z80Read),
    fetch: Z80Read = @import("std").mem.zeroes(Z80Read),
    read: Z80Read = @import("std").mem.zeroes(Z80Read),
    write: Z80Write = @import("std").mem.zeroes(Z80Write),
    in: Z80Read = @import("std").mem.zeroes(Z80Read),
    out: Z80Write = @import("std").mem.zeroes(Z80Write),
    halt: Z80Halt = @import("std").mem.zeroes(Z80Halt),
    nop: Z80Read = @import("std").mem.zeroes(Z80Read),
    nmia: Z80Read = @import("std").mem.zeroes(Z80Read),
    inta: Z80Read = @import("std").mem.zeroes(Z80Read),
    int_fetch: Z80Read = @import("std").mem.zeroes(Z80Read),
    ld_i_a: Z80Notify = @import("std").mem.zeroes(Z80Notify),
    ld_r_a: Z80Notify = @import("std").mem.zeroes(Z80Notify),
    reti: Z80Notify = @import("std").mem.zeroes(Z80Notify),
    retn: Z80Notify = @import("std").mem.zeroes(Z80Notify),
    hook: Z80Read = @import("std").mem.zeroes(Z80Read),
    illegal: Z80Illegal = @import("std").mem.zeroes(Z80Illegal),
    data: ZInt32 = @import("std").mem.zeroes(ZInt32),
    ix_iy: [2]ZInt16 = @import("std").mem.zeroes([2]ZInt16),
    pc: ZInt16 = @import("std").mem.zeroes(ZInt16),
    sp: ZInt16 = @import("std").mem.zeroes(ZInt16),
    xy: ZInt16 = @import("std").mem.zeroes(ZInt16),
    memptr: ZInt16 = @import("std").mem.zeroes(ZInt16),
    af: ZInt16 = @import("std").mem.zeroes(ZInt16),
    bc: ZInt16 = @import("std").mem.zeroes(ZInt16),
    de: ZInt16 = @import("std").mem.zeroes(ZInt16),
    hl: ZInt16 = @import("std").mem.zeroes(ZInt16),
    af_: ZInt16 = @import("std").mem.zeroes(ZInt16),
    bc_: ZInt16 = @import("std").mem.zeroes(ZInt16),
    de_: ZInt16 = @import("std").mem.zeroes(ZInt16),
    hl_: ZInt16 = @import("std").mem.zeroes(ZInt16),
    r: zuint8 = @import("std").mem.zeroes(zuint8),
    i: zuint8 = @import("std").mem.zeroes(zuint8),
    r7: zuint8 = @import("std").mem.zeroes(zuint8),
    im: zuint8 = @import("std").mem.zeroes(zuint8),
    request: zuint8 = @import("std").mem.zeroes(zuint8),
    @"resume": zuint8 = @import("std").mem.zeroes(zuint8),
    iff1: zuint8 = @import("std").mem.zeroes(zuint8),
    iff2: zuint8 = @import("std").mem.zeroes(zuint8),
    q: zuint8 = @import("std").mem.zeroes(zuint8),
    options: zuint8 = @import("std").mem.zeroes(zuint8),
    int_line: zuint8 = @import("std").mem.zeroes(zuint8),
    halt_line: zuint8 = @import("std").mem.zeroes(zuint8),
};
pub extern fn z80_power(self: [*c]Z80, state: zboolean) void;
pub extern fn z80_instant_reset(self: [*c]Z80) void;
pub extern fn z80_special_reset(self: [*c]Z80) void;
pub extern fn z80_int(self: [*c]Z80, state: zboolean) void;
pub extern fn z80_nmi(self: [*c]Z80) void;
pub extern fn z80_execute(self: [*c]Z80, cycles: zusize) zusize;
pub extern fn z80_run(self: [*c]Z80, cycles: zusize) zusize;
pub inline fn z80_break(arg_self: [*c]Z80) void {
    var self = arg_self;
    _ = &self;
    self.*.cycle_limit = 0;
}
pub inline fn z80_r(arg_self: [*c]const Z80) zuint8 {
    var self = arg_self;
    _ = &self;
    return @as(zuint8, @bitCast(@as(i8, @truncate((@as(c_int, @bitCast(@as(c_uint, self.*.r))) & @as(c_int, 127)) | (@as(c_int, @bitCast(@as(c_uint, self.*.r7))) & @as(c_int, 128))))));
}
pub inline fn z80_refresh_address(arg_self: [*c]const Z80) zuint16 {
    var self = arg_self;
    _ = &self;
    return @as(zuint16, @bitCast(@as(c_short, @truncate(((@as(c_int, @bitCast(@as(c_uint, @as(zuint16, @bitCast(@as(c_ushort, self.*.i)))))) << @intCast(8)) | ((@as(c_int, @bitCast(@as(c_uint, self.*.r))) - @as(c_int, 1)) & @as(c_int, 127))) | (@as(c_int, @bitCast(@as(c_uint, self.*.r7))) & @as(c_int, 128))))));
}
pub inline fn z80_in_cycle(arg_self: [*c]const Z80) zuint8 {
    var self = arg_self;
    _ = &self;
    return @as(zuint8, @bitCast(@as(i8, @truncate(if (@as(c_int, @bitCast(@as(c_uint, self.*.data.uint8_array[@as(c_uint, @intCast(@as(c_int, 0)))]))) == @as(c_int, 219)) @as(c_int, 7) else @as(c_int, 8) + (@as(c_int, @bitCast(@as(c_uint, self.*.data.uint8_array[@as(c_uint, @intCast(@as(c_int, 1)))]))) >> @intCast(7))))));
}
pub inline fn z80_out_cycle(arg_self: [*c]const Z80) zuint8 {
    var self = arg_self;
    _ = &self;
    return @as(zuint8, @bitCast(@as(i8, @truncate(if (@as(c_int, @bitCast(@as(c_uint, self.*.data.uint8_array[@as(c_uint, @intCast(@as(c_int, 0)))]))) == @as(c_int, 211)) @as(c_int, 7) else @as(c_int, 8) + ((@as(c_int, @bitCast(@as(c_uint, self.*.data.uint8_array[@as(c_uint, @intCast(@as(c_int, 1)))]))) >> @intCast(7)) << @intCast(2))))));
}
pub const __llvm__ = @as(c_int, 1);
pub const __clang__ = @as(c_int, 1);
pub const __clang_major__ = @as(c_int, 18);
pub const __clang_minor__ = @as(c_int, 1);
pub const __clang_patchlevel__ = @as(c_int, 6);
pub const __clang_version__ = "18.1.6 ";
pub const __GNUC__ = @as(c_int, 4);
pub const __GNUC_MINOR__ = @as(c_int, 2);
pub const __GNUC_PATCHLEVEL__ = @as(c_int, 1);
pub const __GXX_ABI_VERSION = @as(c_int, 1002);
pub const __ATOMIC_RELAXED = @as(c_int, 0);
pub const __ATOMIC_CONSUME = @as(c_int, 1);
pub const __ATOMIC_ACQUIRE = @as(c_int, 2);
pub const __ATOMIC_RELEASE = @as(c_int, 3);
pub const __ATOMIC_ACQ_REL = @as(c_int, 4);
pub const __ATOMIC_SEQ_CST = @as(c_int, 5);
pub const __MEMORY_SCOPE_SYSTEM = @as(c_int, 0);
pub const __MEMORY_SCOPE_DEVICE = @as(c_int, 1);
pub const __MEMORY_SCOPE_WRKGRP = @as(c_int, 2);
pub const __MEMORY_SCOPE_WVFRNT = @as(c_int, 3);
pub const __MEMORY_SCOPE_SINGLE = @as(c_int, 4);
pub const __OPENCL_MEMORY_SCOPE_WORK_ITEM = @as(c_int, 0);
pub const __OPENCL_MEMORY_SCOPE_WORK_GROUP = @as(c_int, 1);
pub const __OPENCL_MEMORY_SCOPE_DEVICE = @as(c_int, 2);
pub const __OPENCL_MEMORY_SCOPE_ALL_SVM_DEVICES = @as(c_int, 3);
pub const __OPENCL_MEMORY_SCOPE_SUB_GROUP = @as(c_int, 4);
pub const __FPCLASS_SNAN = @as(c_int, 0x0001);
pub const __FPCLASS_QNAN = @as(c_int, 0x0002);
pub const __FPCLASS_NEGINF = @as(c_int, 0x0004);
pub const __FPCLASS_NEGNORMAL = @as(c_int, 0x0008);
pub const __FPCLASS_NEGSUBNORMAL = @as(c_int, 0x0010);
pub const __FPCLASS_NEGZERO = @as(c_int, 0x0020);
pub const __FPCLASS_POSZERO = @as(c_int, 0x0040);
pub const __FPCLASS_POSSUBNORMAL = @as(c_int, 0x0080);
pub const __FPCLASS_POSNORMAL = @as(c_int, 0x0100);
pub const __FPCLASS_POSINF = @as(c_int, 0x0200);
pub const __PRAGMA_REDEFINE_EXTNAME = @as(c_int, 1);
pub const __VERSION__ = "Homebrew Clang 18.1.6";
pub const __OBJC_BOOL_IS_BOOL = @as(c_int, 1);
pub const __CONSTANT_CFSTRINGS__ = @as(c_int, 1);
pub const __block = @compileError("unable to translate macro: undefined identifier `__blocks__`");
// (no file):42:9
pub const __BLOCKS__ = @as(c_int, 1);
pub const __clang_literal_encoding__ = "UTF-8";
pub const __clang_wide_literal_encoding__ = "UTF-32";
pub const __ORDER_LITTLE_ENDIAN__ = @as(c_int, 1234);
pub const __ORDER_BIG_ENDIAN__ = @as(c_int, 4321);
pub const __ORDER_PDP_ENDIAN__ = @as(c_int, 3412);
pub const __BYTE_ORDER__ = __ORDER_LITTLE_ENDIAN__;
pub const __LITTLE_ENDIAN__ = @as(c_int, 1);
pub const _LP64 = @as(c_int, 1);
pub const __LP64__ = @as(c_int, 1);
pub const __CHAR_BIT__ = @as(c_int, 8);
pub const __BOOL_WIDTH__ = @as(c_int, 8);
pub const __SHRT_WIDTH__ = @as(c_int, 16);
pub const __INT_WIDTH__ = @as(c_int, 32);
pub const __LONG_WIDTH__ = @as(c_int, 64);
pub const __LLONG_WIDTH__ = @as(c_int, 64);
pub const __BITINT_MAXWIDTH__ = @as(c_int, 128);
pub const __SCHAR_MAX__ = @as(c_int, 127);
pub const __SHRT_MAX__ = @as(c_int, 32767);
pub const __INT_MAX__ = @import("std").zig.c_translation.promoteIntLiteral(c_int, 2147483647, .decimal);
pub const __LONG_MAX__ = @import("std").zig.c_translation.promoteIntLiteral(c_long, 9223372036854775807, .decimal);
pub const __LONG_LONG_MAX__ = @as(c_longlong, 9223372036854775807);
pub const __WCHAR_MAX__ = @import("std").zig.c_translation.promoteIntLiteral(c_int, 2147483647, .decimal);
pub const __WCHAR_WIDTH__ = @as(c_int, 32);
pub const __WINT_MAX__ = @import("std").zig.c_translation.promoteIntLiteral(c_int, 2147483647, .decimal);
pub const __WINT_WIDTH__ = @as(c_int, 32);
pub const __INTMAX_MAX__ = @import("std").zig.c_translation.promoteIntLiteral(c_long, 9223372036854775807, .decimal);
pub const __INTMAX_WIDTH__ = @as(c_int, 64);
pub const __SIZE_MAX__ = @import("std").zig.c_translation.promoteIntLiteral(c_ulong, 18446744073709551615, .decimal);
pub const __SIZE_WIDTH__ = @as(c_int, 64);
pub const __UINTMAX_MAX__ = @import("std").zig.c_translation.promoteIntLiteral(c_ulong, 18446744073709551615, .decimal);
pub const __UINTMAX_WIDTH__ = @as(c_int, 64);
pub const __PTRDIFF_MAX__ = @import("std").zig.c_translation.promoteIntLiteral(c_long, 9223372036854775807, .decimal);
pub const __PTRDIFF_WIDTH__ = @as(c_int, 64);
pub const __INTPTR_MAX__ = @import("std").zig.c_translation.promoteIntLiteral(c_long, 9223372036854775807, .decimal);
pub const __INTPTR_WIDTH__ = @as(c_int, 64);
pub const __UINTPTR_MAX__ = @import("std").zig.c_translation.promoteIntLiteral(c_ulong, 18446744073709551615, .decimal);
pub const __UINTPTR_WIDTH__ = @as(c_int, 64);
pub const __SIZEOF_DOUBLE__ = @as(c_int, 8);
pub const __SIZEOF_FLOAT__ = @as(c_int, 4);
pub const __SIZEOF_INT__ = @as(c_int, 4);
pub const __SIZEOF_LONG__ = @as(c_int, 8);
pub const __SIZEOF_LONG_DOUBLE__ = @as(c_int, 8);
pub const __SIZEOF_LONG_LONG__ = @as(c_int, 8);
pub const __SIZEOF_POINTER__ = @as(c_int, 8);
pub const __SIZEOF_SHORT__ = @as(c_int, 2);
pub const __SIZEOF_PTRDIFF_T__ = @as(c_int, 8);
pub const __SIZEOF_SIZE_T__ = @as(c_int, 8);
pub const __SIZEOF_WCHAR_T__ = @as(c_int, 4);
pub const __SIZEOF_WINT_T__ = @as(c_int, 4);
pub const __SIZEOF_INT128__ = @as(c_int, 16);
pub const __INTMAX_TYPE__ = c_long;
pub const __INTMAX_FMTd__ = "ld";
pub const __INTMAX_FMTi__ = "li";
pub const __INTMAX_C_SUFFIX__ = @compileError("unable to translate macro: undefined identifier `L`");
// (no file):97:9
pub const __UINTMAX_TYPE__ = c_ulong;
pub const __UINTMAX_FMTo__ = "lo";
pub const __UINTMAX_FMTu__ = "lu";
pub const __UINTMAX_FMTx__ = "lx";
pub const __UINTMAX_FMTX__ = "lX";
pub const __UINTMAX_C_SUFFIX__ = @compileError("unable to translate macro: undefined identifier `UL`");
// (no file):103:9
pub const __PTRDIFF_TYPE__ = c_long;
pub const __PTRDIFF_FMTd__ = "ld";
pub const __PTRDIFF_FMTi__ = "li";
pub const __INTPTR_TYPE__ = c_long;
pub const __INTPTR_FMTd__ = "ld";
pub const __INTPTR_FMTi__ = "li";
pub const __SIZE_TYPE__ = c_ulong;
pub const __SIZE_FMTo__ = "lo";
pub const __SIZE_FMTu__ = "lu";
pub const __SIZE_FMTx__ = "lx";
pub const __SIZE_FMTX__ = "lX";
pub const __WCHAR_TYPE__ = c_int;
pub const __WINT_TYPE__ = c_int;
pub const __SIG_ATOMIC_MAX__ = @import("std").zig.c_translation.promoteIntLiteral(c_int, 2147483647, .decimal);
pub const __SIG_ATOMIC_WIDTH__ = @as(c_int, 32);
pub const __CHAR16_TYPE__ = c_ushort;
pub const __CHAR32_TYPE__ = c_uint;
pub const __UINTPTR_TYPE__ = c_ulong;
pub const __UINTPTR_FMTo__ = "lo";
pub const __UINTPTR_FMTu__ = "lu";
pub const __UINTPTR_FMTx__ = "lx";
pub const __UINTPTR_FMTX__ = "lX";
pub const __FLT16_DENORM_MIN__ = @as(f16, 5.9604644775390625e-8);
pub const __FLT16_HAS_DENORM__ = @as(c_int, 1);
pub const __FLT16_DIG__ = @as(c_int, 3);
pub const __FLT16_DECIMAL_DIG__ = @as(c_int, 5);
pub const __FLT16_EPSILON__ = @as(f16, 9.765625e-4);
pub const __FLT16_HAS_INFINITY__ = @as(c_int, 1);
pub const __FLT16_HAS_QUIET_NAN__ = @as(c_int, 1);
pub const __FLT16_MANT_DIG__ = @as(c_int, 11);
pub const __FLT16_MAX_10_EXP__ = @as(c_int, 4);
pub const __FLT16_MAX_EXP__ = @as(c_int, 16);
pub const __FLT16_MAX__ = @as(f16, 6.5504e+4);
pub const __FLT16_MIN_10_EXP__ = -@as(c_int, 4);
pub const __FLT16_MIN_EXP__ = -@as(c_int, 13);
pub const __FLT16_MIN__ = @as(f16, 6.103515625e-5);
pub const __FLT_DENORM_MIN__ = @as(f32, 1.40129846e-45);
pub const __FLT_HAS_DENORM__ = @as(c_int, 1);
pub const __FLT_DIG__ = @as(c_int, 6);
pub const __FLT_DECIMAL_DIG__ = @as(c_int, 9);
pub const __FLT_EPSILON__ = @as(f32, 1.19209290e-7);
pub const __FLT_HAS_INFINITY__ = @as(c_int, 1);
pub const __FLT_HAS_QUIET_NAN__ = @as(c_int, 1);
pub const __FLT_MANT_DIG__ = @as(c_int, 24);
pub const __FLT_MAX_10_EXP__ = @as(c_int, 38);
pub const __FLT_MAX_EXP__ = @as(c_int, 128);
pub const __FLT_MAX__ = @as(f32, 3.40282347e+38);
pub const __FLT_MIN_10_EXP__ = -@as(c_int, 37);
pub const __FLT_MIN_EXP__ = -@as(c_int, 125);
pub const __FLT_MIN__ = @as(f32, 1.17549435e-38);
pub const __DBL_DENORM_MIN__ = @as(f64, 4.9406564584124654e-324);
pub const __DBL_HAS_DENORM__ = @as(c_int, 1);
pub const __DBL_DIG__ = @as(c_int, 15);
pub const __DBL_DECIMAL_DIG__ = @as(c_int, 17);
pub const __DBL_EPSILON__ = @as(f64, 2.2204460492503131e-16);
pub const __DBL_HAS_INFINITY__ = @as(c_int, 1);
pub const __DBL_HAS_QUIET_NAN__ = @as(c_int, 1);
pub const __DBL_MANT_DIG__ = @as(c_int, 53);
pub const __DBL_MAX_10_EXP__ = @as(c_int, 308);
pub const __DBL_MAX_EXP__ = @as(c_int, 1024);
pub const __DBL_MAX__ = @as(f64, 1.7976931348623157e+308);
pub const __DBL_MIN_10_EXP__ = -@as(c_int, 307);
pub const __DBL_MIN_EXP__ = -@as(c_int, 1021);
pub const __DBL_MIN__ = @as(f64, 2.2250738585072014e-308);
pub const __LDBL_DENORM_MIN__ = @as(c_longdouble, 4.9406564584124654e-324);
pub const __LDBL_HAS_DENORM__ = @as(c_int, 1);
pub const __LDBL_DIG__ = @as(c_int, 15);
pub const __LDBL_DECIMAL_DIG__ = @as(c_int, 17);
pub const __LDBL_EPSILON__ = @as(c_longdouble, 2.2204460492503131e-16);
pub const __LDBL_HAS_INFINITY__ = @as(c_int, 1);
pub const __LDBL_HAS_QUIET_NAN__ = @as(c_int, 1);
pub const __LDBL_MANT_DIG__ = @as(c_int, 53);
pub const __LDBL_MAX_10_EXP__ = @as(c_int, 308);
pub const __LDBL_MAX_EXP__ = @as(c_int, 1024);
pub const __LDBL_MAX__ = @as(c_longdouble, 1.7976931348623157e+308);
pub const __LDBL_MIN_10_EXP__ = -@as(c_int, 307);
pub const __LDBL_MIN_EXP__ = -@as(c_int, 1021);
pub const __LDBL_MIN__ = @as(c_longdouble, 2.2250738585072014e-308);
pub const __POINTER_WIDTH__ = @as(c_int, 64);
pub const __BIGGEST_ALIGNMENT__ = @as(c_int, 8);
pub const __INT8_TYPE__ = i8;
pub const __INT8_FMTd__ = "hhd";
pub const __INT8_FMTi__ = "hhi";
pub const __INT8_C_SUFFIX__ = "";
pub const __INT16_TYPE__ = c_short;
pub const __INT16_FMTd__ = "hd";
pub const __INT16_FMTi__ = "hi";
pub const __INT16_C_SUFFIX__ = "";
pub const __INT32_TYPE__ = c_int;
pub const __INT32_FMTd__ = "d";
pub const __INT32_FMTi__ = "i";
pub const __INT32_C_SUFFIX__ = "";
pub const __INT64_TYPE__ = c_longlong;
pub const __INT64_FMTd__ = "lld";
pub const __INT64_FMTi__ = "lli";
pub const __INT64_C_SUFFIX__ = @compileError("unable to translate macro: undefined identifier `LL`");
// (no file):199:9
pub const __UINT8_TYPE__ = u8;
pub const __UINT8_FMTo__ = "hho";
pub const __UINT8_FMTu__ = "hhu";
pub const __UINT8_FMTx__ = "hhx";
pub const __UINT8_FMTX__ = "hhX";
pub const __UINT8_C_SUFFIX__ = "";
pub const __UINT8_MAX__ = @as(c_int, 255);
pub const __INT8_MAX__ = @as(c_int, 127);
pub const __UINT16_TYPE__ = c_ushort;
pub const __UINT16_FMTo__ = "ho";
pub const __UINT16_FMTu__ = "hu";
pub const __UINT16_FMTx__ = "hx";
pub const __UINT16_FMTX__ = "hX";
pub const __UINT16_C_SUFFIX__ = "";
pub const __UINT16_MAX__ = @import("std").zig.c_translation.promoteIntLiteral(c_int, 65535, .decimal);
pub const __INT16_MAX__ = @as(c_int, 32767);
pub const __UINT32_TYPE__ = c_uint;
pub const __UINT32_FMTo__ = "o";
pub const __UINT32_FMTu__ = "u";
pub const __UINT32_FMTx__ = "x";
pub const __UINT32_FMTX__ = "X";
pub const __UINT32_C_SUFFIX__ = @compileError("unable to translate macro: undefined identifier `U`");
// (no file):221:9
pub const __UINT32_MAX__ = @import("std").zig.c_translation.promoteIntLiteral(c_uint, 4294967295, .decimal);
pub const __INT32_MAX__ = @import("std").zig.c_translation.promoteIntLiteral(c_int, 2147483647, .decimal);
pub const __UINT64_TYPE__ = c_ulonglong;
pub const __UINT64_FMTo__ = "llo";
pub const __UINT64_FMTu__ = "llu";
pub const __UINT64_FMTx__ = "llx";
pub const __UINT64_FMTX__ = "llX";
pub const __UINT64_C_SUFFIX__ = @compileError("unable to translate macro: undefined identifier `ULL`");
// (no file):229:9
pub const __UINT64_MAX__ = @as(c_ulonglong, 18446744073709551615);
pub const __INT64_MAX__ = @as(c_longlong, 9223372036854775807);
pub const __INT_LEAST8_TYPE__ = i8;
pub const __INT_LEAST8_MAX__ = @as(c_int, 127);
pub const __INT_LEAST8_WIDTH__ = @as(c_int, 8);
pub const __INT_LEAST8_FMTd__ = "hhd";
pub const __INT_LEAST8_FMTi__ = "hhi";
pub const __UINT_LEAST8_TYPE__ = u8;
pub const __UINT_LEAST8_MAX__ = @as(c_int, 255);
pub const __UINT_LEAST8_FMTo__ = "hho";
pub const __UINT_LEAST8_FMTu__ = "hhu";
pub const __UINT_LEAST8_FMTx__ = "hhx";
pub const __UINT_LEAST8_FMTX__ = "hhX";
pub const __INT_LEAST16_TYPE__ = c_short;
pub const __INT_LEAST16_MAX__ = @as(c_int, 32767);
pub const __INT_LEAST16_WIDTH__ = @as(c_int, 16);
pub const __INT_LEAST16_FMTd__ = "hd";
pub const __INT_LEAST16_FMTi__ = "hi";
pub const __UINT_LEAST16_TYPE__ = c_ushort;
pub const __UINT_LEAST16_MAX__ = @import("std").zig.c_translation.promoteIntLiteral(c_int, 65535, .decimal);
pub const __UINT_LEAST16_FMTo__ = "ho";
pub const __UINT_LEAST16_FMTu__ = "hu";
pub const __UINT_LEAST16_FMTx__ = "hx";
pub const __UINT_LEAST16_FMTX__ = "hX";
pub const __INT_LEAST32_TYPE__ = c_int;
pub const __INT_LEAST32_MAX__ = @import("std").zig.c_translation.promoteIntLiteral(c_int, 2147483647, .decimal);
pub const __INT_LEAST32_WIDTH__ = @as(c_int, 32);
pub const __INT_LEAST32_FMTd__ = "d";
pub const __INT_LEAST32_FMTi__ = "i";
pub const __UINT_LEAST32_TYPE__ = c_uint;
pub const __UINT_LEAST32_MAX__ = @import("std").zig.c_translation.promoteIntLiteral(c_uint, 4294967295, .decimal);
pub const __UINT_LEAST32_FMTo__ = "o";
pub const __UINT_LEAST32_FMTu__ = "u";
pub const __UINT_LEAST32_FMTx__ = "x";
pub const __UINT_LEAST32_FMTX__ = "X";
pub const __INT_LEAST64_TYPE__ = c_longlong;
pub const __INT_LEAST64_MAX__ = @as(c_longlong, 9223372036854775807);
pub const __INT_LEAST64_WIDTH__ = @as(c_int, 64);
pub const __INT_LEAST64_FMTd__ = "lld";
pub const __INT_LEAST64_FMTi__ = "lli";
pub const __UINT_LEAST64_TYPE__ = c_ulonglong;
pub const __UINT_LEAST64_MAX__ = @as(c_ulonglong, 18446744073709551615);
pub const __UINT_LEAST64_FMTo__ = "llo";
pub const __UINT_LEAST64_FMTu__ = "llu";
pub const __UINT_LEAST64_FMTx__ = "llx";
pub const __UINT_LEAST64_FMTX__ = "llX";
pub const __INT_FAST8_TYPE__ = i8;
pub const __INT_FAST8_MAX__ = @as(c_int, 127);
pub const __INT_FAST8_WIDTH__ = @as(c_int, 8);
pub const __INT_FAST8_FMTd__ = "hhd";
pub const __INT_FAST8_FMTi__ = "hhi";
pub const __UINT_FAST8_TYPE__ = u8;
pub const __UINT_FAST8_MAX__ = @as(c_int, 255);
pub const __UINT_FAST8_FMTo__ = "hho";
pub const __UINT_FAST8_FMTu__ = "hhu";
pub const __UINT_FAST8_FMTx__ = "hhx";
pub const __UINT_FAST8_FMTX__ = "hhX";
pub const __INT_FAST16_TYPE__ = c_short;
pub const __INT_FAST16_MAX__ = @as(c_int, 32767);
pub const __INT_FAST16_WIDTH__ = @as(c_int, 16);
pub const __INT_FAST16_FMTd__ = "hd";
pub const __INT_FAST16_FMTi__ = "hi";
pub const __UINT_FAST16_TYPE__ = c_ushort;
pub const __UINT_FAST16_MAX__ = @import("std").zig.c_translation.promoteIntLiteral(c_int, 65535, .decimal);
pub const __UINT_FAST16_FMTo__ = "ho";
pub const __UINT_FAST16_FMTu__ = "hu";
pub const __UINT_FAST16_FMTx__ = "hx";
pub const __UINT_FAST16_FMTX__ = "hX";
pub const __INT_FAST32_TYPE__ = c_int;
pub const __INT_FAST32_MAX__ = @import("std").zig.c_translation.promoteIntLiteral(c_int, 2147483647, .decimal);
pub const __INT_FAST32_WIDTH__ = @as(c_int, 32);
pub const __INT_FAST32_FMTd__ = "d";
pub const __INT_FAST32_FMTi__ = "i";
pub const __UINT_FAST32_TYPE__ = c_uint;
pub const __UINT_FAST32_MAX__ = @import("std").zig.c_translation.promoteIntLiteral(c_uint, 4294967295, .decimal);
pub const __UINT_FAST32_FMTo__ = "o";
pub const __UINT_FAST32_FMTu__ = "u";
pub const __UINT_FAST32_FMTx__ = "x";
pub const __UINT_FAST32_FMTX__ = "X";
pub const __INT_FAST64_TYPE__ = c_longlong;
pub const __INT_FAST64_MAX__ = @as(c_longlong, 9223372036854775807);
pub const __INT_FAST64_WIDTH__ = @as(c_int, 64);
pub const __INT_FAST64_FMTd__ = "lld";
pub const __INT_FAST64_FMTi__ = "lli";
pub const __UINT_FAST64_TYPE__ = c_ulonglong;
pub const __UINT_FAST64_MAX__ = @as(c_ulonglong, 18446744073709551615);
pub const __UINT_FAST64_FMTo__ = "llo";
pub const __UINT_FAST64_FMTu__ = "llu";
pub const __UINT_FAST64_FMTx__ = "llx";
pub const __UINT_FAST64_FMTX__ = "llX";
pub const __USER_LABEL_PREFIX__ = @compileError("unable to translate macro: undefined identifier `_`");
// (no file):320:9
pub const __NO_MATH_ERRNO__ = @as(c_int, 1);
pub const __FINITE_MATH_ONLY__ = @as(c_int, 0);
pub const __GNUC_STDC_INLINE__ = @as(c_int, 1);
pub const __GCC_ATOMIC_TEST_AND_SET_TRUEVAL = @as(c_int, 1);
pub const __CLANG_ATOMIC_BOOL_LOCK_FREE = @as(c_int, 2);
pub const __CLANG_ATOMIC_CHAR_LOCK_FREE = @as(c_int, 2);
pub const __CLANG_ATOMIC_CHAR16_T_LOCK_FREE = @as(c_int, 2);
pub const __CLANG_ATOMIC_CHAR32_T_LOCK_FREE = @as(c_int, 2);
pub const __CLANG_ATOMIC_WCHAR_T_LOCK_FREE = @as(c_int, 2);
pub const __CLANG_ATOMIC_SHORT_LOCK_FREE = @as(c_int, 2);
pub const __CLANG_ATOMIC_INT_LOCK_FREE = @as(c_int, 2);
pub const __CLANG_ATOMIC_LONG_LOCK_FREE = @as(c_int, 2);
pub const __CLANG_ATOMIC_LLONG_LOCK_FREE = @as(c_int, 2);
pub const __CLANG_ATOMIC_POINTER_LOCK_FREE = @as(c_int, 2);
pub const __GCC_ATOMIC_BOOL_LOCK_FREE = @as(c_int, 2);
pub const __GCC_ATOMIC_CHAR_LOCK_FREE = @as(c_int, 2);
pub const __GCC_ATOMIC_CHAR16_T_LOCK_FREE = @as(c_int, 2);
pub const __GCC_ATOMIC_CHAR32_T_LOCK_FREE = @as(c_int, 2);
pub const __GCC_ATOMIC_WCHAR_T_LOCK_FREE = @as(c_int, 2);
pub const __GCC_ATOMIC_SHORT_LOCK_FREE = @as(c_int, 2);
pub const __GCC_ATOMIC_INT_LOCK_FREE = @as(c_int, 2);
pub const __GCC_ATOMIC_LONG_LOCK_FREE = @as(c_int, 2);
pub const __GCC_ATOMIC_LLONG_LOCK_FREE = @as(c_int, 2);
pub const __GCC_ATOMIC_POINTER_LOCK_FREE = @as(c_int, 2);
pub const __NO_INLINE__ = @as(c_int, 1);
pub const __PIC__ = @as(c_int, 2);
pub const __pic__ = @as(c_int, 2);
pub const __FLT_RADIX__ = @as(c_int, 2);
pub const __DECIMAL_DIG__ = __LDBL_DECIMAL_DIG__;
pub const __SSP_STRONG__ = @as(c_int, 2);
pub const __nonnull = @compileError("unable to translate macro: undefined identifier `_Nonnull`");
// (no file):351:9
pub const __null_unspecified = @compileError("unable to translate macro: undefined identifier `_Null_unspecified`");
// (no file):352:9
pub const __nullable = @compileError("unable to translate macro: undefined identifier `_Nullable`");
// (no file):353:9
pub const TARGET_OS_WIN32 = @as(c_int, 0);
pub const TARGET_OS_WINDOWS = @as(c_int, 0);
pub const TARGET_OS_LINUX = @as(c_int, 0);
pub const TARGET_OS_UNIX = @as(c_int, 0);
pub const TARGET_OS_MAC = @as(c_int, 1);
pub const TARGET_OS_OSX = @as(c_int, 1);
pub const TARGET_OS_IPHONE = @as(c_int, 0);
pub const TARGET_OS_IOS = @as(c_int, 0);
pub const TARGET_OS_TV = @as(c_int, 0);
pub const TARGET_OS_WATCH = @as(c_int, 0);
pub const TARGET_OS_DRIVERKIT = @as(c_int, 0);
pub const TARGET_OS_MACCATALYST = @as(c_int, 0);
pub const TARGET_OS_SIMULATOR = @as(c_int, 0);
pub const TARGET_OS_EMBEDDED = @as(c_int, 0);
pub const TARGET_OS_NANO = @as(c_int, 0);
pub const TARGET_IPHONE_SIMULATOR = @as(c_int, 0);
pub const TARGET_OS_UIKITFORMAC = @as(c_int, 0);
pub const __AARCH64EL__ = @as(c_int, 1);
pub const __aarch64__ = @as(c_int, 1);
pub const __GCC_ASM_FLAG_OUTPUTS__ = @as(c_int, 1);
pub const __AARCH64_CMODEL_SMALL__ = @as(c_int, 1);
pub const __ARM_ACLE = @as(c_int, 200);
pub const __ARM_ARCH = @as(c_int, 8);
pub const __ARM_ARCH_PROFILE = 'A';
pub const __ARM_64BIT_STATE = @as(c_int, 1);
pub const __ARM_PCS_AAPCS64 = @as(c_int, 1);
pub const __ARM_ARCH_ISA_A64 = @as(c_int, 1);
pub const __ARM_FEATURE_CLZ = @as(c_int, 1);
pub const __ARM_FEATURE_FMA = @as(c_int, 1);
pub const __ARM_FEATURE_LDREX = @as(c_int, 0xF);
pub const __ARM_FEATURE_IDIV = @as(c_int, 1);
pub const __ARM_FEATURE_DIV = @as(c_int, 1);
pub const __ARM_FEATURE_NUMERIC_MAXMIN = @as(c_int, 1);
pub const __ARM_FEATURE_DIRECTED_ROUNDING = @as(c_int, 1);
pub const __ARM_ALIGN_MAX_STACK_PWR = @as(c_int, 4);
pub const __ARM_STATE_ZA = @as(c_int, 1);
pub const __ARM_STATE_ZT0 = @as(c_int, 1);
pub const __ARM_FP = @as(c_int, 0xE);
pub const __ARM_FP16_FORMAT_IEEE = @as(c_int, 1);
pub const __ARM_FP16_ARGS = @as(c_int, 1);
pub const __ARM_SIZEOF_WCHAR_T = @as(c_int, 4);
pub const __ARM_SIZEOF_MINIMAL_ENUM = @as(c_int, 4);
pub const __ARM_NEON = @as(c_int, 1);
pub const __ARM_NEON_FP = @as(c_int, 0xE);
pub const __ARM_FEATURE_UNALIGNED = @as(c_int, 1);
pub const __GCC_HAVE_SYNC_COMPARE_AND_SWAP_1 = @as(c_int, 1);
pub const __GCC_HAVE_SYNC_COMPARE_AND_SWAP_2 = @as(c_int, 1);
pub const __GCC_HAVE_SYNC_COMPARE_AND_SWAP_4 = @as(c_int, 1);
pub const __GCC_HAVE_SYNC_COMPARE_AND_SWAP_8 = @as(c_int, 1);
pub const __GCC_HAVE_SYNC_COMPARE_AND_SWAP_16 = @as(c_int, 1);
pub const __FP_FAST_FMA = @as(c_int, 1);
pub const __FP_FAST_FMAF = @as(c_int, 1);
pub const __AARCH64_SIMD__ = @as(c_int, 1);
pub const __ARM64_ARCH_8__ = @as(c_int, 1);
pub const __ARM_NEON__ = @as(c_int, 1);
pub const __REGISTER_PREFIX__ = "";
pub const __arm64 = @as(c_int, 1);
pub const __arm64__ = @as(c_int, 1);
pub const __APPLE_CC__ = @as(c_int, 6000);
pub const __APPLE__ = @as(c_int, 1);
pub const __STDC_NO_THREADS__ = @as(c_int, 1);
pub const __weak = @compileError("unable to translate macro: undefined identifier `objc_gc`");
// (no file):415:9
pub const __strong = "";
pub const __unsafe_unretained = "";
pub const __DYNAMIC__ = @as(c_int, 1);
pub const __ENVIRONMENT_MAC_OS_X_VERSION_MIN_REQUIRED__ = @import("std").zig.c_translation.promoteIntLiteral(c_int, 140401, .decimal);
pub const __ENVIRONMENT_OS_VERSION_MIN_REQUIRED__ = @import("std").zig.c_translation.promoteIntLiteral(c_int, 140401, .decimal);
pub const __MACH__ = @as(c_int, 1);
pub const __STDC__ = @as(c_int, 1);
pub const __STDC_HOSTED__ = @as(c_int, 1);
pub const __STDC_VERSION__ = @as(c_long, 201710);
pub const __STDC_UTF_16__ = @as(c_int, 1);
pub const __STDC_UTF_32__ = @as(c_int, 1);
pub const _DEBUG = @as(c_int, 1);
pub const __GCC_HAVE_DWARF2_CFI_ASM = @as(c_int, 1);
pub const Z_macros_language_H = "";
pub const Z_macros_casting_H = "";
pub const Z_CAST = "";
pub const Z_inspection_language_H = "";
pub const Z_keys_language_H = "";
pub const Z_LANGUAGE_C = @as(c_int, 1);
pub const Z_LANGUAGE_CPP = @as(c_int, 3);
pub const Z_LANGUAGE_OBJECTIVE_C = @as(c_int, 5);
pub const Z_LANGUAGE_OBJECTIVE_CPP = @as(c_int, 7);
pub const Z_LANGUAGE_STRING_C = "C";
pub const Z_LANGUAGE_STRING_CPP = "C++";
pub const Z_LANGUAGE_STRING_OBJECTIVE_C = "Objective-C";
pub const Z_LANGUAGE_STRING_OBJECTIVE_CPP = "Objective-C++";
pub const Z_inspection_C_H = "";
pub const Z_keys_C_H = "";
pub const Z_C78 = @as(c_int, 1);
pub const Z_C89 = @as(c_int, 2);
pub const Z_C90 = @as(c_int, 3);
pub const Z_C95 = @as(c_int, 4);
pub const Z_C99 = @as(c_int, 5);
pub const Z_C11 = @as(c_int, 6);
pub const Z_C17 = @as(c_int, 7);
pub const Z_C_NAME_C78 = "K&R C";
pub const Z_C_NAME_C89 = "ANSI X3.159-1989";
pub const Z_C_NAME_C90 = "ISO/IEC 9899:1990";
pub const Z_C_NAME_C95 = "ISO/IEC 9899:1990/AMD1:1995";
pub const Z_C_NAME_C99 = "ISO/IEC 9899:1999";
pub const Z_C_NAME_C11 = "ISO/IEC 9899:2011";
pub const Z_C_NAME_C17 = "ISO/IEC 9899:2018";
pub const Z_macros_token_H = "";
pub const Z_COMMA = @compileError("unable to translate C expr: unexpected token ','");
// /opt/homebrew/include/Z/macros/token.h:12:9
pub const Z_z_EMPTY = @compileError("unable to translate C expr: unexpected token ''");
// /opt/homebrew/include/Z/macros/token.h:14:9
pub const Z_EMPTY = @compileError("unable to translate C expr: unexpected token ')'");
// /opt/homebrew/include/Z/macros/token.h:15:9
pub inline fn Z_SAME(token: anytype) @TypeOf(token) {
    _ = &token;
    return token;
}
pub const Z_z_STRINGIFY = @compileError("unable to translate C expr: unexpected token '#'");
// /opt/homebrew/include/Z/macros/token.h:19:9
pub inline fn Z_STRINGIFY(token: anytype) @TypeOf(Z_z_STRINGIFY(token)) {
    _ = &token;
    return Z_z_STRINGIFY(token);
}
pub const Z_z_PREFIX_0 = @compileError("unable to translate C expr: unexpected token '##'");
// /opt/homebrew/include/Z/macros/token.h:22:9
pub const Z_z_PREFIX_0x = @compileError("invalid number suffix: 'x'");
// /opt/homebrew/include/Z/macros/token.h:23:9
pub const Z_z_PREFIX_0b = @compileError("invalid number suffix: 'b'");
// /opt/homebrew/include/Z/macros/token.h:24:9
pub const Z_z_PREFIX_Z = @compileError("unable to translate macro: undefined identifier `Z`");
// /opt/homebrew/include/Z/macros/token.h:25:9
pub const Z_z_PREFIX_Z_ = @compileError("unable to translate macro: undefined identifier `Z_`");
// /opt/homebrew/include/Z/macros/token.h:26:9
pub const Z_z_PREFIX_z = @compileError("unable to translate macro: undefined identifier `z`");
// /opt/homebrew/include/Z/macros/token.h:27:9
pub const Z_z_PREFIX_z_ = @compileError("unable to translate macro: undefined identifier `z_`");
// /opt/homebrew/include/Z/macros/token.h:28:9
pub const Z_z_SUFFIX_D32 = @compileError("unable to translate macro: undefined identifier `D32`");
// /opt/homebrew/include/Z/macros/token.h:29:9
pub const Z_z_SUFFIX_D64 = @compileError("unable to translate macro: undefined identifier `D64`");
// /opt/homebrew/include/Z/macros/token.h:30:9
pub const Z_z_SUFFIX_D64x = @compileError("unable to translate macro: undefined identifier `D64x`");
// /opt/homebrew/include/Z/macros/token.h:31:9
pub const Z_z_SUFFIX_D128 = @compileError("unable to translate macro: undefined identifier `D128`");
// /opt/homebrew/include/Z/macros/token.h:32:9
pub const Z_z_SUFFIX_D128x = @compileError("unable to translate macro: undefined identifier `D128x`");
// /opt/homebrew/include/Z/macros/token.h:33:9
pub const Z_z_SUFFIX_DD = @compileError("unable to translate macro: undefined identifier `DD`");
// /opt/homebrew/include/Z/macros/token.h:34:9
pub const Z_z_SUFFIX_DF = @compileError("unable to translate macro: undefined identifier `DF`");
// /opt/homebrew/include/Z/macros/token.h:35:9
pub const Z_z_SUFFIX_DL = @compileError("unable to translate macro: undefined identifier `DL`");
// /opt/homebrew/include/Z/macros/token.h:36:9
pub const Z_z_SUFFIX_F = @import("std").zig.c_translation.Macros.F_SUFFIX;
pub const Z_z_SUFFIX_F16 = @compileError("unable to translate macro: undefined identifier `F16`");
// /opt/homebrew/include/Z/macros/token.h:38:9
pub const Z_z_SUFFIX_F32 = @compileError("unable to translate macro: undefined identifier `F32`");
// /opt/homebrew/include/Z/macros/token.h:39:9
pub const Z_z_SUFFIX_F32x = @compileError("unable to translate macro: undefined identifier `F32x`");
// /opt/homebrew/include/Z/macros/token.h:40:9
pub const Z_z_SUFFIX_F64 = @compileError("unable to translate macro: undefined identifier `F64`");
// /opt/homebrew/include/Z/macros/token.h:41:9
pub const Z_z_SUFFIX_F64x = @compileError("unable to translate macro: undefined identifier `F64x`");
// /opt/homebrew/include/Z/macros/token.h:42:9
pub const Z_z_SUFFIX_F128 = @compileError("unable to translate macro: undefined identifier `F128`");
// /opt/homebrew/include/Z/macros/token.h:43:9
pub const Z_z_SUFFIX_F128x = @compileError("unable to translate macro: undefined identifier `F128x`");
// /opt/homebrew/include/Z/macros/token.h:44:9
pub const Z_z_SUFFIX_i32 = @compileError("unable to translate macro: undefined identifier `i32`");
// /opt/homebrew/include/Z/macros/token.h:45:9
pub const Z_z_SUFFIX_i64 = @compileError("unable to translate macro: undefined identifier `i64`");
// /opt/homebrew/include/Z/macros/token.h:46:9
pub const Z_z_SUFFIX_L = @import("std").zig.c_translation.Macros.L_SUFFIX;
pub const Z_z_SUFFIX_LL = @import("std").zig.c_translation.Macros.LL_SUFFIX;
pub const Z_z_SUFFIX_Q = @compileError("unable to translate macro: undefined identifier `Q`");
// /opt/homebrew/include/Z/macros/token.h:49:9
pub const Z_z_SUFFIX_U = @import("std").zig.c_translation.Macros.U_SUFFIX;
pub const Z_z_SUFFIX_Ui32 = @compileError("unable to translate macro: undefined identifier `Ui32`");
// /opt/homebrew/include/Z/macros/token.h:51:9
pub const Z_z_SUFFIX_Ui64 = @compileError("unable to translate macro: undefined identifier `Ui64`");
// /opt/homebrew/include/Z/macros/token.h:52:9
pub const Z_z_SUFFIX_UL = @import("std").zig.c_translation.Macros.UL_SUFFIX;
pub const Z_z_SUFFIX_ULL = @import("std").zig.c_translation.Macros.ULL_SUFFIX;
pub const Z_z_SUFFIX_UZ = @compileError("unable to translate macro: undefined identifier `UZ`");
// /opt/homebrew/include/Z/macros/token.h:55:9
pub const Z_z_SUFFIX_W = @compileError("unable to translate macro: undefined identifier `W`");
// /opt/homebrew/include/Z/macros/token.h:56:9
pub const Z_z_SUFFIX_Z = @compileError("unable to translate macro: undefined identifier `Z`");
// /opt/homebrew/include/Z/macros/token.h:57:9
pub const Z_PREFIX_ = Z_SAME;
pub inline fn Z_PREFIX_0(rht: anytype) @TypeOf(Z_z_PREFIX_0(rht)) {
    _ = &rht;
    return Z_z_PREFIX_0(rht);
}
pub inline fn Z_PREFIX_0x(rht: anytype) @TypeOf(Z_z_PREFIX_0x(rht)) {
    _ = &rht;
    return Z_z_PREFIX_0x(rht);
}
pub inline fn Z_PREFIX_0b(rht: anytype) @TypeOf(Z_z_PREFIX_0b(rht)) {
    _ = &rht;
    return Z_z_PREFIX_0b(rht);
}
pub inline fn Z_PREFIX_Z(rht: anytype) @TypeOf(Z_z_PREFIX_Z(rht)) {
    _ = &rht;
    return Z_z_PREFIX_Z(rht);
}
pub inline fn Z_PREFIX_Z_(rht: anytype) @TypeOf(Z_z_PREFIX_Z_(rht)) {
    _ = &rht;
    return Z_z_PREFIX_Z_(rht);
}
pub inline fn Z_PREFIX_z(rht: anytype) @TypeOf(Z_z_PREFIX_z(rht)) {
    _ = &rht;
    return Z_z_PREFIX_z(rht);
}
pub inline fn Z_PREFIX_z_(rht: anytype) @TypeOf(Z_z_PREFIX_z_(rht)) {
    _ = &rht;
    return Z_z_PREFIX_z_(rht);
}
pub const Z_SUFFIX_ = Z_SAME;
pub inline fn Z_SUFFIX_D32(lht: anytype) @TypeOf(Z_z_SUFFIX_D32(lht)) {
    _ = &lht;
    return Z_z_SUFFIX_D32(lht);
}
pub inline fn Z_SUFFIX_D64(lht: anytype) @TypeOf(Z_z_SUFFIX_D64(lht)) {
    _ = &lht;
    return Z_z_SUFFIX_D64(lht);
}
pub inline fn Z_SUFFIX_D64x(lht: anytype) @TypeOf(Z_z_SUFFIX_D64x(lht)) {
    _ = &lht;
    return Z_z_SUFFIX_D64x(lht);
}
pub inline fn Z_SUFFIX_D128(lht: anytype) @TypeOf(Z_z_SUFFIX_D128(lht)) {
    _ = &lht;
    return Z_z_SUFFIX_D128(lht);
}
pub inline fn Z_SUFFIX_D128x(lht: anytype) @TypeOf(Z_z_SUFFIX_D128x(lht)) {
    _ = &lht;
    return Z_z_SUFFIX_D128x(lht);
}
pub inline fn Z_SUFFIX_DD(lht: anytype) @TypeOf(Z_z_SUFFIX_DD(lht)) {
    _ = &lht;
    return Z_z_SUFFIX_DD(lht);
}
pub inline fn Z_SUFFIX_DF(lht: anytype) @TypeOf(Z_z_SUFFIX_DF(lht)) {
    _ = &lht;
    return Z_z_SUFFIX_DF(lht);
}
pub inline fn Z_SUFFIX_DL(lht: anytype) @TypeOf(Z_z_SUFFIX_DL(lht)) {
    _ = &lht;
    return Z_z_SUFFIX_DL(lht);
}
pub inline fn Z_SUFFIX_F(lht: anytype) @TypeOf(Z_z_SUFFIX_F(lht)) {
    _ = &lht;
    return Z_z_SUFFIX_F(lht);
}
pub inline fn Z_SUFFIX_F16(lht: anytype) @TypeOf(Z_z_SUFFIX_F16(lht)) {
    _ = &lht;
    return Z_z_SUFFIX_F16(lht);
}
pub inline fn Z_SUFFIX_F32(lht: anytype) @TypeOf(Z_z_SUFFIX_F32(lht)) {
    _ = &lht;
    return Z_z_SUFFIX_F32(lht);
}
pub inline fn Z_SUFFIX_F32x(lht: anytype) @TypeOf(Z_z_SUFFIX_F32x(lht)) {
    _ = &lht;
    return Z_z_SUFFIX_F32x(lht);
}
pub inline fn Z_SUFFIX_F64(lht: anytype) @TypeOf(Z_z_SUFFIX_F64(lht)) {
    _ = &lht;
    return Z_z_SUFFIX_F64(lht);
}
pub inline fn Z_SUFFIX_F64x(lht: anytype) @TypeOf(Z_z_SUFFIX_F64x(lht)) {
    _ = &lht;
    return Z_z_SUFFIX_F64x(lht);
}
pub inline fn Z_SUFFIX_F128(lht: anytype) @TypeOf(Z_z_SUFFIX_F128(lht)) {
    _ = &lht;
    return Z_z_SUFFIX_F128(lht);
}
pub inline fn Z_SUFFIX_F128x(lht: anytype) @TypeOf(Z_z_SUFFIX_F128x(lht)) {
    _ = &lht;
    return Z_z_SUFFIX_F128x(lht);
}
pub inline fn Z_SUFFIX_i32(lht: anytype) @TypeOf(Z_z_SUFFIX_i32(lht)) {
    _ = &lht;
    return Z_z_SUFFIX_i32(lht);
}
pub inline fn Z_SUFFIX_i64(lht: anytype) @TypeOf(Z_z_SUFFIX_i64(lht)) {
    _ = &lht;
    return Z_z_SUFFIX_i64(lht);
}
pub inline fn Z_SUFFIX_L(lht: anytype) @TypeOf(Z_z_SUFFIX_L(lht)) {
    _ = &lht;
    return Z_z_SUFFIX_L(lht);
}
pub inline fn Z_SUFFIX_LL(lht: anytype) @TypeOf(Z_z_SUFFIX_LL(lht)) {
    _ = &lht;
    return Z_z_SUFFIX_LL(lht);
}
pub inline fn Z_SUFFIX_Q(lht: anytype) @TypeOf(Z_z_SUFFIX_Q(lht)) {
    _ = &lht;
    return Z_z_SUFFIX_Q(lht);
}
pub inline fn Z_SUFFIX_U(lht: anytype) @TypeOf(Z_z_SUFFIX_U(lht)) {
    _ = &lht;
    return Z_z_SUFFIX_U(lht);
}
pub inline fn Z_SUFFIX_Ui32(lht: anytype) @TypeOf(Z_z_SUFFIX_Ui32(lht)) {
    _ = &lht;
    return Z_z_SUFFIX_Ui32(lht);
}
pub inline fn Z_SUFFIX_Ui64(lht: anytype) @TypeOf(Z_z_SUFFIX_Ui64(lht)) {
    _ = &lht;
    return Z_z_SUFFIX_Ui64(lht);
}
pub inline fn Z_SUFFIX_UL(lht: anytype) @TypeOf(Z_z_SUFFIX_UL(lht)) {
    _ = &lht;
    return Z_z_SUFFIX_UL(lht);
}
pub inline fn Z_SUFFIX_ULL(lht: anytype) @TypeOf(Z_z_SUFFIX_ULL(lht)) {
    _ = &lht;
    return Z_z_SUFFIX_ULL(lht);
}
pub inline fn Z_SUFFIX_UZ(lht: anytype) @TypeOf(Z_z_SUFFIX_UZ(lht)) {
    _ = &lht;
    return Z_z_SUFFIX_UZ(lht);
}
pub inline fn Z_SUFFIX_W(lht: anytype) @TypeOf(Z_z_SUFFIX_W(lht)) {
    _ = &lht;
    return Z_z_SUFFIX_W(lht);
}
pub inline fn Z_SUFFIX_Z(lht: anytype) @TypeOf(Z_z_SUFFIX_Z(lht)) {
    _ = &lht;
    return Z_z_SUFFIX_Z(lht);
}
pub const Z_PASTE_2 = @compileError("unable to translate C expr: unexpected token '##'");
// /opt/homebrew/include/Z/macros/token.h:98:9
pub const Z_PASTE_3 = @compileError("unable to translate C expr: unexpected token '##'");
// /opt/homebrew/include/Z/macros/token.h:99:9
pub const Z_PASTE_4 = @compileError("unable to translate C expr: unexpected token '##'");
// /opt/homebrew/include/Z/macros/token.h:100:9
pub const Z_PASTE_5 = @compileError("unable to translate C expr: unexpected token '##'");
// /opt/homebrew/include/Z/macros/token.h:101:9
pub const Z_PASTE_6 = @compileError("unable to translate C expr: unexpected token '##'");
// /opt/homebrew/include/Z/macros/token.h:102:9
pub const Z_PASTE_7 = @compileError("unable to translate C expr: unexpected token '##'");
// /opt/homebrew/include/Z/macros/token.h:103:9
pub const Z_PASTE_8 = @compileError("unable to translate C expr: unexpected token '##'");
// /opt/homebrew/include/Z/macros/token.h:104:9
pub const Z_PASTE_9 = @compileError("unable to translate C expr: unexpected token '##'");
// /opt/homebrew/include/Z/macros/token.h:105:9
pub const Z_PASTE_10 = @compileError("unable to translate C expr: unexpected token '##'");
// /opt/homebrew/include/Z/macros/token.h:106:9
pub const Z_PASTE_11 = @compileError("unable to translate C expr: unexpected token '##'");
// /opt/homebrew/include/Z/macros/token.h:107:9
pub const Z_PASTE_12 = @compileError("unable to translate C expr: unexpected token '##'");
// /opt/homebrew/include/Z/macros/token.h:108:9
pub const Z_PASTE_13 = @compileError("unable to translate C expr: unexpected token '##'");
// /opt/homebrew/include/Z/macros/token.h:109:9
pub const Z_PASTE_14 = @compileError("unable to translate C expr: unexpected token '##'");
// /opt/homebrew/include/Z/macros/token.h:110:9
pub const Z_PASTE_15 = @compileError("unable to translate C expr: unexpected token '##'");
// /opt/homebrew/include/Z/macros/token.h:111:9
pub const Z_PASTE_16 = @compileError("unable to translate C expr: unexpected token '##'");
// /opt/homebrew/include/Z/macros/token.h:112:9
pub const Z_PASTE_17 = @compileError("unable to translate C expr: unexpected token '##'");
// /opt/homebrew/include/Z/macros/token.h:113:9
pub const Z_PASTE_18 = @compileError("unable to translate C expr: unexpected token '##'");
// /opt/homebrew/include/Z/macros/token.h:114:9
pub const Z_PASTE_19 = @compileError("unable to translate C expr: unexpected token '##'");
// /opt/homebrew/include/Z/macros/token.h:115:9
pub const Z_PASTE_20 = @compileError("unable to translate C expr: unexpected token '##'");
// /opt/homebrew/include/Z/macros/token.h:116:9
pub const Z_PASTE_21 = @compileError("unable to translate C expr: unexpected token '##'");
// /opt/homebrew/include/Z/macros/token.h:117:9
pub const Z_PASTE_22 = @compileError("unable to translate C expr: unexpected token '##'");
// /opt/homebrew/include/Z/macros/token.h:118:9
pub const Z_PASTE_23 = @compileError("unable to translate C expr: unexpected token '##'");
// /opt/homebrew/include/Z/macros/token.h:119:9
pub const Z_PASTE_24 = @compileError("unable to translate C expr: unexpected token '##'");
// /opt/homebrew/include/Z/macros/token.h:120:9
pub const Z_PASTE_25 = @compileError("unable to translate C expr: unexpected token '##'");
// /opt/homebrew/include/Z/macros/token.h:121:9
pub const Z_PASTE_26 = @compileError("unable to translate C expr: unexpected token '##'");
// /opt/homebrew/include/Z/macros/token.h:122:9
pub const Z_PASTE_27 = @compileError("unable to translate C expr: unexpected token '##'");
// /opt/homebrew/include/Z/macros/token.h:123:9
pub const Z_PASTE_28 = @compileError("unable to translate C expr: unexpected token '##'");
// /opt/homebrew/include/Z/macros/token.h:124:9
pub const Z_PASTE_29 = @compileError("unable to translate C expr: unexpected token '##'");
// /opt/homebrew/include/Z/macros/token.h:125:9
pub const Z_PASTE_30 = @compileError("unable to translate C expr: unexpected token '##'");
// /opt/homebrew/include/Z/macros/token.h:126:9
pub const Z_PASTE_31 = @compileError("unable to translate C expr: unexpected token '##'");
// /opt/homebrew/include/Z/macros/token.h:127:9
pub const Z_PASTE_32 = @compileError("unable to translate C expr: unexpected token '##'");
// /opt/homebrew/include/Z/macros/token.h:128:9
pub inline fn Z_JOIN_2(_1: anytype, _2: anytype) @TypeOf(Z_PASTE_2(_1, _2)) {
    _ = &_1;
    _ = &_2;
    return Z_PASTE_2(_1, _2);
}
pub inline fn Z_JOIN_3(_1: anytype, _2: anytype, _3: anytype) @TypeOf(Z_PASTE_3(_1, _2, _3)) {
    _ = &_1;
    _ = &_2;
    _ = &_3;
    return Z_PASTE_3(_1, _2, _3);
}
pub inline fn Z_JOIN_4(_1: anytype, _2: anytype, _3: anytype, _4: anytype) @TypeOf(Z_PASTE_4(_1, _2, _3, _4)) {
    _ = &_1;
    _ = &_2;
    _ = &_3;
    _ = &_4;
    return Z_PASTE_4(_1, _2, _3, _4);
}
pub inline fn Z_JOIN_5(_1: anytype, _2: anytype, _3: anytype, _4: anytype, _5: anytype) @TypeOf(Z_PASTE_5(_1, _2, _3, _4, _5)) {
    _ = &_1;
    _ = &_2;
    _ = &_3;
    _ = &_4;
    _ = &_5;
    return Z_PASTE_5(_1, _2, _3, _4, _5);
}
pub inline fn Z_JOIN_6(_1: anytype, _2: anytype, _3: anytype, _4: anytype, _5: anytype, _6: anytype) @TypeOf(Z_PASTE_6(_1, _2, _3, _4, _5, _6)) {
    _ = &_1;
    _ = &_2;
    _ = &_3;
    _ = &_4;
    _ = &_5;
    _ = &_6;
    return Z_PASTE_6(_1, _2, _3, _4, _5, _6);
}
pub inline fn Z_JOIN_7(_1: anytype, _2: anytype, _3: anytype, _4: anytype, _5: anytype, _6: anytype, _7: anytype) @TypeOf(Z_PASTE_7(_1, _2, _3, _4, _5, _6, _7)) {
    _ = &_1;
    _ = &_2;
    _ = &_3;
    _ = &_4;
    _ = &_5;
    _ = &_6;
    _ = &_7;
    return Z_PASTE_7(_1, _2, _3, _4, _5, _6, _7);
}
pub inline fn Z_JOIN_8(_1: anytype, _2: anytype, _3: anytype, _4: anytype, _5: anytype, _6: anytype, _7: anytype, _8: anytype) @TypeOf(Z_PASTE_8(_1, _2, _3, _4, _5, _6, _7, _8)) {
    _ = &_1;
    _ = &_2;
    _ = &_3;
    _ = &_4;
    _ = &_5;
    _ = &_6;
    _ = &_7;
    _ = &_8;
    return Z_PASTE_8(_1, _2, _3, _4, _5, _6, _7, _8);
}
pub inline fn Z_JOIN_9(_1: anytype, _2: anytype, _3: anytype, _4: anytype, _5: anytype, _6: anytype, _7: anytype, _8: anytype, _9: anytype) @TypeOf(Z_PASTE_9(_1, _2, _3, _4, _5, _6, _7, _8, _9)) {
    _ = &_1;
    _ = &_2;
    _ = &_3;
    _ = &_4;
    _ = &_5;
    _ = &_6;
    _ = &_7;
    _ = &_8;
    _ = &_9;
    return Z_PASTE_9(_1, _2, _3, _4, _5, _6, _7, _8, _9);
}
pub inline fn Z_JOIN_10(_1: anytype, _2: anytype, _3: anytype, _4: anytype, _5: anytype, _6: anytype, _7: anytype, _8: anytype, _9: anytype, _10: anytype) @TypeOf(Z_PASTE_10(_1, _2, _3, _4, _5, _6, _7, _8, _9, _10)) {
    _ = &_1;
    _ = &_2;
    _ = &_3;
    _ = &_4;
    _ = &_5;
    _ = &_6;
    _ = &_7;
    _ = &_8;
    _ = &_9;
    _ = &_10;
    return Z_PASTE_10(_1, _2, _3, _4, _5, _6, _7, _8, _9, _10);
}
pub inline fn Z_JOIN_11(_1: anytype, _2: anytype, _3: anytype, _4: anytype, _5: anytype, _6: anytype, _7: anytype, _8: anytype, _9: anytype, _10: anytype, _11: anytype) @TypeOf(Z_PASTE_11(_1, _2, _3, _4, _5, _6, _7, _8, _9, _10, _11)) {
    _ = &_1;
    _ = &_2;
    _ = &_3;
    _ = &_4;
    _ = &_5;
    _ = &_6;
    _ = &_7;
    _ = &_8;
    _ = &_9;
    _ = &_10;
    _ = &_11;
    return Z_PASTE_11(_1, _2, _3, _4, _5, _6, _7, _8, _9, _10, _11);
}
pub inline fn Z_JOIN_12(_1: anytype, _2: anytype, _3: anytype, _4: anytype, _5: anytype, _6: anytype, _7: anytype, _8: anytype, _9: anytype, _10: anytype, _11: anytype, _12: anytype) @TypeOf(Z_PASTE_12(_1, _2, _3, _4, _5, _6, _7, _8, _9, _10, _11, _12)) {
    _ = &_1;
    _ = &_2;
    _ = &_3;
    _ = &_4;
    _ = &_5;
    _ = &_6;
    _ = &_7;
    _ = &_8;
    _ = &_9;
    _ = &_10;
    _ = &_11;
    _ = &_12;
    return Z_PASTE_12(_1, _2, _3, _4, _5, _6, _7, _8, _9, _10, _11, _12);
}
pub inline fn Z_JOIN_13(_1: anytype, _2: anytype, _3: anytype, _4: anytype, _5: anytype, _6: anytype, _7: anytype, _8: anytype, _9: anytype, _10: anytype, _11: anytype, _12: anytype, _13: anytype) @TypeOf(Z_PASTE_13(_1, _2, _3, _4, _5, _6, _7, _8, _9, _10, _11, _12, _13)) {
    _ = &_1;
    _ = &_2;
    _ = &_3;
    _ = &_4;
    _ = &_5;
    _ = &_6;
    _ = &_7;
    _ = &_8;
    _ = &_9;
    _ = &_10;
    _ = &_11;
    _ = &_12;
    _ = &_13;
    return Z_PASTE_13(_1, _2, _3, _4, _5, _6, _7, _8, _9, _10, _11, _12, _13);
}
pub inline fn Z_JOIN_14(_1: anytype, _2: anytype, _3: anytype, _4: anytype, _5: anytype, _6: anytype, _7: anytype, _8: anytype, _9: anytype, _10: anytype, _11: anytype, _12: anytype, _13: anytype, _14: anytype) @TypeOf(Z_PASTE_14(_1, _2, _3, _4, _5, _6, _7, _8, _9, _10, _11, _12, _13, _14)) {
    _ = &_1;
    _ = &_2;
    _ = &_3;
    _ = &_4;
    _ = &_5;
    _ = &_6;
    _ = &_7;
    _ = &_8;
    _ = &_9;
    _ = &_10;
    _ = &_11;
    _ = &_12;
    _ = &_13;
    _ = &_14;
    return Z_PASTE_14(_1, _2, _3, _4, _5, _6, _7, _8, _9, _10, _11, _12, _13, _14);
}
pub inline fn Z_JOIN_15(_1: anytype, _2: anytype, _3: anytype, _4: anytype, _5: anytype, _6: anytype, _7: anytype, _8: anytype, _9: anytype, _10: anytype, _11: anytype, _12: anytype, _13: anytype, _14: anytype, _15: anytype) @TypeOf(Z_PASTE_15(_1, _2, _3, _4, _5, _6, _7, _8, _9, _10, _11, _12, _13, _14, _15)) {
    _ = &_1;
    _ = &_2;
    _ = &_3;
    _ = &_4;
    _ = &_5;
    _ = &_6;
    _ = &_7;
    _ = &_8;
    _ = &_9;
    _ = &_10;
    _ = &_11;
    _ = &_12;
    _ = &_13;
    _ = &_14;
    _ = &_15;
    return Z_PASTE_15(_1, _2, _3, _4, _5, _6, _7, _8, _9, _10, _11, _12, _13, _14, _15);
}
pub inline fn Z_JOIN_16(_1: anytype, _2: anytype, _3: anytype, _4: anytype, _5: anytype, _6: anytype, _7: anytype, _8: anytype, _9: anytype, _10: anytype, _11: anytype, _12: anytype, _13: anytype, _14: anytype, _15: anytype, _16: anytype) @TypeOf(Z_PASTE_16(_1, _2, _3, _4, _5, _6, _7, _8, _9, _10, _11, _12, _13, _14, _15, _16)) {
    _ = &_1;
    _ = &_2;
    _ = &_3;
    _ = &_4;
    _ = &_5;
    _ = &_6;
    _ = &_7;
    _ = &_8;
    _ = &_9;
    _ = &_10;
    _ = &_11;
    _ = &_12;
    _ = &_13;
    _ = &_14;
    _ = &_15;
    _ = &_16;
    return Z_PASTE_16(_1, _2, _3, _4, _5, _6, _7, _8, _9, _10, _11, _12, _13, _14, _15, _16);
}
pub inline fn Z_JOIN_17(_1: anytype, _2: anytype, _3: anytype, _4: anytype, _5: anytype, _6: anytype, _7: anytype, _8: anytype, _9: anytype, _10: anytype, _11: anytype, _12: anytype, _13: anytype, _14: anytype, _15: anytype, _16: anytype, _17: anytype) @TypeOf(Z_PASTE_17(_1, _2, _3, _4, _5, _6, _7, _8, _9, _10, _11, _12, _13, _14, _15, _16, _17)) {
    _ = &_1;
    _ = &_2;
    _ = &_3;
    _ = &_4;
    _ = &_5;
    _ = &_6;
    _ = &_7;
    _ = &_8;
    _ = &_9;
    _ = &_10;
    _ = &_11;
    _ = &_12;
    _ = &_13;
    _ = &_14;
    _ = &_15;
    _ = &_16;
    _ = &_17;
    return Z_PASTE_17(_1, _2, _3, _4, _5, _6, _7, _8, _9, _10, _11, _12, _13, _14, _15, _16, _17);
}
pub inline fn Z_JOIN_18(_1: anytype, _2: anytype, _3: anytype, _4: anytype, _5: anytype, _6: anytype, _7: anytype, _8: anytype, _9: anytype, _10: anytype, _11: anytype, _12: anytype, _13: anytype, _14: anytype, _15: anytype, _16: anytype, _17: anytype, _18: anytype) @TypeOf(Z_PASTE_18(_1, _2, _3, _4, _5, _6, _7, _8, _9, _10, _11, _12, _13, _14, _15, _16, _17, _18)) {
    _ = &_1;
    _ = &_2;
    _ = &_3;
    _ = &_4;
    _ = &_5;
    _ = &_6;
    _ = &_7;
    _ = &_8;
    _ = &_9;
    _ = &_10;
    _ = &_11;
    _ = &_12;
    _ = &_13;
    _ = &_14;
    _ = &_15;
    _ = &_16;
    _ = &_17;
    _ = &_18;
    return Z_PASTE_18(_1, _2, _3, _4, _5, _6, _7, _8, _9, _10, _11, _12, _13, _14, _15, _16, _17, _18);
}
pub inline fn Z_JOIN_19(_1: anytype, _2: anytype, _3: anytype, _4: anytype, _5: anytype, _6: anytype, _7: anytype, _8: anytype, _9: anytype, _10: anytype, _11: anytype, _12: anytype, _13: anytype, _14: anytype, _15: anytype, _16: anytype, _17: anytype, _18: anytype, _19: anytype) @TypeOf(Z_PASTE_19(_1, _2, _3, _4, _5, _6, _7, _8, _9, _10, _11, _12, _13, _14, _15, _16, _17, _18, _19)) {
    _ = &_1;
    _ = &_2;
    _ = &_3;
    _ = &_4;
    _ = &_5;
    _ = &_6;
    _ = &_7;
    _ = &_8;
    _ = &_9;
    _ = &_10;
    _ = &_11;
    _ = &_12;
    _ = &_13;
    _ = &_14;
    _ = &_15;
    _ = &_16;
    _ = &_17;
    _ = &_18;
    _ = &_19;
    return Z_PASTE_19(_1, _2, _3, _4, _5, _6, _7, _8, _9, _10, _11, _12, _13, _14, _15, _16, _17, _18, _19);
}
pub inline fn Z_JOIN_20(_1: anytype, _2: anytype, _3: anytype, _4: anytype, _5: anytype, _6: anytype, _7: anytype, _8: anytype, _9: anytype, _10: anytype, _11: anytype, _12: anytype, _13: anytype, _14: anytype, _15: anytype, _16: anytype, _17: anytype, _18: anytype, _19: anytype, _20: anytype) @TypeOf(Z_PASTE_20(_1, _2, _3, _4, _5, _6, _7, _8, _9, _10, _11, _12, _13, _14, _15, _16, _17, _18, _19, _20)) {
    _ = &_1;
    _ = &_2;
    _ = &_3;
    _ = &_4;
    _ = &_5;
    _ = &_6;
    _ = &_7;
    _ = &_8;
    _ = &_9;
    _ = &_10;
    _ = &_11;
    _ = &_12;
    _ = &_13;
    _ = &_14;
    _ = &_15;
    _ = &_16;
    _ = &_17;
    _ = &_18;
    _ = &_19;
    _ = &_20;
    return Z_PASTE_20(_1, _2, _3, _4, _5, _6, _7, _8, _9, _10, _11, _12, _13, _14, _15, _16, _17, _18, _19, _20);
}
pub inline fn Z_JOIN_21(_1: anytype, _2: anytype, _3: anytype, _4: anytype, _5: anytype, _6: anytype, _7: anytype, _8: anytype, _9: anytype, _10: anytype, _11: anytype, _12: anytype, _13: anytype, _14: anytype, _15: anytype, _16: anytype, _17: anytype, _18: anytype, _19: anytype, _20: anytype, _21: anytype) @TypeOf(Z_PASTE_21(_1, _2, _3, _4, _5, _6, _7, _8, _9, _10, _11, _12, _13, _14, _15, _16, _17, _18, _19, _20, _21)) {
    _ = &_1;
    _ = &_2;
    _ = &_3;
    _ = &_4;
    _ = &_5;
    _ = &_6;
    _ = &_7;
    _ = &_8;
    _ = &_9;
    _ = &_10;
    _ = &_11;
    _ = &_12;
    _ = &_13;
    _ = &_14;
    _ = &_15;
    _ = &_16;
    _ = &_17;
    _ = &_18;
    _ = &_19;
    _ = &_20;
    _ = &_21;
    return Z_PASTE_21(_1, _2, _3, _4, _5, _6, _7, _8, _9, _10, _11, _12, _13, _14, _15, _16, _17, _18, _19, _20, _21);
}
pub inline fn Z_JOIN_22(_1: anytype, _2: anytype, _3: anytype, _4: anytype, _5: anytype, _6: anytype, _7: anytype, _8: anytype, _9: anytype, _10: anytype, _11: anytype, _12: anytype, _13: anytype, _14: anytype, _15: anytype, _16: anytype, _17: anytype, _18: anytype, _19: anytype, _20: anytype, _21: anytype, _22: anytype) @TypeOf(Z_PASTE_22(_1, _2, _3, _4, _5, _6, _7, _8, _9, _10, _11, _12, _13, _14, _15, _16, _17, _18, _19, _20, _21, _22)) {
    _ = &_1;
    _ = &_2;
    _ = &_3;
    _ = &_4;
    _ = &_5;
    _ = &_6;
    _ = &_7;
    _ = &_8;
    _ = &_9;
    _ = &_10;
    _ = &_11;
    _ = &_12;
    _ = &_13;
    _ = &_14;
    _ = &_15;
    _ = &_16;
    _ = &_17;
    _ = &_18;
    _ = &_19;
    _ = &_20;
    _ = &_21;
    _ = &_22;
    return Z_PASTE_22(_1, _2, _3, _4, _5, _6, _7, _8, _9, _10, _11, _12, _13, _14, _15, _16, _17, _18, _19, _20, _21, _22);
}
pub inline fn Z_JOIN_23(_1: anytype, _2: anytype, _3: anytype, _4: anytype, _5: anytype, _6: anytype, _7: anytype, _8: anytype, _9: anytype, _10: anytype, _11: anytype, _12: anytype, _13: anytype, _14: anytype, _15: anytype, _16: anytype, _17: anytype, _18: anytype, _19: anytype, _20: anytype, _21: anytype, _22: anytype, _23: anytype) @TypeOf(Z_PASTE_23(_1, _2, _3, _4, _5, _6, _7, _8, _9, _10, _11, _12, _13, _14, _15, _16, _17, _18, _19, _20, _21, _22, _23)) {
    _ = &_1;
    _ = &_2;
    _ = &_3;
    _ = &_4;
    _ = &_5;
    _ = &_6;
    _ = &_7;
    _ = &_8;
    _ = &_9;
    _ = &_10;
    _ = &_11;
    _ = &_12;
    _ = &_13;
    _ = &_14;
    _ = &_15;
    _ = &_16;
    _ = &_17;
    _ = &_18;
    _ = &_19;
    _ = &_20;
    _ = &_21;
    _ = &_22;
    _ = &_23;
    return Z_PASTE_23(_1, _2, _3, _4, _5, _6, _7, _8, _9, _10, _11, _12, _13, _14, _15, _16, _17, _18, _19, _20, _21, _22, _23);
}
pub inline fn Z_JOIN_24(_1: anytype, _2: anytype, _3: anytype, _4: anytype, _5: anytype, _6: anytype, _7: anytype, _8: anytype, _9: anytype, _10: anytype, _11: anytype, _12: anytype, _13: anytype, _14: anytype, _15: anytype, _16: anytype, _17: anytype, _18: anytype, _19: anytype, _20: anytype, _21: anytype, _22: anytype, _23: anytype, _24: anytype) @TypeOf(Z_PASTE_24(_1, _2, _3, _4, _5, _6, _7, _8, _9, _10, _11, _12, _13, _14, _15, _16, _17, _18, _19, _20, _21, _22, _23, _24)) {
    _ = &_1;
    _ = &_2;
    _ = &_3;
    _ = &_4;
    _ = &_5;
    _ = &_6;
    _ = &_7;
    _ = &_8;
    _ = &_9;
    _ = &_10;
    _ = &_11;
    _ = &_12;
    _ = &_13;
    _ = &_14;
    _ = &_15;
    _ = &_16;
    _ = &_17;
    _ = &_18;
    _ = &_19;
    _ = &_20;
    _ = &_21;
    _ = &_22;
    _ = &_23;
    _ = &_24;
    return Z_PASTE_24(_1, _2, _3, _4, _5, _6, _7, _8, _9, _10, _11, _12, _13, _14, _15, _16, _17, _18, _19, _20, _21, _22, _23, _24);
}
pub inline fn Z_JOIN_25(_1: anytype, _2: anytype, _3: anytype, _4: anytype, _5: anytype, _6: anytype, _7: anytype, _8: anytype, _9: anytype, _10: anytype, _11: anytype, _12: anytype, _13: anytype, _14: anytype, _15: anytype, _16: anytype, _17: anytype, _18: anytype, _19: anytype, _20: anytype, _21: anytype, _22: anytype, _23: anytype, _24: anytype, _25: anytype) @TypeOf(Z_PASTE_25(_1, _2, _3, _4, _5, _6, _7, _8, _9, _10, _11, _12, _13, _14, _15, _16, _17, _18, _19, _20, _21, _22, _23, _24, _25)) {
    _ = &_1;
    _ = &_2;
    _ = &_3;
    _ = &_4;
    _ = &_5;
    _ = &_6;
    _ = &_7;
    _ = &_8;
    _ = &_9;
    _ = &_10;
    _ = &_11;
    _ = &_12;
    _ = &_13;
    _ = &_14;
    _ = &_15;
    _ = &_16;
    _ = &_17;
    _ = &_18;
    _ = &_19;
    _ = &_20;
    _ = &_21;
    _ = &_22;
    _ = &_23;
    _ = &_24;
    _ = &_25;
    return Z_PASTE_25(_1, _2, _3, _4, _5, _6, _7, _8, _9, _10, _11, _12, _13, _14, _15, _16, _17, _18, _19, _20, _21, _22, _23, _24, _25);
}
pub inline fn Z_JOIN_26(_1: anytype, _2: anytype, _3: anytype, _4: anytype, _5: anytype, _6: anytype, _7: anytype, _8: anytype, _9: anytype, _10: anytype, _11: anytype, _12: anytype, _13: anytype, _14: anytype, _15: anytype, _16: anytype, _17: anytype, _18: anytype, _19: anytype, _20: anytype, _21: anytype, _22: anytype, _23: anytype, _24: anytype, _25: anytype, _26: anytype) @TypeOf(Z_PASTE_26(_1, _2, _3, _4, _5, _6, _7, _8, _9, _10, _11, _12, _13, _14, _15, _16, _17, _18, _19, _20, _21, _22, _23, _24, _25, _26)) {
    _ = &_1;
    _ = &_2;
    _ = &_3;
    _ = &_4;
    _ = &_5;
    _ = &_6;
    _ = &_7;
    _ = &_8;
    _ = &_9;
    _ = &_10;
    _ = &_11;
    _ = &_12;
    _ = &_13;
    _ = &_14;
    _ = &_15;
    _ = &_16;
    _ = &_17;
    _ = &_18;
    _ = &_19;
    _ = &_20;
    _ = &_21;
    _ = &_22;
    _ = &_23;
    _ = &_24;
    _ = &_25;
    _ = &_26;
    return Z_PASTE_26(_1, _2, _3, _4, _5, _6, _7, _8, _9, _10, _11, _12, _13, _14, _15, _16, _17, _18, _19, _20, _21, _22, _23, _24, _25, _26);
}
pub inline fn Z_JOIN_27(_1: anytype, _2: anytype, _3: anytype, _4: anytype, _5: anytype, _6: anytype, _7: anytype, _8: anytype, _9: anytype, _10: anytype, _11: anytype, _12: anytype, _13: anytype, _14: anytype, _15: anytype, _16: anytype, _17: anytype, _18: anytype, _19: anytype, _20: anytype, _21: anytype, _22: anytype, _23: anytype, _24: anytype, _25: anytype, _26: anytype, _27: anytype) @TypeOf(Z_PASTE_27(_1, _2, _3, _4, _5, _6, _7, _8, _9, _10, _11, _12, _13, _14, _15, _16, _17, _18, _19, _20, _21, _22, _23, _24, _25, _26, _27)) {
    _ = &_1;
    _ = &_2;
    _ = &_3;
    _ = &_4;
    _ = &_5;
    _ = &_6;
    _ = &_7;
    _ = &_8;
    _ = &_9;
    _ = &_10;
    _ = &_11;
    _ = &_12;
    _ = &_13;
    _ = &_14;
    _ = &_15;
    _ = &_16;
    _ = &_17;
    _ = &_18;
    _ = &_19;
    _ = &_20;
    _ = &_21;
    _ = &_22;
    _ = &_23;
    _ = &_24;
    _ = &_25;
    _ = &_26;
    _ = &_27;
    return Z_PASTE_27(_1, _2, _3, _4, _5, _6, _7, _8, _9, _10, _11, _12, _13, _14, _15, _16, _17, _18, _19, _20, _21, _22, _23, _24, _25, _26, _27);
}
pub inline fn Z_JOIN_28(_1: anytype, _2: anytype, _3: anytype, _4: anytype, _5: anytype, _6: anytype, _7: anytype, _8: anytype, _9: anytype, _10: anytype, _11: anytype, _12: anytype, _13: anytype, _14: anytype, _15: anytype, _16: anytype, _17: anytype, _18: anytype, _19: anytype, _20: anytype, _21: anytype, _22: anytype, _23: anytype, _24: anytype, _25: anytype, _26: anytype, _27: anytype, _28: anytype) @TypeOf(Z_PASTE_28(_1, _2, _3, _4, _5, _6, _7, _8, _9, _10, _11, _12, _13, _14, _15, _16, _17, _18, _19, _20, _21, _22, _23, _24, _25, _26, _27, _28)) {
    _ = &_1;
    _ = &_2;
    _ = &_3;
    _ = &_4;
    _ = &_5;
    _ = &_6;
    _ = &_7;
    _ = &_8;
    _ = &_9;
    _ = &_10;
    _ = &_11;
    _ = &_12;
    _ = &_13;
    _ = &_14;
    _ = &_15;
    _ = &_16;
    _ = &_17;
    _ = &_18;
    _ = &_19;
    _ = &_20;
    _ = &_21;
    _ = &_22;
    _ = &_23;
    _ = &_24;
    _ = &_25;
    _ = &_26;
    _ = &_27;
    _ = &_28;
    return Z_PASTE_28(_1, _2, _3, _4, _5, _6, _7, _8, _9, _10, _11, _12, _13, _14, _15, _16, _17, _18, _19, _20, _21, _22, _23, _24, _25, _26, _27, _28);
}
pub inline fn Z_JOIN_29(_1: anytype, _2: anytype, _3: anytype, _4: anytype, _5: anytype, _6: anytype, _7: anytype, _8: anytype, _9: anytype, _10: anytype, _11: anytype, _12: anytype, _13: anytype, _14: anytype, _15: anytype, _16: anytype, _17: anytype, _18: anytype, _19: anytype, _20: anytype, _21: anytype, _22: anytype, _23: anytype, _24: anytype, _25: anytype, _26: anytype, _27: anytype, _28: anytype, _29: anytype) @TypeOf(Z_PASTE_29(_1, _2, _3, _4, _5, _6, _7, _8, _9, _10, _11, _12, _13, _14, _15, _16, _17, _18, _19, _20, _21, _22, _23, _24, _25, _26, _27, _28, _29)) {
    _ = &_1;
    _ = &_2;
    _ = &_3;
    _ = &_4;
    _ = &_5;
    _ = &_6;
    _ = &_7;
    _ = &_8;
    _ = &_9;
    _ = &_10;
    _ = &_11;
    _ = &_12;
    _ = &_13;
    _ = &_14;
    _ = &_15;
    _ = &_16;
    _ = &_17;
    _ = &_18;
    _ = &_19;
    _ = &_20;
    _ = &_21;
    _ = &_22;
    _ = &_23;
    _ = &_24;
    _ = &_25;
    _ = &_26;
    _ = &_27;
    _ = &_28;
    _ = &_29;
    return Z_PASTE_29(_1, _2, _3, _4, _5, _6, _7, _8, _9, _10, _11, _12, _13, _14, _15, _16, _17, _18, _19, _20, _21, _22, _23, _24, _25, _26, _27, _28, _29);
}
pub inline fn Z_JOIN_30(_1: anytype, _2: anytype, _3: anytype, _4: anytype, _5: anytype, _6: anytype, _7: anytype, _8: anytype, _9: anytype, _10: anytype, _11: anytype, _12: anytype, _13: anytype, _14: anytype, _15: anytype, _16: anytype, _17: anytype, _18: anytype, _19: anytype, _20: anytype, _21: anytype, _22: anytype, _23: anytype, _24: anytype, _25: anytype, _26: anytype, _27: anytype, _28: anytype, _29: anytype, _30: anytype) @TypeOf(Z_PASTE_31(_1, _2, _3, _4, _5, _6, _7, _8, _9, _10, _11, _12, _13, _14, _15, _16, _17, _18, _19, _20, _21, _22, _23, _24, _25, _26, _27, _28, _29, _30)) {
    _ = &_1;
    _ = &_2;
    _ = &_3;
    _ = &_4;
    _ = &_5;
    _ = &_6;
    _ = &_7;
    _ = &_8;
    _ = &_9;
    _ = &_10;
    _ = &_11;
    _ = &_12;
    _ = &_13;
    _ = &_14;
    _ = &_15;
    _ = &_16;
    _ = &_17;
    _ = &_18;
    _ = &_19;
    _ = &_20;
    _ = &_21;
    _ = &_22;
    _ = &_23;
    _ = &_24;
    _ = &_25;
    _ = &_26;
    _ = &_27;
    _ = &_28;
    _ = &_29;
    _ = &_30;
    return Z_PASTE_31(_1, _2, _3, _4, _5, _6, _7, _8, _9, _10, _11, _12, _13, _14, _15, _16, _17, _18, _19, _20, _21, _22, _23, _24, _25, _26, _27, _28, _29, _30);
}
pub inline fn Z_JOIN_31(_1: anytype, _2: anytype, _3: anytype, _4: anytype, _5: anytype, _6: anytype, _7: anytype, _8: anytype, _9: anytype, _10: anytype, _11: anytype, _12: anytype, _13: anytype, _14: anytype, _15: anytype, _16: anytype, _17: anytype, _18: anytype, _19: anytype, _20: anytype, _21: anytype, _22: anytype, _23: anytype, _24: anytype, _25: anytype, _26: anytype, _27: anytype, _28: anytype, _29: anytype, _30: anytype, _31: anytype) @TypeOf(Z_PASTE_31(_1, _2, _3, _4, _5, _6, _7, _8, _9, _10, _11, _12, _13, _14, _15, _16, _17, _18, _19, _20, _21, _22, _23, _24, _25, _26, _27, _28, _29, _30, _31)) {
    _ = &_1;
    _ = &_2;
    _ = &_3;
    _ = &_4;
    _ = &_5;
    _ = &_6;
    _ = &_7;
    _ = &_8;
    _ = &_9;
    _ = &_10;
    _ = &_11;
    _ = &_12;
    _ = &_13;
    _ = &_14;
    _ = &_15;
    _ = &_16;
    _ = &_17;
    _ = &_18;
    _ = &_19;
    _ = &_20;
    _ = &_21;
    _ = &_22;
    _ = &_23;
    _ = &_24;
    _ = &_25;
    _ = &_26;
    _ = &_27;
    _ = &_28;
    _ = &_29;
    _ = &_30;
    _ = &_31;
    return Z_PASTE_31(_1, _2, _3, _4, _5, _6, _7, _8, _9, _10, _11, _12, _13, _14, _15, _16, _17, _18, _19, _20, _21, _22, _23, _24, _25, _26, _27, _28, _29, _30, _31);
}
pub inline fn Z_JOIN_32(_1: anytype, _2: anytype, _3: anytype, _4: anytype, _5: anytype, _6: anytype, _7: anytype, _8: anytype, _9: anytype, _10: anytype, _11: anytype, _12: anytype, _13: anytype, _14: anytype, _15: anytype, _16: anytype, _17: anytype, _18: anytype, _19: anytype, _20: anytype, _21: anytype, _22: anytype, _23: anytype, _24: anytype, _25: anytype, _26: anytype, _27: anytype, _28: anytype, _29: anytype, _30: anytype, _31: anytype, _32: anytype) @TypeOf(Z_PASTE_32(_1, _2, _3, _4, _5, _6, _7, _8, _9, _10, _11, _12, _13, _14, _15, _16, _17, _18, _19, _20, _21, _22, _23, _24, _25, _26, _27, _28, _29, _30, _31, _32)) {
    _ = &_1;
    _ = &_2;
    _ = &_3;
    _ = &_4;
    _ = &_5;
    _ = &_6;
    _ = &_7;
    _ = &_8;
    _ = &_9;
    _ = &_10;
    _ = &_11;
    _ = &_12;
    _ = &_13;
    _ = &_14;
    _ = &_15;
    _ = &_16;
    _ = &_17;
    _ = &_18;
    _ = &_19;
    _ = &_20;
    _ = &_21;
    _ = &_22;
    _ = &_23;
    _ = &_24;
    _ = &_25;
    _ = &_26;
    _ = &_27;
    _ = &_28;
    _ = &_29;
    _ = &_30;
    _ = &_31;
    _ = &_32;
    return Z_PASTE_32(_1, _2, _3, _4, _5, _6, _7, _8, _9, _10, _11, _12, _13, _14, _15, _16, _17, _18, _19, _20, _21, _22, _23, _24, _25, _26, _27, _28, _29, _30, _31, _32);
}
pub const Z_APPEND_NUMBER_0 = @compileError("unable to translate C expr: unexpected token '##'");
// /opt/homebrew/include/Z/macros/token.h:162:9
pub const Z_APPEND_NUMBER_1 = @compileError("unable to translate C expr: unexpected token '##'");
// /opt/homebrew/include/Z/macros/token.h:163:9
pub const Z_APPEND_NUMBER_2 = @compileError("unable to translate C expr: unexpected token '##'");
// /opt/homebrew/include/Z/macros/token.h:164:9
pub const Z_APPEND_NUMBER_3 = @compileError("unable to translate C expr: unexpected token '##'");
// /opt/homebrew/include/Z/macros/token.h:165:9
pub const Z_APPEND_NUMBER_4 = @compileError("unable to translate C expr: unexpected token '##'");
// /opt/homebrew/include/Z/macros/token.h:166:9
pub const Z_APPEND_NUMBER_5 = @compileError("unable to translate C expr: unexpected token '##'");
// /opt/homebrew/include/Z/macros/token.h:167:9
pub const Z_APPEND_NUMBER_6 = @compileError("unable to translate C expr: unexpected token '##'");
// /opt/homebrew/include/Z/macros/token.h:168:9
pub const Z_APPEND_NUMBER_7 = @compileError("unable to translate C expr: unexpected token '##'");
// /opt/homebrew/include/Z/macros/token.h:169:9
pub const Z_APPEND_NUMBER_8 = @compileError("unable to translate C expr: unexpected token '##'");
// /opt/homebrew/include/Z/macros/token.h:170:9
pub const Z_APPEND_NUMBER_9 = @compileError("unable to translate C expr: unexpected token '##'");
// /opt/homebrew/include/Z/macros/token.h:171:9
pub const Z_APPEND_NUMBER_10 = @compileError("unable to translate C expr: unexpected token '##'");
// /opt/homebrew/include/Z/macros/token.h:172:9
pub const Z_APPEND_NUMBER_11 = @compileError("unable to translate C expr: unexpected token '##'");
// /opt/homebrew/include/Z/macros/token.h:173:9
pub const Z_APPEND_NUMBER_12 = @compileError("unable to translate C expr: unexpected token '##'");
// /opt/homebrew/include/Z/macros/token.h:174:9
pub const Z_APPEND_NUMBER_13 = @compileError("unable to translate C expr: unexpected token '##'");
// /opt/homebrew/include/Z/macros/token.h:175:9
pub const Z_APPEND_NUMBER_14 = @compileError("unable to translate C expr: unexpected token '##'");
// /opt/homebrew/include/Z/macros/token.h:176:9
pub const Z_APPEND_NUMBER_15 = @compileError("unable to translate C expr: unexpected token '##'");
// /opt/homebrew/include/Z/macros/token.h:177:9
pub const Z_APPEND_NUMBER_16 = @compileError("unable to translate C expr: unexpected token '##'");
// /opt/homebrew/include/Z/macros/token.h:178:9
pub const Z_APPEND_NUMBER_17 = @compileError("unable to translate C expr: unexpected token '##'");
// /opt/homebrew/include/Z/macros/token.h:179:9
pub const Z_APPEND_NUMBER_18 = @compileError("unable to translate C expr: unexpected token '##'");
// /opt/homebrew/include/Z/macros/token.h:180:9
pub const Z_APPEND_NUMBER_19 = @compileError("unable to translate C expr: unexpected token '##'");
// /opt/homebrew/include/Z/macros/token.h:181:9
pub const Z_APPEND_NUMBER_20 = @compileError("unable to translate C expr: unexpected token '##'");
// /opt/homebrew/include/Z/macros/token.h:182:9
pub const Z_APPEND_NUMBER_21 = @compileError("unable to translate C expr: unexpected token '##'");
// /opt/homebrew/include/Z/macros/token.h:183:9
pub const Z_APPEND_NUMBER_22 = @compileError("unable to translate C expr: unexpected token '##'");
// /opt/homebrew/include/Z/macros/token.h:184:9
pub const Z_APPEND_NUMBER_23 = @compileError("unable to translate C expr: unexpected token '##'");
// /opt/homebrew/include/Z/macros/token.h:185:9
pub const Z_APPEND_NUMBER_24 = @compileError("unable to translate C expr: unexpected token '##'");
// /opt/homebrew/include/Z/macros/token.h:186:9
pub const Z_APPEND_NUMBER_25 = @compileError("unable to translate C expr: unexpected token '##'");
// /opt/homebrew/include/Z/macros/token.h:187:9
pub const Z_APPEND_NUMBER_26 = @compileError("unable to translate C expr: unexpected token '##'");
// /opt/homebrew/include/Z/macros/token.h:188:9
pub const Z_APPEND_NUMBER_27 = @compileError("unable to translate C expr: unexpected token '##'");
// /opt/homebrew/include/Z/macros/token.h:189:9
pub const Z_APPEND_NUMBER_28 = @compileError("unable to translate C expr: unexpected token '##'");
// /opt/homebrew/include/Z/macros/token.h:190:9
pub const Z_APPEND_NUMBER_29 = @compileError("unable to translate C expr: unexpected token '##'");
// /opt/homebrew/include/Z/macros/token.h:191:9
pub const Z_APPEND_NUMBER_30 = @compileError("unable to translate C expr: unexpected token '##'");
// /opt/homebrew/include/Z/macros/token.h:192:9
pub const Z_APPEND_NUMBER_31 = @compileError("unable to translate C expr: unexpected token '##'");
// /opt/homebrew/include/Z/macros/token.h:193:9
pub const Z_APPEND_NUMBER_32 = @compileError("unable to translate C expr: unexpected token '##'");
// /opt/homebrew/include/Z/macros/token.h:194:9
pub const Z_APPEND_NUMBER_48 = @compileError("unable to translate C expr: unexpected token '##'");
// /opt/homebrew/include/Z/macros/token.h:195:9
pub const Z_APPEND_NUMBER_64 = @compileError("unable to translate C expr: unexpected token '##'");
// /opt/homebrew/include/Z/macros/token.h:196:9
pub const Z_APPEND_NUMBER_72 = @compileError("unable to translate C expr: unexpected token '##'");
// /opt/homebrew/include/Z/macros/token.h:197:9
pub const Z_APPEND_NUMBER_80 = @compileError("unable to translate C expr: unexpected token '##'");
// /opt/homebrew/include/Z/macros/token.h:198:9
pub const Z_APPEND_NUMBER_96 = @compileError("unable to translate C expr: unexpected token '##'");
// /opt/homebrew/include/Z/macros/token.h:199:9
pub const Z_APPEND_NUMBER_128 = @compileError("unable to translate C expr: unexpected token '##'");
// /opt/homebrew/include/Z/macros/token.h:200:9
pub const Z_APPEND_NUMBER_256 = @compileError("unable to translate C expr: unexpected token '##'");
// /opt/homebrew/include/Z/macros/token.h:201:9
pub const Z_APPEND_NUMBER_512 = @compileError("unable to translate C expr: unexpected token '##'");
// /opt/homebrew/include/Z/macros/token.h:202:9
pub const Z_APPEND_NUMBER_1024 = @compileError("unable to translate C expr: unexpected token '##'");
// /opt/homebrew/include/Z/macros/token.h:203:9
pub const Z_PREPEND_NUMBER_0 = @compileError("unable to translate C expr: unexpected token '##'");
// /opt/homebrew/include/Z/macros/token.h:205:9
pub const Z_PREPEND_NUMBER_1 = @compileError("unable to translate C expr: unexpected token '##'");
// /opt/homebrew/include/Z/macros/token.h:206:9
pub const Z_PREPEND_NUMBER_2 = @compileError("unable to translate C expr: unexpected token '##'");
// /opt/homebrew/include/Z/macros/token.h:207:9
pub const Z_PREPEND_NUMBER_3 = @compileError("unable to translate C expr: unexpected token '##'");
// /opt/homebrew/include/Z/macros/token.h:208:9
pub const Z_PREPEND_NUMBER_4 = @compileError("unable to translate C expr: unexpected token '##'");
// /opt/homebrew/include/Z/macros/token.h:209:9
pub const Z_PREPEND_NUMBER_5 = @compileError("unable to translate C expr: unexpected token '##'");
// /opt/homebrew/include/Z/macros/token.h:210:9
pub const Z_PREPEND_NUMBER_6 = @compileError("unable to translate C expr: unexpected token '##'");
// /opt/homebrew/include/Z/macros/token.h:211:9
pub const Z_PREPEND_NUMBER_7 = @compileError("unable to translate C expr: unexpected token '##'");
// /opt/homebrew/include/Z/macros/token.h:212:9
pub const Z_PREPEND_NUMBER_8 = @compileError("unable to translate C expr: unexpected token '##'");
// /opt/homebrew/include/Z/macros/token.h:213:9
pub const Z_PREPEND_NUMBER_9 = @compileError("unable to translate C expr: unexpected token '##'");
// /opt/homebrew/include/Z/macros/token.h:214:9
pub const Z_PREPEND_NUMBER_10 = @compileError("unable to translate C expr: unexpected token '##'");
// /opt/homebrew/include/Z/macros/token.h:215:9
pub const Z_PREPEND_NUMBER_11 = @compileError("unable to translate C expr: unexpected token '##'");
// /opt/homebrew/include/Z/macros/token.h:216:9
pub const Z_PREPEND_NUMBER_12 = @compileError("unable to translate C expr: unexpected token '##'");
// /opt/homebrew/include/Z/macros/token.h:217:9
pub const Z_PREPEND_NUMBER_13 = @compileError("unable to translate C expr: unexpected token '##'");
// /opt/homebrew/include/Z/macros/token.h:218:9
pub const Z_PREPEND_NUMBER_14 = @compileError("unable to translate C expr: unexpected token '##'");
// /opt/homebrew/include/Z/macros/token.h:219:9
pub const Z_PREPEND_NUMBER_15 = @compileError("unable to translate C expr: unexpected token '##'");
// /opt/homebrew/include/Z/macros/token.h:220:9
pub const Z_PREPEND_NUMBER_16 = @compileError("unable to translate C expr: unexpected token '##'");
// /opt/homebrew/include/Z/macros/token.h:221:9
pub const Z_PREPEND_NUMBER_17 = @compileError("unable to translate C expr: unexpected token '##'");
// /opt/homebrew/include/Z/macros/token.h:222:9
pub const Z_PREPEND_NUMBER_18 = @compileError("unable to translate C expr: unexpected token '##'");
// /opt/homebrew/include/Z/macros/token.h:223:9
pub const Z_PREPEND_NUMBER_19 = @compileError("unable to translate C expr: unexpected token '##'");
// /opt/homebrew/include/Z/macros/token.h:224:9
pub const Z_PREPEND_NUMBER_20 = @compileError("unable to translate C expr: unexpected token '##'");
// /opt/homebrew/include/Z/macros/token.h:225:9
pub const Z_PREPEND_NUMBER_21 = @compileError("unable to translate C expr: unexpected token '##'");
// /opt/homebrew/include/Z/macros/token.h:226:9
pub const Z_PREPEND_NUMBER_22 = @compileError("unable to translate C expr: unexpected token '##'");
// /opt/homebrew/include/Z/macros/token.h:227:9
pub const Z_PREPEND_NUMBER_23 = @compileError("unable to translate C expr: unexpected token '##'");
// /opt/homebrew/include/Z/macros/token.h:228:9
pub const Z_PREPEND_NUMBER_24 = @compileError("unable to translate C expr: unexpected token '##'");
// /opt/homebrew/include/Z/macros/token.h:229:9
pub const Z_PREPEND_NUMBER_25 = @compileError("unable to translate C expr: unexpected token '##'");
// /opt/homebrew/include/Z/macros/token.h:230:9
pub const Z_PREPEND_NUMBER_26 = @compileError("unable to translate C expr: unexpected token '##'");
// /opt/homebrew/include/Z/macros/token.h:231:9
pub const Z_PREPEND_NUMBER_27 = @compileError("unable to translate C expr: unexpected token '##'");
// /opt/homebrew/include/Z/macros/token.h:232:9
pub const Z_PREPEND_NUMBER_28 = @compileError("unable to translate C expr: unexpected token '##'");
// /opt/homebrew/include/Z/macros/token.h:233:9
pub const Z_PREPEND_NUMBER_29 = @compileError("unable to translate C expr: unexpected token '##'");
// /opt/homebrew/include/Z/macros/token.h:234:9
pub const Z_PREPEND_NUMBER_30 = @compileError("unable to translate C expr: unexpected token '##'");
// /opt/homebrew/include/Z/macros/token.h:235:9
pub const Z_PREPEND_NUMBER_31 = @compileError("unable to translate C expr: unexpected token '##'");
// /opt/homebrew/include/Z/macros/token.h:236:9
pub const Z_PREPEND_NUMBER_32 = @compileError("unable to translate C expr: unexpected token '##'");
// /opt/homebrew/include/Z/macros/token.h:237:9
pub const Z_PREPEND_NUMBER_48 = @compileError("unable to translate C expr: unexpected token '##'");
// /opt/homebrew/include/Z/macros/token.h:238:9
pub const Z_PREPEND_NUMBER_64 = @compileError("unable to translate C expr: unexpected token '##'");
// /opt/homebrew/include/Z/macros/token.h:239:9
pub const Z_PREPEND_NUMBER_72 = @compileError("unable to translate C expr: unexpected token '##'");
// /opt/homebrew/include/Z/macros/token.h:240:9
pub const Z_PREPEND_NUMBER_80 = @compileError("unable to translate C expr: unexpected token '##'");
// /opt/homebrew/include/Z/macros/token.h:241:9
pub const Z_PREPEND_NUMBER_96 = @compileError("unable to translate C expr: unexpected token '##'");
// /opt/homebrew/include/Z/macros/token.h:242:9
pub const Z_PREPEND_NUMBER_128 = @compileError("unable to translate C expr: unexpected token '##'");
// /opt/homebrew/include/Z/macros/token.h:243:9
pub const Z_PREPEND_NUMBER_256 = @compileError("unable to translate C expr: unexpected token '##'");
// /opt/homebrew/include/Z/macros/token.h:244:9
pub const Z_PREPEND_NUMBER_512 = @compileError("unable to translate C expr: unexpected token '##'");
// /opt/homebrew/include/Z/macros/token.h:245:9
pub const Z_PREPEND_NUMBER_1024 = @compileError("unable to translate C expr: unexpected token '##'");
// /opt/homebrew/include/Z/macros/token.h:246:9
pub const Z_INSERT_NUMBER_0 = @compileError("unable to translate C expr: unexpected token '##'");
// /opt/homebrew/include/Z/macros/token.h:248:9
pub const Z_INSERT_NUMBER_1 = @compileError("unable to translate C expr: unexpected token '##'");
// /opt/homebrew/include/Z/macros/token.h:249:9
pub const Z_INSERT_NUMBER_2 = @compileError("unable to translate C expr: unexpected token '##'");
// /opt/homebrew/include/Z/macros/token.h:250:9
pub const Z_INSERT_NUMBER_3 = @compileError("unable to translate C expr: unexpected token '##'");
// /opt/homebrew/include/Z/macros/token.h:251:9
pub const Z_INSERT_NUMBER_4 = @compileError("unable to translate C expr: unexpected token '##'");
// /opt/homebrew/include/Z/macros/token.h:252:9
pub const Z_INSERT_NUMBER_5 = @compileError("unable to translate C expr: unexpected token '##'");
// /opt/homebrew/include/Z/macros/token.h:253:9
pub const Z_INSERT_NUMBER_6 = @compileError("unable to translate C expr: unexpected token '##'");
// /opt/homebrew/include/Z/macros/token.h:254:9
pub const Z_INSERT_NUMBER_7 = @compileError("unable to translate C expr: unexpected token '##'");
// /opt/homebrew/include/Z/macros/token.h:255:9
pub const Z_INSERT_NUMBER_8 = @compileError("unable to translate C expr: unexpected token '##'");
// /opt/homebrew/include/Z/macros/token.h:256:9
pub const Z_INSERT_NUMBER_9 = @compileError("unable to translate C expr: unexpected token '##'");
// /opt/homebrew/include/Z/macros/token.h:257:9
pub const Z_INSERT_NUMBER_10 = @compileError("unable to translate C expr: unexpected token '##'");
// /opt/homebrew/include/Z/macros/token.h:258:9
pub const Z_INSERT_NUMBER_11 = @compileError("unable to translate C expr: unexpected token '##'");
// /opt/homebrew/include/Z/macros/token.h:259:9
pub const Z_INSERT_NUMBER_12 = @compileError("unable to translate C expr: unexpected token '##'");
// /opt/homebrew/include/Z/macros/token.h:260:9
pub const Z_INSERT_NUMBER_13 = @compileError("unable to translate C expr: unexpected token '##'");
// /opt/homebrew/include/Z/macros/token.h:261:9
pub const Z_INSERT_NUMBER_14 = @compileError("unable to translate C expr: unexpected token '##'");
// /opt/homebrew/include/Z/macros/token.h:262:9
pub const Z_INSERT_NUMBER_15 = @compileError("unable to translate C expr: unexpected token '##'");
// /opt/homebrew/include/Z/macros/token.h:263:9
pub const Z_INSERT_NUMBER_16 = @compileError("unable to translate C expr: unexpected token '##'");
// /opt/homebrew/include/Z/macros/token.h:264:9
pub const Z_INSERT_NUMBER_17 = @compileError("unable to translate C expr: unexpected token '##'");
// /opt/homebrew/include/Z/macros/token.h:265:9
pub const Z_INSERT_NUMBER_18 = @compileError("unable to translate C expr: unexpected token '##'");
// /opt/homebrew/include/Z/macros/token.h:266:9
pub const Z_INSERT_NUMBER_19 = @compileError("unable to translate C expr: unexpected token '##'");
// /opt/homebrew/include/Z/macros/token.h:267:9
pub const Z_INSERT_NUMBER_20 = @compileError("unable to translate C expr: unexpected token '##'");
// /opt/homebrew/include/Z/macros/token.h:268:9
pub const Z_INSERT_NUMBER_21 = @compileError("unable to translate C expr: unexpected token '##'");
// /opt/homebrew/include/Z/macros/token.h:269:9
pub const Z_INSERT_NUMBER_22 = @compileError("unable to translate C expr: unexpected token '##'");
// /opt/homebrew/include/Z/macros/token.h:270:9
pub const Z_INSERT_NUMBER_23 = @compileError("unable to translate C expr: unexpected token '##'");
// /opt/homebrew/include/Z/macros/token.h:271:9
pub const Z_INSERT_NUMBER_24 = @compileError("unable to translate C expr: unexpected token '##'");
// /opt/homebrew/include/Z/macros/token.h:272:9
pub const Z_INSERT_NUMBER_25 = @compileError("unable to translate C expr: unexpected token '##'");
// /opt/homebrew/include/Z/macros/token.h:273:9
pub const Z_INSERT_NUMBER_26 = @compileError("unable to translate C expr: unexpected token '##'");
// /opt/homebrew/include/Z/macros/token.h:274:9
pub const Z_INSERT_NUMBER_27 = @compileError("unable to translate C expr: unexpected token '##'");
// /opt/homebrew/include/Z/macros/token.h:275:9
pub const Z_INSERT_NUMBER_28 = @compileError("unable to translate C expr: unexpected token '##'");
// /opt/homebrew/include/Z/macros/token.h:276:9
pub const Z_INSERT_NUMBER_29 = @compileError("unable to translate C expr: unexpected token '##'");
// /opt/homebrew/include/Z/macros/token.h:277:9
pub const Z_INSERT_NUMBER_30 = @compileError("unable to translate C expr: unexpected token '##'");
// /opt/homebrew/include/Z/macros/token.h:278:9
pub const Z_INSERT_NUMBER_31 = @compileError("unable to translate C expr: unexpected token '##'");
// /opt/homebrew/include/Z/macros/token.h:279:9
pub const Z_INSERT_NUMBER_32 = @compileError("unable to translate C expr: unexpected token '##'");
// /opt/homebrew/include/Z/macros/token.h:280:9
pub const Z_INSERT_NUMBER_48 = @compileError("unable to translate C expr: unexpected token '##'");
// /opt/homebrew/include/Z/macros/token.h:281:9
pub const Z_INSERT_NUMBER_64 = @compileError("unable to translate C expr: unexpected token '##'");
// /opt/homebrew/include/Z/macros/token.h:282:9
pub const Z_INSERT_NUMBER_72 = @compileError("unable to translate C expr: unexpected token '##'");
// /opt/homebrew/include/Z/macros/token.h:283:9
pub const Z_INSERT_NUMBER_80 = @compileError("unable to translate C expr: unexpected token '##'");
// /opt/homebrew/include/Z/macros/token.h:284:9
pub const Z_INSERT_NUMBER_96 = @compileError("unable to translate C expr: unexpected token '##'");
// /opt/homebrew/include/Z/macros/token.h:285:9
pub const Z_INSERT_NUMBER_128 = @compileError("unable to translate C expr: unexpected token '##'");
// /opt/homebrew/include/Z/macros/token.h:286:9
pub const Z_INSERT_NUMBER_256 = @compileError("unable to translate C expr: unexpected token '##'");
// /opt/homebrew/include/Z/macros/token.h:287:9
pub const Z_INSERT_NUMBER_512 = @compileError("unable to translate C expr: unexpected token '##'");
// /opt/homebrew/include/Z/macros/token.h:288:9
pub const Z_INSERT_NUMBER_1024 = @compileError("unable to translate C expr: unexpected token '##'");
// /opt/homebrew/include/Z/macros/token.h:289:9
pub inline fn Z_z_IS_RESULT(padding1: anytype, result: anytype, padding2: anytype, padding3: anytype) @TypeOf(result) {
    _ = &padding1;
    _ = &result;
    _ = &padding2;
    _ = &padding3;
    return result;
}
pub const Z_z_IS_TEST = @compileError("unable to translate C expr: expected ',' or ')' instead got 'A number'");
// /opt/homebrew/include/Z/macros/token.h:293:9
pub const Z_z_IS_NOT_TEST = @compileError("unable to translate C expr: expected ',' or ')' instead got 'A number'");
// /opt/homebrew/include/Z/macros/token.h:296:9
pub const Z_z_IS_0_SPLIT_0 = @compileError("unable to translate C expr: unexpected token ','");
// /opt/homebrew/include/Z/macros/token.h:299:9
pub const Z_z_IS_0_MERGE_BEGIN_0 = @compileError("unable to translate C expr: unexpected token ''");
// /opt/homebrew/include/Z/macros/token.h:300:9
pub const Z_z_IS_0_MERGE_END_0 = @compileError("unable to translate C expr: unexpected token ')'");
// /opt/homebrew/include/Z/macros/token.h:301:9
pub const Z_z_IS_1_SPLIT_1 = @compileError("unable to translate C expr: unexpected token ','");
// /opt/homebrew/include/Z/macros/token.h:302:9
pub const Z_z_IS_1_MERGE_BEGIN_1 = @compileError("unable to translate C expr: unexpected token ''");
// /opt/homebrew/include/Z/macros/token.h:303:9
pub const Z_z_IS_1_MERGE_END_1 = @compileError("unable to translate C expr: unexpected token ')'");
// /opt/homebrew/include/Z/macros/token.h:304:9
pub const Z_IS_0 = @compileError("unable to translate macro: undefined identifier `Z_z_IS_0_SPLIT_`");
// /opt/homebrew/include/Z/macros/token.h:306:9
pub const Z_IS_1 = @compileError("unable to translate macro: undefined identifier `Z_z_IS_1_SPLIT_`");
// /opt/homebrew/include/Z/macros/token.h:311:9
pub const Z_IS_NOT_0 = @compileError("unable to translate macro: undefined identifier `Z_z_IS_0_SPLIT_`");
// /opt/homebrew/include/Z/macros/token.h:316:9
pub const Z_IS_NOT_1 = @compileError("unable to translate macro: undefined identifier `Z_z_IS_1_SPLIT_`");
// /opt/homebrew/include/Z/macros/token.h:321:9
pub const Z_BOOLEANIZE = Z_IS_NOT_0;
pub const Z_NOT = Z_IS_0;
pub const Z_IS_TRUE = Z_IS_1;
pub const Z_IS_FALSE = Z_IS_0;
pub inline fn Z_z_IF_1(body: anytype) @TypeOf(body) {
    _ = &body;
    return body;
}
pub const Z_z_IF_0 = @compileError("unable to translate C expr: unexpected token ''");
// /opt/homebrew/include/Z/macros/token.h:332:9
pub const Z_IF = @compileError("unable to translate macro: undefined identifier `Z_z_IF_`");
// /opt/homebrew/include/Z/macros/token.h:334:9
pub const Z_z_UNLESS_1 = @compileError("unable to translate C expr: unexpected token ''");
// /opt/homebrew/include/Z/macros/token.h:337:9
pub inline fn Z_z_UNLESS_0(body: anytype) @TypeOf(body) {
    _ = &body;
    return body;
}
pub const Z_UNLESS = @compileError("unable to translate macro: undefined identifier `Z_z_UNLESS_`");
// /opt/homebrew/include/Z/macros/token.h:340:9
pub inline fn Z_z_TERNARY_1(a: anytype, b: anytype) @TypeOf(a) {
    _ = &a;
    _ = &b;
    return a;
}
pub inline fn Z_z_TERNARY_0(a: anytype, b: anytype) @TypeOf(b) {
    _ = &a;
    _ = &b;
    return b;
}
pub const Z_TERNARY = @compileError("unable to translate macro: undefined identifier `Z_z_TERNARY_`");
// /opt/homebrew/include/Z/macros/token.h:346:9
pub const Z_z_APPEND_TERNARY_1 = @compileError("unable to translate C expr: unexpected token '##'");
// /opt/homebrew/include/Z/macros/token.h:349:9
pub const Z_z_APPEND_TERNARY_0 = @compileError("unable to translate C expr: unexpected token '##'");
// /opt/homebrew/include/Z/macros/token.h:350:9
pub const Z_APPEND_TERNARY = @compileError("unable to translate macro: undefined identifier `Z_z_APPEND_TERNARY_`");
// /opt/homebrew/include/Z/macros/token.h:352:9
pub const Z_z_PREPEND_TERNARY_1 = @compileError("unable to translate C expr: unexpected token '##'");
// /opt/homebrew/include/Z/macros/token.h:355:9
pub const Z_z_PREPEND_TERNARY_0 = @compileError("unable to translate C expr: unexpected token '##'");
// /opt/homebrew/include/Z/macros/token.h:356:9
pub const Z_PREPEND_TERNARY = @compileError("unable to translate macro: undefined identifier `Z_z_PREPEND_TERNARY_`");
// /opt/homebrew/include/Z/macros/token.h:358:9
pub const Z_z_INSERT_TERNARY_1 = @compileError("unable to translate C expr: unexpected token '##'");
// /opt/homebrew/include/Z/macros/token.h:361:9
pub const Z_z_INSERT_TERNARY_0 = @compileError("unable to translate C expr: unexpected token '##'");
// /opt/homebrew/include/Z/macros/token.h:362:9
pub const Z_INSERT_TERNARY = @compileError("unable to translate macro: undefined identifier `Z_z_INSERT_TERNARY_`");
// /opt/homebrew/include/Z/macros/token.h:364:9
pub const Z_C = Z_C17;
pub const Z_inspection_C_modules_C11_H = "";
pub const Z_inspection_C_modules_C99_H = "";
pub const Z_inspection_C_modules_C95_H = "";
pub const Z_inspection_C_modules_C89_H = "";
pub const Z_inspection_C_modules_C78_H = "";
pub const Z_LANGUAGE_HAS_C_OLD_STYLE_FUNCTION = @as(c_int, 1);
pub const Z_LANGUAGE_HAS_C_OPERATOR_SIZEOF = @as(c_int, 1);
pub const Z_LANGUAGE_HAS_C_STORAGE_CLASS_AUTO = @as(c_int, 1);
pub const Z_LANGUAGE_HAS_C_STORAGE_CLASS_EXTERN = @as(c_int, 1);
pub const Z_LANGUAGE_HAS_C_STORAGE_CLASS_REGISTER = @as(c_int, 1);
pub const Z_LANGUAGE_HAS_C_STORAGE_CLASS_STATIC = @as(c_int, 1);
pub const Z_LANGUAGE_HAS_C_TYPE_DOUBLE = @as(c_int, 1);
pub const Z_LANGUAGE_HAS_C_TYPE_FLOAT = @as(c_int, 1);
pub const Z_LANGUAGE_HAS_C89_CONSTANT_INITIALIZATION_FOR_LOCAL_AGGREGATE = @as(c_int, 1);
pub const Z_LANGUAGE_HAS_C89_CONSTANT_INITIALIZATION_FOR_UNION = @as(c_int, 1);
pub const Z_LANGUAGE_HAS_C89_CONSTRUCT_AS_FUNCTION_ARGUMENT = @as(c_int, 1);
pub const Z_LANGUAGE_HAS_C89_CONSTRUCT_RETURN = @as(c_int, 1);
pub const Z_LANGUAGE_HAS_C89_CONSTRUCT_ASSIGNMENT = @as(c_int, 1);
pub const Z_LANGUAGE_HAS_C89_CONSTRUCT_NAMESPACE = @as(c_int, 1);
pub const Z_LANGUAGE_HAS_C89_ENUMERATION = @as(c_int, 1);
pub const Z_LANGUAGE_HAS_C89_FUNCTION_POINTER_AUTODEREFERENCING = @as(c_int, 1);
pub const Z_LANGUAGE_HAS_C89_FUNCTION_PROTOTYPE = @as(c_int, 1);
pub const Z_LANGUAGE_HAS_C89_INTEGRAL_SWITCH = @as(c_int, 1);
pub const Z_LANGUAGE_HAS_C89_PREPROCESSOR_INDENTATION = @as(c_int, 1);
pub const Z_LANGUAGE_HAS_C89_REMOVAL_OF_ENTRY_AS_KEYWORD = @as(c_int, 1);
pub const Z_LANGUAGE_HAS_C89_REMOVAL_OF_LONG_FLOAT_AS_TYPE = @as(c_int, 1);
pub const Z_LANGUAGE_HAS_C89_STRING_LITERAL_CONCATENATION = @as(c_int, 1);
pub const Z_LANGUAGE_HAS_C89_TRIGRAPHS = @as(c_int, 1);
pub const Z_LANGUAGE_HAS_C89_VALUE_PRESERVING_UNSIGNED_CONVERSION = @as(c_int, 1);
pub const Z_LANGUAGE_HAS_C89_ESCAPE_SEQUENCE_ALERT = @as(c_int, 1);
pub const Z_LANGUAGE_HAS_C89_ESCAPE_SEQUENCE_HEXADECIMAL = @as(c_int, 1);
pub const Z_LANGUAGE_HAS_C89_ESCAPE_SEQUENCE_VERTICAL_TAB = @as(c_int, 1);
pub const Z_LANGUAGE_HAS_C89_LITERAL_FLOAT = @as(c_int, 1);
pub const Z_LANGUAGE_HAS_C89_LITERAL_UNSIGNED = @as(c_int, 1);
pub const Z_LANGUAGE_HAS_C89_LITERAL_WCHAR_T_CHARACTER = @as(c_int, 1);
pub const Z_LANGUAGE_HAS_C89_LITERAL_WCHAR_T_STRING = @as(c_int, 1);
pub const Z_LANGUAGE_HAS_C89_OPERATOR_UNARY_PLUS = @as(c_int, 1);
pub const Z_LANGUAGE_HAS_C89_PREPROCESSOR_DIRECTIVE_NULL = @as(c_int, 1);
pub const Z_LANGUAGE_HAS_C89_PREPROCESSOR_DIRECTIVE_ELIF = @as(c_int, 1);
pub const Z_LANGUAGE_HAS_C89_PREPROCESSOR_DIRECTIVE_ERROR = @as(c_int, 1);
pub const Z_LANGUAGE_HAS_C89_PREPROCESSOR_DIRECTIVE_LINE = @as(c_int, 1);
pub const Z_LANGUAGE_HAS_C89_PREPROCESSOR_DIRECTIVE_PRAGMA = @as(c_int, 1);
pub const Z_LANGUAGE_HAS_C89_PREPROCESSOR_OPERATOR_DEFINED = @as(c_int, 1);
pub const Z_LANGUAGE_HAS_C89_PREPROCESSOR_OPERATOR_PASTING = @as(c_int, 1);
pub const Z_LANGUAGE_HAS_C89_PREPROCESSOR_OPERATOR_STRINGIZING = @as(c_int, 1);
pub const Z_LANGUAGE_HAS_C89_TYPE_LONG_DOUBLE = @as(c_int, 1);
pub const Z_LANGUAGE_HAS_C89_TYPE_UNSIGNED_CHAR = @as(c_int, 1);
pub const Z_LANGUAGE_HAS_C89_TYPE_UNSIGNED_LONG = @as(c_int, 1);
pub const Z_LANGUAGE_HAS_C89_TYPE_UNSIGNED_SHORT = @as(c_int, 1);
pub const Z_LANGUAGE_HAS_C89_TYPE_VOID = @as(c_int, 1);
pub const Z_LANGUAGE_HAS_C89_TYPE_VOID_POINTER = @as(c_int, 1);
pub const Z_LANGUAGE_HAS_C89_TYPE_MODIFIER_SIGNED = @as(c_int, 1);
pub const Z_LANGUAGE_HAS_C89_TYPE_QUALIFIER_CONST = @as(c_int, 1);
pub const Z_LANGUAGE_HAS_C89_TYPE_QUALIFIER_VOLATILE = @as(c_int, 1);
pub const Z_LANGUAGE_HAS_C95_DIGRAPHS = @as(c_int, 1);
pub const Z_LANGUAGE_HAS_C99_COMPOUND_LITERAL = @as(c_int, 1);
pub const Z_LANGUAGE_HAS_C99_CONVERSION_OF_NON_LVALUE_ARRAY_TO_POINTER = @as(c_int, 1);
pub const Z_LANGUAGE_HAS_C99_CPP_STYLE_COMMENT = @as(c_int, 1);
pub const Z_LANGUAGE_HAS_C99_DESIGNATED_INITIALIZATION = @as(c_int, 1);
pub const Z_LANGUAGE_HAS_C99_EMPTY_MACRO_ARGUMENT = @as(c_int, 1);
pub const Z_LANGUAGE_HAS_C99_EXTENDED_IDENTIFIER = @as(c_int, 1);
pub const Z_LANGUAGE_HAS_C99_FLEXIBLE_ARRAY_MEMBER = @as(c_int, 1);
pub const Z_LANGUAGE_HAS_C99_FOR_WITH_DECLARATION = @as(c_int, 1);
pub const Z_LANGUAGE_HAS_C99_IDEMPOTENT_TYPE_QUALIFIERS = @as(c_int, 1);
pub const Z_LANGUAGE_HAS_C99_MIXED_DECLARATIONS_AND_CODE = @as(c_int, 1);
pub const Z_LANGUAGE_HAS_C99_NON_CONSTANT_INITIALIZATION_FOR_LOCAL_AGGREGATE = @as(c_int, 1);
pub const Z_LANGUAGE_HAS_C99_PREPROCESSOR_ARITHMETIC_DONE_IN_INTMAX = @as(c_int, 1);
pub const Z_LANGUAGE_HAS_C99_RELIABLE_INTEGER_DIVISION = @as(c_int, 1);
pub const Z_LANGUAGE_HAS_C99_REMOVAL_OF_ILL_FORMED_RETURN = @as(c_int, 1);
pub const Z_LANGUAGE_HAS_C99_REMOVAL_OF_IMPLICIT_FUNCTION_DECLARATION = @as(c_int, 1);
pub const Z_LANGUAGE_HAS_C99_REMOVAL_OF_IMPLICIT_INT = @as(c_int, 1);
pub const Z_LANGUAGE_HAS_C99_STATIC_IN_ARRAY_PARAMETER_DECLARATION = @as(c_int, 1);
pub const Z_LANGUAGE_HAS_C99_TRAILING_COMMA_ALLOWED_IN_ENUMERATION = @as(c_int, 1);
pub const Z_LANGUAGE_HAS_C99_TYPE_QUALIFIERS_IN_ARRAY_PARAMETER_DECLARATION = @as(c_int, 1);
pub const Z_LANGUAGE_HAS_C99_UNIVERSAL_CHARACTER_NAME = @as(c_int, 1);
pub const Z_LANGUAGE_HAS_C99_VARIADIC_MACRO = @as(c_int, 1);
pub const Z_LANGUAGE_HAS_C99_VLA = @as(c_int, 1);
pub const Z_LANGUAGE_HAS_C99_IDENTIFIER_FUNC = @as(c_int, 1);
pub const Z_LANGUAGE_HAS_C99_LITERAL_HEXADECIMAL_FLOATING_POINT = @as(c_int, 1);
pub const Z_LANGUAGE_HAS_C99_PREPROCESSOR_OPERATOR_PRAGMA = @as(c_int, 1);
pub const Z_LANGUAGE_HAS_C99_SPECIFIER_INLINE = @as(c_int, 1);
pub const Z_LANGUAGE_HAS_C99_STD_PRAGMA_CX_LIMITED_RANGE = @as(c_int, 1);
pub const Z_LANGUAGE_HAS_C99_STD_PRAGMA_FENV_ACCESS = @as(c_int, 1);
pub const Z_LANGUAGE_HAS_C99_STD_PRAGMA_FP_CONTRACT = @as(c_int, 1);
pub const Z_LANGUAGE_HAS_C99_TYPE_BOOL = @as(c_int, 1);
pub const Z_LANGUAGE_HAS_C99_TYPE_LONG_LONG = @as(c_int, 1);
pub const Z_LANGUAGE_HAS_C99_TYPE_QUALIFIER_RESTRICT = @as(c_int, 1);
pub const Z_LANGUAGE_HAS_C11_ANONYMOUS_STRUCTURE_AS_MEMBER = @as(c_int, 1);
pub const Z_LANGUAGE_HAS_C11_ANONYMOUS_UNION_AS_MEMBER = @as(c_int, 1);
pub const Z_LANGUAGE_HAS_C11_GENERIC_SELECTION = @as(c_int, 1);
pub const Z_LANGUAGE_HAS_C11_STATIC_ASSERTION = @as(c_int, 1);
pub const Z_LANGUAGE_HAS_C11_TYPEDEF_REDECLARATION = @as(c_int, 1);
pub const Z_LANGUAGE_HAS_C11_LITERAL_CHAR16_T_CHARACTER = @as(c_int, 1);
pub const Z_LANGUAGE_HAS_C11_LITERAL_CHAR16_T_STRING = @as(c_int, 1);
pub const Z_LANGUAGE_HAS_C11_LITERAL_CHAR32_T_CHARACTER = @as(c_int, 1);
pub const Z_LANGUAGE_HAS_C11_LITERAL_CHAR32_T_STRING = @as(c_int, 1);
pub const Z_LANGUAGE_HAS_C11_LITERAL_UTF8_STRING = @as(c_int, 1);
pub const Z_LANGUAGE_HAS_C11_OPERATOR_ALIGNOF = @as(c_int, 1);
pub const Z_LANGUAGE_HAS_C11_SPECIFIER_ALIGNAS = @as(c_int, 1);
pub const Z_LANGUAGE_HAS_C11_SPECIFIER_NORETURN = @as(c_int, 1);
pub const Z_LANGUAGE_HAS_C11_STORAGE_CLASS_THREAD_LOCAL = @as(c_int, 1);
pub const Z_LANGUAGE_HAS_C11_TYPE_MODIFIER_ATOMIC = @as(c_int, 1);
pub const Z_LANGUAGE_HAS_C11_TYPE_QUALIFIER_ATOMIC = @as(c_int, 1);
pub const Z_C_NAME = Z_C_NAME_C17;
pub const Z_C_HAS = @compileError("unable to translate macro: undefined identifier `Z_C_HAS_`");
// /opt/homebrew/include/Z/inspection/C.h:60:9
pub const Z_C_HAS_ATTRIBUTE = @compileError("unable to translate macro: undefined identifier `Z_C_HAS_ATTRIBUTE_`");
// /opt/homebrew/include/Z/inspection/C.h:61:9
pub const Z_C_HAS_ESCAPE_SEQUENCE = @compileError("unable to translate macro: undefined identifier `Z_C_HAS_ESCAPE_SEQUENCE_`");
// /opt/homebrew/include/Z/inspection/C.h:62:9
pub const Z_C_HAS_IDENTIFIER = @compileError("unable to translate macro: undefined identifier `Z_C_HAS_IDENTIFIER_`");
// /opt/homebrew/include/Z/inspection/C.h:63:9
pub const Z_C_HAS_LITERAL = @compileError("unable to translate macro: undefined identifier `Z_C_HAS_LITERAL_`");
// /opt/homebrew/include/Z/inspection/C.h:64:9
pub const Z_C_HAS_OPERATOR = @compileError("unable to translate macro: undefined identifier `Z_C_HAS_OPERATOR_`");
// /opt/homebrew/include/Z/inspection/C.h:65:9
pub const Z_C_HAS_PREPROCESSOR_DIRECTIVE = @compileError("unable to translate macro: undefined identifier `Z_C_HAS_PREPROCESSOR_DIRECTIVE_`");
// /opt/homebrew/include/Z/inspection/C.h:66:9
pub const Z_C_HAS_PREPROCESSOR_OPERATOR = @compileError("unable to translate macro: undefined identifier `Z_C_HAS_PREPROCESSOR_OPERATOR_`");
// /opt/homebrew/include/Z/inspection/C.h:67:9
pub const Z_C_HAS_SPECIFIER = @compileError("unable to translate macro: undefined identifier `Z_C_HAS_SPECIFIER_`");
// /opt/homebrew/include/Z/inspection/C.h:68:9
pub const Z_C_HAS_STD_PRAGMA = @compileError("unable to translate macro: undefined identifier `Z_C_HAS_STD_PRAGMA_`");
// /opt/homebrew/include/Z/inspection/C.h:69:9
pub const Z_C_HAS_STORAGE_CLASS = @compileError("unable to translate macro: undefined identifier `Z_C_HAS_STORAGE_CLASS_`");
// /opt/homebrew/include/Z/inspection/C.h:70:9
pub const Z_C_HAS_TYPE = @compileError("unable to translate macro: undefined identifier `Z_C_HAS_TYPE_`");
// /opt/homebrew/include/Z/inspection/C.h:71:9
pub const Z_C_HAS_TYPE_MODIFIER = @compileError("unable to translate macro: undefined identifier `Z_C_HAS_TYPE_MODIFIER_`");
// /opt/homebrew/include/Z/inspection/C.h:72:9
pub const Z_C_HAS_TYPE_QUALIFIER = @compileError("unable to translate macro: undefined identifier `Z_C_HAS_TYPE_QUALIFIER_`");
// /opt/homebrew/include/Z/inspection/C.h:73:9
pub const Z_inspection_compiler_H = "";
pub const Z_keys_compiler_H = "";
pub const Z_COMPILER_UNKNOWN = @as(c_int, 0);
pub const Z_COMPILER_ACC = @as(c_int, 1);
pub const Z_COMPILER_ALTIUM_C_TO_HARDWARE = @as(c_int, 2);
pub const Z_COMPILER_ALTIUM_MICROBLAZE_C = @as(c_int, 3);
pub const Z_COMPILER_AMSTERDAM_COMPILER_KIT = @as(c_int, 4);
pub const Z_COMPILER_APPLE_CLANG = @as(c_int, 5);
pub const Z_COMPILER_ARM_C_CPP_COMPILER = @as(c_int, 6);
pub const Z_COMPILER_ARM_COMPILER = @as(c_int, 7);
pub const Z_COMPILER_AZTEC_C = @as(c_int, 8);
pub const Z_COMPILER_BCC = @as(c_int, 9);
pub const Z_COMPILER_CC65 = @as(c_int, 10);
pub const Z_COMPILER_CLANG = @as(c_int, 11);
pub const Z_COMPILER_CODE_WARRIOR = @as(c_int, 12);
pub const Z_COMPILER_COMEAU_CPP = @as(c_int, 13);
pub const Z_COMPILER_COMPAQ_C_CPP = @as(c_int, 14);
pub const Z_COMPILER_COMPCERT = @as(c_int, 15);
pub const Z_COMPILER_CONVEX_C = @as(c_int, 16);
pub const Z_COMPILER_COVERITY_C_CPP_STATIC_ANALYZER = @as(c_int, 17);
pub const Z_COMPILER_CRAY_C = @as(c_int, 18);
pub const Z_COMPILER_DIAB_C_CPP = @as(c_int, 19);
pub const Z_COMPILER_DICE_C = @as(c_int, 20);
pub const Z_COMPILER_DIGITAL_MARS = @as(c_int, 21);
pub const Z_COMPILER_DJGPP = @as(c_int, 22);
pub const Z_COMPILER_EDG_CPP_FRONTEND = @as(c_int, 23);
pub const Z_COMPILER_EKOPATH = @as(c_int, 24);
pub const Z_COMPILER_FUJITSU_CPP = @as(c_int, 25);
pub const Z_COMPILER_GCC = @as(c_int, 26);
pub const Z_COMPILER_GREEN_HILL_C_CPP = @as(c_int, 27);
pub const Z_COMPILER_HP_ACPP = @as(c_int, 28);
pub const Z_COMPILER_HP_ANSI_C = @as(c_int, 29);
pub const Z_COMPILER_HP_UPC = @as(c_int, 30);
pub const Z_COMPILER_IAR_C_CPP = @as(c_int, 31);
pub const Z_COMPILER_IBM_XL_C_CPP = @as(c_int, 32);
pub const Z_COMPILER_IBM_Z_OS_C_CPP = @as(c_int, 33);
pub const Z_COMPILER_IMAGECRAFT_C = @as(c_int, 34);
pub const Z_COMPILER_INTEL_CPP = @as(c_int, 35);
pub const Z_COMPILER_KAI_CPP = @as(c_int, 36);
pub const Z_COMPILER_KEIL_C166 = @as(c_int, 37);
pub const Z_COMPILER_KEIL_C51 = @as(c_int, 38);
pub const Z_COMPILER_KEIL_CARM = @as(c_int, 39);
pub const Z_COMPILER_LCC = @as(c_int, 40);
pub const Z_COMPILER_MCC = @as(c_int, 41);
pub const Z_COMPILER_METAWARE_HIGH_C_CPP = @as(c_int, 42);
pub const Z_COMPILER_MICROTEC_C_CPP = @as(c_int, 43);
pub const Z_COMPILER_MINGW = @as(c_int, 44);
pub const Z_COMPILER_MIPS_PRO = @as(c_int, 45);
pub const Z_COMPILER_MIRACLE_C = @as(c_int, 46);
pub const Z_COMPILER_MPW_CPP = @as(c_int, 47);
pub const Z_COMPILER_MSC = @as(c_int, 48);
pub const Z_COMPILER_MSVC = @as(c_int, 49);
pub const Z_COMPILER_NDP_C = @as(c_int, 50);
pub const Z_COMPILER_NORCROFT_C = @as(c_int, 51);
pub const Z_COMPILER_NVC = @as(c_int, 52);
pub const Z_COMPILER_NWCC = @as(c_int, 53);
pub const Z_COMPILER_OPEN64 = @as(c_int, 54);
pub const Z_COMPILER_ORACLE_PRO_C_PRECOMPILER = @as(c_int, 55);
pub const Z_COMPILER_ORACLE_SOLARIS_STUDIO = @as(c_int, 56);
pub const Z_COMPILER_PACIFIC_C = @as(c_int, 57);
pub const Z_COMPILER_PALM_C_CPP = @as(c_int, 58);
pub const Z_COMPILER_PCC = @as(c_int, 59);
pub const Z_COMPILER_PELLES_C = @as(c_int, 60);
pub const Z_COMPILER_PGI_C_CPP = @as(c_int, 61);
pub const Z_COMPILER_RENESAS_C_CPP = @as(c_int, 62);
pub const Z_COMPILER_SAS_C = @as(c_int, 63);
pub const Z_COMPILER_SCCZ80 = @as(c_int, 64);
pub const Z_COMPILER_SDCC = @as(c_int, 65);
pub const Z_COMPILER_SNC = @as(c_int, 66);
pub const Z_COMPILER_SYMANTEC_CPP = @as(c_int, 67);
pub const Z_COMPILER_SYSTEMS_C = @as(c_int, 68);
pub const Z_COMPILER_TENDRA = @as(c_int, 69);
pub const Z_COMPILER_THINK_C = @as(c_int, 70);
pub const Z_COMPILER_TI_C_CPP_COMPILER = @as(c_int, 71);
pub const Z_COMPILER_TINY_CC = @as(c_int, 72);
pub const Z_COMPILER_TURBO_C = @as(c_int, 73);
pub const Z_COMPILER_TURBO_CPP = @as(c_int, 74);
pub const Z_COMPILER_ULTRA_C_CPP = @as(c_int, 75);
pub const Z_COMPILER_USL = @as(c_int, 76);
pub const Z_COMPILER_VBCC = @as(c_int, 77);
pub const Z_COMPILER_VOS_C = @as(c_int, 78);
pub const Z_COMPILER_VOS_STANDARD_C = @as(c_int, 79);
pub const Z_COMPILER_WATCOM_C_CPP = @as(c_int, 80);
pub const Z_COMPILER_ZORTECH_CPP = @as(c_int, 81);
pub const Z_COMPILER_NAME_ACC = "ACC";
pub const Z_COMPILER_NAME_ALTIUM_C_TO_HARDWARE = "Altium C-to-Hardware";
pub const Z_COMPILER_NAME_ALTIUM_MICROBLAZE_C = "Altium MicroBlaze C";
pub const Z_COMPILER_NAME_AMSTERDAM_COMPILER_KIT = "Amsterdam Compiler Kit";
pub const Z_COMPILER_NAME_APPLE_CLANG = "Apple Clang";
pub const Z_COMPILER_NAME_ARM_C_CPP_COMPILER = "ARM C/C++ Compiler";
pub const Z_COMPILER_NAME_ARM_COMPILER = "ARM Compiler";
pub const Z_COMPILER_NAME_AZTEC_C = "Aztec C";
pub const Z_COMPILER_NAME_BCC = "BCC";
pub const Z_COMPILER_NAME_CC65 = "cc65";
pub const Z_COMPILER_NAME_CLANG = "Clang";
pub const Z_COMPILER_NAME_CODE_WARRIOR = "CodeWarrior";
pub const Z_COMPILER_NAME_COMEAU_CPP = "Comeau C++ ";
pub const Z_COMPILER_NAME_COMPAQ_C_CPP = "Compaq C/C++";
pub const Z_COMPILER_NAME_COMPCERT = "CompCert";
pub const Z_COMPILER_NAME_CONVEX_C = "Convex C";
pub const Z_COMPILER_NAME_COVERITY_C_CPP_STATIC_ANALYZER = "Coverity C/C++ Static Analyzer";
pub const Z_COMPILER_NAME_CRAY_C = "Cray C";
pub const Z_COMPILER_NAME_DIAB_C_CPP = "Diab C/C++";
pub const Z_COMPILER_NAME_DICE_C = "DICE C";
pub const Z_COMPILER_NAME_DIGITAL_MARS = "Digital Mars";
pub const Z_COMPILER_NAME_DJGPP = "DJGPP";
pub const Z_COMPILER_NAME_EDG_CPP_FRONTEND = "EDG C++ Frontend";
pub const Z_COMPILER_NAME_EKOPATH = "EKOPath";
pub const Z_COMPILER_NAME_FUJITSU_CPP = "Fujitsu C++";
pub const Z_COMPILER_NAME_GCC = "GCC";
pub const Z_COMPILER_NAME_GREEN_HILL_C_CPP = "Green Hill C/C++";
pub const Z_COMPILER_NAME_HP_ACPP = "HP aC++";
pub const Z_COMPILER_NAME_HP_ANSI_C = "HP ANSI C";
pub const Z_COMPILER_NAME_HP_UPC = "HP UPC";
pub const Z_COMPILER_NAME_IAR_C_CPP = "IAR C/C++";
pub const Z_COMPILER_NAME_IBM_XL_C_CPP = "IBM XL C/C++";
pub const Z_COMPILER_NAME_IBM_Z_OS_C_CPP = "IBM z/OS C/C++";
pub const Z_COMPILER_NAME_IMAGECRAFT_C = "ImageCraft C";
pub const Z_COMPILER_NAME_INTEL_CPP = "Intel C++";
pub const Z_COMPILER_NAME_KAI_CPP = "KAI C++";
pub const Z_COMPILER_NAME_KEIL_C166 = "KEIL C166";
pub const Z_COMPILER_NAME_KEIL_C51 = "KEIL C51";
pub const Z_COMPILER_NAME_KEIL_CARM = "KEIL CARM";
pub const Z_COMPILER_NAME_LCC = "LCC";
pub const Z_COMPILER_NAME_MCC = "MCC";
pub const Z_COMPILER_NAME_METAWARE_HIGH_C_CPP = "MetaWare High C/C++";
pub const Z_COMPILER_NAME_MICROTEC_C_CPP = "Microtec C/C++";
pub const Z_COMPILER_NAME_MINGW = "MinGW";
pub const Z_COMPILER_NAME_MIPS_PRO = "MIPSpro";
pub const Z_COMPILER_NAME_MIRACLE_C = "Miracle C";
pub const Z_COMPILER_NAME_MPW_CPP = "MPW C++";
pub const Z_COMPILER_NAME_MSC = "Microsoft C/C++";
pub const Z_COMPILER_NAME_MSVC = "Microsoft Visual C++";
pub const Z_COMPILER_NAME_NDP_C = "NDP C";
pub const Z_COMPILER_NAME_NORCROFT_C = "Norcroft C";
pub const Z_COMPILER_NAME_NVC = "NVC";
pub const Z_COMPILER_NAME_NWCC = "NWCC";
pub const Z_COMPILER_NAME_OPEN64 = "Open64";
pub const Z_COMPILER_NAME_ORACLE_PRO_C_PRECOMPILER = "Oracle Pro*C Precompiler";
pub const Z_COMPILER_NAME_ORACLE_SOLARIS_STUDIO = "Oracle Solaris Studio";
pub const Z_COMPILER_NAME_PACIFIC_C = "Pacific C";
pub const Z_COMPILER_NAME_PALM_C_CPP = "Palm C/C++";
pub const Z_COMPILER_NAME_PCC = "PCC";
pub const Z_COMPILER_NAME_PELLES_C = "Pelles C";
pub const Z_COMPILER_NAME_PGI_C_CPP = "PGI C/C++";
pub const Z_COMPILER_NAME_RENESAS_C_CPP = "Renesas C/C++";
pub const Z_COMPILER_NAME_SAS_C = "SAS/C";
pub const Z_COMPILER_NAME_SCCZ80 = "SCCZ80";
pub const Z_COMPILER_NAME_SDCC = "SDCC";
pub const Z_COMPILER_NAME_SNC = "SNC";
pub const Z_COMPILER_NAME_SYMANTEC_CPP = "Symantec C++";
pub const Z_COMPILER_NAME_SYSTEMS_C = "Systems/C";
pub const Z_COMPILER_NAME_TENDRA = "TenDRA";
pub const Z_COMPILER_NAME_THINK_C = "THINK C";
pub const Z_COMPILER_NAME_TI_C_CPP_COMPILER = "Texas Instruments C/C++ Compiler";
pub const Z_COMPILER_NAME_TINY_CC = "TinyCC";
pub const Z_COMPILER_NAME_TURBO_C = "Turbo C";
pub const Z_COMPILER_NAME_TURBO_CPP = "Turbo C++";
pub const Z_COMPILER_NAME_ULTRA_C_CPP = "Ultra C/C++";
pub const Z_COMPILER_NAME_USL = "USL";
pub const Z_COMPILER_NAME_VBCC = "vbcc";
pub const Z_COMPILER_NAME_VOS_C = "VOS C";
pub const Z_COMPILER_NAME_VOS_STANDARD_C = "VOS Standard C";
pub const Z_COMPILER_NAME_WATCOM_C_CPP = "Watcom C/C++";
pub const Z_COMPILER_NAME_ZORTECH_CPP = "Zortech C++";
pub const Z_COMPILER_FORTE_DEVELOPER = Z_COMPILER_ORACLE_SOLARIS_STUDIO;
pub const Z_COMPILER_SUN_PRO_COMPILERS = Z_COMPILER_ORACLE_SOLARIS_STUDIO;
pub const Z_COMPILER_SUN_STUDIO = Z_COMPILER_ORACLE_SOLARIS_STUDIO;
pub const Z_COMPILER_SUN_WORK_SHOP = Z_COMPILER_ORACLE_SOLARIS_STUDIO;
pub const Z_COMPILER_SYSTEMS_CPP = Z_COMPILER_SYSTEMS_C;
pub const Z_COMPILER_VISUAL_AGE_CPP = Z_COMPILER_IBM_XL_C_CPP;
pub const Z_COMPILER_NAME_FORTE_DEVELOPER = "Forte Developer";
pub const Z_COMPILER_NAME_SUN_PRO_COMPILERS = "SunPro Compilers";
pub const Z_COMPILER_NAME_SUN_STUDIO = "Sun Studio";
pub const Z_COMPILER_NAME_SUN_WORK_SHOP = "Sun WorkShop";
pub const Z_COMPILER_NAME_SYSTEMS_CPP = "Systems/C++";
pub const Z_COMPILER_NAME_VISUAL_AGE_CPP = "VisualAge C++";
pub const Z_macros_version_H = "";
pub inline fn Z_VERSION(major: anytype, minor: anytype, micro: anytype) @TypeOf(((major * @as(c_ulong, 4194304)) + (minor * @as(c_ulong, 4096))) + micro) {
    _ = &major;
    _ = &minor;
    _ = &micro;
    return ((major * @as(c_ulong, 4194304)) + (minor * @as(c_ulong, 4096))) + micro;
}
pub inline fn Z_VERSION_MAJOR(version: anytype) @TypeOf(@import("std").zig.c_translation.MacroArithmetic.div(version, @as(c_ulong, 4194304))) {
    _ = &version;
    return @import("std").zig.c_translation.MacroArithmetic.div(version, @as(c_ulong, 4194304));
}
pub inline fn Z_VERSION_MINOR(version: anytype) @TypeOf(@import("std").zig.c_translation.MacroArithmetic.div(@import("std").zig.c_translation.MacroArithmetic.rem(version, @as(c_ulong, 4194304)), @as(c_ulong, 4096))) {
    _ = &version;
    return @import("std").zig.c_translation.MacroArithmetic.div(@import("std").zig.c_translation.MacroArithmetic.rem(version, @as(c_ulong, 4194304)), @as(c_ulong, 4096));
}
pub inline fn Z_VERSION_MICRO(version: anytype) @TypeOf(version & @as(c_ulong, 0xFFF)) {
    _ = &version;
    return version & @as(c_ulong, 0xFFF);
}
pub const Z_COMPILER_IS = @compileError("unable to translate macro: undefined identifier `Z_COMPILER_IS_`");
// /opt/homebrew/include/Z/inspection/compiler.h:16:9
pub const Z_COMPILER_DIALECT_HAS = @compileError("unable to translate macro: undefined identifier `Z_COMPILER_HAS_`");
// /opt/homebrew/include/Z/inspection/compiler.h:18:9
pub const Z_COMPILER_DIALECT_HAS_ATTRIBUTE = @compileError("unable to translate macro: undefined identifier `Z_COMPILER_HAS_`");
// /opt/homebrew/include/Z/inspection/compiler.h:19:9
pub const Z_COMPILER_DIALECT_HAS_ESCAPE_SEQUENCE = @compileError("unable to translate macro: undefined identifier `Z_COMPILER_HAS_`");
// /opt/homebrew/include/Z/inspection/compiler.h:20:9
pub const Z_COMPILER_DIALECT_HAS_IDENTIFIER = @compileError("unable to translate macro: undefined identifier `Z_COMPILER_HAS_`");
// /opt/homebrew/include/Z/inspection/compiler.h:21:9
pub const Z_COMPILER_DIALECT_HAS_LITERAL = @compileError("unable to translate macro: undefined identifier `Z_COMPILER_HAS_`");
// /opt/homebrew/include/Z/inspection/compiler.h:22:9
pub const Z_COMPILER_DIALECT_HAS_OPERATOR = @compileError("unable to translate macro: undefined identifier `Z_COMPILER_HAS_`");
// /opt/homebrew/include/Z/inspection/compiler.h:23:9
pub const Z_COMPILER_DIALECT_HAS_OPERATOR_CASE = @compileError("unable to translate macro: undefined identifier `Z_COMPILER_HAS_`");
// /opt/homebrew/include/Z/inspection/compiler.h:24:9
pub const Z_COMPILER_DIALECT_HAS_PREPROCESSOR_DIRECTIVE = @compileError("unable to translate macro: undefined identifier `Z_COMPILER_HAS_`");
// /opt/homebrew/include/Z/inspection/compiler.h:25:9
pub const Z_COMPILER_DIALECT_HAS_PREPROCESSOR_IDENTIFIER = @compileError("unable to translate macro: undefined identifier `Z_COMPILER_HAS_`");
// /opt/homebrew/include/Z/inspection/compiler.h:26:9
pub const Z_COMPILER_DIALECT_HAS_PREPROCESSOR_OPERATOR = @compileError("unable to translate macro: undefined identifier `Z_COMPILER_HAS_`");
// /opt/homebrew/include/Z/inspection/compiler.h:27:9
pub const Z_COMPILER_DIALECT_HAS_SPECIFIER = @compileError("unable to translate macro: undefined identifier `Z_COMPILER_HAS_`");
// /opt/homebrew/include/Z/inspection/compiler.h:28:9
pub const Z_COMPILER_DIALECT_HAS_SPECIFIER_CASE = @compileError("unable to translate macro: undefined identifier `Z_COMPILER_HAS_`");
// /opt/homebrew/include/Z/inspection/compiler.h:29:9
pub const Z_COMPILER_DIALECT_HAS_STD_PRAGMA = @compileError("unable to translate macro: undefined identifier `Z_COMPILER_HAS_`");
// /opt/homebrew/include/Z/inspection/compiler.h:30:9
pub const Z_COMPILER_DIALECT_HAS_STORAGE_CLASS = @compileError("unable to translate macro: undefined identifier `Z_COMPILER_HAS_`");
// /opt/homebrew/include/Z/inspection/compiler.h:31:9
pub const Z_COMPILER_DIALECT_HAS_TYPE = @compileError("unable to translate macro: undefined identifier `Z_COMPILER_HAS_`");
// /opt/homebrew/include/Z/inspection/compiler.h:32:9
pub const Z_COMPILER_DIALECT_HAS_TYPE_MODIFIER = @compileError("unable to translate macro: undefined identifier `Z_COMPILER_HAS_`");
// /opt/homebrew/include/Z/inspection/compiler.h:33:9
pub const Z_COMPILER_DIALECT_HAS_TYPE_QUALIFIER = @compileError("unable to translate macro: undefined identifier `Z_COMPILER_HAS_`");
// /opt/homebrew/include/Z/inspection/compiler.h:34:9
pub const Z_COMPILER_HAS = @compileError("unable to translate macro: undefined identifier `Z_COMPILER_HAS_`");
// /opt/homebrew/include/Z/inspection/compiler.h:36:9
pub const Z_COMPILER_HAS_ATTRIBUTE = @compileError("unable to translate macro: undefined identifier `Z_COMPILER_HAS_ATTRIBUTE_`");
// /opt/homebrew/include/Z/inspection/compiler.h:37:9
pub const Z_COMPILER_HAS_CONSTANT = @compileError("unable to translate macro: undefined identifier `Z_COMPILER_HAS_CONSTANT_`");
// /opt/homebrew/include/Z/inspection/compiler.h:38:9
pub const Z_COMPILER_HAS_FUNCTION = @compileError("unable to translate macro: undefined identifier `Z_COMPILER_HAS_FUNCTION_`");
// /opt/homebrew/include/Z/inspection/compiler.h:39:9
pub const Z_COMPILER_HAS_LITERAL = @compileError("unable to translate macro: undefined identifier `Z_COMPILER_HAS_LITERAL_`");
// /opt/homebrew/include/Z/inspection/compiler.h:40:9
pub const Z_COMPILER_HAS_MACRO = @compileError("unable to translate macro: undefined identifier `Z_COMPILER_HAS_MACRO_`");
// /opt/homebrew/include/Z/inspection/compiler.h:41:9
pub const Z_COMPILER_HAS_MAGIC_CONSTANT = @compileError("unable to translate macro: undefined identifier `Z_COMPILER_HAS_MAGIC_CONSTANT_`");
// /opt/homebrew/include/Z/inspection/compiler.h:42:9
pub const Z_COMPILER_HAS_TRAIT = @compileError("unable to translate macro: undefined identifier `Z_COMPILER_HAS_TRAIT_`");
// /opt/homebrew/include/Z/inspection/compiler.h:43:9
pub const Z_COMPILER_HAS_TYPE = @compileError("unable to translate macro: undefined identifier `Z_COMPILER_HAS_TYPE_`");
// /opt/homebrew/include/Z/inspection/compiler.h:44:9
pub const Z_COMPILER_ATTRIBUTE = @compileError("unable to translate macro: undefined identifier `Z_COMPILER_ATTRIBUTE_`");
// /opt/homebrew/include/Z/inspection/compiler.h:45:9
pub const Z_COMPILER_CONSTANT = @compileError("unable to translate macro: undefined identifier `Z_COMPILER_CONSTANT_`");
// /opt/homebrew/include/Z/inspection/compiler.h:46:9
pub const Z_COMPILER_FUNCTION = @compileError("unable to translate macro: undefined identifier `Z_COMPILER_FUNCTION_`");
// /opt/homebrew/include/Z/inspection/compiler.h:47:9
pub const Z_COMPILER_LITERAL = @compileError("unable to translate macro: undefined identifier `Z_COMPILER_LITERAL_`");
// /opt/homebrew/include/Z/inspection/compiler.h:48:9
pub const Z_COMPILER_MACRO = @compileError("unable to translate macro: undefined identifier `Z_COMPILER_MACRO_`");
// /opt/homebrew/include/Z/inspection/compiler.h:49:9
pub const Z_COMPILER_MAGIC_CONSTANT = @compileError("unable to translate macro: undefined identifier `Z_COMPILER_MAGIC_CONSTANT_`");
// /opt/homebrew/include/Z/inspection/compiler.h:50:9
pub const Z_COMPILER_TRAIT = @compileError("unable to translate macro: undefined identifier `Z_COMPILER_TRAIT_`");
// /opt/homebrew/include/Z/inspection/compiler.h:51:9
pub const Z_COMPILER_TYPE = @compileError("unable to translate macro: undefined identifier `Z_COMPILER_TYPE_`");
// /opt/homebrew/include/Z/inspection/compiler.h:52:9
pub const Z_inspection_compiler_detection_H = "";
pub const Z_COMPILER = Z_COMPILER_CLANG;
pub const Z_inspection_compiler_modules_Clang_H = "";
pub const Z_COMPILER_IS_CLANG = @as(c_int, 1);
pub const Z_COMPILER_NAME = Z_COMPILER_NAME_CLANG;
pub const Z_COMPILER_VERSION = Z_VERSION(__clang_major__, __clang_minor__, __clang_patchlevel__);
pub const Z_COMPILER_VERSION_STRING = __clang_version__;
pub const Z_z_HAS_ATTRIBUTE = @compileError("unable to translate macro: undefined identifier `__has_attribute`");
// /opt/homebrew/include/Z/inspection/compiler/modules/Clang.h:79:10
pub inline fn Z_z_HAS_CPP_ATTRIBUTE(which: anytype) @TypeOf(@as(c_int, 0)) {
    _ = &which;
    return @as(c_int, 0);
}
pub const Z_z_HAS_EXTENSION = @compileError("unable to translate macro: undefined identifier `__has_extension`");
// /opt/homebrew/include/Z/inspection/compiler/modules/Clang.h:91:10
pub const Z_z_HAS_MSVC_COMPATIBILITY = @as(c_int, 0);
pub const Z_z_HAS_GNU_EXTENSIONS = @as(c_int, 1);
pub const Z_z_HAS_TRAIT = @compileError("unable to translate macro: undefined identifier `__`");
// /opt/homebrew/include/Z/inspection/compiler/modules/Clang.h:126:10
pub const Z_COMPILER_ISA = Z_ISA_AARCH64;
pub const Z_COMPILER_ISA_INTEGRAL_ENDIANNESS = Z_ENDIANNESS_LITTLE;
pub const Z_COMPILER_BIT_FIELD_ORDER_ALL = @compileError("unable to translate macro: undefined identifier `Z_ORDER_REVERSED`");
// /opt/homebrew/include/Z/inspection/compiler/modules/Clang.h:300:11
pub const Z_COMPILER_OS = @compileError("unable to translate macro: undefined identifier `Z_OS_MAC_OS_X`");
// /opt/homebrew/include/Z/inspection/compiler/modules/Clang.h:362:11
pub const Z_COMPILER_DATA_MODEL = Z_DATA_MODEL_LP64;
pub const Z_COMPILER_FIXED_FUNDAMENTAL_FLOAT = Z_FUNDAMENTAL_BFP32;
pub const Z_COMPILER_FIXED_FUNDAMENTAL_DOUBLE = Z_FUNDAMENTAL_BFP64;
pub const Z_COMPILER_FIXED_FUNDAMENTAL_LDOUBLE = Z_FUNDAMENTAL_BFP64;
pub const Z_COMPILER_HAS_C_OLD_STYLE_FUNCTION = @as(c_int, 1);
pub const Z_COMPILER_HAS_C_OPERATOR_SIZEOF = @as(c_int, 1);
pub const Z_COMPILER_HAS_C_STORAGE_CLASS_EXTERN = @as(c_int, 1);
pub const Z_COMPILER_HAS_C_STORAGE_CLASS_STATIC = @as(c_int, 1);
pub const Z_COMPILER_HAS_C_STORAGE_CLASS_REGISTER = @as(c_int, 1);
pub const Z_COMPILER_HAS_C_TYPE_DOUBLE = @as(c_int, 1);
pub const Z_COMPILER_HAS_C_TYPE_FLOAT = @as(c_int, 1);
pub const Z_COMPILER_HAS_C89_CONSTANT_INITIALIZATION_FOR_LOCAL_AGGREGATE = @as(c_int, 1);
pub const Z_COMPILER_HAS_C89_CONSTANT_INITIALIZATION_FOR_UNION = @as(c_int, 1);
pub const Z_COMPILER_HAS_C89_CONSTRUCT_AS_FUNCTION_ARGUMENT = @as(c_int, 1);
pub const Z_COMPILER_HAS_C89_CONSTRUCT_RETURN = @as(c_int, 1);
pub const Z_COMPILER_HAS_C89_CONSTRUCT_ASSIGNMENT = @as(c_int, 1);
pub const Z_COMPILER_HAS_C89_CONSTRUCT_NAMESPACE = @as(c_int, 1);
pub const Z_COMPILER_HAS_C89_ENUMERATION = @as(c_int, 1);
pub const Z_COMPILER_HAS_C89_FUNCTION_POINTER_AUTODEREFERENCING = @as(c_int, 1);
pub const Z_COMPILER_HAS_C89_FUNCTION_PROTOTYPE = @as(c_int, 1);
pub const Z_COMPILER_HAS_C89_INTEGRAL_SWITCH = @as(c_int, 1);
pub const Z_COMPILER_HAS_C89_PREPROCESSOR_INDENTATION = @as(c_int, 1);
pub const Z_COMPILER_HAS_C89_REMOVAL_OF_ENTRY_AS_KEYWORD = @as(c_int, 1);
pub const Z_COMPILER_HAS_C89_REMOVAL_OF_LONG_FLOAT_AS_TYPE = @as(c_int, 1);
pub const Z_COMPILER_HAS_C89_STRING_LITERAL_CONCATENATION = @as(c_int, 1);
pub const Z_COMPILER_HAS_C89_VALUE_PRESERVING_UNSIGNED_CONVERSION = @as(c_int, 1);
pub const Z_COMPILER_HAS_C89_ESCAPE_SEQUENCE_ALERT = @as(c_int, 1);
pub const Z_COMPILER_HAS_C89_ESCAPE_SEQUENCE_HEXADECIMAL = @as(c_int, 1);
pub const Z_COMPILER_HAS_C89_ESCAPE_SEQUENCE_VERTICAL_TAB = @as(c_int, 1);
pub const Z_COMPILER_HAS_C89_LITERAL_UNSIGNED = @as(c_int, 1);
pub const Z_COMPILER_HAS_C89_LITERAL_WCHAR_T_CHARACTER = @as(c_int, 1);
pub const Z_COMPILER_HAS_C89_LITERAL_WCHAR_T_STRING = @as(c_int, 1);
pub const Z_COMPILER_HAS_C89_OPERATOR_UNARY_PLUS = @as(c_int, 1);
pub const Z_COMPILER_HAS_C89_PREPROCESSOR_DIRECTIVE_NULL = @as(c_int, 1);
pub const Z_COMPILER_HAS_C89_PREPROCESSOR_DIRECTIVE_ELIF = @as(c_int, 1);
pub const Z_COMPILER_HAS_C89_PREPROCESSOR_DIRECTIVE_ERROR = @as(c_int, 1);
pub const Z_COMPILER_HAS_C89_PREPROCESSOR_DIRECTIVE_LINE = @as(c_int, 1);
pub const Z_COMPILER_HAS_C89_PREPROCESSOR_DIRECTIVE_PRAGMA = @as(c_int, 1);
pub const Z_COMPILER_HAS_C89_PREPROCESSOR_OPERATOR_DEFINED = @as(c_int, 1);
pub const Z_COMPILER_HAS_C89_PREPROCESSOR_OPERATOR_PASTING = @as(c_int, 1);
pub const Z_COMPILER_HAS_C89_PREPROCESSOR_OPERATOR_STRINGIZING = @as(c_int, 1);
pub const Z_COMPILER_HAS_C89_TYPE_UNSIGNED_CHAR = @as(c_int, 1);
pub const Z_COMPILER_HAS_C89_TYPE_UNSIGNED_LONG = @as(c_int, 1);
pub const Z_COMPILER_HAS_C89_TYPE_UNSIGNED_SHORT = @as(c_int, 1);
pub const Z_COMPILER_HAS_C89_TYPE_VOID = @as(c_int, 1);
pub const Z_COMPILER_HAS_C89_TYPE_VOID_POINTER = @as(c_int, 1);
pub const Z_COMPILER_HAS_C89_TYPE_MODIFIER_SIGNED = @as(c_int, 1);
pub const Z_COMPILER_HAS_C89_TYPE_QUALIFIER_CONST = @as(c_int, 1);
pub const Z_COMPILER_HAS_C89_TYPE_QUALIFIER_VOLATILE = @as(c_int, 1);
pub const Z_COMPILER_HAS_C89_LITERAL_FLOAT = @as(c_int, 1);
pub const Z_COMPILER_HAS_C89_TYPE_LONG_DOUBLE = @as(c_int, 1);
pub const Z_COMPILER_HAS_C95_DIGRAPHS = @as(c_int, 1);
pub const Z_COMPILER_HAS_C99_PREPROCESSOR_ARITHMETIC_DONE_IN_INTMAX = @as(c_int, 1);
pub const Z_COMPILER_HAS_C99_RELIABLE_INTEGER_DIVISION = @as(c_int, 1);
pub const Z_COMPILER_HAS_C99_REMOVAL_OF_ILL_FORMED_RETURN = @as(c_int, 1);
pub const Z_COMPILER_HAS_C99_REMOVAL_OF_IMPLICIT_FUNCTION_DECLARATION = @as(c_int, 1);
pub const Z_COMPILER_HAS_C99_REMOVAL_OF_IMPLICIT_INT = @as(c_int, 1);
pub const Z_COMPILER_HAS_C99_IDENTIFIER_FUNC = @as(c_int, 1);
pub const Z_COMPILER_HAS_C99_PREPROCESSOR_OPERATOR_PRAGMA = @as(c_int, 1);
pub const Z_COMPILER_HAS_C99_STD_PRAGMA_CX_LIMITED_RANGE = @as(c_int, 1);
pub const Z_COMPILER_HAS_C99_STD_PRAGMA_FP_CONTRACT = @as(c_int, 1);
pub const Z_COMPILER_HAS_C99_COMPOUND_LITERAL = @as(c_int, 1);
pub const Z_COMPILER_HAS_C99_DESIGNATED_INITIALIZATION = @as(c_int, 1);
pub const Z_COMPILER_HAS_C99_FLEXIBLE_ARRAY_MEMBER = @as(c_int, 1);
pub const Z_COMPILER_HAS_C99_STATIC_IN_ARRAY_PARAMETER_DECLARATION = @as(c_int, 1);
pub const Z_COMPILER_HAS_C99_TYPE_QUALIFIERS_IN_ARRAY_PARAMETER_DECLARATION = @as(c_int, 1);
pub const Z_COMPILER_HAS_C99_TYPE_QUALIFIER_RESTRICT = @as(c_int, 1);
pub const Z_COMPILER_HAS_C99_VLA = @as(c_int, 1);
pub const Z_COMPILER_HAS_C99_CONVERSION_OF_NON_LVALUE_ARRAY_TO_POINTER = @as(c_int, 1);
pub const Z_COMPILER_HAS_C99_FOR_WITH_DECLARATION = @as(c_int, 1);
pub const Z_COMPILER_HAS_C99_MIXED_DECLARATIONS_AND_CODE = @as(c_int, 1);
pub const Z_COMPILER_HAS_C99_NON_CONSTANT_INITIALIZATION_FOR_LOCAL_AGGREGATE = @as(c_int, 1);
pub const Z_COMPILER_HAS_C99_UNIVERSAL_CHARACTER_NAME = @as(c_int, 1);
pub const Z_COMPILER_HAS_C99_SPECIFIER_INLINE = @as(c_int, 1);
pub const Z_COMPILER_HAS_C99_CPP_STYLE_COMMENT = @as(c_int, 1);
pub const Z_COMPILER_HAS_C99_EMPTY_MACRO_ARGUMENT = @as(c_int, 1);
pub const Z_COMPILER_HAS_C99_VARIADIC_MACRO = @as(c_int, 1);
pub const Z_COMPILER_HAS_C99_TYPE_LONG_LONG = @as(c_int, 1);
pub const Z_COMPILER_HAS_C99_EXTENDED_IDENTIFIER = @as(c_int, 1);
pub const Z_COMPILER_HAS_C99_TRAILING_COMMA_ALLOWED_IN_ENUMERATION = @as(c_int, 1);
pub const Z_COMPILER_HAS_C99_LITERAL_HEXADECIMAL_FLOATING_POINT = @as(c_int, 1);
pub const Z_COMPILER_HAS_C99_TYPE_BOOL = @as(c_int, 1);
pub const Z_COMPILER_HAS_C99_TYPE_MODIFIER_COMPLEX = @as(c_int, 1);
pub const Z_COMPILER_HAS_C99_TYPE_DOUBLE_COMPLEX = @as(c_int, 1);
pub const Z_COMPILER_HAS_C99_TYPE_FLOAT_COMPLEX = @as(c_int, 1);
pub const Z_COMPILER_HAS_C99_TYPE_LONG_DOUBLE_COMPLEX = @as(c_int, 1);
pub const Z_COMPILER_HAS_C11_ANONYMOUS_STRUCTURE_AS_MEMBER = @as(c_int, 1);
pub const Z_COMPILER_HAS_C11_STORAGE_CLASS_THREAD_LOCAL = @as(c_int, 1);
pub const Z_COMPILER_HAS_C11_SPECIFIER_ALIGNAS = @as(c_int, 1);
pub const Z_COMPILER_HAS_C11_SPECIFIER_NORETURN = @as(c_int, 1);
pub const Z_COMPILER_HAS_C11_TYPE_QUALIFIER_ATOMIC = @as(c_int, 1);
pub const Z_COMPILER_HAS_C11_ANONYMOUS_UNION_AS_MEMBER = @as(c_int, 1);
pub const Z_COMPILER_HAS_C11_GENERIC_SELECTION = @as(c_int, 1);
pub const Z_COMPILER_HAS_C11_STATIC_ASSERTION = @as(c_int, 1);
pub const Z_COMPILER_HAS_C11_TYPEDEF_REDECLARATION = @as(c_int, 1);
pub const Z_COMPILER_HAS_C11_LITERAL_CHAR16_T_CHARACTER = @as(c_int, 1);
pub const Z_COMPILER_HAS_C11_LITERAL_CHAR16_T_STRING = @as(c_int, 1);
pub const Z_COMPILER_HAS_C11_LITERAL_CHAR32_T_CHARACTER = @as(c_int, 1);
pub const Z_COMPILER_HAS_C11_LITERAL_CHAR32_T_STRING = @as(c_int, 1);
pub const Z_COMPILER_HAS_C11_LITERAL_UTF8_STRING = @as(c_int, 1);
pub const Z_COMPILER_HAS_C11_OPERATOR_ALIGNOF = @as(c_int, 1);
pub const Z_COMPILER_HAS_C11_TYPE_MODIFIER_ATOMIC = @as(c_int, 1);
pub const Z_COMPILER_HAS_APPLE_C_BLOCK_OBJECT = @as(c_int, 1);
pub const Z_COMPILER_HAS_CLANG_C_PREPROCESSOR_OPERATOR_HAS_INCLUDE = @as(c_int, 1);
pub const Z_COMPILER_HAS_ARITHMETIC_RIGHT_SHIFT = @as(c_int, 1);
pub const Z_COMPILER_ATTRIBUTE_ALIAS = @compileError("unable to translate macro: undefined identifier `alias`");
// /opt/homebrew/include/Z/inspection/compiler/modules/Clang.h:1531:10
pub const Z_COMPILER_ATTRIBUTE_MICROSOFT_STD_CALL = @compileError("unable to translate macro: undefined identifier `stdcall`");
// /opt/homebrew/include/Z/inspection/compiler/modules/Clang.h:1543:10
pub const Z_COMPILER_ATTRIBUTE_ALWAYS_INLINE = @compileError("unable to translate macro: undefined identifier `always_inline`");
// /opt/homebrew/include/Z/inspection/compiler/modules/Clang.h:1547:10
pub const Z_COMPILER_ATTRIBUTE_INLINE = @compileError("unable to translate macro: undefined identifier `always_inline`");
// /opt/homebrew/include/Z/inspection/compiler/modules/Clang.h:1548:10
pub const Z_COMPILER_ATTRIBUTE_NO_RETURN = @compileError("unable to translate macro: undefined identifier `noreturn`");
// /opt/homebrew/include/Z/inspection/compiler/modules/Clang.h:1554:10
pub const Z_COMPILER_ATTRIBUTE_NULL_TERMINATED = @compileError("unable to translate macro: undefined identifier `sentinel`");
// /opt/homebrew/include/Z/inspection/compiler/modules/Clang.h:1558:10
pub const Z_COMPILER_ATTRIBUTE_PRIVATE = @compileError("unable to translate macro: undefined identifier `visibility`");
// /opt/homebrew/include/Z/inspection/compiler/modules/Clang.h:1562:10
pub const Z_COMPILER_ATTRIBUTE_PUBLIC = @compileError("unable to translate macro: undefined identifier `visibility`");
// /opt/homebrew/include/Z/inspection/compiler/modules/Clang.h:1563:10
pub const Z_COMPILER_ATTRIBUTE_THREAD_LOCAL = @compileError("unable to translate macro: undefined identifier `__thread`");
// /opt/homebrew/include/Z/inspection/compiler/modules/Clang.h:1567:10
pub const Z_COMPILER_ATTRIBUTE_WEAK = @compileError("unable to translate macro: undefined identifier `weak`");
// /opt/homebrew/include/Z/inspection/compiler/modules/Clang.h:1571:10
pub const Z_COMPILER_PACKED_NAMED_STRUCTURE_BEFORE_TYPE = @compileError("unable to translate macro: undefined identifier `packed`");
// /opt/homebrew/include/Z/inspection/compiler/modules/Clang.h:1580:10
pub const Z_COMPILER_PACKED_NAMED_UNION_BEFORE_TYPE = @compileError("unable to translate macro: undefined identifier `packed`");
// /opt/homebrew/include/Z/inspection/compiler/modules/Clang.h:1581:10
pub const Z_COMPILER_PACKED_STRUCTURE_AFTER_BODY = @compileError("unable to translate macro: undefined identifier `packed`");
// /opt/homebrew/include/Z/inspection/compiler/modules/Clang.h:1582:10
pub const Z_COMPILER_PACKED_UNION_AFTER_BODY = @compileError("unable to translate macro: undefined identifier `packed`");
// /opt/homebrew/include/Z/inspection/compiler/modules/Clang.h:1583:10
pub const Z_COMPILER_TYPE_UINT8 = @compileError("unable to translate C expr: unexpected token '__typeof'");
// /opt/homebrew/include/Z/inspection/compiler/modules/Clang.h:1600:10
pub const Z_COMPILER_TYPE_SINT8 = @compileError("unable to translate C expr: unexpected token '__typeof'");
// /opt/homebrew/include/Z/inspection/compiler/modules/Clang.h:1604:10
pub const Z_COMPILER_TYPE_UINT16 = @compileError("unable to translate C expr: unexpected token '__typeof'");
// /opt/homebrew/include/Z/inspection/compiler/modules/Clang.h:1612:10
pub const Z_COMPILER_TYPE_SINT16 = @compileError("unable to translate C expr: unexpected token '__typeof'");
// /opt/homebrew/include/Z/inspection/compiler/modules/Clang.h:1616:10
pub const Z_COMPILER_TYPE_UINT32 = @compileError("unable to translate C expr: unexpected token '__typeof'");
// /opt/homebrew/include/Z/inspection/compiler/modules/Clang.h:1624:10
pub const Z_COMPILER_TYPE_SINT32 = @compileError("unable to translate C expr: unexpected token '__typeof'");
// /opt/homebrew/include/Z/inspection/compiler/modules/Clang.h:1628:10
pub const Z_COMPILER_TYPE_UINT64 = @compileError("unable to translate C expr: unexpected token '__typeof'");
// /opt/homebrew/include/Z/inspection/compiler/modules/Clang.h:1636:10
pub const Z_COMPILER_TYPE_SINT64 = @compileError("unable to translate C expr: unexpected token '__typeof'");
// /opt/homebrew/include/Z/inspection/compiler/modules/Clang.h:1640:10
pub const Z_COMPILER_TYPE_UINT128 = __uint128_t;
pub const Z_COMPILER_TYPE_SINT128 = __int128_t;
pub const Z_COMPILER_TYPE_VAL = @compileError("unable to translate macro: undefined identifier `__builtin_va_list`");
// /opt/homebrew/include/Z/inspection/compiler/modules/Clang.h:1652:9
pub const Z_COMPILER_LITERAL_UINT16 = @compileError("unable to translate C expr: unexpected token '__extension__'");
// /opt/homebrew/include/Z/inspection/compiler/modules/Clang.h:1655:10
pub const Z_COMPILER_LITERAL_SINT16 = @compileError("unable to translate C expr: unexpected token '__extension__'");
// /opt/homebrew/include/Z/inspection/compiler/modules/Clang.h:1659:10
pub const Z_COMPILER_LITERAL_UINT32 = @compileError("unable to translate C expr: unexpected token '__extension__'");
// /opt/homebrew/include/Z/inspection/compiler/modules/Clang.h:1663:10
pub const Z_COMPILER_LITERAL_SINT32 = @compileError("unable to translate C expr: unexpected token '__extension__'");
// /opt/homebrew/include/Z/inspection/compiler/modules/Clang.h:1667:10
pub const Z_COMPILER_LITERAL_UINT64 = @compileError("unable to translate C expr: unexpected token '__extension__'");
// /opt/homebrew/include/Z/inspection/compiler/modules/Clang.h:1671:10
pub const Z_COMPILER_LITERAL_SINT64 = @compileError("unable to translate C expr: unexpected token '__extension__'");
// /opt/homebrew/include/Z/inspection/compiler/modules/Clang.h:1675:10
pub const Z_COMPILER_CONSTANT_CHAR_WIDTH = __CHAR_BIT__;
pub const Z_COMPILER_CONSTANT_SCHAR_MAXIMUM = __SCHAR_MAX__;
pub const Z_COMPILER_CONSTANT_SHORT_SIZE = __SIZEOF_SHORT__;
pub const Z_COMPILER_CONSTANT_SSHORT_MAXIMUM = __SHRT_MAX__;
pub const Z_COMPILER_CONSTANT_INT_SIZE = __SIZEOF_INT__;
pub const Z_COMPILER_CONSTANT_SINT_MAXIMUM = __INT_MAX__;
pub const Z_COMPILER_CONSTANT_LONG_SIZE = __SIZEOF_LONG__;
pub const Z_COMPILER_CONSTANT_SLONG_MAXIMUM = __LONG_MAX__;
pub const Z_COMPILER_CONSTANT_LLONG_SIZE = __SIZEOF_LONG_LONG__;
pub const Z_COMPILER_CONSTANT_SLLONG_MAXIMUM = __LONG_LONG_MAX__;
pub const Z_COMPILER_CONSTANT_WCHAR_SIZE = __SIZEOF_WCHAR_T__;
pub const Z_COMPILER_CONSTANT_WCHAR_WIDTH = __WCHAR_WIDTH__;
pub const Z_COMPILER_CONSTANT_WCHAR_MAXIMUM = __WCHAR_MAX__;
pub const Z_COMPILER_CONSTANT_SIZE_SIZE = __SIZEOF_SIZE_T__;
pub const Z_COMPILER_CONSTANT_SIZE_WIDTH = __SIZE_WIDTH__;
pub const Z_COMPILER_CONSTANT_USIZE_MAXIMUM = __SIZE_MAX__;
pub const Z_COMPILER_CONSTANT_UINTMAX_WIDTH = __UINTMAX_WIDTH__;
pub const Z_COMPILER_CONSTANT_UINTMAX_MAXIMUM = __UINTMAX_MAX__;
pub const Z_COMPILER_CONSTANT_SINTMAX_WIDTH = __INTMAX_WIDTH__;
pub const Z_COMPILER_CONSTANT_SINTMAX_MAXIMUM = __INTMAX_MAX__;
pub const Z_COMPILER_CONSTANT_UINTPTR_WIDTH = __UINTPTR_WIDTH__;
pub const Z_COMPILER_CONSTANT_UINTPTR_MAXIMUM = __UINTPTR_MAX__;
pub const Z_COMPILER_CONSTANT_SINTPTR_WIDTH = __INTPTR_WIDTH__;
pub const Z_COMPILER_CONSTANT_SINTPTR_MAXIMUM = __INTPTR_MAX__;
pub const Z_COMPILER_CONSTANT_FLOAT_SIZE = __SIZEOF_FLOAT__;
pub const Z_COMPILER_CONSTANT_FLOAT_HUGE = __builtin_huge_valf();
pub const Z_COMPILER_CONSTANT_FLOAT_INFINITY = __builtin_inff();
pub const Z_COMPILER_CONSTANT_FLOAT_QNAN = __builtin_nanf("");
pub const Z_COMPILER_CONSTANT_FLOAT_SNAN = @compileError("unable to translate macro: undefined identifier `__builtin_nansf`");
// /opt/homebrew/include/Z/inspection/compiler/modules/Clang.h:1866:10
pub const Z_COMPILER_CONSTANT_DOUBLE_SIZE = __SIZEOF_DOUBLE__;
pub const Z_COMPILER_CONSTANT_DOUBLE_HUGE = @compileError("unable to translate macro: undefined identifier `__builtin_huge_val`");
// /opt/homebrew/include/Z/inspection/compiler/modules/Clang.h:1876:10
pub const Z_COMPILER_CONSTANT_DOUBLE_INFINITY = @compileError("unable to translate macro: undefined identifier `__builtin_inf`");
// /opt/homebrew/include/Z/inspection/compiler/modules/Clang.h:1880:10
pub const Z_COMPILER_CONSTANT_DOUBLE_QNAN = @compileError("unable to translate macro: undefined identifier `__builtin_nan`");
// /opt/homebrew/include/Z/inspection/compiler/modules/Clang.h:1884:10
pub const Z_COMPILER_CONSTANT_DOUBLE_SNAN = @compileError("unable to translate macro: undefined identifier `__builtin_nans`");
// /opt/homebrew/include/Z/inspection/compiler/modules/Clang.h:1888:10
pub const Z_COMPILER_CONSTANT_LDOUBLE_SIZE = __SIZEOF_LONG_DOUBLE__;
pub const Z_COMPILER_CONSTANT_LDOUBLE_HUGE = @compileError("unable to translate macro: undefined identifier `__builtin_huge_vall`");
// /opt/homebrew/include/Z/inspection/compiler/modules/Clang.h:1896:10
pub const Z_COMPILER_CONSTANT_LDOUBLE_INFINITY = @compileError("unable to translate macro: undefined identifier `__builtin_infl`");
// /opt/homebrew/include/Z/inspection/compiler/modules/Clang.h:1900:10
pub const Z_COMPILER_CONSTANT_LDOUBLE_QNAN = @compileError("unable to translate macro: undefined identifier `__builtin_nanl`");
// /opt/homebrew/include/Z/inspection/compiler/modules/Clang.h:1904:10
pub const Z_COMPILER_CONSTANT_LDOUBLE_SNAN = @compileError("unable to translate macro: undefined identifier `__builtin_nansl`");
// /opt/homebrew/include/Z/inspection/compiler/modules/Clang.h:1908:10
pub const Z_COMPILER_CONSTANT_POINTER_SIZE = __SIZEOF_POINTER__;
pub const Z_COMPILER_CONSTANT_POINTER_WIDTH = __POINTER_WIDTH__;
pub const Z_COMPILER_MACRO_MEMBER_OFFSET = @compileError("unable to translate C expr: unexpected token '__extension__'");
// /opt/homebrew/include/Z/inspection/compiler/modules/Clang.h:2053:9
pub const Z_COMPILER_MACRO_VAL_INITIALIZE = @compileError("unable to translate macro: undefined identifier `__builtin_va_start`");
// /opt/homebrew/include/Z/inspection/compiler/modules/Clang.h:2056:9
pub const Z_COMPILER_MACRO_VAL_FINALIZE = @compileError("unable to translate macro: undefined identifier `__builtin_va_end`");
// /opt/homebrew/include/Z/inspection/compiler/modules/Clang.h:2057:9
pub const Z_COMPILER_MACRO_VAL_READ = @compileError("unable to translate C expr: unexpected token 'an identifier'");
// /opt/homebrew/include/Z/inspection/compiler/modules/Clang.h:2058:9
pub const Z_COMPILER_MACRO_VAL_COPY = @compileError("unable to translate macro: undefined identifier `__builtin_va_copy`");
// /opt/homebrew/include/Z/inspection/compiler/modules/Clang.h:2061:10
pub const Z_COMPILER_FUNCTION_UINT8_ATOMIC_ADD_THEN_GET = @compileError("unable to translate macro: undefined identifier `__sync_add_and_fetch_1`");
// /opt/homebrew/include/Z/inspection/compiler/modules/Clang.h:2067:10
pub const Z_COMPILER_FUNCTION_SINT8_ATOMIC_ADD_THEN_GET = @compileError("unable to translate macro: undefined identifier `__sync_add_and_fetch_1`");
// /opt/homebrew/include/Z/inspection/compiler/modules/Clang.h:2068:10
pub const Z_COMPILER_FUNCTION_UINT8_ATOMIC_AND_THEN_GET = @compileError("unable to translate macro: undefined identifier `__sync_and_and_fetch_1`");
// /opt/homebrew/include/Z/inspection/compiler/modules/Clang.h:2072:10
pub const Z_COMPILER_FUNCTION_SINT8_ATOMIC_AND_THEN_GET = @compileError("unable to translate macro: undefined identifier `__sync_and_and_fetch_1`");
// /opt/homebrew/include/Z/inspection/compiler/modules/Clang.h:2073:10
pub const Z_COMPILER_FUNCTION_UINT8_ATOMIC_GET_THEN_ADD = @compileError("unable to translate macro: undefined identifier `__sync_fetch_and_add_1`");
// /opt/homebrew/include/Z/inspection/compiler/modules/Clang.h:2077:10
pub const Z_COMPILER_FUNCTION_SINT8_ATOMIC_GET_THEN_ADD = @compileError("unable to translate macro: undefined identifier `__sync_fetch_and_add_1`");
// /opt/homebrew/include/Z/inspection/compiler/modules/Clang.h:2078:10
pub const Z_COMPILER_FUNCTION_SINT8_ATOMIC_GET_THEN_AND = @compileError("unable to translate macro: undefined identifier `__sync_fetch_and_and_1`");
// /opt/homebrew/include/Z/inspection/compiler/modules/Clang.h:2082:10
pub const Z_COMPILER_FUNCTION_UINT8_ATOMIC_GET_THEN_AND = @compileError("unable to translate macro: undefined identifier `__sync_fetch_and_and_1`");
// /opt/homebrew/include/Z/inspection/compiler/modules/Clang.h:2083:10
pub const Z_COMPILER_FUNCTION_UINT8_ATOMIC_GET_THEN_NAND = @compileError("unable to translate macro: undefined identifier `__sync_fetch_and_nand_1`");
// /opt/homebrew/include/Z/inspection/compiler/modules/Clang.h:2087:10
pub const Z_COMPILER_FUNCTION_SINT8_ATOMIC_GET_THEN_NAND = @compileError("unable to translate macro: undefined identifier `__sync_fetch_and_nand_1`");
// /opt/homebrew/include/Z/inspection/compiler/modules/Clang.h:2088:10
pub const Z_COMPILER_FUNCTION_UINT8_ATOMIC_GET_THEN_OR = @compileError("unable to translate macro: undefined identifier `__sync_fetch_and_or_1`");
// /opt/homebrew/include/Z/inspection/compiler/modules/Clang.h:2092:10
pub const Z_COMPILER_FUNCTION_SINT8_ATOMIC_GET_THEN_OR = @compileError("unable to translate macro: undefined identifier `__sync_fetch_and_or_1`");
// /opt/homebrew/include/Z/inspection/compiler/modules/Clang.h:2093:10
pub const Z_COMPILER_FUNCTION_UINT8_ATOMIC_GET_THEN_SET_IF_EQUAL = @compileError("unable to translate macro: undefined identifier `__sync_val_compare_and_swap_1`");
// /opt/homebrew/include/Z/inspection/compiler/modules/Clang.h:2097:10
pub const Z_COMPILER_FUNCTION_SINT8_ATOMIC_GET_THEN_SET_IF_EQUAL = @compileError("unable to translate macro: undefined identifier `__sync_val_compare_and_swap_1`");
// /opt/homebrew/include/Z/inspection/compiler/modules/Clang.h:2098:10
pub const Z_COMPILER_FUNCTION_UINT8_ATOMIC_GET_THEN_SUBTRACT = @compileError("unable to translate macro: undefined identifier `__sync_fetch_and_sub_1`");
// /opt/homebrew/include/Z/inspection/compiler/modules/Clang.h:2102:10
pub const Z_COMPILER_FUNCTION_SINT8_ATOMIC_GET_THEN_SUBTRACT = @compileError("unable to translate macro: undefined identifier `__sync_fetch_and_sub_1`");
// /opt/homebrew/include/Z/inspection/compiler/modules/Clang.h:2103:10
pub const Z_COMPILER_FUNCTION_UINT8_ATOMIC_GET_THEN_XOR = @compileError("unable to translate macro: undefined identifier `__sync_fetch_and_xor_1`");
// /opt/homebrew/include/Z/inspection/compiler/modules/Clang.h:2107:10
pub const Z_COMPILER_FUNCTION_SINT8_ATOMIC_GET_THEN_XOR = @compileError("unable to translate macro: undefined identifier `__sync_fetch_and_xor_1`");
// /opt/homebrew/include/Z/inspection/compiler/modules/Clang.h:2108:10
pub const Z_COMPILER_FUNCTION_UINT8_ATOMIC_NAND_THEN_GET = @compileError("unable to translate macro: undefined identifier `__sync_nand_and_fetch_1`");
// /opt/homebrew/include/Z/inspection/compiler/modules/Clang.h:2112:10
pub const Z_COMPILER_FUNCTION_SINT8_ATOMIC_NAND_THEN_GET = @compileError("unable to translate macro: undefined identifier `__sync_nand_and_fetch_1`");
// /opt/homebrew/include/Z/inspection/compiler/modules/Clang.h:2113:10
pub const Z_COMPILER_FUNCTION_UINT8_ATOMIC_OR_THEN_GET = @compileError("unable to translate macro: undefined identifier `__sync_or_and_fetch_1`");
// /opt/homebrew/include/Z/inspection/compiler/modules/Clang.h:2117:10
pub const Z_COMPILER_FUNCTION_SINT8_ATOMIC_OR_THEN_GET = @compileError("unable to translate macro: undefined identifier `__sync_or_and_fetch_1`");
// /opt/homebrew/include/Z/inspection/compiler/modules/Clang.h:2118:10
pub const Z_COMPILER_FUNCTION_UINT8_ATOMIC_SET_IF_EQUAL = @compileError("unable to translate macro: undefined identifier `__sync_bool_compare_and_swap_1`");
// /opt/homebrew/include/Z/inspection/compiler/modules/Clang.h:2122:10
pub const Z_COMPILER_FUNCTION_SINT8_ATOMIC_SET_IF_EQUAL = @compileError("unable to translate macro: undefined identifier `__sync_bool_compare_and_swap_1`");
// /opt/homebrew/include/Z/inspection/compiler/modules/Clang.h:2123:10
pub const Z_COMPILER_FUNCTION_UINT8_ATOMIC_SUBTRACT_THEN_GET = @compileError("unable to translate macro: undefined identifier `__sync_sub_and_fetch_1`");
// /opt/homebrew/include/Z/inspection/compiler/modules/Clang.h:2127:10
pub const Z_COMPILER_FUNCTION_SINT8_ATOMIC_SUBTRACT_THEN_GET = @compileError("unable to translate macro: undefined identifier `__sync_sub_and_fetch_1`");
// /opt/homebrew/include/Z/inspection/compiler/modules/Clang.h:2128:10
pub const Z_COMPILER_FUNCTION_UINT8_ATOMIC_XOR_THEN_GET = @compileError("unable to translate macro: undefined identifier `__sync_xor_and_fetch_1`");
// /opt/homebrew/include/Z/inspection/compiler/modules/Clang.h:2132:10
pub const Z_COMPILER_FUNCTION_SINT8_ATOMIC_XOR_THEN_GET = @compileError("unable to translate macro: undefined identifier `__sync_xor_and_fetch_1`");
// /opt/homebrew/include/Z/inspection/compiler/modules/Clang.h:2133:10
pub const Z_COMPILER_FUNCTION_UINT16_ATOMIC_ADD_THEN_GET = @compileError("unable to translate macro: undefined identifier `__sync_add_and_fetch_2`");
// /opt/homebrew/include/Z/inspection/compiler/modules/Clang.h:2137:10
pub const Z_COMPILER_FUNCTION_SINT16_ATOMIC_ADD_THEN_GET = @compileError("unable to translate macro: undefined identifier `__sync_add_and_fetch_2`");
// /opt/homebrew/include/Z/inspection/compiler/modules/Clang.h:2138:10
pub const Z_COMPILER_FUNCTION_UINT16_ATOMIC_AND_THEN_GET = @compileError("unable to translate macro: undefined identifier `__sync_and_and_fetch_2`");
// /opt/homebrew/include/Z/inspection/compiler/modules/Clang.h:2142:10
pub const Z_COMPILER_FUNCTION_SINT16_ATOMIC_AND_THEN_GET = @compileError("unable to translate macro: undefined identifier `__sync_and_and_fetch_2`");
// /opt/homebrew/include/Z/inspection/compiler/modules/Clang.h:2143:10
pub const Z_COMPILER_FUNCTION_UINT16_ATOMIC_GET_THEN_ADD = @compileError("unable to translate macro: undefined identifier `__sync_fetch_and_add_2`");
// /opt/homebrew/include/Z/inspection/compiler/modules/Clang.h:2147:10
pub const Z_COMPILER_FUNCTION_SINT16_ATOMIC_GET_THEN_ADD = @compileError("unable to translate macro: undefined identifier `__sync_fetch_and_add_2`");
// /opt/homebrew/include/Z/inspection/compiler/modules/Clang.h:2148:10
pub const Z_COMPILER_FUNCTION_SINT16_ATOMIC_GET_THEN_AND = @compileError("unable to translate macro: undefined identifier `__sync_fetch_and_and_2`");
// /opt/homebrew/include/Z/inspection/compiler/modules/Clang.h:2152:10
pub const Z_COMPILER_FUNCTION_UINT16_ATOMIC_GET_THEN_AND = @compileError("unable to translate macro: undefined identifier `__sync_fetch_and_and_2`");
// /opt/homebrew/include/Z/inspection/compiler/modules/Clang.h:2153:10
pub const Z_COMPILER_FUNCTION_UINT16_ATOMIC_GET_THEN_NAND = @compileError("unable to translate macro: undefined identifier `__sync_fetch_and_nand_2`");
// /opt/homebrew/include/Z/inspection/compiler/modules/Clang.h:2157:10
pub const Z_COMPILER_FUNCTION_SINT16_ATOMIC_GET_THEN_NAND = @compileError("unable to translate macro: undefined identifier `__sync_fetch_and_nand_2`");
// /opt/homebrew/include/Z/inspection/compiler/modules/Clang.h:2158:10
pub const Z_COMPILER_FUNCTION_UINT16_ATOMIC_GET_THEN_OR = @compileError("unable to translate macro: undefined identifier `__sync_fetch_and_or_2`");
// /opt/homebrew/include/Z/inspection/compiler/modules/Clang.h:2162:10
pub const Z_COMPILER_FUNCTION_SINT16_ATOMIC_GET_THEN_OR = @compileError("unable to translate macro: undefined identifier `__sync_fetch_and_or_2`");
// /opt/homebrew/include/Z/inspection/compiler/modules/Clang.h:2163:10
pub const Z_COMPILER_FUNCTION_UINT16_ATOMIC_GET_THEN_SET_IF_EQUAL = @compileError("unable to translate macro: undefined identifier `__sync_val_compare_and_swap_2`");
// /opt/homebrew/include/Z/inspection/compiler/modules/Clang.h:2167:10
pub const Z_COMPILER_FUNCTION_SINT16_ATOMIC_GET_THEN_SET_IF_EQUAL = @compileError("unable to translate macro: undefined identifier `__sync_val_compare_and_swap_2`");
// /opt/homebrew/include/Z/inspection/compiler/modules/Clang.h:2168:10
pub const Z_COMPILER_FUNCTION_UINT16_ATOMIC_GET_THEN_SUBTRACT = @compileError("unable to translate macro: undefined identifier `__sync_fetch_and_sub_2`");
// /opt/homebrew/include/Z/inspection/compiler/modules/Clang.h:2172:10
pub const Z_COMPILER_FUNCTION_SINT16_ATOMIC_GET_THEN_SUBTRACT = @compileError("unable to translate macro: undefined identifier `__sync_fetch_and_sub_2`");
// /opt/homebrew/include/Z/inspection/compiler/modules/Clang.h:2173:10
pub const Z_COMPILER_FUNCTION_UINT16_ATOMIC_GET_THEN_XOR = @compileError("unable to translate macro: undefined identifier `__sync_fetch_and_xor_2`");
// /opt/homebrew/include/Z/inspection/compiler/modules/Clang.h:2177:10
pub const Z_COMPILER_FUNCTION_SINT16_ATOMIC_GET_THEN_XOR = @compileError("unable to translate macro: undefined identifier `__sync_fetch_and_xor_2`");
// /opt/homebrew/include/Z/inspection/compiler/modules/Clang.h:2178:10
pub const Z_COMPILER_FUNCTION_UINT16_ATOMIC_NAND_THEN_GET = @compileError("unable to translate macro: undefined identifier `__sync_nand_and_fetch_2`");
// /opt/homebrew/include/Z/inspection/compiler/modules/Clang.h:2182:10
pub const Z_COMPILER_FUNCTION_SINT16_ATOMIC_NAND_THEN_GET = @compileError("unable to translate macro: undefined identifier `__sync_nand_and_fetch_2`");
// /opt/homebrew/include/Z/inspection/compiler/modules/Clang.h:2183:10
pub const Z_COMPILER_FUNCTION_UINT16_ATOMIC_OR_THEN_GET = @compileError("unable to translate macro: undefined identifier `__sync_or_and_fetch_2`");
// /opt/homebrew/include/Z/inspection/compiler/modules/Clang.h:2187:10
pub const Z_COMPILER_FUNCTION_SINT16_ATOMIC_OR_THEN_GET = @compileError("unable to translate macro: undefined identifier `__sync_or_and_fetch_2`");
// /opt/homebrew/include/Z/inspection/compiler/modules/Clang.h:2188:10
pub const Z_COMPILER_FUNCTION_UINT16_ATOMIC_SET_IF_EQUAL = @compileError("unable to translate macro: undefined identifier `__sync_bool_compare_and_swap_2`");
// /opt/homebrew/include/Z/inspection/compiler/modules/Clang.h:2192:10
pub const Z_COMPILER_FUNCTION_SINT16_ATOMIC_SET_IF_EQUAL = @compileError("unable to translate macro: undefined identifier `__sync_bool_compare_and_swap_2`");
// /opt/homebrew/include/Z/inspection/compiler/modules/Clang.h:2193:10
pub const Z_COMPILER_FUNCTION_UINT16_ATOMIC_SUBTRACT_THEN_GET = @compileError("unable to translate macro: undefined identifier `__sync_sub_and_fetch_2`");
// /opt/homebrew/include/Z/inspection/compiler/modules/Clang.h:2197:10
pub const Z_COMPILER_FUNCTION_SINT16_ATOMIC_SUBTRACT_THEN_GET = @compileError("unable to translate macro: undefined identifier `__sync_sub_and_fetch_2`");
// /opt/homebrew/include/Z/inspection/compiler/modules/Clang.h:2198:10
pub const Z_COMPILER_FUNCTION_UINT16_ATOMIC_XOR_THEN_GET = @compileError("unable to translate macro: undefined identifier `__sync_xor_and_fetch_2`");
// /opt/homebrew/include/Z/inspection/compiler/modules/Clang.h:2202:10
pub const Z_COMPILER_FUNCTION_SINT16_ATOMIC_XOR_THEN_GET = @compileError("unable to translate macro: undefined identifier `__sync_xor_and_fetch_2`");
// /opt/homebrew/include/Z/inspection/compiler/modules/Clang.h:2203:10
pub const Z_COMPILER_FUNCTION_UINT32_ATOMIC_ADD_THEN_GET = @compileError("unable to translate macro: undefined identifier `__sync_add_and_fetch_4`");
// /opt/homebrew/include/Z/inspection/compiler/modules/Clang.h:2207:10
pub const Z_COMPILER_FUNCTION_SINT32_ATOMIC_ADD_THEN_GET = @compileError("unable to translate macro: undefined identifier `__sync_add_and_fetch_4`");
// /opt/homebrew/include/Z/inspection/compiler/modules/Clang.h:2208:10
pub const Z_COMPILER_FUNCTION_UINT32_ATOMIC_AND_THEN_GET = @compileError("unable to translate macro: undefined identifier `__sync_and_and_fetch_4`");
// /opt/homebrew/include/Z/inspection/compiler/modules/Clang.h:2212:10
pub const Z_COMPILER_FUNCTION_SINT32_ATOMIC_AND_THEN_GET = @compileError("unable to translate macro: undefined identifier `__sync_and_and_fetch_4`");
// /opt/homebrew/include/Z/inspection/compiler/modules/Clang.h:2213:10
pub const Z_COMPILER_FUNCTION_UINT32_ATOMIC_GET_THEN_ADD = @compileError("unable to translate macro: undefined identifier `__sync_fetch_and_add_4`");
// /opt/homebrew/include/Z/inspection/compiler/modules/Clang.h:2217:10
pub const Z_COMPILER_FUNCTION_SINT32_ATOMIC_GET_THEN_ADD = @compileError("unable to translate macro: undefined identifier `__sync_fetch_and_add_4`");
// /opt/homebrew/include/Z/inspection/compiler/modules/Clang.h:2218:10
pub const Z_COMPILER_FUNCTION_SINT32_ATOMIC_GET_THEN_AND = @compileError("unable to translate macro: undefined identifier `__sync_fetch_and_and_4`");
// /opt/homebrew/include/Z/inspection/compiler/modules/Clang.h:2222:10
pub const Z_COMPILER_FUNCTION_UINT32_ATOMIC_GET_THEN_AND = @compileError("unable to translate macro: undefined identifier `__sync_fetch_and_and_4`");
// /opt/homebrew/include/Z/inspection/compiler/modules/Clang.h:2223:10
pub const Z_COMPILER_FUNCTION_UINT32_ATOMIC_GET_THEN_NAND = @compileError("unable to translate macro: undefined identifier `__sync_fetch_and_nand_4`");
// /opt/homebrew/include/Z/inspection/compiler/modules/Clang.h:2227:10
pub const Z_COMPILER_FUNCTION_SINT32_ATOMIC_GET_THEN_NAND = @compileError("unable to translate macro: undefined identifier `__sync_fetch_and_nand_4`");
// /opt/homebrew/include/Z/inspection/compiler/modules/Clang.h:2228:10
pub const Z_COMPILER_FUNCTION_UINT32_ATOMIC_GET_THEN_OR = @compileError("unable to translate macro: undefined identifier `__sync_fetch_and_or_4`");
// /opt/homebrew/include/Z/inspection/compiler/modules/Clang.h:2232:10
pub const Z_COMPILER_FUNCTION_SINT32_ATOMIC_GET_THEN_OR = @compileError("unable to translate macro: undefined identifier `__sync_fetch_and_or_4`");
// /opt/homebrew/include/Z/inspection/compiler/modules/Clang.h:2233:10
pub const Z_COMPILER_FUNCTION_UINT32_ATOMIC_GET_THEN_SET_IF_EQUAL = @compileError("unable to translate macro: undefined identifier `__sync_val_compare_and_swap_4`");
// /opt/homebrew/include/Z/inspection/compiler/modules/Clang.h:2237:10
pub const Z_COMPILER_FUNCTION_SINT32_ATOMIC_GET_THEN_SET_IF_EQUAL = @compileError("unable to translate macro: undefined identifier `__sync_val_compare_and_swap_4`");
// /opt/homebrew/include/Z/inspection/compiler/modules/Clang.h:2238:10
pub const Z_COMPILER_FUNCTION_UINT32_ATOMIC_GET_THEN_SUBTRACT = @compileError("unable to translate macro: undefined identifier `__sync_fetch_and_sub_4`");
// /opt/homebrew/include/Z/inspection/compiler/modules/Clang.h:2242:10
pub const Z_COMPILER_FUNCTION_SINT32_ATOMIC_GET_THEN_SUBTRACT = @compileError("unable to translate macro: undefined identifier `__sync_fetch_and_sub_4`");
// /opt/homebrew/include/Z/inspection/compiler/modules/Clang.h:2243:10
pub const Z_COMPILER_FUNCTION_UINT32_ATOMIC_GET_THEN_XOR = @compileError("unable to translate macro: undefined identifier `__sync_fetch_and_xor_4`");
// /opt/homebrew/include/Z/inspection/compiler/modules/Clang.h:2247:10
pub const Z_COMPILER_FUNCTION_SINT32_ATOMIC_GET_THEN_XOR = @compileError("unable to translate macro: undefined identifier `__sync_fetch_and_xor_4`");
// /opt/homebrew/include/Z/inspection/compiler/modules/Clang.h:2248:10
pub const Z_COMPILER_FUNCTION_UINT32_ATOMIC_NAND_THEN_GET = @compileError("unable to translate macro: undefined identifier `__sync_nand_and_fetch_4`");
// /opt/homebrew/include/Z/inspection/compiler/modules/Clang.h:2252:10
pub const Z_COMPILER_FUNCTION_SINT32_ATOMIC_NAND_THEN_GET = @compileError("unable to translate macro: undefined identifier `__sync_nand_and_fetch_4`");
// /opt/homebrew/include/Z/inspection/compiler/modules/Clang.h:2253:10
pub const Z_COMPILER_FUNCTION_UINT32_ATOMIC_OR_THEN_GET = @compileError("unable to translate macro: undefined identifier `__sync_or_and_fetch_4`");
// /opt/homebrew/include/Z/inspection/compiler/modules/Clang.h:2257:10
pub const Z_COMPILER_FUNCTION_SINT32_ATOMIC_OR_THEN_GET = @compileError("unable to translate macro: undefined identifier `__sync_or_and_fetch_4`");
// /opt/homebrew/include/Z/inspection/compiler/modules/Clang.h:2258:10
pub const Z_COMPILER_FUNCTION_UINT32_ATOMIC_SET_IF_EQUAL = @compileError("unable to translate macro: undefined identifier `__sync_bool_compare_and_swap_4`");
// /opt/homebrew/include/Z/inspection/compiler/modules/Clang.h:2262:10
pub const Z_COMPILER_FUNCTION_SINT32_ATOMIC_SET_IF_EQUAL = @compileError("unable to translate macro: undefined identifier `__sync_bool_compare_and_swap_4`");
// /opt/homebrew/include/Z/inspection/compiler/modules/Clang.h:2263:10
pub const Z_COMPILER_FUNCTION_UINT32_ATOMIC_SUBTRACT_THEN_GET = @compileError("unable to translate macro: undefined identifier `__sync_sub_and_fetch_4`");
// /opt/homebrew/include/Z/inspection/compiler/modules/Clang.h:2267:10
pub const Z_COMPILER_FUNCTION_SINT32_ATOMIC_SUBTRACT_THEN_GET = @compileError("unable to translate macro: undefined identifier `__sync_sub_and_fetch_4`");
// /opt/homebrew/include/Z/inspection/compiler/modules/Clang.h:2268:10
pub const Z_COMPILER_FUNCTION_UINT32_ATOMIC_XOR_THEN_GET = @compileError("unable to translate macro: undefined identifier `__sync_xor_and_fetch_4`");
// /opt/homebrew/include/Z/inspection/compiler/modules/Clang.h:2272:10
pub const Z_COMPILER_FUNCTION_SINT32_ATOMIC_XOR_THEN_GET = @compileError("unable to translate macro: undefined identifier `__sync_xor_and_fetch_4`");
// /opt/homebrew/include/Z/inspection/compiler/modules/Clang.h:2273:10
pub const Z_COMPILER_FUNCTION_UINT64_ATOMIC_ADD_THEN_GET = @compileError("unable to translate macro: undefined identifier `__sync_add_and_fetch_8`");
// /opt/homebrew/include/Z/inspection/compiler/modules/Clang.h:2277:10
pub const Z_COMPILER_FUNCTION_SINT64_ATOMIC_ADD_THEN_GET = @compileError("unable to translate macro: undefined identifier `__sync_add_and_fetch_8`");
// /opt/homebrew/include/Z/inspection/compiler/modules/Clang.h:2278:10
pub const Z_COMPILER_FUNCTION_UINT64_ATOMIC_AND_THEN_GET = @compileError("unable to translate macro: undefined identifier `__sync_and_and_fetch_8`");
// /opt/homebrew/include/Z/inspection/compiler/modules/Clang.h:2282:10
pub const Z_COMPILER_FUNCTION_SINT64_ATOMIC_AND_THEN_GET = @compileError("unable to translate macro: undefined identifier `__sync_and_and_fetch_8`");
// /opt/homebrew/include/Z/inspection/compiler/modules/Clang.h:2283:10
pub const Z_COMPILER_FUNCTION_UINT64_ATOMIC_GET_THEN_ADD = @compileError("unable to translate macro: undefined identifier `__sync_fetch_and_add_8`");
// /opt/homebrew/include/Z/inspection/compiler/modules/Clang.h:2287:10
pub const Z_COMPILER_FUNCTION_SINT64_ATOMIC_GET_THEN_ADD = @compileError("unable to translate macro: undefined identifier `__sync_fetch_and_add_8`");
// /opt/homebrew/include/Z/inspection/compiler/modules/Clang.h:2288:10
pub const Z_COMPILER_FUNCTION_SINT64_ATOMIC_GET_THEN_AND = @compileError("unable to translate macro: undefined identifier `__sync_fetch_and_and_8`");
// /opt/homebrew/include/Z/inspection/compiler/modules/Clang.h:2292:10
pub const Z_COMPILER_FUNCTION_UINT64_ATOMIC_GET_THEN_AND = @compileError("unable to translate macro: undefined identifier `__sync_fetch_and_and_8`");
// /opt/homebrew/include/Z/inspection/compiler/modules/Clang.h:2293:10
pub const Z_COMPILER_FUNCTION_UINT64_ATOMIC_GET_THEN_NAND = @compileError("unable to translate macro: undefined identifier `__sync_fetch_and_nand_8`");
// /opt/homebrew/include/Z/inspection/compiler/modules/Clang.h:2297:10
pub const Z_COMPILER_FUNCTION_SINT64_ATOMIC_GET_THEN_NAND = @compileError("unable to translate macro: undefined identifier `__sync_fetch_and_nand_8`");
// /opt/homebrew/include/Z/inspection/compiler/modules/Clang.h:2298:10
pub const Z_COMPILER_FUNCTION_UINT64_ATOMIC_GET_THEN_OR = @compileError("unable to translate macro: undefined identifier `__sync_fetch_and_or_8`");
// /opt/homebrew/include/Z/inspection/compiler/modules/Clang.h:2302:10
pub const Z_COMPILER_FUNCTION_SINT64_ATOMIC_GET_THEN_OR = @compileError("unable to translate macro: undefined identifier `__sync_fetch_and_or_8`");
// /opt/homebrew/include/Z/inspection/compiler/modules/Clang.h:2303:10
pub const Z_COMPILER_FUNCTION_UINT64_ATOMIC_GET_THEN_SET_IF_EQUAL = @compileError("unable to translate macro: undefined identifier `__sync_val_compare_and_swap_8`");
// /opt/homebrew/include/Z/inspection/compiler/modules/Clang.h:2307:10
pub const Z_COMPILER_FUNCTION_SINT64_ATOMIC_GET_THEN_SET_IF_EQUAL = @compileError("unable to translate macro: undefined identifier `__sync_val_compare_and_swap_8`");
// /opt/homebrew/include/Z/inspection/compiler/modules/Clang.h:2308:10
pub const Z_COMPILER_FUNCTION_UINT64_ATOMIC_GET_THEN_SUBTRACT = @compileError("unable to translate macro: undefined identifier `__sync_fetch_and_sub_8`");
// /opt/homebrew/include/Z/inspection/compiler/modules/Clang.h:2312:10
pub const Z_COMPILER_FUNCTION_SINT64_ATOMIC_GET_THEN_SUBTRACT = @compileError("unable to translate macro: undefined identifier `__sync_fetch_and_sub_8`");
// /opt/homebrew/include/Z/inspection/compiler/modules/Clang.h:2313:10
pub const Z_COMPILER_FUNCTION_UINT64_ATOMIC_GET_THEN_XOR = @compileError("unable to translate macro: undefined identifier `__sync_fetch_and_xor_8`");
// /opt/homebrew/include/Z/inspection/compiler/modules/Clang.h:2317:10
pub const Z_COMPILER_FUNCTION_SINT64_ATOMIC_GET_THEN_XOR = @compileError("unable to translate macro: undefined identifier `__sync_fetch_and_xor_8`");
// /opt/homebrew/include/Z/inspection/compiler/modules/Clang.h:2318:10
pub const Z_COMPILER_FUNCTION_UINT64_ATOMIC_NAND_THEN_GET = @compileError("unable to translate macro: undefined identifier `__sync_nand_and_fetch_8`");
// /opt/homebrew/include/Z/inspection/compiler/modules/Clang.h:2322:10
pub const Z_COMPILER_FUNCTION_SINT64_ATOMIC_NAND_THEN_GET = @compileError("unable to translate macro: undefined identifier `__sync_nand_and_fetch_8`");
// /opt/homebrew/include/Z/inspection/compiler/modules/Clang.h:2323:10
pub const Z_COMPILER_FUNCTION_UINT64_ATOMIC_OR_THEN_GET = @compileError("unable to translate macro: undefined identifier `__sync_or_and_fetch_8`");
// /opt/homebrew/include/Z/inspection/compiler/modules/Clang.h:2327:10
pub const Z_COMPILER_FUNCTION_SINT64_ATOMIC_OR_THEN_GET = @compileError("unable to translate macro: undefined identifier `__sync_or_and_fetch_8`");
// /opt/homebrew/include/Z/inspection/compiler/modules/Clang.h:2328:10
pub const Z_COMPILER_FUNCTION_UINT64_ATOMIC_SET_IF_EQUAL = @compileError("unable to translate macro: undefined identifier `__sync_bool_compare_and_swap_8`");
// /opt/homebrew/include/Z/inspection/compiler/modules/Clang.h:2332:10
pub const Z_COMPILER_FUNCTION_SINT64_ATOMIC_SET_IF_EQUAL = @compileError("unable to translate macro: undefined identifier `__sync_bool_compare_and_swap_8`");
// /opt/homebrew/include/Z/inspection/compiler/modules/Clang.h:2333:10
pub const Z_COMPILER_FUNCTION_UINT64_ATOMIC_SUBTRACT_THEN_GET = @compileError("unable to translate macro: undefined identifier `__sync_sub_and_fetch_8`");
// /opt/homebrew/include/Z/inspection/compiler/modules/Clang.h:2337:10
pub const Z_COMPILER_FUNCTION_SINT64_ATOMIC_SUBTRACT_THEN_GET = @compileError("unable to translate macro: undefined identifier `__sync_sub_and_fetch_8`");
// /opt/homebrew/include/Z/inspection/compiler/modules/Clang.h:2338:10
pub const Z_COMPILER_FUNCTION_UINT64_ATOMIC_XOR_THEN_GET = @compileError("unable to translate macro: undefined identifier `__sync_xor_and_fetch_8`");
// /opt/homebrew/include/Z/inspection/compiler/modules/Clang.h:2342:10
pub const Z_COMPILER_FUNCTION_SINT64_ATOMIC_XOR_THEN_GET = @compileError("unable to translate macro: undefined identifier `__sync_xor_and_fetch_8`");
// /opt/homebrew/include/Z/inspection/compiler/modules/Clang.h:2343:10
pub const Z_COMPILER_FUNCTION_UINT128_ATOMIC_ADD_THEN_GET = @compileError("unable to translate macro: undefined identifier `__sync_add_and_fetch_16`");
// /opt/homebrew/include/Z/inspection/compiler/modules/Clang.h:2347:10
pub const Z_COMPILER_FUNCTION_SINT128_ATOMIC_ADD_THEN_GET = @compileError("unable to translate macro: undefined identifier `__sync_add_and_fetch_16`");
// /opt/homebrew/include/Z/inspection/compiler/modules/Clang.h:2348:10
pub const Z_COMPILER_FUNCTION_UINT128_ATOMIC_AND_THEN_GET = @compileError("unable to translate macro: undefined identifier `__sync_and_and_fetch_16`");
// /opt/homebrew/include/Z/inspection/compiler/modules/Clang.h:2352:10
pub const Z_COMPILER_FUNCTION_SINT128_ATOMIC_AND_THEN_GET = @compileError("unable to translate macro: undefined identifier `__sync_and_and_fetch_16`");
// /opt/homebrew/include/Z/inspection/compiler/modules/Clang.h:2353:10
pub const Z_COMPILER_FUNCTION_UINT128_ATOMIC_GET_THEN_ADD = @compileError("unable to translate macro: undefined identifier `__sync_fetch_and_add_16`");
// /opt/homebrew/include/Z/inspection/compiler/modules/Clang.h:2357:10
pub const Z_COMPILER_FUNCTION_SINT128_ATOMIC_GET_THEN_ADD = @compileError("unable to translate macro: undefined identifier `__sync_fetch_and_add_16`");
// /opt/homebrew/include/Z/inspection/compiler/modules/Clang.h:2358:10
pub const Z_COMPILER_FUNCTION_SINT128_ATOMIC_GET_THEN_AND = @compileError("unable to translate macro: undefined identifier `__sync_fetch_and_and_16`");
// /opt/homebrew/include/Z/inspection/compiler/modules/Clang.h:2362:10
pub const Z_COMPILER_FUNCTION_UINT128_ATOMIC_GET_THEN_AND = @compileError("unable to translate macro: undefined identifier `__sync_fetch_and_and_16`");
// /opt/homebrew/include/Z/inspection/compiler/modules/Clang.h:2363:10
pub const Z_COMPILER_FUNCTION_UINT128_ATOMIC_GET_THEN_NAND = @compileError("unable to translate macro: undefined identifier `__sync_fetch_and_nand_16`");
// /opt/homebrew/include/Z/inspection/compiler/modules/Clang.h:2367:10
pub const Z_COMPILER_FUNCTION_SINT128_ATOMIC_GET_THEN_NAND = @compileError("unable to translate macro: undefined identifier `__sync_fetch_and_nand_16`");
// /opt/homebrew/include/Z/inspection/compiler/modules/Clang.h:2368:10
pub const Z_COMPILER_FUNCTION_UINT128_ATOMIC_GET_THEN_OR = @compileError("unable to translate macro: undefined identifier `__sync_fetch_and_or_16`");
// /opt/homebrew/include/Z/inspection/compiler/modules/Clang.h:2372:10
pub const Z_COMPILER_FUNCTION_SINT128_ATOMIC_GET_THEN_OR = @compileError("unable to translate macro: undefined identifier `__sync_fetch_and_or_16`");
// /opt/homebrew/include/Z/inspection/compiler/modules/Clang.h:2373:10
pub const Z_COMPILER_FUNCTION_UINT128_ATOMIC_GET_THEN_SET_IF_EQUAL = @compileError("unable to translate macro: undefined identifier `__sync_val_compare_and_swap_16`");
// /opt/homebrew/include/Z/inspection/compiler/modules/Clang.h:2377:10
pub const Z_COMPILER_FUNCTION_SINT128_ATOMIC_GET_THEN_SET_IF_EQUAL = @compileError("unable to translate macro: undefined identifier `__sync_val_compare_and_swap_16`");
// /opt/homebrew/include/Z/inspection/compiler/modules/Clang.h:2378:10
pub const Z_COMPILER_FUNCTION_UINT128_ATOMIC_GET_THEN_SUBTRACT = @compileError("unable to translate macro: undefined identifier `__sync_fetch_and_sub_16`");
// /opt/homebrew/include/Z/inspection/compiler/modules/Clang.h:2382:10
pub const Z_COMPILER_FUNCTION_SINT128_ATOMIC_GET_THEN_SUBTRACT = @compileError("unable to translate macro: undefined identifier `__sync_fetch_and_sub_16`");
// /opt/homebrew/include/Z/inspection/compiler/modules/Clang.h:2383:10
pub const Z_COMPILER_FUNCTION_UINT128_ATOMIC_GET_THEN_XOR = @compileError("unable to translate macro: undefined identifier `__sync_fetch_and_xor_16`");
// /opt/homebrew/include/Z/inspection/compiler/modules/Clang.h:2387:10
pub const Z_COMPILER_FUNCTION_SINT128_ATOMIC_GET_THEN_XOR = @compileError("unable to translate macro: undefined identifier `__sync_fetch_and_xor_16`");
// /opt/homebrew/include/Z/inspection/compiler/modules/Clang.h:2388:10
pub const Z_COMPILER_FUNCTION_UINT128_ATOMIC_NAND_THEN_GET = @compileError("unable to translate macro: undefined identifier `__sync_nand_and_fetch_16`");
// /opt/homebrew/include/Z/inspection/compiler/modules/Clang.h:2392:10
pub const Z_COMPILER_FUNCTION_SINT128_ATOMIC_NAND_THEN_GET = @compileError("unable to translate macro: undefined identifier `__sync_nand_and_fetch_16`");
// /opt/homebrew/include/Z/inspection/compiler/modules/Clang.h:2393:10
pub const Z_COMPILER_FUNCTION_UINT128_ATOMIC_OR_THEN_GET = @compileError("unable to translate macro: undefined identifier `__sync_or_and_fetch_16`");
// /opt/homebrew/include/Z/inspection/compiler/modules/Clang.h:2397:10
pub const Z_COMPILER_FUNCTION_SINT128_ATOMIC_OR_THEN_GET = @compileError("unable to translate macro: undefined identifier `__sync_or_and_fetch_16`");
// /opt/homebrew/include/Z/inspection/compiler/modules/Clang.h:2398:10
pub const Z_COMPILER_FUNCTION_UINT128_ATOMIC_SET_IF_EQUAL = @compileError("unable to translate macro: undefined identifier `__sync_bool_compare_and_swap_16`");
// /opt/homebrew/include/Z/inspection/compiler/modules/Clang.h:2402:10
pub const Z_COMPILER_FUNCTION_SINT128_ATOMIC_SET_IF_EQUAL = @compileError("unable to translate macro: undefined identifier `__sync_bool_compare_and_swap_16`");
// /opt/homebrew/include/Z/inspection/compiler/modules/Clang.h:2403:10
pub const Z_COMPILER_FUNCTION_UINT128_ATOMIC_SUBTRACT_THEN_GET = @compileError("unable to translate macro: undefined identifier `__sync_sub_and_fetch_16`");
// /opt/homebrew/include/Z/inspection/compiler/modules/Clang.h:2407:10
pub const Z_COMPILER_FUNCTION_SINT128_ATOMIC_SUBTRACT_THEN_GET = @compileError("unable to translate macro: undefined identifier `__sync_sub_and_fetch_16`");
// /opt/homebrew/include/Z/inspection/compiler/modules/Clang.h:2408:10
pub const Z_COMPILER_FUNCTION_UINT128_ATOMIC_XOR_THEN_GET = @compileError("unable to translate macro: undefined identifier `__sync_xor_and_fetch_16`");
// /opt/homebrew/include/Z/inspection/compiler/modules/Clang.h:2412:10
pub const Z_COMPILER_FUNCTION_SINT128_ATOMIC_XOR_THEN_GET = @compileError("unable to translate macro: undefined identifier `__sync_xor_and_fetch_16`");
// /opt/homebrew/include/Z/inspection/compiler/modules/Clang.h:2413:10
pub const Z_COMPILER_HAS_MAGIC_CONSTANT_MANGLED_FUNCTION_NAME = @as(c_int, 1);
pub const Z_inspection_compiler_completion_H = "";
pub const Z_COMPILER_HAS_ATTRIBUTE_ALIAS = @as(c_int, 1);
pub const Z_COMPILER_HAS_ATTRIBUTE_ALWAYS_INLINE = @as(c_int, 1);
pub const Z_COMPILER_HAS_ATTRIBUTE_INLINE = @as(c_int, 1);
pub const Z_COMPILER_HAS_ATTRIBUTE_MICROSOFT_STD_CALL = @as(c_int, 1);
pub const Z_COMPILER_HAS_ATTRIBUTE_NO_RETURN = @as(c_int, 1);
pub const Z_COMPILER_HAS_ATTRIBUTE_NULL_TERMINATED = @as(c_int, 1);
pub const Z_COMPILER_HAS_ATTRIBUTE_PRIVATE = @as(c_int, 1);
pub const Z_COMPILER_HAS_ATTRIBUTE_PUBLIC = @as(c_int, 1);
pub const Z_COMPILER_HAS_ATTRIBUTE_THREAD_LOCAL = @as(c_int, 1);
pub const Z_COMPILER_HAS_ATTRIBUTE_WEAK = @as(c_int, 1);
pub const Z_COMPILER_HAS_CONSTANT_CHAR_WIDTH = @as(c_int, 1);
pub const Z_COMPILER_HAS_CONSTANT_SCHAR_MAXIMUM = @as(c_int, 1);
pub const Z_COMPILER_HAS_CONSTANT_SHORT_SIZE = @as(c_int, 1);
pub const Z_COMPILER_HAS_CONSTANT_SSHORT_MAXIMUM = @as(c_int, 1);
pub const Z_COMPILER_HAS_CONSTANT_INT_SIZE = @as(c_int, 1);
pub const Z_COMPILER_HAS_CONSTANT_SINT_MAXIMUM = @as(c_int, 1);
pub const Z_COMPILER_HAS_CONSTANT_LONG_SIZE = @as(c_int, 1);
pub const Z_COMPILER_HAS_CONSTANT_SLONG_MAXIMUM = @as(c_int, 1);
pub const Z_COMPILER_HAS_CONSTANT_LLONG_SIZE = @as(c_int, 1);
pub const Z_COMPILER_HAS_CONSTANT_SLLONG_MAXIMUM = @as(c_int, 1);
pub const Z_COMPILER_HAS_CONSTANT_FLOAT_SIZE = @as(c_int, 1);
pub const Z_COMPILER_HAS_CONSTANT_FLOAT_INFINITY = @as(c_int, 1);
pub const Z_COMPILER_HAS_CONSTANT_DOUBLE_SIZE = @as(c_int, 1);
pub const Z_COMPILER_HAS_CONSTANT_DOUBLE_INFINITY = @as(c_int, 1);
pub const Z_COMPILER_HAS_CONSTANT_LDOUBLE_SIZE = @as(c_int, 1);
pub const Z_COMPILER_HAS_CONSTANT_LDOUBLE_INFINITY = @as(c_int, 1);
pub const Z_COMPILER_HAS_CONSTANT_WCHAR_SIZE = @as(c_int, 1);
pub const Z_COMPILER_HAS_CONSTANT_WCHAR_WIDTH = @as(c_int, 1);
pub const Z_COMPILER_HAS_CONSTANT_WCHAR_MAXIMUM = @as(c_int, 1);
pub const Z_COMPILER_HAS_CONSTANT_SIZE_SIZE = @as(c_int, 1);
pub const Z_COMPILER_HAS_CONSTANT_SIZE_WIDTH = @as(c_int, 1);
pub const Z_COMPILER_HAS_CONSTANT_USIZE_MAXIMUM = @as(c_int, 1);
pub const Z_COMPILER_HAS_CONSTANT_UINTMAX_WIDTH = @as(c_int, 1);
pub const Z_COMPILER_HAS_CONSTANT_UINTMAX_MAXIMUM = @as(c_int, 1);
pub const Z_COMPILER_HAS_CONSTANT_SINTMAX_WIDTH = @as(c_int, 1);
pub const Z_COMPILER_HAS_CONSTANT_SINTMAX_MAXIMUM = @as(c_int, 1);
pub const Z_COMPILER_HAS_CONSTANT_UINTPTR_MAXIMUM = @as(c_int, 1);
pub const Z_COMPILER_HAS_CONSTANT_SINTPTR_MAXIMUM = @as(c_int, 1);
pub const Z_COMPILER_HAS_CONSTANT_POINTER_SIZE = @as(c_int, 1);
pub const Z_COMPILER_HAS_CONSTANT_POINTER_WIDTH = @as(c_int, 1);
pub const Z_COMPILER_HAS_MACRO_MEMBER_OFFSET = @as(c_int, 1);
pub const Z_COMPILER_HAS_MACRO_VAL_INITIALIZE = @as(c_int, 1);
pub const Z_COMPILER_HAS_MACRO_VAL_FINALIZE = @as(c_int, 1);
pub const Z_COMPILER_HAS_MACRO_VAL_READ = @as(c_int, 1);
pub const Z_COMPILER_HAS_MACRO_VAL_COPY = @as(c_int, 1);
pub const Z_COMPILER_HAS_TYPE_UINT8 = @as(c_int, 1);
pub const Z_COMPILER_HAS_TYPE_SINT8 = @as(c_int, 1);
pub const Z_COMPILER_HAS_TYPE_UINT16 = @as(c_int, 1);
pub const Z_COMPILER_HAS_TYPE_SINT16 = @as(c_int, 1);
pub const Z_COMPILER_HAS_TYPE_UINT32 = @as(c_int, 1);
pub const Z_COMPILER_HAS_TYPE_SINT32 = @as(c_int, 1);
pub const Z_COMPILER_HAS_TYPE_UINT64 = @as(c_int, 1);
pub const Z_COMPILER_HAS_TYPE_SINT64 = @as(c_int, 1);
pub const Z_COMPILER_HAS_TYPE_UINT128 = @as(c_int, 1);
pub const Z_COMPILER_HAS_TYPE_SINT128 = @as(c_int, 1);
pub const Z_COMPILER_HAS_TYPE_VAL = @as(c_int, 1);
pub const Z_COMPILER_HAS_LITERAL_UINT16 = @as(c_int, 1);
pub const Z_COMPILER_HAS_LITERAL_SINT16 = @as(c_int, 1);
pub const Z_COMPILER_HAS_LITERAL_UINT32 = @as(c_int, 1);
pub const Z_COMPILER_HAS_LITERAL_SINT32 = @as(c_int, 1);
pub const Z_COMPILER_HAS_LITERAL_UINT64 = @as(c_int, 1);
pub const Z_COMPILER_HAS_LITERAL_SINT64 = @as(c_int, 1);
pub const Z_COMPILER_HAS_VAL = @as(c_int, 1);
pub const Z_COMPILER_HAS_FUNCTION_UINT8_ATOMIC_ADD_THEN_GET = @as(c_int, 1);
pub const Z_COMPILER_HAS_FUNCTION_UINT8_ATOMIC_AND_THEN_GET = @as(c_int, 1);
pub const Z_COMPILER_HAS_FUNCTION_UINT8_ATOMIC_GET_THEN_ADD = @as(c_int, 1);
pub const Z_COMPILER_HAS_FUNCTION_UINT8_ATOMIC_GET_THEN_AND = @as(c_int, 1);
pub const Z_COMPILER_HAS_FUNCTION_UINT8_ATOMIC_GET_THEN_NAND = @as(c_int, 1);
pub const Z_COMPILER_HAS_FUNCTION_UINT8_ATOMIC_GET_THEN_OR = @as(c_int, 1);
pub const Z_COMPILER_HAS_FUNCTION_UINT8_ATOMIC_GET_THEN_SET_IF_EQUAL = @as(c_int, 1);
pub const Z_COMPILER_HAS_FUNCTION_UINT8_ATOMIC_GET_THEN_SUBTRACT = @as(c_int, 1);
pub const Z_COMPILER_HAS_FUNCTION_UINT8_ATOMIC_GET_THEN_XOR = @as(c_int, 1);
pub const Z_COMPILER_HAS_FUNCTION_UINT8_ATOMIC_NAND_THEN_GET = @as(c_int, 1);
pub const Z_COMPILER_HAS_FUNCTION_UINT8_ATOMIC_OR_THEN_GET = @as(c_int, 1);
pub const Z_COMPILER_HAS_FUNCTION_UINT8_ATOMIC_SET_IF_EQUAL = @as(c_int, 1);
pub const Z_COMPILER_HAS_FUNCTION_UINT8_ATOMIC_SUBTRACT_THEN_GET = @as(c_int, 1);
pub const Z_COMPILER_HAS_FUNCTION_UINT8_ATOMIC_XOR_THEN_GET = @as(c_int, 1);
pub const Z_COMPILER_HAS_FUNCTION_SINT8_ATOMIC_ADD_THEN_GET = @as(c_int, 1);
pub const Z_COMPILER_HAS_FUNCTION_SINT8_ATOMIC_AND_THEN_GET = @as(c_int, 1);
pub const Z_COMPILER_HAS_FUNCTION_SINT8_ATOMIC_GET_THEN_ADD = @as(c_int, 1);
pub const Z_COMPILER_HAS_FUNCTION_SINT8_ATOMIC_GET_THEN_AND = @as(c_int, 1);
pub const Z_COMPILER_HAS_FUNCTION_SINT8_ATOMIC_GET_THEN_NAND = @as(c_int, 1);
pub const Z_COMPILER_HAS_FUNCTION_SINT8_ATOMIC_GET_THEN_OR = @as(c_int, 1);
pub const Z_COMPILER_HAS_FUNCTION_SINT8_ATOMIC_GET_THEN_SET_IF_EQUAL = @as(c_int, 1);
pub const Z_COMPILER_HAS_FUNCTION_SINT8_ATOMIC_GET_THEN_SUBTRACT = @as(c_int, 1);
pub const Z_COMPILER_HAS_FUNCTION_SINT8_ATOMIC_GET_THEN_XOR = @as(c_int, 1);
pub const Z_COMPILER_HAS_FUNCTION_SINT8_ATOMIC_NAND_THEN_GET = @as(c_int, 1);
pub const Z_COMPILER_HAS_FUNCTION_SINT8_ATOMIC_OR_THEN_GET = @as(c_int, 1);
pub const Z_COMPILER_HAS_FUNCTION_SINT8_ATOMIC_SET_IF_EQUAL = @as(c_int, 1);
pub const Z_COMPILER_HAS_FUNCTION_SINT8_ATOMIC_SUBTRACT_THEN_GET = @as(c_int, 1);
pub const Z_COMPILER_HAS_FUNCTION_SINT8_ATOMIC_XOR_THEN_GET = @as(c_int, 1);
pub const Z_COMPILER_HAS_FUNCTION_UINT16_ATOMIC_ADD_THEN_GET = @as(c_int, 1);
pub const Z_COMPILER_HAS_FUNCTION_UINT16_ATOMIC_AND_THEN_GET = @as(c_int, 1);
pub const Z_COMPILER_HAS_FUNCTION_UINT16_ATOMIC_GET_THEN_ADD = @as(c_int, 1);
pub const Z_COMPILER_HAS_FUNCTION_UINT16_ATOMIC_GET_THEN_AND = @as(c_int, 1);
pub const Z_COMPILER_HAS_FUNCTION_UINT16_ATOMIC_GET_THEN_NAND = @as(c_int, 1);
pub const Z_COMPILER_HAS_FUNCTION_UINT16_ATOMIC_GET_THEN_OR = @as(c_int, 1);
pub const Z_COMPILER_HAS_FUNCTION_UINT16_ATOMIC_GET_THEN_SET_IF_EQUAL = @as(c_int, 1);
pub const Z_COMPILER_HAS_FUNCTION_UINT16_ATOMIC_GET_THEN_SUBTRACT = @as(c_int, 1);
pub const Z_COMPILER_HAS_FUNCTION_UINT16_ATOMIC_GET_THEN_XOR = @as(c_int, 1);
pub const Z_COMPILER_HAS_FUNCTION_UINT16_ATOMIC_NAND_THEN_GET = @as(c_int, 1);
pub const Z_COMPILER_HAS_FUNCTION_UINT16_ATOMIC_OR_THEN_GET = @as(c_int, 1);
pub const Z_COMPILER_HAS_FUNCTION_UINT16_ATOMIC_SET_IF_EQUAL = @as(c_int, 1);
pub const Z_COMPILER_HAS_FUNCTION_UINT16_ATOMIC_SUBTRACT_THEN_GET = @as(c_int, 1);
pub const Z_COMPILER_HAS_FUNCTION_UINT16_ATOMIC_XOR_THEN_GET = @as(c_int, 1);
pub const Z_COMPILER_HAS_FUNCTION_SINT16_ATOMIC_ADD_THEN_GET = @as(c_int, 1);
pub const Z_COMPILER_HAS_FUNCTION_SINT16_ATOMIC_AND_THEN_GET = @as(c_int, 1);
pub const Z_COMPILER_HAS_FUNCTION_SINT16_ATOMIC_GET_THEN_ADD = @as(c_int, 1);
pub const Z_COMPILER_HAS_FUNCTION_SINT16_ATOMIC_GET_THEN_AND = @as(c_int, 1);
pub const Z_COMPILER_HAS_FUNCTION_SINT16_ATOMIC_GET_THEN_NAND = @as(c_int, 1);
pub const Z_COMPILER_HAS_FUNCTION_SINT16_ATOMIC_GET_THEN_OR = @as(c_int, 1);
pub const Z_COMPILER_HAS_FUNCTION_SINT16_ATOMIC_GET_THEN_SET_IF_EQUAL = @as(c_int, 1);
pub const Z_COMPILER_HAS_FUNCTION_SINT16_ATOMIC_GET_THEN_SUBTRACT = @as(c_int, 1);
pub const Z_COMPILER_HAS_FUNCTION_SINT16_ATOMIC_GET_THEN_XOR = @as(c_int, 1);
pub const Z_COMPILER_HAS_FUNCTION_SINT16_ATOMIC_NAND_THEN_GET = @as(c_int, 1);
pub const Z_COMPILER_HAS_FUNCTION_SINT16_ATOMIC_OR_THEN_GET = @as(c_int, 1);
pub const Z_COMPILER_HAS_FUNCTION_SINT16_ATOMIC_SET_IF_EQUAL = @as(c_int, 1);
pub const Z_COMPILER_HAS_FUNCTION_SINT16_ATOMIC_SUBTRACT_THEN_GET = @as(c_int, 1);
pub const Z_COMPILER_HAS_FUNCTION_SINT16_ATOMIC_XOR_THEN_GET = @as(c_int, 1);
pub const Z_COMPILER_HAS_FUNCTION_UINT32_ATOMIC_ADD_THEN_GET = @as(c_int, 1);
pub const Z_COMPILER_HAS_FUNCTION_UINT32_ATOMIC_AND_THEN_GET = @as(c_int, 1);
pub const Z_COMPILER_HAS_FUNCTION_UINT32_ATOMIC_GET_THEN_ADD = @as(c_int, 1);
pub const Z_COMPILER_HAS_FUNCTION_UINT32_ATOMIC_GET_THEN_AND = @as(c_int, 1);
pub const Z_COMPILER_HAS_FUNCTION_UINT32_ATOMIC_GET_THEN_NAND = @as(c_int, 1);
pub const Z_COMPILER_HAS_FUNCTION_UINT32_ATOMIC_GET_THEN_OR = @as(c_int, 1);
pub const Z_COMPILER_HAS_FUNCTION_UINT32_ATOMIC_GET_THEN_SET_IF_EQUAL = @as(c_int, 1);
pub const Z_COMPILER_HAS_FUNCTION_UINT32_ATOMIC_GET_THEN_SUBTRACT = @as(c_int, 1);
pub const Z_COMPILER_HAS_FUNCTION_UINT32_ATOMIC_GET_THEN_XOR = @as(c_int, 1);
pub const Z_COMPILER_HAS_FUNCTION_UINT32_ATOMIC_NAND_THEN_GET = @as(c_int, 1);
pub const Z_COMPILER_HAS_FUNCTION_UINT32_ATOMIC_OR_THEN_GET = @as(c_int, 1);
pub const Z_COMPILER_HAS_FUNCTION_UINT32_ATOMIC_SET_IF_EQUAL = @as(c_int, 1);
pub const Z_COMPILER_HAS_FUNCTION_UINT32_ATOMIC_SUBTRACT_THEN_GET = @as(c_int, 1);
pub const Z_COMPILER_HAS_FUNCTION_UINT32_ATOMIC_XOR_THEN_GET = @as(c_int, 1);
pub const Z_COMPILER_HAS_FUNCTION_SINT32_ATOMIC_ADD_THEN_GET = @as(c_int, 1);
pub const Z_COMPILER_HAS_FUNCTION_SINT32_ATOMIC_AND_THEN_GET = @as(c_int, 1);
pub const Z_COMPILER_HAS_FUNCTION_SINT32_ATOMIC_GET_THEN_ADD = @as(c_int, 1);
pub const Z_COMPILER_HAS_FUNCTION_SINT32_ATOMIC_GET_THEN_AND = @as(c_int, 1);
pub const Z_COMPILER_HAS_FUNCTION_SINT32_ATOMIC_GET_THEN_NAND = @as(c_int, 1);
pub const Z_COMPILER_HAS_FUNCTION_SINT32_ATOMIC_GET_THEN_OR = @as(c_int, 1);
pub const Z_COMPILER_HAS_FUNCTION_SINT32_ATOMIC_GET_THEN_SET_IF_EQUAL = @as(c_int, 1);
pub const Z_COMPILER_HAS_FUNCTION_SINT32_ATOMIC_GET_THEN_SUBTRACT = @as(c_int, 1);
pub const Z_COMPILER_HAS_FUNCTION_SINT32_ATOMIC_GET_THEN_XOR = @as(c_int, 1);
pub const Z_COMPILER_HAS_FUNCTION_SINT32_ATOMIC_NAND_THEN_GET = @as(c_int, 1);
pub const Z_COMPILER_HAS_FUNCTION_SINT32_ATOMIC_OR_THEN_GET = @as(c_int, 1);
pub const Z_COMPILER_HAS_FUNCTION_SINT32_ATOMIC_SET_IF_EQUAL = @as(c_int, 1);
pub const Z_COMPILER_HAS_FUNCTION_SINT32_ATOMIC_SUBTRACT_THEN_GET = @as(c_int, 1);
pub const Z_COMPILER_HAS_FUNCTION_SINT32_ATOMIC_XOR_THEN_GET = @as(c_int, 1);
pub const Z_COMPILER_HAS_FUNCTION_UINT64_ATOMIC_ADD_THEN_GET = @as(c_int, 1);
pub const Z_COMPILER_HAS_FUNCTION_UINT64_ATOMIC_AND_THEN_GET = @as(c_int, 1);
pub const Z_COMPILER_HAS_FUNCTION_UINT64_ATOMIC_GET_THEN_ADD = @as(c_int, 1);
pub const Z_COMPILER_HAS_FUNCTION_UINT64_ATOMIC_GET_THEN_AND = @as(c_int, 1);
pub const Z_COMPILER_HAS_FUNCTION_UINT64_ATOMIC_GET_THEN_NAND = @as(c_int, 1);
pub const Z_COMPILER_HAS_FUNCTION_UINT64_ATOMIC_GET_THEN_OR = @as(c_int, 1);
pub const Z_COMPILER_HAS_FUNCTION_UINT64_ATOMIC_GET_THEN_SET_IF_EQUAL = @as(c_int, 1);
pub const Z_COMPILER_HAS_FUNCTION_UINT64_ATOMIC_GET_THEN_SUBTRACT = @as(c_int, 1);
pub const Z_COMPILER_HAS_FUNCTION_UINT64_ATOMIC_GET_THEN_XOR = @as(c_int, 1);
pub const Z_COMPILER_HAS_FUNCTION_UINT64_ATOMIC_NAND_THEN_GET = @as(c_int, 1);
pub const Z_COMPILER_HAS_FUNCTION_UINT64_ATOMIC_OR_THEN_GET = @as(c_int, 1);
pub const Z_COMPILER_HAS_FUNCTION_UINT64_ATOMIC_SET_IF_EQUAL = @as(c_int, 1);
pub const Z_COMPILER_HAS_FUNCTION_UINT64_ATOMIC_SUBTRACT_THEN_GET = @as(c_int, 1);
pub const Z_COMPILER_HAS_FUNCTION_UINT64_ATOMIC_XOR_THEN_GET = @as(c_int, 1);
pub const Z_COMPILER_HAS_FUNCTION_SINT64_ATOMIC_ADD_THEN_GET = @as(c_int, 1);
pub const Z_COMPILER_HAS_FUNCTION_SINT64_ATOMIC_AND_THEN_GET = @as(c_int, 1);
pub const Z_COMPILER_HAS_FUNCTION_SINT64_ATOMIC_GET_THEN_ADD = @as(c_int, 1);
pub const Z_COMPILER_HAS_FUNCTION_SINT64_ATOMIC_GET_THEN_AND = @as(c_int, 1);
pub const Z_COMPILER_HAS_FUNCTION_SINT64_ATOMIC_GET_THEN_NAND = @as(c_int, 1);
pub const Z_COMPILER_HAS_FUNCTION_SINT64_ATOMIC_GET_THEN_OR = @as(c_int, 1);
pub const Z_COMPILER_HAS_FUNCTION_SINT64_ATOMIC_GET_THEN_SET_IF_EQUAL = @as(c_int, 1);
pub const Z_COMPILER_HAS_FUNCTION_SINT64_ATOMIC_GET_THEN_SUBTRACT = @as(c_int, 1);
pub const Z_COMPILER_HAS_FUNCTION_SINT64_ATOMIC_GET_THEN_XOR = @as(c_int, 1);
pub const Z_COMPILER_HAS_FUNCTION_SINT64_ATOMIC_NAND_THEN_GET = @as(c_int, 1);
pub const Z_COMPILER_HAS_FUNCTION_SINT64_ATOMIC_OR_THEN_GET = @as(c_int, 1);
pub const Z_COMPILER_HAS_FUNCTION_SINT64_ATOMIC_SET_IF_EQUAL = @as(c_int, 1);
pub const Z_COMPILER_HAS_FUNCTION_SINT64_ATOMIC_SUBTRACT_THEN_GET = @as(c_int, 1);
pub const Z_COMPILER_HAS_FUNCTION_SINT64_ATOMIC_XOR_THEN_GET = @as(c_int, 1);
pub const Z_COMPILER_HAS_FUNCTION_UINT128_ATOMIC_ADD_THEN_GET = @as(c_int, 1);
pub const Z_COMPILER_HAS_FUNCTION_UINT128_ATOMIC_AND_THEN_GET = @as(c_int, 1);
pub const Z_COMPILER_HAS_FUNCTION_UINT128_ATOMIC_GET_THEN_ADD = @as(c_int, 1);
pub const Z_COMPILER_HAS_FUNCTION_UINT128_ATOMIC_GET_THEN_AND = @as(c_int, 1);
pub const Z_COMPILER_HAS_FUNCTION_UINT128_ATOMIC_GET_THEN_NAND = @as(c_int, 1);
pub const Z_COMPILER_HAS_FUNCTION_UINT128_ATOMIC_GET_THEN_OR = @as(c_int, 1);
pub const Z_COMPILER_HAS_FUNCTION_UINT128_ATOMIC_GET_THEN_SET_IF_EQUAL = @as(c_int, 1);
pub const Z_COMPILER_HAS_FUNCTION_UINT128_ATOMIC_GET_THEN_SUBTRACT = @as(c_int, 1);
pub const Z_COMPILER_HAS_FUNCTION_UINT128_ATOMIC_GET_THEN_XOR = @as(c_int, 1);
pub const Z_COMPILER_HAS_FUNCTION_UINT128_ATOMIC_NAND_THEN_GET = @as(c_int, 1);
pub const Z_COMPILER_HAS_FUNCTION_UINT128_ATOMIC_OR_THEN_GET = @as(c_int, 1);
pub const Z_COMPILER_HAS_FUNCTION_UINT128_ATOMIC_SET_IF_EQUAL = @as(c_int, 1);
pub const Z_COMPILER_HAS_FUNCTION_UINT128_ATOMIC_SUBTRACT_THEN_GET = @as(c_int, 1);
pub const Z_COMPILER_HAS_FUNCTION_UINT128_ATOMIC_XOR_THEN_GET = @as(c_int, 1);
pub const Z_COMPILER_HAS_FUNCTION_SINT128_ATOMIC_ADD_THEN_GET = @as(c_int, 1);
pub const Z_COMPILER_HAS_FUNCTION_SINT128_ATOMIC_AND_THEN_GET = @as(c_int, 1);
pub const Z_COMPILER_HAS_FUNCTION_SINT128_ATOMIC_GET_THEN_ADD = @as(c_int, 1);
pub const Z_COMPILER_HAS_FUNCTION_SINT128_ATOMIC_GET_THEN_AND = @as(c_int, 1);
pub const Z_COMPILER_HAS_FUNCTION_SINT128_ATOMIC_GET_THEN_NAND = @as(c_int, 1);
pub const Z_COMPILER_HAS_FUNCTION_SINT128_ATOMIC_GET_THEN_OR = @as(c_int, 1);
pub const Z_COMPILER_HAS_FUNCTION_SINT128_ATOMIC_GET_THEN_SET_IF_EQUAL = @as(c_int, 1);
pub const Z_COMPILER_HAS_FUNCTION_SINT128_ATOMIC_GET_THEN_SUBTRACT = @as(c_int, 1);
pub const Z_COMPILER_HAS_FUNCTION_SINT128_ATOMIC_GET_THEN_XOR = @as(c_int, 1);
pub const Z_COMPILER_HAS_FUNCTION_SINT128_ATOMIC_NAND_THEN_GET = @as(c_int, 1);
pub const Z_COMPILER_HAS_FUNCTION_SINT128_ATOMIC_OR_THEN_GET = @as(c_int, 1);
pub const Z_COMPILER_HAS_FUNCTION_SINT128_ATOMIC_SET_IF_EQUAL = @as(c_int, 1);
pub const Z_COMPILER_HAS_FUNCTION_SINT128_ATOMIC_SUBTRACT_THEN_GET = @as(c_int, 1);
pub const Z_COMPILER_HAS_FUNCTION_SINT128_ATOMIC_XOR_THEN_GET = @as(c_int, 1);
pub inline fn Z_COMPILER_BIT_FIELD_ORDER(bits: anytype) @TypeOf(Z_COMPILER_BIT_FIELD_ORDER_ALL) {
    _ = &bits;
    return Z_COMPILER_BIT_FIELD_ORDER_ALL;
}
pub const Z_COMPILER_PACKED_NAMED_STRUCTURE_BEFORE_STRUCT = "";
pub const Z_COMPILER_PACKED_NAMED_STRUCTURE_BEFORE_BODY = "";
pub const Z_COMPILER_PACKED_NAMED_STRUCTURE_AFTER_BODY = "";
pub const Z_COMPILER_PACKED_NAMED_UNION_BEFORE_UNION = "";
pub const Z_COMPILER_PACKED_NAMED_UNION_BEFORE_BODY = "";
pub const Z_COMPILER_PACKED_NAMED_UNION_AFTER_BODY = "";
pub const Z_COMPILER_PACKED_STRUCTURE_BEFORE_STRUCT = "";
pub const Z_COMPILER_PACKED_STRUCTURE_BEFORE_BODY = "";
pub const Z_COMPILER_PACKED_UNION_BEFORE_UNION = "";
pub const Z_COMPILER_PACKED_UNION_BEFORE_BODY = "";
pub const Z_LANGUAGE = Z_LANGUAGE_C;
pub const Z_LANGUAGE_INCLUDES = @compileError("unable to translate macro: undefined identifier `Z_LANGUAGE_`");
// /opt/homebrew/include/Z/inspection/language.h:32:9
pub inline fn Z_C_FLAG(FLAG: anytype) @TypeOf(Z_IS_TRUE(FLAG)) {
    _ = &FLAG;
    return Z_IS_TRUE(FLAG);
}
pub inline fn Z_CPP_FLAG(FLAG: anytype) @TypeOf(@as(c_int, 0)) {
    _ = &FLAG;
    return @as(c_int, 0);
}
pub inline fn Z_OBJECTIVE_C_FLAG(FLAG: anytype) @TypeOf(@as(c_int, 0)) {
    _ = &FLAG;
    return @as(c_int, 0);
}
pub const Z_DIALECT_HAS = Z_COMPILER_DIALECT_HAS;
pub const Z_DIALECT_HAS_ATTRIBUTE = Z_COMPILER_DIALECT_HAS_ATTRIBUTE;
pub const Z_DIALECT_HAS_ESCAPE_SEQUENCE = Z_COMPILER_DIALECT_HAS_ESCAPE_SEQUENCE;
pub const Z_DIALECT_HAS_IDENTIFIER = Z_COMPILER_DIALECT_HAS_IDENTIFIER;
pub const Z_DIALECT_HAS_LITERAL = Z_COMPILER_DIALECT_HAS_LITERAL;
pub const Z_DIALECT_HAS_OPERATOR = Z_COMPILER_DIALECT_HAS_OPERATOR;
pub const Z_DIALECT_HAS_OPERATOR_CASE = Z_COMPILER_DIALECT_HAS_OPERATOR_CASE;
pub const Z_DIALECT_HAS_PREPROCESSOR_DIRECTIVE = Z_COMPILER_DIALECT_HAS_PREPROCESSOR_DIRECTIVE;
pub const Z_DIALECT_HAS_PREPROCESSOR_IDENTIFIER = Z_COMPILER_DIALECT_HAS_PREPROCESSOR_IDENTIFIER;
pub const Z_DIALECT_HAS_PREPROCESSOR_OPERATOR = Z_COMPILER_DIALECT_HAS_PREPROCESSOR_OPERATOR;
pub const Z_DIALECT_HAS_SPECIFIER = Z_COMPILER_DIALECT_HAS_SPECIFIER;
pub const Z_DIALECT_HAS_SPECIFIER_CASE = Z_COMPILER_DIALECT_HAS_SPECIFIER_CASE;
pub const Z_DIALECT_HAS_STD_PRAGMA = Z_COMPILER_DIALECT_HAS_STD_PRAGMA;
pub const Z_DIALECT_HAS_STORAGE_CLASS = Z_COMPILER_DIALECT_HAS_STORAGE_CLASS;
pub const Z_DIALECT_HAS_TYPE = Z_COMPILER_DIALECT_HAS_TYPE;
pub const Z_DIALECT_HAS_TYPE_MODIFIER = Z_COMPILER_DIALECT_HAS_TYPE_MODIFIER;
pub const Z_DIALECT_HAS_TYPE_QUALIFIER = Z_COMPILER_DIALECT_HAS_TYPE_QUALIFIER;
pub const Z_API_EXPORT = Z_PUBLIC;
pub const Z_API_IMPORT = "";
pub const Z_API_WEAK_EXPORT = Z_API_EXPORT ++ Z_WEAK;
pub const Z_MICROSOFT_STD_CALL = @compileError("unable to translate macro: undefined identifier `MICROSOFT_STD_CALL`");
// /opt/homebrew/include/Z/macros/language.h:36:10
pub const Z_NULL_TERMINATED = @compileError("unable to translate macro: undefined identifier `NULL_TERMINATED`");
// /opt/homebrew/include/Z/macros/language.h:40:10
pub const Z_PRIVATE = @compileError("unable to translate macro: undefined identifier `PRIVATE`");
// /opt/homebrew/include/Z/macros/language.h:46:10
pub const Z_PUBLIC = @compileError("unable to translate macro: undefined identifier `PUBLIC`");
// /opt/homebrew/include/Z/macros/language.h:54:10
pub const Z_WEAK = @compileError("unable to translate macro: undefined identifier `WEAK`");
// /opt/homebrew/include/Z/macros/language.h:60:10
pub const Z_INLINE = @compileError("unable to translate macro: undefined identifier `INLINE`");
// /opt/homebrew/include/Z/macros/language.h:68:10
pub const Z_ALWAYS_INLINE = @compileError("unable to translate macro: undefined identifier `ALWAYS_INLINE`");
// /opt/homebrew/include/Z/macros/language.h:76:10
pub const Z_NO_RETURN = @compileError("unable to translate macro: undefined identifier `NO_RETURN`");
// /opt/homebrew/include/Z/macros/language.h:82:10
pub const Z_THREAD_LOCAL = @compileError("unable to translate macro: undefined identifier `THREAD_LOCAL`");
// /opt/homebrew/include/Z/macros/language.h:94:10
pub const Z_OUT = "";
pub const Z_INOUT = "";
pub const Z_UNUSED = @compileError("unable to translate C expr: unexpected token ';'");
// /opt/homebrew/include/Z/macros/language.h:105:9
pub const Z_EXTERN_C = "";
pub const Z_EXTERN_C_BEGIN = "";
pub const Z_EXTERN_C_END = "";
// pub inline fn Z_PACKED_NAMED_STRUCTURE_BEGIN(@"type": anytype) @TypeOf(struct_Z_COMPILER_PACKED_NAMED_STRUCTURE_BEFORE_TYPE ++ @"type") {
//     _ = &@"type";
//     return struct_Z_COMPILER_PACKED_NAMED_STRUCTURE_BEFORE_TYPE ++ @"type";
// }
pub const Z_PACKED_NAMED_STRUCTURE_END = "";
// pub inline fn Z_PACKED_NAMED_UNION_BEGIN(@"type": anytype) @TypeOf(union_Z_COMPILER_PACKED_NAMED_UNION_BEFORE_TYPE ++ @"type") {
//     _ = &@"type";
//     return union_Z_COMPILER_PACKED_NAMED_UNION_BEFORE_TYPE ++ @"type";
// }
pub const Z_PACKED_NAMED_UNION_END = "";
// pub const Z_PACKED_STRUCTURE_BEGIN = struct_Z_COMPILER_PACKED_STRUCTURE_BEFORE_BODY;
pub const Z_PACKED_STRUCTURE_END = Z_COMPILER_PACKED_STRUCTURE_AFTER_BODY;
// pub const Z_PACKED_UNION_BEGIN = union_Z_COMPILER_PACKED_UNION_BEFORE_BODY;
pub const Z_PACKED_UNION_END = Z_COMPILER_PACKED_UNION_AFTER_BODY;
pub inline fn Z_FAM(member: anytype) @TypeOf(member) {
    _ = &member;
    return member;
}
pub const Z_types_bitwise_H = "";
pub const Z_inspection_ISA_H = "";
pub const Z_keys_ISA_H = "";
pub const Z_ISA_UNKNOWN = @as(c_int, 0);
pub const Z_ISA_6502 = @as(c_int, 1);
pub const Z_ISA_AARCH32 = @as(c_int, 2);
pub const Z_ISA_AARCH64 = @as(c_int, 3);
pub const Z_ISA_ALPHA = @as(c_int, 4);
pub const Z_ISA_ARC = @as(c_int, 5);
pub const Z_ISA_BLACKFIN = @as(c_int, 6);
pub const Z_ISA_CONVEX = @as(c_int, 7);
pub const Z_ISA_EPIPHANY = @as(c_int, 8);
pub const Z_ISA_ESA_370 = @as(c_int, 9);
pub const Z_ISA_ESA_390 = @as(c_int, 10);
pub const Z_ISA_HEXAGON = @as(c_int, 11);
pub const Z_ISA_IA_64 = @as(c_int, 12);
pub const Z_ISA_LA32R = @as(c_int, 13);
pub const Z_ISA_LA32S = @as(c_int, 14);
pub const Z_ISA_LA64 = @as(c_int, 15);
pub const Z_ISA_LANAI = @as(c_int, 16);
pub const Z_ISA_LATTICE_MICO_32 = @as(c_int, 17);
pub const Z_ISA_M68K = @as(c_int, 18);
pub const Z_ISA_MIPS = @as(c_int, 19);
pub const Z_ISA_MIPS64 = @as(c_int, 20);
pub const Z_ISA_MSP430 = @as(c_int, 21);
pub const Z_ISA_PA_RISC = @as(c_int, 22);
pub const Z_ISA_PA_RISC_2 = @as(c_int, 23);
pub const Z_ISA_POWERPC_32BIT = @as(c_int, 24);
pub const Z_ISA_POWERPC_64BIT = @as(c_int, 25);
pub const Z_ISA_RV32E = @as(c_int, 26);
pub const Z_ISA_RV32I = @as(c_int, 27);
pub const Z_ISA_RV64E = @as(c_int, 28);
pub const Z_ISA_RV64I = @as(c_int, 29);
pub const Z_ISA_RV128I = @as(c_int, 30);
pub const Z_ISA_SPARC = @as(c_int, 31);
pub const Z_ISA_SPARC_V9 = @as(c_int, 32);
pub const Z_ISA_SUPERH = @as(c_int, 33);
pub const Z_ISA_SUPERH_5 = @as(c_int, 34);
pub const Z_ISA_VAX = @as(c_int, 35);
pub const Z_ISA_WASM32 = @as(c_int, 36);
pub const Z_ISA_WASM64 = @as(c_int, 37);
pub const Z_ISA_X86_16 = @as(c_int, 38);
pub const Z_ISA_X86_32 = @as(c_int, 39);
pub const Z_ISA_X86_64 = @as(c_int, 40);
pub const Z_ISA_XCORE = @as(c_int, 41);
pub const Z_ISA_Z_ARCHITECTURE = @as(c_int, 42);
pub const Z_ISA_Z80 = @as(c_int, 43);
pub const Z_ISA_NAME_UNKNOWN = "unknown ISA";
pub const Z_ISA_NAME_6502 = "6502";
pub const Z_ISA_NAME_AARCH32 = "AArch32";
pub const Z_ISA_NAME_AARCH64 = "AArch64";
pub const Z_ISA_NAME_ALPHA = "Alpha";
pub const Z_ISA_NAME_ARC = "ARC";
pub const Z_ISA_NAME_BLACKFIN = "Blackfin";
pub const Z_ISA_NAME_CONVEX = "Convex";
pub const Z_ISA_NAME_EPIPHANY = "Epiphany";
pub const Z_ISA_NAME_ESA_370 = "ESA/370";
pub const Z_ISA_NAME_ESA_390 = "ESA/390";
pub const Z_ISA_NAME_HEXAGON = "Hexagon";
pub const Z_ISA_NAME_IA_64 = "IA-64";
pub const Z_ISA_NAME_LA32R = "LA32R";
pub const Z_ISA_NAME_LA32S = "LA32S";
pub const Z_ISA_NAME_LA64 = "LA64";
pub const Z_ISA_NAME_LANAI = "Lanai";
pub const Z_ISA_NAME_LATTICE_MICO_32 = "LatticeMico32";
pub const Z_ISA_NAME_M68K = "M68K";
pub const Z_ISA_NAME_MIPS = "MIPS";
pub const Z_ISA_NAME_MIPS64 = "MIPS64";
pub const Z_ISA_NAME_MSP430 = "MSP430";
pub const Z_ISA_NAME_PA_RISC = "PA-RISC";
pub const Z_ISA_NAME_PA_RISC_2 = "PA-RISC 2.0";
pub const Z_ISA_NAME_POWERPC_32BIT = "PowerPC 32-bit";
pub const Z_ISA_NAME_POWERPC_64BIT = "PowerPC 64-bit";
pub const Z_ISA_NAME_RV32E = "RV32E";
pub const Z_ISA_NAME_RV32I = "RV32I";
pub const Z_ISA_NAME_RV64E = "RV64E";
pub const Z_ISA_NAME_RV64I = "RV64I";
pub const Z_ISA_NAME_RV128I = "RV128I";
pub const Z_ISA_NAME_SPARC = "SPARC";
pub const Z_ISA_NAME_SPARC_V9 = "SPARC V9";
pub const Z_ISA_NAME_SUPERH = "SuperH";
pub const Z_ISA_NAME_SUPERH_5 = "SuperH 5";
pub const Z_ISA_NAME_VAX = "VAX";
pub const Z_ISA_NAME_WASM32 = "Wasm32";
pub const Z_ISA_NAME_WASM64 = "Wasm64";
pub const Z_ISA_NAME_X86_16 = "x86-16";
pub const Z_ISA_NAME_X86_32 = "x86-32";
pub const Z_ISA_NAME_X86_64 = "x86-64";
pub const Z_ISA_NAME_XCORE = "xCORE";
pub const Z_ISA_NAME_Z_ARCHITECTURE = "z/Architecture";
pub const Z_ISA_NAME_Z80 = "Z80";
pub const Z_keys_endianness_H = "";
pub const Z_ENDIANNESS_LITTLE = @as(c_int, 0);
pub const Z_ENDIANNESS_BIG = @as(c_int, 1);
pub const Z_ENDIANNESS_PDP = @as(c_int, 2);
pub const Z_ISA = Z_COMPILER_ISA;
pub const Z_ISA_IS_AARCH64 = @as(c_int, 1);
pub const Z_ISA_NAME = Z_ISA_NAME_AARCH64;
pub const Z_ISA_INTEGRAL_ENDIANNESS = Z_COMPILER_ISA_INTEGRAL_ENDIANNESS;
pub const Z_ISA_IS = @compileError("unable to translate macro: undefined identifier `Z_ISA_IS_`");
// /opt/homebrew/include/Z/inspection/ISA.h:203:9
pub const Z_ISA_HAS_INTEGRAL = @compileError("unable to translate macro: undefined identifier `Z_ISA_HAS_INTEGRAL_`");
// /opt/homebrew/include/Z/inspection/ISA.h:204:9
pub const Z_types_integral_H = "";
pub const Z_constants_boolean_H = "";
pub const TRUE = @as(c_int, 1);
pub const FALSE = @as(c_int, 0);
pub const Z_TRUE = @as(c_int, 1);
pub const Z_FALSE = @as(c_int, 0);
pub const Z_inspection_data_model_H = "";
pub const Z_keys_data_model_H = "";
pub const Z_DATA_MODEL_IP16L32 = @as(c_int, 1);
pub const Z_DATA_MODEL_I16LP32 = @as(c_int, 2);
pub const Z_DATA_MODEL_LP32 = @as(c_int, 3);
pub const Z_DATA_MODEL_ILP32 = @as(c_int, 4);
pub const Z_DATA_MODEL_LLP64 = @as(c_int, 5);
pub const Z_DATA_MODEL_LP64 = @as(c_int, 6);
pub const Z_DATA_MODEL_ILP64 = @as(c_int, 7);
pub const Z_DATA_MODEL_SILP64 = @as(c_int, 8);
pub const Z_DATA_MODEL_NAME_IP16L32 = "IP16L32";
pub const Z_DATA_MODEL_NAME_I16LP32 = "I16LP32";
pub const Z_DATA_MODEL_NAME_LP32 = "LP32";
pub const Z_DATA_MODEL_NAME_ILP32 = "ILP32";
pub const Z_DATA_MODEL_NAME_LP64 = "LP64";
pub const Z_DATA_MODEL_NAME_LLP64 = "LLP64";
pub const Z_DATA_MODEL_NAME_ILP64 = "ILP64";
pub const Z_DATA_MODEL_NAME_SILP64 = "SILP64";
pub const Z_keys_fundamental_H = "";
pub const Z_FUNDAMENTAL_VOID = @as(c_int, 0);
pub const Z_FUNDAMENTAL_CHAR = @as(c_int, 1);
pub const Z_FUNDAMENTAL_UCHAR = @as(c_int, 2);
pub const Z_FUNDAMENTAL_SCHAR = @as(c_int, 3);
pub const Z_FUNDAMENTAL_USHORT = @as(c_int, 4);
pub const Z_FUNDAMENTAL_SSHORT = @as(c_int, 5);
pub const Z_FUNDAMENTAL_UINT = @as(c_int, 6);
pub const Z_FUNDAMENTAL_SINT = @as(c_int, 7);
pub const Z_FUNDAMENTAL_ULONG = @as(c_int, 8);
pub const Z_FUNDAMENTAL_SLONG = @as(c_int, 9);
pub const Z_FUNDAMENTAL_ULLONG = @as(c_int, 10);
pub const Z_FUNDAMENTAL_SLLONG = @as(c_int, 11);
pub const Z_FUNDAMENTAL_BOOL = @as(c_int, 12);
pub const Z_FUNDAMENTAL_WCHAR = @as(c_int, 13);
pub const Z_FUNDAMENTAL_CHAR8 = @as(c_int, 14);
pub const Z_FUNDAMENTAL_CHAR16 = @as(c_int, 15);
pub const Z_FUNDAMENTAL_CHAR32 = @as(c_int, 16);
pub const Z_FUNDAMENTAL_FLOAT = @as(c_int, 17);
pub const Z_FUNDAMENTAL_DOUBLE = @as(c_int, 18);
pub const Z_FUNDAMENTAL_LDOUBLE = @as(c_int, 19);
pub const Z_FUNDAMENTAL_FLOAT16 = @as(c_int, 20);
pub const Z_FUNDAMENTAL_FLOAT32 = @as(c_int, 21);
pub const Z_FUNDAMENTAL_FLOAT64 = @as(c_int, 22);
pub const Z_FUNDAMENTAL_FLOAT128 = @as(c_int, 23);
pub const Z_FUNDAMENTAL_FLOAT32X = @as(c_int, 24);
pub const Z_FUNDAMENTAL_FLOAT64X = @as(c_int, 25);
pub const Z_FUNDAMENTAL_FLOAT128X = @as(c_int, 26);
pub const Z_FUNDAMENTAL_DECIMAL32 = @as(c_int, 27);
pub const Z_FUNDAMENTAL_DECIMAL64 = @as(c_int, 28);
pub const Z_FUNDAMENTAL_DECIMAL128 = @as(c_int, 29);
pub const Z_FUNDAMENTAL_DECIMAL64X = @as(c_int, 30);
pub const Z_FUNDAMENTAL_DECIMAL128X = @as(c_int, 31);
pub const Z_FUNDAMENTAL_NULLPTR = @as(c_int, 32);
pub const Z_FUNDAMENTAL_UINT8 = @as(c_int, 100);
pub const Z_FUNDAMENTAL_SINT8 = @as(c_int, 101);
pub const Z_FUNDAMENTAL_UINT16 = @as(c_int, 102);
pub const Z_FUNDAMENTAL_SINT16 = @as(c_int, 103);
pub const Z_FUNDAMENTAL_UINT24 = @as(c_int, 104);
pub const Z_FUNDAMENTAL_SINT24 = @as(c_int, 105);
pub const Z_FUNDAMENTAL_UINT32 = @as(c_int, 106);
pub const Z_FUNDAMENTAL_SINT32 = @as(c_int, 107);
pub const Z_FUNDAMENTAL_UINT40 = @as(c_int, 108);
pub const Z_FUNDAMENTAL_SINT40 = @as(c_int, 109);
pub const Z_FUNDAMENTAL_UINT48 = @as(c_int, 110);
pub const Z_FUNDAMENTAL_SINT48 = @as(c_int, 111);
pub const Z_FUNDAMENTAL_UINT56 = @as(c_int, 112);
pub const Z_FUNDAMENTAL_SINT56 = @as(c_int, 113);
pub const Z_FUNDAMENTAL_UINT64 = @as(c_int, 114);
pub const Z_FUNDAMENTAL_SINT64 = @as(c_int, 115);
pub const Z_FUNDAMENTAL_UINT128 = @as(c_int, 116);
pub const Z_FUNDAMENTAL_SINT128 = @as(c_int, 117);
pub const Z_FUNDAMENTAL_BFP16 = @as(c_int, 150);
pub const Z_FUNDAMENTAL_BFP32 = @as(c_int, 151);
pub const Z_FUNDAMENTAL_BFP64 = @as(c_int, 152);
pub const Z_FUNDAMENTAL_BFP128 = @as(c_int, 153);
pub const Z_FUNDAMENTAL_DFP32 = @as(c_int, 154);
pub const Z_FUNDAMENTAL_DFP64 = @as(c_int, 155);
pub const Z_FUNDAMENTAL_DFP128 = @as(c_int, 156);
pub const Z_FUNDAMENTAL_X87_DE80 = @as(c_int, 157);
pub const Z_FUNDAMENTAL_X87_DE96 = @as(c_int, 158);
pub const Z_FUNDAMENTAL_X87_DE128 = @as(c_int, 159);
pub const Z_FUNDAMENTAL_IBM_ED = @as(c_int, 160);
pub const Z_FUNDAMENTAL_BFLOAT16 = @as(c_int, 162);
pub const Z_DATA_MODEL = Z_COMPILER_DATA_MODEL;
pub const Z_formats_data_model_LP64_H = "";
pub const Z_LP64_WIDTH_CHAR = @as(c_int, 8);
pub const Z_LP64_WIDTH_SHORT = @as(c_int, 16);
pub const Z_LP64_WIDTH_INT = @as(c_int, 32);
pub const Z_LP64_WIDTH_LONG = @as(c_int, 64);
pub const Z_LP64_WIDTH_LLONG = @as(c_int, 64);
pub const Z_LP64_WIDTH_SIZE = @as(c_int, 64);
pub const Z_LP64_WIDTH_POINTER = @as(c_int, 64);
pub const Z_DATA_MODEL_IS_LP64 = @as(c_int, 1);
pub const Z_DATA_MODEL_NAME = Z_DATA_MODEL_NAME_LP64;
pub const Z_INSERT_DATA_MODEL = @compileError("unable to translate macro: undefined identifier `LP64`");
// /opt/homebrew/include/Z/inspection/data_model.h:79:10
pub const Z_DATA_MODEL_IS = @compileError("unable to translate macro: undefined identifier `Z_DATA_MODEL_IS_`");
// /opt/homebrew/include/Z/inspection/data_model.h:94:9
pub const Z_DATA_MODEL_HAS_LITERAL = @compileError("unable to translate macro: undefined identifier `Z_DATA_MODEL_HAS_LITERAL_`");
// /opt/homebrew/include/Z/inspection/data_model.h:95:9
pub const Z_DATA_MODEL_HAS_TYPE = @compileError("unable to translate macro: undefined identifier `Z_DATA_MODEL_HAS_TYPE_`");
// /opt/homebrew/include/Z/inspection/data_model.h:96:9
pub const Z_DATA_MODEL_WIDTH = @compileError("unable to translate macro: undefined identifier `Z_`");
// /opt/homebrew/include/Z/inspection/data_model.h:97:9
pub const Z_DATA_MODEL_FUNDAMENTAL = @compileError("unable to translate macro: undefined identifier `Z_DATA_MODEL_FUNDAMENTAL_`");
// /opt/homebrew/include/Z/inspection/data_model.h:98:9
pub const Z_DATA_MODEL_LITERAL = @compileError("unable to translate macro: undefined identifier `Z_DATA_MODEL_LITERAL_`");
// /opt/homebrew/include/Z/inspection/data_model.h:99:9
pub const Z_DATA_MODEL_TYPE = @compileError("unable to translate macro: undefined identifier `Z_DATA_MODEL_TYPE_`");
// /opt/homebrew/include/Z/inspection/data_model.h:100:9
pub const Z_DATA_MODEL_TYPE_UINT8 = u8;
pub const Z_DATA_MODEL_FUNDAMENTAL_UINT8 = Z_FUNDAMENTAL_UCHAR;
pub const Z_DATA_MODEL_LITERAL_UINT8 = Z_SUFFIX_U;
pub const Z_DATA_MODEL_TYPE_SINT8 = i8;
pub const Z_DATA_MODEL_FUNDAMENTAL_SINT8 = Z_FUNDAMENTAL_SCHAR;
pub const Z_DATA_MODEL_LITERAL_SINT8 = Z_SAME;
pub const Z_DATA_MODEL_HAS_TYPE_UINT8 = @as(c_int, 1);
pub const Z_DATA_MODEL_HAS_LITERAL_UINT8 = @as(c_int, 1);
pub const Z_DATA_MODEL_HAS_TYPE_SINT8 = @as(c_int, 1);
pub const Z_DATA_MODEL_HAS_LITERAL_SINT8 = @as(c_int, 1);
pub const Z_DATA_MODEL_TYPE_UINT16 = c_ushort;
pub const Z_DATA_MODEL_FUNDAMENTAL_UINT16 = Z_FUNDAMENTAL_USHORT;
pub const Z_DATA_MODEL_LITERAL_UINT16 = Z_SUFFIX_U;
pub const Z_DATA_MODEL_TYPE_SINT16 = c_short;
pub const Z_DATA_MODEL_FUNDAMENTAL_SINT16 = Z_FUNDAMENTAL_SSHORT;
pub const Z_DATA_MODEL_LITERAL_SINT16 = Z_SAME;
pub const Z_DATA_MODEL_HAS_TYPE_UINT16 = @as(c_int, 1);
pub const Z_DATA_MODEL_HAS_LITERAL_UINT16 = @as(c_int, 1);
pub const Z_DATA_MODEL_HAS_TYPE_SINT16 = @as(c_int, 1);
pub const Z_DATA_MODEL_HAS_LITERAL_SINT16 = @as(c_int, 1);
pub const Z_DATA_MODEL_TYPE_UINT32 = c_uint;
pub const Z_DATA_MODEL_FUNDAMENTAL_UINT32 = Z_FUNDAMENTAL_UINT;
pub const Z_DATA_MODEL_LITERAL_UINT32 = Z_SUFFIX_U;
pub const Z_DATA_MODEL_TYPE_SINT32 = c_int;
pub const Z_DATA_MODEL_FUNDAMENTAL_SINT32 = Z_FUNDAMENTAL_SINT;
pub const Z_DATA_MODEL_LITERAL_SINT32 = Z_SAME;
pub const Z_DATA_MODEL_HAS_TYPE_UINT32 = @as(c_int, 1);
pub const Z_DATA_MODEL_HAS_LITERAL_UINT32 = @as(c_int, 1);
pub const Z_DATA_MODEL_HAS_TYPE_SINT32 = @as(c_int, 1);
pub const Z_DATA_MODEL_HAS_LITERAL_SINT32 = @as(c_int, 1);
pub const Z_DATA_MODEL_TYPE_UINT64 = c_ulong;
pub const Z_DATA_MODEL_FUNDAMENTAL_UINT64 = Z_FUNDAMENTAL_ULONG;
pub const Z_DATA_MODEL_LITERAL_UINT64 = Z_SUFFIX_UL;
pub const Z_DATA_MODEL_TYPE_SINT64 = c_long;
pub const Z_DATA_MODEL_FUNDAMENTAL_SINT64 = Z_FUNDAMENTAL_SLONG;
pub const Z_DATA_MODEL_LITERAL_SINT64 = Z_SUFFIX_L;
pub const Z_DATA_MODEL_HAS_TYPE_UINT64 = @as(c_int, 1);
pub const Z_DATA_MODEL_HAS_LITERAL_UINT64 = @as(c_int, 1);
pub const Z_DATA_MODEL_HAS_TYPE_SINT64 = @as(c_int, 1);
pub const Z_DATA_MODEL_HAS_LITERAL_SINT64 = @as(c_int, 1);
pub const Z_DATA_MODEL_TYPE_UINT128 = @compileError("unable to translate macro: undefined identifier `UINT128`");
// /opt/homebrew/include/Z/inspection/data_model.h:377:11
pub const Z_DATA_MODEL_FUNDAMENTAL_UINT128 = Z_FUNDAMENTAL_UINT128;
pub const Z_DATA_MODEL_TYPE_SINT128 = @compileError("unable to translate macro: undefined identifier `SINT128`");
// /opt/homebrew/include/Z/inspection/data_model.h:386:11
pub const Z_DATA_MODEL_FUNDAMENTAL_SINT128 = Z_FUNDAMENTAL_SINT128;
pub const Z_DATA_MODEL_HAS_TYPE_UINT128 = @as(c_int, 1);
pub const Z_DATA_MODEL_LITERAL_UINT128 = Z_SUFFIX_U;
pub const Z_DATA_MODEL_HAS_TYPE_SINT128 = @as(c_int, 1);
pub const Z_DATA_MODEL_LITERAL_SINT128 = Z_SAME;
pub const Z_macros_T_H = "";
pub const Z_z_APPEND_TYPE_1 = @compileError("unable to translate macro: undefined identifier `CHAR`");
// /opt/homebrew/include/Z/macros/T.h:14:9
pub const Z_z_APPEND_Type_1 = @compileError("unable to translate macro: undefined identifier `Char`");
// /opt/homebrew/include/Z/macros/T.h:15:9
pub const Z_z_APPEND_type_1 = @compileError("unable to translate C expr: unexpected token '##'");
// /opt/homebrew/include/Z/macros/T.h:16:9
pub const Z_z_INSERT_TYPE_1 = @compileError("unable to translate macro: undefined identifier `CHAR`");
// /opt/homebrew/include/Z/macros/T.h:17:9
pub const Z_z_INSERT_Type_1 = @compileError("unable to translate macro: undefined identifier `Char`");
// /opt/homebrew/include/Z/macros/T.h:18:9
pub const Z_z_INSERT_type_1 = @compileError("unable to translate C expr: unexpected token '##'");
// /opt/homebrew/include/Z/macros/T.h:19:9
pub const Z_z_APPEND_TYPE_2 = @compileError("unable to translate macro: undefined identifier `UCHAR`");
// /opt/homebrew/include/Z/macros/T.h:21:9
pub const Z_z_APPEND_Type_2 = @compileError("unable to translate macro: undefined identifier `UChar`");
// /opt/homebrew/include/Z/macros/T.h:22:9
pub const Z_z_APPEND_type_2 = @compileError("unable to translate macro: undefined identifier `uchar`");
// /opt/homebrew/include/Z/macros/T.h:23:9
pub const Z_z_INSERT_TYPE_2 = @compileError("unable to translate macro: undefined identifier `UCHAR`");
// /opt/homebrew/include/Z/macros/T.h:24:9
pub const Z_z_INSERT_Type_2 = @compileError("unable to translate macro: undefined identifier `UChar`");
// /opt/homebrew/include/Z/macros/T.h:25:9
pub const Z_z_INSERT_type_2 = @compileError("unable to translate macro: undefined identifier `uchar`");
// /opt/homebrew/include/Z/macros/T.h:26:9
pub const Z_z_APPEND_TYPE_3 = @compileError("unable to translate macro: undefined identifier `SCHAR`");
// /opt/homebrew/include/Z/macros/T.h:28:9
pub const Z_z_APPEND_Type_3 = @compileError("unable to translate macro: undefined identifier `SChar`");
// /opt/homebrew/include/Z/macros/T.h:29:9
pub const Z_z_APPEND_type_3 = @compileError("unable to translate macro: undefined identifier `schar`");
// /opt/homebrew/include/Z/macros/T.h:30:9
pub const Z_z_INSERT_TYPE_3 = @compileError("unable to translate macro: undefined identifier `SCHAR`");
// /opt/homebrew/include/Z/macros/T.h:31:9
pub const Z_z_INSERT_Type_3 = @compileError("unable to translate macro: undefined identifier `SChar`");
// /opt/homebrew/include/Z/macros/T.h:32:9
pub const Z_z_INSERT_type_3 = @compileError("unable to translate macro: undefined identifier `schar`");
// /opt/homebrew/include/Z/macros/T.h:33:9
pub const Z_z_APPEND_TYPE_4 = @compileError("unable to translate macro: undefined identifier `USHORT`");
// /opt/homebrew/include/Z/macros/T.h:35:9
pub const Z_z_APPEND_Type_4 = @compileError("unable to translate macro: undefined identifier `UShort`");
// /opt/homebrew/include/Z/macros/T.h:36:9
pub const Z_z_APPEND_type_4 = @compileError("unable to translate macro: undefined identifier `ushort`");
// /opt/homebrew/include/Z/macros/T.h:37:9
pub const Z_z_INSERT_TYPE_4 = @compileError("unable to translate macro: undefined identifier `USHORT`");
// /opt/homebrew/include/Z/macros/T.h:38:9
pub const Z_z_INSERT_Type_4 = @compileError("unable to translate macro: undefined identifier `UShort`");
// /opt/homebrew/include/Z/macros/T.h:39:9
pub const Z_z_INSERT_type_4 = @compileError("unable to translate macro: undefined identifier `ushort`");
// /opt/homebrew/include/Z/macros/T.h:40:9
pub const Z_z_APPEND_TYPE_5 = @compileError("unable to translate macro: undefined identifier `SSHORT`");
// /opt/homebrew/include/Z/macros/T.h:42:9
pub const Z_z_APPEND_Type_5 = @compileError("unable to translate macro: undefined identifier `SShort`");
// /opt/homebrew/include/Z/macros/T.h:43:9
pub const Z_z_APPEND_type_5 = @compileError("unable to translate macro: undefined identifier `sshort`");
// /opt/homebrew/include/Z/macros/T.h:44:9
pub const Z_z_INSERT_TYPE_5 = @compileError("unable to translate macro: undefined identifier `SSHORT`");
// /opt/homebrew/include/Z/macros/T.h:45:9
pub const Z_z_INSERT_Type_5 = @compileError("unable to translate macro: undefined identifier `SShort`");
// /opt/homebrew/include/Z/macros/T.h:46:9
pub const Z_z_INSERT_type_5 = @compileError("unable to translate macro: undefined identifier `sshort`");
// /opt/homebrew/include/Z/macros/T.h:47:9
pub const Z_z_APPEND_TYPE_6 = @compileError("unable to translate macro: undefined identifier `UINT`");
// /opt/homebrew/include/Z/macros/T.h:49:9
pub const Z_z_APPEND_Type_6 = @compileError("unable to translate macro: undefined identifier `UInt`");
// /opt/homebrew/include/Z/macros/T.h:50:9
pub const Z_z_APPEND_type_6 = @compileError("unable to translate macro: undefined identifier `uint`");
// /opt/homebrew/include/Z/macros/T.h:51:9
pub const Z_z_INSERT_TYPE_6 = @compileError("unable to translate macro: undefined identifier `UINT`");
// /opt/homebrew/include/Z/macros/T.h:52:9
pub const Z_z_INSERT_Type_6 = @compileError("unable to translate macro: undefined identifier `UInt`");
// /opt/homebrew/include/Z/macros/T.h:53:9
pub const Z_z_INSERT_type_6 = @compileError("unable to translate macro: undefined identifier `uint`");
// /opt/homebrew/include/Z/macros/T.h:54:9
pub const Z_z_APPEND_TYPE_7 = @compileError("unable to translate macro: undefined identifier `SINT`");
// /opt/homebrew/include/Z/macros/T.h:56:9
pub const Z_z_APPEND_Type_7 = @compileError("unable to translate macro: undefined identifier `SInt`");
// /opt/homebrew/include/Z/macros/T.h:57:9
pub const Z_z_APPEND_type_7 = @compileError("unable to translate macro: undefined identifier `sint`");
// /opt/homebrew/include/Z/macros/T.h:58:9
pub const Z_z_INSERT_TYPE_7 = @compileError("unable to translate macro: undefined identifier `SINT`");
// /opt/homebrew/include/Z/macros/T.h:59:9
pub const Z_z_INSERT_Type_7 = @compileError("unable to translate macro: undefined identifier `SInt`");
// /opt/homebrew/include/Z/macros/T.h:60:9
pub const Z_z_INSERT_type_7 = @compileError("unable to translate macro: undefined identifier `sint`");
// /opt/homebrew/include/Z/macros/T.h:61:9
pub const Z_z_APPEND_TYPE_8 = @compileError("unable to translate macro: undefined identifier `ULONG`");
// /opt/homebrew/include/Z/macros/T.h:63:9
pub const Z_z_APPEND_Type_8 = @compileError("unable to translate macro: undefined identifier `ULong`");
// /opt/homebrew/include/Z/macros/T.h:64:9
pub const Z_z_APPEND_type_8 = @compileError("unable to translate macro: undefined identifier `ulong`");
// /opt/homebrew/include/Z/macros/T.h:65:9
pub const Z_z_INSERT_TYPE_8 = @compileError("unable to translate macro: undefined identifier `ULONG`");
// /opt/homebrew/include/Z/macros/T.h:66:9
pub const Z_z_INSERT_Type_8 = @compileError("unable to translate macro: undefined identifier `ULong`");
// /opt/homebrew/include/Z/macros/T.h:67:9
pub const Z_z_INSERT_type_8 = @compileError("unable to translate macro: undefined identifier `ulong`");
// /opt/homebrew/include/Z/macros/T.h:68:9
pub const Z_z_APPEND_TYPE_9 = @compileError("unable to translate macro: undefined identifier `SLONG`");
// /opt/homebrew/include/Z/macros/T.h:70:9
pub const Z_z_APPEND_Type_9 = @compileError("unable to translate macro: undefined identifier `SLong`");
// /opt/homebrew/include/Z/macros/T.h:71:9
pub const Z_z_APPEND_type_9 = @compileError("unable to translate macro: undefined identifier `slong`");
// /opt/homebrew/include/Z/macros/T.h:72:9
pub const Z_z_INSERT_TYPE_9 = @compileError("unable to translate macro: undefined identifier `SLONG`");
// /opt/homebrew/include/Z/macros/T.h:73:9
pub const Z_z_INSERT_Type_9 = @compileError("unable to translate macro: undefined identifier `SLong`");
// /opt/homebrew/include/Z/macros/T.h:74:9
pub const Z_z_INSERT_type_9 = @compileError("unable to translate macro: undefined identifier `slong`");
// /opt/homebrew/include/Z/macros/T.h:75:9
pub const Z_z_APPEND_TYPE_10 = @compileError("unable to translate macro: undefined identifier `ULLONG`");
// /opt/homebrew/include/Z/macros/T.h:77:9
pub const Z_z_APPEND_Type_10 = @compileError("unable to translate macro: undefined identifier `ULLong`");
// /opt/homebrew/include/Z/macros/T.h:78:9
pub const Z_z_APPEND_type_10 = @compileError("unable to translate macro: undefined identifier `ullong`");
// /opt/homebrew/include/Z/macros/T.h:79:9
pub const Z_z_INSERT_TYPE_10 = @compileError("unable to translate macro: undefined identifier `ULLONG`");
// /opt/homebrew/include/Z/macros/T.h:80:9
pub const Z_z_INSERT_Type_10 = @compileError("unable to translate macro: undefined identifier `ULLong`");
// /opt/homebrew/include/Z/macros/T.h:81:9
pub const Z_z_INSERT_type_10 = @compileError("unable to translate macro: undefined identifier `ullong`");
// /opt/homebrew/include/Z/macros/T.h:82:9
pub const Z_z_APPEND_TYPE_11 = @compileError("unable to translate macro: undefined identifier `SLLONG`");
// /opt/homebrew/include/Z/macros/T.h:84:9
pub const Z_z_APPEND_Type_11 = @compileError("unable to translate macro: undefined identifier `SLLong`");
// /opt/homebrew/include/Z/macros/T.h:85:9
pub const Z_z_APPEND_type_11 = @compileError("unable to translate macro: undefined identifier `sllong`");
// /opt/homebrew/include/Z/macros/T.h:86:9
pub const Z_z_INSERT_TYPE_11 = @compileError("unable to translate macro: undefined identifier `SLLONG`");
// /opt/homebrew/include/Z/macros/T.h:87:9
pub const Z_z_INSERT_Type_11 = @compileError("unable to translate macro: undefined identifier `SLLong`");
// /opt/homebrew/include/Z/macros/T.h:88:9
pub const Z_z_INSERT_type_11 = @compileError("unable to translate macro: undefined identifier `sllong`");
// /opt/homebrew/include/Z/macros/T.h:89:9
pub const Z_z_APPEND_TYPE_13 = @compileError("unable to translate macro: undefined identifier `WCHAR`");
// /opt/homebrew/include/Z/macros/T.h:91:9
pub const Z_z_APPEND_Type_13 = @compileError("unable to translate macro: undefined identifier `WChar`");
// /opt/homebrew/include/Z/macros/T.h:92:9
pub const Z_z_APPEND_type_13 = @compileError("unable to translate macro: undefined identifier `wchar`");
// /opt/homebrew/include/Z/macros/T.h:93:9
pub const Z_z_INSERT_TYPE_13 = @compileError("unable to translate macro: undefined identifier `WCHAR`");
// /opt/homebrew/include/Z/macros/T.h:94:9
pub const Z_z_INSERT_Type_13 = @compileError("unable to translate macro: undefined identifier `WChar`");
// /opt/homebrew/include/Z/macros/T.h:95:9
pub const Z_z_INSERT_type_13 = @compileError("unable to translate macro: undefined identifier `wchar`");
// /opt/homebrew/include/Z/macros/T.h:96:9
pub const Z_z_APPEND_TYPE_14 = @compileError("unable to translate macro: undefined identifier `CHAR8`");
// /opt/homebrew/include/Z/macros/T.h:98:9
pub const Z_z_APPEND_Type_14 = @compileError("unable to translate macro: undefined identifier `Char8`");
// /opt/homebrew/include/Z/macros/T.h:99:9
pub const Z_z_APPEND_type_14 = @compileError("unable to translate macro: undefined identifier `char8`");
// /opt/homebrew/include/Z/macros/T.h:100:9
pub const Z_z_INSERT_TYPE_14 = @compileError("unable to translate macro: undefined identifier `CHAR8`");
// /opt/homebrew/include/Z/macros/T.h:101:9
pub const Z_z_INSERT_Type_14 = @compileError("unable to translate macro: undefined identifier `Char8`");
// /opt/homebrew/include/Z/macros/T.h:102:9
pub const Z_z_INSERT_type_14 = @compileError("unable to translate macro: undefined identifier `char8`");
// /opt/homebrew/include/Z/macros/T.h:103:9
pub const Z_z_APPEND_TYPE_15 = @compileError("unable to translate macro: undefined identifier `CHAR16`");
// /opt/homebrew/include/Z/macros/T.h:105:9
pub const Z_z_APPEND_Type_15 = @compileError("unable to translate macro: undefined identifier `Char16`");
// /opt/homebrew/include/Z/macros/T.h:106:9
pub const Z_z_APPEND_type_15 = @compileError("unable to translate macro: undefined identifier `char16`");
// /opt/homebrew/include/Z/macros/T.h:107:9
pub const Z_z_INSERT_TYPE_15 = @compileError("unable to translate macro: undefined identifier `CHAR16`");
// /opt/homebrew/include/Z/macros/T.h:108:9
pub const Z_z_INSERT_Type_15 = @compileError("unable to translate macro: undefined identifier `Char16`");
// /opt/homebrew/include/Z/macros/T.h:109:9
pub const Z_z_INSERT_type_15 = @compileError("unable to translate macro: undefined identifier `char16`");
// /opt/homebrew/include/Z/macros/T.h:110:9
pub const Z_z_APPEND_TYPE_16 = @compileError("unable to translate macro: undefined identifier `CHAR32`");
// /opt/homebrew/include/Z/macros/T.h:112:9
pub const Z_z_APPEND_Type_16 = @compileError("unable to translate macro: undefined identifier `Char32`");
// /opt/homebrew/include/Z/macros/T.h:113:9
pub const Z_z_APPEND_type_16 = @compileError("unable to translate macro: undefined identifier `char32`");
// /opt/homebrew/include/Z/macros/T.h:114:9
pub const Z_z_INSERT_TYPE_16 = @compileError("unable to translate macro: undefined identifier `CHAR32`");
// /opt/homebrew/include/Z/macros/T.h:115:9
pub const Z_z_INSERT_Type_16 = @compileError("unable to translate macro: undefined identifier `Char32`");
// /opt/homebrew/include/Z/macros/T.h:116:9
pub const Z_z_INSERT_type_16 = @compileError("unable to translate macro: undefined identifier `char32`");
// /opt/homebrew/include/Z/macros/T.h:117:9
pub const Z_z_APPEND_TYPE_17 = @compileError("unable to translate macro: undefined identifier `FLOAT`");
// /opt/homebrew/include/Z/macros/T.h:119:9
pub const Z_z_APPEND_Type_17 = @compileError("unable to translate macro: undefined identifier `Float`");
// /opt/homebrew/include/Z/macros/T.h:120:9
pub const Z_z_APPEND_type_17 = @compileError("unable to translate C expr: unexpected token '##'");
// /opt/homebrew/include/Z/macros/T.h:121:9
pub const Z_z_INSERT_TYPE_17 = @compileError("unable to translate macro: undefined identifier `FLOAT`");
// /opt/homebrew/include/Z/macros/T.h:122:9
pub const Z_z_INSERT_Type_17 = @compileError("unable to translate macro: undefined identifier `Float`");
// /opt/homebrew/include/Z/macros/T.h:123:9
pub const Z_z_INSERT_type_17 = @compileError("unable to translate C expr: unexpected token '##'");
// /opt/homebrew/include/Z/macros/T.h:124:9
pub const Z_z_APPEND_TYPE_18 = @compileError("unable to translate macro: undefined identifier `DOUBLE`");
// /opt/homebrew/include/Z/macros/T.h:126:9
pub const Z_z_APPEND_Type_18 = @compileError("unable to translate macro: undefined identifier `Double`");
// /opt/homebrew/include/Z/macros/T.h:127:9
pub const Z_z_APPEND_type_18 = @compileError("unable to translate C expr: unexpected token '##'");
// /opt/homebrew/include/Z/macros/T.h:128:9
pub const Z_z_INSERT_TYPE_18 = @compileError("unable to translate macro: undefined identifier `DOUBLE`");
// /opt/homebrew/include/Z/macros/T.h:129:9
pub const Z_z_INSERT_Type_18 = @compileError("unable to translate macro: undefined identifier `Double`");
// /opt/homebrew/include/Z/macros/T.h:130:9
pub const Z_z_INSERT_type_18 = @compileError("unable to translate C expr: unexpected token '##'");
// /opt/homebrew/include/Z/macros/T.h:131:9
pub const Z_z_APPEND_TYPE_19 = @compileError("unable to translate macro: undefined identifier `LDOUBLE`");
// /opt/homebrew/include/Z/macros/T.h:133:9
pub const Z_z_APPEND_Type_19 = @compileError("unable to translate macro: undefined identifier `LDouble`");
// /opt/homebrew/include/Z/macros/T.h:134:9
pub const Z_z_APPEND_type_19 = @compileError("unable to translate macro: undefined identifier `ldouble`");
// /opt/homebrew/include/Z/macros/T.h:135:9
pub const Z_z_INSERT_TYPE_19 = @compileError("unable to translate macro: undefined identifier `LDOUBLE`");
// /opt/homebrew/include/Z/macros/T.h:136:9
pub const Z_z_INSERT_Type_19 = @compileError("unable to translate macro: undefined identifier `LDouble`");
// /opt/homebrew/include/Z/macros/T.h:137:9
pub const Z_z_INSERT_type_19 = @compileError("unable to translate macro: undefined identifier `ldouble`");
// /opt/homebrew/include/Z/macros/T.h:138:9
pub const Z_z_APPEND_TYPE_20 = @compileError("unable to translate macro: undefined identifier `FLOAT16`");
// /opt/homebrew/include/Z/macros/T.h:140:9
pub const Z_z_APPEND_Type_20 = @compileError("unable to translate macro: undefined identifier `Float16`");
// /opt/homebrew/include/Z/macros/T.h:141:9
pub const Z_z_APPEND_type_20 = @compileError("unable to translate macro: undefined identifier `float16`");
// /opt/homebrew/include/Z/macros/T.h:142:9
pub const Z_z_INSERT_TYPE_20 = @compileError("unable to translate macro: undefined identifier `FLOAT16`");
// /opt/homebrew/include/Z/macros/T.h:143:9
pub const Z_z_INSERT_Type_20 = @compileError("unable to translate macro: undefined identifier `Float16`");
// /opt/homebrew/include/Z/macros/T.h:144:9
pub const Z_z_INSERT_type_20 = @compileError("unable to translate macro: undefined identifier `float16`");
// /opt/homebrew/include/Z/macros/T.h:145:9
pub const Z_z_APPEND_TYPE_21 = @compileError("unable to translate macro: undefined identifier `FLOAT32`");
// /opt/homebrew/include/Z/macros/T.h:147:9
pub const Z_z_APPEND_Type_21 = @compileError("unable to translate macro: undefined identifier `Float32`");
// /opt/homebrew/include/Z/macros/T.h:148:9
pub const Z_z_APPEND_type_21 = @compileError("unable to translate macro: undefined identifier `float32`");
// /opt/homebrew/include/Z/macros/T.h:149:9
pub const Z_z_INSERT_TYPE_21 = @compileError("unable to translate macro: undefined identifier `FLOAT32`");
// /opt/homebrew/include/Z/macros/T.h:150:9
pub const Z_z_INSERT_Type_21 = @compileError("unable to translate macro: undefined identifier `Float32`");
// /opt/homebrew/include/Z/macros/T.h:151:9
pub const Z_z_INSERT_type_21 = @compileError("unable to translate macro: undefined identifier `float32`");
// /opt/homebrew/include/Z/macros/T.h:152:9
pub const Z_z_APPEND_TYPE_22 = @compileError("unable to translate macro: undefined identifier `FLOAT64`");
// /opt/homebrew/include/Z/macros/T.h:154:9
pub const Z_z_APPEND_Type_22 = @compileError("unable to translate macro: undefined identifier `Float64`");
// /opt/homebrew/include/Z/macros/T.h:155:9
pub const Z_z_APPEND_type_22 = @compileError("unable to translate macro: undefined identifier `float64`");
// /opt/homebrew/include/Z/macros/T.h:156:9
pub const Z_z_INSERT_TYPE_22 = @compileError("unable to translate macro: undefined identifier `FLOAT64`");
// /opt/homebrew/include/Z/macros/T.h:157:9
pub const Z_z_INSERT_Type_22 = @compileError("unable to translate macro: undefined identifier `Float64`");
// /opt/homebrew/include/Z/macros/T.h:158:9
pub const Z_z_INSERT_type_22 = @compileError("unable to translate macro: undefined identifier `float64`");
// /opt/homebrew/include/Z/macros/T.h:159:9
pub const Z_z_APPEND_TYPE_23 = @compileError("unable to translate macro: undefined identifier `FLOAT128`");
// /opt/homebrew/include/Z/macros/T.h:161:9
pub const Z_z_APPEND_Type_23 = @compileError("unable to translate macro: undefined identifier `Float128`");
// /opt/homebrew/include/Z/macros/T.h:162:9
pub const Z_z_APPEND_type_23 = @compileError("unable to translate macro: undefined identifier `float128`");
// /opt/homebrew/include/Z/macros/T.h:163:9
pub const Z_z_INSERT_TYPE_23 = @compileError("unable to translate macro: undefined identifier `FLOAT128`");
// /opt/homebrew/include/Z/macros/T.h:164:9
pub const Z_z_INSERT_Type_23 = @compileError("unable to translate macro: undefined identifier `Float128`");
// /opt/homebrew/include/Z/macros/T.h:165:9
pub const Z_z_INSERT_type_23 = @compileError("unable to translate macro: undefined identifier `float128`");
// /opt/homebrew/include/Z/macros/T.h:166:9
pub const Z_z_APPEND_TYPE_24 = @compileError("unable to translate macro: undefined identifier `FLOAT32X`");
// /opt/homebrew/include/Z/macros/T.h:168:9
pub const Z_z_APPEND_Type_24 = @compileError("unable to translate macro: undefined identifier `Float32x`");
// /opt/homebrew/include/Z/macros/T.h:169:9
pub const Z_z_APPEND_type_24 = @compileError("unable to translate macro: undefined identifier `float32x`");
// /opt/homebrew/include/Z/macros/T.h:170:9
pub const Z_z_INSERT_TYPE_24 = @compileError("unable to translate macro: undefined identifier `FLOAT32X`");
// /opt/homebrew/include/Z/macros/T.h:171:9
pub const Z_z_INSERT_Type_24 = @compileError("unable to translate macro: undefined identifier `Float32x`");
// /opt/homebrew/include/Z/macros/T.h:172:9
pub const Z_z_INSERT_type_24 = @compileError("unable to translate macro: undefined identifier `float32x`");
// /opt/homebrew/include/Z/macros/T.h:173:9
pub const Z_z_APPEND_TYPE_25 = @compileError("unable to translate macro: undefined identifier `FLOAT64X`");
// /opt/homebrew/include/Z/macros/T.h:175:9
pub const Z_z_APPEND_Type_25 = @compileError("unable to translate macro: undefined identifier `Float64x`");
// /opt/homebrew/include/Z/macros/T.h:176:9
pub const Z_z_APPEND_type_25 = @compileError("unable to translate macro: undefined identifier `float64x`");
// /opt/homebrew/include/Z/macros/T.h:177:9
pub const Z_z_INSERT_TYPE_25 = @compileError("unable to translate macro: undefined identifier `FLOAT64X`");
// /opt/homebrew/include/Z/macros/T.h:178:9
pub const Z_z_INSERT_Type_25 = @compileError("unable to translate macro: undefined identifier `Float64x`");
// /opt/homebrew/include/Z/macros/T.h:179:9
pub const Z_z_INSERT_type_25 = @compileError("unable to translate macro: undefined identifier `float64x`");
// /opt/homebrew/include/Z/macros/T.h:180:9
pub const Z_z_APPEND_TYPE_26 = @compileError("unable to translate macro: undefined identifier `FLOAT128X`");
// /opt/homebrew/include/Z/macros/T.h:182:9
pub const Z_z_APPEND_Type_26 = @compileError("unable to translate macro: undefined identifier `Float128x`");
// /opt/homebrew/include/Z/macros/T.h:183:9
pub const Z_z_APPEND_type_26 = @compileError("unable to translate macro: undefined identifier `float128x`");
// /opt/homebrew/include/Z/macros/T.h:184:9
pub const Z_z_INSERT_TYPE_26 = @compileError("unable to translate macro: undefined identifier `FLOAT128X`");
// /opt/homebrew/include/Z/macros/T.h:185:9
pub const Z_z_INSERT_Type_26 = @compileError("unable to translate macro: undefined identifier `Float128x`");
// /opt/homebrew/include/Z/macros/T.h:186:9
pub const Z_z_INSERT_type_26 = @compileError("unable to translate macro: undefined identifier `float128x`");
// /opt/homebrew/include/Z/macros/T.h:187:9
pub const Z_z_APPEND_TYPE_27 = @compileError("unable to translate macro: undefined identifier `DECIMAL32`");
// /opt/homebrew/include/Z/macros/T.h:189:9
pub const Z_z_APPEND_Type_27 = @compileError("unable to translate macro: undefined identifier `Decimal32`");
// /opt/homebrew/include/Z/macros/T.h:190:9
pub const Z_z_APPEND_type_27 = @compileError("unable to translate macro: undefined identifier `decimal32`");
// /opt/homebrew/include/Z/macros/T.h:191:9
pub const Z_z_INSERT_TYPE_27 = @compileError("unable to translate macro: undefined identifier `DECIMAL32`");
// /opt/homebrew/include/Z/macros/T.h:192:9
pub const Z_z_INSERT_Type_27 = @compileError("unable to translate macro: undefined identifier `Decimal32`");
// /opt/homebrew/include/Z/macros/T.h:193:9
pub const Z_z_INSERT_type_27 = @compileError("unable to translate macro: undefined identifier `decimal32`");
// /opt/homebrew/include/Z/macros/T.h:194:9
pub const Z_z_APPEND_TYPE_28 = @compileError("unable to translate macro: undefined identifier `DECIMAL64`");
// /opt/homebrew/include/Z/macros/T.h:196:9
pub const Z_z_APPEND_Type_28 = @compileError("unable to translate macro: undefined identifier `Decimal64`");
// /opt/homebrew/include/Z/macros/T.h:197:9
pub const Z_z_APPEND_type_28 = @compileError("unable to translate macro: undefined identifier `decimal64`");
// /opt/homebrew/include/Z/macros/T.h:198:9
pub const Z_z_INSERT_TYPE_28 = @compileError("unable to translate macro: undefined identifier `DECIMAL64`");
// /opt/homebrew/include/Z/macros/T.h:199:9
pub const Z_z_INSERT_Type_28 = @compileError("unable to translate macro: undefined identifier `Decimal64`");
// /opt/homebrew/include/Z/macros/T.h:200:9
pub const Z_z_INSERT_type_28 = @compileError("unable to translate macro: undefined identifier `decimal64`");
// /opt/homebrew/include/Z/macros/T.h:201:9
pub const Z_z_APPEND_TYPE_29 = @compileError("unable to translate macro: undefined identifier `DECIMAL128`");
// /opt/homebrew/include/Z/macros/T.h:203:9
pub const Z_z_APPEND_Type_29 = @compileError("unable to translate macro: undefined identifier `Decimal128`");
// /opt/homebrew/include/Z/macros/T.h:204:9
pub const Z_z_APPEND_type_29 = @compileError("unable to translate macro: undefined identifier `decimal128`");
// /opt/homebrew/include/Z/macros/T.h:205:9
pub const Z_z_INSERT_TYPE_29 = @compileError("unable to translate macro: undefined identifier `DECIMAL128`");
// /opt/homebrew/include/Z/macros/T.h:206:9
pub const Z_z_INSERT_Type_29 = @compileError("unable to translate macro: undefined identifier `Decimal128`");
// /opt/homebrew/include/Z/macros/T.h:207:9
pub const Z_z_INSERT_type_29 = @compileError("unable to translate macro: undefined identifier `decimal128`");
// /opt/homebrew/include/Z/macros/T.h:208:9
pub const Z_z_APPEND_TYPE_30 = @compileError("unable to translate macro: undefined identifier `DECIMAL64X`");
// /opt/homebrew/include/Z/macros/T.h:210:9
pub const Z_z_APPEND_Type_30 = @compileError("unable to translate macro: undefined identifier `Decimal64x`");
// /opt/homebrew/include/Z/macros/T.h:211:9
pub const Z_z_APPEND_type_30 = @compileError("unable to translate macro: undefined identifier `decimal64x`");
// /opt/homebrew/include/Z/macros/T.h:212:9
pub const Z_z_INSERT_TYPE_30 = @compileError("unable to translate macro: undefined identifier `DECIMAL64X`");
// /opt/homebrew/include/Z/macros/T.h:213:9
pub const Z_z_INSERT_Type_30 = @compileError("unable to translate macro: undefined identifier `Decimal64x`");
// /opt/homebrew/include/Z/macros/T.h:214:9
pub const Z_z_INSERT_type_30 = @compileError("unable to translate macro: undefined identifier `decimal64x`");
// /opt/homebrew/include/Z/macros/T.h:215:9
pub const Z_z_APPEND_TYPE_31 = @compileError("unable to translate macro: undefined identifier `DECIMAL128X`");
// /opt/homebrew/include/Z/macros/T.h:217:9
pub const Z_z_APPEND_Type_31 = @compileError("unable to translate macro: undefined identifier `Decimal128x`");
// /opt/homebrew/include/Z/macros/T.h:218:9
pub const Z_z_APPEND_type_31 = @compileError("unable to translate macro: undefined identifier `decimal128x`");
// /opt/homebrew/include/Z/macros/T.h:219:9
pub const Z_z_INSERT_TYPE_31 = @compileError("unable to translate macro: undefined identifier `DECIMAL128X`");
// /opt/homebrew/include/Z/macros/T.h:220:9
pub const Z_z_INSERT_Type_31 = @compileError("unable to translate macro: undefined identifier `Decimal128x`");
// /opt/homebrew/include/Z/macros/T.h:221:9
pub const Z_z_INSERT_type_31 = @compileError("unable to translate macro: undefined identifier `decimal128x`");
// /opt/homebrew/include/Z/macros/T.h:222:9
pub const Z_z_APPEND_TYPE_100 = @compileError("unable to translate macro: undefined identifier `UINT8`");
// /opt/homebrew/include/Z/macros/T.h:226:9
pub const Z_z_APPEND_Type_100 = @compileError("unable to translate macro: undefined identifier `UInt8`");
// /opt/homebrew/include/Z/macros/T.h:227:9
pub const Z_z_APPEND_type_100 = @compileError("unable to translate macro: undefined identifier `uint8`");
// /opt/homebrew/include/Z/macros/T.h:228:9
pub const Z_z_INSERT_TYPE_100 = @compileError("unable to translate macro: undefined identifier `UINT8`");
// /opt/homebrew/include/Z/macros/T.h:229:9
pub const Z_z_INSERT_Type_100 = @compileError("unable to translate macro: undefined identifier `UInt8`");
// /opt/homebrew/include/Z/macros/T.h:230:9
pub const Z_z_INSERT_type_100 = @compileError("unable to translate macro: undefined identifier `uint8`");
// /opt/homebrew/include/Z/macros/T.h:231:9
pub const Z_z_APPEND_TYPE_101 = @compileError("unable to translate macro: undefined identifier `SINT8`");
// /opt/homebrew/include/Z/macros/T.h:233:9
pub const Z_z_APPEND_Type_101 = @compileError("unable to translate macro: undefined identifier `SInt8`");
// /opt/homebrew/include/Z/macros/T.h:234:9
pub const Z_z_APPEND_type_101 = @compileError("unable to translate macro: undefined identifier `sint8`");
// /opt/homebrew/include/Z/macros/T.h:235:9
pub const Z_z_INSERT_TYPE_101 = @compileError("unable to translate macro: undefined identifier `SINT8`");
// /opt/homebrew/include/Z/macros/T.h:236:9
pub const Z_z_INSERT_Type_101 = @compileError("unable to translate macro: undefined identifier `SInt8`");
// /opt/homebrew/include/Z/macros/T.h:237:9
pub const Z_z_INSERT_type_101 = @compileError("unable to translate macro: undefined identifier `sint8`");
// /opt/homebrew/include/Z/macros/T.h:238:9
pub const Z_z_APPEND_TYPE_102 = @compileError("unable to translate macro: undefined identifier `UINT16`");
// /opt/homebrew/include/Z/macros/T.h:240:9
pub const Z_z_APPEND_Type_102 = @compileError("unable to translate macro: undefined identifier `UInt16`");
// /opt/homebrew/include/Z/macros/T.h:241:9
pub const Z_z_APPEND_type_102 = @compileError("unable to translate macro: undefined identifier `uint16`");
// /opt/homebrew/include/Z/macros/T.h:242:9
pub const Z_z_INSERT_TYPE_102 = @compileError("unable to translate macro: undefined identifier `UINT16`");
// /opt/homebrew/include/Z/macros/T.h:243:9
pub const Z_z_INSERT_Type_102 = @compileError("unable to translate macro: undefined identifier `UInt16`");
// /opt/homebrew/include/Z/macros/T.h:244:9
pub const Z_z_INSERT_type_102 = @compileError("unable to translate macro: undefined identifier `uint16`");
// /opt/homebrew/include/Z/macros/T.h:245:9
pub const Z_z_APPEND_TYPE_103 = @compileError("unable to translate macro: undefined identifier `SINT16`");
// /opt/homebrew/include/Z/macros/T.h:247:9
pub const Z_z_APPEND_Type_103 = @compileError("unable to translate macro: undefined identifier `SInt16`");
// /opt/homebrew/include/Z/macros/T.h:248:9
pub const Z_z_APPEND_type_103 = @compileError("unable to translate macro: undefined identifier `sint16`");
// /opt/homebrew/include/Z/macros/T.h:249:9
pub const Z_z_INSERT_TYPE_103 = @compileError("unable to translate macro: undefined identifier `SINT16`");
// /opt/homebrew/include/Z/macros/T.h:250:9
pub const Z_z_INSERT_Type_103 = @compileError("unable to translate macro: undefined identifier `SInt16`");
// /opt/homebrew/include/Z/macros/T.h:251:9
pub const Z_z_INSERT_type_103 = @compileError("unable to translate macro: undefined identifier `sint16`");
// /opt/homebrew/include/Z/macros/T.h:252:9
pub const Z_z_APPEND_TYPE_104 = @compileError("unable to translate macro: undefined identifier `UINT24`");
// /opt/homebrew/include/Z/macros/T.h:254:9
pub const Z_z_APPEND_Type_104 = @compileError("unable to translate macro: undefined identifier `UInt24`");
// /opt/homebrew/include/Z/macros/T.h:255:9
pub const Z_z_APPEND_type_104 = @compileError("unable to translate macro: undefined identifier `uint24`");
// /opt/homebrew/include/Z/macros/T.h:256:9
pub const Z_z_INSERT_TYPE_104 = @compileError("unable to translate macro: undefined identifier `UINT24`");
// /opt/homebrew/include/Z/macros/T.h:257:9
pub const Z_z_INSERT_Type_104 = @compileError("unable to translate macro: undefined identifier `UInt24`");
// /opt/homebrew/include/Z/macros/T.h:258:9
pub const Z_z_INSERT_type_104 = @compileError("unable to translate macro: undefined identifier `uint24`");
// /opt/homebrew/include/Z/macros/T.h:259:9
pub const Z_z_APPEND_TYPE_105 = @compileError("unable to translate macro: undefined identifier `SINT24`");
// /opt/homebrew/include/Z/macros/T.h:261:9
pub const Z_z_APPEND_Type_105 = @compileError("unable to translate macro: undefined identifier `SInt24`");
// /opt/homebrew/include/Z/macros/T.h:262:9
pub const Z_z_APPEND_type_105 = @compileError("unable to translate macro: undefined identifier `sint24`");
// /opt/homebrew/include/Z/macros/T.h:263:9
pub const Z_z_INSERT_TYPE_105 = @compileError("unable to translate macro: undefined identifier `SINT24`");
// /opt/homebrew/include/Z/macros/T.h:264:9
pub const Z_z_INSERT_Type_105 = @compileError("unable to translate macro: undefined identifier `SInt24`");
// /opt/homebrew/include/Z/macros/T.h:265:9
pub const Z_z_INSERT_type_105 = @compileError("unable to translate macro: undefined identifier `sint24`");
// /opt/homebrew/include/Z/macros/T.h:266:9
pub const Z_z_APPEND_TYPE_106 = @compileError("unable to translate macro: undefined identifier `UINT32`");
// /opt/homebrew/include/Z/macros/T.h:268:9
pub const Z_z_APPEND_Type_106 = @compileError("unable to translate macro: undefined identifier `UInt32`");
// /opt/homebrew/include/Z/macros/T.h:269:9
pub const Z_z_APPEND_type_106 = @compileError("unable to translate macro: undefined identifier `uint32`");
// /opt/homebrew/include/Z/macros/T.h:270:9
pub const Z_z_INSERT_TYPE_106 = @compileError("unable to translate macro: undefined identifier `UINT32`");
// /opt/homebrew/include/Z/macros/T.h:271:9
pub const Z_z_INSERT_Type_106 = @compileError("unable to translate macro: undefined identifier `UInt32`");
// /opt/homebrew/include/Z/macros/T.h:272:9
pub const Z_z_INSERT_type_106 = @compileError("unable to translate macro: undefined identifier `uint32`");
// /opt/homebrew/include/Z/macros/T.h:273:9
pub const Z_z_APPEND_TYPE_107 = @compileError("unable to translate macro: undefined identifier `SINT32`");
// /opt/homebrew/include/Z/macros/T.h:275:9
pub const Z_z_APPEND_Type_107 = @compileError("unable to translate macro: undefined identifier `SInt32`");
// /opt/homebrew/include/Z/macros/T.h:276:9
pub const Z_z_APPEND_type_107 = @compileError("unable to translate macro: undefined identifier `sint32`");
// /opt/homebrew/include/Z/macros/T.h:277:9
pub const Z_z_INSERT_TYPE_107 = @compileError("unable to translate macro: undefined identifier `SINT32`");
// /opt/homebrew/include/Z/macros/T.h:278:9
pub const Z_z_INSERT_Type_107 = @compileError("unable to translate macro: undefined identifier `SInt32`");
// /opt/homebrew/include/Z/macros/T.h:279:9
pub const Z_z_INSERT_type_107 = @compileError("unable to translate macro: undefined identifier `sint32`");
// /opt/homebrew/include/Z/macros/T.h:280:9
pub const Z_z_APPEND_TYPE_108 = @compileError("unable to translate macro: undefined identifier `UINT40`");
// /opt/homebrew/include/Z/macros/T.h:282:9
pub const Z_z_APPEND_Type_108 = @compileError("unable to translate macro: undefined identifier `UInt40`");
// /opt/homebrew/include/Z/macros/T.h:283:9
pub const Z_z_APPEND_type_108 = @compileError("unable to translate macro: undefined identifier `uint40`");
// /opt/homebrew/include/Z/macros/T.h:284:9
pub const Z_z_INSERT_TYPE_108 = @compileError("unable to translate macro: undefined identifier `UINT40`");
// /opt/homebrew/include/Z/macros/T.h:285:9
pub const Z_z_INSERT_Type_108 = @compileError("unable to translate macro: undefined identifier `UInt40`");
// /opt/homebrew/include/Z/macros/T.h:286:9
pub const Z_z_INSERT_type_108 = @compileError("unable to translate macro: undefined identifier `uint40`");
// /opt/homebrew/include/Z/macros/T.h:287:9
pub const Z_z_APPEND_TYPE_109 = @compileError("unable to translate macro: undefined identifier `SINT40`");
// /opt/homebrew/include/Z/macros/T.h:289:9
pub const Z_z_APPEND_Type_109 = @compileError("unable to translate macro: undefined identifier `SInt40`");
// /opt/homebrew/include/Z/macros/T.h:290:9
pub const Z_z_APPEND_type_109 = @compileError("unable to translate macro: undefined identifier `sint40`");
// /opt/homebrew/include/Z/macros/T.h:291:9
pub const Z_z_INSERT_TYPE_109 = @compileError("unable to translate macro: undefined identifier `SINT40`");
// /opt/homebrew/include/Z/macros/T.h:292:9
pub const Z_z_INSERT_Type_109 = @compileError("unable to translate macro: undefined identifier `SInt40`");
// /opt/homebrew/include/Z/macros/T.h:293:9
pub const Z_z_INSERT_type_109 = @compileError("unable to translate macro: undefined identifier `sint40`");
// /opt/homebrew/include/Z/macros/T.h:294:9
pub const Z_z_APPEND_TYPE_110 = @compileError("unable to translate macro: undefined identifier `UINT48`");
// /opt/homebrew/include/Z/macros/T.h:296:9
pub const Z_z_APPEND_Type_110 = @compileError("unable to translate macro: undefined identifier `UInt48`");
// /opt/homebrew/include/Z/macros/T.h:297:9
pub const Z_z_APPEND_type_110 = @compileError("unable to translate macro: undefined identifier `uint48`");
// /opt/homebrew/include/Z/macros/T.h:298:9
pub const Z_z_INSERT_TYPE_110 = @compileError("unable to translate macro: undefined identifier `UINT48`");
// /opt/homebrew/include/Z/macros/T.h:299:9
pub const Z_z_INSERT_Type_110 = @compileError("unable to translate macro: undefined identifier `UInt48`");
// /opt/homebrew/include/Z/macros/T.h:300:9
pub const Z_z_INSERT_type_110 = @compileError("unable to translate macro: undefined identifier `uint48`");
// /opt/homebrew/include/Z/macros/T.h:301:9
pub const Z_z_APPEND_TYPE_111 = @compileError("unable to translate macro: undefined identifier `SINT48`");
// /opt/homebrew/include/Z/macros/T.h:303:9
pub const Z_z_APPEND_Type_111 = @compileError("unable to translate macro: undefined identifier `SInt48`");
// /opt/homebrew/include/Z/macros/T.h:304:9
pub const Z_z_APPEND_type_111 = @compileError("unable to translate macro: undefined identifier `sint48`");
// /opt/homebrew/include/Z/macros/T.h:305:9
pub const Z_z_INSERT_TYPE_111 = @compileError("unable to translate macro: undefined identifier `SINT48`");
// /opt/homebrew/include/Z/macros/T.h:306:9
pub const Z_z_INSERT_Type_111 = @compileError("unable to translate macro: undefined identifier `SInt48`");
// /opt/homebrew/include/Z/macros/T.h:307:9
pub const Z_z_INSERT_type_111 = @compileError("unable to translate macro: undefined identifier `sint48`");
// /opt/homebrew/include/Z/macros/T.h:308:9
pub const Z_z_APPEND_TYPE_112 = @compileError("unable to translate macro: undefined identifier `UINT56`");
// /opt/homebrew/include/Z/macros/T.h:310:9
pub const Z_z_APPEND_Type_112 = @compileError("unable to translate macro: undefined identifier `UInt56`");
// /opt/homebrew/include/Z/macros/T.h:311:9
pub const Z_z_APPEND_type_112 = @compileError("unable to translate macro: undefined identifier `uint56`");
// /opt/homebrew/include/Z/macros/T.h:312:9
pub const Z_z_INSERT_TYPE_112 = @compileError("unable to translate macro: undefined identifier `UINT56`");
// /opt/homebrew/include/Z/macros/T.h:313:9
pub const Z_z_INSERT_Type_112 = @compileError("unable to translate macro: undefined identifier `UInt56`");
// /opt/homebrew/include/Z/macros/T.h:314:9
pub const Z_z_INSERT_type_112 = @compileError("unable to translate macro: undefined identifier `uint56`");
// /opt/homebrew/include/Z/macros/T.h:315:9
pub const Z_z_APPEND_TYPE_113 = @compileError("unable to translate macro: undefined identifier `SINT56`");
// /opt/homebrew/include/Z/macros/T.h:317:9
pub const Z_z_APPEND_Type_113 = @compileError("unable to translate macro: undefined identifier `SInt56`");
// /opt/homebrew/include/Z/macros/T.h:318:9
pub const Z_z_APPEND_type_113 = @compileError("unable to translate macro: undefined identifier `sint56`");
// /opt/homebrew/include/Z/macros/T.h:319:9
pub const Z_z_INSERT_TYPE_113 = @compileError("unable to translate macro: undefined identifier `SINT56`");
// /opt/homebrew/include/Z/macros/T.h:320:9
pub const Z_z_INSERT_Type_113 = @compileError("unable to translate macro: undefined identifier `SInt56`");
// /opt/homebrew/include/Z/macros/T.h:321:9
pub const Z_z_INSERT_type_113 = @compileError("unable to translate macro: undefined identifier `sint56`");
// /opt/homebrew/include/Z/macros/T.h:322:9
pub const Z_z_APPEND_TYPE_114 = @compileError("unable to translate macro: undefined identifier `UINT64`");
// /opt/homebrew/include/Z/macros/T.h:324:9
pub const Z_z_APPEND_Type_114 = @compileError("unable to translate macro: undefined identifier `UInt64`");
// /opt/homebrew/include/Z/macros/T.h:325:9
pub const Z_z_APPEND_type_114 = @compileError("unable to translate macro: undefined identifier `uint64`");
// /opt/homebrew/include/Z/macros/T.h:326:9
pub const Z_z_INSERT_TYPE_114 = @compileError("unable to translate macro: undefined identifier `UINT64`");
// /opt/homebrew/include/Z/macros/T.h:327:9
pub const Z_z_INSERT_Type_114 = @compileError("unable to translate macro: undefined identifier `UInt64`");
// /opt/homebrew/include/Z/macros/T.h:328:9
pub const Z_z_INSERT_type_114 = @compileError("unable to translate macro: undefined identifier `uint64`");
// /opt/homebrew/include/Z/macros/T.h:329:9
pub const Z_z_APPEND_TYPE_115 = @compileError("unable to translate macro: undefined identifier `SINT64`");
// /opt/homebrew/include/Z/macros/T.h:331:9
pub const Z_z_APPEND_Type_115 = @compileError("unable to translate macro: undefined identifier `SInt64`");
// /opt/homebrew/include/Z/macros/T.h:332:9
pub const Z_z_APPEND_type_115 = @compileError("unable to translate macro: undefined identifier `sint64`");
// /opt/homebrew/include/Z/macros/T.h:333:9
pub const Z_z_INSERT_TYPE_115 = @compileError("unable to translate macro: undefined identifier `SINT64`");
// /opt/homebrew/include/Z/macros/T.h:334:9
pub const Z_z_INSERT_Type_115 = @compileError("unable to translate macro: undefined identifier `SInt64`");
// /opt/homebrew/include/Z/macros/T.h:335:9
pub const Z_z_INSERT_type_115 = @compileError("unable to translate macro: undefined identifier `sint64`");
// /opt/homebrew/include/Z/macros/T.h:336:9
pub const Z_z_APPEND_TYPE_116 = @compileError("unable to translate macro: undefined identifier `UINT128`");
// /opt/homebrew/include/Z/macros/T.h:338:9
pub const Z_z_APPEND_Type_116 = @compileError("unable to translate macro: undefined identifier `UInt128`");
// /opt/homebrew/include/Z/macros/T.h:339:9
pub const Z_z_APPEND_type_116 = @compileError("unable to translate macro: undefined identifier `uint128`");
// /opt/homebrew/include/Z/macros/T.h:340:9
pub const Z_z_INSERT_TYPE_116 = @compileError("unable to translate macro: undefined identifier `UINT128`");
// /opt/homebrew/include/Z/macros/T.h:341:9
pub const Z_z_INSERT_Type_116 = @compileError("unable to translate macro: undefined identifier `UInt128`");
// /opt/homebrew/include/Z/macros/T.h:342:9
pub const Z_z_INSERT_type_116 = @compileError("unable to translate macro: undefined identifier `uint128`");
// /opt/homebrew/include/Z/macros/T.h:343:9
pub const Z_z_APPEND_TYPE_117 = @compileError("unable to translate macro: undefined identifier `SINT128`");
// /opt/homebrew/include/Z/macros/T.h:345:9
pub const Z_z_APPEND_Type_117 = @compileError("unable to translate macro: undefined identifier `SInt128`");
// /opt/homebrew/include/Z/macros/T.h:346:9
pub const Z_z_APPEND_type_117 = @compileError("unable to translate macro: undefined identifier `sint128`");
// /opt/homebrew/include/Z/macros/T.h:347:9
pub const Z_z_INSERT_TYPE_117 = @compileError("unable to translate macro: undefined identifier `SINT128`");
// /opt/homebrew/include/Z/macros/T.h:348:9
pub const Z_z_INSERT_Type_117 = @compileError("unable to translate macro: undefined identifier `SInt128`");
// /opt/homebrew/include/Z/macros/T.h:349:9
pub const Z_z_INSERT_type_117 = @compileError("unable to translate macro: undefined identifier `sint128`");
// /opt/homebrew/include/Z/macros/T.h:350:9
pub const Z_z_APPEND_TYPE_150 = @compileError("unable to translate macro: undefined identifier `BFP16`");
// /opt/homebrew/include/Z/macros/T.h:354:9
pub const Z_z_APPEND_Type_150 = @compileError("unable to translate macro: undefined identifier `BFP16`");
// /opt/homebrew/include/Z/macros/T.h:355:9
pub const Z_z_APPEND_type_150 = @compileError("unable to translate macro: undefined identifier `bfp16`");
// /opt/homebrew/include/Z/macros/T.h:356:9
pub const Z_z_INSERT_TYPE_150 = @compileError("unable to translate macro: undefined identifier `BFP16`");
// /opt/homebrew/include/Z/macros/T.h:357:9
pub const Z_z_INSERT_Type_150 = @compileError("unable to translate macro: undefined identifier `BFP16`");
// /opt/homebrew/include/Z/macros/T.h:358:9
pub const Z_z_INSERT_type_150 = @compileError("unable to translate macro: undefined identifier `bfp16`");
// /opt/homebrew/include/Z/macros/T.h:359:9
pub const Z_z_APPEND_TYPE_151 = @compileError("unable to translate macro: undefined identifier `BFP32`");
// /opt/homebrew/include/Z/macros/T.h:361:9
pub const Z_z_APPEND_Type_151 = @compileError("unable to translate macro: undefined identifier `BFP32`");
// /opt/homebrew/include/Z/macros/T.h:362:9
pub const Z_z_APPEND_type_151 = @compileError("unable to translate macro: undefined identifier `bfp32`");
// /opt/homebrew/include/Z/macros/T.h:363:9
pub const Z_z_INSERT_TYPE_151 = @compileError("unable to translate macro: undefined identifier `BFP32`");
// /opt/homebrew/include/Z/macros/T.h:364:9
pub const Z_z_INSERT_Type_151 = @compileError("unable to translate macro: undefined identifier `BFP32`");
// /opt/homebrew/include/Z/macros/T.h:365:9
pub const Z_z_INSERT_type_151 = @compileError("unable to translate macro: undefined identifier `bfp32`");
// /opt/homebrew/include/Z/macros/T.h:366:9
pub const Z_z_APPEND_TYPE_152 = @compileError("unable to translate macro: undefined identifier `BFP64`");
// /opt/homebrew/include/Z/macros/T.h:368:9
pub const Z_z_APPEND_Type_152 = @compileError("unable to translate macro: undefined identifier `BFP64`");
// /opt/homebrew/include/Z/macros/T.h:369:9
pub const Z_z_APPEND_type_152 = @compileError("unable to translate macro: undefined identifier `bfp64`");
// /opt/homebrew/include/Z/macros/T.h:370:9
pub const Z_z_INSERT_TYPE_152 = @compileError("unable to translate macro: undefined identifier `BFP64`");
// /opt/homebrew/include/Z/macros/T.h:371:9
pub const Z_z_INSERT_Type_152 = @compileError("unable to translate macro: undefined identifier `BFP64`");
// /opt/homebrew/include/Z/macros/T.h:372:9
pub const Z_z_INSERT_type_152 = @compileError("unable to translate macro: undefined identifier `bfp64`");
// /opt/homebrew/include/Z/macros/T.h:373:9
pub const Z_z_APPEND_TYPE_153 = @compileError("unable to translate macro: undefined identifier `BFP128`");
// /opt/homebrew/include/Z/macros/T.h:375:9
pub const Z_z_APPEND_Type_153 = @compileError("unable to translate macro: undefined identifier `BFP128`");
// /opt/homebrew/include/Z/macros/T.h:376:9
pub const Z_z_APPEND_type_153 = @compileError("unable to translate macro: undefined identifier `bfp128`");
// /opt/homebrew/include/Z/macros/T.h:377:9
pub const Z_z_INSERT_TYPE_153 = @compileError("unable to translate macro: undefined identifier `BFP128`");
// /opt/homebrew/include/Z/macros/T.h:378:9
pub const Z_z_INSERT_Type_153 = @compileError("unable to translate macro: undefined identifier `BFP128`");
// /opt/homebrew/include/Z/macros/T.h:379:9
pub const Z_z_INSERT_type_153 = @compileError("unable to translate macro: undefined identifier `bfp128`");
// /opt/homebrew/include/Z/macros/T.h:380:9
pub const Z_z_APPEND_TYPE_154 = @compileError("unable to translate macro: undefined identifier `DFP32`");
// /opt/homebrew/include/Z/macros/T.h:382:9
pub const Z_z_APPEND_Type_154 = @compileError("unable to translate macro: undefined identifier `DFP32`");
// /opt/homebrew/include/Z/macros/T.h:383:9
pub const Z_z_APPEND_type_154 = @compileError("unable to translate macro: undefined identifier `dfp32`");
// /opt/homebrew/include/Z/macros/T.h:384:9
pub const Z_z_INSERT_TYPE_154 = @compileError("unable to translate macro: undefined identifier `DFP32`");
// /opt/homebrew/include/Z/macros/T.h:385:9
pub const Z_z_INSERT_Type_154 = @compileError("unable to translate macro: undefined identifier `DFP32`");
// /opt/homebrew/include/Z/macros/T.h:386:9
pub const Z_z_INSERT_type_154 = @compileError("unable to translate macro: undefined identifier `dfp32`");
// /opt/homebrew/include/Z/macros/T.h:387:9
pub const Z_z_APPEND_TYPE_155 = @compileError("unable to translate macro: undefined identifier `DFP64`");
// /opt/homebrew/include/Z/macros/T.h:389:9
pub const Z_z_APPEND_Type_155 = @compileError("unable to translate macro: undefined identifier `DFP64`");
// /opt/homebrew/include/Z/macros/T.h:390:9
pub const Z_z_APPEND_type_155 = @compileError("unable to translate macro: undefined identifier `dfp64`");
// /opt/homebrew/include/Z/macros/T.h:391:9
pub const Z_z_INSERT_TYPE_155 = @compileError("unable to translate macro: undefined identifier `DFP64`");
// /opt/homebrew/include/Z/macros/T.h:392:9
pub const Z_z_INSERT_Type_155 = @compileError("unable to translate macro: undefined identifier `DFP64`");
// /opt/homebrew/include/Z/macros/T.h:393:9
pub const Z_z_INSERT_type_155 = @compileError("unable to translate macro: undefined identifier `dfp64`");
// /opt/homebrew/include/Z/macros/T.h:394:9
pub const Z_z_APPEND_TYPE_156 = @compileError("unable to translate macro: undefined identifier `DFP128`");
// /opt/homebrew/include/Z/macros/T.h:396:9
pub const Z_z_APPEND_Type_156 = @compileError("unable to translate macro: undefined identifier `DFP128`");
// /opt/homebrew/include/Z/macros/T.h:397:9
pub const Z_z_APPEND_type_156 = @compileError("unable to translate macro: undefined identifier `dfp128`");
// /opt/homebrew/include/Z/macros/T.h:398:9
pub const Z_z_INSERT_TYPE_156 = @compileError("unable to translate macro: undefined identifier `DFP128`");
// /opt/homebrew/include/Z/macros/T.h:399:9
pub const Z_z_INSERT_Type_156 = @compileError("unable to translate macro: undefined identifier `DFP128`");
// /opt/homebrew/include/Z/macros/T.h:400:9
pub const Z_z_INSERT_type_156 = @compileError("unable to translate macro: undefined identifier `dfp128`");
// /opt/homebrew/include/Z/macros/T.h:401:9
pub const Z_z_APPEND_TYPE_157 = @compileError("unable to translate macro: undefined identifier `X87_DE80`");
// /opt/homebrew/include/Z/macros/T.h:403:9
pub const Z_z_APPEND_Type_157 = @compileError("unable to translate macro: undefined identifier `x87_DE80`");
// /opt/homebrew/include/Z/macros/T.h:404:9
pub const Z_z_APPEND_type_157 = @compileError("unable to translate macro: undefined identifier `x87_de80`");
// /opt/homebrew/include/Z/macros/T.h:405:9
pub const Z_z_INSERT_TYPE_157 = @compileError("unable to translate macro: undefined identifier `X87_DE80`");
// /opt/homebrew/include/Z/macros/T.h:406:9
pub const Z_z_INSERT_Type_157 = @compileError("unable to translate macro: undefined identifier `x87_DE80`");
// /opt/homebrew/include/Z/macros/T.h:407:9
pub const Z_z_INSERT_type_157 = @compileError("unable to translate macro: undefined identifier `x87_de80`");
// /opt/homebrew/include/Z/macros/T.h:408:9
pub const Z_z_APPEND_TYPE_158 = @compileError("unable to translate macro: undefined identifier `X87_DE96`");
// /opt/homebrew/include/Z/macros/T.h:410:9
pub const Z_z_APPEND_Type_158 = @compileError("unable to translate macro: undefined identifier `x87_DE96`");
// /opt/homebrew/include/Z/macros/T.h:411:9
pub const Z_z_APPEND_type_158 = @compileError("unable to translate macro: undefined identifier `x87_de96`");
// /opt/homebrew/include/Z/macros/T.h:412:9
pub const Z_z_INSERT_TYPE_158 = @compileError("unable to translate macro: undefined identifier `X87_DE96`");
// /opt/homebrew/include/Z/macros/T.h:413:9
pub const Z_z_INSERT_Type_158 = @compileError("unable to translate macro: undefined identifier `x87_DE96`");
// /opt/homebrew/include/Z/macros/T.h:414:9
pub const Z_z_INSERT_type_158 = @compileError("unable to translate macro: undefined identifier `x87_de96`");
// /opt/homebrew/include/Z/macros/T.h:415:9
pub const Z_z_APPEND_TYPE_159 = @compileError("unable to translate macro: undefined identifier `X87_DE128`");
// /opt/homebrew/include/Z/macros/T.h:417:9
pub const Z_z_APPEND_Type_159 = @compileError("unable to translate macro: undefined identifier `x87_DE128`");
// /opt/homebrew/include/Z/macros/T.h:418:9
pub const Z_z_APPEND_type_159 = @compileError("unable to translate macro: undefined identifier `x87_de128`");
// /opt/homebrew/include/Z/macros/T.h:419:9
pub const Z_z_INSERT_TYPE_159 = @compileError("unable to translate macro: undefined identifier `X87_DE128`");
// /opt/homebrew/include/Z/macros/T.h:420:9
pub const Z_z_INSERT_Type_159 = @compileError("unable to translate macro: undefined identifier `x87_DE128`");
// /opt/homebrew/include/Z/macros/T.h:421:9
pub const Z_z_INSERT_type_159 = @compileError("unable to translate macro: undefined identifier `x87_de128`");
// /opt/homebrew/include/Z/macros/T.h:422:9
pub const Z_z_APPEND_TYPE_160 = @compileError("unable to translate macro: undefined identifier `IBM_ED`");
// /opt/homebrew/include/Z/macros/T.h:424:9
pub const Z_z_APPEND_Type_160 = @compileError("unable to translate macro: undefined identifier `IBM_ED`");
// /opt/homebrew/include/Z/macros/T.h:425:9
pub const Z_z_APPEND_type_160 = @compileError("unable to translate macro: undefined identifier `ibm_ed`");
// /opt/homebrew/include/Z/macros/T.h:426:9
pub const Z_z_INSERT_TYPE_160 = @compileError("unable to translate macro: undefined identifier `IBM_ED`");
// /opt/homebrew/include/Z/macros/T.h:427:9
pub const Z_z_INSERT_Type_160 = @compileError("unable to translate macro: undefined identifier `IBM_ED`");
// /opt/homebrew/include/Z/macros/T.h:428:9
pub const Z_z_INSERT_type_160 = @compileError("unable to translate macro: undefined identifier `ibm_ed`");
// /opt/homebrew/include/Z/macros/T.h:429:9
pub const Z_z_APPEND_TYPE_162 = @compileError("unable to translate macro: undefined identifier `BFLOAT16`");
// /opt/homebrew/include/Z/macros/T.h:431:9
pub const Z_z_APPEND_Type_162 = @compileError("unable to translate macro: undefined identifier `bfloat16`");
// /opt/homebrew/include/Z/macros/T.h:432:9
pub const Z_z_APPEND_type_162 = @compileError("unable to translate macro: undefined identifier `bfloat16`");
// /opt/homebrew/include/Z/macros/T.h:433:9
pub const Z_z_INSERT_TYPE_162 = @compileError("unable to translate macro: undefined identifier `BFLOAT16`");
// /opt/homebrew/include/Z/macros/T.h:434:9
pub const Z_z_INSERT_Type_162 = @compileError("unable to translate macro: undefined identifier `bfloat16`");
// /opt/homebrew/include/Z/macros/T.h:435:9
pub const Z_z_INSERT_type_162 = @compileError("unable to translate macro: undefined identifier `bfloat16`");
// /opt/homebrew/include/Z/macros/T.h:436:9
pub const Z_PREPEND_TYPE = @compileError("unable to translate macro: undefined identifier `Z_z_PREPEND_TYPE_`");
// /opt/homebrew/include/Z/macros/T.h:438:9
pub const Z_PREPEND_Type = @compileError("unable to translate macro: undefined identifier `Z_z_PREPEND_Type_`");
// /opt/homebrew/include/Z/macros/T.h:439:9
pub const Z_PREPEND_type = @compileError("unable to translate macro: undefined identifier `Z_z_PREPEND_type_`");
// /opt/homebrew/include/Z/macros/T.h:440:9
pub const Z_APPEND_TYPE = @compileError("unable to translate macro: undefined identifier `Z_z_APPEND_TYPE_`");
// /opt/homebrew/include/Z/macros/T.h:441:9
pub const Z_APPEND_Type = @compileError("unable to translate macro: undefined identifier `Z_z_APPEND_Type_`");
// /opt/homebrew/include/Z/macros/T.h:442:9
pub const Z_APPEND_type = @compileError("unable to translate macro: undefined identifier `Z_z_APPEND_type_`");
// /opt/homebrew/include/Z/macros/T.h:443:9
pub const Z_INSERT_TYPE = @compileError("unable to translate macro: undefined identifier `Z_z_INSERT_TYPE_`");
// /opt/homebrew/include/Z/macros/T.h:444:9
pub const Z_INSERT_Type = @compileError("unable to translate macro: undefined identifier `Z_z_INSERT_Type_`");
// /opt/homebrew/include/Z/macros/T.h:445:9
pub const Z_INSERT_type = @compileError("unable to translate macro: undefined identifier `Z_z_INSERT_type_`");
// /opt/homebrew/include/Z/macros/T.h:446:9
pub const Z_z_INSERT_NUMBER_FORMAT_37 = @compileError("unable to translate macro: undefined identifier `IEEE_754_BINARY16`");
// /opt/homebrew/include/Z/macros/T.h:450:9
pub const Z_z_INSERT_NUMBER_FORMAT_38 = @compileError("unable to translate macro: undefined identifier `IEEE_754_BINARY32`");
// /opt/homebrew/include/Z/macros/T.h:451:9
pub const Z_z_INSERT_NUMBER_FORMAT_39 = @compileError("unable to translate macro: undefined identifier `IEEE_754_BINARY64`");
// /opt/homebrew/include/Z/macros/T.h:452:9
pub const Z_z_INSERT_NUMBER_FORMAT_40 = @compileError("unable to translate macro: undefined identifier `IEEE_754_BINARY128`");
// /opt/homebrew/include/Z/macros/T.h:453:9
pub const Z_z_INSERT_NUMBER_FORMAT_41 = @compileError("unable to translate macro: undefined identifier `IEEE_754_DECIMAL32`");
// /opt/homebrew/include/Z/macros/T.h:454:9
pub const Z_z_INSERT_NUMBER_FORMAT_42 = @compileError("unable to translate macro: undefined identifier `IEEE_754_DECIMAL64`");
// /opt/homebrew/include/Z/macros/T.h:455:9
pub const Z_z_INSERT_NUMBER_FORMAT_43 = @compileError("unable to translate macro: undefined identifier `IEEE_754_DECIMAL128`");
// /opt/homebrew/include/Z/macros/T.h:456:9
pub const Z_z_INSERT_NUMBER_FORMAT_44 = @compileError("unable to translate macro: undefined identifier `X87_DOUBLE_EXTENDED`");
// /opt/homebrew/include/Z/macros/T.h:457:9
pub const Z_z_INSERT_NUMBER_FORMAT_45 = @compileError("unable to translate macro: undefined identifier `IBM_EXTENDED_DOUBLE`");
// /opt/homebrew/include/Z/macros/T.h:458:9
pub const Z_z_INSERT_NUMBER_FORMAT_47 = @compileError("unable to translate macro: undefined identifier `BRAIN_FLOATING_POINT`");
// /opt/homebrew/include/Z/macros/T.h:459:9
pub const Z_INSERT_NUMBER_FORMAT = @compileError("unable to translate macro: undefined identifier `Z_z_INSERT_NUMBER_FORMAT_`");
// /opt/homebrew/include/Z/macros/T.h:461:9
pub const Z_UINT8 = @compileError("unable to translate macro: undefined identifier `UINT8`");
// /opt/homebrew/include/Z/types/integral.h:21:10
pub const Z_UINT8_FUNDAMENTAL = @compileError("unable to translate macro: undefined identifier `UINT8`");
// /opt/homebrew/include/Z/types/integral.h:22:10
pub const Z_UINT8_FIXED_FUNDAMENTAL = Z_FUNDAMENTAL_UINT8;
pub const Z_UINT8_WIDTH = @as(c_int, 8);
pub const Z_UINT8_MAXIMUM_ = @as(c_int, 255);
pub const Z_UINT8_MAXIMUM = Z_UINT8(Z_UINT8_MAXIMUM_);
pub const Z_SINT8 = @compileError("unable to translate macro: undefined identifier `SINT8`");
// /opt/homebrew/include/Z/types/integral.h:31:10
pub const Z_SINT8_FUNDAMENTAL = @compileError("unable to translate macro: undefined identifier `SINT8`");
// /opt/homebrew/include/Z/types/integral.h:32:10
pub const Z_SINT8_FIXED_FUNDAMENTAL = Z_FUNDAMENTAL_SINT8;
pub const Z_SINT8_WIDTH = @as(c_int, 8);
pub const Z_SINT8_MAXIMUM_ = @as(c_int, 127);
pub const Z_SINT8_MAXIMUM = Z_SINT8(Z_SINT8_MAXIMUM_);
pub const Z_SINT8_MINIMUM = -Z_SINT8_MAXIMUM - Z_SINT8(@as(c_int, 1));
pub const Z_UINT16 = @compileError("unable to translate macro: undefined identifier `UINT16`");
// /opt/homebrew/include/Z/types/integral.h:42:10
pub const Z_UINT16_FUNDAMENTAL = @compileError("unable to translate macro: undefined identifier `UINT16`");
// /opt/homebrew/include/Z/types/integral.h:43:10
pub const Z_UINT16_FIXED_FUNDAMENTAL = Z_FUNDAMENTAL_UINT16;
pub const Z_UINT16_WIDTH = @as(c_int, 16);
pub const Z_UINT16_MAXIMUM_ = @import("std").zig.c_translation.promoteIntLiteral(c_int, 65535, .decimal);
pub const Z_UINT16_MAXIMUM = Z_UINT16(Z_UINT16_MAXIMUM_);
pub const Z_SINT16 = @compileError("unable to translate macro: undefined identifier `SINT16`");
// /opt/homebrew/include/Z/types/integral.h:52:10
pub const Z_SINT16_FUNDAMENTAL = @compileError("unable to translate macro: undefined identifier `SINT16`");
// /opt/homebrew/include/Z/types/integral.h:53:10
pub const Z_SINT16_FIXED_FUNDAMENTAL = Z_FUNDAMENTAL_SINT16;
pub const Z_SINT16_WIDTH = @as(c_int, 16);
pub const Z_SINT16_MAXIMUM_ = @as(c_int, 32767);
pub const Z_SINT16_MAXIMUM = Z_SINT16(Z_SINT16_MAXIMUM_);
pub const Z_SINT16_MINIMUM = -Z_SINT16_MAXIMUM - Z_SINT16(@as(c_int, 1));
pub const Z_UINT32 = @compileError("unable to translate macro: undefined identifier `UINT32`");
// /opt/homebrew/include/Z/types/integral.h:84:10
pub const Z_UINT32_FUNDAMENTAL = @compileError("unable to translate macro: undefined identifier `UINT32`");
// /opt/homebrew/include/Z/types/integral.h:85:10
pub const Z_UINT32_FIXED_FUNDAMENTAL = Z_FUNDAMENTAL_UINT32;
pub const Z_UINT32_WIDTH = @as(c_int, 32);
pub const Z_UINT32_MAXIMUM_ = @import("std").zig.c_translation.promoteIntLiteral(c_int, 4294967295, .decimal);
pub const Z_UINT32_MAXIMUM = Z_UINT32(Z_UINT32_MAXIMUM_);
pub const Z_SINT32 = @compileError("unable to translate macro: undefined identifier `SINT32`");
// /opt/homebrew/include/Z/types/integral.h:94:10
pub const Z_SINT32_FUNDAMENTAL = @compileError("unable to translate macro: undefined identifier `SINT32`");
// /opt/homebrew/include/Z/types/integral.h:95:10
pub const Z_SINT32_FIXED_FUNDAMENTAL = Z_FUNDAMENTAL_SINT32;
pub const Z_SINT32_WIDTH = @as(c_int, 32);
pub const Z_SINT32_MAXIMUM_ = @import("std").zig.c_translation.promoteIntLiteral(c_int, 2147483647, .decimal);
pub const Z_SINT32_MAXIMUM = Z_SINT32(Z_SINT32_MAXIMUM_);
pub const Z_SINT32_MINIMUM = -Z_SINT32_MAXIMUM - Z_SINT32(@as(c_int, 1));
pub const Z_UINT64 = @compileError("unable to translate macro: undefined identifier `UINT64`");
// /opt/homebrew/include/Z/types/integral.h:168:10
pub const Z_UINT64_FUNDAMENTAL = @compileError("unable to translate macro: undefined identifier `UINT64`");
// /opt/homebrew/include/Z/types/integral.h:169:10
pub const Z_UINT64_FIXED_FUNDAMENTAL = Z_FUNDAMENTAL_UINT64;
pub const Z_UINT64_WIDTH = @as(c_int, 64);
pub const Z_UINT64_MAXIMUM_ = @import("std").zig.c_translation.promoteIntLiteral(c_int, 18446744073709551615, .decimal);
pub const Z_UINT64_MAXIMUM = Z_UINT64(Z_UINT64_MAXIMUM_);
pub const Z_SINT64 = @compileError("unable to translate macro: undefined identifier `SINT64`");
// /opt/homebrew/include/Z/types/integral.h:183:10
pub const Z_SINT64_FUNDAMENTAL = @compileError("unable to translate macro: undefined identifier `SINT64`");
// /opt/homebrew/include/Z/types/integral.h:184:10
pub const Z_SINT64_FIXED_FUNDAMENTAL = Z_FUNDAMENTAL_SINT64;
pub const Z_SINT64_WIDTH = @as(c_int, 64);
pub const Z_SINT64_MAXIMUM_ = @import("std").zig.c_translation.promoteIntLiteral(c_int, 9223372036854775807, .decimal);
pub const Z_SINT64_MAXIMUM = Z_SINT64(Z_SINT64_MAXIMUM_);
pub const Z_SINT64_MINIMUM = -Z_SINT64_MAXIMUM - Z_SINT64(@as(c_int, 1));
pub const Z_UINT128 = @compileError("unable to translate macro: undefined identifier `UINT128`");
// /opt/homebrew/include/Z/types/integral.h:204:10
pub const Z_UINT128_FUNDAMENTAL = @compileError("unable to translate macro: undefined identifier `UINT128`");
// /opt/homebrew/include/Z/types/integral.h:205:10
pub const Z_UINT128_FIXED_FUNDAMENTAL = Z_FUNDAMENTAL_UINT128;
pub const Z_UINT128_WIDTH = @as(c_int, 128);
pub const Z_UINT128_MAXIMUM_ = @import("std").zig.c_translation.promoteIntLiteral(c_int, 340282366920938463463374607431768211455, .decimal);
pub const Z_UINT128_MAXIMUM = ~zuint128(@as(c_int, 0));
pub const Z_SINT128 = @compileError("unable to translate macro: undefined identifier `SINT128`");
// /opt/homebrew/include/Z/types/integral.h:219:10
pub const Z_SINT128_FUNDAMENTAL = @compileError("unable to translate macro: undefined identifier `SINT128`");
// /opt/homebrew/include/Z/types/integral.h:220:10
pub const Z_SINT128_FIXED_FUNDAMENTAL = Z_FUNDAMENTAL_SINT128;
pub const Z_SINT128_WIDTH = @as(c_int, 128);
pub const Z_SINT128_MAXIMUM_ = @import("std").zig.c_translation.promoteIntLiteral(c_int, 170141183460469231731687303715884105727, .decimal);
pub const Z_SINT128_MAXIMUM = -(Z_SINT128_MINIMUM + zsint128(@as(c_int, 1)));
pub const Z_SINT128_MINIMUM = @compileError("unable to translate C expr: unexpected token ')'");
// /opt/homebrew/include/Z/types/integral.h:231:11
pub const Z_INTEGRAL_T_LITERAL = @compileError("unable to translate macro: undefined identifier `Z_`");
// /opt/homebrew/include/Z/types/integral.h:243:9
pub const Z_INTEGRAL_T_FUNDAMENTAL = @compileError("unable to translate macro: undefined identifier `Z_`");
// /opt/homebrew/include/Z/types/integral.h:244:9
pub const Z_INTEGRAL_T_MAXIMUM = @compileError("unable to translate macro: undefined identifier `Z_`");
// /opt/homebrew/include/Z/types/integral.h:245:9
pub const Z_NATURAL_T_TYPE = @compileError("unable to translate macro: undefined identifier `Z_APPEND_NUMBER_`");
// /opt/homebrew/include/Z/types/integral.h:246:9
pub const Z_NATURAL_T_FIXED_FUNDAMENTAL = @compileError("unable to translate macro: undefined identifier `Z_INSERT_NUMBER_`");
// /opt/homebrew/include/Z/types/integral.h:247:9
pub const Z_INTEGER_T_TYPE = @compileError("unable to translate macro: undefined identifier `Z_APPEND_NUMBER_`");
// /opt/homebrew/include/Z/types/integral.h:248:9
pub const Z_INTEGER_T_FIXED_FUNDAMENTAL = @compileError("unable to translate macro: undefined identifier `Z_INSERT_NUMBER_`");
// /opt/homebrew/include/Z/types/integral.h:249:9
pub const Z_UINT_LEAST8_WIDTH = @as(c_int, 8);
pub const Z_UINT_LEAST8 = @compileError("unable to translate macro: undefined identifier `UINT_LEAST8`");
// /opt/homebrew/include/Z/types/integral.h:274:9
pub const Z_UINT_LEAST8_FUNDAMENTAL = @compileError("unable to translate macro: undefined identifier `UINT_LEAST8`");
// /opt/homebrew/include/Z/types/integral.h:275:9
pub const Z_UINT_LEAST8_FIXED_FUNDAMENTAL = @compileError("unable to translate macro: undefined identifier `UINT_LEAST8`");
// /opt/homebrew/include/Z/types/integral.h:276:9
pub const Z_UINT_LEAST8_MAXIMUM = @compileError("unable to translate macro: undefined identifier `UINT_LEAST8`");
// /opt/homebrew/include/Z/types/integral.h:277:9
pub const Z_SINT_LEAST8_WIDTH = @as(c_int, 8);
pub const Z_SINT_LEAST8 = @compileError("unable to translate macro: undefined identifier `SINT_LEAST8`");
// /opt/homebrew/include/Z/types/integral.h:300:9
pub const Z_SINT_LEAST8_FUNDAMENTAL = @compileError("unable to translate macro: undefined identifier `SINT_LEAST8`");
// /opt/homebrew/include/Z/types/integral.h:301:9
pub const Z_SINT_LEAST8_FIXED_FUNDAMENTAL = @compileError("unable to translate macro: undefined identifier `SINT_LEAST8`");
// /opt/homebrew/include/Z/types/integral.h:302:9
pub const Z_SINT_LEAST8_MAXIMUM = @compileError("unable to translate macro: undefined identifier `SINT_LEAST8`");
// /opt/homebrew/include/Z/types/integral.h:303:9
pub const Z_SINT_LEAST8_MINIMUM = -Z_SINT_LEAST8_MAXIMUM - Z_SINT_LEAST8(@as(c_int, 1));
pub const Z_UINT_LEAST16_WIDTH = @as(c_int, 16);
pub const Z_UINT_LEAST16 = @compileError("unable to translate macro: undefined identifier `UINT_LEAST16`");
// /opt/homebrew/include/Z/types/integral.h:326:10
pub const Z_UINT_LEAST16_FUNDAMENTAL = @compileError("unable to translate macro: undefined identifier `UINT_LEAST16`");
// /opt/homebrew/include/Z/types/integral.h:327:10
pub const Z_UINT_LEAST16_FIXED_FUNDAMENTAL = @compileError("unable to translate macro: undefined identifier `UINT_LEAST16`");
// /opt/homebrew/include/Z/types/integral.h:328:10
pub const Z_UINT_LEAST16_MAXIMUM = @compileError("unable to translate macro: undefined identifier `UINT_LEAST16`");
// /opt/homebrew/include/Z/types/integral.h:329:10
pub const Z_SINT_LEAST16_WIDTH = @as(c_int, 16);
pub const Z_SINT_LEAST16 = @compileError("unable to translate macro: undefined identifier `SINT_LEAST16`");
// /opt/homebrew/include/Z/types/integral.h:352:10
pub const Z_SINT_LEAST16_FUNDAMENTAL = @compileError("unable to translate macro: undefined identifier `SINT_LEAST16`");
// /opt/homebrew/include/Z/types/integral.h:353:10
pub const Z_SINT_LEAST16_FIXED_FUNDAMENTAL = @compileError("unable to translate macro: undefined identifier `SINT_LEAST16`");
// /opt/homebrew/include/Z/types/integral.h:354:10
pub const Z_SINT_LEAST16_MAXIMUM = @compileError("unable to translate macro: undefined identifier `SINT_LEAST16`");
// /opt/homebrew/include/Z/types/integral.h:355:10
pub const Z_SINT_LEAST16_MINIMUM = -Z_SINT_LEAST16_MAXIMUM - Z_SINT_LEAST16(@as(c_int, 1));
pub const Z_UINT_LEAST24_WIDTH = @as(c_int, 32);
pub const Z_UINT_LEAST24 = @compileError("unable to translate macro: undefined identifier `UINT_LEAST24`");
// /opt/homebrew/include/Z/types/integral.h:377:10
pub const Z_UINT_LEAST24_FUNDAMENTAL = @compileError("unable to translate macro: undefined identifier `UINT_LEAST24`");
// /opt/homebrew/include/Z/types/integral.h:378:10
pub const Z_UINT_LEAST24_FIXED_FUNDAMENTAL = @compileError("unable to translate macro: undefined identifier `UINT_LEAST24`");
// /opt/homebrew/include/Z/types/integral.h:379:10
pub const Z_UINT_LEAST24_MAXIMUM = @compileError("unable to translate macro: undefined identifier `UINT_LEAST24`");
// /opt/homebrew/include/Z/types/integral.h:380:10
pub const Z_SINT_LEAST24_WIDTH = @as(c_int, 32);
pub const Z_SINT_LEAST24 = @compileError("unable to translate macro: undefined identifier `SINT_LEAST24`");
// /opt/homebrew/include/Z/types/integral.h:401:10
pub const Z_SINT_LEAST24_FUNDAMENTAL = @compileError("unable to translate macro: undefined identifier `SINT_LEAST24`");
// /opt/homebrew/include/Z/types/integral.h:402:10
pub const Z_SINT_LEAST24_FIXED_FUNDAMENTAL = @compileError("unable to translate macro: undefined identifier `SINT_LEAST24`");
// /opt/homebrew/include/Z/types/integral.h:403:10
pub const Z_SINT_LEAST24_MAXIMUM = @compileError("unable to translate macro: undefined identifier `SINT_LEAST24`");
// /opt/homebrew/include/Z/types/integral.h:404:10
pub const Z_SINT_LEAST24_MINIMUM = -Z_SINT_LEAST24_MAXIMUM - Z_SINT_LEAST24(@as(c_int, 1));
pub const Z_UINT_LEAST32_WIDTH = @as(c_int, 32);
pub const Z_UINT_LEAST32 = @compileError("unable to translate macro: undefined identifier `UINT_LEAST32`");
// /opt/homebrew/include/Z/types/integral.h:424:10
pub const Z_UINT_LEAST32_FUNDAMENTAL = @compileError("unable to translate macro: undefined identifier `UINT_LEAST32`");
// /opt/homebrew/include/Z/types/integral.h:425:10
pub const Z_UINT_LEAST32_FIXED_FUNDAMENTAL = @compileError("unable to translate macro: undefined identifier `UINT_LEAST32`");
// /opt/homebrew/include/Z/types/integral.h:426:10
pub const Z_UINT_LEAST32_MAXIMUM = @compileError("unable to translate macro: undefined identifier `UINT_LEAST32`");
// /opt/homebrew/include/Z/types/integral.h:427:10
pub const Z_SINT_LEAST32_WIDTH = @as(c_int, 32);
pub const Z_SINT_LEAST32 = @compileError("unable to translate macro: undefined identifier `SINT_LEAST32`");
// /opt/homebrew/include/Z/types/integral.h:446:10
pub const Z_SINT_LEAST32_FUNDAMENTAL = @compileError("unable to translate macro: undefined identifier `SINT_LEAST32`");
// /opt/homebrew/include/Z/types/integral.h:447:10
pub const Z_SINT_LEAST32_FIXED_FUNDAMENTAL = @compileError("unable to translate macro: undefined identifier `SINT_LEAST32`");
// /opt/homebrew/include/Z/types/integral.h:448:10
pub const Z_SINT_LEAST32_MAXIMUM = @compileError("unable to translate macro: undefined identifier `SINT_LEAST32`");
// /opt/homebrew/include/Z/types/integral.h:449:10
pub const Z_SINT_LEAST32_MINIMUM = -Z_SINT_LEAST32_MAXIMUM - Z_SINT_LEAST32(@as(c_int, 1));
pub const Z_UINT_LEAST40_WIDTH = @as(c_int, 64);
pub const Z_UINT_LEAST40 = @compileError("unable to translate macro: undefined identifier `UINT_LEAST40`");
// /opt/homebrew/include/Z/types/integral.h:467:10
pub const Z_UINT_LEAST40_FUNDAMENTAL = @compileError("unable to translate macro: undefined identifier `UINT_LEAST40`");
// /opt/homebrew/include/Z/types/integral.h:468:10
pub const Z_UINT_LEAST40_FIXED_FUNDAMENTAL = @compileError("unable to translate macro: undefined identifier `UINT_LEAST40`");
// /opt/homebrew/include/Z/types/integral.h:469:10
pub const Z_UINT_LEAST40_MAXIMUM = @compileError("unable to translate macro: undefined identifier `UINT_LEAST40`");
// /opt/homebrew/include/Z/types/integral.h:470:10
pub const Z_SINT_LEAST40_WIDTH = @as(c_int, 64);
pub const Z_SINT_LEAST40 = @compileError("unable to translate macro: undefined identifier `SINT_LEAST40`");
// /opt/homebrew/include/Z/types/integral.h:487:10
pub const Z_SINT_LEAST40_FUNDAMENTAL = @compileError("unable to translate macro: undefined identifier `SINT_LEAST40`");
// /opt/homebrew/include/Z/types/integral.h:488:10
pub const Z_SINT_LEAST40_FIXED_FUNDAMENTAL = @compileError("unable to translate macro: undefined identifier `SINT_LEAST40`");
// /opt/homebrew/include/Z/types/integral.h:489:10
pub const Z_SINT_LEAST40_MAXIMUM = @compileError("unable to translate macro: undefined identifier `SINT_LEAST40`");
// /opt/homebrew/include/Z/types/integral.h:490:10
pub const Z_SINT_LEAST40_MINIMUM = -Z_SINT_LEAST40_MAXIMUM - Z_SINT_LEAST40(@as(c_int, 1));
pub const Z_UINT_LEAST48_WIDTH = @as(c_int, 64);
pub const Z_UINT_LEAST48 = @compileError("unable to translate macro: undefined identifier `UINT_LEAST48`");
// /opt/homebrew/include/Z/types/integral.h:506:10
pub const Z_UINT_LEAST48_FUNDAMENTAL = @compileError("unable to translate macro: undefined identifier `UINT_LEAST48`");
// /opt/homebrew/include/Z/types/integral.h:507:10
pub const Z_UINT_LEAST48_FIXED_FUNDAMENTAL = @compileError("unable to translate macro: undefined identifier `UINT_LEAST48`");
// /opt/homebrew/include/Z/types/integral.h:508:10
pub const Z_UINT_LEAST48_MAXIMUM = @compileError("unable to translate macro: undefined identifier `UINT_LEAST48`");
// /opt/homebrew/include/Z/types/integral.h:509:10
pub const Z_SINT_LEAST48_WIDTH = @as(c_int, 64);
pub const Z_SINT_LEAST48 = @compileError("unable to translate macro: undefined identifier `SINT_LEAST48`");
// /opt/homebrew/include/Z/types/integral.h:524:10
pub const Z_SINT_LEAST48_FUNDAMENTAL = @compileError("unable to translate macro: undefined identifier `SINT_LEAST48`");
// /opt/homebrew/include/Z/types/integral.h:525:10
pub const Z_SINT_LEAST48_FIXED_FUNDAMENTAL = @compileError("unable to translate macro: undefined identifier `SINT_LEAST48`");
// /opt/homebrew/include/Z/types/integral.h:526:10
pub const Z_SINT_LEAST48_MAXIMUM = @compileError("unable to translate macro: undefined identifier `SINT_LEAST48`");
// /opt/homebrew/include/Z/types/integral.h:527:10
pub const Z_SINT_LEAST48_MINIMUM = -Z_SINT_LEAST48_MAXIMUM - Z_SINT_LEAST48(@as(c_int, 1));
pub const Z_UINT_LEAST56_WIDTH = @as(c_int, 64);
pub const Z_UINT_LEAST56 = @compileError("unable to translate macro: undefined identifier `UINT_LEAST56`");
// /opt/homebrew/include/Z/types/integral.h:541:10
pub const Z_UINT_LEAST56_FUNDAMENTAL = @compileError("unable to translate macro: undefined identifier `UINT_LEAST56`");
// /opt/homebrew/include/Z/types/integral.h:542:10
pub const Z_UINT_LEAST56_FIXED_FUNDAMENTAL = @compileError("unable to translate macro: undefined identifier `UINT_LEAST56`");
// /opt/homebrew/include/Z/types/integral.h:543:10
pub const Z_UINT_LEAST56_MAXIMUM = @compileError("unable to translate macro: undefined identifier `UINT_LEAST56`");
// /opt/homebrew/include/Z/types/integral.h:544:10
pub const Z_SINT_LEAST56_WIDTH = @as(c_int, 64);
pub const Z_SINT_LEAST56 = @compileError("unable to translate macro: undefined identifier `SINT_LEAST56`");
// /opt/homebrew/include/Z/types/integral.h:557:10
pub const Z_SINT_LEAST56_FUNDAMENTAL = @compileError("unable to translate macro: undefined identifier `SINT_LEAST56`");
// /opt/homebrew/include/Z/types/integral.h:558:10
pub const Z_SINT_LEAST56_FIXED_FUNDAMENTAL = @compileError("unable to translate macro: undefined identifier `SINT_LEAST56`");
// /opt/homebrew/include/Z/types/integral.h:559:10
pub const Z_SINT_LEAST56_MAXIMUM = @compileError("unable to translate macro: undefined identifier `SINT_LEAST56`");
// /opt/homebrew/include/Z/types/integral.h:560:10
pub const Z_SINT_LEAST56_MINIMUM = -Z_SINT_LEAST56_MAXIMUM - Z_SINT_LEAST56(@as(c_int, 1));
pub const Z_UINT_LEAST64_WIDTH = @as(c_int, 64);
pub const Z_UINT_LEAST64 = @compileError("unable to translate macro: undefined identifier `UINT_LEAST64`");
// /opt/homebrew/include/Z/types/integral.h:572:10
pub const Z_UINT_LEAST64_FUNDAMENTAL = @compileError("unable to translate macro: undefined identifier `UINT_LEAST64`");
// /opt/homebrew/include/Z/types/integral.h:573:10
pub const Z_UINT_LEAST64_FIXED_FUNDAMENTAL = @compileError("unable to translate macro: undefined identifier `UINT_LEAST64`");
// /opt/homebrew/include/Z/types/integral.h:574:10
pub const Z_UINT_LEAST64_MAXIMUM = @compileError("unable to translate macro: undefined identifier `UINT_LEAST64`");
// /opt/homebrew/include/Z/types/integral.h:575:10
pub const Z_SINT_LEAST64_WIDTH = @as(c_int, 64);
pub const Z_SINT_LEAST64 = @compileError("unable to translate macro: undefined identifier `SINT_LEAST64`");
// /opt/homebrew/include/Z/types/integral.h:586:10
pub const Z_SINT_LEAST64_FUNDAMENTAL = @compileError("unable to translate macro: undefined identifier `SINT_LEAST64`");
// /opt/homebrew/include/Z/types/integral.h:587:10
pub const Z_SINT_LEAST64_FIXED_FUNDAMENTAL = @compileError("unable to translate macro: undefined identifier `SINT_LEAST64`");
// /opt/homebrew/include/Z/types/integral.h:588:10
pub const Z_SINT_LEAST64_MAXIMUM = @compileError("unable to translate macro: undefined identifier `SINT_LEAST64`");
// /opt/homebrew/include/Z/types/integral.h:589:10
pub const Z_SINT_LEAST64_MINIMUM = -Z_SINT_LEAST64_MAXIMUM - Z_SINT_LEAST64(@as(c_int, 1));
pub const Z_CHAR_FIXED_FUNDAMENTAL = @compileError("unable to translate macro: undefined identifier `CHAR`");
// /opt/homebrew/include/Z/types/integral.h:600:10
pub const Z_CHAR_IS_SIGNED = @as(c_int, 1);
pub const Z_CHAR_MINIMUM = -Z_CHAR_MAXIMUM - @as(c_int, 1);
pub const Z_CHAR = Z_SAME;
pub const Z_CHAR_FUNDAMENTAL = Z_FUNDAMENTAL_CHAR;
pub const Z_CHAR_WIDTH = @compileError("unable to translate macro: undefined identifier `CHAR`");
// /opt/homebrew/include/Z/types/integral.h:608:9
pub const Z_CHAR_MAXIMUM = @compileError("unable to translate macro: undefined identifier `CHAR`");
// /opt/homebrew/include/Z/types/integral.h:609:9
pub const Z_UCHAR = Z_SUFFIX_U;
pub const Z_UCHAR_FUNDAMENTAL = Z_FUNDAMENTAL_UCHAR;
pub const Z_UCHAR_FIXED_FUNDAMENTAL = @compileError("unable to translate macro: undefined identifier `UCHAR`");
// /opt/homebrew/include/Z/types/integral.h:614:9
pub const Z_UCHAR_WIDTH = @compileError("unable to translate macro: undefined identifier `CHAR`");
// /opt/homebrew/include/Z/types/integral.h:615:9
pub const Z_UCHAR_MAXIMUM = @compileError("unable to translate macro: undefined identifier `UCHAR`");
// /opt/homebrew/include/Z/types/integral.h:616:9
pub const Z_SCHAR = Z_SAME;
pub const Z_SCHAR_FUNDAMENTAL = Z_FUNDAMENTAL_SCHAR;
pub const Z_SCHAR_FIXED_FUNDAMENTAL = @compileError("unable to translate macro: undefined identifier `SCHAR`");
// /opt/homebrew/include/Z/types/integral.h:621:9
pub const Z_SCHAR_WIDTH = @compileError("unable to translate macro: undefined identifier `CHAR`");
// /opt/homebrew/include/Z/types/integral.h:622:9
pub const Z_SCHAR_MAXIMUM = @compileError("unable to translate macro: undefined identifier `SCHAR`");
// /opt/homebrew/include/Z/types/integral.h:623:9
pub const Z_SCHAR_MINIMUM = -Z_SCHAR_MAXIMUM - @as(c_int, 1);
pub const Z_USHORT = Z_SUFFIX_U;
pub const Z_USHORT_FUNDAMENTAL = Z_FUNDAMENTAL_USHORT;
pub const Z_USHORT_FIXED_FUNDAMENTAL = @compileError("unable to translate macro: undefined identifier `USHORT`");
// /opt/homebrew/include/Z/types/integral.h:629:9
pub const Z_USHORT_WIDTH = @compileError("unable to translate macro: undefined identifier `SHORT`");
// /opt/homebrew/include/Z/types/integral.h:630:9
pub const Z_USHORT_MAXIMUM = @compileError("unable to translate macro: undefined identifier `USHORT`");
// /opt/homebrew/include/Z/types/integral.h:631:9
pub const Z_SSHORT = Z_SAME;
pub const Z_SSHORT_FUNDAMENTAL = Z_FUNDAMENTAL_SSHORT;
pub const Z_SSHORT_FIXED_FUNDAMENTAL = @compileError("unable to translate macro: undefined identifier `SSHORT`");
// /opt/homebrew/include/Z/types/integral.h:636:9
pub const Z_SSHORT_WIDTH = @compileError("unable to translate macro: undefined identifier `SHORT`");
// /opt/homebrew/include/Z/types/integral.h:637:9
pub const Z_SSHORT_MAXIMUM = @compileError("unable to translate macro: undefined identifier `SSHORT`");
// /opt/homebrew/include/Z/types/integral.h:638:9
pub const Z_SSHORT_MINIMUM = -Z_SSHORT_MAXIMUM - @as(c_int, 1);
pub const Z_UINT = Z_SUFFIX_U;
pub const Z_UINT_FUNDAMENTAL = Z_FUNDAMENTAL_UINT;
pub const Z_UINT_FIXED_FUNDAMENTAL = @compileError("unable to translate macro: undefined identifier `UINT`");
// /opt/homebrew/include/Z/types/integral.h:644:9
pub const Z_UINT_WIDTH = @compileError("unable to translate macro: undefined identifier `INT`");
// /opt/homebrew/include/Z/types/integral.h:645:9
pub const Z_UINT_MAXIMUM = @compileError("unable to translate macro: undefined identifier `UINT`");
// /opt/homebrew/include/Z/types/integral.h:646:9
pub const Z_SINT = Z_SAME;
pub const Z_SINT_FUNDAMENTAL = Z_FUNDAMENTAL_SINT;
pub const Z_SINT_FIXED_FUNDAMENTAL = @compileError("unable to translate macro: undefined identifier `SINT`");
// /opt/homebrew/include/Z/types/integral.h:651:9
pub const Z_SINT_WIDTH = @compileError("unable to translate macro: undefined identifier `INT`");
// /opt/homebrew/include/Z/types/integral.h:652:9
pub const Z_SINT_MAXIMUM = @compileError("unable to translate macro: undefined identifier `SINT`");
// /opt/homebrew/include/Z/types/integral.h:653:9
pub const Z_SINT_MINIMUM = -Z_SINT_MAXIMUM - @as(c_int, 1);
pub const Z_ULONG = Z_SUFFIX_UL;
pub const Z_ULONG_FUNDAMENTAL = Z_FUNDAMENTAL_ULONG;
pub const Z_ULONG_FIXED_FUNDAMENTAL = @compileError("unable to translate macro: undefined identifier `ULONG`");
// /opt/homebrew/include/Z/types/integral.h:659:9
pub const Z_ULONG_WIDTH = @compileError("unable to translate macro: undefined identifier `LONG`");
// /opt/homebrew/include/Z/types/integral.h:660:9
pub const Z_ULONG_MAXIMUM = @compileError("unable to translate macro: undefined identifier `ULONG`");
// /opt/homebrew/include/Z/types/integral.h:661:9
pub const Z_SLONG = Z_SUFFIX_L;
pub const Z_SLONG_FUNDAMENTAL = Z_FUNDAMENTAL_SLONG;
pub const Z_SLONG_FIXED_FUNDAMENTAL = @compileError("unable to translate macro: undefined identifier `SLONG`");
// /opt/homebrew/include/Z/types/integral.h:666:9
pub const Z_SLONG_WIDTH = @compileError("unable to translate macro: undefined identifier `LONG`");
// /opt/homebrew/include/Z/types/integral.h:667:9
pub const Z_SLONG_MAXIMUM = @compileError("unable to translate macro: undefined identifier `SLONG`");
// /opt/homebrew/include/Z/types/integral.h:668:9
pub const Z_SLONG_MINIMUM = -Z_SLONG_MAXIMUM - @as(c_long, 1);
pub const Z_ULLONG = Z_SUFFIX_ULL;
pub const Z_ULLONG_FUNDAMENTAL = Z_FUNDAMENTAL_ULLONG;
pub const Z_ULLONG_FIXED_FUNDAMENTAL = @compileError("unable to translate macro: undefined identifier `ULLONG`");
// /opt/homebrew/include/Z/types/integral.h:675:10
pub const Z_ULLONG_WIDTH = @compileError("unable to translate macro: undefined identifier `LLONG`");
// /opt/homebrew/include/Z/types/integral.h:676:10
pub const Z_ULLONG_MAXIMUM = @compileError("unable to translate macro: undefined identifier `ULLONG`");
// /opt/homebrew/include/Z/types/integral.h:677:10
pub const Z_SLLONG = Z_SUFFIX_LL;
pub const Z_SLLONG_FUNDAMENTAL = Z_FUNDAMENTAL_SLLONG;
pub const Z_SLLONG_FIXED_FUNDAMENTAL = @compileError("unable to translate macro: undefined identifier `SLLONG`");
// /opt/homebrew/include/Z/types/integral.h:682:10
pub const Z_SLLONG_WIDTH = @compileError("unable to translate macro: undefined identifier `LLONG`");
// /opt/homebrew/include/Z/types/integral.h:683:10
pub const Z_SLLONG_MAXIMUM = @compileError("unable to translate macro: undefined identifier `SLLONG`");
// /opt/homebrew/include/Z/types/integral.h:684:10
pub const Z_SLLONG_MINIMUM = -Z_SLLONG_MAXIMUM - @as(c_longlong, 1);
pub const Z_LLONG = "";
pub const Z_BOOL = Z_SAME;
pub const Z_BOOL_FUNDAMENTAL = Z_FUNDAMENTAL_BOOL;
pub const Z_BOOL_FIXED_FUNDAMENTAL = Z_UCHAR_FIXED_FUNDAMENTAL;
pub const Z_BOOL_WIDTH = Z_UCHAR_WIDTH;
pub const Z_USIZE_WIDTH = @compileError("unable to translate macro: undefined identifier `SIZE`");
// /opt/homebrew/include/Z/types/integral.h:706:9
pub const Z_USIZE_BITS = Z_USIZE_WIDTH;
pub const Z_USIZE = @compileError("unable to translate macro: undefined identifier `USIZE`");
// /opt/homebrew/include/Z/types/integral.h:710:9
pub const Z_USIZE_FUNDAMENTAL = @compileError("unable to translate macro: undefined identifier `USIZE`");
// /opt/homebrew/include/Z/types/integral.h:711:9
pub const Z_USIZE_FIXED_FUNDAMENTAL = @compileError("unable to translate macro: undefined identifier `USIZE`");
// /opt/homebrew/include/Z/types/integral.h:712:9
pub const Z_USIZE_MAXIMUM = @compileError("unable to translate macro: undefined identifier `USIZE`");
// /opt/homebrew/include/Z/types/integral.h:713:9
pub const Z_SSIZE_WIDTH = @compileError("unable to translate macro: undefined identifier `SIZE`");
// /opt/homebrew/include/Z/types/integral.h:715:9
pub const Z_SSIZE = @compileError("unable to translate macro: undefined identifier `SSIZE`");
// /opt/homebrew/include/Z/types/integral.h:718:9
pub const Z_SSIZE_FUNDAMENTAL = @compileError("unable to translate macro: undefined identifier `SSIZE`");
// /opt/homebrew/include/Z/types/integral.h:719:9
pub const Z_SSIZE_FIXED_FUNDAMENTAL = @compileError("unable to translate macro: undefined identifier `SSIZE`");
// /opt/homebrew/include/Z/types/integral.h:720:9
pub const Z_SSIZE_MAXIMUM = @compileError("unable to translate macro: undefined identifier `SSIZE`");
// /opt/homebrew/include/Z/types/integral.h:721:9
pub const Z_SSIZE_MINIMUM = -Z_SSIZE_MAXIMUM - Z_SSIZE(@as(c_int, 1));
pub const Z_UINTMAX_WIDTH = @as(c_int, 128);
pub const Z_UINTMAX = @compileError("unable to translate macro: undefined identifier `UINTMAX`");
// /opt/homebrew/include/Z/types/integral.h:737:9
pub const Z_UINTMAX_FUNDAMENTAL = @compileError("unable to translate macro: undefined identifier `UINTMAX`");
// /opt/homebrew/include/Z/types/integral.h:738:9
pub const Z_UINTMAX_FIXED_FUNDAMENTAL = @compileError("unable to translate macro: undefined identifier `UINTMAX`");
// /opt/homebrew/include/Z/types/integral.h:739:9
pub const Z_UINTMAX_MAXIMUM = @compileError("unable to translate macro: undefined identifier `UINTMAX`");
// /opt/homebrew/include/Z/types/integral.h:740:9
pub const Z_SINTMAX_WIDTH = @as(c_int, 128);
pub const Z_SINTMAX = @compileError("unable to translate macro: undefined identifier `SINTMAX`");
// /opt/homebrew/include/Z/types/integral.h:753:9
pub const Z_SINTMAX_FUNDAMENTAL = @compileError("unable to translate macro: undefined identifier `SINTMAX`");
// /opt/homebrew/include/Z/types/integral.h:754:9
pub const Z_SINTMAX_FIXED_FUNDAMENTAL = @compileError("unable to translate macro: undefined identifier `SINTMAX`");
// /opt/homebrew/include/Z/types/integral.h:755:9
pub const Z_SINTMAX_MAXIMUM = @compileError("unable to translate macro: undefined identifier `SINTMAX`");
// /opt/homebrew/include/Z/types/integral.h:756:9
pub const Z_SINTMAX_MINIMUM = -Z_SINTMAX_MAXIMUM - Z_SINTMAX(@as(c_int, 1));
pub const Z_INTMAX = Z_UINTMAX;
pub const Z_INTMAX_FUNDAMENTAL = Z_UINTMAX_FUNDAMENTAL;
pub const Z_INTMAX_FIXED_FUNDAMENTAL = Z_UINTMAX_FIXED_FUNDAMENTAL;
pub const Z_INTMAX_WIDTH = Z_UINTMAX_WIDTH;
pub const Z_INTMAX_MAXIMUM = Z_UINTMAX_MAXIMUM;
pub const Z_INTMAX_MINIMUM = Z_UINTMAX(@as(c_int, 0));
pub const Z_POINTER_WIDTH = @compileError("unable to translate macro: undefined identifier `POINTER`");
// /opt/homebrew/include/Z/types/integral.h:779:9
pub const Z_UINTPTR_WIDTH = Z_POINTER_WIDTH;
pub const Z_UINTPTR = @compileError("unable to translate macro: undefined identifier `UINTPTR`");
// /opt/homebrew/include/Z/types/integral.h:784:9
pub const Z_UINTPTR_FUNDAMENTAL = @compileError("unable to translate macro: undefined identifier `UINTPTR`");
// /opt/homebrew/include/Z/types/integral.h:785:9
pub const Z_UINTPTR_FIXED_FUNDAMENTAL = @compileError("unable to translate macro: undefined identifier `UINTPTR`");
// /opt/homebrew/include/Z/types/integral.h:786:9
pub const Z_UINTPTR_MAXIMUM = @compileError("unable to translate macro: undefined identifier `UINTPTR`");
// /opt/homebrew/include/Z/types/integral.h:787:9
pub const Z_SINTPTR_WIDTH = Z_POINTER_WIDTH;
pub const Z_SINTPTR = @compileError("unable to translate macro: undefined identifier `SINTPTR`");
// /opt/homebrew/include/Z/types/integral.h:792:9
pub const Z_SINTPTR_FUNDAMENTAL = @compileError("unable to translate macro: undefined identifier `SINTPTR`");
// /opt/homebrew/include/Z/types/integral.h:793:9
pub const Z_SINTPTR_FIXED_FUNDAMENTAL = @compileError("unable to translate macro: undefined identifier `SINTPTR`");
// /opt/homebrew/include/Z/types/integral.h:794:9
pub const Z_SINTPTR_MAXIMUM = @compileError("unable to translate macro: undefined identifier `SINTPTR`");
// /opt/homebrew/include/Z/types/integral.h:795:9
pub const Z_SINTPTR_MINIMUM = -Z_SINTPTR_MAXIMUM - Z_SINTPTR(@as(c_int, 1));
pub const Z_PTRDIFF = Z_SINTPTR;
pub const Z_PTRDIFF_FUNDAMENTAL = Z_SINTPTR_FUNDAMENTAL;
pub const Z_PTRDIFF_FIXED_FUNDAMENTAL = Z_SINTPTR_FIXED_FUNDAMENTAL;
pub const Z_PTRDIFF_WIDTH = Z_SINTPTR_WIDTH;
pub const Z_PTRDIFF_MAXIMUM = Z_SINTPTR_MAXIMUM;
pub const Z_PTRDIFF_MINIMUM = Z_SINTPTR_MINIMUM;
pub const Z_BOOLEAN = Z_BOOL;
pub const Z_BOOLEAN_FUNDAMENTAL = Z_BOOL_FUNDAMENTAL;
pub const Z_BOOLEAN_FIXED_FUNDAMENTAL = Z_BOOL_FIXED_FUNDAMENTAL;
pub const Z_BOOLEAN_WIDTH = Z_BOOL_WIDTH;
pub const Z_NATURAL_WIDTH = Z_ULONG_WIDTH;
pub const Z_NATURAL = @compileError("unable to translate macro: undefined identifier `NATURAL`");
// /opt/homebrew/include/Z/types/integral.h:839:9
pub const Z_NATURAL_FUNDAMENTAL = @compileError("unable to translate macro: undefined identifier `NATURAL`");
// /opt/homebrew/include/Z/types/integral.h:840:9
pub const Z_NATURAL_FIXED_FUNDAMENTAL = @compileError("unable to translate macro: undefined identifier `NATURAL`");
// /opt/homebrew/include/Z/types/integral.h:841:9
pub const Z_NATURAL_MAXIMUM = @compileError("unable to translate macro: undefined identifier `NATURAL`");
// /opt/homebrew/include/Z/types/integral.h:842:9
pub const Z_INTEGER_WIDTH = Z_SLONG_WIDTH;
pub const Z_INTEGER = @compileError("unable to translate macro: undefined identifier `INTEGER`");
// /opt/homebrew/include/Z/types/integral.h:849:9
pub const Z_INTEGER_FUNDAMENTAL = @compileError("unable to translate macro: undefined identifier `INTEGER`");
// /opt/homebrew/include/Z/types/integral.h:850:9
pub const Z_INTEGER_FIXED_FUNDAMENTAL = @compileError("unable to translate macro: undefined identifier `INTEGER`");
// /opt/homebrew/include/Z/types/integral.h:851:9
pub const Z_INTEGER_MAXIMUM = @compileError("unable to translate macro: undefined identifier `INTEGER`");
// /opt/homebrew/include/Z/types/integral.h:852:9
pub const Z_INTEGER_MINIMUM = -Z_INTEGER_MAXIMUM - Z_INTEGER(@as(c_int, 1));
pub const Z_macros_structure_H = "";
pub const Z_MEMBER_OFFSET = @compileError("unable to translate macro: undefined identifier `MEMBER_OFFSET`");
// /opt/homebrew/include/Z/macros/structure.h:15:10
pub const Z_HAS_ZInt8 = @as(c_int, 1);
pub const Z_HAS_ZInt16 = @as(c_int, 1);
pub const Z_HAS_ZInt32 = @as(c_int, 1);
pub const Z_HAS_ZInt64 = @as(c_int, 1);
pub const Z_HAS_ZInt128 = @as(c_int, 1);
pub const Z80_API = "";
pub const Z80_LIBRARY_VERSION_MAJOR = @as(c_int, 0);
pub const Z80_LIBRARY_VERSION_MINOR = @as(c_int, 2);
pub const Z80_LIBRARY_VERSION_MICRO = @as(c_int, 0);
pub const Z80_LIBRARY_VERSION_STRING = "0.2";
pub const Z80_MAXIMUM_CYCLES = Z_USIZE_MAXIMUM - Z_USIZE(@as(c_int, 30));
pub const Z80_MAXIMUM_CYCLES_PER_STEP = @as(c_int, 25);
pub const Z80_MINIMUM_CYCLES_PER_STEP = @as(c_int, 4);
pub const Z80_HOOK = @as(c_int, 0x64);
pub const Z80_SF = @as(c_int, 128);
pub const Z80_ZF = @as(c_int, 64);
pub const Z80_YF = @as(c_int, 32);
pub const Z80_HF = @as(c_int, 16);
pub const Z80_XF = @as(c_int, 8);
pub const Z80_PF = @as(c_int, 4);
pub const Z80_NF = @as(c_int, 2);
pub const Z80_CF = @as(c_int, 1);
pub const Z80_OPTION_OUT_VC_255 = @as(c_int, 1);
pub const Z80_OPTION_LD_A_IR_BUG = @as(c_int, 2);
pub const Z80_OPTION_HALT_SKIP = @as(c_int, 4);
pub const Z80_OPTION_XQ = @as(c_int, 8);
pub const Z80_OPTION_IM0_RETX_NOTIFICATIONS = @as(c_int, 16);
pub const Z80_OPTION_YQ = @as(c_int, 32);
pub const Z80_MODEL_ZILOG_NMOS = (Z80_OPTION_LD_A_IR_BUG | Z80_OPTION_XQ) | Z80_OPTION_YQ;
pub const Z80_MODEL_ZILOG_CMOS = (Z80_OPTION_OUT_VC_255 | Z80_OPTION_XQ) | Z80_OPTION_YQ;
pub const Z80_MODEL_NEC_NMOS = Z80_OPTION_LD_A_IR_BUG;
pub const Z80_MODEL_ST_CMOS = (Z80_OPTION_OUT_VC_255 | Z80_OPTION_LD_A_IR_BUG) | Z80_OPTION_YQ;
pub const Z80_REQUEST_REJECT_NMI = @as(c_int, 2);
pub const Z80_REQUEST_NMI = @as(c_int, 4);
pub const Z80_REQUEST_INT = @as(c_int, 8);
pub const Z80_REQUEST_SPECIAL_RESET = @as(c_int, 16);
pub const Z80_RESUME_HALT = @as(c_int, 1);
pub const Z80_RESUME_XY = @as(c_int, 2);
pub const Z80_RESUME_IM0_XY = @as(c_int, 3);
pub const Z80_HALT_EXIT_EARLY = @as(c_int, 2);
pub const Z80_HALT_CANCEL = @as(c_int, 3);
pub inline fn Z80_MEMPTR(object: anytype) @TypeOf(object.memptr.uint16_value) {
    _ = &object;
    return object.memptr.uint16_value;
}
pub inline fn Z80_PC(object: anytype) @TypeOf(object.pc.uint16_value) {
    _ = &object;
    return object.pc.uint16_value;
}
pub inline fn Z80_SP(object: anytype) @TypeOf(object.sp.uint16_value) {
    _ = &object;
    return object.sp.uint16_value;
}
pub inline fn Z80_XY(object: anytype) @TypeOf(object.xy.uint16_value) {
    _ = &object;
    return object.xy.uint16_value;
}
pub inline fn Z80_IX(object: anytype) @TypeOf(object.ix_iy[@as(usize, @intCast(@as(c_int, 0)))].uint16_value) {
    _ = &object;
    return object.ix_iy[@as(usize, @intCast(@as(c_int, 0)))].uint16_value;
}
pub inline fn Z80_IY(object: anytype) @TypeOf(object.ix_iy[@as(usize, @intCast(@as(c_int, 1)))].uint16_value) {
    _ = &object;
    return object.ix_iy[@as(usize, @intCast(@as(c_int, 1)))].uint16_value;
}
pub inline fn Z80_AF(object: anytype) @TypeOf(object.af.uint16_value) {
    _ = &object;
    return object.af.uint16_value;
}
pub inline fn Z80_BC(object: anytype) @TypeOf(object.bc.uint16_value) {
    _ = &object;
    return object.bc.uint16_value;
}
pub inline fn Z80_DE(object: anytype) @TypeOf(object.de.uint16_value) {
    _ = &object;
    return object.de.uint16_value;
}
pub inline fn Z80_HL(object: anytype) @TypeOf(object.hl.uint16_value) {
    _ = &object;
    return object.hl.uint16_value;
}
pub inline fn Z80_AF_(object: anytype) @TypeOf(object.af_.uint16_value) {
    _ = &object;
    return object.af_.uint16_value;
}
pub inline fn Z80_BC_(object: anytype) @TypeOf(object.bc_.uint16_value) {
    _ = &object;
    return object.bc_.uint16_value;
}
pub inline fn Z80_DE_(object: anytype) @TypeOf(object.de_.uint16_value) {
    _ = &object;
    return object.de_.uint16_value;
}
pub inline fn Z80_HL_(object: anytype) @TypeOf(object.hl_.uint16_value) {
    _ = &object;
    return object.hl_.uint16_value;
}
pub inline fn Z80_MEMPTRH(object: anytype) @TypeOf(object.memptr.uint8_values.at_1) {
    _ = &object;
    return object.memptr.uint8_values.at_1;
}
pub inline fn Z80_MEMPTRL(object: anytype) @TypeOf(object.memptr.uint8_values.at_0) {
    _ = &object;
    return object.memptr.uint8_values.at_0;
}
pub inline fn Z80_PCH(object: anytype) @TypeOf(object.pc.uint8_values.at_1) {
    _ = &object;
    return object.pc.uint8_values.at_1;
}
pub inline fn Z80_PCL(object: anytype) @TypeOf(object.pc.uint8_values.at_0) {
    _ = &object;
    return object.pc.uint8_values.at_0;
}
pub inline fn Z80_SPH(object: anytype) @TypeOf(object.sp.uint8_values.at_1) {
    _ = &object;
    return object.sp.uint8_values.at_1;
}
pub inline fn Z80_SPL(object: anytype) @TypeOf(object.sp.uint8_values.at_0) {
    _ = &object;
    return object.sp.uint8_values.at_0;
}
pub inline fn Z80_XYH(object: anytype) @TypeOf(object.xy.uint8_values.at_1) {
    _ = &object;
    return object.xy.uint8_values.at_1;
}
pub inline fn Z80_XYL(object: anytype) @TypeOf(object.xy.uint8_values.at_0) {
    _ = &object;
    return object.xy.uint8_values.at_0;
}
pub inline fn Z80_IXH(object: anytype) @TypeOf(object.ix_iy[@as(usize, @intCast(@as(c_int, 0)))].uint8_values.at_1) {
    _ = &object;
    return object.ix_iy[@as(usize, @intCast(@as(c_int, 0)))].uint8_values.at_1;
}
pub inline fn Z80_IXL(object: anytype) @TypeOf(object.ix_iy[@as(usize, @intCast(@as(c_int, 0)))].uint8_values.at_0) {
    _ = &object;
    return object.ix_iy[@as(usize, @intCast(@as(c_int, 0)))].uint8_values.at_0;
}
pub inline fn Z80_IYH(object: anytype) @TypeOf(object.ix_iy[@as(usize, @intCast(@as(c_int, 1)))].uint8_values.at_1) {
    _ = &object;
    return object.ix_iy[@as(usize, @intCast(@as(c_int, 1)))].uint8_values.at_1;
}
pub inline fn Z80_IYL(object: anytype) @TypeOf(object.ix_iy[@as(usize, @intCast(@as(c_int, 1)))].uint8_values.at_0) {
    _ = &object;
    return object.ix_iy[@as(usize, @intCast(@as(c_int, 1)))].uint8_values.at_0;
}
pub inline fn Z80_A(object: anytype) @TypeOf(object.af.uint8_values.at_1) {
    _ = &object;
    return object.af.uint8_values.at_1;
}
pub inline fn Z80_F(object: anytype) @TypeOf(object.af.uint8_values.at_0) {
    _ = &object;
    return object.af.uint8_values.at_0;
}
pub inline fn Z80_B(object: anytype) @TypeOf(object.bc.uint8_values.at_1) {
    _ = &object;
    return object.bc.uint8_values.at_1;
}
pub inline fn Z80_C(object: anytype) @TypeOf(object.bc.uint8_values.at_0) {
    _ = &object;
    return object.bc.uint8_values.at_0;
}
pub inline fn Z80_D(object: anytype) @TypeOf(object.de.uint8_values.at_1) {
    _ = &object;
    return object.de.uint8_values.at_1;
}
pub inline fn Z80_E(object: anytype) @TypeOf(object.de.uint8_values.at_0) {
    _ = &object;
    return object.de.uint8_values.at_0;
}
pub inline fn Z80_H(object: anytype) @TypeOf(object.hl.uint8_values.at_1) {
    _ = &object;
    return object.hl.uint8_values.at_1;
}
pub inline fn Z80_L(object: anytype) @TypeOf(object.hl.uint8_values.at_0) {
    _ = &object;
    return object.hl.uint8_values.at_0;
}
pub inline fn Z80_A_(object: anytype) @TypeOf(object.af_.uint8_values.at_1) {
    _ = &object;
    return object.af_.uint8_values.at_1;
}
pub inline fn Z80_F_(object: anytype) @TypeOf(object.af_.uint8_values.at_0) {
    _ = &object;
    return object.af_.uint8_values.at_0;
}
pub inline fn Z80_B_(object: anytype) @TypeOf(object.bc_.uint8_values.at_1) {
    _ = &object;
    return object.bc_.uint8_values.at_1;
}
pub inline fn Z80_C_(object: anytype) @TypeOf(object.bc_.uint8_values.at_0) {
    _ = &object;
    return object.bc_.uint8_values.at_0;
}
pub inline fn Z80_D_(object: anytype) @TypeOf(object.de_.uint8_values.at_1) {
    _ = &object;
    return object.de_.uint8_values.at_1;
}
pub inline fn Z80_E_(object: anytype) @TypeOf(object.de_.uint8_values.at_0) {
    _ = &object;
    return object.de_.uint8_values.at_0;
}
pub inline fn Z80_H_(object: anytype) @TypeOf(object.hl_.uint8_values.at_1) {
    _ = &object;
    return object.hl_.uint8_values.at_1;
}
pub inline fn Z80_L_(object: anytype) @TypeOf(object.hl_.uint8_values.at_0) {
    _ = &object;
    return object.hl_.uint8_values.at_0;
}
pub const Z80_WZ = Z80_MEMPTR;
pub const Z80_WZH = Z80_MEMPTRH;
pub const Z80_WZL = Z80_MEMPTRL;
