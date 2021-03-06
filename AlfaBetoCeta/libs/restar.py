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
a = False
b = False
puntos = 0
corazonesNP = False
ayudaNP = False

def SetResta():
	picker.active = False
	global corazonesNP
	padre = env.nodos["activo"]
	for n in padre.getChildren(): n.removeNode()
	bg = bganim.SetBgAnim("corazon", 0, "blink", "verde")
	bg.reparentTo(padre)
	RestaRandom()
	restarNP = padre.attachNewNode("sumar")
	Preguntar(restarNP)
	corazonesNP = padre.attachNewNode("corazones")
	SetCorazones()
	puntuacion.SetPuntuacion("Restar", "corazon", "resta")
	
def RestaRandom():
	global acertijo, a, b
	a = random.randint(2,12)
	a=12
	b = random.randint(1,a-1)
	acertijo = a-b
	Cuanto()

def Cuanto():
	global a, b
	picker.active=False
	cuanto = base.loader.loadSfx("sound/mensajes/cuantoes.wav")
	mas = base.loader.loadSfx("sound/numeros/menos.wav")
	x = base.loader.loadSfx("sound/numeros/"+str(a)+".wav")
	y = base.loader.loadSfx("sound/numeros/"+str(b)+".wav")
	Sequence(SoundInterval(cuanto), SoundInterval(x), SoundInterval(mas), SoundInterval(y), Wait(0.5), Func(picker.SetActive, True)).start()
	pass

def Preguntar(padre):
	global acertijo, a, b
	for n in padre.getChildren(): n.removeNode()
	if a < 10:
		modelox = loader.loadModel("modelos/numeros/"+str(a)+".bam")
		myMaterial = MkMat("verde")
		modelox.setMaterial(myMaterial, 1)
	else:
		modelox = NodePath("modelox")
		myMaterial = MkMat("verde")
		mx1 = loader.loadModel("modelos/numeros/"+str(a)[0]+".bam")
		mx1.setMaterial(myMaterial, 1)
		mx1.instanceTo(modelox)
		mx1.setX(-0.5)
		mx2 = loader.loadModel("modelos/numeros/"+str(a)[1]+".bam")
		mx2.setMaterial(myMaterial, 1)
		mx2.instanceTo(modelox)
		mx2.setX(0.5)
	
	if b < 10:
		modeloy = loader.loadModel("modelos/numeros/"+str(b)+".bam")
		myMaterial = MkMat("morado")
		modeloy.setMaterial(myMaterial, 1)
	else:
		modeloy = NodePath("modeloy")
		myMaterial = MkMat("morado")
		mx1 = loader.loadModel("modelos/numeros/"+str(b)[0]+".bam")
		mx1.setMaterial(myMaterial, 1)
		mx1.instanceTo(modeloy)
		mx1.setX(-0.5)
		mx2 = loader.loadModel("modelos/numeros/"+str(b)[1]+".bam")
		mx2.setMaterial(myMaterial, 1)
		mx2.instanceTo(modeloy)
		mx2.setX(0.5)

	modelomenos = loader.loadModel("modelos/signos/menos.bam")
	myMaterial = MkMat("rojo")
	modelomenos.setMaterial(myMaterial, 1)

	preguntaNP = padre.attachNewNode("pregunta")
	preguntaNP.setX(-5)
	preguntaNP.setY(2)
	primernumeroNP = preguntaNP.attachNewNode("primer_numero")
	menosNP = preguntaNP.attachNewNode("menos")
	segundonumeroNP = preguntaNP.attachNewNode("segundo_numero")

	modelox.instanceTo(primernumeroNP)
	primernumeroNP.setX(-2)
	modelomenos.instanceTo(menosNP)
	modeloy.instanceTo(segundonumeroNP)
	segundonumeroNP.setX(2)

	Respuestas(padre)
	SetAyuda(preguntaNP)

def MkMat(color):
	myMaterial = Material()
	myMaterial.setDiffuse(env.color[color])
	myMaterial.setShininess(32)
	return myMaterial

def SetAyuda(padre):
	global a, b, ayudaNP
	ayudaNP = padre.attachNewNode("ayuda")
	ayudaNP.setY(-2)
	#ayudaNP.setX(-4)

	modelov = loader.loadModel("modelos/assets/esfera.bam")
	modelom = loader.loadModel("modelos/assets/esfera.bam")

	verde = Material()
	verde.setDiffuse(env.color["verde"])
	verde.setShininess(32)

	morado = Material()
	morado.setDiffuse(env.color["morado"])
	morado.setShininess(32)

	s = 0.25
	modelov.setScale(s)
	modelom.setScale(s)

	x = -((a)*s)
	for i in range(0, a-b):
		nodo = ayudaNP.attachNewNode("nodox"+str(i))
		nodo.setX(x)
		modelov.instanceTo(nodo)
		modelov.setMaterial(verde, 1)
		x+=0.7
	for i in range(0, b):
		nodo = ayudaNP.attachNewNode("nodoy"+str(i))
		nodo.setX(x)
		modelom.instanceTo(nodo)
		modelom.setMaterial(morado, 1)
		x+=0.7
	ayudaNP.hide()

def Respuestas(padre):
	respuestasNP = padre.attachNewNode("respuestas")
	respuestasNP.setX(5)
	x = -2
	y = 4
	myMaterial = Material()
	myMaterial.setDiffuse((0.8,0.8,0.8,1))
	myMaterial.setShininess(32)
	for i in range(1,13):
		numNP = respuestasNP.attachNewNode(str(i))
		numNP.setPos(x*1.5,y,0)
		if i < 10:
			modelo = loader.loadModel("modelos/numeros/"+str(i)+".bam")
		else:
			modelo = modelos.icon_num(i)
		modelo.setMaterial(myMaterial, 1)
		modelo.instanceTo(numNP)

		coll = numNP.attachNewNode(CollisionNode("collision"))
		coll.node().addSolid(CollisionSphere(0, 0, 0, 1))

		rotar = numNP.hprInterval(1.0, Vec3(0,0,-360))
		rotar.loop()
		rotar.pause()
		picker.acciones[coll] = {
			"over": globals()["rOver"],
			"over_params": rotar,
			"out": globals()["rOut"],
			"out_params": rotar,
			"click": globals()["rClick"],
			"click_params": i
			}
		x+=2
		if x > 3:
			x = -2
			y-= 2.5

def rOver(x, rotar):
	sonido = base.loader.loadSfx("sound/assets/pop.wav")
	sonido.play()
	rotar.resume()
def rOut(x, rotar):
	rotar.pause()
	rotar.setT(0)

def rClick(x, i):
	picker.active=False
	global acertijo, a, b, puntos
	if i == acertijo:   result = 1
	else:			   result = -1
	puntos+=result
	if puntos<=0: puntos = 0

	taskMgr.add(resultado(result))

async def resultado(result):
	global puntos, ayudaNP
	picker.active=False
	if result==-1:
		sonido = base.loader.loadSfx("sound/assets/aww.wav").play()
		SetCorazones(result)
		await Task.pause(1.0)
		ayudaNP.show()
		Cuanto()
	else:
		bien = base.loader.loadSfx("sound/assets/aplausos.wav")
		if puntos<5:
			bien.play()
			SetCorazones(result)
			await Task.pause(3.0)
			SetResta()
		else:
			SetCorazones(result)
			puntos = 0
			puntuacion.puntos["resta"] += 1
			Sequence(Func(Logro)).start()
			puntuacion.SetPuntuacion("Restar", "corazon", "resta")
			await Task.pause(2.5)
			SetResta()
			SetCorazones()

def Logro():
	picker.active=False
	chimes = base.loader.loadSfx("sound/assets/level-up.wav")
	chimes.play()
	padre = env.nodos["logro"]
	padre.show()
	for n in padre.getChildren(): n.removeNode()
	estrella = padre.attachNewNode("estrella")
	modelo = loader.loadModel("modelos/assets/corazon.bam")
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
	padre.hide()

def MkCorazon():
	estrella = NodePath("estrella")
	modelo = loader.loadModel("modelos/assets/corazon.bam")
	modelo.reparentTo(estrella)
	return estrella


def SetCorazones(signo=0):
	global puntos, corazonesNP
	for n in corazonesNP.getChildren(): n.removeNode()
	modelo = loader.loadModel("modelos/assets/corazon.bam")

	barra = corazonesNP.attachNewNode("barra")
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

