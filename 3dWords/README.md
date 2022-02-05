
# 3dWords

Script to automate creation of 3D words for Panda3d Engine

## Usage:

```
blender -b -P 3dWords.py -- "<word>"
```

You will need a "font.ttf" file in current dir. Provided one is a copy of sansbold.ttf distributed with Debian Bullseye. Any ttf will work, ensure if replacing use one with Extended ASCII characters (ñ, á, ü, etc)

## Requirements

- Blender > 2.9
- dae2egg
- egg2bam

## TODO

Make a clean install of Panda3d and test dependencies.

Make a INSTALL section
