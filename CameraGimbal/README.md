# CameraGimbal

This is a Code Snippet to have a orbit camera around a node.

## Usage:

File libs/env.py set an empty "CameraGimbal" node attached to render and reparent base.cam into it, so the following mouse commanda will be enabled:

- Middle Mouse Button: enable free movement cam. While pressed mouse rotates CameraGimbal around its HPR degrees
- Right Mouse Button: resets CameraGimbal HPR to (0,0,0) 
- Mosue Wheel: Move camera closer or far to the CameraGimbal node

NOTE: main scene node is rotated 90° because my models are y-fliped to be lay on floor

Any comments or advide are welcomed at octavio.rossell@gmail.com



