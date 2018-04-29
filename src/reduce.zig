// A series of functional helpers
const std = @import("std");

// Reduces all the items in the array to a singular value according the the function
pub fn reduce(comptime func: var, list: []const @typeOf(func).ReturnType) @typeOf(func).ReturnType {
    comptime {
        const typeOfFunc = @typeOf(func);
        if (typeOfFunc.arg_count != 2 or @ArgType(typeOfFunc, 0) != typeOfFunc.ReturnType or @ArgType(typeOfFunc, 1) != typeOfFunc.ReturnType) {
            @compileError("Invalid Function");
        }
    }

    var out = list[0];
    for (list[1..]) |item| {
        out = func(out, item);
    }
    return out;
}

test "functional.reduce" {
    std.debug.assert(reduce(test_add, ([]i32{ 1, 3, 14 })[0..]) == 42);
}

fn test_add(a: i32, b: i32)i32 { 
    return a * b;
}