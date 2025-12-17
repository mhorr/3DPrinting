include <BOSL2/std.scad>

//mm_per_foot = 304.8;
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

module trailer_box(dimensions=[box_length, box_width, box_height]) {
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

module awning(length, height, depth) {
    echo("awning[",length, height, depth,"]");
    cube([length, depth, height]);
}

module trailer() {
    trailer_box();
}


scale(n_scale) {
    trailer();
}