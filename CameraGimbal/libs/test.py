
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

from panda3d.core import LineSegs, NodePath

from libs import modelos
from libs import colors
from libs import conf
from libs import cameragimbal

def Test():
	t = conf.gimbal.attachNewNode("test")
	test = t.attachNewNode("test")
	t.setP(90)

	fondo = modelos.fondo(colors.cyan_d, 3, 3)
	fondo.reparentTo(test)
	lines = LineSegs()
	lines.moveTo(0,0,0)
	lines.drawTo(10,10,-10)
	lines.setThickness(5)
	node = lines.create()
	np = NodePath(node)
	np.reparentTo(fondo)
	#np.setLightOff()

	b = modelos.LoadGltf("assets", "a")
	b.reparentTo(fondo)
	b.setZ(0.3)
	b.setY(0)

	cameragimbal.Set(fondo)

	base.accept('f', change, [fondo])
	base.accept('m', change, [b])

def change(model):
	cameragimbal.gimbal = model

