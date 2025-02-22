mb_snap_inner_octagon_width = 13.45;

module hexagon(ri, height) {
    ro = ri/sqrt(3);

    A = [-ro, 0];
    B = [-ro/2, ri/2];
    C = [ro/2, ri/2];
    D = [ro, 0];
    E = [ro/2, -ri/2];
    F = [-ro/2, -ri/2];

    linear_extrude(height=height, center=true) {
        polygon(points=[A, B, C, D, E, F]);
    }
}


module mb_snap_inner_octagon(height) {
    width = mb_snap_inner_octagon_width;

    intersection() {
        cube([width, width, height], center=true);

        rotate([0,0,45]) {
            cube([width, width, height], center=true);
        }
    }
}
