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

import random
import time

acertijo = False
letras = "ABCDEFGHIJKLMNÑOPQRSTUVWXYZ"
puntos = 0
logrosNP = False
avanceNP = False
teclaNP = False
ListenKeyboard = False

def SetTeclas():
	global teclaNP, logrosNP, avanceNP, ListenKeyboard
	padre = env.nodos["activo"]
	for n in padre.getChildren(): n.removeNode()

	logrosNP = padre.attachNewNode("logros")
	avanceNP = padre.attachNewNode("avance")
	teclaNP = padre.attachNewNode("TECLA")
	teclaNP.setZ(-1)
	base.acceptOnce('keystroke', PressTecla)
	ListenKeyboard = True
	#SetLogro()
	SetAvance()
	LetraRandom()
	ShowTecla(padre)
	puntuacion.SetPuntuacion("Teclas", "mariposa", "teclas")


def LetraRandom():
	global acertijo, letras
	l = random.randint(0,26)
	acertijo = letras[l]
	Cual()

def Cual():
	global acertijo, letras
	cual = base.loader.loadSfx("sound/teclas/tecla.wav")
	letra = base.loader.loadSfx("sound/letras/"+acertijo+".wav")
	#tipo = base.loader.loadSfx("sound/mensajes/"+maymin+".wav")
	Sequence(SoundInterval(cual), SoundInterval(letra)).start()

def ShowTecla(padre):
	global acertijo, teclaNP
	for n in teclaNP.getChildren(): n.removeNode()
	path = "modelos/letras/mayus/"+acertijo+".bam"
	modelo = teclaNP.attachNewNode("modelo")
	mesh = loader.loadModel(path)
	mesh.reparentTo(modelo)
	mesh.setScale(3)
	#rotar = modelo.hprInterval(1.0, Vec3(0,0,-360))
	#rotar.loop()
	
def PressTecla(tecla):
	global acertijo, ListenKeyboard, puntos
	if not ListenKeyboard:
		return
	pressed = tecla.upper()
	#print(pressed, tecla, acertijo)
	if pressed == acertijo:   result = 1
	else:			  		result = -1
	puntos+=result
	if puntos<=0: puntos = 0
	taskMgr.add(resultado(result))

async def resultado(result):
	global puntos
	if result==-1:
		sonido = base.loader.loadSfx("sound/assets/aww.wav").play()
		SetAvance(result)
		await Task.pause(1.0)
		Cual()
		await Task.pause(2.0)
		base.acceptOnce('keystroke', PressTecla)
	else:
		bien = base.loader.loadSfx("sound/assets/aplausos.wav")
		if puntos<5:
			bien.play()
			SetAvance(result)
			await Task.pause(3.0)
			SetTeclas()
		else:
			SetAvance(result)
			puntos = 0
			puntuacion.puntos["teclas"] += 1
			Sequence(SoundInterval(bien), Func(Logro)).start()
			puntuacion.SetPuntuacion("Teclas", "mariposa", "teclas")
			await Task.pause(8.0)
			#RestaRandom()
			SetTeclas()
			SetAvance()

def Logro():
	chimes = base.loader.loadSfx("sound/assets/level-up.wav")
	chimes.play()
	padre = env.nodos["logro"]
	padre.show()
	for n in padre.getChildren(): n.removeNode()
	estrella = padre.attachNewNode("mariposa")
	modelo = loader.loadModel("modelos/assets/mariposa.bam")
	modelo.reparentTo(estrella)
	estrella.setScale(2)
	eanim = Parallel()
	for i in range(-5, 5):
		e = MkCorazon()
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

def MkCorazon():
	estrella = NodePath("estrella")
	modelo = loader.loadModel("modelos/assets/mariposa.bam")
	modelo.reparentTo(estrella)
	return estrella

def SetAvance(signo=0):
    global puntos, avanceNP
    for n in avanceNP.getChildren(): n.removeNode()
    modelo = loader.loadModel("modelos/assets/mariposa.bam")

    barra = avanceNP.attachNewNode("barra")
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
