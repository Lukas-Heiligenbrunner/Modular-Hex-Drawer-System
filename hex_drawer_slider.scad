diameter=53.2;
_flatSideDiam = (diameter / 2) * sqrt(3 / 4);

thickness = 2;
height= 87;

// config
seperators = 1;
middlesep=false;

module basehex() {
    difference() {
        circle(d=diameter, $fn=6);
        circle(d=diameter - thickness, $fn=6);
        #translate([0,3 + _flatSideDiam - thickness,0]) square([diameter/2,6], center=true);
        #rotate([0,0,60]) translate([0,3 + _flatSideDiam - thickness,0]) square([diameter/2,6], center=true);
    }
}
linear_extrude(1) circle(d=diameter, $fn=6);
linear_extrude(height) basehex();
translate([0,0, height]) linear_extrude(1) circle(d=diameter, $fn=6);

// add seperators
if(seperators > 0) {
    step = height/(seperators+1);
    
    for(i = [step:step:height-step]){
        translate([0,0, i]) linear_extrude(1) circle(d=diameter, $fn=6);
    } 
}

if(middlesep) {
    translate([0, 0, height/2]) rotate([0,0,120]) cube([diameter-1,1,height], center=true);
}

// add knob
translate([0,0,-5]) rotate([90, 0, 30]) difference() {
    linear_extrude(5) knobbody();
    linear_extrude(1) translate([0,1,0])  scale([.8,.8,1]) knobbody();
};

module knobbody() {
    hull() {
        translate([-5,0,0]) circle(5, $fn=100);
        translate([5,0,0]) circle(5, $fn=100);
        #translate([-12.5,5,0]) square([25, 1]);
    }
}


//polygon([[0,0], [1,0], [1,1]]);