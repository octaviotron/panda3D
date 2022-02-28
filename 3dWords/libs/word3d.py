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

from fontTools.ttLib import TTFont
from fontTools.pens.boundsPen import BoundsPen

from panda3d.core import NodePath, Vec4, Material

class word():
	def __init__(self, word):
		self.font_path = "fonts/font.ttf"
		self._ttf = False
		self._ttft = False
		self.word = word
		self.color = Vec4(0,0,0,1)
		self.center = True
		self.spacing = 0.2
		self.salida = NodePath("word")
		self.offset = self.salida.attachNewNode("offset")
		self.all = []

		self._SetFont()
		self._EachLetter()

	def nodo(self):
		return self.salida

	def _SetFont(self):
		font = TTFont(self.font_path)
		cmap = font['cmap']
		self._ttft = cmap.getBestCmap()
		self._ttf = font.getGlyphSet()

	def _Ancho(self, letter):
		bp = BoundsPen(self._ttf)
		self._ttf[self._ttft[ord(letter)]].draw(bp)
		bounds = bp.bounds
		ancho = bounds[2]/1500
		return ancho

	def _EachLetter(self):
		x = 0
		for letter in self.word:
			if letter==" ":
				x+=0.5
				continue

			charnode = self.offset.attachNewNode("letra")
			charnode.setX(x)
			charnode.setY(-0.5)

			mesh = self._LoadMesh(letter)
			mesh.reparentTo(charnode)
			self.all.append(mesh)

			ancho = self._Ancho(letter)
			x+=ancho+self.spacing

		if self.center: self.offset.setX(-x/2)

	def _LoadMesh(self, letter):
		nodo = NodePath(letter)
		model_path = 'fonts/glb/'+str(ord(letter))+'.glb'
		model = loader.loadModel(model_path)

		material = self._MkMat()
		model.setMaterial(material, 1)
		model.reparentTo(nodo)
		return nodo

	def _MkMat(self):
		material = Material()
		material.setDiffuse(self.color)
		material.setShininess(32)
		return material

	
