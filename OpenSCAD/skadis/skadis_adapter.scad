include <ikea_skadis.scad>
include <BOSL2/std.scad>
include <BOSL2/screws.scad>

hardware="M3"; // ["M2", "M2.5", "M3"]

nut_spec = nut_info("M3");
echo(nut_spec);
difference() {
    skadis_peg();
    translate([0,10, 3])
        rotate([90,90,0])
            nut(hardware);
}