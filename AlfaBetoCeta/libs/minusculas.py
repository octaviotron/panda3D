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
from panda3d.core import CollisionNode, CollisionSphere
from direct.interval.IntervalGlobal import Sequence, Parallel, Func, SoundInterval, Wait
from direct.task.Task import Task

from libs import env
from libs import picker
from libs import puntuacion
from libs import word3d
from libs import bganim

import random
import time

acertijo = False
letras = "abcdefghijklmnñopqrstuvwxyz"
puntos = 0
estrellasNP = False


def LetraRandom():
	global acertijo, letras
	l = random.randint(0,26)
	acertijo = letras[l]
	Cual()

def Cual():
	global acertijo, letras
	cual = base.loader.loadSfx("sound/mensajes/cualdetodas.wav")
	letra = base.loader.loadSfx("sound/letras/"+acertijo+".wav")
	Sequence(SoundInterval(cual), SoundInterval(letra)).start()

def SetMinusculas():
	global estrellasNP
	padre = env.nodos["activo"]
	for n in padre.getChildren(): n.removeNode()

	bg = bganim.SetBgAnim("estrella", 10, "blink", "noche")
	bg.reparentTo(padre)

	SetLetras(padre)

	estrellasNP = padre.attachNewNode("estrellas")
	SetEstrellas()

	LetraRandom()
	puntuacion.SetPuntuacion("Minúsculas", "estrella", "minusculas")

def SetLetras(padre):
	global letras
	alfabetoNP = padre.attachNewNode("alfabeto")
	x = -9.5
	y = 4
	z = 0
	c = 0
	for i in range(0, len(letras)):
		mayuscula = ButtonLetra(letras[i])
		mayuscula.reparentTo(padre)
		mayuscula.setPos(x,y,z)
		x+= 3
		if x > 9.5:
			x = -9.5
			y+=-2.5

	cual = ButtonCual()
	cual.reparentTo(padre)
	cual.setPos(x,y,z)
	cual.setScale(0.7)

def ButtonCual():
	nodo = NodePath("cual")
	mesh = loader.loadModel("modelos/assets/interrogacion.bam")
	mesh.reparentTo(nodo)
	mesh.setY(0.6)
	coll = nodo.attachNewNode(CollisionNode("collision"))
	coll.node().addSolid(CollisionSphere(0, 0, 0, 1))
	rotar = mesh.hprInterval(1.0, Vec3(0,0,-360))
	rotar.loop()
	rotar.pause()
	picker.acciones[coll] = {
		"over": globals()["CualOver"],
		"over_params": rotar,
		"out": globals()["CualOut"],
		"out_params": rotar,
		"click": globals()["CualClick"],
		"click_params": ""
		}
	return nodo

def CualOver(x, rotar):
	rotar.resume()
def CualOut(x, rotar):
	rotar.pause()
	rotar.setT(0)
def CualClick(a, b):
	Cual()

	
def ButtonLetra(nombre):
	letra = NodePath("letra-"+nombre)

	modelo = letra.attachNewNode("modelo")
	mesh = word3d.MkWord(nombre, 4, True)
	mesh.reparentTo(modelo)
	rotar = modelo.hprInterval(1.0, Vec3(0,0,-360))
	rotar.loop()
	rotar.pause()

	coll = letra.attachNewNode(CollisionNode("collision"))
	coll.node().addSolid(CollisionSphere(0, 0, 0, 0.5))
	picker.acciones[coll] = {
		"over": globals()["Over"],
		"over_params": rotar,
		"out": globals()["Out"],
		"out_params": rotar,
		"click": globals()["Click"],
		"click_params": nombre
		}
	#coll.show()

	return letra

def Over(nodo, rotar):
	sonido = base.loader.loadSfx("sound/assets/pop.wav")
	sonido.play()
	rotar.resume()

def Out(nodo, rotar):
	rotar.pause()
	rotar.setT(0)

def Click(nodo, letra):
	global acertijo, puntos

	if acertijo == letra: 	result = 1
	else: 					result = -1
	puntos+=result
	if puntos<=0: puntos = 0
	#print("CLICK", puntos)

	taskMgr.add(resultado(result))


async def resultado(result):
	global puntos
	# MAL
	if result==-1:
		sonido = base.loader.loadSfx("sound/assets/aww.wav")
		sonido.play()
		SetEstrellas(result)
		await Task.pause(1.0)
		Cual()
	# BIEN
	else:
		bien = base.loader.loadSfx("sound/assets/aplausos.wav")
		if puntos<5:
			bien.play()
			SetEstrellas(result)
			await Task.pause(3.0)
			LetraRandom()
		else:
			SetEstrellas(result)
			puntos = 0
			puntuacion.puntos["minusculas"] += 1
			puntuacion.SetPuntuacion("Minúsculas", "estrella", "minusculas")
			Sequence(SoundInterval(bien), Func(Logro)).start()
			await Task.pause(8.0)
			SetEstrellas()
			LetraRandom()
			
			
		

def SetEstrellas(signo=0):
	global puntos, estrellasNP
	for n in estrellasNP.getChildren(): n.removeNode()
	modelo = loader.loadModel("modelos/assets/estrella.bam")

	barra = estrellasNP.attachNewNode("barra")
	barra.setY(-5.5)
	barra.setScale(0.6)
	barra.setColor((1,0,0,1))

	x = -6
	for f in range (0, puntos):
		i = barra.attachNewNode(str(f))
		i.setX(x)
		e = modelo.instanceTo(i)
		if f == puntos-1 and signo>0:
			i.hprInterval(2, Vec3(0,0,-360)).start()
		x+= 3
		
def Logro():
	chimes = base.loader.loadSfx("sound/assets/level-up.wav")
	chimes.play()
	padre = env.nodos["logro"]
	padre.show()
	for n in padre.getChildren(): n.removeNode()
	estrella = padre.attachNewNode("estrella")
	modelo = loader.loadModel("modelos/assets/estrella.bam")
	modelo.reparentTo(estrella)
	estrella.setScale(2)
	eanim = Parallel()
	for i in range(-5, 5):
		e = MkEstrella()
		e1 = e.instanceTo(padre)

		xr = (random.randint(0, 5)+5)*random.choice([-1, 1])
		yr = (random.randint(0, 5)+5)*random.choice([-1, 1])
		i1 = e1.posHprInterval(0.1+abs(i/6), Vec3(xr, yr, 10), Vec3(0, 0, 360))
		eanim.append(i1)

	secuencia = Sequence(eanim, eanim, eanim, Func(FinLogro))
	secuencia.start()

def FinLogro():
	padre = env.nodos["logro"]
	for n in padre.getChildren(): n.removeNode()

def MkEstrella():
	estrella = NodePath("estrella")
	modelo = loader.loadModel("modelos/assets/estrella.bam")
	modelo.reparentTo(estrella)
	return estrella
