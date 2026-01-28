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
        square([5-tolerance, 20], center=true);
      }
    }
  }
}

module my_skadis_peg(hook=true, nub=true) {
  back(2.5) {
    if (nub || hook) {
      back(2.5) cube([5-tolerance,10,5], center=true);
    }
    if (hook) {
      back(5) down(3.5) cube([5-tolerance, 5,12], center=true);
    }
  }
}

module bolt_on_hook(hardware=hardware, hook=true, nub=false) {
  difference() {
    union() {
      my_skadis_peg(hook, nub);
      fwd(1-tolerance) xrot(90) bridge();
    }
    rotate([90,0,0]) cylinder(30, tolerance + nut_spec["diameter"]/2, center=true);
  }
}

bolt_on_hook(hardware, hook=true);
down(20) bolt_on_hook(hardware, hook=false);

right(20) {
bolt_on_hook(hardware, hook=false);
down(20) bolt_on_hook(hook=true);
}