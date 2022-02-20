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


from panda3d.core import NodePath, Vec4, Material
import random

def MkWord(word, col="random", center=False, spacing=0.2):
	salida = NodePath("word")
	offset = salida.attachNewNode("offset")
	#          red       green     blue      violet    yellow    pink          brown         cyan      orange        black		white
	colors = [(1,0,0,1),(0,1,0,1),(0,0.5,1,1),(1,0,1,1),(1,1,0,1),(1,0.7,0.7,1),(0.5,0.3,0,1),(0,1,1,1),(1,0.5,0,1),(0,0,0,1),(1,1,1,1)]
	if isinstance(col, str): 
		if col=="random":	colcont = random.randint(0,len(colors)-1)
		else: colcont=int(col)
	
	x = 0
	for l in range(0,len(word)):
		letter = word[l]
		if letter==" ":
			x+=0.5
			continue
		nodo = offset.attachNewNode(letter)
		nodo.setX(x)
		if l!=len(word): x+=setx(letter)+spacing
		model = loader.loadModel('modelos/3dfonts/'+letter+'.bam')

		if isinstance(col, int): color=colors[col]
		else:		
			color = colors[colcont]
			colcont+=1
			if colcont>=len(colors): colcont=0
		material = MkMat(color)
		model.setMaterial(material, 1)
		model.reparentTo(nodo)

		if center: offset.setX(-x/2)
	return salida

def MkMat(color):
	material = Material()
	material.setDiffuse(color)
	material.setShininess(32)
	return material

def setx(letter):
	if letter in "W": x=1.4
	if letter in "AÁCGMOÓQRVXYmw":x=1.1
	if letter in "DKZ": x=1
	if letter in "BEÉFHNÑPSUÚ": x=0.9
	if letter in "LT45aábkoópuúvx": x=0.8
	if letter in "cdeéghnñsyz0236789": x=0.7
	if letter in "J1q": x=0.6
	if letter in "r": x=0.5
	if letter in "ft": x=0.4
	if letter in "IÍií": x=0.3
	if letter in "jl": x=0.2
	return x
		


def character(padre, c, col="white"):
	global color
	salida = NodePath(c)
	model = loader.loadModel('modelos/3dfonts/'+c+'.bam')
	material = Material()
	material.setDiffuse(color[col])
	material.setShininess(32)
	model.setMaterial(material, 1)
	model.reparentTo(salida)
	return salida
	
	
