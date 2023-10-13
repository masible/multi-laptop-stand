// Framework Laptop Stand
//     A parametric stand to hold multiple Framework Laptop 13s,
//     or really any other laptop if you adjust the thickness.
//
// Copyright 2023 Framework Computer Inc <https://frame.work>
//     This work is licensed under a Creative Commons Attribution 4.0 
//     International License.

include <MCAD/boxes.scad>;
include <roundedcube.scad>;

width = 100;
height = 50;
wall = 5;
end = 15;
r = 15;
$fn = 128;

// For each laptop, add its thickness to the array
// FIXME the first thickness is used for all slots
laptop_thickness = [ 16, 16 ];

// No changes below this
num_laptops = len(laptop_thickness);

function add(v, i = 0, r = 0) = i < len(v) ? add(v, i + 1, r + v[i]) : r;
total_thickness = add(laptop_thickness);

difference() {
    // Rounded cube as the core structure to cut out
    translate([0, 0, -r]) roundedcube([width, end*2+wall+wall*num_laptops+total_thickness, height+r], false, r);
    
    // Make the bottom flat
    translate([0, 0, -r]) cube([width, end*2+wall+wall*num_laptops+total_thickness, r]);
    
    // Cut out the laptop slots
    for (i = [0:num_laptops-1]) {
        translate([0, end+wall + i*(laptop_thickness[0] + wall), wall]) cube([width, laptop_thickness[0], height]);
    }
    
    // Round the ends
    translate([0, 0, wall+r]) rotate([0, 90, 0]) cylinder(h = width, r = r);
    translate([0, 0, wall+r]) cube([width, r, height]);
    translate([0, end*2+wall+wall*num_laptops+total_thickness, wall+r]) rotate([0, 90, 0]) cylinder(h = width, r = r);
    translate([0, end+wall+wall*num_laptops+total_thickness, wall+r]) cube([width, r, height]);
}
