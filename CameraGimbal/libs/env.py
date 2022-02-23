
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


from libs import conf
from libs import light

def SetEnv():
	base.disableMouse()

	conf.scene = render.attachNewNode("scene")
	conf.gimbal = conf.scene.attachNewNode("gimbal")

	base.cam.setPos(0, -40, 0)

	light.Ambient(render,0.05)
	light.Direccional(render, 0.9)


