
// Halter für die Abschirmung zwischen PA und RX

// Resolution for 3D printing:
$fa = 1;
$fs = 0.4;

// Allgemeines:
delta                  =   0.1; // Standard Durchdringung

holder_width           =   2.0;
holder_height          =   2.0;

slit_width             =   0.5;

holder1                =  75.0;
holder2                =  65.0;
holder3                =  35.0;

module holder(l) {
    difference() {
        cube([holder_width, l, holder_height]);
        translate([(holder_width - slit_width) / 2,
                   -delta,
                   holder_height / 3])
            cube([slit_width, l + 2*delta, holder_height]);
    };
};

holder(holder1);

translate([2*holder_width, 0, 0])
    holder(holder2);

translate([4*holder_width, 0, 0])
    holder(holder3);
