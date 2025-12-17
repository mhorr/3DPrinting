mm_per_foot = 304.8;
n_scale = 1 / 159;
$fn = 60;
function foot(feet) = feet * mm_per_foot;
function inch(inches) = foot(inches/12);
base_width = foot(7) + inch(6);
base_height = foot(9) + inch(11);
base_length = foot(19);
box_length = base_length - foot(2);
box_height = foot(6) + inch(10);
scale([n_scale, n_scale, n_scale]) {
    front_radius = box_height/2 + foot(1);
    intersection() {
    union() {
    cube([box_length - front_radius, base_width, box_height], center=true);
    translate([((box_length-front_radius)/2),0,-foot(1)]) {
        rotate([90,0,0]) {
            cylinder(r=(front_radius), h=base_width, center=true);
        }
    }
    }
    cube([box_length *2, base_width, box_height], center=true);
}
}

