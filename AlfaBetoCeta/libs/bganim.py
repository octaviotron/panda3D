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
from panda3d.core import TransparencyAttrib
from direct.interval.IntervalGlobal import Interval#,Sequence, Parallel

from libs import env

import random

nube = False
animnodes = []

def SetBgAnim(modelo):
	global nube, animnodes
	salida = NodePath("Background")
	nube = loader.loadModel("modelos/assets/"+modelo+".bam")
	anim = MkBackground()
	anim.reparentTo(salida)
	y = -6
	while y < 8:
		y+= 1+random.uniform(0.5,2)
		duracion = random.randint(10,30)
		nodo = NodePath("nube-"+str(y))
		nodo.setTransparency(TransparencyAttrib.MAlpha)
		nodo.setAlphaScale(random.uniform(0.1,0.5))
		nodo.reparentTo(salida)
		nube.instanceTo(nodo)
		nodo.setPos(10,y,-1)
		anim = nodo.posInterval(duracion, Vec3(-15, y, -1), startPos=Vec3(15, y, -1))
		anim.loop()
		anim.setT(duracion/random.uniform(1,10))
	MkBackground()
	return salida

def MkBackground():
	bgNP = env.nodos["activo"].attachNewNode("background")
	cm = CardMaker('background')
	cm.setFrame(-10, 10, -20, 20)
	card = bgNP.attachNewNode(cm.generate())
	card.setHpr(0,-90,90)
	card.setPos(0,0,-4)
	textura = loader.loadTexture("modelos/assets/cielo.png")
	card.setTexture(textura)	
	return bgNP
