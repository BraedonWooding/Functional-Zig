# Functional-Zig
A library just adding a few functional commands.

## How to use

Just import the index like `const functional = @import("functional/index.zig");` and use like `functional.map(...)`.  When a package manager comes along it will be different :).

## Commands

Currently contains just the following commands;
- `map(function, list, buffer)` calls the function 'function' on each item in the list and outputs it to buffer.
  - Returns slice equal to elements placed in buffer.
- `mapAlloc(function, list, allocator)` same as map just takes an allocator instead of a buffer.
  - Returns slice equal to elements placed in buffer.
- `filter(function, list, buffer)` will only output to buffer if the function returns true.  
  - Returns slice equal to elements placed in buffer.
- `filterAlloc(function, list, buffer)` same as filter but takes an allocator instead of a buffer.
  - Returns slice equal to elements placed in buffer.
- `reduce(function, list)` calls the function with two list parameters at a time summing them up like `(((A)+B)+C)` kind of thing.
  - Returns the final state.