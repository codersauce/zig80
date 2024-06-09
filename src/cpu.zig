const std = @import("std");
const Allocator = std.mem.Allocator;

const utils = @import("utils.zig");

pub const Z80 = struct {
    // 8-bit registers
    af: u16,
    bc: u16,
    de: u16,
    hl: u16,

    // 16-bit registers
    pc: u16,
    sp: u16,

    // Memory (for simplicity, let's assume 64KB)
    memory: [65536]u8,

    // Internal state
    cycles: u64,
    halt: bool,

    // Initialize the CPU state
    pub fn init() Z80 {
        const memory: [65536]u8 = [_]u8{0} ** 65536;
        const af: u16 = 0;
        const bc: u16 = 0;
        const de: u16 = 0;
        const hl: u16 = 0;
        const pc: u16 = 0;
        const sp: u16 = 0xFFFF;
        const cycles: u64 = 0;

        return Z80{
            .af = af,
            .bc = bc,
            .de = de,
            .hl = hl,
            .pc = pc,
            .sp = sp,
            .memory = memory,
            .cycles = cycles,
            .halt = false,
        };
    }

    pub fn reset(self: *Z80) void {
        self.af = 0xFFFF;
        self.bc = 0xFFFF;
        self.de = 0xFFFF;
        self.hl = 0xFFFF;
        self.pc = 0xFFFF;
        self.sp = 0xFFFF;
        self.cycles = 0;
        self.halt = false;
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
        std.debug.print("flag before: ", .{});
        flag.dump();

        flag.setFromAddDec(res);

        // set subtract to false
        flag.setSubtract(true);

        std.debug.print("flag after: ", .{});
        flag.dump();

        self.setF(flag.get());
        return res;
    }

    pub fn inc(self: *Z80, v: u8) u8 {
        const res = v +% 1;
        var flag = self.getFlag();
        std.debug.print("flag before: ", .{});
        flag.dump();

        flag.setFromAddDec(res);

        // set subtract to false
        flag.setSubtract(false);

        std.debug.print("flag after: ", .{});
        flag.dump();

        self.setF(flag.get());
        return res;
    }

    pub fn doOr(self: *Z80, v: u8) void {
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
        flag.setFromVal(result);
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

    pub fn rst(self: *Z80, address: u16) void {
        self.decSP();
        self.writeByte(self.sp, @as(u8, @intCast(self.pc >> 8)));
        self.decSP();
        // std.debug.print("pc = {X:0>4} low = {X:0>2}\n", .{ self.pc, @as(u8, @intCast(self.pc & 0xFF)) });
        self.writeByte(self.sp, @as(u8, @intCast(self.pc & 0xFF)));
        self.pc = address;
        self.cycles += 11;
    }

    // Fetch the next byte from memory
    fn fetchByte(self: *Z80) u8 {
        const byte = self.memory[self.pc];
        self.pc +%= 1;
        return byte;
    }

    pub fn peekByte(self: *Z80) u8 {
        return self.memory[self.pc];
    }

    // Fetch the next word (2 bytes) from memory
    fn fetchWord(self: *Z80) u16 {
        const lowByte: u8 = self.fetchByte();
        const highByte: u16 = self.fetchByte();
        return (highByte << 8) | lowByte;
    }

    pub fn writeByte(self: *Z80, address: u16, value: u8) void {
        // std.debug.print("[w {X:0>4}] = {X:0>2}\n", .{ address, value });
        self.memory[address] = value;
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
            self.execute();
            if (cur_cycle == self.cycles) {
                std.debug.panic("No cycles were consumed (opcode {X:0>2})\n", .{self.peekByte()});
            }
        }
    }

    pub fn isZero(self: *Z80) bool {
        var flag = self.getFlag();
        return flag.isZero();
    }

    pub fn isCarry(self: *Z80) bool {
        var flag = self.getFlag();
        return flag.isCarry();
    }

    // Execute a single instruction
    pub fn execute(self: *Z80) void {
        // std.debug.print("[cpu  ] pc={0X:0>4} opcode={1X:0>2}\n", .{ self.pc, self.peekByte() });
        const opcode = self.fetchByte();

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
            0x03 => {
                // INC BC
                self.bc +%= 1;
                self.cycles += 6;
            },
            0x06 => {
                // LD B, n
                self.setB(self.fetchByte());
                self.cycles += 7;
            },
            0x09 => {
                // ADD HL, BC
                const sum: u32 = self.hl + self.bc;
                self.hl +|= self.bc;

                if (sum > 0xFFFF) {
                    self.setF(self.getF() | 0x10);
                } else {
                    self.setF(self.getF() & 0xEF);
                }

                self.cycles += 11;
                self.pc +%= 1;
            },
            0x0A => {
                // LD A, (BC)
                self.setA(self.memory[self.bc]);
                self.pc +%= 7;
                self.cycles += 7;
            },
            0x0E => {
                // LD C, n
                self.setC(self.fetchByte());
                self.cycles += 7;
            },
            0x11 => {
                // LD DE, nn
                self.de = self.fetchWord();
                self.cycles += 10;
            },
            0x13 => {
                // INC DE
                self.de +%= 1;
                self.cycles += 6;
            },
            0x12 => {
                // LD (DE), A
                std.debug.print("DE={X:0>4} A={X:0>2}\n", .{ self.de, self.getA() });
                self.writeByte(self.de, self.getA());
                self.cycles += 7;
            },
            0x1A => {
                // LD A, (DE)
                self.setA(self.memory[self.de]);
                self.cycles += 7;
            },
            0x1D => {
                // DEC E
                self.decE();
                self.pc +%= 1;
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
            0x2A => {
                // LD HL, (nn)
                self.hl = self.memory[self.fetchWord()];
                self.cycles += 16;
            },
            0x2C => {
                // INC L
                self.setL(self.inc(self.getL()));
                self.cycles += 4;
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
            0x42 => {
                // LD B, D
                self.setB(self.getD());
                self.cycles += 4;
            },
            0x49 => {
                // LD C, C
                self.setC(self.getC());
                self.cycles += 4;
            },
            0x58 => {
                // LD E, B
                self.setE(self.getB());
                self.cycles += 4;
            },
            0x61 => {
                // LD H, C
                self.setH(self.getC());
                self.cycles += 4;
            },
            0x63 => {
                // LD H, E
                self.setH(self.getE());
                self.cycles += 4;
            },
            0x64 => {
                // LD H, H
                self.setH(self.getH());
                self.cycles += 4;
            },
            0x65 => {
                // LD H, L
                self.setH(self.getL());
                self.cycles += 4;
            },
            0x6c => {
                // LD L, H
                self.setL(self.getH());
                self.cycles += 4;
            },
            0x6F => {
                // LD L, A
                self.setL(self.getA());
                self.cycles += 4;
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
            0x7A => {
                // LD A, D
                self.setA(self.getD());
                self.cycles += 4;
            },
            0x7E => {
                // LD A, (HL)
                self.setA(self.memory[self.hl]);
                self.cycles += 7;
            },
            0x80 => {
                // ADD A, B
                // const sum = self.getA() +% self.getB();
                const result: u16 = @as(u16, self.getA()) + @as(u16, self.getB());
                const sum = @as(u8, @intCast(result & 0xFF));

                // std.debug.print("A={X:0>2} B={X:0>2}\n", .{ self.getA(), self.getB() });
                // std.debug.print("sum={X:0>2} result={X:0>2} result8={X:0>2}\n", .{ sum, result, result8 });

                // Condition Bits Affected
                // S is set if result is negative; otherwise, it is reset.
                // Z is set if result is 0; otherwise, it is reset.
                // H is set if carry from bit 3; otherwise, it is reset.
                // P/V is set if overflow; otherwise, it is reset.
                // N is reset.
                // C is set if carry from bit 7; otherwise, it is reset.

                var flag = self.getFlag();
                flag.setFromVal(sum);
                flag.setSign(sum & 0x80 == 0x80);
                flag.setZero(sum == 0);
                flag.setHalfCarry((self.getA() & 0x0F) + (self.getB() & 0x0F) > 0x0F);
                flag.setParityOverflow(sum == 0x7F);
                flag.setSubtract(false);
                flag.setCarry(result > 0xFF);
                self.setF(flag.get());

                self.setA(sum);
                self.cycles += 4;
            },
            0x9C => {
                // SBC A, H
                const carry: u8 = if (self.isCarry()) 1 else 0;
                const result = self.getA() - self.getH() - carry;

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
                flag.setSign(result & 0x80 == 0x80);
                flag.setZero(result == 0);
                flag.setHalfCarry((self.getA() & 0x0F) < (self.getH() & 0x0F) + carry);
                flag.setParityOverflow(result == 0x7F);
                flag.setSubtract(true);
                flag.setCarry(result > 0xFF);
                self.setF(flag.get());

                self.setA(@as(u8, @intCast(result & 0xFF)));
                self.cycles += 4;
            },
            0xB0 => {
                // OR B
                self.doOr(self.getB());
            },
            0xB1 => {
                // OR C
                self.doOr(self.getC());
            },
            0xC3 => {
                // JP nn
                self.pc = self.fetchWord();
                self.cycles += 10;
            },
            0xC5 => {
                // PUSH BC
                self.decSP();
                self.writeByte(self.sp, self.getB());
                self.decSP();
                self.writeByte(self.sp, self.getC());
                self.cycles += 11;
            },
            0xCD => {
                // CALL nn
                // The current PC value plus three is pushed onto the stack, then is loaded with nn.
                self.decSP();
                self.writeByte(self.sp, @as(u8, @intCast((self.pc + 2) >> 8)));
                self.decSP();
                self.writeByte(self.sp, @as(u8, @intCast((self.pc + 2) & 0xFF)));
                self.pc = self.fetchWord();
                self.cycles += 17;
            },
            0xCE => {
                // ADC A, n
                const n = self.fetchByte();
                const carry = (self.getF() & 0x10) >> 4;
                const result = self.getA() + n + carry;
                self.setF(0);
                if (result > 0xFF) {
                    self.setF(self.getF() | 0x10);
                }
                if (result == 0) {
                    self.setF(self.getF() | 0x80);
                }
                self.setA(@as(u8, @intCast(result & 0xFF)));
                self.cycles += 7;
                self.pc +%= 2;
            },
            0xD5 => {
                // PUSH DE
                self.decSP();
                self.writeByte(self.sp, self.getD());
                self.decSP();
                self.writeByte(self.sp, self.getE());
                self.cycles += 11;
            },
            0xD7 => {
                // RST 10H
                self.decSP();
                self.writeByte(self.sp, @as(u8, @intCast((self.pc + 1) >> 8)));
                self.decSP();
                self.writeByte(self.sp, @as(u8, @intCast((self.pc + 1) & 0xFF)));
                self.pc = 0x10;
                self.cycles += 11;
            },
            0xED => {
                // Extended instructions
                const ext_opcode = self.fetchByte();
                switch (ext_opcode) {
                    0xFB => {
                        // EI
                        self.cycles += 4;
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
                const n = self.fetchByte();
                const result = self.getA() & n;

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
                // H is set.
                // P/V is reset if overflow; otherwise, it is reset.
                //    --- this seems to be wrong, it actually detects parity
                // N is reset.
                // C is reset.

                var flag = self.getFlag();
                flag.reset();
                flag.setSign(result & 0x80 == 0x80);
                flag.setZero(result == 0);
                flag.setHalfCarry(true);
                std.debug.print("result: {X:0>2}\n", .{result});
                flag.setParityOverflow(result % 2 == 0);
                self.setF(flag.get());

                self.setA(@as(u8, @intCast(result & 0xFF)));
                self.cycles += 7;
            },
            0xF5 => {
                // PUSH AF
                self.decSP();
                self.writeByte(self.sp, self.getA());
                self.decSP();
                self.writeByte(self.sp, self.getF());
                self.cycles += 11;
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

    pub fn setFromAddDec(self: *Flag, v: u8) void {
        self.setFromVal(v);

        // if lower nibble is 0, then half carry
        self.setHalfCarry(v & 0x0F == 0x0F);

        // set parity to true if number of bits is even
        self.setParityOverflow(utils.countSetBits(v) % 2 == 0);
    }

    pub fn setFromVal(self: *Flag, v: u8) void {
        // set sign if bit 0 is set, indicating negative number
        self.setSign(v & 0x80 == 0x80);

        // set zero self if result is zero
        self.setZero(v == 0);

        // sets F5 (aka Y) to bit 5 of the result
        self.setF5(v & 0x20 == 0x20);

        // sets F3 (aka X) to bit 3 of the result
        self.setF3(v & 0x08 == 0x08);
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
