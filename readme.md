<h1 align="center">magsafe attach plate</h1>

<div align="center">
  <a href="https://cadhub.xyz/draft/openscad#fetch_text_v1=https%3A%2F%2Fraw.githubusercontent.com%2Fvaaski%2Fscad-magsafe%2Fmain%2Fmagsafe.scad">
    <img src="https://raw.githubusercontent.com/vaaski/scad-magsafe/main/render.png" />
  </a>
</div>

## how to use

there's a pre-rendered [`magsafe.stl`](https://github.com/vaaski/scad-magsafe/raw/main/magsafe.stl) (shown above) using default settings, but you can customize it using openSCAD.

if you don't wan't to download openSCAD, you can use web-based [cadhub](https://cadhub.xyz/draft/openscad#fetch_text_v1=https%3A%2F%2Fraw.githubusercontent.com%2Fvaaski%2Fscad-magsafe%2Fmain%2Fmagsafe.scad) instead.

## parameters
- `RENDER_QUALITY`: set to true for final render quality

- `MAGNET_COUNT`: amount of magnets you have or want to use (+3 if you enable clocking)

- `MAGNET_HOLE_DEPTH`: how deep the magnet holes are. if set to 0 they're flush. measured in layers

- `CLOCK_ENABLE`: enable/disable clocking magnets

- `CLOCK_HEIGHT`: how long the clocking part should be

- `MAGNET_HEIGHT`, `MAGNET_DIAMETER`: magnet dimensions, i strongly recommend 4x2 mm

- `MAGNET_HOLE_ROUNDING`: amount of rounding between magnets, 0.75 is fine

- `LAYER_HEIGHT`: 3d printer layer height

- `SEPARATION_LAYERS`: layers between the magnets and the phone
