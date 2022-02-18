
from panda3d.core import NodePath


def icon_m():
	salida = NodePath("icon_m")
	a = loader.loadModel("modelos/assets/minusculas.bam")
	a.reparentTo(salida)
	a.setPos(0,0,0)
	a.setR(45)
	return salida

def icon_M():
	salida = NodePath("icon_M")
	a = loader.loadModel("modelos/assets/mayusculas.bam")
	a.reparentTo(salida)
	a.setPos(0,0,0)
	a.setR(45)
	return salida

def icon_sumar():
	salida = NodePath("icon_sumar")
	a = loader.loadModel("modelos/assets/mas.bam")
	a.reparentTo(salida)
	a.setPos(0,0,0)
	a.setR(25)
	return salida

def icon_restar():
	salida = NodePath("icon_restar")
	a = loader.loadModel("modelos/assets/menos.bam")
	a.reparentTo(salida)
	a.setPos(0,0,0)
	a.setR(25)
	return salida

def icon_formas():
	salida = NodePath("icon_formas")
	a = loader.loadModel("modelos/assets/formas.bam")
	a.reparentTo(salida)
	a.setPos(0,0,0)
	a.setScale(1.5)
	a.setR(45)
	return salida

def icon_teclas():
	salida = NodePath("icon_teclas")
	a = loader.loadModel("modelos/assets/tecla.bam")
	a.reparentTo(salida)
	a.setPos(0,0,0)
	a.setScale(1.5)
	return salida

def icon_num(entero):
	e = str(entero)
	num1 = e[0]
	num2 = e[1]
	salida = NodePath("icon_num")

	node1 = salida.attachNewNode("num1")
	node1.setX(-0.3)
	m1 = loader.loadModel("modelos/numeros/"+num1+".bam")
	m1.instanceTo(node1)

	node2 = salida.attachNewNode("num2")
	node2.setX(0.3)
	m2 = loader.loadModel("modelos/numeros/"+num2+".bam")
	m2.instanceTo(node2)

	salida.setScale(0.8)
	return salida



