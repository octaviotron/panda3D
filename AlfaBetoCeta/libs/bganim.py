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

from panda3d.core import NodePath, Vec3, CardMaker
from panda3d.core import TransparencyAttrib, Material
from direct.interval.LerpInterval import LerpFunctionInterval, LerpScaleInterval
from direct.interval.IntervalGlobal import Interval, Sequence, Parallel

from libs import env

import random

def SetBgAnim(modelo_anim, anim_type, imagen_fondo):
	salida = NodePath("Background")
	bg = MkBackground(imagen_fondo)
	bg.reparentTo(salida)
	animación = Animacion(modelo_anim, anim_type)
	animación.reparentTo(salida)
	return salida

def MkBackground(fondo):
	bgNP = env.nodos["activo"].attachNewNode("background")
	cm = CardMaker('background')
	cm.setFrame(-10, 10, -20, 20)
	card = bgNP.attachNewNode(cm.generate())
	card.setHpr(0,-90,90)
	card.setPos(0,0,-4)
	textura = loader.loadTexture("modelos/assets/"+fondo+".png")
	card.setTexture(textura)
	return bgNP

def Animacion(modelo, tipo):
	modelo = loader.loadModel("modelos/assets/"+modelo+".bam")
	salida = NodePath("Anim")

	if tipo == "righttoleft": animacion = AnimRigtToLeft(modelo)
	if tipo == "blink": animacion = AnimBlink(modelo)

	animacion.reparentTo(salida)
	return salida

def AnimBlink(modelo):
	salida = NodePath("Blink")
	material = Material()
	material.setDiffuse((1,1,1,1))
	material.setShininess(32)
	pares = []
	for x in range(1,20): pares.append([random.uniform(-10,10),random.uniform(-6,6)])
	for par in pares:
		duracion = random.uniform(1,10)
		size = random.uniform(0.3,1)
		nodo = salida.attachNewNode("modelo")
		modelo.instanceTo(nodo)
		nodo.setTransparency(TransparencyAttrib.MAlpha)
		nodo.setPos(par[0],par[1], -1)
		nodo.setMaterial(material, 1)
		fadeinlerp = LerpFunctionInterval(nodo.setAlphaScale, toData = 0.1, fromData = 0.0, duration = duracion)
		sizein = LerpScaleInterval(nodo, duracion, size, startScale=0.1)
		fadein = Parallel(fadeinlerp,sizein)
		fadeoutlerp = LerpFunctionInterval(nodo.setAlphaScale, toData = 0.0, fromData = 0.1, duration = duracion)
		sizeout = LerpScaleInterval(nodo, duracion, 0.1, startScale=size)
		fadeout = Parallel(fadeoutlerp,sizeout)
		anim = Sequence(fadein,fadeout)
		anim.loop()
	return salida
	
def AnimRigtToLeft(modelo):
	salida = NodePath("Right To Left")
	y = -6
	while y < 8:
		y+= 1+random.uniform(0.5,2)
		duracion = random.randint(10,30)
		nodo = NodePath("nube-"+str(y))
		nodo.setTransparency(TransparencyAttrib.MAlpha)
		nodo.setAlphaScale(random.uniform(0.1,0.5))
		nodo.reparentTo(salida)
		modelo.instanceTo(nodo)
		nodo.setPos(10,y,-1)
		anim = nodo.posInterval(duracion, Vec3(-15, y, -1), startPos=Vec3(15, y, -1))
		anim.loop()
		anim.setT(duracion/random.uniform(1,10))
	return salida


