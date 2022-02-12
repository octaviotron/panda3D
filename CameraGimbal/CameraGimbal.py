
#	This program is free software: you can redistribute it and/or modify it 
#	under the terms of the GNU General Public License as published by the 
#	Free Software Foundation, either version 3 of the License, or 
#	(at your option) any later version.
#
#	This program is distributed in the hope that it will be useful, 
#	but WITHOUT ANY WARRANTY; without even the implied warranty of 
#	MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the 
#	GNU General Public License for more details.
#
#	You should have received a copy of the GNU General Public License along 
#	with this program. If not, see <https://www.gnu.org/licenses/>. 

from direct.showbase.ShowBase import ShowBase

from libs import env
from libs import cameragimbal

class ElEnvBase(ShowBase):
	def __init__(self):
		ShowBase.__init__(self)
		base.setFrameRateMeter(True)
		render.setShaderAuto()
		env.SetEnv()
		cameragimbal.Set()
		TestGimbal()

def TestGimbal():
	from libs import modelos
	from libs import colors
	from libs import conf
	from panda3d.core import LineSegs, NodePath

	t = conf.scene.attachNewNode("test")
	test = t.attachNewNode("test")
	m = modelos.load("assets", "a")
	m.reparentTo(test)
	m.setZ(0.3)
	fondo = modelos.fondo(colors.cyan_d, 1.1, 1.1)
	fondo.reparentTo(test)
	lines = LineSegs()
	lines.moveTo(0,0,0)
	lines.drawTo(10,10,-10)
	lines.setThickness(5)
	node = lines.create()
	np = NodePath(node)
	np.reparentTo(fondo)
	#np.setLightOff()

app = ElEnvBase()
app.run()

