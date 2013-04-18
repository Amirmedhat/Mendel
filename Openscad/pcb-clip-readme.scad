// PRUSA Mendel  
// Endstop holder
// Used to attach endstops to 8mm rods
// GNU GPL v2
// Josef Průša
// josefprusa@me.com
// prusadjs.cz
// http://www.reprap.org/wiki/Prusa_Mendel
// http://github.com/prusajr/PrusaMendel

// Modified by Adrian to include support for sub-min microswitches and to make PCB mounts too. 15 May 2011

include <configuration.scad>

// Print four of the objects generated when pcb_mount is true, two of those generated
// when it is false and switch_add is 0, and one when it is false and switch_add is 11.

pcb_mount=true; // Set false for endstop
extrude_mount=false; // Set true for mini-extruder 
switch_add =0; // Set 0 for ordinary endstop, 11 for Z with adjuster

/**
 *@name Endstop holder
 *@using 1 m3x20
 *@using 1 m3nut
 *@using 2 m3washer
 */
module endstop(){
outer_diameter = m8_diameter/2+3.3;
screw_hole_spacing = 9.5; // Set to 20 to get standard design
opening_size = m8_diameter-1.5; //openingsize
switch_screw_hole_radius = 1.3; // Set to m3_diameter/2 to get standard design

translate([-outer_diameter, -outer_diameter, -5]) 
difference(){

	union()
	{
		if(extrude_mount)
		{
			translate([-outer_diameter/2-5, outer_diameter/2+2, -outer_diameter/2+3.75]) 
				cube([20,outer_diameter*2,4]);
		}
		translate([outer_diameter, outer_diameter, 0]) cylinder(h =10, r = outer_diameter, $fn = 20);
		translate([outer_diameter, 0, 0]) cube([15.5,outer_diameter*2,10]);
		if(pcb_mount){
  		translate([17, outer_diameter*2+1.9, 5]) rotate([90,0,0])
  		  rotate([0,0,0]) difference() {
  		    cylinder(r=10/sqrt(3),h=2,$fn=6);
  		    cylinder(r=5.8/sqrt(3),h=5,center=true,$fn=6);
  		  }
  		translate([17, -0.9, 5]) rotate([-90,0,0])
  		  cylinder(r1=3,r2=m3_diameter*1.1,h=2,center=true);
  	}
		if(!pcb_mount)
			translate([-42,0, 0]) cube([50, 4, 10]);
	}

//  		translate([17, outer_diameter*2+1.9, 5]) rotate([90,0,0])
//  		  rotate([0,0,30]) difference() {
//  		    cylinder(r=5.8/sqrt(3),h=5,center=true,$fn=6);
//  		  }
	// Chop the end just after the hole


	translate([-(56+screw_hole_spacing+ switch_screw_hole_radius+switch_add), -10, -10]) 
		cube([50, 50, 50]);

<<<<<<< HEAD:Openscad/endstop-holder-pcb-clip-readme.scad
	translate([9, outer_diameter-opening_size/2, 0]) cube([18,opening_size,22]);
	translate([outer_diameter, outer_diameter, 0]) cylinder(h =20, r = m8_diameter/2, $fn = 18);
=======
	translate([9, outer_diameter-opening_size/2, -0.1]) cube([18,opening_size,20]);
	translate([outer_diameter, outer_diameter, -0.1]) cylinder(h =20, r = m8_diameter/2, $fn = 18);
>>>>>>> dev-v1.1:Openscad/pcb-clip-readme.scad
	translate([17, 17, 5]) rotate([90, 0, 0]) cylinder(h =20, r = m3_diameter/2, $fn = 10);

	if(extrude_mount)
	{
		translate([-5, 11, -1]) cube([m3_diameter+0.3,7,20]);
	} else
	{
		translate([-4-switch_add, 17, 5]) rotate([90, 0, 0]) cylinder(h =20, r = 
			switch_screw_hole_radius, $fn = 10);
		translate([-(4+switch_add+screw_hole_spacing), 17, 5]) rotate([90, 0, 0]) cylinder(h =20, r = 
			switch_screw_hole_radius, $fn = 10);
	}
}
}
endstop();

