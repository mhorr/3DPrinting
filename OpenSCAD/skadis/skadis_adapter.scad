include <ikea_skadis.scad>
include <BOSL2/std.scad>
include <BOSL2/screws.scad>

hardware="M2"; // ["M2", "M2.5", "M3"]

nut_spec = nut_info(hardware);
echo(hardware);
echo(tolerance);
difference() {
    down(2.5) #skadis_peg();
    rotate([90,0,0]) cylinder(30, tolerance + nut_spec["diameter"]/2, center=true);
    back(10)
        rotate([90,90,0])
            nut_trap_inline(4,hardware);
}