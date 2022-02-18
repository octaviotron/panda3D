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

from direct.showbase.ShowBase import ShowBase

from libs import env
from libs import menu
from libs import barra
from libs import picker

import sys

class ElEnvBase(ShowBase):
	def __init__(self):
		ShowBase.__init__(self)
		render.setShaderAuto()
		env.SetEnv()
		picker.SetupPicker()
		taskMgr.add(picker.MouseOverTask, 'Mouse Over Task')
		self.accept('mouse1', picker.MouseClick)
		self.accept('escape', Salir)
		base.buttonThrowers[0].node().setKeystrokeEvent('keystroke')

		AlfaBetoCeta()


def AlfaBetoCeta():
	menu.SetMenu()
	barra.SetBarra()

def Salir():
	sys.exit()

app = ElEnvBase()
app.run()

