from panda3d.core import *
#from direct.tkpanels.Inspector import inspect
from direct.interval.IntervalGlobal import *
from direct.showbase.ShowBase import ShowBase
from direct.showbase.DirectObject import DirectObject
import simplepbr
import random

#loadPrcFileData("", "win-size 1280 720")
loadPrcFileData("", "fullscreen 1")
#loadPrcFileData("", "model-cache 0")
#loadPrcFileData("", "model-cache-dir")
loadPrcFileData("", "vertex-buffer-sharing #t") 

class main(ShowBase):
	def __init__(self):
		super().__init__()
		pipeline = simplepbr.init( )
		self.setBackgroundColor(0,0,0,0.0)

		base.cam.setPos(0,-25,0)
		luces()
		mainnode = render.attachNewNode("Nodo Principal")

		grupo1 = mainnode.attachNewNode("Grupo1")
		grupo1.setPos(0,5,0)
		nodo1 = Nodo(name='nodo1', model_path="./modelos/snaregris.obj", escala=1, pos=Vec3(0, 0, 0), tecla='1')
		nodo1.nodepath.reparentTo(grupo1)
		giro1 = girar(nodo1.nodepath, 3.0, Vec3(0, 360, 0))
		nodo1.secuencia.append(giro1)
		giro12 = girar(nodo1.model, 2.0, Vec3(0, 0, 360))
		nodo1.secuencia.append(giro12)
		latido = latir(nodo1.nodepath, vel=0.2)
		latido.loop()
		nodo1.secuencia.append(latido)

		grupo_orb = mainnode.attachNewNode("Grupo Orb")
		for i in range(20):
			#grupoo(grupo_orb, "orb", "./modelos/s2.bam", lat=False, gir=True, mine=0.3, maxe=0.5)
			grupoo(grupo_orb, "orb", "./modelos/snareama.obj", lat=False, gir=True, mine=0.3, maxe=0.5)
		for i in range(10):
			grupoo(grupo_orb, "orb", "./modelos/snarev.obj", lat=True, gir=False, mine=0.2, maxe=0.4, minf=0.3, maxf=1, mins=0.3, maxs=2)

		grupo3 = mainnode.attachNewNode("Grupo3")
		for i in range(10):
			grupoh(grupo3, 'grupo3'+str(i))

		grupo5 = mainnode.attachNewNode("Grupo5")
		for i in range(10):
			grupot(grupo5, 'grupo5')

		self.accept('escape', self.salir)

	def salir(self):
		self.userExit()

def grupoo(padre, name, modelo, lat=False, gir=False, mine=0.1, maxe=0.2, minf=2, maxf=3, mins=1, maxs=2):
	nombre = name+str(random.randint(1, 5000))
	wrapnode = padre.attachNewNode(nombre)
	randx = random.uniform(3,7)
	escala = random.uniform(mine, maxe)
	nodo = Nodo(name=nombre, model_path=modelo, escala=escala, pos=Vec3(randx,0,0), tecla='2')
	nodo.nodepath.reparentTo(wrapnode)

	if gir==True:
		vel = random.uniform(10,50)
		velgiro = escala*vel
		giro2 = girar(nodo.nodepath, velgiro, Vec3(0, 0, 360))
		nodo.secuencia.append(giro2)

	velflip = random.uniform(minf, maxf)
	giro21 = girar(nodo.model, velflip, Vec3(360, 0, 0))
	nodo.secuencia.append(giro21)

	if lat==True:
		latido = latir(nodo.nodepath, size=Vec3(2,2,2), mins=mins, maxs=maxs)
		latido.loop()
		nodo.secuencia.append(latido)

	randgiro = random.randint(-180, 180)
	wrapnode.setR(randgiro)
	

def grupoh(padre, name):
	nombre = name+str(random.randint(1, 5000))
	#escala = random.uniform(0.5,0.9)
	startx = random.uniform(-2,0)-14
	posiciones = desdehasta(0,0,3)
	velgiro = random.uniform(1,5)
	velmover = random.uniform(1,5)
	nodo = Nodo(name=nombre, model_path="./modelos/s3.bam", escala=1.0, pos=Vec3(-15,0,0), tecla='3')
	nodo.nodepath.reparentTo(padre)
	trasladar(nodo)
	#giro = girar(nodo.model, velgiro, Vec3(0, 360, 0))
	#nodo.secuencia.append(giro)
	mov = mover(nodo.nodepath, velmover, Point3(15, 0, 0), Point3(-15, 0, 0))
	nodo.secuencia.append(mov)
	delay=Wait(velmover)
	seq1 = Sequence(delay, Func(trasladar, nodo))
	seq1.loop()
	nodo.secuencia.append(seq1)
	return nodo

def grupot(padre, name):
	nombre = name+str(random.randint(1, 5000))
	nodo = Nodo(name=nombre, model_path="./modelos/s5.bam", escala=1.0, pos=Vec3(0,0,0), tecla='5')
	nodo.nodepath.reparentTo(padre)
	velmover = random.uniform(0.5,2)
	delay=Wait(velmover)
	seq1 = Sequence(Func(parpadear, nodo), Wait(random.uniform(0.1,2.0)))
	seq1.loop()
	nodo.secuencia.append(seq1)

def parpadear(nodo):
	posiciones = desdehasta(5,0,3)
	nodo.nodepath.setPos(posiciones[0])
	escala = random.uniform(0.1,0.7)
	nodo.nodepath.setScale(escala, escala, escala)
	randgiro = random.randint(-180, 180)
	nodo.model.setHpr(randgiro,randgiro,randgiro)

def girar(nodo, tiempo, giro):
	giro = nodo.hprInterval(tiempo, giro)
	giro.loop()
	return giro

def mover(nodo, tiempo, pos, spos=False):
	if spos==False:
		mover = nodo.posInterval(duration=tiempo, pos=pos)
	else:
		mover = nodo.posInterval(duration=tiempo, pos=pos, startPos=spos)
	mover.loop()
	return mover

def trasladar(nodo, variacion=3):
	posicion = desdehasta(0,0,variacion)
	nodo.model.setPos(posicion[0])
	escala = random.uniform(0.5,0.9)
	nodo.model.setScale(escala, escala, escala)
	randgiro = random.randint(-180, 180)
	nodo.model.setHpr(randgiro,randgiro,randgiro)

def desdehasta(x, y, z):
	minx=-x-x
	maxx=x+x
	miny=-y-y
	maxy=y+y
	minz=-z-z
	maxz=z+z
	
	rndx = random.uniform(minx, maxx)
	rndy = random.uniform(miny, maxy)
	rndz = random.uniform(minz, maxz)
		
	desde = Point3(rndx, rndy, rndz)
	hasta = Point3(-rndx, -rndy, -rndz)

	return [desde,hasta]

def latir(nodo, vel=False, size=False, mins=1, maxs=2):
	rs = random.uniform(0.3,2.0)
	rv = random.uniform(0.3,2.0)
	mi = Vec3(mins, mins, mins)
	ma = Vec3(maxs, maxs, maxs)
	if vel==False:
		vel = rv
	agrandar = LerpScaleInterval(nodo, vel, ma, mi)
	reducir = LerpScaleInterval(nodo, vel, mi, ma)
	latir = Sequence(agrandar, reducir)
	#latir.loop()
	return latir


class Nodo(PandaNode, DirectObject):
	def __init__(self, name, model_path, escala, pos, tecla):
		PandaNode.__init__(self, name)
		DirectObject.__init__(self)
		
		self.name = name
		self.model_path = model_path
		self.escala = escala
		self.position = pos
		self.tecla = tecla
		self.nodepath = NodePath(self)
		self.model = loader.loadModel(self.model_path)
		self.model.reparentTo(self.nodepath)

		#self.model.flattenStrong()

		self.model.setPos(pos)
		self.model.setScale(self.escala, self.escala, self.escala)

		#self.model.writeBamFile("modelo"+name+".bam")

		self.secuencia = Parallel()
		self.secuencia.loop()

		#self.nodepath.hide()
		self.accept(self.tecla, self.ver)

	def ver(self):
		if not self.nodepath.is_empty():
			self.nodepath.show()
			
def luces():
	main_light = PointLight("main_light")
	main_light.setColor(Vec4(2.5, 2.2, 2.0, 1))  # Blanco cálido
	main_light.setAttenuation(Vec3(0.2, 0.02, 0.005))  # Atenuación
	main_light_np = render.attachNewNode(main_light)
	main_light_np.setPos(3, -13, 5)  # Posición diagonal superior
	render.setLight(main_light_np)

	# 2. Luz tenue (ambiente fría)
	subtle_light = PointLight("subtle_light")
	subtle_light.setColor(Vec4(0.5, 0.6, 0.8, 1))  # Azul frío tenue
	subtle_light.setAttenuation(Vec3(0.8, 0.05, 0.01))  # Mayor alcance
	subtle_light_np = render.attachNewNode(subtle_light)
	subtle_light_np.setPos(-2, -12, -2)  # Posición contraria
	render.setLight(subtle_light_np)

app = main()
app.run()
