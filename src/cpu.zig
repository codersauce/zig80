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

    pub fn reset(self: *Z80) void {
        self.a = 0;
        self.f = 0;
        self.b = 0;
        self.c = 0;
        self.d = 0;
        self.e = 0;
        self.h = 0;
        self.l = 0;
        self.pc = 0;
        self.sp = 0xFFFF;
        self.halt = false;
        self.clearMemory();
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
        std.debug.print("Running for {d} cycles\n", .{cycles});
        var current_cycle: u64 = 0;
        while (!self.halt and current_cycle < cycles) {
            self.execute();
            current_cycle += 1;
        }
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
            0x0A => {
                self.a = self.fetchByteFromBC();
                self.pc += 7;
            },
            // Add more opcode implementations here
            else => |unknown| {
                std.debug.panic("Unknown opcode: {}", .{unknown});
            },
        }
    }

    pub fn dumpRegisters(self: *Z80, alloc: Allocator) ![]const u8 {
        return try std.fmt.allocPrint(alloc, "a={d} f={d} b={d} c={d} d={d} e={d} h={d} l={d} pc={d} sp={d}", .{ self.a, self.f, self.b, self.c, self.d, self.e, self.h, self.l, self.pc, self.sp });
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
