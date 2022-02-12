
from panda3d.core import DirectionalLight, AmbientLight
from panda3d.core import OrthographicLens
from panda3d.core import Vec4

from libs import conf

def Direccional(padre, intensity):
	plight = DirectionalLight('directional')
	plight.setColor((intensity,intensity,intensity, 1))
	plnp = padre.attachNewNode(plight)
	plnp.setPos(12, 12, 20)
	plnp.setHpr(-45,-130,0)
	lens = OrthographicLens()
	lens.setNearFar(10, 40)
	lens.setFilmSize(20, 20)
	plight.setLens(lens)
	plight.setShadowCaster(True, 1024,1024)
	#plight.showFrustum()
	padre.setLight(plnp)
	Complement(padre)
	#Ambient(padre, 0.1)

def Complement(padre):
	plight = DirectionalLight('complement')
	intensity = 0.3
	plight.setColor((intensity,intensity,intensity, 1))
	plnp = padre.attachNewNode(plight)
	plnp.setPos(-15, -15, -20)
	plnp.setHpr(-45,45,-0)
	lens = OrthographicLens()
	lens.setNearFar(20, 40)
	lens.setFilmSize(20, 20)
	plight.setLens(lens)
	padre.setLight(plnp)
	plight.setShadowCaster(False)
	#plight.showFrustum()


def Ambient(padre, intensity):
	alight = AmbientLight('Ambient')
	alight.setColor((intensity,intensity,intensity, 1))
	alnp = padre.attachNewNode(alight)
	render.setLight(alnp)
	#padre.setShaderAuto()


