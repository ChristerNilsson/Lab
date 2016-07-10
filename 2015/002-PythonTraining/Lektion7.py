# -*- coding: utf-8 -*-

from pyglet.gl import *
import pygame
from math import cos,sin,pi

################################################
# Övning i att hantera joysticken i pygame.
# 1. Ändra fönstrets rubrik till någon annan text
# 2. Ändra fönstrets storlek
# 3. Ändra uppdateringshastigheten
# 4. Visa thrust och yaw i ett annat hörn. Med grön text.
# 5. Visa roll och pitch med en cirkel
################################################

CPU = True


def pmap(x, (x1, x2), (y1, y2)):
    dx,dy = (float(x2)-x1),(float(y2)-y1)
    return y1 + (x-x1) * dy / dx

class JoyStick():

    def __init__(self):
        if CPU:
            pygame.init()
        pygame.joystick.init()
        self.gp = pygame.joystick.Joystick(0)
        self.gp.init()
        self.update()

    def update(self):
        res = []
        pygame.event.pump()
        gp = self.gp
        for i in range(gp.get_numaxes()):
            res.append(gp.get_axis(i))
        for i in range(gp.get_numbuttons()):
            res.append(gp.get_button(i))
        self.yaw, self.thrust, _, self.pitch, self.roll = res[0:5]
        self.A, self.B, self.X, self.Y = res[5:9]

        if abs(self.pitch) < 0.075:
            self.pitch = 0
        if abs(self.roll) < 0.075:
            self.roll = 0


class Window(pyglet.window.Window):
    def __init__(self, *args, **kwargs):
        super(Window, self).__init__(*args, **kwargs)
        self.joystick = JoyStick()
        pyglet.clock.schedule_interval(self.update, 1.0 / 60)
        self.label = pyglet.text.Label('', font_name='Arial', font_size=18, x=10, y=self.height - 10, anchor_x='left', anchor_y='top', color=(255, 0, 0, 255))

    def on_draw(self):
        self.clear()
        w = self.width
        h = self.height

        glColor3f(1, 1, 1)
        self.circle(w/2,h/2,w/2)

        glColor3f(0, 0, 0)
        self.circle(w/2,h/2,w/30)

        glColor3f(1, 0, 0)
        x = pmap(self.joystick.roll,(-1,1),(0,w))
        y = pmap(self.joystick.pitch,(1,-1),(0,h))
        self.circle(x,y,w/40)

        js = self.joystick
        self.label.text = "pitch={0:.3f} roll={1:.3f} A={2:d} B={3:d}".format(js.pitch, js.roll, js.A, js.B)
        self.label.draw()

    def update(self, dt):
        self.joystick.update()

    def circle(self,x, y, radius):
        iterations = int(2*radius*pi)
        s = sin(2*pi / iterations)
        c = cos(2*pi / iterations)
        dx, dy = radius, 0
        glBegin(GL_TRIANGLE_FAN)
        glVertex2f(x, y)
        for i in range(iterations+1):
            glVertex2f(x+dx, y+dy)
            dx, dy = (dx*c - dy*s), (dy*c + dx*s)
        glEnd()

def main():
    Window(width=1000, height=1000, caption='Quadcopter', resizable=False)
    pyglet.app.run()

if not CPU:
    pygame.init()
main()