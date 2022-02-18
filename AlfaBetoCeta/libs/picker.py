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



from panda3d.core import CollisionTraverser, CollisionNode, CollisionHandlerQueue, CollisionRay
from panda3d.bullet import BulletWorld
from direct.task import Task

picker=False
pq=False
pickerRay=False
mouseovercurrent=False
acciones = { "overs": {}, "outs": {}, "clicks":{} }

def SetupPicker():
	global picker,pq,pickerRay
	picker = CollisionTraverser()
	#self.picker.showCollisions(render)
	pq = CollisionHandlerQueue()
	pickerNode = CollisionNode('mouseRay')
	pickerNP = base.cam.attachNewNode(pickerNode)
	pickerRay = CollisionRay()
	pickerNode.addSolid(pickerRay)
	picker.addCollider(pickerNP,pq)

def MouseOverTask(task):
	global picker,pq,mouseovercurrent,pickerRay
	if base.mouseWatcherNode.hasMouse():
		mpos = base.mouseWatcherNode.getMouse()
		pickerRay.setFromLens(base.camNode,mpos.getX(),mpos.getY())
		picker.traverse(render)
		if pq.getNumEntries() > 0:
			pq.sortEntries()
			new = pq.getEntry(0).getIntoNodePath()
			MouseOverEnter(new)
		else:
			if mouseovercurrent:
				MouseOverOut(mouseovercurrent)
	return Task.cont

def MouseOverEnter(new):
	global mouseovercurrent, acciones
	if mouseovercurrent != new:
		if mouseovercurrent: MouseOverOut(mouseovercurrent)
		mouseovercurrent = new
		funcion = acciones[mouseovercurrent]["over"]
		params = acciones[mouseovercurrent]["over_params"]
		funcion(mouseovercurrent, params)

def MouseOverOut(nodo):
	global mouseovercurrent, acciones
	funcion = acciones[mouseovercurrent]["out"]
	params = acciones[mouseovercurrent]["out_params"]
	funcion(mouseovercurrent, params)
	mouseovercurrent = False

def MouseClick():
	global mouseovercurrent
	if mouseovercurrent:
		funcion = acciones[mouseovercurrent]["click"]
		params = acciones[mouseovercurrent]["click_params"]
		funcion(mouseovercurrent, params)
