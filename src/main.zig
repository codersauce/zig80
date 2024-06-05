const std = @import("std");

const Z80 = struct {
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
            .halt = false,
        };
    }

    // Fetch the next byte from memory
    fn fetchByte(self: *Z80) u8 {
        const byte = self.memory[self.pc];
        if (self.pc == 0xFFFF) {
            self.pc = 0;
        } else {
            self.pc += 1;
        }
        return byte;
    }

    // Fetch the next word (2 bytes) from memory
    fn fetchWord(self: *Z80) u16 {
        const lowByte: u8 = self.fetchByte();
        const highByte: u16 = self.fetchByte();
        return (highByte << 8) | lowByte;
    }

    // Execute a single instruction
    pub fn execute(self: *Z80) void {
        std.debug.print("pc: {any}\n", .{self.pc});
        const opcode = self.fetchByte();

        switch (opcode) {
            0x00 => {}, // NOP
            0x01 => {
                const nn = self.fetchWord();
                self.b = @as(u8, @intCast(nn >> 8));
                self.c = @as(u8, @intCast(nn & 0xFF));
            },
            0x76 => {
                std.debug.print("HALT\n", .{});
                self.halt = true;
                return;
            }, // HALT
            // Add more opcode implementations here
            else => |unknown| {
                std.debug.panic("Unknown opcode: {}", .{unknown});
            },
        }
    }

    pub fn run(self: *Z80) void {
        while (!self.halt) {
            self.execute();
        }
    }
};

pub fn main() void {
    var z80 = Z80.init();

    // Load a program into memory (example: NOP, LD BC,0x1234)
    z80.memory[0x0000] = 0x00;
    z80.memory[0x0001] = 0x01;
    z80.memory[0x0002] = 0x34;
    z80.memory[0x0003] = 0x12;
    z80.memory[0x0004] = 0x76;

    // Execute the loaded program
    z80.run();
}
