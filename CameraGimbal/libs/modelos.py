
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



from panda3d.core import NodePath
from panda3d.core import Material


def load(path, bam, rotation=0):
	salida = NodePath(bam)
	a = loader.loadModel("modelos/"+path+"/"+bam+".bam")
	a.reparentTo(salida)
	a.setPos(0,0,0)
	a.setR(rotation)
	return salida

def LoadGltf(path, name, rotation=0):
	salida = NodePath(name)
	a = loader.loadModel("modelos/"+path+"/"+name+".gltf")
	a.reparentTo(salida)
	a.setPos(0,0,0)
	a.setR(rotation)
	return salida


def fondo(color, x, y):
	salida = NodePath("fondo")
	m = loader.loadModel("modelos/assets/fondo.bam")
	m.setScale(x,y,0.1)
	m.reparentTo(salida)
	material = Material()
	material.setDiffuse(color)
	material.setShininess(32)
	m.setMaterial(material, 1)
	
	return salida

