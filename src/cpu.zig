const std = @import("std");
const Allocator = std.mem.Allocator;

const utils = @import("utils.zig");

pub const Z80 = struct {
    alloc: Allocator,

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

    // "WZ" register.
    // https://www.grimware.org/lib/exe/fetch.php/documentations/devices/z80/z80.memptr.eng.txt
    wz: u16,

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
    pub fn init(alloc: Allocator) Z80 {
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
            .alloc = alloc,
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
            .wz = 0,
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
        self.wz = 0;
        // self.write = null;
        // self.hook = null;
        // self.out = null;
        self.clearMemory();
    }

    pub fn saveState(self: *Z80, path: []const u8) void {
        self.pc -= 1;
        var memory_map = std.ArrayList(u8).init(self.alloc);
        defer memory_map.deinit();

        for (self.memory, 0..) |byte, i| {
            if (byte != 0) {
                const addr_hi: u8 = utils.hi(@intCast(i));
                const addr_lo: u8 = utils.lo(@intCast(i));
                memory_map.append(addr_hi) catch {};
                memory_map.append(addr_lo) catch {};
                memory_map.append(byte) catch {};
            }
        }

        var f = std.fs.cwd().createFile(path, .{ .truncate = true }) catch {
            std.debug.print("Failed to create file\n", .{});
            return;
        };
        const data: SaveData = .{
            .af = self.af,
            .bc = self.bc,
            .de = self.de,
            .hl = self.hl,
            .af_ = self.af_,
            .bc_ = self.bc_,
            .de_ = self.de_,
            .hl_ = self.hl_,
            .pc = self.pc,
            .sp = self.sp,
            .ix = self.ix,
            .iy = self.iy,
            .i = self.i,
            .r = self.r,
            .im = self.im,
            .iff1 = self.iff1,
            .iff2 = self.iff2,
            .memory = memory_map.items,
            .cycles = self.cycles,
            .pending_opcode = self.pending_opcode,
        };
        std.json.stringify(data, .{}, f.writer()) catch {
            std.debug.print("Failed to save state\n", .{});
        };
    }

    pub fn loadState(self: *Z80, path: []const u8) !void {
        var f = try std.fs.cwd().openFile(path, .{});
        defer f.close();

        const data = try f.reader().readAllAlloc(self.alloc, 1_000_000);
        const json = try std.json.parseFromSlice(SaveData, self.alloc, data, .{});
        defer json.deinit();

        const state = json.value;

        self.af = state.af;
        self.bc = state.bc;
        self.de = state.de;
        self.hl = state.hl;
        self.af_ = state.af_;
        self.bc_ = state.bc_;
        self.de_ = state.de_;
        self.hl_ = state.hl_;
        self.pc = state.pc;
        self.sp = state.sp;
        self.ix = state.ix;
        self.iy = state.iy;
        self.i = state.i;
        self.r = state.r;
        self.im = state.im;
        self.iff1 = state.iff1;
        self.iff2 = state.iff2;
        self.cycles = state.cycles;
        self.pending_opcode = state.pending_opcode;

        var i: u32 = 0;
        while (true) {
            const addr_hi = state.memory[i];
            const addr_lo = state.memory[i + 1];
            const addr = @as(u16, @intCast(addr_hi)) << 8 | @as(u16, @intCast(addr_lo));
            self.memory[addr] = state.memory[i + 2];
            i += 3;

            if (i + 2 >= state.memory.len) {
                break;
            }
        }
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

    pub fn getHLMemory(self: *Z80) u8 {
        return self.memory[self.hl];
    }

    pub fn setHLMemory(self: *Z80, v: u8) void {
        self.memory[self.hl] = v;
    }

    pub fn setDEMemory(self: *Z80, v: u8) void {
        self.memory[self.de] = v;
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

    pub fn addn(self: *Z80, v: u8) void {
        self.setA(self.add8(self.getA(), v, self.isCarry()));
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

    // SI void addiz(u16 * reg, u16 val) {
    //   bv nsf = sf; bv nzf = zf; bv npf = pf;
    //   *reg = add16(*reg, val, 0);
    //   sf = nsf; zf = nzf; pf = npf;
    // }

    /// Add a word to a native 16-bit register.
    pub fn addiz(self: *Z80, reg: *u16, val: u16) void {
        const nsf = self.isSign();
        const nzf = self.isZero();
        const npf = self.isParityOverflow();

        reg.* = self.add16n(reg.*, val, false);

        self.setSign(nsf);
        self.setZero(nzf);
        self.setParityOverflow(npf);
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
        self.wz = a + 1;
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
        self.wz = a + 1;
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
        flag.setXY1(resultHi);
        flag.setCarry(result > 0xFFFF);
        flag.setHalfCarry((v1 & 0x0FFF) + (v2 & 0x0FFF) > 0x0FFF);
        self.setF(flag.get());

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

    pub fn adchl(self: *Z80, v: u16) void {
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
        flags.setXY1(@as(u8, @intCast(result >> 8)));
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

    pub fn scbhl(self: *Z80, v: u16) void {
        const q: u16 = self.sub16n(self.hl, v, self.isCarry());
        var flags = self.getFlag();
        flags.setZeroSign16(q);
        self.setF(flags.get());
        self.hl = q;
        self.cycles += 15;
    }

    pub fn tst(self: *Z80, v: u8) void {
        const result = self.getA() & v;
        self.setZero(result == 0);
        self.setSign(result & 0x80 == 0x80);
        self.setParityOverflow(utils.parity(result));
        self.setHalfCarry(true);
        self.setSubtract(false);
        self.setXY1(@intCast(result));
    }

    fn ldi(self: *Z80) void {
        const val = self.getHLMemory();
        self.setHLMemory(val);
        self.setDEMemory(val);
        self.hl = self.hl +% 1;
        self.de = self.de +% 1;
        self.bc = self.bc -% 1;
        self.setXY2(val + self.getA());
        self.setSubtract(false);
        self.setHalfCarry(false);
        self.setParityOverflow(self.bc > 0);
    }

    fn ldd(self: *Z80) void {
        self.ldi();
        self.hl = self.hl -% 2;
        self.de = self.de -% 2;
    }

    fn cpi(self: *Z80) void {
        // bv ncf = cf;
        // u8 v = sub8(a, m[get_hl()], 0);
        // set_hl(get_hl() + (1)); set_bc(get_bc() + (-1));
        // xyf2(v - hf);
        // pf = get_bc() != 0;
        // cf = ncf;
        // wz += 1;
        const carry = self.isCarry();
        const v = self.sub8(self.getA(), self.getHLMemory(), false);
        self.hl = self.hl +% 1;
        self.bc = self.bc -% 1;
        const halfCarry: u1 = if (self.isHalfCarry()) 1 else 0;
        self.setXY2(v - halfCarry);
        self.setParityOverflow(self.bc > 0);
        self.setCarry(carry);
        self.wz +%= 1;
    }

    fn cpd(self: *Z80) void {
        self.cpi();
        self.hl = self.hl -% 2;
        self.wz -%= 2;
    }

    fn adji(self: *Z80) void {
        // set_hl(get_hl() + (1));
        // zf = --b == 0;
        // nf = 1;
        // wz = get_bc() + 1;
        self.hl = self.hl +% 1;
        self.bc = self.bc -% 1;
        self.setZero(self.bc == 0);
        self.setSubtract(true);
        self.wz = self.bc +% 1;
    }

    fn ini(self: *Z80) void {
        // m[get_hl()] = port_in(c); adji();
        self.setHLMemory(self.readFromPort(self.getC()));
        self.adji();
    }

    fn ind(self: *Z80) void {
        // ini(); set_hl(get_hl() + (-2)); wz = get_bc() - 2;
        self.ini();
        self.hl = self.hl -% 2;
        self.wz = self.bc -% 2;
    }

    fn outi(self: *Z80) void {
        // port_out(c, m[get_hl()]); adji();
        self.writeToPort(self.getC(), self.getHLMemory());
        self.adji();
    }

    fn outd(self: *Z80) void {
        // outi(); set_hl(get_hl() + (-2)); wz = get_bc() - 2;
        self.outi();
        self.hl = self.hl -% 2;
        self.wz = self.bc -% 2;
    }

    fn rotep(self: *Z80) void {
        self.setSubtract(false);
        self.setXY1(self.getA());
        self.setZero(self.getA() == 0);
        self.setSign(self.getA() & 0x80 == 0x80);
        self.setParityOverflow(utils.parity(self.getA()));
        self.wz = self.hl +% 1;
    }

    pub fn sbc16(self: *Z80, v: u16) void {
        const carry: u16 = if (self.isCarry()) 1 else 0;
        const result: u32 = @as(u32, @intCast(self.hl)) - @as(u32, @intCast(v)) - @as(u32, @intCast(carry));
        std.debug.print("result={X:0>8}\n", .{result});

        var flags = self.getFlag();
        flags.setXY1(@as(u8, @intCast(result >> 8)));
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

    pub fn subn(self: *Z80, v: u8) void {
        self.setA(self.sub8(self.getA(), v, self.isCarry()));
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
        flag.setXY1(v);
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

    fn rlc(self: *Z80, v: u8) u8 {
        // op_cbh(rlc, bv old = val >> 7; val = (val << 1) | old; cf = old;)
        const old = v >> 7;
        const res = (v << 1) | old;
        self.setCarry(old != 0);
        return res;
    }

    fn rrc(self: *Z80, v: u8) u8 {
        // op_cbh(rrc, bv old = val & 1; val = (val >> 1) | (old << 7); cf = old;)
        const old = v & 1;
        const res = (v >> 1) | (old << 7);
        self.setCarry(old != 0);
        return res;
    }

    fn rl(self: *Z80, v: u8) u8 {
        // op_cbh(rl, bv old = val >> 7; val = (val << 1) | cf; cf = old;)
        const old = v >> 7;
        const carry: u8 = if (self.isCarry()) 1 else 0;
        const res = (v << 1) | carry;
        self.setCarry(old != 0);
        return res;
    }

    fn rr(self: *Z80, v: u8) u8 {
        // op_cbh(rr, bv old = val & 1; val = (val >> 1) | (cf << 7); cf = old;)
        const old = v & 1;
        const carry: u8 = if (self.isCarry()) 1 else 0;
        const res = (v >> 1) | carry << 7;
        self.setCarry(old != 0);
        return res;
    }

    fn sla(self: *Z80, v: u8) u8 {
        // op_cbh(sla, cf = val >> 7; val <<= 1;)
        const res = v << 1;
        self.setCarry(v >> 7 != 0);
        return res;
    }

    fn sra(self: *Z80, v: u8) u8 {
        // op_cbh(sra, cf = val & 1; val = (val >> 1) | (val & 0x80);)
        const res = (v >> 1) | (v & 0x80);
        self.setCarry(v & 1 != 0);
        return res;
    }

    fn sll(self: *Z80, v: u8) u8 {
        // op_cbh(sll, cf = val >> 7; val = (val << 1) | 1;)
        const res = (v << 1) | 1;
        self.setCarry(v >> 7 != 0);
        return res;
    }

    fn srl(self: *Z80, v: u8) u8 {
        // op_cbh(srl, cf = val & 1; val >>= 1;)
        const res = v >> 1;
        self.setCarry(v & 1 != 0);
        return res;
    }

    /// Detects if n-th bit of an u8 is set
    fn bt(self: *Z80, n: u3, val: u8) u8 {
        const res_val = val & (@as(u8, 1) << n);
        const res = res_val != 0;
        self.setZero(res);
        self.setParityOverflow(res);
        self.setXY1(val);
        self.setHalfCarry(true);
        self.setSubtract(false);
        return res_val;
    }

    /// Detects if n-th bit of an u8 is set
    fn bit(self: *Z80, n: u3, val: u8) bool {
        const res_val = val & (@as(u8, 1) << n);
        const res = res_val != 0;
        self.setZero(res);
        self.setParityOverflow(res);
        self.setXY1(val);
        self.setHalfCarry(true);
        self.setSubtract(false);
        return res;
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

    pub fn pop(self: *Z80) u16 {
        const low = self.memory[self.sp];
        self.incSP();
        const high = self.memory[self.sp];
        self.incSP();
        return utils.u16FromBytes(low, high);
    }

    pub fn push(self: *Z80, v: u16) void {
        const low = utils.lo(v);
        self.decSP();
        self.writeByte(self.sp, low);

        const high = utils.hi(v);
        self.decSP();
        self.writeByte(self.sp, high);
    }

    fn jmp(self: *Z80, address: u16) void {
        self.wz = address;
        self.pc = address;
    }

    fn incR(self: *Z80) void {
        self.r +%= 1;
        if (self.r >= 128) {
            self.r = 0;
        }
    }

    fn land(self: *Z80, v: u8) void {
        // static inline void land(u8 val) { u8 res = a & val; szf8(res); xyf1(res); hf = 1; pf = parity(res); nf = cf = 0; a = res; }
        const res = self.getA() & v;
        self.setZero(res == 0);
        self.setSign(res & 0x80 == 0x80);
        self.setHalfCarry(true);
        self.setParityOverflow(utils.parity(res));
        self.setSubtract(false);
        self.setCarry(false);
        self.setA(res);
    }

    fn lxor(self: *Z80, v: u8) void {
        // static inline void lxor(u8 val) { u8 res = a ^ val; szf8(res); xyf1(res); hf = 0; pf = parity(res); nf = cf = 0; a = res; }
        const res = self.getA() ^ v;
        self.setZero(res == 0);
        self.setSign(res & 0x80 == 0x80);
        self.setHalfCarry(false);
        self.setParityOverflow(utils.parity(res));
        self.setSubtract(false);
        self.setCarry(false);
        self.setA(res);
    }

    fn lor(self: *Z80, v: u8) void {
        // static inline void lor(u8 val) { u8 res = a | val; szf8(res); xyf1(res); hf = 0; pf = parity(res); nf = cf = 0; a = res; }
        const res = self.getA() | v;
        self.setZero(res == 0);
        self.setSign(res & 0x80 == 0x80);
        self.setHalfCarry(false);
        self.setParityOverflow(utils.parity(res));
        self.setSubtract(false);
        self.setCarry(false);
        self.setA(res);
    }

    fn cmpa(self: *Z80, v: u8) void {
        // static inline void cmpa(u8 val) { sub8(a, val, 0); xyf1(val); }
        _ = self.sub8(self.getA(), v, false);
        self.setXY1(v);
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

    fn readByte(self: *Z80, address: u16) u8 {
        return self.memory[@as(usize, address)];
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
        if (self.write) |write| {
            write(self, address, value);
            return;
        }
        self.memory[@as(usize, address)] = value;
    }

    fn writeWord(self: *Z80, address: u16, value: u16) void {
        self.writeByte(address, utils.lo(value));
        self.writeByte(address + 1, utils.hi(value));
    }

    fn readWord(self: *Z80, address: u16) u16 {
        const low = self.readByte(address);
        const high = self.readByte(address + 1);
        return utils.u16FromBytes(low, high);
    }

    pub fn writeToPort(self: *Z80, port: u8, value: u8) void {
        if (self.out) |out| {
            out(self, port, value);
            return;
        }
        std.debug.print("OUT {X:0>2}, {X:0>2}\n", .{ port, value });
    }

    pub fn readFromPort(self: *Z80, port: u8) u8 {
        if (self.in) |in| {
            return in(self, port);
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

    fn isZero(self: *Z80) bool {
        var flag = self.getFlag();
        return flag.isZero();
    }

    fn setZero(self: *Z80, zero: bool) void {
        var flag = self.getFlag();
        flag.setZero(zero);
        self.setF(flag.get());
    }

    fn isSign(self: *Z80) bool {
        var flag = self.getFlag();
        return flag.isSign();
    }

    fn setSign(self: *Z80, sign: bool) void {
        var flag = self.getFlag();
        flag.setSign(sign);
        self.setF(flag.get());
    }

    fn isCarry(self: *Z80) bool {
        var flag = self.getFlag();
        return flag.isCarry();
    }

    fn setCarry(self: *Z80, carry: bool) void {
        var flag = self.getFlag();
        flag.setCarry(carry);
        self.setF(flag.get());
    }

    fn isParityOverflow(self: *Z80) bool {
        var flag = self.getFlag();
        return flag.isParityOverflow();
    }

    fn setParityOverflow(self: *Z80, po: bool) void {
        var flag = self.getFlag();
        flag.setParityOverflow(po);
        self.setF(flag.get());
    }

    fn isHalfCarry(self: *Z80) bool {
        var flag = self.getFlag();
        return flag.isHalfCarry();
    }

    fn setHalfCarry(self: *Z80, half_carry: bool) void {
        var flag = self.getFlag();
        flag.setHalfCarry(half_carry);
        self.setF(flag.get());
    }

    fn isSubtract(self: *Z80) bool {
        var flag = self.getFlag();
        return flag.isSubtract();
    }

    fn setSubtract(self: *Z80, subtract: bool) void {
        var flag = self.getFlag();
        flag.setSubtract(subtract);
        self.setF(flag.get());
    }

    fn setXY1(self: *Z80, v: u8) void {
        var flag = self.getFlag();
        flag.setXY1(v);
        self.setF(flag.get());
    }

    fn setXY2(self: *Z80, v: u8) void {
        var flag = self.getFlag();
        flag.setXY2(v);
        self.setF(flag.get());
    }

    fn setInFlags(self: *Z80, v: u8) void {
        self.setZero(v == 0);
        self.setSubtract(v & 0x80 != 0);
        self.setParityOverflow(utils.parity(v));
    }

    // Execute a single instruction
    pub fn execute(self: *Z80) void {
        // std.debug.print("opcode = 0x{X:0>2}\n", .{self.peekByte()});
        self.executeOpcode(self.fetchOpcode());
    }

    pub fn executeOpcode(self: *Z80, opcode: u8) void {
        // std.debug.print("opcode = 0x{X:0>2}\n", .{opcode});
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
                flag.setXY1(result);
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
                flag.setXY1(result);
                flag.setCarry(carry);
                flag.setHalfCarry(false);
                flag.setSubtract(false);
                self.setF(flag.get());

                self.cycles += 4;
            },
            0x10 => {
                // DJNZ n
                const offset = self.fetchByteAsI8();
                self.setB(self.getB() -% 1);
                if (self.getB() != 0) {
                    // std.debug.print("pc = {X:0>4} offset = {d}\n", .{ self.pc, offset });
                    self.pc = @intCast(@as(i16, @intCast(self.pc)) + @as(i16, @intCast(offset)));
                    self.cycles += 13;
                } else {
                    self.cycles += 8;
                }
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
            0x15 => {
                // DEC D
                self.setD(self.dec(self.getD()));
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
                flag.setXY1(result);
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
                self.cycles += 11;
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
            0x1E => {
                // LD E, n
                self.setE(self.fetchByte());
                self.cycles += 7;
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
                flag.setXY1(result);
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
                flags.setXY1(self.getA());
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
                self.cycles += 11;
            },
            0x2A => {
                // LD HL, (nn)
                const addr = self.fetchWord();
                const lo = self.memory[addr];
                const hi = self.memory[addr + 1];
                self.hl = @as(u16, @intCast(hi)) << 8 | lo;
                self.cycles += 16;
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
                flags.setXY1(self.getA());
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
                self.cycles += 11;
            },
            0x35 => {
                // DEC (HL)
                self.writeByte(self.hl, self.dec(self.memory[self.hl]));
                self.cycles += 11;
            },
            0x36 => {
                // LD (HL), n
                self.writeByte(self.hl, self.fetchByte());
                self.cycles += 10;
            },
            0x37 => {
                // SCF
                var flag = self.getFlag();
                flag.setXY1(self.getA());
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
                self.cycles += 11;
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
                var flag = self.getFlag();
                // flag.setHalfCarry(flag.isCarry());
                flag.setCarry(!flag.isCarry());
                flag.setSubtract(false);
                flag.setXY1(self.getA());
                self.setF(flag.get());
                self.cycles += 4;
            },
            0x40 => {
                // LD B, B
                self.setB(self.getB());
                self.cycles += 4;
            },
            0x41 => {
                // LD B, C
                self.setB(self.getC());
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
            0x45 => {
                // LD B, L
                self.setB(self.getL());
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
            0x4B => {
                // LD C, E
                self.setC(self.getE());
                self.cycles += 4;
            },
            0x4C => {
                // LD C, H
                self.setC(self.getH());
                self.cycles += 4;
            },
            0x4D => {
                // LD C, L
                self.setC(self.getL());
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
            0x55 => {
                // LD D, L
                self.setD(self.getL());
                self.cycles += 4;
            },
            0x56 => {
                // LD D, (HL)
                self.setD(self.memory[self.hl]);
                self.cycles += 7;
            },
            0x57 => {
                // LD D, A
                self.setD(self.getA());
                self.cycles += 4;
            },
            0x58 => {
                // LD E, B
                self.setE(self.getB());
                self.cycles += 4;
            },
            0x59 => {
                // LD E, C
                self.setE(self.getC());
                self.cycles += 4;
            },
            0x5A => {
                // LD E, D
                self.setE(self.getD());
                self.cycles += 4;
            },
            0x5B => {
                // LD E, E
                self.setE(self.getE());
                self.cycles += 4;
            },
            0x5C => {
                // LD E, H
                self.setE(self.getH());
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
            0x5F => {
                // LD E, A
                self.setE(self.getA());
                self.cycles += 4;
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
                if (self.hook) |hook| {
                    self.executeOpcode(hook(self, self.pc - 1));
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
            0x6A => {
                // LD L, D
                self.setL(self.getD());
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
            0x6E => {
                // LD L, (HL)
                self.setL(self.memory[self.hl]);
                self.cycles += 7;
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
            0x7C => {
                // LD A, H
                self.setA(self.getH());
                self.cycles += 4;
            },
            0x7D => {
                // LD A, L
                self.setA(self.getL());
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
            0x84 => {
                // ADD A, H
                self.add(self.getA(), self.getH());
            },
            0x85 => {
                // ADD A, L
                self.add(self.getA(), self.getL());
            },
            0x86 => {
                // ADD A, (HL)
                self.addn(self.memory[self.hl]);
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
            0x8B => {
                // ADC A, E
                self.adc(self.getE());
            },
            0x8C => {
                // ADC A, H
                self.adc(self.getH());
            },
            0x8D => {
                // ADC A, L
                self.adc(self.getL());
            },
            0x8E => {
                // ADC A, (HL)
                self.adc(self.memory[self.hl]);
            },
            0x8F => {
                // ADC A, A
                self.adc(self.getA());
            },
            0x90 => {
                // SUB B
                self.sub(self.getB());
            },
            0x91 => {
                // SUB C
                self.sub(self.getC());
            },
            0x92 => {
                // SUB D
                self.sub(self.getD());
            },
            0x93 => {
                // SUB E
                self.sub(self.getE());
            },
            0x94 => {
                // SUB H
                self.sub(self.getH());
            },
            0x95 => {
                // SUB L
                self.sub(self.getL());
            },
            0x96 => {
                // SUB (HL)
                self.sub(self.memory[self.hl]);
            },
            0x97 => {
                // SUB A
                self.sub(self.getA());
            },
            0x98 => {
                // SBC A, B
                self.sbc(self.getA(), self.getB());
            },
            0x99 => {
                // SBC A, C
                self.sbc(self.getA(), self.getC());
            },
            0x9A => {
                // SBC A, D
                self.sbc(self.getA(), self.getD());
            },
            0x9B => {
                // SBC A, E
                self.sbc(self.getA(), self.getE());
            },
            0x9C => {
                // SBC A, H
                self.sbc8(self.getH());
            },
            0x9D => {
                // SBC A, L
                self.sbc8(self.getL());
            },
            0x9E => {
                // SBC A, (HL)
                self.sbc8(self.memory[self.hl]);
            },
            0x9F => {
                // SBC A, A
                self.sbc8(self.getA());
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
            0xA6 => {
                // AND (HL)
                self.andOp(self.memory[self.hl]);
            },
            0xA8 => {
                // XOR B
                self.xorOp(self.getB());
            },
            0xA9 => {
                // XOR C
                self.xorOp(self.getC());
            },
            0xAA => {
                // XOR D
                self.xorOp(self.getD());
            },
            0xAB => {
                // XOR E
                self.xorOp(self.getE());
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
            0xB2 => {
                // OR D
                self.orOp(self.getD());
            },
            0xB3 => {
                // OR E
                self.orOp(self.getE());
            },
            0xB4 => {
                // OR H
                self.orOp(self.getH());
            },
            0xB5 => {
                // OR L
                self.orOp(self.getL());
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
            0xBA => {
                // CP D
                self.cp(self.getD());
            },
            0xBB => {
                // CP E
                self.cp(self.getE());
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
            0xC6 => {
                // ADD A, n
                const n = self.fetchByte();
                self.add(self.getA(), n);
            },
            0xC7 => {
                // RST 00H
                self.rst(0x00);
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
            0xCB => {
                // CB Extended Instructions
                self.exec_cb(self.fetchByte());
                // std.debug.print("0xCB next_byte = {X:0>2}\n", .{next_byte});
                // const cb_instruction = BIT_TABLE[next_byte];
                // std.debug.print("0xCB cb_instruction = {any}\n", .{cb_instruction});
                // if (cb_instruction == null) {
                //     self.saveState("/tmp/cpu.json");
                //     std.debug.panic("Unhandled 0xCB {X:0>2}\n", .{next_byte});
                //     // self.cycles += 4;
                //     // self.execute();
                // } else {
                //     _ = self.fetchOpcode();
                //     _ = cb_instruction.?(self);
                //     // std.debug.print("CB instruction: {any} {any}\n", .{ res, cb_instruction });
                // }
            },
            0xCC => {
                // CALL Z, nn
                const addr = self.fetchWord();
                if (self.isZero()) {
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
            0xCF => {
                // RST 08H
                self.rst(0x08);
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
            0xD4 => {
                // CALL NC, nn
                const addr = self.fetchWord();
                if (!self.isCarry()) {
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
                    self.wz = self.pc;
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
            0xDB => {
                // IN A, (n)
                const port = self.fetchByte();
                self.setA(self.readFromPort(port));
                self.cycles += 11;
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
                self.exec_ind(self.fetchByte(), &self.ix);
                // const next_byte = self.peekByte();
                // // std.debug.print("0xDD next_byte = {X:0>2}\n", .{next_byte});
                // const ix_instruction = IX_TABLE[next_byte];
                // if (ix_instruction == null) {
                //     self.saveState("/tmp/cpu.json");
                //     std.debug.panic("Unhandled 0xDD {X:0>2}\n", .{next_byte});
                //     self.cycles += 4;
                //     self.execute();
                // } else {
                //     _ = self.fetchOpcode();
                //     _ = ix_instruction.?(self);
                //     // std.debug.print("IX instruction: {any} {any}\n", .{ res, ix_instruction });
                // }
            },
            0xDE => {
                // SBC A, n
                const n = self.fetchByte();
                self.sbc8(n);
            },
            0xDF => {
                // RST 18H
                self.rst(0x18);
            },
            0xE0 => {
                // RET PO
                if (!self.isParityOverflow()) {
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
            0xE1 => {
                // POP HL
                self.setL(self.memory[self.sp]);
                self.incSP();
                self.setH(self.memory[self.sp]);
                self.incSP();
                self.cycles += 10;
            },
            0xE2 => {
                // JP PO, nn
                const addr = self.fetchWord();
                if (!self.isParityOverflow()) {
                    self.pc = addr;
                }
                self.cycles += 10;
            },
            0xE3 => {
                // EX (SP), HL
                const hl = self.hl;
                self.hl = utils.u16FromBytes(self.memory[self.sp], self.memory[self.sp + 1]);
                self.memory[self.sp] = utils.lo(hl);
                self.memory[self.sp + 1] = utils.hi(hl);
                self.cycles += 23;
            },
            0xE4 => {
                // CALL PO, nn
                const addr = self.fetchWord();
                if (!self.isParityOverflow()) {
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
                const n = self.fetchByte();
                self.andOp(n);
            },
            0xE7 => {
                // RST 20H
                self.rst(0x20);
            },
            0xE8 => {
                // RET PE
                if (self.isParityOverflow()) {
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
            0xE9 => {
                // JP (HL)
                self.pc = self.hl;
                self.cycles += 4;
            },
            0xEA => {
                // JP PE, nn
                const addr = self.fetchWord();
                if (self.isParityOverflow()) {
                    self.pc = addr;
                }
                self.cycles += 10;
            },
            0xEB => {
                // EX DE, HL
                std.mem.swap(u16, &self.de, &self.hl);
                self.cycles += 4;
            },
            0xEC => {
                // CALL PE, nn
                const addr = self.fetchWord();
                if (self.isParityOverflow()) {
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
            0xED => {
                // Extended instructions
                self.exec_ed(self.fetchOpcode());
            },
            0xEE => {
                // XOR n
                self.xorOp(self.fetchByte());
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
            0xF6 => {
                // OR n
                self.orOp(self.fetchByte());
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
                self.iff1 = true;
                self.iff2 = true;
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
                    self.saveState("/tmp/cpu.json");
                    std.debug.panic("Unhandled 0xFD {X:0>2}\n", .{self.peekByte()});
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
                self.saveState("/tmp/cpu.json");
                std.debug.panic("Unknown opcode: {0X:0>2}", .{code});
            },
        }
    }

    pub fn dumpState(self: *Z80) ![]const u8 {
        return try std.fmt.allocPrint(self.alloc, "[cpu] a={X:0>2} f={X:0>2} b={X:0>2} c={X:0>2} d={X:0>2} e={X:0>2} h={X:0>2} l={X:0>2} sp={X:0>4} pc={X:0>4}", .{ self.getA(), self.getF(), self.getB(), self.getC(), self.getD(), self.getE(), self.getH(), self.getL(), self.sp, self.pc });
    }

    pub fn printState(self: *Z80) void {
        std.debug.print("[ours  ] a={X:0>2} f={X:0>2} b={X:0>2} c={X:0>2} d={X:0>2} e={X:0>2} h={X:0>2} l={X:0>2} sp={X:0>4} pc={X:0>4}\n", .{ self.getA(), self.getF(), self.getB(), self.getC(), self.getD(), self.getE(), self.getH(), self.getL(), self.sp, self.pc });
    }

    pub fn load(self: *Z80, program: []const u8, start_address: u16) void {
        @memset(&self.memory, 0);
        @memcpy(self.memory[start_address .. start_address + program.len], program);
    }

    pub fn clearMemory(self: *Z80) void {
        self.memory = [_]u8{0} ** 65536;
    }

    pub fn dumpMemory(self: *Z80) ![]const u8 {
        var res = std.ArrayList(u8).init(self.alloc);
        defer res.deinit();

        for (self.memory, 0..) |byte, i| {
            if (byte != 0) {
                const s = try std.fmt.allocPrint(self.alloc, "   {d}: {d}\n", .{ i, byte });
                defer self.alloc.free(s);

                try res.appendSlice(s);
            }
        }

        return res.toOwnedSlice();
    }

    // 0xCB - Bit Instructions
    fn exec_cb(self: *Z80, opcode: u8) void {
        self.incR();
        self.cycles += CB_CYCLES_TABLE[opcode];
        const dk: u8 = (opcode >> 6) & 0b11; // opcode kind
        const da: u3 = @as(u3, @intCast((opcode >> 3) & 0b111)); // auxiliary / op0 kind type
        const dr: u8 = opcode & 0b111; // data

        // auxiliary storage for data under hl
        var hlr: u8 = 0;

        const getReg: *const fn (*Z80) u8 = switch (dr) {
            0 => &getB,
            1 => &getC,
            2 => &getD,
            3 => &getE,
            4 => &getH,
            5 => &getL,
            6 => blk: {
                hlr = self.memory[self.hl];
                break :blk &getHLMemory;
            },
            7 => &getA,
            else => |code| {
                self.saveState("/tmp/cpu.json");
                std.debug.panic("Unknown opcode: {0X:0>2}", .{code});
            },
        };

        const setReg: *const fn (*Z80, u8) void = switch (dr) {
            0 => setB,
            1 => setC,
            2 => setD,
            3 => setE,
            4 => setH,
            5 => setL,
            6 => setHLMemory,
            7 => setA,
            else => |code| {
                self.saveState("/tmp/cpu.json");
                std.debug.panic("Unknown opcode: {0X:0>2}", .{code});
            },
        };

        switch (dk) {
            0 => {
                _ = switch (da) {
                    0 => self.rlc(getReg(self)),
                    1 => self.rrc(getReg(self)),
                    2 => self.rl(getReg(self)),
                    3 => self.rr(getReg(self)),
                    4 => self.sla(getReg(self)),
                    5 => self.sra(getReg(self)),
                    6 => self.sll(getReg(self)),
                    7 => self.srl(getReg(self)),
                };
            },
            1 => {
                setReg(self, self.bt(da, getReg(self)));

                // Odd edge case. See the WZ comment.
                if (da == 6) {
                    self.setXY1(utils.hi(self.wz));
                }
            },
            2 => setReg(self, getReg(self) & ~(@as(u8, 1) << da)),
            3 => setReg(self, getReg(self) | (@as(u8, 1) << da)),
            else => {},
        }

        // Write back to hl ptr if needed.
        if (dr == 6) {
            self.writeByte(self.hl, hlr);
        }
    }

    fn exec_ed(self: *Z80, opcode: u8) void {
        switch (opcode) {
            // TST r
            0x04 => {
                // TST B
                self.tst(self.getB());
            },
            0x14 => {
                // TST D
                self.tst(self.getD());
            },
            0x24 => {
                // TST H
                self.tst(self.getH());
            },
            0x34 => {
                // TST (HL)
                self.tst(self.memory[self.hl]);
            },
            0x0C => {
                // TST C
                self.tst(self.getC());
            },
            0x1C => {
                // TST E
                self.tst(self.getE());
            },
            0x2C => {
                // TST L
                self.tst(self.getL());
            },
            0x3C => {
                // TST A
                self.tst(self.getA());
            },
            // This is correct according to Z80 Opcode Table
            // https://clrhome.org/table/#ED%2064
            // but according to tinyZ80 and redcode/Z80
            // it's the same as neg (0xED 44)
            // 0x64 => {
            //     // TST n
            //     const n = self.fetchByte();
            //     self.tst(n);
            // },

            // in r, (C)
            0x40 => {
                // IN B, (C)
                self.setB(self.readFromPort(self.getC()));
                self.setInFlags(self.getB());
                self.cycles += 12;
            },
            0x50 => {
                // IN D, (C)
                self.setD(self.readFromPort(self.getC()));
                self.setInFlags(self.getD());
                self.cycles += 12;
            },
            0x60 => {
                // IN H, (C)
                self.setH(self.readFromPort(self.getC()));
                self.setInFlags(self.getH());
                self.cycles += 12;
            },
            0x70 => {
                // IN (HL), (C)
                self.memory[self.hl] = self.readFromPort(self.getC());
                self.setInFlags(self.memory[self.hl]);
                self.cycles += 12;
            },
            0x48 => {
                // IN C, (C)
                self.setC(self.readFromPort(self.getC()));
                self.setInFlags(self.getC());
                self.cycles += 12;
            },
            0x58 => {
                // IN E, (C)
                self.setE(self.readFromPort(self.getC()));
                self.setInFlags(self.getE());
                self.cycles += 12;
            },
            0x68 => {
                // IN L, (C)
                self.setL(self.readFromPort(self.getC()));
                self.setInFlags(self.getL());
                self.cycles += 12;
            },
            0x78 => {
                // IN A, (C)
                self.setA(self.readFromPort(self.getC()));
                self.setInFlags(self.getA());
                self.cycles += 12;
            },

            // out (C), r
            0x41 => {
                // OUT (C), B
                self.writeToPort(self.getC(), self.getB());
                self.cycles += 12;
            },
            0x51 => {
                // OUT (C), D
                self.writeToPort(self.getC(), self.getD());
                self.cycles += 12;
            },
            0x61 => {
                // OUT (C), H
                self.writeToPort(self.getC(), self.getH());
                self.cycles += 12;
            },
            0x71 => {
                // OUT (C), (HL)
                self.writeToPort(self.getC(), self.memory[self.hl]);
                self.cycles += 12;
            },
            0x49 => {
                // OUT (C), C
                self.writeToPort(self.getC(), self.getC());
                self.cycles += 12;
            },
            0x59 => {
                // OUT (C), E
                self.writeToPort(self.getC(), self.getE());
                self.cycles += 12;
            },
            0x69 => {
                // OUT (C), L
                self.writeToPort(self.getC(), self.getL());
                self.cycles += 12;
            },
            0x79 => {
                // OUT (C), A
                self.writeToPort(self.getC(), self.getA());
                self.wz = self.bc +% 1;
                self.cycles += 12;
            },

            // ADC HL, rr
            0x4A => {
                // ADC HL, BC
                self.adchl(self.bc);
            },
            0x5A => {
                // ADC HL, DE
                self.adchl(self.de);
            },
            0x6A => {
                // ADC HL, HL
                self.adchl(self.hl);
            },
            0x7A => {
                // ADC HL, SP
                self.adchl(self.sp);
            },

            // SBC HL, rr
            0x42 => {
                // SBC HL, BC
                self.scbhl(self.bc);
            },
            0x52 => {
                // SBC HL, DE
                self.scbhl(self.de);
            },
            0x62 => {
                // SBC HL, HL
                self.scbhl(self.hl);
            },
            0x72 => {
                // SBC HL, SP
                self.scbhl(self.sp);
            },

            // LD (nn), reg
            0x43 => {
                // LD (nn), BC
                const nn = self.fetchWord();
                self.writeWord(nn, self.bc);
                self.wz = nn +% 1;
                self.cycles += 20;
            },
            0x53 => {
                // LD (nn), DE
                const nn = self.fetchWord();
                self.writeWord(self.fetchWord(), self.de);
                self.wz = nn +% 1;
            },
            0x63 => {
                // LD (nn), HL
                const nn = self.fetchWord();
                self.writeWord(nn, self.hl);
                self.wz = nn +% 1;
                self.cycles += 20;
            },
            0x73 => {
                // LD (nn), SP
                const nn = self.fetchWord();
                self.writeWord(nn, self.sp);
                self.wz = nn +% 1;
                self.cycles += 20;
            },

            // LD reg, (nn)
            0x4B => {
                // LD BC, (nn)
                const nn = self.fetchWord();
                self.bc = self.readWord(nn);
                self.wz = nn +% 1;
                self.cycles += 20;
            },
            0x5B => {
                // LD DE, (nn)
                const nn = self.fetchWord();
                self.de = self.readWord(nn);
                self.wz = nn +% 1;
                self.cycles += 20;
            },
            0x6B => {
                // LD HL, (nn)
                const nn = self.fetchWord();
                self.hl = self.readWord(nn);
                self.wz = nn +% 1;
                self.cycles += 20;
            },
            0x7B => {
                // LD SP, (nn)
                const nn = self.fetchWord();
                self.sp = self.readWord(nn);
                self.wz = nn +% 1;
                self.cycles += 20;
            },

            // neg
            0x44 | 0x54 | 0x64 | 0x74 | 0x4C | 0x5C | 0x6C | 0x7C => {
                // NEG
                self.setA(self.sub8(0, self.getA(), false));
            },

            // ldi/ldir
            0xA0 => {
                self.ldi();
                self.cycles += 16;
            },
            0xB0 => {
                self.ldi();
                if (self.bc != 0) {
                    self.pc -%= 2;
                    self.wz = self.pc;
                    self.cycles += 21;
                } else {
                    self.cycles += 16;
                }
            },
            0xA8 => {
                self.ldd();
                self.cycles += 16;
            },
            0xB8 => {
                self.ldd();
                if (self.bc != 0) {
                    self.pc -%= 2;
                    self.wz = self.pc;
                    self.cycles += 21;
                } else {
                    self.cycles += 16;
                }
            },

            // cpi/cpd
            0xA1 => {
                self.cpi();
                self.cycles += 16;
            },
            0xA9 => {
                self.cpd();
                self.cycles += 16;
            },

            // cpir/cpdr
            0xB1 => {
                self.cpi();
                if (self.bc != 0 and !self.isZero()) {
                    self.pc -%= 2;
                    self.wz = self.pc;
                    self.cycles += 21;
                } else {
                    self.wz +%= 1;
                    self.cycles += 16;
                }
            },
            0xB9 => {
                self.cpd();
                if (self.bc != 0 and !self.isZero()) {
                    self.pc -%= 2;
                    self.cycles += 21;
                } else {
                    self.wz +%= 1;
                    self.cycles += 16;
                }
            },

            // ini/ind
            0xA2 => {
                self.ini();
                self.cycles += 16;
            },
            0xAA => {
                self.ind();
                self.cycles += 16;
            },

            // inir/indr
            0xB2 => {
                self.ini();
                if (self.getB() != 0) {
                    self.pc -%= 2;
                    self.wz = self.pc;
                    self.cycles += 21;
                } else {
                    self.cycles += 16;
                }
            },
            0xBA => {
                self.ind();
                if (self.getB() != 0) {
                    self.pc -%= 2;
                    self.wz = self.pc;
                    self.cycles += 21;
                } else {
                    self.cycles += 16;
                }
            },

            // outi/outd
            0xA3 => {
                self.outi();
                self.cycles += 16;
            },
            0xAB => {
                self.outd();
                self.cycles += 16;
            },

            // otir/otdr
            0xB3 => {
                self.outi();
                if (self.getB() != 0) {
                    self.pc -%= 2;
                    self.cycles += 21;
                } else {
                    self.cycles += 16;
                }
            },
            0xBB => {
                self.outd();
                if (self.getB() != 0) {
                    self.pc -%= 2;
                    self.cycles += 21;
                } else {
                    self.cycles += 16;
                }
            },

            // im 0/1/2
            0x46 | 0x66 => {
                // IM 0
                self.im = 0;
                self.cycles += 8;
            },
            0x56 | 0x76 => {
                // IM 1
                self.im = 1;
                self.cycles += 8;
            },
            0x5E | 0x7E => {
                // IM 2
                self.im = 2;
                self.cycles += 8;
            },

            // rrd
            0x67 => {
                // RRD
                // u8 na = a, val = m[get_hl()];
                // a = (na & 0xF0) | (val & 0xF);
                // m[get_hl()] = (val >> 4) | (na << 4);
                // rot_ep();
                const na = self.getA();
                const val = self.getHLMemory();
                self.setA((na & 0xF0) | (val & 0xF));
                self.setHLMemory((val >> 4) | (na << 4));
                self.rotep();
                self.cycles += 18;
            },

            // rld
            0x6F => {
                // RLD
                // u8 na = a, val = m[get_hl()];
                // a = (na & 0xF0) | (val >> 4);
                // m[get_hl()] = (val << 4) | (na & 0xF);
                // rot_ep();
                const na = self.getA();
                const val = self.getHLMemory();
                self.setA((na & 0xF0) | (val >> 4));
                self.setHLMemory((val << 4) | (na & 0xF));
                self.rotep();
                self.cycles += 18;
            },

            else => |_| {
                // self.saveState("/tmp/cpu.json");
                // std.debug.panic("Unknown ED extended opcode: {0X:0>2}\n", .{code});
                self.pc +%= 2;
                self.cycles += 8;
            },
        }
    }

    fn exec_ind(self: *Z80, opcode: u8, ir: *u16) void {
        self.incR();

        switch (opcode) {
            // Stack operations.
            0xE1 => {
                // POP IX
                ir.* = self.pop();
                self.cycles += 14;
            },
            0xE5 => {
                // PUSH IX
                self.push(ir.*);
                self.cycles += 15;
            },

            // Jumps.
            0xE9 => {
                // JP (IX)
                self.jmp(ir.*);
                self.cycles += 8;
            },

            // Arithmetics.
            0x09 => {
                // ADD IX, BC
                self.addiz(ir, self.bc);
                self.cycles += 15;
            },
            0x19 => {
                // ADD IX, DE
                self.addiz(ir, self.de);
                self.cycles += 15;
            },
            0x29 => {
                // ADD IX, IX
                self.addiz(ir, ir.*);
                self.cycles += 15;
            },
            0x39 => {
                // ADD IX, SP
                self.addiz(ir, self.sp);
                self.cycles += 15;
            },

            // Hi/lo math.
            // add/adc a, IHI/ILO
            0x84 => {
                // ADD A, IYH
                self.setA(self.add8(self.getA(), utils.hi(ir.* >> 8), false));
                self.cycles += 4;
            },
            0x85 => {
                // ADD A, IYL
                self.setA(self.add8(self.getA(), utils.lo(ir.* >> 8), false));
                self.cycles += 4;
            },
            0x8C => {
                // ADC A, IYH
                self.setA(self.add8(self.getA(), utils.hi(ir.* >> 8), self.isCarry()));
                self.cycles += 1;
            },
            0x8D => {
                // ADC A, IYL
                self.setA(self.add8(self.getA(), utils.lo(ir.* >> 8), self.isCarry()));
                self.cycles += 1;
            },

            // add/adc/sub/sbc a, byte *(ir + imm)
            0x86 => {
                // ADD A, (IX+d)
                self.setA(self.add8(self.getA(), self.memory[self.fetchByte() + ir.*], false));
                self.cycles += 19;
            },
            0x8E => {
                // ADC A, (IX+d)
                self.setA(self.add8(self.getA(), self.memory[self.fetchByte() + ir.*], self.isCarry()));
                self.cycles += 19;
            },
            0x96 => {
                // SUB A, (IX+d)
                self.setA(self.sub8(self.getA(), self.memory[self.fetchByte() + ir.*], false));
                self.cycles += 19;
            },
            0x9E => {
                // SBC A, (IX+d)
                self.setA(self.sub8(self.getA(), self.memory[self.fetchByte() + ir.*], self.isCarry()));
                self.cycles += 19;
            },

            // sub/sbc a, IHI/ILO
            0x94 => {
                // SUB A, IYH
                self.setA(self.sub8(self.getA(), utils.hi(ir.* >> 8), false));
                self.cycles += 4;
            },
            0x95 => {
                // SUB A, IYL
                self.setA(self.sub8(self.getA(), utils.lo(ir.* >> 8), false));
                self.cycles += 4;
            },
            0x9C => {
                // SBC A, IYH
                self.setA(self.sub8(self.getA(), utils.hi(ir.* >> 8), self.isCarry()));
                self.cycles += 4;
            },
            0x9D => {
                // SBC A, IYL
                self.setA(self.sub8(self.getA(), utils.lo(ir.* >> 8), self.isCarry()));
                self.cycles += 4;
            },
            0xA6 => {
                // #define op3(opA, opB, opC, f) H(opA, f(r8(IDP))) H(opB, f(IHI)) H(opC, f(ILO))
                // op3(0xA6, 0xA4, 0xA5, land)
                // op3(0xAE, 0xAC, 0xAD, lxor)
                // op3(0xB6, 0xB4, 0xB5, lor)
                // op3(0xBE, 0xBC, 0xBD, cmpa)
                // #undef op3
                //
                // static inline u8 p8() {return({m[pc++];});}
                //
                //   case 0xA6: land(m[dp(*ir, p8())]); break; case 0xA4: land(((*ir) >> 8)); break; case 0xA5: land(((*ir) & 0xFF)); break;
                //   case 0xAE: lxor(m[dp(*ir, p8())]); break; case 0xAC: lxor(((*ir) >> 8)); break; case 0xAD: lxor(((*ir) & 0xFF)); break;
                //   case 0xB6: lor(m[dp(*ir, p8())]); break; case 0xB4: lor(((*ir) >> 8)); break; case 0xB5: lor(((*ir) & 0xFF)); break;
                //   case 0xBE: cmpa(m[dp(*ir, p8())]); break; case 0xBC: cmpa(((*ir) >> 8)); break; case 0xBD: cmpa(((*ir) & 0xFF)); break;
                //
                // H = #define H(n, c...) case n: c; break;
                // f = function to call (land, lxor, lor or cmpa)
                // r8 = read 8-bit value from memory
                // #define _(a...) {return({a;});}
                // IDP = Displacement computation. Updates the WZ pair.
                //       SI u16 dp(u16 b, i8 d) _ (wz = b + d)
                self.land(self.memory[self.fetchByte() + ir.*]);
                self.cycles += 4;
            },
            0xA4 => {
                // AND A, IYH
                self.land(utils.hi(ir.*));
                self.cycles += 4;
            },
            0xA5 => {
                // AND A, IYL
                self.land(utils.lo(ir.*));
                self.cycles += 4;
            },
            0xAE => {
                // XOR A, (IX+d)
                self.lxor(self.memory[self.fetchByte() + ir.*]);
                self.cycles += 4;
            },
            0xAC => {
                // XOR A, IYH
                self.lxor(utils.hi(ir.*));
                self.cycles += 4;
            },
            0xAD => {
                // XOR A, IYL
                self.lxor(utils.lo(ir.*));
                self.cycles += 4;
            },
            0xB6 => {
                // OR A, (IX+d)
                self.lor(self.memory[self.fetchByte() + ir.*]);
                self.cycles += 4;
            },
            0xB4 => {
                // OR A, IYH
                self.lor(utils.hi(ir.*));
                self.cycles += 4;
            },
            0xB5 => {
                // OR A, IYL
                self.lor(utils.lo(ir.*));
                self.cycles += 4;
            },
            0xBE => {
                // CP A, (IX+d)
                // Subtracts the value pointed to by IX plus d from A and affects flags according to the result. A is not modified.
                const d = self.fetchByte();
                self.cmpa(self.memory[d + ir.*]);
                self.cycles += 4;
            },
            0xBC => {
                // CP A, IYH
                self.cmpa(utils.hi(ir.*));
                self.cycles += 4;
            },
            0xBD => {
                // CP A, IYL
                self.cmpa(utils.lo(ir.*));
                self.cycles += 4;
            },
            0x23 => {
                // INC IX
                ir.* +%= 1;
                self.cycles += 10;
            },
            0x2B => {
                // DEC IX
                ir.* -%= 1;
                self.cycles += 10;
            },

            // inc/dec *(ix/iy + imm)
            0x34 => {
                // case 0x34: t1=dp(*ir, p8());m[t1] = inc(m[t1]); break;
                // INC (IX+d)
                const d = self.fetchByte();
                self.writeByte(ir.* + d, self.inc(self.memory[ir.* + d]));
                self.cycles += 23;
            },
            0x35 => {
                // DEC (IX+d)
                const d = self.fetchByte();
                self.writeByte(ir.* + d, self.dec(self.memory[ir.* + d]));
                self.cycles += 23;
            },

            else => {
                // std.debug.panic("Unknown IY/IX opcode: {0X:0>2}", .{opcode});
                self.executeOpcode(opcode);
                self.r = self.r & 0x80 | (self.r + 1) & 0x7F;
            },
        }
    }
};

pub const SaveData = struct {
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
    memory: []u8,

    // Internal state
    cycles: u64,

    // Pending opcode
    pending_opcode: ?u8,
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

    pub fn setXY1(self: *Flag, v: u8) void {
        // sets F5 (aka Y) to bit 5 of the result
        self.setF5(v & 0x20 == 0x20);

        // sets F3 (aka X) to bit 3 of the result
        self.setF3(v & 0x08 == 0x08);
    }

    pub fn setXY2(self: *Flag, v: u8) void {
        // sets F5 (aka Y) to bit 5 of the result
        self.setF5(v & 0x20 == 0x20);

        // sets F3 (aka X) to bit 1 of the result
        self.setF3(v & 0x02 == 0x02);
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

const _______ = null;

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

fn addixbc(self: *Z80) void {
    // 0xDD 0x09 ADD IX, BC
    self.ix = self.add16n(self.ix, self.bc, self.isCarry());
    self.cycles += 15;
}

fn addiybc(self: *Z80) void {
    // 0xFD 0x09 ADD IY, BC
    self.iy = self.add16n(self.iy, self.bc, self.isCarry());
    self.cycles += 15;
}

fn addixde(self: *Z80) void {
    // 0xDD 0x19 ADD IX, DE
    self.ix = self.add16n(self.ix, self.de, self.isCarry());
    self.cycles += 15;
}

fn addiyde(self: *Z80) void {
    // 0xFD 0x19 ADD IY, DE
    self.iy = self.add16n(self.iy, self.de, self.isCarry());
    self.cycles += 15;
}

fn addixix(self: *Z80) void {
    // 0xDD 0x29 ADD IX, IX
    self.ix = self.add16n(self.ix, self.ix, self.isCarry());
    self.cycles += 15;
}

fn addiyiy(self: *Z80) void {
    // 0xFD 0x29 ADD IY, IY
    self.iy = self.add16n(self.iy, self.iy, self.isCarry());
    self.cycles += 15;
}

fn addixsp(self: *Z80) void {
    // 0xDD 0x39 ADD IX, SP
    self.ix = self.add16n(self.ix, self.sp, self.isCarry());
    self.cycles += 15;
}

fn addiysp(self: *Z80) void {
    // 0xFD 0x39 ADD IY, SP
    self.iy = self.add16n(self.iy, self.sp, self.isCarry());
    self.cycles += 15;
}

fn addaiyh(self: *Z80) void {
    // 0xFD 0x84 ADD A, IYH
    self.addn(@as(u8, @intCast(self.iy >> 8)));
}

fn addaixh(self: *Z80) void {
    // 0xDD 0x84 ADD A, IXH
    self.addn(@as(u8, @intCast(self.ix >> 8)));
}

fn addaiyl(self: *Z80) void {
    // 0xFD 0x85 ADD A, IYL
    self.addn(@as(u8, @intCast(self.iy & 0xFF)));
}

fn addaixl(self: *Z80) void {
    // 0xDD 0x85 ADD A, IXL
    self.addn(@as(u8, @intCast(self.ix & 0xFF)));
}

fn adcaiyh(self: *Z80) void {
    // 0xFD 0x8C ADC A, IYH
    self.adc(@as(u8, @intCast(self.iy >> 8)));
}

fn adcaixh(self: *Z80) void {
    // 0xDD 0x8C ADC A, IXH
    self.adc(@as(u8, @intCast(self.ix >> 8)));
}

fn adcaiyl(self: *Z80) void {
    // 0xFD 0x8D ADC A, IYL
    self.adc(@as(u8, @intCast(self.iy & 0xFF)));
}

fn adcaixl(self: *Z80) void {
    // 0xDD 0x8D ADC A, IXL
    self.adc(@as(u8, @intCast(self.ix & 0xFF)));
}

fn sub_iyh(self: *Z80) void {
    // 0xFD 0x94 SUB IYH
    self.subn(@as(u8, @intCast(self.iy >> 8)));
}

fn sub_ixh(self: *Z80) void {
    // 0xDD 0x94 SUB IXH
    self.subn(@as(u8, @intCast(self.ix >> 8)));
}

fn sub_iyl(self: *Z80) void {
    // 0xFD 0x95 SUB IYL
    self.subn(@as(u8, @intCast(self.iy & 0xFF)));
}

fn sub_ixl(self: *Z80) void {
    // 0xDD 0x95 SUB IXL
    self.subn(@as(u8, @intCast(self.ix & 0xFF)));
}

fn sbcaiyh(self: *Z80) void {
    // 0xFD 0x9C SBC A, IYH
    self.sbc8(@as(u8, @intCast(self.iy >> 8)));
}

fn sbcaixh(self: *Z80) void {
    // 0xDD 0x9C SBC A, IXH
    self.sbc8(@as(u8, @intCast(self.ix >> 8)));
}

fn sbcaiyl(self: *Z80) void {
    // 0xFD 0x9D SBC A, IYL
    self.sbc8(@as(u8, @intCast(self.iy & 0xFF)));
}

fn sbcaixl(self: *Z80) void {
    // 0xDD 0x9D SBC A, IXL
    self.sbc8(@as(u8, @intCast(self.ix & 0xFF)));
}

fn and_iyh(self: *Z80) void {
    // 0xFD 0xA4 AND IYH
    self.andOp(@as(u8, @intCast(self.iy >> 8)));
}

fn and_ixh(self: *Z80) void {
    // 0xDD 0xA4 AND IXH
    self.andOp(@as(u8, @intCast(self.ix >> 8)));
}

fn and_iyl(self: *Z80) void {
    // 0xFD 0xA5 AND IYL
    self.andOp(@as(u8, @intCast(self.iy & 0xFF)));
}

fn and_ixl(self: *Z80) void {
    // 0xDD 0xA5 AND IXL
    self.andOp(@as(u8, @intCast(self.ix & 0xFF)));
}

fn xor_ixl(self: *Z80) void {
    // 0xDD 0xAC XOR IXL
    self.xorOp(@as(u8, @intCast(self.ix & 0xFF)));
}

fn xor_iyl(self: *Z80) void {
    // 0xFD 0xAD XOR IYL
    self.xorOp(@as(u8, @intCast(self.iy & 0xFF)));
}

fn xor_ixh(self: *Z80) void {
    // 0xDD 0xAC XOR IXH
    self.xorOp(@as(u8, @intCast(self.ix >> 8)));
}

fn xor_iyh(self: *Z80) void {
    // 0xFD 0xAD XOR IYH
    self.xorOp(@as(u8, @intCast(self.iy >> 8)));
}

fn ori__xh(self: *Z80) void {
    // 0xDD 0xB4 OR IXH
    self.orOp(@as(u8, @intCast(self.ix >> 8)));
}

fn or__iyh(self: *Z80) void {
    // 0xFD 0xB4 OR IYH
    self.orOp(@as(u8, @intCast(self.iy >> 8)));
}

fn ori__xl(self: *Z80) void {
    // 0xDD 0xB5 OR IXL
    self.orOp(@as(u8, @intCast(self.ix & 0xFF)));
}

fn or__iyl(self: *Z80) void {
    // 0xFD 0xB5 OR IYL
    self.orOp(@as(u8, @intCast(self.iy & 0xFF)));
}

fn cp__iyh(self: *Z80) void {
    // 0xFD 0xBC CP IYH
    self.cp(@as(u8, @intCast(self.iy >> 8)));
}

fn cp__ixh(self: *Z80) void {
    // 0xDD 0xBC CP IXH
    self.cp(@as(u8, @intCast(self.ix >> 8)));
}

fn cp__iyl(self: *Z80) void {
    // 0xFD 0xBD CP IYL
    self.cp(@as(u8, @intCast(self.iy & 0xFF)));
}

fn cp__ixl(self: *Z80) void {
    // 0xDD 0xBD CP IXL
    self.cp(@as(u8, @intCast(self.ix & 0xFF)));
}

fn addaiyd(self: *Z80) void {
    // 0xFD 0x86 ADD A, (IY+d)
    const d = self.fetchByte();
    self.addn(self.memory[self.iy + d]);
    self.cycles += 19;
}

fn addaixd(self: *Z80) void {
    // 0xDD 0x86 ADD A, (IX+d)
    const d = self.fetchByte();
    self.addn(self.memory[self.ix + d]);
    self.cycles += 19;
}

fn adcaiyd(self: *Z80) void {
    // 0xFD 0x8E ADC A, (IY+d)
    const d = self.fetchByte();
    self.adc(self.memory[self.iy + d]);
    self.cycles += 19;
}

fn adcaixd(self: *Z80) void {
    // 0xDD 0x8E ADC A, (IX+d)
    const d = self.fetchByte();
    self.adc(self.memory[self.ix + d]);
    self.cycles += 19;
}

fn subaiyd(self: *Z80) void {
    // 0xFD 0x96 SUB A, (IY+d)
    const d = self.fetchByte();
    self.subn(self.memory[self.iy + d]);
    self.cycles += 19;
}

fn subaixd(self: *Z80) void {
    // 0xDD 0x96 SUB A, (IX+d)
    const d = self.fetchByte();
    self.subn(self.memory[self.ix + d]);
    self.cycles += 19;
}

fn sbcaiyd(self: *Z80) void {
    // 0xFD 0x9E SBC A, (IY+d)
    const d = self.fetchByte();
    self.sbc8(self.memory[self.iy + d]);
    self.cycles += 19;
}

fn and_iyd(self: *Z80) void {
    // 0xFD 0xA6 AND (IY+d)
    const d = self.fetchByte();
    self.andOp(self.memory[self.iy + d]);
    self.cycles += 19;
}

fn and_ixd(self: *Z80) void {
    // 0xDD 0xA6 AND (IX+d)
    const d = self.fetchByte();
    self.andOp(self.memory[self.ix + d]);
    self.cycles += 19;
}

fn xor_iyd(self: *Z80) void {
    // 0xFD 0xAE XOR (IY+d)
    const d = self.fetchByte();
    self.xorOp(self.memory[self.iy + d]);
    self.cycles += 19;
}

fn xor_ixd(self: *Z80) void {
    // 0xDD 0xAE XOR (IX+d)
    const d = self.fetchByte();
    self.xorOp(self.memory[self.ix + d]);
    self.cycles += 19;
}

fn or__iyd(self: *Z80) void {
    // 0xFD 0xB6 OR (IY+d)
    const d = self.fetchByte();
    self.orOp(self.memory[self.iy + d]);
    self.cycles += 19;
}

fn or__ixd(self: *Z80) void {
    // 0xDD 0xB6 OR (IX+d)
    const d = self.fetchByte();
    self.orOp(self.memory[self.ix + d]);
    self.cycles += 19;
}

fn cp__iyd(self: *Z80) void {
    // 0xFD 0xBE CP (IY+d)
    const d = self.fetchByte();
    self.cp(self.memory[self.iy + d]);
    self.cycles += 19;
}

fn cp__ixd(self: *Z80) void {
    // 0xDD 0xBE CP (IX+d)
    const d = self.fetchByte();
    self.cp(self.memory[self.ix + d]);
    self.cycles += 19;
}

fn ix__bit(self: *Z80) void {
    // 0xDD 0xCB IX Bit Instructions
    const next_byte = self.peekByte();
    const ix_bit_instruction = IX_BIT_TABLE[next_byte];
    if (ix_bit_instruction == null) {
        self.saveState("/tmp/cpu.json");
        std.debug.panic("Unhandled 0xDD 0xCB {X:0>2}\n", .{next_byte});
        self.cycles += 4;
        self.execute();
    } else {
        _ = self.fetchOpcode();
        _ = ix_bit_instruction.?(self);
    }
}

fn iy__bit(self: *Z80) void {
    // 0xFD 0xCB IY Bit Instructions
    const next_byte = self.peekByte();
    const iy_bit_instruction = IY_BIT_TABLE[next_byte];
    if (iy_bit_instruction == null) {
        self.saveState("/tmp/cpu.json");
        std.debug.panic("Unhandled 0xFD 0xCB {X:0>2}\n", .{next_byte});
        self.cycles += 4;
        self.execute();
    } else {
        _ = self.fetchOpcode();
        _ = iy_bit_instruction.?(self);
    }
}

// 0xDD and 0xFD 0xCB - Bit Instructions

fn rlcixdc(self: *Z80) void {
    // 0xDD 0xCB 0x01 RLC (IX+d), d
    const d = self.fetchByte();
    const res = self.rlc(self.memory[self.ix + d]);
    self.writeByte(self.ix + d, res);
    self.setC(res);
    self.cycles += 23;
}

fn rlciydc(self: *Z80) void {
    // 0xFD 0xCB 0x01 RLC (IY+d), d
    const d = self.fetchByte();
    const res = self.rlc(self.memory[self.iy + d]);
    self.writeByte(self.iy + d, res);
    self.setC(res);
    self.cycles += 23;
}

// 0xDD
const IX_TABLE: [256]?*const fn (*Z80) void = .{
    // 0,    1,       2,       3,       4,       5,       6,       7,       8,       9,       A,       B,       C,       D,       E,       F
    _______, _______, _______, _______, _______, _______, _______, _______, _______, addixbc, _______, _______, _______, _______, _______, _______, // 0
    _______, _______, _______, _______, _______, _______, _______, _______, _______, addixde, _______, _______, _______, _______, _______, _______, // 1
    _______, _______, _______, _______, _______, _______, _______, _______, _______, addixix, _______, _______, _______, _______, _______, _______, // 2
    _______, _______, _______, _______, _______, _______, _______, _______, _______, addixsp, _______, _______, _______, _______, _______, _______, // 3
    _______, _______, _______, _______, _______, _______, _______, _______, _______, _______, _______, _______, _______, _______, _______, _______, // 4
    _______, _______, _______, _______, _______, _______, _______, _______, _______, _______, _______, _______, _______, _______, _______, _______, // 5
    _______, _______, _______, _______, _______, _______, _______, _______, _______, _______, _______, _______, _______, _______, _______, _______, // 6
    _______, _______, _______, _______, _______, _______, _______, _______, _______, _______, _______, _______, _______, _______, _______, _______, // 7
    _______, _______, _______, _______, addaixh, addaixl, addaixd, _______, _______, _______, _______, _______, adcaixh, adcaixl, adcaiyd, _______, // 8
    _______, _______, _______, _______, sub_ixh, sub_ixl, subaixd, _______, _______, _______, _______, _______, sbcaixh, sbcaixl, sbcaiyd, _______, // 9
    _______, _______, _______, _______, and_ixh, and_ixl, and_ixd, _______, _______, _______, _______, _______, xor_ixh, xor_ixl, xor_ixd, _______, // A
    _______, _______, _______, _______, ori__xh, ori__xl, or__ixd, _______, _______, _______, _______, _______, cp__ixh, cp__ixl, cp__ixd, _______, // B
    _______, _______, _______, _______, _______, _______, _______, _______, _______, _______, _______, ix__bit, _______, _______, _______, _______, // C
    _______, _______, _______, _______, _______, _______, _______, _______, _______, _______, _______, _______, _______, _______, _______, _______, // D
    _______, pop__ix, _______, _______, _______, push_ix, _______, _______, _______, _______, _______, _______, _______, _______, _______, _______, // E
    _______, _______, _______, _______, _______, _______, _______, _______, _______, _______, _______, _______, _______, _______, _______, _______, // F
};

// 0xFD
const IY_TABLE: [256]?*const fn (*Z80) void = .{
    // 0,    1,       2,       3,       4,       5,       6,       7,       8,       9,       A,       B,       C,       D,       E,       F
    _______, _______, _______, _______, _______, _______, _______, _______, _______, addiybc, _______, _______, _______, _______, _______, _______, // 0
    _______, _______, _______, _______, _______, _______, _______, _______, _______, addiyde, _______, _______, _______, _______, _______, _______, // 1
    _______, ldiy_nn, _______, _______, _______, _______, _______, _______, _______, addiyiy, _______, _______, _______, _______, _______, _______, // 2
    _______, _______, _______, _______, _______, _______, ldiyd_n, _______, _______, addiysp, _______, _______, _______, _______, _______, _______, // 3
    _______, _______, _______, _______, _______, _______, _______, _______, _______, _______, _______, _______, _______, _______, _______, _______, // 4
    _______, _______, _______, _______, _______, _______, _______, _______, _______, _______, _______, _______, _______, _______, _______, _______, // 5
    _______, _______, _______, _______, _______, _______, _______, _______, ldiyl_b, _______, _______, _______, _______, _______, _______, _______, // 6
    _______, _______, _______, _______, _______, _______, _______, _______, _______, _______, _______, _______, _______, _______, _______, _______, // 7
    _______, _______, _______, _______, addaiyh, addaiyl, addaiyd, _______, _______, _______, _______, _______, adcaiyh, adcaixl, adcaiyd, _______, // 8
    _______, _______, _______, _______, sub_iyh, sub_iyl, subaiyd, _______, _______, _______, _______, _______, sbcaiyh, sbcaiyl, sbcaiyd, _______, // 9
    _______, _______, _______, _______, and_ixh, and_ixl, and_iyd, _______, _______, _______, _______, _______, xor_iyh, xor_iyl, xor_iyd, _______, // A
    _______, _______, _______, _______, or__iyh, or__iyl, or__iyd, _______, _______, _______, _______, _______, cp__iyh, cp__iyl, cp__iyd, _______, // B
    _______, _______, _______, _______, _______, _______, _______, _______, _______, _______, _______, iy__bit, _______, _______, _______, _______, // C
    _______, _______, _______, _______, _______, _______, _______, _______, _______, _______, _______, _______, _______, _______, _______, _______, // D
    _______, pop__iy, _______, _______, _______, push_iy, _______, _______, _______, _______, _______, _______, _______, _______, _______, _______, // E
    _______, _______, _______, _______, _______, _______, _______, _______, _______, _______, _______, _______, _______, _______, _______, _______, // F
};

// 0xDD 0xCB
const IX_BIT_TABLE: [256]?*const fn (*Z80) void = .{
    // 0,    1,       2,       3,       4,       5,       6,       7,       8,       9,       A,       B,       C,       D,       E,       F
    _______, rlcixdc, _______, _______, _______, _______, _______, _______, _______, _______, _______, _______, _______, _______, _______, _______, // 0
    _______, _______, _______, _______, _______, _______, _______, _______, _______, _______, _______, _______, _______, _______, _______, _______, // 1
    _______, _______, _______, _______, _______, _______, _______, _______, _______, _______, _______, _______, _______, _______, _______, _______, // 2
    _______, _______, _______, _______, _______, _______, _______, _______, _______, _______, _______, _______, _______, _______, _______, _______, // 3
    _______, _______, _______, _______, _______, _______, _______, _______, _______, _______, _______, _______, _______, _______, _______, _______, // 4
    _______, _______, _______, _______, _______, _______, _______, _______, _______, _______, _______, _______, _______, _______, _______, _______, // 5
    _______, _______, _______, _______, _______, _______, _______, _______, _______, _______, _______, _______, _______, _______, _______, _______, // 6
    _______, _______, _______, _______, _______, _______, _______, _______, _______, _______, _______, _______, _______, _______, _______, _______, // 7
    _______, _______, _______, _______, _______, _______, _______, _______, _______, _______, _______, _______, _______, _______, _______, _______, // 8
    _______, _______, _______, _______, _______, _______, _______, _______, _______, _______, _______, _______, _______, _______, _______, _______, // 9
    _______, _______, _______, _______, _______, _______, _______, _______, _______, _______, _______, _______, _______, _______, _______, _______, // A
    _______, _______, _______, _______, _______, _______, _______, _______, _______, _______, _______, _______, _______, _______, _______, _______, // B
    _______, _______, _______, _______, _______, _______, _______, _______, _______, _______, _______, _______, _______, _______, _______, _______, // C
    _______, _______, _______, _______, _______, _______, _______, _______, _______, _______, _______, _______, _______, _______, _______, _______, // D
    _______, _______, _______, _______, _______, _______, _______, _______, _______, _______, _______, _______, _______, _______, _______, _______, // E
    _______, _______, _______, _______, _______, _______, _______, _______, _______, _______, _______, _______, _______, _______, _______, _______, // F
};

// 0xFD 0xCB
const IY_BIT_TABLE: [256]?*const fn (*Z80) void = .{
    // 0,    1,       2,       3,       4,       5,       6,       7,       8,       9,       A,       B,       C,       D,       E,       F
    _______, rlciydc, _______, _______, _______, _______, _______, _______, _______, _______, _______, _______, _______, _______, _______, _______, // 0
    _______, _______, _______, _______, _______, _______, _______, _______, _______, _______, _______, _______, _______, _______, _______, _______, // 1
    _______, _______, _______, _______, _______, _______, _______, _______, _______, _______, _______, _______, _______, _______, _______, _______, // 2
    _______, _______, _______, _______, _______, _______, _______, _______, _______, _______, _______, _______, _______, _______, _______, _______, // 3
    _______, _______, _______, _______, _______, _______, _______, _______, _______, _______, _______, _______, _______, _______, _______, _______, // 4
    _______, _______, _______, _______, _______, _______, _______, _______, _______, _______, _______, _______, _______, _______, _______, _______, // 5
    _______, _______, _______, _______, _______, _______, _______, _______, _______, _______, _______, _______, _______, _______, _______, _______, // 6
    _______, _______, _______, _______, _______, _______, _______, _______, _______, _______, _______, _______, _______, _______, _______, _______, // 7
    _______, _______, _______, _______, _______, _______, _______, _______, _______, _______, _______, _______, _______, _______, _______, _______, // 8
    _______, _______, _______, _______, _______, _______, _______, _______, _______, _______, _______, _______, _______, _______, _______, _______, // 9
    _______, _______, _______, _______, _______, _______, _______, _______, _______, _______, _______, _______, _______, _______, _______, _______, // A
    _______, _______, _______, _______, _______, _______, _______, _______, _______, _______, _______, _______, _______, _______, _______, _______, // B
    _______, _______, _______, _______, _______, _______, _______, _______, _______, _______, _______, _______, _______, _______, _______, _______, // C
    _______, _______, _______, _______, _______, _______, _______, _______, _______, _______, _______, _______, _______, _______, _______, _______, // D
    _______, _______, _______, _______, _______, _______, _______, _______, _______, _______, _______, _______, _______, _______, _______, _______, // E
    _______, _______, _______, _______, _______, _______, _______, _______, _______, _______, _______, _______, _______, _______, _______, _______, // F
};

// CB Cycles Table
const CB_CYCLES_TABLE: [256]u8 = .{
    //0,   1,   2,   3,   4,   5,   6,   7,   8,   9,   A,   B,   C,   D,   E,   F
    0x8, 0x8, 0x8, 0x8, 0x8, 0x8, 0xF, 0x8, 0x8, 0x8, 0x8, 0x8, 0x8, 0x8, 0xF, 0x8, // 0
    0x8, 0x8, 0x8, 0x8, 0x8, 0x8, 0xF, 0x8, 0x8, 0x8, 0x8, 0x8, 0x8, 0x8, 0xF, 0x8, // 1
    0x8, 0x8, 0x8, 0x8, 0x8, 0x8, 0xF, 0x8, 0x8, 0x8, 0x8, 0x8, 0x8, 0x8, 0xF, 0x8, // 2
    0x8, 0x8, 0x8, 0x8, 0x8, 0x8, 0xF, 0x8, 0x8, 0x8, 0x8, 0x8, 0x8, 0x8, 0xF, 0x8, // 3
    0x8, 0x8, 0x8, 0x8, 0x8, 0x8, 0xF, 0x8, 0x8, 0x8, 0x8, 0x8, 0x8, 0x8, 0xF, 0x8, // 4
    0x8, 0x8, 0x8, 0x8, 0x8, 0x8, 0xF, 0x8, 0x8, 0x8, 0x8, 0x8, 0x8, 0x8, 0xF, 0x8, // 5
    0x8, 0x8, 0x8, 0x8, 0x8, 0x8, 0xF, 0x8, 0x8, 0x8, 0x8, 0x8, 0x8, 0x8, 0xF, 0x8, // 6
    0x8, 0x8, 0x8, 0x8, 0x8, 0x8, 0xF, 0x8, 0x8, 0x8, 0x8, 0x8, 0x8, 0x8, 0xF, 0x8, // 7
    0x8, 0x8, 0x8, 0x8, 0x8, 0x8, 0xF, 0x8, 0x8, 0x8, 0x8, 0x8, 0x8, 0x8, 0xF, 0x8, // 8
    0x8, 0x8, 0x8, 0x8, 0x8, 0x8, 0xF, 0x8, 0x8, 0x8, 0x8, 0x8, 0x8, 0x8, 0xF, 0x8, // 9
    0x8, 0x8, 0x8, 0x8, 0x8, 0x8, 0xF, 0x8, 0x8, 0x8, 0x8, 0x8, 0x8, 0x8, 0xF, 0x8, // A
    0x8, 0x8, 0x8, 0x8, 0x8, 0x8, 0xF, 0x8, 0x8, 0x8, 0x8, 0x8, 0x8, 0x8, 0xF, 0x8, // B
    0x8, 0x8, 0x8, 0x8, 0x8, 0x8, 0xF, 0x8, 0x8, 0x8, 0x8, 0x8, 0x8, 0x8, 0xF, 0x8, // C
    0x8, 0x8, 0x8, 0x8, 0x8, 0x8, 0xF, 0x8, 0x8, 0x8, 0x8, 0x8, 0x8, 0x8, 0xF, 0x8, // D
    0x8, 0x8, 0x8, 0x8, 0x8, 0x8, 0xF, 0x8, 0x8, 0x8, 0x8, 0x8, 0x8, 0x8, 0xF, 0x8, // E
    0x8, 0x8, 0x8, 0x8, 0x8, 0x8, 0xF, 0x8, 0x8, 0x8, 0x8, 0x8, 0x8, 0x8, 0xF, 0x8, // F
};
