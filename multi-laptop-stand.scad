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

// Designed for the Framework Laptop 13, but you can adjust to whatever.
framework_laptop_13 = 16;
// You can specify the number of laptops you want to hold.
num_laptops = 2;

difference() {
    // Rounded cube as the core structure to cut out
    translate([0, 0, -r]) roundedcube([width, end*2+wall+wall*num_laptops+framework_laptop_13*num_laptops, height+r], false, r);
    
    // Make the bottom flat
    translate([0, 0, -r]) cube([width, end*2+wall+wall*num_laptops+framework_laptop_13*num_laptops, r]);
    
    // Cut out the laptop slots
    for (i = [0:num_laptops-1]) {
        translate([0, end+wall + i*(framework_laptop_13 + wall), wall]) cube([width, framework_laptop_13, height]);
    }
    
    // Round the ends
    translate([0, 0, wall+r]) rotate([0, 90, 0]) cylinder(h = width, r = r);
    translate([0, 0, wall+r]) cube([width, r, height]);
    translate([0, end*2+wall+wall*num_laptops+framework_laptop_13*num_laptops, wall+r]) rotate([0, 90, 0]) cylinder(h = width, r = r);
    translate([0, end+wall+wall*num_laptops+framework_laptop_13*num_laptops, wall+r]) cube([width, r, height]);
}
