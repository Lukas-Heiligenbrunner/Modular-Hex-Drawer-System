diameter=53.2;
_flatSideDiam = (diameter / 2) * sqrt(3 / 4);

thickness = 2;
height= 87;

// config
seperators = 0;
middlesep=false;
bitHolder=true;

size=1;

if(size == 1) {
    linear_extrude(1) circle(d=diameter, $fn=6);
    linear_extrude(height) basehex();
    translate([0,0, height-1]) linear_extrude(1) circle(d=diameter, $fn=6);
    
    if(bitHolder) {
        rotate([0,0,30]) difference() {
            translate([-22, -12, 0]) cube([44, 15, height]);
            for (z =[9:13:height-5]) {
                xstep = 8;
                for (x = [0:xstep:(_flatSideDiam*2) - 10]) {
                    shift = (x % (xstep*2)) == 0 ? 6.5 : 0;
                    #translate([x + 7.5 - _flatSideDiam,-9, z + shift]) rotate([0, 90, 90]) rotate([0, 0, 30]) cylinder(h=12, d=(6.85 / sqrt(3/4)), $fn=6);
                }
                
            }
            
        }
    }


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
} else {
    linear_extrude(1) rotate([0,0,30]) circle(d=diameter, $fn=6);
    translate([0,0, height-1]) linear_extrude(1) rotate([0,0,30]) circle(d=diameter, $fn=6);
    
    linear_extrude(1) translate([-diameter+1, 0, 0]) rotate([0,0,30]) circle(d=diameter, $fn=6);
    translate([0,0, height-1]) linear_extrude(1) translate([-diameter+1, 0, 0]) rotate([0,0,30]) circle(d=diameter, $fn=6);
    linear_extrude(height) basehex2();
    
    translate([(-diameter/2)+ 0.5, 0, 0.5]) cube([6.5, 26.5, 1], center=true);
    translate([(-diameter/2)+ 0.5, 0, height -0.5]) cube([6.5, 26.5, 1], center=true);
    
    //#translate([(-diameter/2)+ 0.5, -13, height/2]) cube([8, 1, height], center=true);
    
    # linear_extrude(height) translate([-diameter/2 + 0.5, -13.4, 0])  polygon([[-5,0],[5,0], [3,1], [-3,1]]);
    
    translate([-diameter/2,0,-5]) rotate([90, 0, 0]) difference() {
        linear_extrude(5) rotate([0,0,0]) knobbody(w=40, d=12.5);
        linear_extrude(1) translate([0,1,0])  scale([.8,.8,1]) knobbody(w=40, d=12.5);
    };
}

module basehex2() {
    rotate([0,0,30]) difference() {
        circle(d=diameter, $fn=6);
        circle(d=diameter - thickness, $fn=6);
        translate([0,3 + _flatSideDiam - thickness,0]) square([diameter/2,6], center=true);
        rotate([0,0,-60]) translate([0,3 + _flatSideDiam - thickness,0]) square([diameter/2,6], center=true);
        rotate([0,0,60]) translate([0,3 + _flatSideDiam - thickness,0]) square([diameter/2,6], center=true);
    }
    
    translate([-diameter+1, 0, 0]) rotate([0,0,30]) difference() {
        circle(d=diameter, $fn=6);
        circle(d=diameter - thickness, $fn=6);
        translate([0,3 + _flatSideDiam - thickness,0]) square([diameter/2,6], center=true);
        rotate([0,0,-60]) translate([0,3 + _flatSideDiam - thickness,0]) square([diameter/2,6], center=true);
        rotate([0,0,-120]) translate([0,3 + _flatSideDiam - thickness,0]) square([diameter/2,6], center=true);
    }
}

module basehex() {
    difference() {
        circle(d=diameter, $fn=6);
        circle(d=diameter - thickness, $fn=6);
        #translate([0,3 + _flatSideDiam - thickness,0]) square([diameter/2,6], center=true);
        #rotate([0,0,60]) translate([0,3 + _flatSideDiam - thickness,0]) square([diameter/2,6], center=true);
    }
}

module knobbody(w=25, d=5) {
    hull() {
        #translate([-d,0,0]) circle(5, $fn=100);
        #translate([d,0,0]) circle(5, $fn=100);
        #translate([-w/2,5,0]) square([w, 1]);
    }
}


//polygon([[0,0], [1,0], [1,1]]);