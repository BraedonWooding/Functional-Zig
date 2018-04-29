const filterSrc = @import("src/filter.zig");
const mapSrc = @import("src/map.zig");
const reduceSrc = @import("src/reduce.zig");

pub const filter = filterSrc.filter;
pub const filterAlloc = filterSrc.filterAlloc;

pub const map = mapSrc.map;
pub const mapAlloc = mapSrc.mapAlloc;

pub const reduce = reduceSrc.reduce;

test "Functional" {
    _ = @import("src/filter.zig");
    _ = @import("src/map.zig");
    _ = @import("src/reduce.zig");
}