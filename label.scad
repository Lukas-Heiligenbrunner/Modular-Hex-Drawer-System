$fn=100;
text="Magneten";
font="Liberation Sans:style=Bold";
depth=0.5;
height=10;
width=40;
fontsize=4.5;

width_tol = width - 0.6;
height_tol = height - 0.6;

label();
module label() {
    translate([-width_tol/2, 0, 0]) cube([width_tol, height_tol, depth]);
    color("#7F7F7FFF") translate([0,(height_tol-fontsize)/2,depth]) 
    linear_extrude(0.5) 
    text(text, size=fontsize, halign="center",font=font);
}

function getLabelHeight() = height;
function getLabelLength() = width;
function getLabelDepth() = depth;