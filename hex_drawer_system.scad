depth=50;
diameter=40;
mainFrameThickness=3;

$fn=100;

enableMountingHoles=false;

difference() {
    basebody();
    if(enableMountingHoles) {
        hole();
        rotate([0,0,180]) hole();
    }
}



module basebody() {
    difference() {
        cylinder(d=diameter, h=depth, $fn=6);
        translate([0,0,3]) cylinder(d=diameter-mainFrameThickness*2, h=depth + 1, $fn=6);
        cylinder(r=diameter/2-mainFrameThickness-2.5, h=depth + 1, $fn=6);
        
        translate([0, 16.45, 0]) holders();
        rotate([0,0,120]) translate([0, 16.45, 0]) holders();
        rotate([0,0,240]) translate([0, 16.45, 0]) holders();
    }
    
    rotate([0,0,60]) translate([0, 18.18, 0]) rotate([0,0,180]) scale([0.99,0.99,1]) holders();
rotate([0,0,180]) translate([0, 18.18, 0]) rotate([0,0,180]) scale([0.99,0.99,1]) holders();
rotate([0,0,300]) translate([0, 18.18, 0]) rotate([0,0,180]) scale([0.99,0.99,1]) holders();
    
    if(enableMountingHoles) {
        holeFrame();
        rotate([0,0,180]) holeFrame();
    }
}

module holders() {
    width=12;
    gripWidth=1;
    gripDepth=1.75;
    translate([-width/2, -gripDepth/2, 0])
    linear_extrude(height=depth)
    polygon([[0,0], [width, 0], [width-gripWidth, gripDepth], [gripWidth, gripDepth]]);
}

module holeFrame() {
    translate([diameter/2- mainFrameThickness - 5, 0, 0]) cylinder(r=5, h=3, $fn=6);
}

module hole() {
    headdiam=6.75;
    holediam=3.25;
    
    translate([diameter/2- mainFrameThickness - 5, 0, 0]) cylinder(d=holediam, h=3);
    translate([diameter/2- mainFrameThickness - 5, 0, 0.75]) cylinder(h=2.25, d1=holediam, d2=headdiam);
}
