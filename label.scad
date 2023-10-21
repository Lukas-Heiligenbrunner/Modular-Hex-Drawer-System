$fn=100;
text="M3 Schrauben";
font="Liberation Sans:style=Bold";
depth=0.5;
heigth=10;
width=40;
fontsize=3.8;

label();
module label() {
    translate([0,0,0]) difference() {
        union(){
            translate([-width/2, 0, 0]) cube([width, heigth, depth]);
            color("#7F7F7FFF") translate([0,(heigth-fontsize)/2,depth]) 
            linear_extrude(0.5) 
            text(text, size=fontsize, halign="center",font=font);
        }
        #mountholes();
    }
}


module mountholes() {
    holeheigth=3;
    _heigthPos=(heigth/2) - holeheigth/2;
    translate([-width/2 + 1, _heigthPos, 0]) cube([1,holeheigth,1]);
    translate([-width/2 + 0.5, _heigthPos, 1]) cube([1.5,holeheigth,0.5]);
    translate([width/2 - 2, _heigthPos, 0]) cube([1,3,1]);
}