#from panda3d.core import NodePath, Vec3, Material
#from panda3d.core import CollisionNode, CollisionSphere

from libs import env
from libs import picker
from libs import modelos
from libs import word3d

def SetAcerca():
	padre = env.nodos["activo"]
	for n in padre.getChildren(): n.removeNode()

	texto = padre.attachNewNode("texto")
	
	titulo = word3d.MkWord("AlfaBetoCeta", "4", True)
	titulo.setY(5)
	titulo.reparentTo(texto)

	devel = word3d.MkWord("Desarrollado por", 2, True)
	devel.setY(2)
	devel.setScale(0.6)
	devel.reparentTo(texto)

	devel = word3d.MkWord("Octavio Rossell", 2, True)
	devel.setY(1)
	devel.setScale(0.6)
	devel.reparentTo(texto)

	devel = word3d.MkWord("Licencia GPLv3", 4, True)
	devel.setY(-1)
	devel.setScale(0.6)
	devel.reparentTo(texto)
