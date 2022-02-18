
from panda3d.core import DirectionalLight, AmbientLight, PointLight
from panda3d.core import OrthographicLens, PerspectiveLens
from panda3d.core import Vec4

from libs import conf

def Direccional(padre, intensity):
	plight = DirectionalLight('directional')
	plight.setColor((intensity,intensity,intensity, 1))
	plnp = padre.attachNewNode(plight)
	plnp.setHpr(10,10,10)
	padre.setLight(plnp)

def Ambient(padre, intensity):
	alight = AmbientLight('Ambient')
	alight.setColor((intensity,intensity,intensity, 1))
	alnp = padre.attachNewNode(alight)
	render.setLight(alnp)


