const std = @import("std");
const Allocator = std.mem.Allocator;

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

    pub fn decE(self: *Z80) void {
        var e = self.getE();
        e -%= 1;
        self.setE(e);
    }

    // Fetch the next byte from memory
    fn fetchByte(self: *Z80) u8 {
        const byte = self.memory[self.pc];
        self.pc +%= 1;
        return byte;
    }

    fn peekByte(self: *Z80) u8 {
        return self.memory[self.pc];
    }

    // Fetch the next word (2 bytes) from memory
    fn fetchWord(self: *Z80) u16 {
        const lowByte: u8 = self.fetchByte();
        const highByte: u16 = self.fetchByte();
        return (highByte << 8) | lowByte;
    }

    pub fn writeByte(self: *Z80, address: u16, value: u8) void {
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
            // std.debug.print("Running cycle {d}\n", .{self.cycles});
            self.execute();
        }
    }

    // Execute a single instruction
    pub fn execute(self: *Z80) void {
        std.debug.print("[cpu  ] pc={0X:0>4} opcode={1X:0>2}\n", .{ self.pc, self.peekByte() });
        const opcode = self.fetchByte();

        switch (opcode) {
            0x00 => {
                // NOP
                self.cycles += 4;
            },
            0x01 => {
                // LD BC, nn
                self.bc = self.fetchWord();
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
            0x0A => {
                // LD A, (BC)
                self.setA(self.memory[self.bc]);
                self.pc +%= 7;
            },
            0x1D => {
                // DEC E
                self.decE();
                self.pc +%= 1;
            },
            0x2A => {
                // LD HL, (nn)
                self.hl = self.memory[self.fetchWord()];
                self.cycles += 16;
            },
            0x76 => {
                // HALT
                std.debug.print("HALT\n", .{});
                self.pc +%= 1;
                self.cycles += 4;
                self.halt = true;
                return;
            },
            0xC3 => {
                // JP nn
                self.pc = self.fetchWord();
                self.cycles += 10;
            },
            0xC5 => {
                // PUSH BC
                self.sp -%= 1;
                self.memory[self.sp] = self.getB();
                self.sp -%= 1;
                self.memory[self.sp] = self.getC();
                self.cycles += 11;
            },
            0xCD => {
                // CALL nn
                // The current PC value plus three is pushed onto the stack, then is loaded with nn.
                self.sp -%= 1;
                self.memory[self.sp] = @as(u8, @intCast((self.pc + 3) >> 8));
                self.sp -%= 1;
                self.memory[self.sp] = @as(u8, @intCast((self.pc + 3) & 0xFF));
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
                self.sp -%= 1;
                self.memory[self.sp] = self.getD();
                self.sp -%= 1;
                self.memory[self.sp] = self.getE();
                self.cycles += 11;
            },
            0xF5 => {
                // PUSH AF
                self.sp -%= 1;
                self.memory[self.sp] = self.getA();
                self.sp -%= 1;
                self.memory[self.sp] = self.getF();
                self.cycles += 11;
            },
            0xF9 => {
                // LD SP, HL
                self.sp = self.hl;
                self.cycles += 6;
            },
            else => |code| {
                std.debug.panic("Unknown opcode: {0d: >3} {0X:0>2}", .{code});
            },
        }
    }

    pub fn dumpState(self: *Z80, alloc: Allocator) ![]const u8 {
        return try std.fmt.allocPrint(alloc, "[cpu] a={X:0>2} f={X:0>2} b={X:0>2} c={X:0>2} d={X:0>2} e={X:0>2} h={X:0>2} l={X:0>2} pc={X:0>4} sp={X:0>4}", .{ self.getA(), self.getF(), self.getB(), self.getC(), self.getD(), self.getE(), self.getH(), self.getL(), self.pc, self.sp });
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
