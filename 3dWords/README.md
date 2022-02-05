
# 3dWords

Script to automate creation of 3D words for Panda3d Engine

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

## About Model Material

As far as I have read in documentation about DAE specifications (used in blender-DAE-egg-bam process) and Panda3d Material Support, the only safe lighthing shading when using materials is to have a basic "Principled BSDF" material type in Blender using only defined Base Color. Using PNG/JPG textures results in dark no-iluminated shapes. If anyone have made Blender-BAM (or Blender-EGG) conversions and more complex materials have worked I will apreciate very much any tip about it.

Fixed blue color has been defined in code and of course may be changed for any other RGBA values.

## TODO

Make a clean install of Panda3d and test dependencies.

Make a INSTALL section
