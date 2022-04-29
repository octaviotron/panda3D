# 3D Fonts for Panda3D

This is a work in progress to have a true 3d font meshes in Panda3d, in order to add a font.setRenderMode() alternative.

It uses Blender pby for creating and exporting .blend and .glb models.

## Usage:

There is a "panda.py" example file using all configurable features. You can see in the code how to implement this library into Panda3D.

For using in your own environment, copy word3d directory into a loadable module path and call like:

```
        w3d = word3d.Word3d()
        w3d.fontname = "DejaVuSansMono"
        w3d.center = True
        w3d.color = (0,0,1,1)
        w3d.scale = 1
        w3d.spacing = 0

        label = w3d.Word("Test")
        label.reparentTo(render)
```

## Making your own models from a custom Font File

- Create a "FontName" path and copy into it any TTF you like as "font.ttf" (see samples files)
- Edit the bottom line in "blender.py" and match the "FontName" to the argument passed to MkModels() 
- Execute "blender -b -P blender.py" 

This will create a blender/ and a glb/ directory with charcodes number as filenames.

Change class.fontname property after instancing, like in the above sample code.


