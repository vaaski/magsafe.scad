include <./magsafe.scad>

/* [main settings] */

// amount of magnets you have or want to use (+3 if you enable clocking)
MAGNET_COUNT = 40;  // [32:2:50]

// how deep the magnet holes are. if set to 0 they're flush. measured in layers
MAGNET_HOLE_DEPTH = 2;  // [0:4]

// enable/disable clocking magnets, don't use it right now, it's too weak with only 3 TODO: add more
CLOCK_ENABLE = false;

// how long the clocking part should be
CLOCK_HEIGHT = 12;  // [10:1:17]

/* [magnet dimensions] */

// magnet dimensions, i strongly recommend 4x2 mm
MAGNET_HEIGHT = 2;
MAGNET_DIAMETER = 4;

// amount of rounding between magnets, 0.75 is fine
MAGNET_HOLE_ROUNDING = 0.75;  // [0.25:0.25:1]

/* [print stuff] */

// 3d printer layer height
LAYER_HEIGHT = 0.2;

// layers between the magnets and the phone
SEPARATION_LAYERS = 2;  // [1:5]

module __Customizer_Limit__() {}

// set quality, 64 for testing, 128 for rendering
$fn = $preview ? 64 : 128;
// overlap only for preview, cus it tends to get glitchy
OVERLAP = $preview ? 0.001 : 0;

MAGNET_POSITIONS_COUNT = floor(MAGNET_COUNT / 2);

EXTRA_HEIGHT = LAYER_HEIGHT * MAGNET_HOLE_DEPTH;

MAGSAFE_INNER_DIAMETER = 42;  // inner diameter of the magnetic ring
MAGSAFE_RING_GAP_DEG = 20;    // the gap on the side of the ring

CLOCK_MAGNETS = 3;
CLOCK_WIDTH = MAGNET_DIAMETER * (CLOCK_MAGNETS + 1);

BASEPLATE_HEIGHT = MAGNET_HEIGHT + OVERLAP + (LAYER_HEIGHT * SEPARATION_LAYERS);
BASEPLATE_RADIUS = MAGSAFE_INNER_DIAMETER / 2 + MAGNET_DIAMETER * 2.5;

N_HOLE_DIAM = MAGNET_DIAMETER;
N_HOLE_HEIGHT = MAGNET_HEIGHT + EXTRA_HEIGHT;

main();
// ----

THING_HEIGHT = 9.55;
THING_UPPER_DIAMETER = 25;
EXTENDED_PART_WALL_WIDTH = 2;

translate([0, 0, BASEPLATE_HEIGHT + EXTRA_HEIGHT - OVERLAP]) difference() {
  linear_extrude(THING_HEIGHT + EXTENDED_PART_WALL_WIDTH)
  circle(d = MAGSAFE_INNER_DIAMETER - MAGNET_DIAMETER + EXTENDED_PART_WALL_WIDTH * 2);

  translate([0, 0, -OVERLAP]) union() {
    linear_extrude(THING_HEIGHT)
    circle(d = MAGSAFE_INNER_DIAMETER - MAGNET_DIAMETER);

    linear_extrude(THING_HEIGHT + EXTENDED_PART_WALL_WIDTH + OVERLAP * 2)
    circle(d = THING_UPPER_DIAMETER);
  }
}
