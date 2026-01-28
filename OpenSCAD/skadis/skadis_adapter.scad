include <ikea_skadis.scad>
include <BOSL2/std.scad>
include <BOSL2/screws.scad>

hardware="M2"; // ["M2", "M2.5", "M3"]

nut_spec = nut_info(hardware);
echo(hardware);
echo(tolerance);

module bridge() {
  union() {
    linear_extrude(4-tolerance) {
      difference() {
        union() {
          back(4)circle(r=2.5-tolerance/2);
          fwd(4)circle(r=2.5-tolerance/2);
        }
        square([5, 8 + tolerance], center=true);
      }
    }
    down(1-tolerance) {
      linear_extrude(1) {
        square([10, 19], center=true);
      }
    }
  }
}

module my_skadis_peg() {
  back(2.5) {
    back(2.5) cube([5-tolerance,10,5], center=true);
    back(5) down(3.5) cube([5-tolerance, 5,12], center=true);
  }
}

module bolt_on_hook(hardware=hardware) {
  difference() {
    union() {
      down(0) {
        my_skadis_peg();
      }
      fwd(1-tolerance) xrot(90) bridge();
    }
    union(){
      rotate([90,0,0]) cylinder(30, tolerance + nut_spec["diameter"]/2, center=true);
//      back(12.5)
//        rotate([90,90,0])
//          nut_trap_inline(4,hardware);
    }
  }
}
//my_skadis_peg();

bolt_on_hook(hardware);
