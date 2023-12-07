$fn=100;
text="M3 Schrauben";
font="Liberation Sans:style=Bold";
depth=0.5;
height=10;
width=40;
fontsize=3.8;

label();
module label() {
    translate([-width/2, 0, 0]) cube([width, height, depth]);
    color("#7F7F7FFF") translate([0,(height-fontsize)/2,depth]) 
    linear_extrude(0.5) 
    text(text, size=fontsize, halign="center",font=font);
}

function getLabelHeight() = height;
function getLabelLength() = width;
function getLabelDepth() = depth;