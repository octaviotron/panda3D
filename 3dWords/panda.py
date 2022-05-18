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

from libs.word3d import word3d

class ElEnvBase(ShowBase):
	def __init__(self):
		ShowBase.__init__(self)
		gltf.patch_loader(self.loader)

		self.Main()

		self.accept('escape', self._Out)

	def Main(self):
		camara = render.attachNewNode("CAMERA")
		camara.setY(-15)
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

		p1 = word3d("FreeSans","Panda3D")
		p1.reparentTo(render)
		p1.Center()
		p1.Color(Vec4(1,0,0,1))
		p1.setHpr(10,100,10)

		p2 = word3d("DejaVuSansMono", "Rulz :-)")
		p2.reparentTo(render)
		p2.Center()
		p2.Color(Vec4(1,1,0,1))
		p2.setZ(-2)
		p2.setHpr(10,100,10)

	def _Out(self):
		sys.exit()




app = ElEnvBase()
app.run()

