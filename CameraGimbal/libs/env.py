
#   This program is free software: you can redistribute it and/or modify it 
#   under the terms of the GNU General Public License as published by the 
#   Free Software Foundation, either version 3 of the License, or 
#   (at your option) any later version.
#
#   This program is distributed in the hope that it will be useful, 
#   but WITHOUT ANY WARRANTY; without even the implied warranty of 
#   MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the 
#   GNU General Public License for more details.
#
#   You should have received a copy of the GNU General Public License along 
#   with this program. If not, see <https://www.gnu.org/licenses/>. 


from panda3d.core import Vec4, Vec3
from panda3d.core import AmbientLight
from panda3d.core import AntialiasAttrib
from panda3d.core import ClockObject
from panda3d.core import WindowProperties
from direct.task import Task
from direct.interval.LerpInterval import LerpPosInterval

from libs import conf
from libs import light

mouse = False
mouse_enabled = False
lastH = 0
lastP = 0
newx =0
newy =0

def SetEnv():
	base.disableMouse()

	conf.scene = render.attachNewNode("scene")
	conf.scene.setP(90)	

	conf.camera = render.attachNewNode("CAMERA")
	base.cam.setPos(0, -40, 0)
	base.cam.reparentTo(conf.camera)

	globalClock.setMode(ClockObject.MLimited)
	globalClock.setFrameRate(30)

	render.setAntialias(AntialiasAttrib.MMultisample)

	light.Direccional(conf.scene, 0.9)
	light.Ambient(conf.scene,0.1)


