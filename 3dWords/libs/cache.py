


import os

fcache = {}

def Cache(font, char):
	global fcache
	if not font in fcache:
		fcache[font] = {}
	if not char in fcache[font]:
		mesh = LoadChar(font, char)
		ancho = mesh.getTightBounds()[1][0]
		fcache[font][char] = { "mesh":mesh, "ancho":ancho }
	return fcache[font][char]


def LoadChar(font, char):
	dirname = os.path.dirname(__file__)
	model_path = os.path.join(dirname, 'fonts', font, 'glb/'+str(ord(char))+'.glb')
	model = loader.loadModel(model_path)
	salida = model.getChildren()[0].getChildren()[0]
	return salida

