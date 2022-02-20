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

from panda3d.core import NodePath, Vec3
from panda3d.core import TransparencyAttrib
from direct.interval.IntervalGlobal import Interval#,Sequence, Parallel

import random

nube = False
animnodes = []

def SetBgAnim(modelo):
	global nube, animnodes
	salida = NodePath("nubes")
	nube = loader.loadModel("modelos/assets/"+modelo+".bam")
	anim = NubeAnim()
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
	return salida

def NubeAnim():
	global nube
	salida = NodePath("animacion")
	#nube.instanceTo(salida)
	return salida

