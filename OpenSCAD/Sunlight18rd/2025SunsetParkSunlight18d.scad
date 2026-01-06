include <BOSL2/std.scad>

n_scale = 1 / 159;
$fn = 60;
function foot(feet) = 12*INCH*feet;
function inch(inches) = INCH*inches;
base_width = foot(7) + inch(6);
base_height = foot(9) + inch(11);
base_length = foot(19);
box_length = base_length - foot(2);
box_height = foot(6) + inch(10);
box_width = base_width;

module trailer_box(size=[box_length, box_width, box_height]) {
    circle_offset = box_height / 6;
    echo(circle_offset);
    front_radius = box_height/2 + circle_offset;
    intersection() {
        union() {
            cube([box_length - front_radius, base_width, box_height], center=true);
            translate([(box_length-front_radius)/2, 0, -circle_offset])
            {
                xrot(90) {
                    cylinder(r=(front_radius), h=box_width, center=true);
                }
            }
        }
        cube([box_length *2, box_width, box_height], center=true);
    }
}

module a_trailer_box(anchor, spin, orient, size=[box_length, box_width, box_height]) {
    attachable(anchor, spin, orient, size=size) {
        trailer_box(size);
        children();
    }
}

module awning(size, roll_dia=inch(3), arm_width=inch(3)) {
    width=size[0];
    height=size[1];
    depth=size[2];
    left(width/2) xrot(90) cube(size=[arm_width,height,depth], center=true);
    right(width/2) xrot(90) cube(size=[arm_width,height,depth], center=true);
    up(height/2) yrot(90) cylinder(h=width, d=roll_dia, center=true);
}

module a_awning(anchor, spin, orient, size, roll_dia=inch(4), arm_width=inch(4)) {
  attachable(anchor, spin, orient, size=size) {
    awning(size=size, roll_dia=roll_dia, arm_width=arm_width);
    children();
  }
}

module trailer() {
    a_trailer_box() {
        attach(FRONT, BACK, align=CENTER) {
          back(foot(1.25)) down(foot(1.9))
          a_awning(size=[foot(12), foot(4), foot(0.25)]);
        }
        attach(LEFT, BACK, align=CENTER) {
          back(foot(1.25)) down(foot(4.15))
          a_awning(size=[box_width - inch(5), foot(4), foot(0.25)]);
        }
    }
}


scale(n_scale) {
    trailer();
    //a_awning(size=[foot(12),foot(4),foot(.5)]);
}