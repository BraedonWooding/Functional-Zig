// A series of functional helpers
const std = @import("std");

// Returns a new array including items only where the filter function returned true
pub fn filter(comptime func: var, list: []const @ArgType(@typeOf(func), 0), buffer: []@ArgType(@typeOf(func), 0)) []@ArgType(@typeOf(func), 0) {
    comptime {
        if (@typeOf(func).arg_count != 1 or @typeOf(func).ReturnType != bool) {
            @compileError("Invalid Function");
        }
    }
    // You have to be prepared that the reduce will match all
    std.debug.assert(buffer.len >= list.len);
    var count : usize = 0;
    for (list) |item, i| {
        if (func(item)) {
            buffer[count] = item;
            count += 1;
        }
    }
    return buffer[0..count];
}

// Returns a new array including items only where the filter function returned true
// You have to free the result
pub fn filterAlloc(comptime func: var, list: []const @ArgType(@typeOf(func), 0), allocator: &std.mem.Allocator) ![]@ArgType(@typeOf(func), 0) {
    // We can't know how much to allocate so we will over allocate
    // Then shrink to prevent annoyance for developer
    var buf = try allocator.alloc(@ArgType(@typeOf(func), 0), list.len);
    var out = filter(func, list, buf);
    // Actual size we needed
    return allocator.shrink(@ArgType(@typeOf(func), 0), buf, out.len);
}

test "functional.filter" {
    var direct_allocator = std.heap.DirectAllocator.init();
    defer direct_allocator.deinit();
    std.debug.assert(std.mem.eql(i32, try filterAlloc(test_is_even, ([]i32{ 1, 4, 5, 2, 8 })[0..], &direct_allocator.allocator), []i32{ 4, 2, 8 }));
}

fn test_is_even(a: i32)bool {
    return @rem(a, 2) == 0;
}