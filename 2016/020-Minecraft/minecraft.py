# -*- coding: utf-8 -*-

# https://github.com/fogleman/Minecraft
# Python 2.7 (ej anaconda)
# Pyglet had to be installed (pip install pyglet)
# texture.png was corrupted
# Startar i riktning norrut, dvs 90 grader matematiskt

import math
import random
import time

import pygame

from collections import deque
import pyglet
from pyglet import *
from pyglet import image
from pyglet.gl import glColor3d,GL_LINES,glEnable,glFogfv,glHint,glFogi,glFogf,GL_FOG,GL_FOG_COLOR,GL_FOG_HINT
from pyglet.gl import GLfloat,GL_DONT_CARE,GL_FOG_MODE,GL_LINEAR,GL_FOG_START,GL_FOG_END,glClearColor,GL_CULL_FACE
from pyglet.gl import glTexParameteri,GL_TEXTURE_2D,GL_TEXTURE_MIN_FILTER,GL_NEAREST,GL_TEXTURE_MAG_FILTER
from pyglet.gl import glPolygonMode,GL_FRONT_AND_BACK,GL_LINE,GL_QUADS,GL_FILL
from pyglet.gl import glDisable,glViewport,glMatrixMode,glLoadIdentity,glOrtho,GL_DEPTH_TEST,GL_PROJECTION,gluPerspective,glRotatef,glTranslatef,GL_MODELVIEW
from pyglet.graphics import TextureGroup

TICKS_PER_SEC = 60
SECTOR_SIZE = 16
GRAVITY = 20.0
TERMINAL_VELOCITY = 50
PLAYER_HEIGHT = 2

def cube_vertices(x, y, z, n):
    return [
        x-n,y+n,z-n, x-n,y+n,z+n, x+n,y+n,z+n, x+n,y+n,z-n,  # top
        x-n,y-n,z-n, x+n,y-n,z-n, x+n,y-n,z+n, x-n,y-n,z+n,  # bottom
        x-n,y-n,z-n, x-n,y-n,z+n, x-n,y+n,z+n, x-n,y+n,z-n,  # left
        x+n,y-n,z+n, x+n,y-n,z-n, x+n,y+n,z-n, x+n,y+n,z+n,  # right
        x-n,y-n,z+n, x+n,y-n,z+n, x+n,y+n,z+n, x-n,y+n,z+n,  # front
        x+n,y-n,z-n, x-n,y-n,z-n, x-n,y+n,z-n, x+n,y+n,z-n,  # back
    ]

def tex_coord(x, y, n=4):
    m = 1.0 / n
    dx = x * m
    dy = y * m
    return dx, dy, dx + m, dy, dx + m, dy + m, dx, dy + m

def tex_coords(top, bottom, side):
    top = tex_coord(*top)
    bottom = tex_coord(*bottom)
    side = tex_coord(*side)
    result = []
    result.extend(top)
    result.extend(bottom)
    result.extend(side * 4)
    return result

class JoyStick():

    def __init__(self):
        pygame.init()
        pygame.joystick.init()
        self.gp = pygame.joystick.Joystick(0)
        self.gp.init()

    def update(self):
        res = []
        pygame.event.pump()
        for i in range(self.gp.get_numaxes()):
            res.append(self.gp.get_axis(i))
        for i in range(self.gp.get_numbuttons()):
            res.append(self.gp.get_button(i))
        self.yaw, self.thrust, _, self.pitch, self.roll = res[0:5]
        self.thrust = -self.thrust
        #self.yaw = -self.yaw
        self.A, self.B, self.X, self.Y = res[5:9]


TEXTURE_PATH = 'texture.png'

GRASS = tex_coords((1, 0), (0, 1), (0, 0))
SAND  = tex_coords((1, 1), (1, 1), (1, 1))
BRICK = tex_coords((2, 0), (2, 0), (2, 0))
STONE = tex_coords((2, 1), (2, 1), (2, 1))

FACES = [
    ( 0, 1, 0),
    ( 0,-1, 0),
    (-1, 0, 0),
    ( 1, 0, 0),
    ( 0, 0, 1),
    ( 0, 0,-1),
]

def normalize(position):
    x, y, z = position
    x, y, z = (int(round(x)), int(round(y)), int(round(z)))
    return x, y, z

def sectorize(position):
    x, y, z = normalize(position)
    x, y, z = x / SECTOR_SIZE, y / SECTOR_SIZE, z / SECTOR_SIZE
    return x, 0, z

class QuadCopter():
    def __init__(self, gp):
        self.gp = gp
        self.position = (0,0,0)  # x,y,z
        self.angle = 90  # grader
        self.dx, self.dy, self.dz = 0,0,0
        self.da = 0

    def rotate(self, px, py, angle):
        # Rotate a point counterclockwise by a given angle around (0,0).
        # angle in degrees.
        a = math.radians(angle)
        qx = math.cos(a) * px - math.sin(a) * py
        qy = math.sin(a) * px + math.cos(a) * py
        return qx, qy

    def update(self, dt):
        gp = self.gp
        if gp.B:
            return
        x,y,z = self.position

        self.dx = gp.roll/100
        self.dy = gp.thrust/250
        self.dz = gp.pitch/100
        self.da = gp.yaw/5

        self.angle += self.da
        self.angle %= 360
        self.dx,self.dz = self.rotate(self.dx,self.dz,self.angle)

        if y < 0:
            y = 0  # Planet kan inte befinna sig under markytan

        if y > 0:
            x += self.dx
            z += self.dz
        y += self.dy

        self.position = (x,y,z)

class Model(object):

    def __init__(self, gp):
        self.count = 0
        self.batch = pyglet.graphics.Batch()
        self.group = TextureGroup(image.load(TEXTURE_PATH).get_texture())
        self.world = {}
        self.shown = {}
        self._shown = {}
        self.sectors = {}
        self.queue = deque()
        self._initialize()
        self.quadcopter = QuadCopter(gp)

    def _initialize(self):
        n = 20 # 20 # 1/2 width and height of world
        for x in xrange(-n, n + 1):
            for z in xrange(-n, n + 1):
                if x in (-n, n) or z in (-n, n):
                    self.add_block((x, -1, z), STONE, immediate=False)
                else:
                    texture = GRASS if random.randint(1,2) == 1 else SAND
                    self.add_block((x, -1, z), texture, immediate=False)
        self.add_ring_z((-n+3, 5, -n+3), 2)
        self.add_ring_x((n-10, 6, n-5), 3)
        self.add_ring_x((-n+10, 7, n-15), 3)

    def add_ring_z(self,pos,size):
        x,y,z = pos
        for x0 in range(x-size,x+size+1):
            for y0 in range(y-size,y+size+1):
                if x0 in [x-size,x+size] or y0 in [y-size,y+size]:
                    self.add_block((x0,y0,z), BRICK, immediate=False)
        for y0 in range(0,y-size):
            self.add_block((x,y0,z), STONE, immediate=False)

    def add_ring_x(self,pos,size):
        x,y,z = pos
        for y0 in range(y-size,y+size+1):
            for z0 in range(z-size,z+size+1):
                if y0 in [y-size,y+size] or z0 in [z-size,z+size]:
                    self.add_block((x,y0,z0), BRICK, immediate=False)
        for y0 in range(0,y-size):
            self.add_block((x,y0,z), STONE, immediate=False)

    def hit_test(self, position, vector, max_distance=8):
        m = 8
        x, y, z = position
        dx, dy, dz = vector
        previous = None
        for _ in xrange(max_distance * m):
            key = normalize((x, y, z))
            if key != previous and key in self.world:
                return key, previous
            previous = key
            x, y, z = x + dx / m, y + dy / m, z + dz / m
        return None, None

    def exposed(self, position):
        x, y, z = position
        for dx, dy, dz in FACES:
            if (x + dx, y + dy, z + dz) not in self.world:
                return True
        return False

    def add_block(self, position, texture, immediate=True):
        self.count += 1
        self.world[position] = texture
        self.sectors.setdefault(sectorize(position), []).append(position)
        if immediate:
            if self.exposed(position):
                self.show_block(position)
            self.check_neighbors(position)

    def check_neighbors(self, position):
        x, y, z = position
        for dx, dy, dz in FACES:
            key = (x + dx, y + dy, z + dz)
            if key not in self.world:
                continue
            if self.exposed(key):
                if key not in self.shown:
                    self.show_block(key)
            else:
                if key in self.shown:
                    self.hide_block(key)

    def show_block(self, position, immediate=True):
        texture = self.world[position]
        self.shown[position] = texture
        if immediate:
            self._show_block(position, texture)
        else:
            self._enqueue(self._show_block, position, texture)

    def _show_block(self, position, texture):
        x, y, z = position
        vertex_data = cube_vertices(x, y, z, 0.5)
        texture_data = list(texture)
        self._shown[position] = self.batch.add(24, GL_QUADS, self.group,
            ('v3f/static', vertex_data),
            ('t2f/static', texture_data))

    def hide_block(self, position, immediate=True):
        self.shown.pop(position)
        if immediate:
            self._hide_block(position)
        else:
            self._enqueue(self._hide_block, position)

    def _hide_block(self, position):
        self._shown.pop(position).delete()

    def show_sector(self, sector):
        for position in self.sectors.get(sector, []):
            if position not in self.shown and self.exposed(position):
                self.show_block(position, False)

    def hide_sector(self, sector):
        for position in self.sectors.get(sector, []):
            if position in self.shown:
                self.hide_block(position, False)

    def change_sectors(self, before, after):
        before_set = set()
        after_set = set()
        pad = 4
        for dx in xrange(-pad, pad + 1):
            for dy in [0]:  # xrange(-pad, pad + 1):
                for dz in xrange(-pad, pad + 1):
                    if dx ** 2 + dy ** 2 + dz ** 2 > (pad + 1) ** 2:
                        continue
                    if before:
                        x, y, z = before
                        before_set.add((x + dx, y + dy, z + dz))
                    if after:
                        x, y, z = after
                        after_set.add((x + dx, y + dy, z + dz))
        show = after_set - before_set
        hide = before_set - after_set
        for sector in show:
            self.show_sector(sector)
        for sector in hide:
            self.hide_sector(sector)

    def _enqueue(self, func, *args):
        self.queue.append((func, args))

    def _dequeue(self):
        func, args = self.queue.popleft()
        func(*args)

    def process_queue(self):
        start = time.clock()
        while self.queue and time.clock() - start < 1.0 / TICKS_PER_SEC:
            self._dequeue()

    def process_entire_queue(self):
        while self.queue:
            self._dequeue()

class Window(pyglet.window.Window):

    def __init__(self, *args, **kwargs):
        super(Window, self).__init__(*args, **kwargs)
        self.sector = None
        self.reticle = None

        # Joystick
        self.joystick = JoyStick()
        self.model = Model(self.joystick)

        self.label1 = pyglet.text.Label('', font_name='Arial', font_size=18, x=10, y=self.height - 10, anchor_x='left', anchor_y='top', color=(0, 0, 0, 255))
        self.label2 = pyglet.text.Label('', font_name='Arial', font_size=18, x=10, y=self.height - 40, anchor_x='left', anchor_y='top', color=(0, 0, 0, 255))
        self.label3 = pyglet.text.Label('', font_name='Arial', font_size=18, x=10, y=self.height - 70, anchor_x='left', anchor_y='top', color=(0, 0, 0, 255))
        self.label4 = pyglet.text.Label('', font_name='Arial', font_size=18, x=10, y=self.height - 100, anchor_x='left', anchor_y='top', color=(0, 0, 0, 255))
        self.label5 = pyglet.text.Label('', font_name='Arial', font_size=18, x=10, y=self.height - 130, anchor_x='left', anchor_y='top', color=(0, 0, 0, 255))
        pyglet.clock.schedule_interval(self.update, 1.0 / TICKS_PER_SEC)

    def update(self, dt):
        self.model.process_queue()
        sector = sectorize(self.model.quadcopter.position)
        if sector != self.sector:
            self.model.change_sectors(self.sector, sector)
            if self.sector is None:
                self.model.process_entire_queue()
            self.sector = sector
        m = 8
        dt = min(dt, 0.2)
        for _ in xrange(m):
            self._update(dt / m)

    def _update(self, dt):
        self.model.quadcopter.update(dt)

    def collide(self, position, height):
        pad = 0.25
        p = list(position)
        np = normalize(position)
        for face in FACES:  # check all surrounding blocks
            for i in xrange(3):  # check each dimension independently
                if not face[i]:
                    continue
                d = (p[i] - np[i]) * face[i]
                if d < pad:
                    continue
                for dy in xrange(height):  # check each height
                    op = list(np)
                    op[1] -= dy
                    op[i] += face[i]
                    if tuple(op) not in self.model.world:
                        continue
                    p[i] -= (d - pad) * face[i]
                    if face == (0, -1, 0) or face == (0, 1, 0):
                        self.dy = 0
                    break
        return tuple(p)

    def on_resize(self, width, height):
        self.label1.y = height - 10
        self.label2.y = height - 40
        self.label3.y = height - 70
        self.label4.y = height - 100
        self.label5.y = height - 130
        if self.reticle:
            self.reticle.delete()
        x, y = self.width / 2, self.height / 2
        n = 10
        self.reticle = pyglet.graphics.vertex_list(4, ('v2i', (x - n, y, x + n, y, x, y - n, x, y + n)))

    def set_2d(self):
        width, height = self.get_size()
        glDisable(GL_DEPTH_TEST)
        glViewport(0, 0, width, height)
        glMatrixMode(GL_PROJECTION)
        glLoadIdentity()

        glOrtho(0, width, 0, height, -1, 1)
        glMatrixMode(GL_MODELVIEW)
        glLoadIdentity()

    def set_3d(self):
        width, height = self.get_size()
        glEnable(GL_DEPTH_TEST)
        glViewport(0, 0, width, height)
        glMatrixMode(GL_PROJECTION)
        glLoadIdentity()
        gluPerspective(65.0, width / float(height), 0.1, 600.0)  # 60.0
        glMatrixMode(GL_MODELVIEW)
        glLoadIdentity()

        qc = self.model.quadcopter

        x = qc.angle
        y = 0
        glRotatef(x, 0, 1, 0)
        glRotatef(-y, math.cos(math.radians(x)), 0, math.sin(math.radians(x)))

        x, y, z = qc.position
        glTranslatef(-x, -y, -z)

    def on_draw(self):
        self.joystick.update()

        self.clear()
        self.set_3d()
        glColor3d(1, 1, 1)
        self.model.batch.draw()
        #self.draw_focused_block()
        self.set_2d()
        self.draw_label()
        self.draw_reticle()

    def draw_label(self):
        qc = self.model.quadcopter
        gp = qc.gp
        x, y, z = qc.position
        self.label1.text = 'x=%.2f roll=%.2f' % (z, gp.roll)
        self.label2.text = 'y=%.2f pitch=%.2f' % (x, -gp.pitch)
        self.label3.text = 'z=%.2f thrust=%0.2f' % (y, gp.thrust)
        self.label4.text = 'angle=%2d yaw=%0.2f' % ((-qc.angle-180) % 360, gp.yaw)
        self.label5.text = 'fps=%02d' % (pyglet.clock.get_fps())
        self.label1.draw()
        self.label2.draw()
        self.label3.draw()
        self.label4.draw()
        self.label5.draw()

    def draw_reticle(self):  # hårkors
        glColor3d(0, 0, 0)
        self.reticle.draw(GL_LINES)

def setup():
    glClearColor(0.5, 0.69, 1.0, 1)
    glEnable(GL_CULL_FACE)
    glTexParameteri(GL_TEXTURE_2D, GL_TEXTURE_MIN_FILTER, GL_NEAREST)
    glTexParameteri(GL_TEXTURE_2D, GL_TEXTURE_MAG_FILTER, GL_NEAREST)

def main():
    Window(width=1200, height=1000, caption='Quadcopter', resizable=False)
    setup()
    pyglet.app.run()

main()