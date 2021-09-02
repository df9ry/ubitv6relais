
// Halterung für größeres RX/TX Umschaltrelais für uBit-V6

// Resolution for 3D printing:
$fa = 1;
$fs = 0.4;

// Allgemeines:
delta                  =   0.1; // Standard Durchdringung

relais_laenge          =  29.0;
relais_breite          =  12.6;
relais_grund           =   4.0;

luft                   =   5.0; // Wo die Verdrahtung ist

wand_dicke             =   1.0;
einrueckung            =   0.5;

module verjuengung() {
        cube([einrueckung, 
              relais_breite + 2*wand_dicke + 2*delta,
              luft - wand_dicke + delta]);
}

module innen() {
    // Oberer Rahmen
    translate([wand_dicke, wand_dicke, luft])
        cube([relais_laenge,
              relais_breite,
              relais_grund + delta]);
    // Unten Verdrahtungsbereich
    translate([wand_dicke + einrueckung,
               wand_dicke + einrueckung,
               -delta])
        cube([relais_laenge - 2*einrueckung,
              relais_breite - 2*einrueckung,
              luft + 2*delta]);
    // Seitliche Öffnung
    translate([wand_dicke + einrueckung,
               -delta, -delta])
        cube([relais_laenge - 2*einrueckung,
              relais_breite + 2*wand_dicke + 2*delta,
              luft - wand_dicke + delta]);
    // Verjuengung links
    translate([-delta, -delta, -delta])
        verjuengung();
    // Verjuengung rechts
    translate([relais_laenge + 2*wand_dicke - einrueckung
               + delta,-delta, -delta])
            verjuengung();
};

module bauteil() {
    difference() {
        cube([relais_laenge + 2*wand_dicke,
              relais_breite + 2*wand_dicke,
              relais_grund + luft]);
        innen();
    };
};

translate([0,
           relais_breite + 2*wand_dicke,
           luft + relais_grund])
    rotate([180, 0, 0])
        bauteil();