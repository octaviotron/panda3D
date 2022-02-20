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


from panda3d.core import TextNode, TextFont, NodePath

from libs import env
from libs import word3d

puntos = {"mayusculas": 0, "minusculas": 0, "suma": 0, "resta":0, "formas": 0, "teclas": 0}
logs = {"mayusculas": {}, "minusculas": {}, "suma": {}, "resta":{}, "formas": {}, "teclas": {} }
barra = False

def Totales():
	global puntos
	padre = env.nodos["activo"]
	for n in padre.getChildren(): n.removeNode()

	titulo = word3d.MkWord("Puntuación", "4", True)
	titulo.setY(5)
	titulo.reparentTo(padre)

	totales = padre.attachNewNode("totales")
	totales.setY(3)

	mayus = MkTotal("Mayúsculas", puntos["mayusculas"])
	mayus.setPos(0,0,0)
	mayus.reparentTo(totales)

	minus = MkTotal("Minúsculas", puntos["minusculas"])
	minus.setPos(0,-1.5,0)
	minus.reparentTo(totales)

	sumar = MkTotal("Sumar", puntos["suma"])
	sumar.setPos(0,-3,0)
	sumar.reparentTo(totales)

	restar = MkTotal("Restar", puntos["resta"])
	restar.setPos(0,-4.5,0)
	restar.reparentTo(totales)

	formas = MkTotal("Geometría", puntos["formas"])
	formas.setPos(0,-6,0)
	formas.reparentTo(totales)

	teclas = MkTotal("Teclas", puntos["teclas"])
	teclas.setPos(0,-7.5,0)
	teclas.reparentTo(totales)
	

def MkTotal(nombre, puntos):
	salida = NodePath(nombre)
	color = -1 if puntos == 0 else 4
	titulo = word3d.MkWord(nombre, color)
	titulo.setX(-4.5)
	titulo.setScale(0.5)
	titulo.reparentTo(salida)
	numero = word3d.MkWord(str(puntos), color, True)
	numero.setX(4)
	numero.setScale(0.5)
	numero.reparentTo(salida)
	return salida

def SetPuntuacion(titulo, icono_logro, indice):
	global puntos, barra
	padre = env.nodos["puntuacion"]
	padre.setY(7)
	for n in padre.getChildren(): n.removeNode()

	barra = padre.attachNewNode("barra")
	MkIcono(titulo, icono_logro, puntos[indice])

def MkIcono(titulo, icono_logro, punto):
	global barra
	total = barra.attachNewNode("total_"+titulo)
	total.setScale(1)
	m = word3d.MkWord(titulo, 10, True)
	m.reparentTo(total)
	m.setY(0)
	m.setScale(0.5)

	abajo = total.attachNewNode("abajo")
	abajo.setY(-0.8)
	abajo.setZ(0.5)

	bill = abajo.attachNewNode("bill")
	bill.setX(0)
	b = SetBillboard(punto)
	b.reparentTo(bill)
	b.setColor(env.color["negro"])
	b.setScale(0.5)
	b.setX(0.3)
	b.setY(-0.2)

	logro = abajo.attachNewNode("logro")
	l = loader.loadModel("modelos/assets/"+icono_logro+".bam")
	l.setScale(0.3)
	l.setX(-0.3)
	l.reparentTo(logro)

def SetBillboard(punto):
	bill = NodePath("bill")
	billtext = TextNode('Billboard')
	font = env.font["bold"]
	font.setRenderMode(TextFont.RMSolid)
	billtext.setFont(font)
	billtext.setText(str(punto))
	if punto > 0:	color = env.color["amarillo"]
	else:			color = env.color["blanco"]
	billtext.setTextColor(color)
	billtext.setAlign(TextNode.ACenter)
	t = bill.attachNewNode(billtext)
	t.setBillboardPointEye()
	t.setScale(1,0.5,1)
	return bill
	
