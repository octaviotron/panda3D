
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

from panda3d.core import Vec3
from direct.task import Task
from direct.interval.LerpInterval import LerpPosInterval
from direct.showbase.ShowBase import DirectObject

# NodePath rotation/zoom using mouse:
#
#	USAGE:
#		instance gimbal passing the target node you want to control with mouse
#			gimb = gimbal.gimbal(some_node)
#		if needed, change target node to be controlled
#			gimb.Set(another_node)
#		when you no longer need to listen gimbal events mouse and end running task:
#			gimb.Destroy()
#
#	CONTROLS:
#		middle click:	starts target node rotation over Z and X axis
# 		right click:	reset target node rotation
#		mouse wheel:	Zooms in/out camera

class gimbal():
	def __init__(self, target_node):
		self.mouse = base.mouseWatcherNode
		self.mouse_enabled = False			# True when mouse2 is pressed, False on button release
		self.gimbal_enabled = True			# If set to False, "Mouse Move" task ends
		self.gimbal = target_node			# Target Node Path to rotate
		self.maxcamfar = -400				# Farest camera can zoom out
		self.mincamnear = -10				# Nearest camera can zoom in

		self.lastH = 0
		self.lastP = 0
		self.newx =0
		self.newy =0
		self.listener = DirectObject.DirectObject()
		
		taskMgr.add(self.MouseMove, 'Mouse Move')
		self.listener.accept('mouse2', self.MoveCam, [True])
		self.listener.accept('mouse2-up', self.MoveCam, [False])
		self.listener.accept('wheel_up', self.ZoomCam, [-1])
		self.listener.accept('wheel_down', self.ZoomCam, [1])
		self.listener.accept('mouse3', self.ResetCam)

	# Change target node to be rotated
	def Set(self, newgimbal):
		self.gimbal = newgimbal

	# Stop "Mouse Move" task and clear events listener 
	def Destroy(self):
		self.gimbal_enabled = False
		self.listener.ignoreAll()

	# Update target node rotation values while mouse2 is pressed
	def MoveCam(self,action):
		if not self.gimbal_enabled: return
		self.mouse_enabled = action
		if action:
			self.newx, self.newy = self.mouse.getMouseX(), self.mouse.getMouseY()
			self.lastH, self.lastP = self.gimbal.getH(), self.gimbal.getP()

	# Updates target rotation values when mouse2 is pressed
	def MouseMove(self, task):
		if not self.gimbal_enabled: return Task.done
		if not base.mouseWatcherNode.hasMouse(): return Task.cont
		if self.mouse_enabled:
			currentx, currenty = self.mouse.getMouseX(), self.mouse.getMouseY()
			x, y = currentx-self.newx, currenty-self.newy
			self.gimbal.setHpr(self.lastH-(360*x*0.5), self.lastP-(360*-y*0.5), 0)
		return Task.cont

	# Zoom in/out in mouse wheel events
	def ZoomCam(self,direction):
		if not self.gimbal_enabled: return
		zoom = 0
		current = base.cam.getY()
		if (direction == 1 and current > self.maxcamfar):
			zoom = (direction*(current))
		if (direction == -1 and current < self.mincamnear):
			zoom = (direction*(current/2))
		new = Vec3(0,current+zoom, 0)
		i = LerpPosInterval(base.cam, 0.3, new, blendType='easeOut').start()

	# Clean target node rotartion
	def ResetCam(self):
		if not self.gimbal_enabled: return
		self.gimbal.setHpr(0,0,0)



