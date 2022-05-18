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

from panda3d.core import PandaNode, NodePath

from .cache import Cache

class word3d(NodePath):
	def __init__(self, font, word, spacing=0.05):
		NodePath.__init__(self, word)
		root = PandaNode('"'+word+'"')
		self.assign(NodePath(root))
		self.setHpr(0,90,0)
		self.font = font
		self.word = word
		self.spacing = spacing
		self.ancho = 0
		self.MK()

	def MK(self):	
		for letter in self.word:
			if letter == " ":
				self.ancho+=0.5
				continue
			l = Cache(self.font, letter)
			nodo = self.attachNewNode(letter)
			mesh = l["mesh"]
			ancho = l["ancho"]
			mesh.instanceTo(nodo)
			nodo.setX(self.ancho)
			self.ancho+=ancho+self.spacing

	def Center(self):
		bounds = self.getTightBounds()
		anchor = bounds[1][0]
		alto = bounds[0][1]+bounds[1][1]
		self.setX(-anchor/2)
		self.setZ(-alto/2)

	def Color(self, color):
		self.setColorScale(color)

