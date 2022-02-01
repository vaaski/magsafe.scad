/* [render quality] */

// set to true for final render
RENDER_QUALITY = false;

/* [main settings] */

// amount of magnets you have or want to use (+3 if you enable clocking)
MAGNET_COUNT = 40;  // [32:2:50]

// how deep the magnet holes are. if set to 0 they're flush. measured in layers
MAGNET_HOLE_DEPTH = 2;  // [0:4]

// enable/disable clocking magnets
CLOCK_ENABLE = true;

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
SEPARATION_LAYERS = 2; // [1:5]

module __Customizer_Limit__() {}

// set quality, 64 for testing, 128 for rendering
$fn = RENDER_QUALITY ? 128 : 64;

MAGNET_POSITIONS_COUNT = floor(MAGNET_COUNT / 2);
OVERLAP = 0.001;

EXTRA_HEIGHT = LAYER_HEIGHT * MAGNET_HOLE_DEPTH;

MAGSAFE_INNER_DIAMETER = 42;  // inner diameter of the magnetic ring
MAGSAFE_RING_GAP_DEG = 20;    // the gap on the side of the ring

CLOCK_MAGNETS = 3;
CLOCK_WIDTH = MAGNET_DIAMETER * (CLOCK_MAGNETS + 1);

BASEPLATE_HEIGHT = MAGNET_HEIGHT + OVERLAP + (LAYER_HEIGHT * SEPARATION_LAYERS);
BASEPLATE_RADIUS = MAGSAFE_INNER_DIAMETER / 2 + MAGNET_DIAMETER * 2.5;

N_HOLE_DIAM = MAGNET_DIAMETER;
N_HOLE_HEIGHT = MAGNET_HEIGHT + EXTRA_HEIGHT;
module n_hole(amount) {
  radius = N_HOLE_DIAM / 2;

  linear_extrude(N_HOLE_HEIGHT) {
    translate([ radius, 0, 0 ]) {
      // double offset is for smoothing of the intersection
      offset(-MAGNET_HOLE_ROUNDING) offset(MAGNET_HOLE_ROUNDING) {
        for (t = [0:amount - 1]) {
          translate([ t * N_HOLE_DIAM, 0, 0 ]) circle(radius);  // outer magnet
        }
      }
    }
  }
}

module ring(RING_RADIUS) {
  // degrees of the ring, minus gap
  ring_degrees_with_gap = 360 - MAGSAFE_RING_GAP_DEG;

  // degrees between magnets
  step_size = (360 - MAGSAFE_RING_GAP_DEG * 2) / MAGNET_POSITIONS_COUNT;

  // loop and distribute magnets around the ring
  for (r = [MAGSAFE_RING_GAP_DEG:step_size:ring_degrees_with_gap]) {
    rotate([ 0, 0, r ]) translate([ RING_RADIUS, 0, 0 ]) n_hole(2);
  }
}

module baseplate_ring() {
  difference() {
    // outer ring
    circle(BASEPLATE_RADIUS);

    // inner cutout
    circle(MAGSAFE_INNER_DIAMETER / 2 - MAGNET_DIAMETER * .5);
  }
}

module baseplate_clock() {
  translate([ -CLOCK_WIDTH / 2, -BASEPLATE_RADIUS - CLOCK_HEIGHT, 0 ]) {
    square([ CLOCK_WIDTH, CLOCK_HEIGHT ]);
  }
}

module baseplate() {
  roundness = 3;

  linear_extrude(BASEPLATE_HEIGHT + EXTRA_HEIGHT) {
    // smooth curve fillets hack
    offset(roundness) offset(roundness * -2) offset(roundness) {
      baseplate_ring();
      if (CLOCK_ENABLE) baseplate_clock();
    }
  }
}

module clock_magnets() {
  x_offset = (MAGNET_DIAMETER * CLOCK_MAGNETS) / -2;
  y_offset = -BASEPLATE_RADIUS - CLOCK_HEIGHT + MAGNET_DIAMETER;

  translate([ x_offset, y_offset, 0 ]) n_hole(3);
}

module magnet_cutouts() {
  // main circular magnet layout
  rotate(180) ring(MAGSAFE_INNER_DIAMETER / 2);

  if (CLOCK_ENABLE) clock_magnets();
}

module main() {
  difference() {
    baseplate();

    // move em up
    translate([ 0, 0, BASEPLATE_HEIGHT - MAGNET_HEIGHT + OVERLAP ]) {
      magnet_cutouts();
    }
  }
}

main();
