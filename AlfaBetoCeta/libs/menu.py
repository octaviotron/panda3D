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


from pathlib import Path

from panda3d.core import NodePath, Vec3, Material, TransparencyAttrib, CardMaker
from panda3d.core import CollisionNode, CollisionSphere
from direct.interval.IntervalGlobal import Sequence, Parallel, Func, SoundInterval, Wait

from libs import env
from libs import picker
from libs import modelos
from libs import mayusculas
from libs import minusculas
from libs import sumar
from libs import restar
from libs import formas
from libs import teclas
from libs import acerca
from libs import puntuacion
from libs import word3d
from libs import bganim

import sys

menuNP = False
soundtrack = False


def SetMenu():
	global menuNP

	limpiar = env.nodos["puntuacion"]
	for n in limpiar.getChildren(): n.removeNode()

	limpiar = env.nodos["activo"]
	for n in limpiar.getChildren(): n.removeNode()

	menuNP = env.nodos["menu"]
	for n in menuNP.getChildren(): n.removeNode()

	bg = bganim.SetBgAnim("cloud", 10, "righttoleft", "cielo")
	bg.reparentTo(env.nodos["activo"])

	teclas.ListenKeyboard = False

	titulo_letras = word3d.MkWord("Letras", 2, True)
	v1 = vinculo(logro("estrellas"), icono("mayusculas"), "Mayúsculas")
	v2 = vinculo(logro("estrellas"), icono("minusculas"), "Minúsculas")
	letras = seccion("letras", titulo_letras, v1, v2)
	letras.reparentTo(menuNP)
	letras.setPos(-5,6,0)

	titulo_numeros = word3d.MkWord("Números", 3, True)
	t1 = vinculo(logro("corazones"), icono("sumar"), "Sumar")
	t2 = vinculo(logro("corazones"), icono("restar"), "Restar")
	numeros = seccion("numeros", titulo_numeros, t1, t2)
	numeros.reparentTo(menuNP)
	numeros.setPos(5,6,0)

	titulo_formas = word3d.MkWord("Geometría", 0, True)
	f1 = vinculo(logro("flores"), icono("formas"), "Geometría")
	formas = seccion("formas", titulo_formas, f1)
	formas.reparentTo(menuNP)
	formas.setPos(-5,-1,0)	

	titulo_teclas = word3d.MkWord("Teclado", 1, True)
	k1 = vinculo(logro("mariposas"), icono("teclas"), "Teclas")
	tecls = seccion("teclas", titulo_teclas, k1)
	tecls.reparentTo(menuNP)
	tecls.setPos(5,-1,0)
	
	Barra()

def Barra():
	global menuNP

	barra = menuNP.attachNewNode("barra")
	barra.setY(-7)
	base = loader.loadModel("modelos/assets/rec10.bam")
	base.setScale(4,1.1,1)
	#base.reparentTo(barra)
	base.setColor(env.color["gnuve-3"])
	base.setZ(-0.5)
	base.setTransparency(TransparencyAttrib.MAlpha)
	base.setAlphaScale(0.5)

	acerca = barra.attachNewNode("acerca")
	acerca.setPos(-5,0,0)
	titulo_acerca = word3d.MkWord("Acerca de", 9, True)
	titulo_acerca.setScale(0.2)
	titulo_acerca.reparentTo(acerca)
	titulo_acerca.setPos(0,-0.6,0)
	icono_acerca = MkMenuIcon("interrogacion", 0)
	icono_acerca.setScale(0.5)
	icono_acerca.reparentTo(acerca)
	icono_acerca.setPos(0,0.3,0)

	punt = barra.attachNewNode("puntuacion")
	punt.setPos(-8,0,0)
	titulo_puntuacion = word3d.MkWord("Puntuación", 9, True)
	titulo_puntuacion.setPos(0,-0.6,0)
	titulo_puntuacion.setScale(0.2)
	titulo_puntuacion.reparentTo(punt)
	icono_puntuacion = MkMenuIcon("puntuacion", 0)
	icono_puntuacion.setScale(0.5)
	icono_puntuacion.reparentTo(punt)
	icono_puntuacion.setPos(0,0.3,0.2)
	

	salir = barra.attachNewNode("salir")
	salir.setPos(8,0,0)
	titulo_salir = word3d.MkWord("Salir", 9, True)
	titulo_salir.setPos(0,-0.6,0)
	titulo_salir.setScale(0.2)
	titulo_salir.reparentTo(salir)
	icono_salir = MkMenuIcon("power", 0)
	icono_salir.setScale(0.5)
	icono_salir.reparentTo(salir)
	icono_salir.setPos(0,0.3,0.2)

def seccion(nombre, titulo, tarea1, tarea2=False):
	salida = NodePath(nombre)
	titulo.reparentTo(salida)
	titulo.setY(-0.5)
	t = salida.attachNewNode("tareas")
	t.setY(-2.5)
	t.reparentTo(salida)
	tarea1.reparentTo(t)
	if tarea2:
		tarea2.reparentTo(t)
		tarea2.setX(4)
		t.setX(-2)
	return salida

def vinculo(logro, icono, rotulo):
	salida = NodePath("vinculo")
	icono.reparentTo(salida)
	icono.setX(0)
	card = loader.loadModel("modelos/menu/card.bam")
	card.reparentTo(salida)
	card.setPos(0,-0.2,0)
	nombre=word3d.MkWord(rotulo, -1, True)
	nombre.reparentTo(card)
	nombre.setY(-1.1)
	nombre.setZ(0.1)
	nombre.setScale(0.2)
	return salida

def tareas(t1, t2=False):
	salida = NodePath("tareas")
	t1.reparentTo(salida)
	if t2:
		t2.reparentTo(salida)
		t2.setX(5)
	return salida

def icono(nombre):
	salida = NodePath(nombre)
	icon = MkMenuIcon(nombre, 15 )
	icon.reparentTo(salida)
	return salida

def logro(icono):
	salida = NodePath("logro")
	#logro_icon = loader.loadModel("modelos/menu/"+icono+".bam")
	#logro_icon.reparentTo(salida)
	#logro_icon.setX(1)
	return salida



def MkMenuIcon(nombre, r):
	padre = NodePath(nombre)
	m = icon(nombre, r)
	m.reparentTo(padre)
	rotar = m.hprInterval(1.0, Vec3(0,0,-360))
	rotar.loop()
	rotar.pause()
	coll = padre.attachNewNode(CollisionNode("collision"))
	coll.node().addSolid(CollisionSphere(0, 0, 0, 1))
	#coll.show()
	picker.acciones[coll] = {
		"over": globals()["Overs"], "over_params": [rotar, nombre],
		"out": globals()["Outs"], "out_params": rotar,
		"click": globals()["Click_"+nombre], "click_params": "1"
		}
	return padre


def icon(nombre, r):
	salida = NodePath("icon_"+nombre)
	a = loader.loadModel("modelos/menu/"+nombre+".bam")
	a.reparentTo(salida)
	#a.setR(r)
	return salida

def Overs(x, params):
	picker.active=False
	ruta = "sound/menu/"+params[1]+".wav"
	sonido = Path(ruta)
	tipo = base.loader.loadSfx(ruta)
	params[0].resume()
	Sequence(SoundInterval(tipo), Func(picker.SetActive, True)).start()

def Outs(x, rotar):
	rotar.pause()
	rotar.setT(0)

def Click_formas(x, p):
	clearscene()
	env.nodos["barra"].show()
	formas.SetFormas()

def Click_mayusculas(x, p):
	clearscene()
	env.nodos["barra"].show()
	mayusculas.SetMayusculas()

def Click_minusculas(x, p):
	clearscene()
	env.nodos["barra"].show()
	minusculas.SetMinusculas()

def Click_sumar(x, p):
	clearscene()
	env.nodos["barra"].show()
	sumar.SetSuma()

def Click_restar(x, p):
	clearscene()
	env.nodos["barra"].show()
	restar.SetResta()

def Click_teclas(x, p):
	clearscene()
	env.nodos["barra"].show()
	teclas.SetTeclas()

def Click_interrogacion(x, p):
	clearscene()
	env.nodos["barra"].show()
	acerca.SetAcerca()

def Click_puntuacion(x, p):
	clearscene()
	env.nodos["barra"].show()
	puntuacion.Totales()
	#print("OK")

def Click_power(x, p):
	sys.exit()

def clearscene():
	global soundtrack
	for n in env.nodos["menu"].getChildren(): n.removeNode()
	if soundtrack.status() == soundtrack.PLAYING: soundtrack.stop()

def SoundTrack(Task):
	global soundtrack
	soundtrack = base.loader.loadSfx("sound/Mia.ogg")
	soundtrack.setLoop(True)
	soundtrack.play()
	soundtrack.setVolume(0.1)
	return Task.done
