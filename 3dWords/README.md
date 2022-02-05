
# 3dWords

Script to automate creation of 3D words for Panda3d Engine.

It uses Blender to make the model (text-mesh-extrude-bevel-add material), export it to a temp DAE file, then make DAE to EGG and EGG to BAM conversion.

## Usage:

```
blender -b -P 3dWords.py -- "<word>"
```

You will need a "font.ttf" file in current dir. Provided one is a copy of sansbold.ttf distributed with Debian Bullseye. Any ttf will work, ensure if replacing use one with Extended ASCII characters (ñ, á, ü, etc)

Resulting file will be created as "out/word.bam" file. One "sample.bam" is provided for testing. 

## Requirements

- Blender > 2.9
- dae2egg
- egg2bam

## Configuration

On top of script file are the following defined default values:

- char_spacing = separation between ward letters (default: 1.2)
- font_extrude = heigh of mesh characters (default: 0.06)
- font_bevel = bevel curve (default: 0.05)
- model_color = Blender "Principled BSDF" Base Color RGBA value (default: 0,0,1,1 (blue) )

## About Model Material

As far as I have read in documentation about DAE specifications (used in blender-DAE-egg-bam process) and Panda3d Material Support, the only safe lighthing shading when using materials is to have a basic "Principled BSDF" material type in Blender using only defined Base Color. Using PNG/JPG textures results in dark no-iluminated shapes. If anyone have made Blender-BAM (or Blender-EGG) conversions and more complex materials have worked I will apreciate very much any tip about it.

Fixed blue color has been defined in code and of course may be changed for any other RGBA values.

## TODO

Make a clean install of Panda3d and test dependencies.

Make a INSTALL section.

## ABOUT

This is a work based in https://github.com/wixette/font-to-3d-models script.

You can send any comments/advice to octavio.rossell@gmail.com

