const std = @import("std");
const Allocator = std.mem.Allocator;

const utils = @import("utils.zig");

pub const Z80 = struct {
    // 8-bit registers
    af: u16,
    bc: u16,
    de: u16,
    hl: u16,
    af_: u16,
    bc_: u16,
    de_: u16,
    hl_: u16,

    // 16-bit registers
    pc: u16,
    sp: u16,

    // Index registers
    ix: u16,
    iy: u16,

    // Other regisers
    i: u8, // Interrupt vector
    r: u8, // Memory refresh

    // Interrupt handling
    iff1: bool, // Interrupt flip-flop 1
    iff2: bool, // Interrupt flip-flop 2
    im: u8, // Interrupt mode

    // Memory (for simplicity, let's assume 64KB)
    memory: [65536]u8,

    // Internal state
    cycles: u64,
    halt: bool,

    // Pending opcode
    pending_opcode: ?u8,

    // Write handler
    write: ?*const fn (*Z80, address: u16, value: u8) void,

    // Hook handler
    hook: ?*const fn (*Z80, address: u16) u8,

    // Write to port (OUT)
    out: ?*const fn (*Z80, port: u8, value: u8) void,

    // Read from port (IN)
    in: ?*const fn (*Z80, port: u8) u8,

    // Initialize the CPU state
    pub fn init() Z80 {
        const memory: [65536]u8 = [_]u8{0} ** 65536;
        const af: u16 = 0;
        const bc: u16 = 0;
        const de: u16 = 0;
        const hl: u16 = 0;
        const af_: u16 = 0;
        const bc_: u16 = 0;
        const de_: u16 = 0;
        const hl_: u16 = 0;
        const pc: u16 = 0;
        const sp: u16 = 0xFFFF;
        const cycles: u64 = 0;

        return Z80{
            .af = af,
            .bc = bc,
            .de = de,
            .hl = hl,
            .af_ = af_,
            .bc_ = bc_,
            .de_ = de_,
            .hl_ = hl_,
            .pc = pc,
            .sp = sp,
            .ix = 0,
            .iy = 0,
            .i = 0,
            .r = 0,
            .im = 0,
            .iff1 = false,
            .iff2 = false,
            .memory = memory,
            .cycles = cycles,
            .halt = false,
            .pending_opcode = null,
            .write = null,
            .hook = null,
            .out = null,
            .in = null,
        };
    }

    pub fn reset(self: *Z80) void {
        self.af = 0xFFFF;
        self.bc = 0xFFFF;
        self.de = 0xFFFF;
        self.hl = 0xFFFF;
        self.af_ = 0xFFFF;
        self.bc_ = 0xFFFF;
        self.de_ = 0xFFFF;
        self.hl_ = 0xFFFF;
        self.pc = 0xFFFF;
        self.sp = 0xFFFF;
        self.ix = 0xFFFF;
        self.iy = 0xFFFF;
        self.i = 0;
        self.r = 0;
        self.im = 0;
        self.iff1 = false;
        self.iff2 = false;
        self.cycles = 0;
        self.halt = false;
        self.pending_opcode = null;
        // self.write = null;
        // self.hook = null;
        // self.out = null;
        self.clearMemory();
    }

    pub fn isHalted(self: *Z80) bool {
        return self.halt;
    }

    pub fn getA(self: *Z80) u8 {
        return @intCast(self.af >> 8);
    }

    pub fn getF(self: *Z80) u8 {
        return @intCast(self.af & 0xFF);
    }

    pub fn getB(self: *Z80) u8 {
        return @intCast(self.bc >> 8);
    }

    pub fn getC(self: *Z80) u8 {
        return @intCast(self.bc & 0xFF);
    }

    pub fn getD(self: *Z80) u8 {
        return @intCast(self.de >> 8);
    }

    pub fn getE(self: *Z80) u8 {
        return @intCast(self.de & 0xFF);
    }

    pub fn getH(self: *Z80) u8 {
        return @intCast(self.hl >> 8);
    }

    pub fn getL(self: *Z80) u8 {
        return @intCast(self.hl & 0xFF);
    }

    fn withLowByte(val: u16, low: u8) u16 {
        return (val & 0xFF00) | low;
    }

    fn withHighByte(val: u16, high: u8) u16 {
        return (val & 0x00FF) | (@as(u16, high) << 8);
    }

    pub fn setA(self: *Z80, v: u8) void {
        self.af = withHighByte(self.af, v);
    }

    pub fn setF(self: *Z80, v: u8) void {
        self.af = withLowByte(self.af, v);
    }

    pub fn setB(self: *Z80, v: u8) void {
        self.bc = withHighByte(self.bc, v);
    }

    pub fn setC(self: *Z80, v: u8) void {
        self.bc = withLowByte(self.bc, v);
    }

    pub fn setD(self: *Z80, v: u8) void {
        self.de = withHighByte(self.de, v);
    }

    pub fn setE(self: *Z80, v: u8) void {
        self.de = withLowByte(self.de, v);
    }

    pub fn setH(self: *Z80, v: u8) void {
        self.hl = withHighByte(self.hl, v);
    }

    pub fn setL(self: *Z80, v: u8) void {
        self.hl = withLowByte(self.hl, v);
    }

    pub fn setSP(self: *Z80, v: u16) void {
        // std.debug.print("[sp] = {X:0>4}\n", .{v});
        self.sp = v;
    }

    pub fn decSP(self: *Z80) void {
        self.setSP(self.sp -% 1);
    }

    pub fn incSP(self: *Z80) void {
        self.setSP(self.sp +% 1);
    }

    pub fn decE(self: *Z80) void {
        var e = self.getE();
        e -%= 1;
        self.setE(e);
    }

    fn getFlag(self: *Z80) Flag {
        return Flag.init(self.getF());
    }

    pub fn dec(self: *Z80, v: u8) u8 {
        const res = v -% 1;
        var flag = self.getFlag();
        flag.setFromIncDec(v, res);
        // set subtract to true
        flag.setSubtract(true);

        self.setF(flag.get());
        return res;
    }

    pub fn inc(self: *Z80, v: u8) u8 {
        const res = v +% 1;
        var flag = self.getFlag();
        flag.setFromIncDec(v, res);
        flag.setSubtract(false);
        flag.setHalfCarry((v & 0x0F) + 1 > 0x0F);
        flag.setParityOverflow(v == 0x7F);
        self.setF(flag.get());
        return res;
    }

    pub fn add(self: *Z80, v1: u8, v2: u8) void {
        const result: u16 = @as(u16, v1) + @as(u16, v2);
        const sum = @as(u8, @intCast(result & 0xFF));

        var flag = self.getFlag();
        flag.setFromU8(sum);
        flag.setSign(sum & 0x80 == 0x80);
        flag.setZero(sum == 0);
        flag.setHalfCarry((v1 & 0x0F) + (v2 & 0x0F) > 0x0F);
        const po = ((((v1 ^ result) & (v2 ^ result)) & 0x80) != 0);
        flag.setParityOverflow(po);
        // flag.setParityOverflow(sum == 0x7F);
        flag.setSubtract(false);
        flag.setCarry(result > 0xFF);
        self.setF(flag.get());

        self.setA(sum);
        self.cycles += 4;
    }

    // SI u8 add8(u8 a, u8 b, bv cy) {
    //   u8 res = a + b + cy;
    //   hf = carry(4, a, b, cy);
    //   pf = carry(7, a, b, cy) != carry(8, a, b, cy);
    //   cf = carry(8, a, b, cy);
    //   nf = 0;
    //   szf8(res);
    //   xyf1(res);
    //   R res;
    // }

    pub fn add8(self: *Z80, a: u8, b: u8, cy: bool) u8 {
        const cy_: u8 = if (cy) 1 else 0;
        const res = a +% b +% cy_;

        var flags = self.getFlag();
        flags.setFromU8(res);
        flags.setHalfCarry(utils.carry(4, a, b, cy));
        flags.setParityOverflow(utils.carry(7, a, b, cy) != utils.carry(8, a, b, cy));
        flags.setCarry(utils.carry(8, a, b, cy));
        flags.setSubtract(false);
        self.setF(flags.get());

        return res;
    }

    // SI u8 sub8(u8 a, u8 b, bv cy) {
    //   u8 v = add8(a, ~b, !cy);
    //   cf = !cf; hf = !hf;
    //   nf = 1;
    //   R v;
    // }

    pub fn sub8(self: *Z80, a: u8, b: u8, cy: bool) u8 {
        const v = self.add8(a, ~b, !cy);

        var flags = self.getFlag();
        flags.setCarry(!flags.isCarry());
        flags.setHalfCarry(!flags.isHalfCarry());
        flags.setSubtract(true);
        self.setF(flags.get());

        return v;
    }

    // SI u16 add16(u16 a, u16 b, bv cy) {
    //   u8 lo = add8(a, b, cy);
    //
    //   u16 res = (add8(HI(a), HI(b), cf) << 8) | lo;
    //   zf = res == 0; wz = a + 1; R res;
    // }

    pub fn add16n(self: *Z80, a: u16, b: u16, cy: bool) u16 {
        const lo: u8 = self.add8(@as(u8, @intCast(a & 0xFF)), @as(u8, @intCast(b & 0xFF)), cy);
        const res: u16 = @as(u16, @intCast(self.add8(@as(u8, @intCast(a >> 8)), @as(u8, @intCast(b >> 8)), self.isCarry()))) << 8 | lo;
        var flags = self.getFlag();
        flags.setZero(res == 0);
        // wz = a + 1
        return res;
    }

    // SI u16 sub16(u16 a, u16 b, bv cy) {
    //   u8 lo = sub8(a, b, cy);
    //
    //   u16 res = (sub8(HI(a), HI(b), cf) << 8) | lo;
    //   zf = res == 0; wz = a + 1; R res;
    // }

    pub fn sub16n(self: *Z80, a: u16, b: u16, cy: bool) u16 {
        const lo: u8 = self.sub8(@as(u8, @intCast(a & 0xFF)), @as(u8, @intCast(b & 0xFF)), cy);
        const res: u16 = @as(u16, @intCast(self.sub8(@as(u8, @intCast(a >> 8)), @as(u8, @intCast(b >> 8)), self.isCarry()))) << 8 | lo;
        var flags = self.getFlag();
        flags.setZero(res == 0);
        // wz = a + 1
        return res;
    }

    pub fn add16(self: *Z80, v1: u16, v2: u16) u16 {
        // 16 bit additions are done in two steps:
        // First the two lower bytes are added, the two higher bytes.
        //
        // Instruction           Flags     Notes
        // ===========           =====     =====
        // ADD s                 --***-0C  F5,H,F3 from higher bytes addition

        const result = @as(u32, @intCast(v1)) + @as(u32, @intCast(v2));
        const resultHi: u8 = @intCast((result >> 8) & 0xFF);

        var flag = self.getFlag();
        flag.setSubtract(false);
        flag.setXYFromU8(resultHi);
        flag.setCarry(result > 0xFFFF);
        flag.setHalfCarry((v1 & 0x0FFF) + (v2 & 0x0FFF) > 0x0FFF);
        self.setF(flag.get());

        self.cycles += 11;

        const res: u16 = @intCast(result & 0xFFFF);
        return res;
    }

    pub fn adc(self: *Z80, n: u8) void {
        const carry: u8 = if (self.isCarry()) 1 else 0;
        const result: u16 = @as(u16, self.getA()) + @as(u16, n) + @as(u16, carry);
        const sum: u8 = @as(u8, @intCast(result & 0xFF));

        // Symbol Field Name
        // C Carry Flag
        // N Add/Subtract
        // P/V Parity/Overflow Flag
        // H Half Carry Flag
        // Z Zero Flag
        // S Sign Flag
        // X Not Used

        // Condition Bits Affected
        // S is set if result is negative; otherwise, it is reset.
        // Z is set if result is 0; otherwise, it is reset.
        // H is set if carry from bit 3; otherwise, it is reset.
        // P/V is set if overflow; otherwise, it is reset.
        // N is reset.
        // C is set if carry from bit 7; otherwise, it is reset.

        var flag = self.getFlag();
        flag.reset();
        flag.setFromU8(sum);
        flag.setSign(sum & 0x80 == 0x80);
        flag.setZero(sum == 0);
        flag.setHalfCarry((self.getA() & 0x0F) + (n & 0x0F) + carry > 0x0F);
        const a = self.getA();
        const po = ((((a ^ result) & (n ^ result)) & 0x80) != 0);
        flag.setParityOverflow(po);
        flag.setSubtract(false);
        flag.setCarry(result > 0xFF);
        self.setF(flag.get());

        self.setA(@as(u8, @intCast(result & 0xFF)));
        self.cycles += 7;
    }

    // SI void adchl(u16 v) { u16 q = add16(get_hl(), v, cf); szf16(q); set_hl(q); }

    pub fn adc16n(self: *Z80, v: u16) void {
        const q: u16 = self.add16n(self.hl, v, self.isCarry());
        var flags = self.getFlag();
        flags.setZeroSign16(q);
        self.setF(flags.get());
        self.hl = q;
        self.cycles += 15;
    }

    pub fn adc16(self: *Z80, v: u16) void {
        const carry: u16 = if (self.isCarry()) 1 else 0;
        const result: u32 = @as(u32, @intCast(self.hl)) + @as(u32, @intCast(v)) + @as(u32, @intCast(carry));
        std.debug.print("result={X:0>8}\n", .{result});
        self.hl = @as(u16, @intCast(result & 0xFFFF));

        var flags = self.getFlag();
        flags.setXYFromU8(@as(u8, @intCast(result >> 8)));
        flags.setSign(result & 0x8000 == 0x8000);
        flags.setZero(result == 0);
        // H is set if carry from bit 11; otherwise, it is reset
        // flags.setHalfCarry((self.hl & 0x0FFF) + (v & 0x0FFF) + carry > 0x0FFF);
        flags.setHalfCarry((@as(u32, @intCast(self.hl)) & 0x0FFF) + (@as(u32, @intCast(v)) & 0x0FFF) + carry > 0x0FFF);
        flags.setParityOverflow(((self.hl ^ v ^ @as(u16, @intCast(result)) >> 8) & 0x80) != 0);
        flags.setSubtract(false);
        flags.setCarry(result > 0xFFFF);
        self.setF(flags.get());

        self.cycles += 15;
    }

    pub fn sbc16n(self: *Z80, v: u16) void {
        const q: u16 = self.sub16n(self.hl, v, self.isCarry());
        var flags = self.getFlag();
        flags.setZeroSign16(q);
        self.setF(flags.get());
        self.hl = q;
        self.cycles += 15;
    }

    pub fn sbc16(self: *Z80, v: u16) void {
        const carry: u16 = if (self.isCarry()) 1 else 0;
        const result: u32 = @as(u32, @intCast(self.hl)) - @as(u32, @intCast(v)) - @as(u32, @intCast(carry));
        std.debug.print("result={X:0>8}\n", .{result});

        var flags = self.getFlag();
        flags.setXYFromU8(@as(u8, @intCast(result >> 8)));
        flags.setSign(result & 0x8000 == 0x8000);
        flags.setZero(result == 0);
        // H is set if borrow from bit 12; otherwise, it is reset
        // flags.setHalfCarry((self.hl & 0x0FFF) < (result & 0x0FFF) + carry);
        flags.setHalfCarry((@as(u32, @intCast(self.hl)) & 0x0FFF) < (result & 0x0FFF) + carry);
        // P/V is set if overflow; otherwise, it is reset
        // #define PF_OVERFLOW(width, result, lhs, rhs) \
        //    width = 16
        //    result = t
        //    lhs = HL
        //    rhs = pfoverflow_rhs = | NF
        // pf_overflow_rhs = | NF
        // (((zuint##width)((lhs ^ rhs) & (lhs ^ result)) >> (width - 3)) & PF)
        // 		| PF_OVERFLOW(16, t, HL, pf_overflow_rhs)		    \

        flags.setParityOverflow((result ^ @as(u16, @intCast(self.hl)) ^ @as(u16, @intCast(result >> 8)) >> 8) & 0x80 != 0);
        flags.setSubtract(true);
        flags.setCarry(result > 0xFFFF);
        self.setF(flags.get());

        self.hl = @as(u16, @intCast(result & 0xFFFF));

        self.cycles += 15;
    }

    pub fn sbc8(self: *Z80, v: u8) void {
        self.setA(self.sub8(self.getA(), v, self.isCarry()));
        self.cycles += 4;
    }

    // H(0x9C, a = sub8(a, IHI, cf)) H(0x9D, a = sub8(a, ILO, cf))
    pub fn sbc(self: *Z80, v1: u8, v2: u8) void {
        const carry: u8 = if (self.isCarry()) 1 else 0;
        const result = v1 -% v2 -% carry;

        // Symbol Field Name
        // C Carry Flag
        // N Add/Subtract
        // P/V Parity/Overflow Flag
        // H Half Carry Flag
        // Z Zero Flag
        // S Sign Flag
        // X Not Used

        // Condition Bits Affected
        // S is set if result is negative; otherwise, it is reset.
        // Z is set if result is 0; otherwise, it is reset.
        // H is set if borrow from bit 4; otherwise, it is reset.
        // P/V is reset if overflow; otherwise, it is reset.
        // N is set.
        // C is set if borrow; otherwise, it is reset.

        var flag = self.getFlag();
        flag.reset();
        flag.setFromU8(result);
        flag.setSign(result & 0x80 == 0x80);
        flag.setZero(result == 0);
        flag.setHalfCarry((v1 & 0x0F) < (v2 & 0x0F) + carry);
        flag.setParityOverflow(@as(u16, @intCast(result ^ v1 ^ v2)) >> 8 & 0x80 != 0);
        flag.setSubtract(true);
        const carry_out = @as(u16, v1) < @as(u16, v2) + @as(u16, carry);
        flag.setCarry(carry_out);
        self.setF(flag.get());

        self.setA(@as(u8, @intCast(result & 0xFF)));
        self.cycles += 4;
    }

    pub fn sub(self: *Z80, v: u8) void {
        // const result = self.getA() -% v;
        const result = @as(u8, @intCast(self.getA() -% v));

        // Symbol Field Name
        // C Carry Flag
        // N Add/Subtract
        // P/V Parity/Overflow Flag
        // H Half Carry Flag
        // Z Zero Flag
        // S Sign Flag
        // X Not Used

        // Condition Bits Affected
        // S is set if result is negative; otherwise, it is reset.
        // Z is set if result is 0; otherwise, it is reset.
        // H is set if borrow from bit 4; otherwise, it is reset.
        // P/V is reset if overflow; otherwise, it is reset.
        // N is set.
        // C is set if borrow; otherwise, it is reset.

        var flag = self.getFlag();
        flag.reset();
        flag.setFromU8(result);
        flag.setSign(result & 0x80 == 0x80);
        flag.setZero(result == 0);
        // std.debug.print("pc = {X:0>4}\n", .{self.pc});
        flag.setHalfCarry((self.getA() & 0x0F) < (v & 0x0F));
        const a = self.getA();
        const po = ((((a ^ v) & (a ^ result)) & 0x80) != 0);
        flag.setParityOverflow(po);
        flag.setSubtract(true);
        flag.setCarry(self.getA() < v);
        self.setF(flag.get());

        self.setA(@as(u8, @intCast(result & 0xFF)));
        self.cycles += 4;
    }

    pub fn andOp(self: *Z80, v: u8) void {
        const result = self.getA() & v;
        self.setA(result);

        var flag = self.getFlag();
        flag.setFromU8(result);
        flag.setSign(result & 0x80 == 0x80);
        flag.setZero(result == 0);
        flag.setHalfCarry(true);
        flag.setSubtract(false);
        flag.setCarry(false);
        flag.setParityOverflow(utils.countSetBits(result) % 2 == 0);
        self.setF(flag.get());

        self.cycles += 7;
    }

    pub fn xorOp(self: *Z80, v: u8) void {
        const result = self.getA() ^ v;
        self.setA(result);

        var flag = self.getFlag();
        flag.setFromU8(result);
        flag.setSign(result & 0x80 == 0x80);
        flag.setZero(result == 0);
        flag.setHalfCarry(false);
        flag.setSubtract(false);
        flag.setCarry(false);
        flag.setParityOverflow(utils.countSetBits(result) % 2 == 0);
        self.setF(flag.get());

        self.cycles += 4;
    }

    pub fn orOp(self: *Z80, v: u8) void {
        // std.debug.print("val={d} a={d} result={d}\n", .{ v, self.getA(), self.getA() | v });

        const result = self.getA() | v;
        self.setA(@as(u8, @intCast(result & 0xFF)));

        // Symbol Field Name
        // C Carry Flag
        // N Add/Subtract
        // P/V Parity/Overflow Flag
        // H Half Carry Flag
        // Z Zero Flag
        // S Sign Flag
        // X Not Used

        // Condition Bits Affected
        // S is set if result is negative; otherwise, it is reset.
        // Z is set if result is 0; otherwise, it is reset.
        // H is reset.
        // P/V is set if overflow; otherwise, it is reset.
        // N is reset.
        // C is reset.

        var flag = self.getFlag();
        flag.setFromU8(result);
        flag.setSign(result & 0x80 == 0x80);
        flag.setZero(result == 0);
        flag.setHalfCarry(false);
        // std.debug.print("result: {d}\n", .{result});
        flag.setSubtract(false);
        flag.setCarry(false);
        flag.setParityOverflow(utils.countSetBits(result) % 2 == 0);
        self.setF(flag.get());

        self.cycles += 4;
    }

    pub fn cp(self: *Z80, v: u8) void {
        const result = self.getA() -% v;

        // Symbol Field Name
        // C Carry Flag
        // N Add/Subtract
        // P/V Parity/Overflow Flag
        // H Half Carry Flag
        // Z Zero Flag
        // S Sign Flag
        // X Not Used

        // Condition Bits Affected
        // S is set if result is negative; otherwise, it is reset.
        // Z is set if result is 0; otherwise, it is reset.
        // H is set if borrow from bit 4; otherwise, it is reset.
        // P/V is reset if overflow; otherwise, it is reset.
        // N is set.
        // C is set if borrow; otherwise, it is reset.

        var flag = self.getFlag();
        flag.reset();
        flag.setXYFromU8(v);
        flag.setSign(result & 0x80 == 0x80);
        flag.setZero(result == 0);
        flag.setHalfCarry((self.getA() & 0x0F) < (v & 0x0F));
        const a = self.getA();
        const po = ((((a ^ v) & (a ^ result)) & 0x80) != 0);
        flag.setParityOverflow(po);
        // flag.setParityOverflow(result == 0x7F);
        flag.setSubtract(true);
        flag.setCarry(self.getA() < v);
        self.setF(flag.get());

        self.cycles += 4;
    }

    pub fn rst(self: *Z80, address: u16) void {
        self.decSP();
        const byte1 = @as(u8, @intCast(self.pc >> 8));
        self.writeByte(self.sp, byte1);

        self.decSP();
        const byte2 = @as(u8, @intCast(self.pc & 0xFF));
        self.writeByte(self.sp, byte2);

        self.pc = address;
        self.cycles += 11;
    }

    fn incR(self: *Z80) void {
        self.r +%= 1;
        if (self.r >= 128) {
            self.r = 0;
        }
    }

    // pub fn handleIY(self: *Z80) void {}

    pub fn fetchOpcode(self: *Z80) u8 {
        self.incR();
        return self.fetchByte();
    }

    pub fn calcJump(self: *Z80, byte: u8) void {
        const offset: i8 = @bitCast(byte);
        if (offset > 0) {
            self.pc +%= @intCast(offset);
        } else {
            self.pc -%= @as(u16, @intCast(-@as(i16, @intCast(offset))));
        }
    }

    pub fn peekByte(self: *Z80) u8 {
        return self.memory[self.pc];
    }

    // Fetch the next byte from memory
    fn fetchByte(self: *Z80) u8 {
        const byte = self.memory[self.pc];
        self.pc +%= 1;
        return byte;
    }

    fn fetchByteAsI8(self: *Z80) i8 {
        return @bitCast(self.fetchByte());
    }

    // Fetch the next word (2 bytes) from memory
    fn fetchWord(self: *Z80) u16 {
        const lowByte: u8 = self.fetchByte();
        const highByte: u16 = self.fetchByte();
        return (highByte << 8) | lowByte;
    }

    pub fn writeByte(self: *Z80, address: u16, value: u8) void {
        if (self.write != null) {
            self.write.?(self, address, value);
            return;
        }
        self.memory[@as(usize, address)] = value;
    }

    pub fn writeToPort(self: *Z80, port: u8, value: u8) void {
        if (self.out != null) {
            self.out.?(self, port, value);
            return;
        }
        std.debug.print("OUT {X:0>2}, {X:0>2}\n", .{ port, value });
    }

    pub fn readFromPort(self: *Z80, port: u8) u8 {
        if (self.in != null) {
            return self.in.?(self, port);
        }
        std.debug.print("IN {X:0>2}\n", .{port});
        return 0;
    }

    pub fn start(self: *Z80) void {
        while (!self.halt) {
            self.execute();
        }
    }

    pub fn run(self: *Z80, cycles: u64) void {
        const initial_cycles = self.cycles;
        // std.debug.print("Running for {d} cycles\n", .{cycles});
        while (!self.halt and self.cycles < initial_cycles + cycles) {
            const cur_cycle = self.cycles;
            // std.debug.print("Running cycle {d}\n", .{self.cycles});
            const opcode = self.peekByte();
            self.execute();
            if (cur_cycle == self.cycles) {
                std.debug.panic("No cycles were consumed (opcode {X:0>2})\n", .{opcode});
            }
        }
    }

    pub fn isZero(self: *Z80) bool {
        var flag = self.getFlag();
        return flag.isZero();
    }

    pub fn isSign(self: *Z80) bool {
        var flag = self.getFlag();
        return flag.isSign();
    }

    pub fn isCarry(self: *Z80) bool {
        var flag = self.getFlag();
        return flag.isCarry();
    }

    // Execute a single instruction
    pub fn execute(self: *Z80) void {
        self.executeOpcode(self.fetchOpcode());
    }

    pub fn executeOpcode(self: *Z80, opcode: u8) void {
        switch (opcode) {
            0x00 => {
                // NOP
                self.cycles += 4;
            },
            0x01 => {
                // LD BC, nn
                self.bc = self.fetchWord();
                self.cycles += 10;
            },
            0x02 => {
                // LD (BC), A
                self.writeByte(self.bc, self.getA());
                self.cycles += 7;
            },
            0x03 => {
                // INC BC
                self.bc +%= 1;
                self.cycles += 6;
            },
            0x04 => {
                // INC B
                self.setB(self.inc(self.getB()));
                self.cycles += 4;
            },
            0x05 => {
                // DEC B
                self.setB(self.dec(self.getB()));
                self.cycles += 4;
            },
            0x06 => {
                // LD B, n
                self.setB(self.fetchByte());
                self.cycles += 7;
            },
            0x07 => {
                // RLCA
                const a = self.getA();
                const carry = a & 0x80 == 0x80;
                const result = (a << 1) | (a >> 7);
                self.setA(result);

                var flag = self.getFlag();
                flag.setXYFromU8(result);
                flag.setCarry(carry);
                flag.setHalfCarry(false);
                flag.setSubtract(false);
                self.setF(flag.get());

                self.cycles += 4;
            },
            0x08 => {
                // EX AF, AF'
                const tmp = self.af;
                self.af = self.af_;
                self.af_ = tmp;
                self.cycles += 4;
            },
            0x09 => {
                // ADD HL, BC
                self.hl = self.add16(self.hl, self.bc);
                self.cycles += 11;
            },
            0x0A => {
                // LD A, (BC)
                self.setA(self.memory[self.bc]);
                self.cycles += 7;
            },
            0x0B => {
                // DEC BC
                self.bc -%= 1;
                self.cycles += 6;
            },
            0x0C => {
                // INC C
                self.setC(self.inc(self.getC()));
                self.cycles += 4;
            },
            0x0D => {
                // DEC C
                self.setC(self.dec(self.getC()));
                self.cycles += 4;
            },
            0x0E => {
                // LD C, n
                self.setC(self.fetchByte());
                self.cycles += 7;
            },
            0x0F => {
                // RRCA
                const a = self.getA();
                const carry = a & 0x01 == 0x01;
                const result = (a >> 1) | (a << 7);
                self.setA(result);

                var flag = self.getFlag();
                flag.setXYFromU8(result);
                flag.setCarry(carry);
                flag.setHalfCarry(false);
                flag.setSubtract(false);
                self.setF(flag.get());

                self.cycles += 4;
            },
            0x11 => {
                // LD DE, nn
                self.de = self.fetchWord();
                self.cycles += 10;
            },
            0x12 => {
                // LD (DE), A
                self.writeByte(self.de, self.getA());
                self.cycles += 7;
            },
            0x13 => {
                // INC DE
                self.de +%= 1;
                self.cycles += 6;
            },
            0x14 => {
                // INC D
                self.setD(self.inc(self.getD()));
                self.cycles += 4;
            },
            0x16 => {
                // LD D, n
                self.setD(self.fetchByte());
                self.cycles += 7;
            },
            0x17 => {
                // RLA
                // H(0x17, t2=cf;cf=a>>7;a=(a<<1)|t2;nf=hf=0;xyf1(a))
                var carry: u8 = undefined;
                if (self.isCarry()) {
                    carry = 1;
                } else {
                    carry = 0;
                }
                const a = self.getA();
                const result = (a << 1) | carry;
                self.setA(result);

                var flag = self.getFlag();
                flag.setXYFromU8(result);
                flag.setCarry(a & 0x80 == 0x80);
                flag.setHalfCarry(false);
                self.setF(flag.get());

                self.cycles += 4;
            },
            0x18 => {
                // JR n
                self.calcJump(self.fetchByte());
                self.cycles += 12;
            },
            0x19 => {
                // ADD HL, DE
                self.hl = self.add16(self.hl, self.de);
            },
            0x1A => {
                // LD A, (DE)
                self.setA(self.memory[self.de]);
                self.cycles += 7;
            },
            0x1B => {
                // DEC DE
                self.de -%= 1;
                self.cycles += 6;
            },
            0x1C => {
                // INC E
                self.setE(self.inc(self.getE()));
                self.cycles += 4;
            },
            0x1D => {
                // DEC E
                self.setE(self.dec(self.getE()));
                self.cycles += 4;
            },
            0x1F => {
                // RRA
                var carry: u8 = undefined;
                if (self.isCarry()) {
                    carry = 0x80;
                } else {
                    carry = 0;
                }
                const a = self.getA();
                const result = (a >> 1) | carry;
                self.setA(result);

                var flag = self.getFlag();
                flag.setXYFromU8(result);
                flag.setCarry(a & 0x01 == 0x01);
                flag.setHalfCarry(false);
                flag.setSubtract(false);
                self.setF(flag.get());

                self.cycles += 4;
            },
            0x20 => {
                // JR NZ, n
                const offset = self.fetchByte();

                if (self.isZero()) {
                    self.cycles += 7;
                } else {
                    self.pc += offset;
                    self.cycles += 12;
                }
            },
            0x21 => {
                // LD HL, nn
                self.hl = self.fetchWord();
                self.cycles += 10;
            },
            0x22 => {
                // LD (nn), HL
                const nn = self.fetchWord();
                self.writeByte(nn, self.getL());
                self.writeByte(nn + 1, self.getH());
                self.cycles += 16;
            },
            0x23 => {
                // INC HL
                self.hl +%= 1;
                self.cycles += 6;
            },
            0x24 => {
                // INC H
                self.setH(self.inc(self.getH()));
                self.cycles += 4;
            },
            0x25 => {
                // DEC H
                self.setH(self.dec(self.getH()));
                self.cycles += 4;
            },
            0x26 => {
                // LD H, n
                self.setH(self.fetchByte());
                self.cycles += 7;
            },
            0x27 => {
                // DAA
                // Adapted from: https://stackoverflow.com/a/57837042/14540
                var t: u8 = 0;
                var flags = self.getFlag();
                if (flags.isHalfCarry() or (self.getA() & 0x0F) > 9) {
                    t += 1;
                }
                if (flags.isCarry() or self.getA() > 0x99) {
                    t += 2;
                    flags.setCarry(true);
                }
                if (flags.isSubtract() and !flags.isHalfCarry()) {
                    flags.setHalfCarry(false);
                } else {
                    if (flags.isSubtract() and flags.isHalfCarry()) {
                        flags.setHalfCarry((self.getA() & 0x0F) < 6);
                    } else {
                        flags.setHalfCarry((self.getA() & 0x0F) >= 0x0A);
                    }
                }
                switch (t) {
                    1 => {
                        if (flags.isSubtract()) {
                            self.setA(self.getA() +% 0xFA);
                        } else {
                            self.setA(self.getA() +% 0x06);
                        }
                    },
                    2 => {
                        if (flags.isSubtract()) {
                            self.setA(self.getA() +% 0xA0);
                        } else {
                            self.setA(self.getA() +% 0x60);
                        }
                    },
                    3 => {
                        if (flags.isSubtract()) {
                            self.setA(self.getA() +% 0x9A);
                        } else {
                            self.setA(self.getA() +% 0x66);
                        }
                    },
                    else => {},
                }

                flags.setSign(self.getA() & 0x80 == 0x80);
                flags.setZero(self.getA() == 0);
                flags.setParityOverflow(utils.countSetBits(self.getA()) % 2 == 0);
                flags.setXYFromU8(self.getA());
                self.setF(flags.get());
                self.cycles += 4;
            },
            0x28 => {
                // JR Z, n
                const offset = self.fetchByte();
                if (self.isZero()) {
                    self.calcJump(offset);
                    self.cycles += 12;
                } else {
                    self.cycles += 7;
                }
            },
            0x29 => {
                // ADD HL, HL
                self.hl = self.add16(self.hl, self.hl);
            },
            0x2A => {
                // LD HL, (nn)
                const addr = self.fetchWord();
                const lo = self.memory[addr];
                const hi = self.memory[addr + 1];
                self.hl = @as(u16, @intCast(hi)) << 8 | lo;
                self.cycles += 14;
            },
            0x2B => {
                // DEC HL
                self.hl -%= 1;
                self.cycles += 6;
            },
            0x2C => {
                // INC L
                self.setL(self.inc(self.getL()));
                self.cycles += 4;
            },
            0x2D => {
                // DEC L
                self.setL(self.dec(self.getL()));
                self.cycles += 4;
            },
            0x2E => {
                // LD L, n
                self.setL(self.fetchByte());
                self.cycles += 7;
            },
            0x2F => {
                // CPL
                self.setA(~self.getA());

                //                       SZ5H3VNC
                // CPL                   --*1*-1-	F5, F3 from A register
                var flags = self.getFlag();
                flags.setHalfCarry(true);
                flags.setSubtract(true);
                flags.setXYFromU8(self.getA());
                self.setF(flags.get());

                self.cycles += 4;
            },
            0x30 => {
                // JR NC, n
                const offset = self.fetchByte();

                if (self.isCarry()) {
                    self.cycles += 7;
                } else {
                    self.pc += offset;
                    self.cycles += 12;
                }
            },
            0x31 => {
                // LD SP, nn
                self.sp = self.fetchWord();
                self.cycles += 10;
            },
            0x32 => {
                // LD (NN), A
                self.writeByte(self.fetchWord(), self.getA());
                self.cycles += 13;
            },
            0x33 => {
                // INC SP
                self.sp +%= 1;
                self.cycles += 6;
            },
            0x34 => {
                // INC (HL)
                self.writeByte(self.hl, self.inc(self.memory[self.hl]));
                self.cycles += 10;
            },
            0x35 => {
                // DEC (HL)
                self.writeByte(self.hl, self.dec(self.memory[self.hl]));
                self.cycles += 10;
            },
            0x36 => {
                // LD (HL), n
                self.writeByte(self.hl, self.fetchByte());
                self.cycles += 10;
            },
            0x37 => {
                // SCF
                var flag = self.getFlag();
                flag.setCarry(true);
                flag.setSubtract(false);
                flag.setHalfCarry(false);
                self.setF(flag.get());
                self.cycles += 4;
            },
            0x38 => {
                // JR C, n
                const offset = self.fetchByte();

                if (self.isCarry()) {
                    self.pc += offset;
                    self.cycles += 12;
                } else {
                    self.cycles += 7;
                }
            },
            0x39 => {
                // ADD HL, SP
                self.hl = self.add16(self.hl, self.sp);
            },
            0x3A => {
                // LD A, (nn)
                const nn = self.fetchWord();
                self.setA(self.memory[nn]);
                self.cycles += 13;
            },
            0x3B => {
                // DEC SP
                self.decSP();
                self.cycles += 6;
            },
            0x3C => {
                // INC A
                self.setA(self.inc(self.getA()));
                self.cycles += 4;
            },
            0x3D => {
                // DEC A
                self.setA(self.dec(self.getA()));
                self.cycles += 4;
            },
            0x3E => {
                // LD A, n
                self.setA(self.fetchByte());
                self.cycles += 7;
            },
            0x3F => {
                // CCF
                const carry = self.isCarry();
                var flag = self.getFlag();
                flag.setXYFromU8(self.getA());
                flag.setCarry(!flag.isCarry());
                flag.setHalfCarry(carry);
                flag.setSubtract(false);
                self.setF(flag.get());
                self.cycles += 4;
            },
            0x42 => {
                // LD B, D
                self.setB(self.getD());
                self.cycles += 4;
            },
            0x43 => {
                // LD B, E
                self.setB(self.getE());
                self.cycles += 4;
            },
            0x44 => {
                // LD B, H
                self.setB(self.getH());
                self.cycles += 4;
            },
            0x46 => {
                // LD B, (HL)
                self.setB(self.memory[self.hl]);
                self.cycles += 7;
            },
            0x47 => {
                // LD B, A
                self.setB(self.getA());
                self.cycles += 4;
            },
            0x48 => {
                // LD C, B
                self.setC(self.getB());
                self.cycles += 4;
            },
            0x49 => {
                // LD C, C
                self.setC(self.getC());
                self.cycles += 4;
            },
            0x4A => {
                // LD C, D
                self.setC(self.getD());
                self.cycles += 4;
            },
            0x4E => {
                // LD C, (HL)
                self.setC(self.memory[self.hl]);
                self.cycles += 7;
            },
            0x4F => {
                // LD C, A
                self.setC(self.getA());
                self.cycles += 4;
            },
            0x50 => {
                // LD D, B
                self.setD(self.getB());
                self.cycles += 4;
            },
            0x51 => {
                // LD D, C
                self.setD(self.getC());
                self.cycles += 4;
            },
            0x52 => {
                // LD D, D
                self.setD(self.getD());
                self.cycles += 4;
            },
            0x53 => {
                // LD D, E
                self.setD(self.getE());
                self.cycles += 4;
            },
            0x54 => {
                // LD D, H
                self.setD(self.getH());
                self.cycles += 4;
            },
            0x58 => {
                // LD E, B
                self.setE(self.getB());
                self.cycles += 4;
            },
            0x5B => {
                // LD E, E
                self.setE(self.getE());
                self.cycles += 4;
            },
            0x5D => {
                // LD E, L
                self.setE(self.getL());
                self.cycles += 4;
            },
            0x5E => {
                // LD E, (HL)
                self.setE(self.memory[self.hl]);
                self.cycles += 7;
            },
            0x60 => {
                // LD H, B
                self.setH(self.getB());
                self.cycles += 4;
            },
            0x61 => {
                // LD H, C
                self.setH(self.getC());
                self.cycles += 4;
            },
            0x62 => {
                // LD H, D
                self.setH(self.getD());
                self.cycles += 4;
            },
            0x63 => {
                // LD H, E
                self.setH(self.getE());
                self.cycles += 4;
            },
            0x64 => {
                // LD H, H
                if (self.hook != null) {
                    self.executeOpcode(self.hook.?(self, self.pc - 1));
                } else {
                    self.setH(self.getH());
                    self.cycles += 4;
                }
            },
            0x65 => {
                // LD H, L
                self.setH(self.getL());
                self.cycles += 4;
            },
            0x66 => {
                // LD H, (HL)
                self.setH(self.memory[self.hl]);
                self.cycles += 7;
            },
            0x67 => {
                // LD H, A
                self.setH(self.getA());
                self.cycles += 4;
            },
            0x68 => {
                // LD L, B
                self.setL(self.getB());
                self.cycles += 4;
            },
            0x69 => {
                // LD L, C
                self.setL(self.getC());
                self.cycles += 4;
            },
            0x6B => {
                // LD L, E
                self.setL(self.getE());
                self.cycles += 4;
            },
            0x6C => {
                // LD L, H
                self.setL(self.getH());
                self.cycles += 4;
            },
            0x6D => {
                // LD L, L
                self.setL(self.getL());
                self.cycles += 4;
            },
            0x6F => {
                // LD L, A
                self.setL(self.getA());
                self.cycles += 4;
            },
            0x70 => {
                // LD (HL), B
                self.writeByte(self.hl, self.getB());
                self.cycles += 7;
            },
            0x71 => {
                // LD (HL), C
                self.writeByte(self.hl, self.getC());
                self.cycles += 7;
            },
            0x72 => {
                // LD (HL), D
                self.writeByte(self.hl, self.getD());
                self.cycles += 7;
            },
            0x73 => {
                // LD (HL), E
                self.writeByte(self.hl, self.getE());
                self.cycles += 7;
            },
            0x74 => {
                // LD (HL), H
                self.writeByte(self.hl, self.getH());
                self.cycles += 7;
            },
            0x75 => {
                // LD (HL), L
                self.writeByte(self.hl, self.getL());
                self.cycles += 7;
            },
            0x76 => {
                // HALT
                std.debug.print("HALT\n", .{});
                self.cycles += 4;
                self.halt = true;
                return;
            },
            0x77 => {
                // LD (HL), A
                self.writeByte(self.hl, self.getA());
                self.cycles += 7;
            },
            0x78 => {
                // LD A, B
                self.setA(self.getB());
                self.cycles += 4;
            },
            0x79 => {
                // LD A, C
                self.setA(self.getC());
                self.cycles += 4;
            },
            0x7A => {
                // LD A, D
                self.setA(self.getD());
                self.cycles += 4;
            },
            0x7B => {
                // LD A, E
                self.setA(self.getE());
                self.cycles += 4;
            },
            0x7E => {
                // LD A, (HL)
                self.setA(self.memory[self.hl]);
                self.cycles += 7;
            },
            0x7F => {
                // LD A, A
                self.setA(self.getA());
                self.cycles += 4;
            },
            0x80 => {
                // ADD A, B
                self.add(self.getA(), self.getB());
            },
            0x81 => {
                // ADD A, C
                self.add(self.getA(), self.getC());
            },
            0x82 => {
                // ADD A, D
                self.add(self.getA(), self.getD());
            },
            0x83 => {
                // ADD A, E
                self.add(self.getA(), self.getE());
            },
            0x86 => {
                // ADD A, (HL)
                self.add(self.getA(), self.memory[self.hl]);
            },
            0x87 => {
                // ADD A, A
                self.add(self.getA(), self.getA());
            },
            0x88 => {
                // ADC A, B
                self.adc(self.getB());
            },
            0x89 => {
                // ADC A, C
                self.adc(self.getC());
            },
            0x8A => {
                // ADC A, D
                self.adc(self.getD());
            },
            0x8C => {
                // ADC A, H
                self.adc(self.getH());
            },
            0x8F => {
                // ADC A, A
                self.adc(self.getA());
            },
            0x91 => {
                // SUB C
                self.sub(self.getC());
            },
            0x95 => {
                // SUB L
                self.sub(self.getL());
            },
            0x97 => {
                // SUB A
                self.sub(self.getA());
            },
            0x9A => {
                // SBC A, D
                self.sbc(self.getA(), self.getD());
            },
            0x9C => {
                // SBC A, H
                self.sbc8(self.getH());
            },
            0x9D => {
                // SBC A, L
                self.sbc8(self.getL());
            },
            0xA0 => {
                // AND B
                self.andOp(self.getB());
            },
            0xA1 => {
                // AND C
                self.andOp(self.getC());
            },
            0xA2 => {
                // AND D
                self.andOp(self.getD());
            },
            0xA3 => {
                // AND E
                self.andOp(self.getE());
            },
            0xA4 => {
                // AND H
                self.andOp(self.getH());
            },
            0xA5 => {
                // AND L
                self.andOp(self.getL());
            },
            0xA7 => {
                // AND A
                self.andOp(self.getA());
            },
            0xA8 => {
                // XOR B
                self.xorOp(self.getB());
            },
            0xA9 => {
                // XOR C
                self.xorOp(self.getC());
            },
            0xAC => {
                // XOR H
                self.xorOp(self.getH());
            },
            0xAD => {
                // XOR L
                self.xorOp(self.getL());
            },
            0xAE => {
                // XOR (HL)
                self.xorOp(self.memory[self.hl]);
            },
            0xAF => {
                // XOR A
                self.xorOp(self.getA());
            },
            0xB0 => {
                // OR B
                self.orOp(self.getB());
            },
            0xB1 => {
                // OR C
                self.orOp(self.getC());
            },
            0xB6 => {
                // OR (HL)
                self.orOp(self.memory[self.hl]);
            },
            0xB7 => {
                // OR A
                self.orOp(self.getA());
            },
            0xB8 => {
                // CP B
                self.cp(self.getB());
            },
            0xB9 => {
                // CP C
                self.cp(self.getC());
            },
            0xBC => {
                // CP H
                self.cp(self.getH());
            },
            0xBD => {
                // CP L
                self.cp(self.getL());
            },
            0xBE => {
                // CP (HL)
                self.cp(self.memory[self.hl]);
            },
            0xBF => {
                // CP A
                self.cp(self.getA());
            },
            0xC0 => {
                // RET NZ
                if (!self.isZero()) {
                    const lo: u16 = @intCast(self.memory[self.sp]);
                    const hi: u16 = @intCast(self.memory[self.sp + 1]);
                    self.incSP();
                    self.incSP();
                    self.pc = hi << 8 | lo;
                    self.cycles += 11;
                } else {
                    self.cycles += 5;
                }
            },
            0xC1 => {
                // POP BC
                self.setC(self.memory[self.sp]);
                self.incSP();
                self.setB(self.memory[self.sp]);
                self.incSP();
                self.cycles += 10;
            },
            0xC2 => {
                // JP NZ, nn
                const addr = self.fetchWord();
                if (!self.isZero()) {
                    self.pc = addr;
                    self.cycles += 10;
                } else {
                    self.cycles += 10;
                }
            },
            0xC3 => {
                // JP nn
                self.pc = self.fetchWord();
                self.cycles += 10;
            },
            0xC4 => {
                // CALL NZ, nn
                const addr = self.fetchWord();
                if (!self.isZero()) {
                    self.decSP();
                    self.writeByte(self.sp, @as(u8, @intCast(self.pc >> 8)));
                    self.decSP();
                    self.writeByte(self.sp, @as(u8, @intCast(self.pc & 0xFF)));
                    self.pc = addr;
                    self.cycles += 17;
                } else {
                    self.cycles += 10;
                }
            },
            0xC5 => {
                // PUSH BC
                self.decSP();
                self.writeByte(self.sp, self.getB());
                self.decSP();
                self.writeByte(self.sp, self.getC());
                self.cycles += 11;
            },
            0xC8 => {
                // RET Z
                if (self.isZero()) {
                    const lo: u16 = @intCast(self.memory[self.sp]);
                    const hi: u16 = @intCast(self.memory[self.sp + 1]);
                    self.incSP();
                    self.incSP();
                    self.pc = hi << 8 | lo;
                    self.cycles += 11;
                } else {
                    self.cycles += 5;
                }
            },
            0xC9 => {
                // RET
                const lo: u16 = @intCast(self.memory[self.sp]);
                const hi: u16 = @intCast(self.memory[self.sp +% 1]);
                self.incSP();
                self.incSP();
                self.pc = hi << 8 | lo;
                self.cycles += 10;
            },
            0xCA => {
                // JP Z, nn
                const addr = self.fetchWord();
                if (self.isZero()) {
                    self.pc = addr;
                }
                self.cycles += 10;
            },
            0xCD => {
                // CALL nn
                // The current PC value plus three is pushed onto the stack, then is loaded with nn.

                // const pc = self.pc;
                const nn = self.fetchWord();
                self.decSP();
                self.writeByte(self.sp, @as(u8, @intCast(self.pc >> 8)));
                self.decSP();
                self.writeByte(self.sp, @as(u8, @intCast(self.pc & 0xFF)));
                self.pc = nn;
                self.cycles += 17;
            },
            0xCE => {
                // ADC A, n
                const n = self.fetchByte();
                self.adc(n);
            },
            0xD0 => {
                // RET NC
                if (!self.isCarry()) {
                    const lo: u16 = @intCast(self.memory[self.sp]);
                    const hi: u16 = @intCast(self.memory[self.sp + 1]);
                    self.incSP();
                    self.incSP();
                    self.pc = hi << 8 | lo;
                    self.cycles += 11;
                } else {
                    self.cycles += 5;
                }
            },
            0xD1 => {
                // POP DE
                self.setE(self.memory[self.sp]);
                self.incSP();
                self.setD(self.memory[self.sp]);
                self.incSP();
                self.cycles += 10;
            },
            0xD2 => {
                // JP NC, nn
                const addr = self.fetchWord();
                if (!self.isCarry()) {
                    self.pc = addr;
                }
                self.cycles += 10;
            },
            0xD3 => {
                // OUT (n), A
                const port = self.fetchByte();
                self.writeToPort(port, self.getA());
                self.cycles += 11;
            },
            0xD5 => {
                // PUSH DE
                self.decSP();
                self.writeByte(self.sp, self.getD());
                self.decSP();
                self.writeByte(self.sp, self.getE());
                self.cycles += 11;
            },
            0xD6 => {
                // SUB n
                const n = self.fetchByte();
                self.sub(n);
            },
            0xD7 => {
                // RST 10H
                self.rst(0x10);
            },
            0xD8 => {
                // RET C
                if (self.isCarry()) {
                    const lo: u16 = @intCast(self.memory[self.sp]);
                    const hi: u16 = @intCast(self.memory[self.sp + 1]);
                    self.incSP();
                    self.incSP();
                    self.pc = hi << 8 | lo;
                    self.cycles += 11;
                } else {
                    self.cycles += 5;
                }
            },
            0xD9 => {
                // EXX
                // Exchange BC, DE, HL with BC', DE', HL'
                std.mem.swap(u16, &self.bc, &self.bc_);
                std.mem.swap(u16, &self.de, &self.de_);
                std.mem.swap(u16, &self.hl, &self.hl_);
                self.cycles += 4;
            },
            0xDA => {
                // JP C, nn
                const addr = self.fetchWord();
                if (self.isCarry()) {
                    self.pc = addr;
                }
                self.cycles += 10;
            },
            0xDC => {
                // CALL C, nn
                const addr = self.fetchWord();
                if (self.isCarry()) {
                    self.decSP();
                    self.writeByte(self.sp, @as(u8, @intCast(self.pc >> 8)));
                    self.decSP();
                    self.writeByte(self.sp, @as(u8, @intCast(self.pc & 0xFF)));
                    self.pc = addr;
                    self.cycles += 17;
                } else {
                    self.cycles += 10;
                }
            },
            0xDD => {
                // IY Extended Instructions
                const next_byte = self.peekByte();
                // std.debug.print("0xDD next_byte = {X:0>2}\n", .{next_byte});
                const ix_instruction = IX_TABLE[next_byte];
                if (ix_instruction == null) {
                    self.cycles += 4;
                    self.execute();
                } else {
                    _ = self.fetchOpcode();
                    _ = ix_instruction.?(self);
                    // std.debug.print("IX instruction: {any} {any}\n", .{ res, ix_instruction });
                }
            },
            0xE1 => {
                // POP HL
                self.setL(self.memory[self.sp]);
                self.incSP();
                self.setH(self.memory[self.sp]);
                self.incSP();
                self.cycles += 10;
            },
            0xE7 => {
                // RST 20H
                self.rst(0x20);
            },
            0xEB => {
                // EX DE, HL
                std.mem.swap(u16, &self.de, &self.hl);
                self.cycles += 4;
            },
            0xED => {
                // Extended instructions
                const ext_opcode = self.fetchOpcode();
                // std.debug.print("0xED extended opcode = {X:0>2}\n", .{ext_opcode});
                switch (ext_opcode) {
                    0x42 => {
                        // SBC HL, BC
                        self.sbc16n(self.bc);
                    },
                    0x4A => {
                        // ADC HL, BC
                        self.adc16n(self.bc);
                    },
                    0x52 => {
                        // SBC HL, DE
                        self.sbc16n(self.de);
                    },
                    0x5A => {
                        // ADC HL, DE
                        self.adc16n(self.de);
                    },
                    0x62 => {
                        // SBC HL, HL
                        self.sbc16n(self.hl);
                    },
                    0x6A => {
                        // ADC HL, HL
                        self.adc16n(self.hl);
                    },
                    0x72 => {
                        // SBC HL, SP
                        self.sbc16n(self.sp);
                    },
                    0x7A => {
                        // ADC HL, SP
                        self.adc16n(self.sp);
                    },
                    // MOS extensions - https://mdfs.net/Docs/Comp/Z80/UnDocOps
                    0x73 => {
                        // LD (nn), SP
                        const nn = self.fetchWord();
                        self.writeByte(nn, @as(u8, @intCast(self.sp & 0xFF)));
                        self.writeByte(nn + 1, @as(u8, @intCast(self.sp >> 8)));
                        self.cycles += 20;
                    },
                    0x7B => {
                        // LD SP, (nn)
                        const nn = self.fetchWord();
                        const lo = self.memory[nn];
                        const hi = self.memory[nn + 1];
                        self.sp = (@as(u16, @intCast(hi)) << 8) | lo;
                        self.cycles += 20;
                    },
                    0xB0 => {
                        // LDIR
                        // This 2-byte instruction transfers a byte of data from
                        // the memory location addressed by the contents of the
                        // HL register pair to the memory location addressed by
                        // the DE register pair. Both these register pairs are
                        // incremented and the Byte Counter (BC) Register pair
                        // is decremented. If decrementing allows the BC to go
                        // to 0, the instruction is terminated. If BC is not 0,
                        // the program counter is decremented by two and the
                        // instruction is repeated. Interrupts are recognized
                        // and two refresh cycles are executed after each data
                        // transfer. When the BC is set to 0 prior to instru-
                        // ction execution, the instruction loops through 64 KB.

                        var t = self.memory[self.hl];
                        self.hl +%= 1;
                        self.writeByte(self.de, t);
                        self.de +%= 1;
                        t +%= self.getA();

                        self.bc -%= 1;
                        var flags = self.getFlag();
                        if (self.bc != 0) {
                            flags.setXYFromU8(@as(u8, @intCast(self.pc >> 8)));
                            flags.setParityOverflow(true);
                            self.pc -%= 2;
                            self.cycles += 21;
                        } else {
                            flags.setF5(t & 0x02 == 0x02);
                            flags.setF3(t & 0x08 == 0x08);
                            flags.setHalfCarry(false);
                            flags.setParityOverflow(false);
                            flags.setSubtract(false);
                            self.cycles += 16;
                        }

                        self.setF(flags.get());
                    },
                    0xFB => {
                        // EI
                        self.iff1 = true;
                        self.iff2 = true;
                        self.cycles += 4;
                    },
                    0xFF => {
                        self.halt = true;
                    },
                    else => |code| {
                        std.debug.panic("Unknown extended opcode: {0X:0>2}\n", .{code});
                    },
                }
                // switch (ext_opcode) {
                //     0x44 => {
                //         // NEG
                //         const result = 0 - self.getA();
                //         self.setA(@as(u8, @intCast(result & 0xFF)));
                //         self.cycles += 8;
                //     },
                //     0x57 => {
                //         // LD A, I
                //         self.setA(self.getA());
                //         self.cycles += 9;
                //     },
                //     0x5F => {
                //         // LD A, R
                //         self.setA(self.getA());
                //         self.cycles += 9;
                //     },
                //     0x60 => {
                //         // IN H, (C)
                //         self.setH(self.getH());
                //         self.cycles += 8;
                //     },
                //     0x61 => {
                //         // OUT (C), H
                //         self.cycles += 8;
                //     },
                //     0x62 => {
                //         // SBC HL, BC
                //         const carry = if (self.isCarry()) 1 else 0;
                //         const result = self.hl - self.bc - carry;
                //         self.hl = @as(u16, @intCast(result & 0xFFFF));
                //         self.cycles += 15;
                //     },
                //     0x63 => {
                //         // LD (nn), BC
                //         self.memory[self.fetchWord()] = self.getB();
                //         self.memory[self.fetchWord()] = self.getC();
                //         self.cycles += 20;
                //     },
                //     0x64 => {
                //         // NEG
                //         const result = 0 - self.getH();
                //         self.setH(@as(u8, @intCast(result & 0xFF)));
                //         self.cycles += 8;
                //     },
                //     0x65 => {
                //         // RET
                //         self.pc = self.memory[self.sp];
                //         self.sp +%= 1;
                //         self.pc +%= 1;
                //         self.cycles += 10;
                //     },
                //     0x66 => {
                //         // IM 0
                //         self.cycles += 8;
                //     },
                //     0x67 => {
                //         // RRD
                //         self.cycles += 18;
                //     },
                //     0x68 => {
                //         // IN L, (C)
                //         self.setL(self.getL());
                //         self.cycles += 8;
                //     }
                // }
            },
            0xE5 => {
                // PUSH HL
                self.decSP();
                self.writeByte(self.sp, self.getH());
                self.decSP();
                self.writeByte(self.sp, self.getL());
                self.cycles += 11;
            },
            0xE6 => {
                // AND n
                self.andOp(self.fetchByte());
            },
            0xF0 => {
                // RET P
                if (!self.isSign()) {
                    const lo: u16 = @intCast(self.memory[self.sp]);
                    const hi: u16 = @intCast(self.memory[self.sp + 1]);
                    self.incSP();
                    self.incSP();
                    self.pc = hi << 8 | lo;
                    self.cycles += 11;
                } else {
                    self.cycles += 5;
                }
            },
            0xF1 => {
                // POP AF
                self.setF(self.memory[self.sp]);
                self.incSP();
                self.setA(self.memory[self.sp]);
                self.incSP();
                self.cycles += 10;
            },
            0xF3 => {
                // DI
                self.iff1 = false;
                self.iff2 = false;
                self.cycles += 4;
            },
            0xF4 => {
                // CALL P, nn
                // If the sign flag is unset, the current PC value plus three
                // is pushed onto the stack, then is loaded with nn.
                const addr = self.fetchWord();
                if (!self.isSign()) {
                    self.decSP();
                    self.writeByte(self.sp, @as(u8, @intCast(self.pc >> 8)));
                    self.decSP();
                    self.writeByte(self.sp, @as(u8, @intCast(self.pc & 0xFF)));
                    self.pc = addr;
                    self.cycles += 17;
                } else {
                    self.cycles += 10;
                }
            },
            0xF5 => {
                // PUSH AF
                self.decSP();
                self.writeByte(self.sp, self.getA());
                self.decSP();
                self.writeByte(self.sp, self.getF());
                self.cycles += 11;
            },
            0xF8 => {
                // RET M
                if (self.isSign()) {
                    const lo: u16 = @intCast(self.memory[self.sp]);
                    const hi: u16 = @intCast(self.memory[self.sp + 1]);
                    self.incSP();
                    self.incSP();
                    self.pc = hi << 8 | lo;
                    self.cycles += 11;
                } else {
                    self.cycles += 5;
                }
            },
            0xF9 => {
                // LD SP, HL
                self.setSP(self.hl);
                self.cycles += 6;
            },
            0xFB => {
                // EI
                self.cycles += 4;
            },
            0xFC => {
                // CALL M, nn
                // If the sign flag is set, the current PC value plus three
                // is pushed onto the stack, then is loaded with nn.
                const addr = self.fetchWord();
                if (self.isSign()) {
                    self.decSP();
                    self.writeByte(self.sp, @as(u8, @intCast(self.pc >> 8)));
                    self.decSP();
                    self.writeByte(self.sp, @as(u8, @intCast(self.pc & 0xFF)));
                    self.pc = addr;
                    self.cycles += 17;
                } else {
                    self.cycles += 10;
                }
            },
            0xFD => {
                // IY Extended Instructions
                const iy_instruction = IY_TABLE[self.peekByte()];
                if (iy_instruction == null) {
                    self.cycles += 4;
                    self.execute();
                } else {
                    _ = self.fetchOpcode();
                    _ = iy_instruction.?(self);
                    // std.debug.print("IY instruction: {any} {any}\n", .{ res, iy_instruction });
                }

                // const iy_opcode = self.fetchByte();
                // switch (iy_opcode) {
                //     0x21 => {
                //         // LD IY, nn
                //         self.iy = self.fetchWord();
                //         self.cycles += 14;
                //     },
                //     0x22 => {
                //         // LD (nn), IY
                //         const nn = self.fetchWord();
                //         self.writeByte(nn, @as(u8, @intCast(self.iy >> 8)));
                //         self.writeByte(nn + 1, @as(u8, @intCast(self.iy & 0xFF)));
                //         self.cycles += 20;
                //     },
                //     0x2A => {
                //         // LD IY, (nn)
                //         self.iy = self.memory[self.fetchWord()];
                //         self.cycles += 20;
                //     },
                //     0x2C => {
                //         // INC IY
                //         self.iy +%= 1;
                //         self.cycles += 10;
                //     },
                //     0x34 => {
                //         // INC (IY+d)
                //         const d = self.fetchByte();
                //         self.writeByte(self.iy + d, self.inc(self.memory[self.iy + d]));
                //         self.cycles += 23;
                //     },
                //     0x35 => {
                //         // DEC (IY+d)
                //         const d = self.fetchByte();
                //         self.writeByte(self.iy + d, self.dec(self.memory[self.iy + d]));
                //         self.cycles += 23;
                //     },
                //     0x36 => {
                //         // LD (IY+d), n
                //         const d = self.fetchByte();
                //         self.writeByte(self.iy + d, self.fetchByte());
                //         self.cycles += 19;
                //     },
                //     0x39 => {
                //         // ADD IY, SP
                //         const result = self.iy + self.sp;
                //         self.iy = @as(u16, @intCast(result & 0xFFFF));
                //         self.cycles += 15;
                //     },
                //     0x46 => {
                //         // LD B, (IY+d)
                //         const d = self.fetchByte();
                //         self.setB(self.memory[self.iy + d]);
                //         self.cycles += 19;
                //     },
                //     0xE5 => {
                //         // std.debug.print("pc = {X:0>4}\n", .{self.pc});
                //         // PUSH IY
                //         self.decSP();
                //         self.writeByte(self.sp, @as(u8, @intCast(self.iy >> 8)));
                //         self.decSP();
                //         self.writeByte(self.sp, @as(u8, @intCast(self.iy & 0xFF)));
                //         self.cycles += 15;
                //         // std.debug.print("pc = {X:0>4}\n", .{self.pc});
                //     },
                //     else => |code| {
                //         std.debug.print("Unknown IY opcode: {0X:0>2}\n", .{code});
                //         self.incR();
                //         self.cycles += 1;
                //     },
                // }
            },
            0xFE => {
                // CP n
                self.cp(self.fetchByte());
            },
            0xFF => {
                // RST 38H
                self.rst(0x38);
            },
            else => |code| {
                std.debug.panic("Unknown opcode: {0X:0>2}", .{code});
            },
        }
    }

    pub fn dumpState(self: *Z80, alloc: Allocator) ![]const u8 {
        return try std.fmt.allocPrint(alloc, "[cpu] a={X:0>2} f={X:0>2} b={X:0>2} c={X:0>2} d={X:0>2} e={X:0>2} h={X:0>2} l={X:0>2} sp={X:0>4} pc={X:0>4}", .{ self.getA(), self.getF(), self.getB(), self.getC(), self.getD(), self.getE(), self.getH(), self.getL(), self.sp, self.pc });
    }

    pub fn printState(self: *Z80) void {
        std.debug.print("[ours  ] a={X:0>2} f={X:0>2} b={X:0>2} c={X:0>2} d={X:0>2} e={X:0>2} h={X:0>2} l={X:0>2} sp={X:0>4} pc={X:0>4}\n", .{ self.getA(), self.getF(), self.getB(), self.getC(), self.getD(), self.getE(), self.getH(), self.getL(), self.sp, self.pc });
    }

    pub fn load(self: *Z80, program: []const u8, start_address: u16) void {
        @memcpy(self.memory[start_address .. start_address + program.len], program);
    }

    pub fn clearMemory(self: *Z80) void {
        self.memory = [_]u8{0} ** 65536;
    }

    pub fn dumpMemory(self: *Z80, alloc: Allocator) ![]const u8 {
        var res = std.ArrayList(u8).init(alloc);
        defer res.deinit();

        for (self.memory, 0..) |byte, i| {
            if (byte != 0) {
                const s = try std.fmt.allocPrint(alloc, "   {d}: {d}\n", .{ i, byte });
                defer alloc.free(s);

                try res.appendSlice(s);
            }
        }

        return res.toOwnedSlice();
    }
};

pub const Flag = struct {
    value: u8,

    pub fn init(value: u8) Flag {
        return Flag{ .value = value };
    }

    pub fn setFromAdd(self: *Flag, v: u8) void {
        self.setFromU8(v);

        // if lower nibble is 0, then half carry
        self.setHalfCarry(v & 0x0F == 0x0F);

        // set parity to true if number of bits is even
        const bits = utils.countSetBits(v);
        std.debug.print("value: {d} bits: {d}\n", .{ v, bits });
        self.setParityOverflow(bits % 2 == 0);
    }

    pub fn setFromIncDec(self: *Flag, old: u8, new: u8) void {
        self.setFromU8(new);

        // if lower nibble is 0, then half carry
        self.setHalfCarry(new & 0x0F == 0x0F);

        // set if 80h
        self.setParityOverflow(old == 0x80);
    }

    pub fn setZeroSign(self: *Flag, v: u8) void {
        self.setZero(v == 0);
        self.setSign(v & 0x80 == 0x80);
    }

    pub fn setZeroSign16(self: *Flag, v: u16) void {
        self.setZero(v == 0);
        self.setSign(v & 0x8000 == 0x8000);
    }

    pub fn setFromU8(self: *Flag, v: u8) void {
        // set sign if bit 0 is set, indicating negative number
        self.setSign(v & 0x80 == 0x80);

        // set zero self if result is zero
        self.setZero(v == 0);

        // sets F5 (aka Y) to bit 5 of the result
        self.setF5(v & 0x20 == 0x20);

        // sets F3 (aka X) to bit 3 of the result
        self.setF3(v & 0x08 == 0x08);
    }

    pub fn setXYFromU8(self: *Flag, v: u8) void {
        // sets F5 (aka Y) to bit 5 of the result
        self.setF5(v & 0x20 == 0x20);

        // sets F3 (aka X) to bit 3 of the result
        self.setF3(v & 0x08 == 0x08);
    }

    pub fn setFromU16(self: *Flag, v: u16) void {
        self.setFromU8(@as(u8, @intCast(v >> 8)));
    }

    pub fn reset(self: *Flag) void {
        self.value = 0;
    }

    pub fn get(self: *Flag) u8 {
        return self.value;
    }

    //  Bit 	7 	6 	5 	4 	3 	2 	1 	0
    // Flag 	S 	Z 	F5 	H 	F3 	P/V 	N 	C
    // Hex      80 40 20 10 08 04 02 01

    pub fn isSign(self: *Flag) bool {
        return (self.value & 0x80) != 0;
    }

    pub fn isZero(self: *Flag) bool {
        return (self.value & 0x40) != 0;
    }

    pub fn isF5(self: *Flag) bool {
        return (self.value & 0x20) != 0;
    }

    pub fn isHalfCarry(self: *Flag) bool {
        return (self.value & 0x10) != 0;
    }

    pub fn isF3(self: *Flag) bool {
        return (self.value & 0x08) != 0;
    }

    pub fn isParityOverflow(self: *Flag) bool {
        return (self.value & 0x04) != 0;
    }

    pub fn isSubtract(self: *Flag) bool {
        return (self.value & 0x02) != 0;
    }

    pub fn isCarry(self: *Flag) bool {
        return (self.value & 0x01) != 0;
    }

    pub fn setSign(self: *Flag, value: bool) void {
        if (value) {
            self.value |= 0b1000_0000;
        } else {
            self.value &= 0b0111_1111;
        }
    }

    pub fn setZero(self: *Flag, value: bool) void {
        if (value) {
            self.value |= 0b0100_0000;
        } else {
            self.value &= 0b1011_1111;
        }
    }

    pub fn setF5(self: *Flag, value: bool) void {
        if (value) {
            self.value |= 0b0010_0000;
        } else {
            self.value &= 0b1101_1111;
        }
    }

    pub fn setHalfCarry(self: *Flag, value: bool) void {
        if (value) {
            self.value |= 0b0001_0000;
        } else {
            self.value &= 0b1110_1111;
        }
    }

    pub fn setF3(self: *Flag, value: bool) void {
        if (value) {
            self.value |= 0b0000_1000;
        } else {
            self.value &= 0b1111_0111;
        }
    }

    pub fn setParityOverflow(self: *Flag, value: bool) void {
        if (value) {
            self.value |= 0b0000_0100;
        } else {
            self.value &= 0b1111_1011;
        }
    }

    pub fn setSubtract(self: *Flag, value: bool) void {
        if (value) {
            self.value |= 0b0000_0010;
        } else {
            self.value &= 0b1111_1101;
        }
    }

    pub fn setCarry(self: *Flag, value: bool) void {
        if (value) {
            self.value |= 0b0000_0001;
        } else {
            self.value &= 0b1111_1110;
        }
    }

    pub fn dump(self: *Flag) void {
        const s = if (self.isSign()) "1" else "0";
        const z = if (self.isZero()) "1" else "0";
        const f5 = if (self.isF5()) "1" else "0";
        const h = if (self.isHalfCarry()) "1" else "0";
        const f3 = if (self.isF3()) "1" else "0";
        const p_v = if (self.isParityOverflow()) "1" else "0";
        const n = if (self.isSubtract()) "1" else "0";
        const c = if (self.isCarry()) "1" else "0";

        std.debug.print("S={s} Z={s} F5={s} H={s} F3={s} P/V={s} N={s} C={s}\n", .{ s, z, f5, h, f3, p_v, n, c });
    }
};

const illegal = null;

fn push_iy(cpu: *Z80) void {
    // std.debug.print("pc = {X:0>4}\n", .{self.pc});
    // PUSH IY
    cpu.decSP();
    cpu.writeByte(cpu.sp, @as(u8, @intCast(cpu.iy >> 8)));
    cpu.decSP();
    cpu.writeByte(cpu.sp, @as(u8, @intCast(cpu.iy & 0xFF)));
    cpu.cycles += 15;
    // std.debug.print("pc = {X:0>4}\n", .{self.pc});
}

fn push_ix(cpu: *Z80) void {
    // PUSH IX
    cpu.decSP();
    cpu.writeByte(cpu.sp, @as(u8, @intCast(cpu.ix >> 8)));
    cpu.decSP();
    cpu.writeByte(cpu.sp, @as(u8, @intCast(cpu.ix & 0xFF)));
    cpu.cycles += 15;
}

fn pop__iy(self: *Z80) void {
    // POP IY
    self.iy = self.memory[self.sp];
    self.incSP();
    self.iy |= @as(u16, @intCast(self.memory[self.sp])) << 8;
    self.incSP();
    self.cycles += 14;
}

fn pop__ix(self: *Z80) void {
    // POP IX
    self.ix = self.memory[self.sp];
    self.incSP();
    self.ix |= @as(u16, @intCast(self.memory[self.sp])) << 8;
    self.incSP();
    self.cycles += 14;
}

fn ldiyl_b(self: *Z80) void {
    // 0xFD 0x68 LD IYL, B
    const iyh = @as(u8, @intCast(self.iy >> 8));
    self.iy = @as(u16, @intCast(iyh)) << 8 | @as(u16, @intCast(self.getB()));
    self.cycles += 8;
}

fn ldiyd_n(self: *Z80) void {
    // 0xFD 0x36 n LD (IY+d), n
    const d = self.fetchByte();
    self.writeByte(self.iy + d, self.fetchByte());
    self.cycles += 19;
}

fn ldiy_nn(self: *Z80) void {
    // 0xFD 0x21 LD IY, nn
    self.iy = self.fetchWord();
    self.cycles += 14;
}

// 0xDD
const IX_TABLE: [256]?*const fn (*Z80) void = .{
    // 0,    1,       2,       3,       4,       5,       6,       7,       8,       9,       A,       B,       C,       D,       E,       F
    illegal, illegal, illegal, illegal, illegal, illegal, illegal, illegal, illegal, illegal, illegal, illegal, illegal, illegal, illegal, illegal, // 0
    illegal, illegal, illegal, illegal, illegal, illegal, illegal, illegal, illegal, illegal, illegal, illegal, illegal, illegal, illegal, illegal, // 1
    illegal, illegal, illegal, illegal, illegal, illegal, illegal, illegal, illegal, illegal, illegal, illegal, illegal, illegal, illegal, illegal, // 2
    illegal, illegal, illegal, illegal, illegal, illegal, illegal, illegal, illegal, illegal, illegal, illegal, illegal, illegal, illegal, illegal, // 3
    illegal, illegal, illegal, illegal, illegal, illegal, illegal, illegal, illegal, illegal, illegal, illegal, illegal, illegal, illegal, illegal, // 4
    illegal, illegal, illegal, illegal, illegal, illegal, illegal, illegal, illegal, illegal, illegal, illegal, illegal, illegal, illegal, illegal, // 5
    illegal, illegal, illegal, illegal, illegal, illegal, illegal, illegal, illegal, illegal, illegal, illegal, illegal, illegal, illegal, illegal, // 6
    illegal, illegal, illegal, illegal, illegal, illegal, illegal, illegal, illegal, illegal, illegal, illegal, illegal, illegal, illegal, illegal, // 7
    illegal, illegal, illegal, illegal, illegal, illegal, illegal, illegal, illegal, illegal, illegal, illegal, illegal, illegal, illegal, illegal, // 8
    illegal, illegal, illegal, illegal, illegal, illegal, illegal, illegal, illegal, illegal, illegal, illegal, illegal, illegal, illegal, illegal, // 9
    illegal, illegal, illegal, illegal, illegal, illegal, illegal, illegal, illegal, illegal, illegal, illegal, illegal, illegal, illegal, illegal, // A
    illegal, illegal, illegal, illegal, illegal, illegal, illegal, illegal, illegal, illegal, illegal, illegal, illegal, illegal, illegal, illegal, // B
    illegal, illegal, illegal, illegal, illegal, illegal, illegal, illegal, illegal, illegal, illegal, illegal, illegal, illegal, illegal, illegal, // C
    illegal, illegal, illegal, illegal, illegal, illegal, illegal, illegal, illegal, illegal, illegal, illegal, illegal, illegal, illegal, illegal, // D
    illegal, pop__ix, illegal, illegal, illegal, push_ix, illegal, illegal, illegal, illegal, illegal, illegal, illegal, illegal, illegal, illegal, // E
    illegal, illegal, illegal, illegal, illegal, illegal, illegal, illegal, illegal, illegal, illegal, illegal, illegal, illegal, illegal, illegal, // F
};

const IY_TABLE: [256]?*const fn (*Z80) void = .{
    // 0,    1,       2,       3,       4,       5,       6,       7,       8,       9,       A,       B,       C,       D,       E,       F
    illegal, illegal, illegal, illegal, illegal, illegal, illegal, illegal, illegal, illegal, illegal, illegal, illegal, illegal, illegal, illegal, // 0
    illegal, illegal, illegal, illegal, illegal, illegal, illegal, illegal, illegal, illegal, illegal, illegal, illegal, illegal, illegal, illegal, // 1
    illegal, ldiy_nn, illegal, illegal, illegal, illegal, illegal, illegal, illegal, illegal, illegal, illegal, illegal, illegal, illegal, illegal, // 2
    illegal, illegal, illegal, illegal, illegal, illegal, ldiyd_n, illegal, illegal, illegal, illegal, illegal, illegal, illegal, illegal, illegal, // 3
    illegal, illegal, illegal, illegal, illegal, illegal, illegal, illegal, illegal, illegal, illegal, illegal, illegal, illegal, illegal, illegal, // 4
    illegal, illegal, illegal, illegal, illegal, illegal, illegal, illegal, illegal, illegal, illegal, illegal, illegal, illegal, illegal, illegal, // 5
    illegal, illegal, illegal, illegal, illegal, illegal, illegal, illegal, ldiyl_b, illegal, illegal, illegal, illegal, illegal, illegal, illegal, // 6
    illegal, illegal, illegal, illegal, illegal, illegal, illegal, illegal, illegal, illegal, illegal, illegal, illegal, illegal, illegal, illegal, // 7
    illegal, illegal, illegal, illegal, illegal, illegal, illegal, illegal, illegal, illegal, illegal, illegal, illegal, illegal, illegal, illegal, // 8
    illegal, illegal, illegal, illegal, illegal, illegal, illegal, illegal, illegal, illegal, illegal, illegal, illegal, illegal, illegal, illegal, // 9
    illegal, illegal, illegal, illegal, illegal, illegal, illegal, illegal, illegal, illegal, illegal, illegal, illegal, illegal, illegal, illegal, // A
    illegal, illegal, illegal, illegal, illegal, illegal, illegal, illegal, illegal, illegal, illegal, illegal, illegal, illegal, illegal, illegal, // B
    illegal, illegal, illegal, illegal, illegal, illegal, illegal, illegal, illegal, illegal, illegal, illegal, illegal, illegal, illegal, illegal, // C
    illegal, illegal, illegal, illegal, illegal, illegal, illegal, illegal, illegal, illegal, illegal, illegal, illegal, illegal, illegal, illegal, // D
    illegal, pop__iy, illegal, illegal, illegal, push_iy, illegal, illegal, illegal, illegal, illegal, illegal, illegal, illegal, illegal, illegal, // E
    illegal, illegal, illegal, illegal, illegal, illegal, illegal, illegal, illegal, illegal, illegal, illegal, illegal, illegal, illegal, illegal, // F
};
