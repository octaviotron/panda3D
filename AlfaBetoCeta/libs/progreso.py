
from panda3d.core import Vec3

def SetProgreso(puntos, progresoNP, icono, signo=0):
    for n in progresoNP.getChildren(): n.removeNode()
    modelo = loader.loadModel("modelos/assets/"+icono+".bam")

    barra = progresoNP.attachNewNode("barra")
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

