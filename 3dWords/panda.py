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

import sys
import gltf

from direct.showbase.ShowBase import ShowBase
from panda3d.core import AmbientLight, DirectionalLight, Vec4

from libs import word3d

class ElEnvBase(ShowBase):
	def __init__(self):
		ShowBase.__init__(self)
		gltf.patch_loader(self.loader)
		self.Main()

		self.accept('escape', self._Out)

	def Main(self):
		camara = render.attachNewNode("CAMERA")
		camara.setY(-10)
		base.camera.reparentTo(camara)

		alight = AmbientLight('Ambient')
		alight.setColor(Vec4(0.1,0.1,0.1, 1))
		alnp = render.attachNewNode(alight)
		render.setLight(alnp)
		dlight = DirectionalLight('directional')
		dlight.setColor(Vec4(0.8,0.8,0.8,1))
		dlnp = render.attachNewNode(dlight)
		dlnp.setPos(50,-50,50)
		dlnp.lookAt(0,0,0)
		render.setLight(dlnp)

		
		w3d = word3d.Word3d()
		w3d.fontname = "DejaVuSansMono"
		w3d.center = True
		w3d.color = (0,0,1,1)
		w3d.scale = 1
		w3d.spacing = 0
		label = w3d.Word("Test")
		label.reparentTo(render)

		label.setHpr(30,100,10)


	def _Out(self):
		sys.exit()




app = ElEnvBase()
app.run()

