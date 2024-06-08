const std = @import("std");
const Allocator = std.mem.Allocator;

pub const Z80 = struct {
    // 8-bit registers
    a: u8,
    f: u8,
    b: u8,
    c: u8,
    d: u8,
    e: u8,
    h: u8,
    l: u8,

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
        const a: u8 = 0;
        const f: u8 = 0;
        const b: u8 = 0;
        const c: u8 = 0;
        const d: u8 = 0;
        const e: u8 = 0;
        const h: u8 = 0;
        const l: u8 = 0;
        const pc: u16 = 0;
        const sp: u16 = 0xFFFF;
        const cycles: u64 = 0;

        return Z80{
            .a = a,
            .f = f,
            .b = b,
            .c = c,
            .d = d,
            .e = e,
            .h = h,
            .l = l,
            .pc = pc,
            .sp = sp,
            .memory = memory,
            .cycles = cycles,
            .halt = false,
        };
    }

    pub fn reset(self: *Z80) void {
        self.a = 0xFF;
        self.f = 0xFF;
        self.b = 0xFF;
        self.c = 0xFF;
        self.d = 0xFF;
        self.e = 0xFF;
        self.h = 0xFF;
        self.l = 0xFF;
        self.pc = 0xFF;
        self.sp = 0xFFFF;
        self.cycles = 0;
        self.halt = false;
        self.clearMemory();
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

    pub fn fetchByteFromBC(self: *Z80) u8 {
        const b: u16 = self.b;
        const c: u16 = self.c;
        const address = b << 8 | c;
        return self.memory[address];
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
                //uLD BC, nn
                const nn = self.fetchWord();
                self.b = @as(u8, @intCast(nn >> 8));
                self.c = @as(u8, @intCast(nn & 0xFF));
            },
            0x09 => {
                // ADD HL, BC
                const bc: u16 = (@as(u16, self.b) << 8) | self.c;
                const hl: u16 = (@as(u16, self.h) << 8) | self.l;
                const result: u16 = hl + bc;
                self.h = @as(u8, @intCast(result >> 8));
                self.l = @as(u8, @intCast(result & 0xFF));
                self.f = 0;
                if (result > 0xFFFF) {
                    self.f |= 0x10;
                }
                self.cycles += 11;
                self.pc +%= 1;
            },
            0x0E => {
                // LD C, n
                self.c = self.fetchByte();
                self.cycles += 7;
            },
            0x11 => {
                // LD DE, nn
                const nn = self.fetchWord();
                self.d = @as(u8, @intCast(nn >> 8));
                self.e = @as(u8, @intCast(nn & 0xFF));
                self.cycles += 10;
            },
            0x0A => {
                // HALT
                self.a = self.fetchByteFromBC();
                self.pc +%= 7;
            },
            0x1D => {
                // DEC B
                self.e -%= 1;
                self.pc +%= 1;
            },
            0x2A => {
                // LD HL, (nn)
                const nn = self.fetchWord();
                const lowByte = self.memory[nn];
                const highByte = self.memory[nn + 1];
                self.l = lowByte;
                self.h = highByte;
                self.cycles += 16;
            },
            0x76 => {
                std.debug.print("HALT\n", .{});
                self.pc +%= 1;
                self.cycles += 4;
                self.halt = true;
                return;
            },
            0xC3 => {
                // JP nn
                const hhll = self.fetchWord();
                self.pc = hhll;
                self.cycles += 10;
            },
            0xCD => {
                // CALL nn
                const nn = self.fetchWord();
                self.sp -%= 2;
                self.memory[self.sp] = @as(u8, @intCast(self.pc >> 8));
                self.sp -%= 1;
                self.memory[self.sp] = @as(u8, @intCast(self.pc & 0xFF));
                self.pc = nn;
                self.cycles += 17;
            },
            0xCE => {
                // ADC A, n
                const n = self.fetchByte();
                const carry = (self.f & 0x10) >> 4;
                const result = self.a + n + carry;
                self.f = 0;
                if (result > 0xFF) {
                    self.f |= 0x10;
                }
                if (result == 0) {
                    self.f |= 0x80;
                }
                self.a = @as(u8, @intCast(result & 0xFF));
                self.cycles += 7;
                self.pc +%= 2;
            },
            0xF9 => {
                // LD SP, HL
                self.sp = (@as(u16, self.h) << 8) | self.l;
                self.cycles += 6;
            },
            else => |code| {
                std.debug.panic("Unknown opcode: {0d: >3} {0X:0>2}", .{code});
            },
        }
    }

    pub fn dumpState(self: *Z80, alloc: Allocator) ![]const u8 {
        return try std.fmt.allocPrint(alloc, "[cpu] a={X:0>2} f={X:0>2} b={X:0>2} c={X:0>2} d={X:0>2} e={X:0>2} h={X:0>2} l={X:0>2} pc={X:0>4} sp={X:0>4}", .{ self.a, self.f, self.b, self.c, self.d, self.e, self.h, self.l, self.pc, self.sp });
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
