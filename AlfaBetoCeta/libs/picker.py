

from panda3d.core import CollisionTraverser, CollisionNode, CollisionHandlerQueue, CollisionRay
from panda3d.bullet import BulletWorld
from direct.task import Task

picker=False
pq=False
pickerRay=False
mouseovercurrent=False
acciones = { "overs": {}, "outs": {}, "clicks":{} }

def SetupPicker():
	global picker,pq,pickerRay
	picker = CollisionTraverser()
	#self.picker.showCollisions(render)
	pq = CollisionHandlerQueue()
	pickerNode = CollisionNode('mouseRay')
	pickerNP = base.cam.attachNewNode(pickerNode)
	pickerRay = CollisionRay()
	pickerNode.addSolid(pickerRay)
	picker.addCollider(pickerNP,pq)

def MouseOverTask(task):
	global picker,pq,mouseovercurrent,pickerRay
	if base.mouseWatcherNode.hasMouse():
		mpos = base.mouseWatcherNode.getMouse()
		pickerRay.setFromLens(base.camNode,mpos.getX(),mpos.getY())
		picker.traverse(render)
		if pq.getNumEntries() > 0:
			pq.sortEntries()
			new = pq.getEntry(0).getIntoNodePath()
			MouseOverEnter(new)
		else:
			if mouseovercurrent:
				MouseOverOut(mouseovercurrent)
	return Task.cont

def MouseOverEnter(new):
	global mouseovercurrent, acciones
	if mouseovercurrent != new:
		if mouseovercurrent: MouseOverOut(mouseovercurrent)
		mouseovercurrent = new
		funcion = acciones[mouseovercurrent]["over"]
		params = acciones[mouseovercurrent]["over_params"]
		funcion(mouseovercurrent, params)

def MouseOverOut(nodo):
	global mouseovercurrent, acciones
	funcion = acciones[mouseovercurrent]["out"]
	params = acciones[mouseovercurrent]["out_params"]
	funcion(mouseovercurrent, params)
	mouseovercurrent = False

def MouseClick():
	global mouseovercurrent
	if mouseovercurrent:
		funcion = acciones[mouseovercurrent]["click"]
		params = acciones[mouseovercurrent]["click_params"]
		funcion(mouseovercurrent, params)
