
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

from panda3d.core import LineSegs, NodePath, Material, Vec4

from libs import gimbal
from libs import word3d

def Test():
	t = render.attachNewNode("test")
	test = t.attachNewNode("test")
	t.setP(90)

	fondo = MkFondo(Vec4(1,0.5,1,1), 3, 3)
	fondo.reparentTo(test)
	lines = LineSegs()
	lines.moveTo(0,0,0)
	lines.drawTo(10,10,-10)
	lines.setThickness(5)
	node = lines.create()
	np = NodePath(node)
	np.reparentTo(fondo)
	#np.setLightOff()

	b = word3d.word("Esta es Una Prueba", Vec4(1,0.5,1,1))
	b.salida.reparentTo(fondo)
	b.salida.setZ(0.3)
	b.salida.setY(0)
	#print(b.all)

	gimb = gimbal.gimbal(fondo)

def LoadGltf(name, rotation=0):
	salida = NodePath(name)
	a = loader.loadModel("fonts/glb/"+name+".glb")
	a.reparentTo(salida)
	a.setPos(0,0,0)
	a.setR(rotation)
	return salida


def MkFondo(color, x, y):
	salida = NodePath("fondo")
	m = loader.loadModel("libs/fondo.bam")
	m.setScale(x,y,0.1)
	m.reparentTo(salida)
	material = Material()
	material.setDiffuse(color)
	material.setShininess(32)
	m.setMaterial(material, 1)

	return salida


