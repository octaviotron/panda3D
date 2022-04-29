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

from panda3d.core import NodePath, PandaNode, Vec4, Material
from panda3d.core import CollisionNode, CollisionCapsule

import os

class Word3d():
	def __init__(self):
		self.dirname = os.path.dirname(__file__)
		self.fontname = "FreeSans"

		self.spacing = 0.1
		self.center = True
		self.color=Vec4(0,0,1,1)
		self.scale = 0.5

	def Word(self, word):
		salida = NodePath("word")
		if word == '': return salida
		self.material = self._MkMat()
		self.x = 0
		for letter in word:
			if letter==" ":
				self.x+=0.5
				continue

			charnode = salida.attachNewNode("letra")
			charnode.setX(self.x)
			#charnode.setY(-0.5)

			mesh = self._LoadMesh(letter)
			mesh.reparentTo(charnode)

			ancho = mesh.getTightBounds()[1][0]
			self.x+=ancho+self.spacing

		salida.setScale(self.scale)

		if self.center: 
			bounds = salida.getTightBounds()
			anchor = bounds[1][0]
			alto = bounds[0][1]+bounds[1][1]
			salida.setX(-anchor/2)
			salida.setZ(-alto/2)
		salida.setP(90)
		return salida

	def _LoadMesh(self, letter):
		nodo = NodePath(letter)
		model_path = os.path.join(self.dirname, 'fonts', self.fontname, 'glb/'+str(ord(letter))+'.glb')
		model = loader.loadModel(model_path)
		model.setMaterial(self.material, 1)
		model.reparentTo(nodo)
		return nodo

	def _MkMat(self):
		material = Material()
		material.setAmbient(self.color)
		material.setDiffuse(self.color)
		#material.setShininess(self.color)
		return material

	def Collision(self, word):
		coll = word.attachNewNode(CollisionNode("colision"))
		anchor = word.getTightBounds()[1][0]
		coll.node().addSolid(CollisionCapsule(0, 0, 0, anchor, 0,0, 0.5))


	
