
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

mouse = False
mouse_enabled = False
lastH = 0
lastP = 0
newx =0
newy =0
gimbal = False
gimbal_enabled = False

def Init(gimbalnode):
	global gimbal, mouse, gimbal_enabled
	mouse = base.mouseWatcherNode

	Set(gimbalnode)
	gimbal_enabled = True

	taskMgr.add(MouseMove, 'Mouse Move')
	base.accept('mouse2', MoveCam, [True])
	base.accept('mouse2-up', MoveCam, [False])
	base.accept('wheel_up', ZoomCam, [-1])
	base.accept('wheel_down', ZoomCam, [1])
	base.accept('mouse3', ResetCam)

def Set(gimbalnode):
	global gimbal
	gimbal = gimbalnode

def Unset():
	global gimbal_enabled, gimbal
	gimbal_enabled = False
	gimbal.setHpr(0,0,0)

def MoveCam(action):
	global mouse, mouse_enabled, lastH, lastP, newx, newy, gimbal, gimbal_enabled
	if not gimbal_enabled: return
	mouse_enabled = action
	if action:
		newx, newy = mouse.getMouseX(), mouse.getMouseY()
		lastH, lastP = gimbal.getH(), gimbal.getP()

def MouseMove(task):
	global mouse, mouse_enabled, newx, newy, lastH, lastP, gimbal, gimbal_enabled
	if not gimbal_enabled: return Task.done
	if not base.mouseWatcherNode.hasMouse():
		return Task.cont
	if mouse_enabled:
		currentx, currenty = mouse.getMouseX(), mouse.getMouseY()
		x, y = currentx-newx, currenty-newy
		gimbal.setHpr(lastH-(360*x*0.5), lastP-(360*-y*0.5), 0)
	return Task.cont

def ZoomCam(direction):
	global gimbal_enabled
	if not gimbal_enabled: return
	zoom = 0
	current = base.cam.getY()
	if (direction == 1 and current > -400):
		zoom = (direction*(current))
	if (direction == -1 and current < -10):
		zoom = (direction*(current/2))
	new = Vec3(0,current+zoom, 0)
	i = LerpPosInterval(base.cam, 0.3, new, blendType='easeOut').start()

def ResetCam():
	global gimbal, gimbal_enabled
	if not gimbal_enabled: return
	gimbal.setHpr(0,0,0)

