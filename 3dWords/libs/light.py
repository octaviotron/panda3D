
from panda3d.core import DirectionalLight, AmbientLight, PointLight
from panda3d.core import OrthographicLens, PerspectiveLens
from panda3d.core import Vec4

def Direccional(padre, intensity):
	plight = DirectionalLight('directional')
	plight.setColor((intensity,intensity,intensity, 1))
	#plight.setShadowCaster(True, 1024, 1024)
	#plight.showFrustum()
	"""
	lens = OrthographicLens()
	lens.setNearFar(5, 20)
	lens.setFilmSize(20, 20)
	plight.setLens(lens)
	"""
	plnp = padre.attachNewNode(plight)
	plnp.setHpr(15,-15,0)
	plnp.setPos(0,-10,0)
	padre.setLight(plnp)

def Ambient(padre, intensity):
	alight = AmbientLight('Ambient')
	alight.setColor((intensity,intensity,intensity, 1))
	alnp = padre.attachNewNode(alight)
	render.setLight(alnp)


