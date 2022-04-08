DIAMETER=16;
X_LENGTH=1500;
Z_LENGTH=1300;
Y_LENGTH=500;
CORNER=800;
COLOUR="blue";
JOINT=20;
ANGLE=30;
X_CUT=CORNER*sin(ANGLE);
Z_CUT=CORNER*cos(ANGLE);
P_LENGTH=Y_LENGTH+500;
P_WIDTH=150;
P_HEIGHT=100;
GROUND_LENGTH=Y_LENGTH+700;

translate([0,0,300]) rotate([20,10,0]) plug();

module plug(){
frame();
    translate([-400,0,200]) prong(length=P_LENGTH);
    translate([+400,0,200]) prong(length=P_LENGTH);
    translate([0,0,1000]) rotate([0,90,0]) prong(length=GROUND_LENGTH);
}

//tube(length=500,cutA=10,cutB=45);

module tube(length,colour=COLOUR,cutA=0,cutB=0,center=false){
    echo(length)
    if (center==true) {
        color (colour) translate([0,0,-length/2]) difference(){
            cylinder(d=DIAMETER, h=length,center=false);
            translate([0,0,abs(tan(cutA)*DIAMETER/2)]) rotate([cutA,0,0]) translate([0,0,-DIAMETER*2]) cube([DIAMETER*4,DIAMETER*4,DIAMETER*4],center=true);
            translate([0,0,length-(abs(tan(cutB)*DIAMETER/2))]) rotate([cutB,0,0]) translate([0,0,DIAMETER*2]) cube([DIAMETER*4,DIAMETER*4,DIAMETER*4],center=true);
        }
    }
    else {
        color (colour) difference(){
            cylinder(d=DIAMETER, h=length,center=false);
            translate([0,0,abs(tan(cutA)*DIAMETER/2)]) rotate([cutA,0,0]) translate([0,0,-DIAMETER*2]) cube([DIAMETER*4,DIAMETER*4,DIAMETER*4],center=true);
            translate([0,0,length-(abs(tan(cutB)*DIAMETER/2))]) rotate([cutB,0,0]) translate([0,0,DIAMETER*2]) cube([DIAMETER*4,DIAMETER*4,DIAMETER*4],center=true);
        }
    }
}
module frame(){
    // Base
    translate([0,0,0]) rotate([0,90,0]) tube(X_LENGTH-JOINT*2,center=true);
    translate([0,-Y_LENGTH,0]) rotate([0,90,0]) tube(X_LENGTH-JOINT*2,center=true);
    translate([-X_LENGTH/2,-Y_LENGTH/2,0]) rotate([90,0,0]) tube(Y_LENGTH-JOINT*2,center=true);
    translate([+X_LENGTH/2,-Y_LENGTH/2,0]) rotate([90,0,0]) tube(Y_LENGTH-JOINT*2,center=true);

    // Sides
    translate([+X_LENGTH/2,0,JOINT]) rotate([0,0,0]) tube(Z_LENGTH-JOINT*2-Z_CUT,center=false);
    translate([+X_LENGTH/2,-Y_LENGTH,JOINT]) rotate([0,0,0]) tube(Z_LENGTH-JOINT*2-Z_CUT,center=false);
    translate([-X_LENGTH/2,0,JOINT]) rotate([0,0,0]) tube(Z_LENGTH-JOINT*2-Z_CUT,center=false);
    translate([-X_LENGTH/2,-Y_LENGTH,JOINT]) rotate([0,0,0]) tube(Z_LENGTH-JOINT*2-Z_CUT,center=false);
    
    translate([-X_LENGTH/2,-Y_LENGTH/2,Z_LENGTH-Z_CUT]) rotate([90,0,0]) tube(Y_LENGTH-JOINT*2,center=true);
    translate([+X_LENGTH/2,-Y_LENGTH/2,Z_LENGTH-Z_CUT]) rotate([90,0,0]) tube(Y_LENGTH-JOINT*2,center=true);

    // Top
    translate([0,0,Z_LENGTH]) rotate([0,90,0]) tube(X_LENGTH-JOINT*2-X_CUT*2,center=true);
    translate([0,-Y_LENGTH,Z_LENGTH]) rotate([0,90,0]) tube(X_LENGTH-JOINT*2-X_CUT*2,center=true);
    translate([-(X_LENGTH/2-X_CUT),-Y_LENGTH/2,Z_LENGTH]) rotate([90,0,0]) tube(Y_LENGTH-JOINT*2,center=true);
    translate([+(X_LENGTH/2-X_CUT),-Y_LENGTH/2,Z_LENGTH]) rotate([90,0,0]) tube(Y_LENGTH-JOINT*2,center=true);

    // ANGLE
    translate([+(X_LENGTH/2-X_CUT/2),-Y_LENGTH, Z_LENGTH-Z_CUT/2]) rotate([0,-ANGLE,0]) tube(CORNER-JOINT*2,center=true);
    translate([+(X_LENGTH/2-X_CUT/2),0        , Z_LENGTH-Z_CUT/2]) rotate([0,-ANGLE,0]) tube(CORNER-JOINT*2,center=true);
    translate([-(X_LENGTH/2-X_CUT/2),-Y_LENGTH, Z_LENGTH-Z_CUT/2]) rotate([0,+ANGLE,0]) tube(CORNER-JOINT*2,center=true);
    translate([-(X_LENGTH/2-X_CUT/2),0        , Z_LENGTH-Z_CUT/2]) rotate([0,+ANGLE,0]) tube(CORNER-JOINT*2,center=true);
}

module prong(length){
    translate([+P_WIDTH/2,-Y_LENGTH,0       ]) rotate([-90,0,0]) rotate([0,0,- 45]) tube(length-P_HEIGHT/2+((DIAMETER/2)/tan(90-22.5)),center=false,colour="yellow",cutB=22.5);
    translate([-P_WIDTH/2,-Y_LENGTH,0       ]) rotate([-90,0,0]) rotate([0,0,+ 45]) tube(length-P_HEIGHT/2+((DIAMETER/2)/tan(90-22.5)),center=false,colour="yellow",cutB=22.5);
    translate([+P_WIDTH/2,-Y_LENGTH,P_HEIGHT]) rotate([-90,0,0]) rotate([0,0,-135]) tube(length-P_HEIGHT/2+((DIAMETER/2)/tan(90-22.5)),center=false,colour="yellow",cutB=22.5);
    translate([-P_WIDTH/2,-Y_LENGTH,P_HEIGHT]) rotate([-90,0,0]) rotate([0,0,+135]) tube(length-P_HEIGHT/2+((DIAMETER/2)/tan(90-22.5)),center=false,colour="yellow",cutB=22.5);

    translate([+P_WIDTH/2,(length-P_HEIGHT/2-Y_LENGTH),0       ]) rotate([-45,- 45,0]) translate([0,0,-(sin(22.5)*DIAMETER/2)]) tube(P_HEIGHT,center=false,colour="yellow",cutA=-22.5,cutB=22.5);
    translate([-P_WIDTH/2,(length-P_HEIGHT/2-Y_LENGTH),0       ]) rotate([-45,+ 45,0]) translate([0,0,-(sin(22.5)*DIAMETER/2)]) tube(P_HEIGHT,center=false,colour="yellow",cutA=-22.5,cutB=22.5);
    translate([+P_WIDTH/2,(length-P_HEIGHT/2-Y_LENGTH),P_HEIGHT]) rotate([-45,-135,0]) translate([0,0,-(sin(22.5)*DIAMETER/2)]) tube(P_HEIGHT,center=false,colour="yellow",cutA=-22.5,cutB=22.5);
    translate([-P_WIDTH/2,(length-P_HEIGHT/2-Y_LENGTH),P_HEIGHT]) rotate([-45,+135,0]) translate([0,0,-(sin(22.5)*DIAMETER/2)]) tube(P_HEIGHT,center=false,colour="yellow",cutA=-22.5,cutB=22.5);

    translate([0,length-Y_LENGTH+DIAMETER,P_HEIGHT/2]) rotate([0,90,0]) tube(P_WIDTH-(P_HEIGHT*sin(45))-DIAMETER,center=true,colour="yellow");
    
}