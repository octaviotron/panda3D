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


from panda3d.core import CollisionNode, CollisionSphere, Vec3

from libs import env
from libs import picker
from libs import menu

def SetBarra():
	padre = env.nodos["barra"]
	for n in padre.getChildren(): n.removeNode()

	padre.setY(-7)
	padre.hide()

	casa = loader.loadModel("modelos/assets/casa.bam")
	casa.reparentTo(padre)
	#casa.setP(-10)
	#casa.setR(10)
	rotar = casa.hprInterval(1.0, Vec3(0,0,-360))
	rotar.loop()
	rotar.pause()


	coll = casa.attachNewNode(CollisionNode("collision"))
	coll.node().addSolid(CollisionSphere(0, 0, 0, 0.7))
	picker.acciones[coll] = {
		"over": globals()["CasaOver"],
		"over_params": rotar,
		"out": globals()["CasaOut"],
		"out_params": rotar,
		"click": globals()["CasaClick"],
		"click_params": "1"
		}

def CasaOver(x, rotar):
	rotar.resume()

def CasaOut(x, rotar):
	rotar.pause()
	rotar.setT(0)

def CasaClick(x, p):
	menu.SetMenu()
	#env.nodos["menu"].show()
	env.nodos["barra"].hide()
	for n in env.nodos["activo"].getChildren(): n.removeNode()

	
