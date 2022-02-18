#!/usr/bin/env python3
# -*- coding: utf-8 -*-
#
#   This program is free software: you can redistribute it and/or modify it 
#   under the terms of the GNU General Public License as published by the 
#   Free Software Foundation, either version 3 of the License, or 
#   (at your option) any later version.
#
#   This program is distributed in the hope that it will be useful, 
#   but WITHOUT ANY WARRANTY; without even the implied warranty of 
#   MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the 
#   GNU General Public License for more details.
#
#   You should have received a copy of the GNU General Public License along 
#   with this program. If not, see <https://www.gnu.org/licenses/>. 
#
#   Developed by Octavio Rossell Tabet <octavio.rossell@gmail.com>
#


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

