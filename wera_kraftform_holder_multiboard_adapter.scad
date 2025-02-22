include <multiboard.scad>

$fa = 1;
$fs = 1;

// --- CONFIGURATION START ---
// height and position of multiboard snap
snap_height = 11;
snap_pos_y = 24;
snap_pos_z = 5.4;

// default right adapter
left_adapter = 0;
// --- CONFIGURATION END ---

height = 6;
outer_wall_thickness = 1.5;
inner_wall_cutout_thickness = 2;

// inner
inner_thick_end_d = 35.7;
inner_step_l = 43;
inner_step_d = 2.5;
inner_offset_0 = 8.35;

inner_r = 10;
inner_l = 78.7;

inset_h = 4;
bottom_wall_h = 5;

inner_h = bottom_wall_h+inset_h;

inner_shape_offset_y = outer_wall_thickness+inner_wall_cutout_thickness;

// mid
mid_thick_end_d = 39.8;
mid_step_l = 45.8;
mid_step_d = 2.6;

mid_r = 12;

// outer 
outer_thick_end_d = inner_thick_end_d+2*outer_wall_thickness+2*inner_wall_cutout_thickness;
outer_length = 82;
outer_h = bottom_wall_h+8;
outer_step_l = mid_step_l+outer_wall_thickness;

outer_r = mid_r+outer_wall_thickness;

outer_polygon_points = [
    [0,0], 
    [0,outer_thick_end_d], 
    [outer_step_l,outer_thick_end_d], 
    [outer_step_l,outer_thick_end_d-mid_step_d], 
    [inner_l-inner_r,outer_thick_end_d-mid_step_d], 
    [inner_l-inner_r+3,outer_thick_end_d-mid_step_d-2*outer_r+0.33]
];


mirror([left_adapter,0,0]) {
    // inner shape
    translate([0,inner_shape_offset_y,(inner_h)/2]) {
        linear_extrude(height=inner_h, center=true) {
            union() {
                polygon([
                    [0,0],
                    [0,inner_thick_end_d],
                    [inner_step_l,inner_thick_end_d],
                    [inner_step_l,inner_thick_end_d-inner_step_d],
                    [inner_l-inner_r,inner_thick_end_d-inner_step_d],
                    [inner_l-inner_r+2.5,inner_thick_end_d-inner_step_d-2*inner_r+0.3]
                ]);

                translate([inner_l-inner_r,inner_thick_end_d-inner_step_d-inner_r,0]) {
                    circle(inner_r);
                }
            }
        }
    }

    difference() {
        // outer shape
        translate([0,0,outer_h/2]) {
            linear_extrude(height=outer_h, center=true) {
                union() {
                    polygon(outer_polygon_points);

                    translate([inner_l-inner_r,outer_thick_end_d-mid_step_d-outer_r,0]) {
                        circle(outer_r);
                    }
                }
            }
        }

        // mid shape
        translate([0,outer_wall_thickness,8]) {
            linear_extrude(height=20, center=true) {
                union() {
                    polygon([
                        [0,0], 
                        [0, mid_thick_end_d],
                        [mid_step_l,mid_thick_end_d],
                        [mid_step_l,mid_thick_end_d-mid_step_d],
                        [mid_step_l,mid_thick_end_d-mid_step_d],
                        [inner_l-inner_r,mid_thick_end_d-mid_step_d],
                        [inner_l-inner_r+2.6,mid_thick_end_d-mid_step_d-2*mid_r+0.28]
                    ]);

                    translate([inner_l-inner_r,mid_thick_end_d-mid_step_d-mid_r,0]) {
                        circle(mid_r);
                    }
                }
            }
        }

        // latch cutout
        translate([2/2,4/2+mid_thick_end_d,0])
        cube([2,4,40], center=true);
    }

    // bottom wall
    translate([0,0,bottom_wall_h/2]) {
        linear_extrude(height=bottom_wall_h, center=true) {
            union() {
                polygon(outer_polygon_points);

                translate([inner_l-inner_r,outer_thick_end_d-mid_step_d-outer_r,0]) {
                    circle(outer_r);
                }
            }
        }
    }
    translate([-snap_height/2, mb_snap_inner_octagon_width/2+snap_pos_y, mb_snap_inner_octagon_width/2+snap_pos_z]) {
        rotate([0,90,0]) {
            mb_snap_inner_octagon(snap_height);
        }
    }
}
