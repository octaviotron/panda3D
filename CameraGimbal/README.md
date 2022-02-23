# CameraGimbal

This is a Code Snippet to have a orbit camera around a node.

## Usage:

Just instance gimbal passing the target node you want to control with mouse:

```python

gimb = gimbal.gimbal(some_node)

```

Now target node responds following mouse events:

- middle click:   starts target node rotation over Z and X axis
- right click:    reset target node rotation
- mouse wheel:    Zooms in/out camera

There are two important callable methods:

- gimb.Set(another_node): changes target node
- gimb.Destroy(): unset mouse events listening and end running task


Any comments or advice are welcomed at octavio.rossell@gmail.com

