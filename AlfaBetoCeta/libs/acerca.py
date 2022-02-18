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
