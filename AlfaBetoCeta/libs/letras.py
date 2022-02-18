
import time
import random

from panda3d.core import Vec4, Vec3
from panda3d.core import NodePath
from panda3d.core import DirectionalLight
from panda3d.core import CollisionNode, CollisionSphere
from direct.interval.IntervalGlobal import Sequence, Parallel, Func, SoundInterval

from libs import env
from libs import picker
from libs import puntuacion
#from libs import logro


acertijo = False
maymin = False

def LetraRandom():
	global acertijo, maymin
	letras_arr = [ "ABCDEFGHIJKLMNÑOPQRSTUVWXYZ" , "abcdefghijklmnñopqrstuvwxyz" ]
	m = random.randint(0,1)
	if m == 0: maymin = "mayúscula"
	else: maymin = "minúscula"
	l = random.randint(0,26)
	acertijo = letras_arr[m][l]
	

def SetLetras():
	global acertijo, maymin
	LetraRandom()
	cual = base.loader.loadSfx("sound/mensajes/cualdetodas.wav")
	letra = base.loader.loadSfx("sound/letras/"+acertijo+".wav")
	tipo = base.loader.loadSfx("sound/mensajes/"+maymin+".wav")
	Sequence( SoundInterval(cual), SoundInterval(letra), SoundInterval(tipo) ).start()

	padre = env.nodos["activo"]
	for n in padre.getChildren(): n.removeNode()

	SetPuntuacion(padre)

	alfabetoNP = padre.attachNewNode("alfabeto")

	mayusculas = "ABCDEFGHIJKLMNÑOPQRSTUVWXYZ"
	minusculas = "abcdefghijklmnñopqrstuvwxyz"

	x = -9.5
	y = 4
	z = 0
	c = 0
	for i in range(0, len(mayusculas)):
		mayuscula = ButtonLetra("mayúscula", mayusculas[i], env.colors[c], "mayus")
		mayuscula.reparentTo(padre)
		mayuscula.setPos(x,y,z)

		minuscula = ButtonLetra("minúscula", minusculas[i], env.colors[c], "minus")
		minuscula.reparentTo(padre)
		minuscula.setPos(x+1,y,z)
		minuscula.setScale(0.7)
		
		x+= 3
		if x > 9.5: 
			x = -9.5
			y+=-2.5
		c += 1
		if c > 8:
			c = 0

	cual = ButtonCual()
	cual.reparentTo(padre)
	cual.setPos(x,y,z)
	cual.setScale(0.7)

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
	global acertijo, maymin
	cual = base.loader.loadSfx("sound/mensajes/cualdetodas.wav")
	letra = base.loader.loadSfx("sound/letras/"+acertijo+".wav")
	tipo = base.loader.loadSfx("sound/mensajes/"+maymin+".wav")
	Sequence(SoundInterval(cual), SoundInterval(letra), SoundInterval(tipo)).start()


def ButtonLetra(tipo, nombre, color, mm):
	letra = NodePath("letra-"+nombre)

	path = "modelos/letras/sans/"+mm+"/"+nombre+".bam"

	modelo = letra.attachNewNode("modelo")
	mesh = loader.loadModel(path)
	mesh.reparentTo(modelo)
	modelo.setColor(color)
	rotar = modelo.hprInterval(1.0, Vec3(0,0,-360))
	rotar.loop()
	rotar.pause()

	coll = letra.attachNewNode(CollisionNode("collision"))
	coll.node().addSolid(CollisionSphere(0, 0, 0, 0.5))
	picker.acciones[coll] = { 
		"over": globals()["LetraOver"], 
		"over_params": rotar,
		"out": globals()["LetraOut"],
		"out_params": rotar,
		"click": globals()["LetraClick"],
		"click_params": [nombre, tipo]
		}
	#coll.show()

	return letra
	
def LetraOver(nodo, rotar):
	sonido = base.loader.loadSfx("sound/assets/pop.wav")
	sonido.play()
	rotar.resume()

def LetraOut(nodo, rotar):
	rotar.pause()
	rotar.setT(0)

def LetraClick(nodo, params):
	global acertijo, maymin
	letra = params[0]
	tipo = params[1]
	if acertijo == letra:
		Actualizar(1)
		LetraRandom()
		aplausos = base.loader.loadSfx("sound/assets/aplausos.wav")
		cual = base.loader.loadSfx("sound/mensajes/cualdetodas.wav")
		letra = base.loader.loadSfx("sound/letras/"+acertijo+".wav")
		tipo = base.loader.loadSfx("sound/mensajes/"+maymin+".wav")
		Sequence( SoundInterval(aplausos), SoundInterval(cual), SoundInterval(letra), SoundInterval(tipo) ).start()
	else:
		aww = base.loader.loadSfx("sound/assets/aww.wav")
		dijo = base.loader.loadSfx("sound/letras/"+letra+".wav")
		may = base.loader.loadSfx("sound/mensajes/"+tipo+".wav")
		equivocado = base.loader.loadSfx("sound/mensajes/tehasequivocado.wav")
		intenta = base.loader.loadSfx("sound/mensajes/intentadenuevo.wav")
		
		cual = base.loader.loadSfx("sound/mensajes/cualdetodas.wav")
		letra = base.loader.loadSfx("sound/letras/"+acertijo+".wav")
		tipo = base.loader.loadSfx("sound/mensajes/"+maymin+".wav")
		Sequence( 
			SoundInterval(aww),
			SoundInterval(equivocado), SoundInterval(intenta), 
			SoundInterval(cual), SoundInterval(letra), SoundInterval(tipo) 
			).start()
		Actualizar(-1)
	
def Cual():
	global acertijo, maymin
	cual = base.loader.loadSfx("sound/mensajes/cualdetodas.wav")
	letra = base.loader.loadSfx("sound/letras/"+acertijo+".wav")
	tipo = base.loader.loadSfx("sound/mensajes/"+maymin+".wav")
	Sequence(SoundInterval(cual), SoundInterval(letra), SoundInterval(tipo)).start()


checks = False
puntos = 0
puntos_max = 5

def SetPuntuacion(padre):
	global cuadros, checks

	barra = padre.attachNewNode("barra")
	barra.setY(-5.5)
	barra.setScale(0.8)

	checks = barra.attachNewNode("checks")
	check = loader.loadModel("modelos/assets/estrella.egg")
	check.setColor(env.color["amarillo"])

	x = -4
	for i in range(1,puntos_max+1):
		ch = checks.attachNewNode(str(i))
		ch.setScale(0.7)
		ch.setPos(x+0.1,0,0.4)
		ch.hide()
		check.instanceTo(ch)
		x += 2

def Actualizar(nuevo):
	global puntos, puntos_max, ckecks
	puntos += nuevo
	if puntos<0: puntos = 0
	if puntos >= puntos_max:
		puntuacion.puntos["abc"] += 1
		puntuacion.SetPuntuacion()
		puntos = 0
		PlayLogro()

	for i in range (1, puntos_max+1):
		p = checks.find(str(i))
		if i < puntos:
			p.show()
		elif i == puntos:
			p.show()
			if nuevo > 0:
				p.hprInterval(1, Vec3(0,0,-360)).start()
		else:
			p.hide()


def PlayLogro():
	padre = env.nodos["logro"]
	padre.show()
	for n in padre.getChildren(): n.removeNode()

	estrella = padre.attachNewNode("estrella")
	modelo = loader.loadModel("modelos/assets/estrella.egg")
	modelo.reparentTo(estrella)
	estrella.setScale(2)

	animacion = Parallel()
	for i in range(-5, 5):
		e = MkEstrella()
		e1 = e.instanceTo(padre)

		xr = (random.randint(0, 5)+5)*random.choice([-1, 1])
		yr = (random.randint(0, 5)+5)*random.choice([-1, 1])
		i1 = e1.posHprInterval(0.5+abs(i/6), Vec3(xr, yr, 10), Vec3(0, 0, 360))
		animacion.append(i1)

	secuencia = Sequence(animacion, animacion, animacion, animacion, Func(Fin))
	secuencia.start()
	
def Fin():
	padre = env.nodos["logro"]
	for n in padre.getChildren(): n.removeNode()

def MkEstrella():
	estrella = NodePath("estrella")
	modelo = loader.loadModel("modelos/assets/estrella.egg")
	modelo.reparentTo(estrella)
	return estrella
