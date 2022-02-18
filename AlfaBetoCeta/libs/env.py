#!/usr/bin/env python3
# -*- coding: utf-8 -*-
#
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
#
#   Developed by Octavio Rossell Tabet <octavio.rossell@gmail.com>
#


from panda3d.core import Camera, NodePath
from panda3d.core import Vec4
from panda3d.core import TransparencyAttrib
from panda3d.core import AmbientLight
from panda3d.core import PointLight, DirectionalLight, OrthographicLens
from panda3d.core import ClockObject
from panda3d.core import TextNode, TextFont

color = {
	"blanco":   Vec4(1, 1, 1, 1),
	"gris-o":   Vec4(0.2, 0.2, 0.2, 1),
	"gris":  Vec4(0.5, 0.5, 0.5, 1),
	"gris-c":   Vec4(0.7, 0.7, 0.7, 1),
	"negro" :   Vec4(0, 0, 0, 0.5),

	"azul"  :   Vec4(0, 0, 1, 1),
	"verde" :   Vec4(0, 1, 0, 1),
	"cyan"  :   Vec4(0, 1, 1, 1),
	"gnuve-1": Vec4(0, 0.1, 0.1, 1),
	"gnuve-3": Vec4(0, 0.3, 0.3, 1),
	"gnuve-4": Vec4(0, 0.4, 0.4, 1),
	"gnuve-5": Vec4(0, 0.5, 0.5, 1),
	"gnuve-6": Vec4(0, 0.6, 0.6, 1),
	"gnuve-7": Vec4(0, 0.7, 0.7, 1),
	"rojo"  :   Vec4(1, 0, 0, 1),
	"morado":   Vec4(1, 0, 1, 1),
	"amarillo": Vec4(1, 1, 0, 1),
	}
#              rojo     verde     azul     amarillo   cyan     morado     naranja      rosado        marrón
colors = [ (1,0,0,1),(0,1,0,1),(0,0,1,1),(1,1,0,1),(0,1,1,1),(1,0,1,1),(1,0.5,0,1),(1,0.7,0.7,1),(0.5,0.3,0,1) ]

font = {}
nodos = {}

def SetEnv():
	global font, color
	cam_pos = 30
	font["bold"] = loader.loadFont('fonts/sansbold.ttf')
	font["bold"].setRenderMode(TextFont.RMSolid)
	font["arial"] = loader.loadFont('fonts/arial.ttf')
	font["arial"].setRenderMode(TextFont.RMSolid)
	base.disableMouse()
	base.setBackgroundColor(color["gnuve-3"])
	base.camLens.setNearFar(1, cam_pos+10)
	base.cam.setPos(0, 0, cam_pos)
	base.cam.lookAt(0, 0, 0)
	#base.camLens.setFov(5)
	base.cam.reparentTo(render)

	#globalClock.setMode(ClockObject.MLimited)
	#globalClock.setFrameRate(25)

	MkMainScene()
	LuzAmbiente(render, 0.1, 0.9)

def MkMainScene():
	global nodos
	nodos["root"] = render.attachNewNode('root')
	nodos["menu"] = render.attachNewNode('menu')
	nodos["barra"] = render.attachNewNode('barra')
	nodos["activo"] = nodos["root"].attachNewNode('activo')

	#nodos["letras"] = render.attachNewNode('letras')
	nodos["puntuacion"] = render.attachNewNode('puntuacion')
	nodos["logro"] = render.attachNewNode('logro')
	


def LuzAmbiente(nodo, i, l):
	alight = AmbientLight('Ambient')
	alight.setColor((i,i,i, 1))
	alnp = render.attachNewNode(alight)
	nodo.setLight(alnp)
	
	plight = PointLight('plight')
	plight.setColor((l,l,l, 1))
	plnp = render.attachNewNode(plight)
	plnp.setPos(10, 10, 20)
	nodo.setLight(plnp)

def SombraLuz():
	l = 0.8
	plight = DirectionalLight('plight')
	plight.setColor((l,l,l, 1))
	plnp = render.attachNewNode(plight)
	plnp.setPos(3, 3, 20)
	plnp.lookAt(0, 0, 0)
	plnp.setR(45)
	lens = OrthographicLens()
	lens.setNearFar(18, 25)
	lens.setFilmSize(7, 20)
	plight.setLens(lens)
	plight.setShadowCaster(True, 256,256)
	#plight.showFrustum()
	render.setLight(plnp)
	render.setShaderAuto()

def testload(filename):
	model = loader.loadModel('modelos/3dfonts/i.bam')
	model.reparentTo(render)

def test():
	model = loader.loadModel('modelos/egg/carpeta.egg')
	m = render.attachNewNode('t2')
	model.instanceTo(m)
	model.setX(-4)

	model = loader.loadModel('modelos/egg/generico.egg')
	m = render.attachNewNode('t2')
	model.instanceTo(m)
	model.setX(0)

	model = loader.loadModel('modelos/egg/vinculo.egg')
	m = render.attachNewNode('t3')
	model.instanceTo(m)
	model.setX(8)

	model = loader.loadModel('modelos/egg/documento.egg')
	m = render.attachNewNode('t4')
	model.instanceTo(m)
	model.setX(4)

	model = loader.loadModel('modelos/egg/oculto.egg')
	m = render.attachNewNode('t5')
	model.instanceTo(m)
	model.setX(-8)
	model.setY(0)

	model = loader.loadModel('modelos/glb/piso.glb')
	m = render.attachNewNode('t6')
	model.instanceTo(m)
	model.setX(0)
	model.setY(0)
	model.setZ(-2)
	model.setScale(7,3,1)
	model.setColor(0, 0.3, 0.3, 1)
	#model.setTransparency(TransparencyAttrib.MAlpha)
	#model.setAlphaScale(0.3)

	#model.setP(90)
