
// Halter für die Abschirmung zwischen PA und RX

// Resolution for 3D printing:
$fa = 1;
$fs = 0.4;

// Allgemeines:
delta                  =   0.1; // Standard Durchdringung

material_dicke         =   2.0;

querbalken_breite      =  45.0;
querbalken_dicke       =  material_dicke;
querbalken_hoehe       =  10.0;
querbalken_lochabstand =   5.0;

lasche_breite          =  12.0;
lasche_dicke           =  material_dicke;
lasche_hoehe           =  20.0;

halter_breite          =  material_dicke;
halter_dicke           =  20.0;
halter_hoehe           =  querbalken_hoehe;
halter_lochabstand     =   5.0;

loch_durchmesser       =   3.4;

verstaerkung_dx        =   5.0;
verstaerkung_dy        =   5.0;
verstaerkung_dz        =   1.5;

module loch() {
    cylinder(material_dicke + 4*delta, d=loch_durchmesser,
             center=true);
};

module lasche() {
    cube([lasche_breite, lasche_dicke,
          lasche_hoehe + delta]);
};

module querbalken_loch() {
    translate([0, material_dicke / 2 - delta, 0])
        rotate([90, 0, 0])
    loch();
};

module querbalken_loecher() {
    // Linkes Loch:
    translate([querbalken_lochabstand + loch_durchmesser/2,
              0, querbalken_hoehe/2])
        querbalken_loch();
    // Rechtes Loch:
    translate([querbalken_breite - 
              (querbalken_lochabstand + loch_durchmesser/2),
              0, querbalken_hoehe/2])
        querbalken_loch();
};

module querbalken() {
    difference() {
        cube([querbalken_breite,
              querbalken_dicke,
              querbalken_hoehe]);
        querbalken_loecher();
    };
};

module halter_loch() {
    translate([halter_breite / 2, 
              halter_lochabstand, 
              halter_hoehe / 2])
        rotate([0, 90, 0])
    loch();
};

module halter() {
    difference() {
        cube([halter_breite, halter_dicke + delta,
             halter_hoehe]);
        halter_loch();
    };
};

module dreieck(dim) {
    linear_extrude(height=dim.z, center=false)
        polygon(points=[[0, 0], [0, dim.x], [dim.y, 0]]); 
};

module verstaerkung() {
    dreieck([verstaerkung_dx + delta,
             verstaerkung_dy + delta,
             verstaerkung_dz]);
};

module bauteil() {
    // Lasche:
    translate([(querbalken_breite - lasche_breite) / 2,
              0, 0])
        lasche();
    // Querbalken:
    translate([0, 0, lasche_hoehe])
        querbalken();
    // Halter:
    translate([querbalken_breite - halter_breite,
              -halter_dicke +delta,
              lasche_hoehe])
        halter();
    // Versärkung oben:
    translate([querbalken_breite - halter_breite + delta,
               delta, querbalken_hoehe + lasche_hoehe -
               verstaerkung_dz])
        rotate([0, 0, 180])
            verstaerkung();
    // Versärkung unten:
    translate([querbalken_breite - halter_breite + delta,
               delta, lasche_hoehe])
        rotate([0, 0, 180])
            verstaerkung();
};

translate([0, 0, material_dicke])
    rotate([-90, 0, 0])
        bauteil();

