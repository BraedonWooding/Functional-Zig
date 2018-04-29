// A series of functional helpers
const std = @import("std");

// Maps all of an arrays items to a function
// Returning the composition of each item with the function as a new array
pub fn map(comptime func: var, list: []const @ArgType(@typeOf(func), 0), buffer: []@typeOf(func).ReturnType) []@typeOf(func).ReturnType {
    comptime {
        if (@typeOf(func).arg_count != 1) {
            @compileError("Invalid Function");
        }
    }
    std.debug.assert(buffer.len >= list.len);

    for (list) |item, i| {
        buffer[i] = func(item);
    }
    return buffer[0..list.len];
}

// Maps all of an arrays items to a function
// Returning the composition of each item with the function as a new array
// You have to free the result
pub fn mapAlloc(comptime func: var, list: []const @ArgType(@typeOf(func), 0), allocator: &std.mem.Allocator) ![]@typeOf(func).ReturnType {
    var buf = try allocator.alloc(@typeOf(func).ReturnType, list.len);
    return map(func, list, buf);
}

test "functional.map" {
    var direct_allocator = std.heap.DirectAllocator.init();
    defer direct_allocator.deinit();
    std.debug.assert(std.mem.eql(i32, try mapAlloc(test_pow, ([]i32{ 1, 4, 5, 2, 8 })[0..], &direct_allocator.allocator), []i32{ 1, 16, 25, 4, 64 }));
}

fn test_pow(a: i32) i32 {
    return a * a;
}