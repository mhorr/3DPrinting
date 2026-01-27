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
        square([5, 8], center=true);
      }
    }
    down(2-tolerance) {
      linear_extrude(2) {
        square([5-tolerance, 15], center=true);
      }
    }
  }
}

module bolt_on_hook(hardware=hardware) {
  difference() {
    union() {
//      fwd(7.5 - tolerance) cube(5-tolerance, center=true);
      down(2.5) {
        skadis_peg();
      }
      fwd(5) xrot(90) bridge();
    }
    union(){
      rotate([90,0,0]) cylinder(30, tolerance + nut_spec["diameter"]/2, center=true);
      back(10)
        rotate([90,90,0])
          nut_trap_inline(4,hardware);
    }
  }
}

bolt_on_hook(hardware);
