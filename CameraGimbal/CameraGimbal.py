
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
from libs import test

import simplepbr
import gltf

class ElEnvBase(ShowBase):
	def __init__(self):
		ShowBase.__init__(self)
		gltf.patch_loader(self.loader)
		base.setFrameRateMeter(True)
		pbr = simplepbr.init()
		pbr.use_hardware_skinning = True
		pbr.msaa_samples = 8
		#pbr.enable_shadows = True
		pbr.use_330 = True # export MESA_GL_VERSION_OVERRIDE="3.00 ES"
		pbr.use_normal_maps = True
		pbr.use_emission_maps = True
		pbr.use_occlusion_maps = True
		pbr.enable_fog = True
		
		env.SetEnv()
		cameragimbal.Set()
		test.Test()

app = ElEnvBase()
app.run()

