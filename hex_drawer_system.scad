////  Parameters ////
enableMountingHoles = true;

////  Constants ////
depth = 90;
diameter = 60;
mainFrameThickness = 3;

gripDepth = 1.75;
gripLength = 12;
gripWidth = 1;

$fn = 100;

_flatSideDiam = (diameter / 2) * sqrt(3 / 4);

size = 1;

//// Model ////
if (size == 1) {
    buildhexagon();
} else if (size == 2) {
    difference() {
        union() {
            buildhexagon();
            translate([calcXDist(60, diameter), -calcYDist(60, diameter), 0]) buildhexagon();
        }
        cutSide(60);
    }
} else if (size == 3) {
    difference() {
        buildhexagon();
        cutSide(0);
        cutSide(60);
    }

    translate([calcXDist(60, diameter), -calcYDist(60, diameter), 0])  difference() {
        buildhexagon();
        #cutSide(-120);
        //#cutSide(120);
    }


    translate([calcXDist(0, diameter), -calcYDist(0, diameter), 0]) buildhexagon();
    difference() {
        union() {

        }
//        translate([calcXDist(60, diameter + mainFrameThickness * 4) / 2, - calcYDist(60, diameter + mainFrameThickness * 4) / 2, 0])
//            rotate([0, 0, 60])
//                translate([- diameter / 4 + 1, 0, 3])
//                    cube([diameter / 2 - 2, mainFrameThickness * 4, depth]);
//
//        #translate([calcXDist(0, diameter + mainFrameThickness * 4) / 2, - calcYDist(0, diameter + mainFrameThickness * 4) / 2, 0])
//            rotate([0, 0, 0])
//                translate([- diameter / 4 + 1, 0, 3])
//                    cube([diameter / 2 - 2, mainFrameThickness * 4, depth]);
//
//        #translate([calcXDist(30, diameter + mainFrameThickness * 2) / 1, - calcYDist(30, diameter + mainFrameThickness * 2) / 1.5, 0])
//            rotate([0, 0, 120])
//                translate([- diameter / 4 + 1, 0, 3])
//                    cube([diameter / 2 - 2 + 10, mainFrameThickness * 4, depth]);
    }

}

module cutSide(angle) {
    translate([calcXDist(angle, diameter + mainFrameThickness*4)/2, -calcYDist(angle, diameter + mainFrameThickness*4)/2, 0])
        rotate([0,0,angle])
            translate([-diameter/4 +1,0,3])
                cube([diameter/2 - 2,mainFrameThickness*4,depth]);
}

function calcYDist(angle, length) = cos(angle) * length * sqrt(3 / 4);
function calcXDist(angle, length) = sqrt(length * length * 3 / 4 - calcYDist(angle,length) * calcYDist(angle, length));


////  Modules ////
module buildhexagon() {
    difference() {
        basebody();
        if (enableMountingHoles) {
            hole();
            rotate([0, 0, 180]) hole();
        }
    }
}

module basebody() {
    difference() {
        cylinder(d = diameter, h = depth, $fn = 6);
        translate([0, 0, 3]) cylinder(d = diameter - mainFrameThickness * 2, h = depth + 1, $fn = 6);
        cylinder(r = diameter / 2 - mainFrameThickness - 2.5, h = depth + 1, $fn = 6);

        translate([0, _flatSideDiam - gripDepth / 2 + .05, 0]) holders();
        rotate([0, 0, 120]) translate([0, _flatSideDiam - gripDepth / 2 + .05, 0]) holders();
        rotate([0, 0, 240]) translate([0, _flatSideDiam - gripDepth / 2 + .05, 0]) holders();
    }

    outerGripScale = 0.99;

    rotate([0, 0, 60]) translate([0, _flatSideDiam + gripDepth * outerGripScale / 2, 0]) rotate([0, 0, 180]) scale([outerGripScale, 0.99, 1]) holders();
    rotate([0, 0, 180]) translate([0, _flatSideDiam + gripDepth * outerGripScale / 2, 0]) rotate([0, 0, 180]) scale([outerGripScale, 0.99, 1]) holders();
    rotate([0, 0, 300]) translate([0, _flatSideDiam + gripDepth * outerGripScale / 2, 0]) rotate([0, 0, 180]) scale([outerGripScale, 0.99, 1]) holders();

    if (enableMountingHoles) {
        holeFrame();
        rotate([0, 0, 180]) holeFrame();
    }
}

module holders() {
    translate([- gripLength / 2, - gripDepth / 2, 0])
        linear_extrude(height = depth)
            polygon([[0, 0], [gripLength, 0], [gripLength - gripWidth, gripDepth], [gripWidth, gripDepth]]);
}

module holeFrame() {
    translate([diameter / 2 - mainFrameThickness - 5, 0, 0]) cylinder(r = 5, h = 3, $fn = 6);
}

module hole() {
    headdiam = 6.75;
    holediam = 3.25;

    translate([diameter / 2 - mainFrameThickness - 5, 0, 0]) cylinder(d = holediam, h = 3);
    translate([diameter / 2 - mainFrameThickness - 5, 0, 0.75]) cylinder(h = 2.25, d1 = holediam, d2 = headdiam);
}

