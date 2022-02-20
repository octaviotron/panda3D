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



from panda3d.core import NodePath, Vec3, Material
from panda3d.core import CollisionNode, CollisionSphere
from direct.interval.IntervalGlobal import Sequence, Parallel, Func, SoundInterval, Wait
from direct.task.Task import Task

from libs import env
from libs import picker
from libs import modelos
from libs import puntuacion
from libs import bganim

import random
import time

acertijo = False
puntos = 0
floresNP = False
ayudaNP = False
formas = ["triangulo", "cuadrado", "rectangulo", "circulo", "trapecio", "rombo", "elipse", "cilindro", "cono", "esfera", "piramide"]

def SetFormas():
	global floresNP
	padre = env.nodos["activo"]
	for n in padre.getChildren(): n.removeNode()
	bg = bganim.SetBgAnim("flor", 0, "blink", "naranja")
	bg.reparentTo(padre)
	MuestraFormas(padre)
	floresNP = padre.attachNewNode("flores")
	SetFlores()
	FormasRandom()
	puntuacion.SetPuntuacion("Geometría", "flor", "formas")

def FormasRandom():
	global acertijo, formas
	a = random.randint(0,len(formas)-1)
	acertijo = formas[a]
	#print(acertijo)
	Cual()

def Cual():
	global acertijo
	cual = base.loader.loadSfx("sound/formas/cuales.wav")
	forma = base.loader.loadSfx("sound/formas/"+acertijo+".wav")
	Sequence(SoundInterval(cual), SoundInterval(forma)).start()

def SetFlores(signo=0):
	global puntos, floresNP
	for n in floresNP.getChildren(): n.removeNode()
	modelo = loader.loadModel("modelos/assets/flor.bam")

	barra = floresNP.attachNewNode("barra")
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


def MuestraFormas(padre):
	global formas
	x = -6
	y = 4
	z = 0
	col = 0
	for i in range(0, len(formas)):
		f = ButtonForma(formas[i], env.colors[col])
		f.reparentTo(padre)
		f.setPos(x,y,z)
		x+= 4
		if x > 6:
			x = -6
			y+=-3
		col+=1
		if col > 8: col = 0

	cual = ButtonCual()
	cual.reparentTo(padre)
	cual.setPos(x,y,z)
	cual.setScale(0.7)

def ButtonForma(nombre, color):
	letra = NodePath("letra-"+nombre)
	modelo = letra.attachNewNode("modelo")
	mesh = loader.loadModel("modelos/formas/"+nombre+".bam")
	mesh.reparentTo(modelo)
	myMaterial = Material()
	myMaterial.setDiffuse(color)
	myMaterial.setShininess(32)
	mesh.setMaterial(myMaterial, 1)

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

def Click(nodo, forma):
	global acertijo, puntos

	if acertijo == forma:   result = 1
	else:				   result = -1
	puntos+=result
	if puntos<=0: puntos = 0

	taskMgr.add(resultado(result))

async def resultado(result):
	global puntos
	# MAL
	if result==-1:
		sonido = base.loader.loadSfx("sound/assets/aww.wav")
		sonido.play()
		SetFlores(result)
		await Task.pause(1.0)
		Cual()
	# BIEN
	else:
		bien = base.loader.loadSfx("sound/assets/aplausos.wav")
		if puntos<5:
			bien.play()
			SetFlores(result)
			await Task.pause(3.0)
			FormasRandom()
		else:
			SetFlores(result)
			puntos = 0
			puntuacion.puntos["formas"] += 1
			puntuacion.SetPuntuacion("Geometría", "flor", "formas")
			Sequence(SoundInterval(bien), Func(Logro)).start()
			await Task.pause(8.0)
			SetFlores()
			FormasRandom()

def Logro():
	chimes = base.loader.loadSfx("sound/assets/level-up.wav")
	chimes.play()
	padre = env.nodos["logro"]
	padre.show()
	for n in padre.getChildren(): n.removeNode()
	estrella = padre.attachNewNode("logro")
	modelo = loader.loadModel("modelos/assets/flor.bam")
	modelo.reparentTo(estrella)
	estrella.setScale(2)
	eanim = Parallel()
	for i in range(-5, 5):
		e = MkFlor()
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

def MkFlor():
	estrella = NodePath("estrella")
	modelo = loader.loadModel("modelos/assets/flor.bam")
	modelo.reparentTo(estrella)
	return estrella



def ButtonCual():
	nodo = NodePath("cual")
	mesh = loader.loadModel("modelos/assets/interrogacion.bam")
	mesh.reparentTo(nodo)
	coll = nodo.attachNewNode(CollisionNode("collision"))
	coll.node().addSolid(CollisionSphere(0, 0, 0, 0.5))
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

