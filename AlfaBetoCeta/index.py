
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

