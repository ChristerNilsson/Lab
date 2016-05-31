# -*- coding: utf-8 -*-

import math
import time

import pygame

from collections import deque
import pyglet
from pyglet import image
from pyglet.gl import glColor3d,GL_LINES,glEnable
from pyglet.gl import glClearColor,GL_CULL_FACE
from pyglet.gl import glTexParameteri,GL_TEXTURE_2D,GL_TEXTURE_MIN_FILTER,GL_NEAREST,GL_TEXTURE_MAG_FILTER
from pyglet.gl import GL_QUADS
from pyglet.gl import glDisable,glViewport,glMatrixMode,glLoadIdentity,glOrtho,GL_DEPTH_TEST,GL_PROJECTION,gluPerspective,glRotatef,glTranslatef,GL_MODELVIEW
from pyglet.graphics import TextureGroup

TICKS_PER_SEC = 60
SECTOR_SIZE = 16

CPU = True  # Eftersom min laptop och min CPU uppför sig olika. Symptomet är att programmet hänger sig vid start.

MAX_SPEED = 2.0  # boxar/sekund

def ass(a,b):
    if round(a,6) != round(b,6):
        print 'assert failure!'
        assert False

def ass_point(a,b):
    if round(a[0],6) != round(b[0],6) or round(a[1],6) != round(b[1],6):
        print 'assert failure!'
        assert False

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
        if CPU:
            pygame.init()
        pygame.joystick.init()
        self.gp = pygame.joystick.Joystick(0)
        self.gp.init()
        self.pitch = 0

    def update(self):
        res = []
        pygame.event.pump()
        for i in range(self.gp.get_numaxes()):
            res.append(self.gp.get_axis(i))
        for i in range(self.gp.get_numbuttons()):
            res.append(self.gp.get_button(i))
        self.yaw, self.thrust, _, self.pitch, self.roll = res[0:5]
        self.A, self.B, self.X, self.Y = res[5:9]

TEXTURE_PATH = 'texture_clean.png'

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

ass(math.radians(0),0)
ass(math.radians(30),30 * math.pi / 180)
ass(math.radians(45),45 * math.pi / 180)
ass(math.radians(60),60 * math.pi / 180)
ass(math.radians(90),90 * math.pi / 180)

def sin(angle):
    return round(math.sin(math.radians(angle)),6)
ass(sin(0), 0)
ass(sin(30), 0.5)
ass(sin(45), 1/math.sqrt(2))
ass(sin(60), math.sqrt(3)/2)
ass(sin(90), 1)
ass(sin(120), math.sqrt(3)/2)
ass(sin(135), 1/math.sqrt(2))
ass(sin(150), 0.5)
ass(sin(180), 0)
ass(sin(210), -0.5)
ass(sin(225), -1/math.sqrt(2))
ass(sin(240), -math.sqrt(3)/2)
ass(sin(270), -1)
ass(sin(300), -math.sqrt(3)/2)
ass(sin(315), -1/math.sqrt(2))
ass(sin(330), -0.5)

def cos(angle):
    return round(math.cos(math.radians(angle)),6)
ass(cos(0), 1)
ass(cos(30), math.sqrt(3)/2)
ass(cos(45), 1/math.sqrt(2))
ass(cos(60), 0.5)
ass(cos(90), 0)
ass(cos(120), -0.5)
ass(cos(135), -1/math.sqrt(2))
ass(cos(150), -math.sqrt(3)/2)
ass(cos(180), -1)
ass(cos(210), -math.sqrt(3)/2)
ass(cos(225), -1/math.sqrt(2))
ass(cos(240), -0.5)
ass(cos(270), 0)
ass(cos(300), 0.5)
ass(cos(315), 1/math.sqrt(2))
ass(cos(330), math.sqrt(3)/2)


# def rotate(px, py, angle):
#     # Roterar en punkt (px,py) moturs runt origo, givet en vinkel i grader
#     # Du behöver använda addition, subtraktion, multiplikation samt sinus och cosinus.
#     a = math.radians(angle)
#     qx = 00
#     qy = 00
#     return qx, qy
# ass_point(rotate(0,0,0), (0,0))
# ass_point(rotate(0,0,90), (0,0))
# ass_point(rotate(1,0,90), (0,1))
# ass_point(rotate(2,0,90), (0,2))
# ass_point(rotate(1,0,180), (-1,0))
# ass_point(rotate(1,0,270), (0,-1))
# ass_point(rotate(1,0,45), (0.707107,0.707107))
# ass_point(rotate(1,0,60), (0.5,math.sqrt(3)/2))

class QuadCopter():
    def __init__(self, gp):
        self.gp = gp
        self.position = (0,0,0)  # x,y,z
        self.angle = 0  # geografiska grader

    def update(self, dt):  #02#  #03#  #04.5#
        gp = self.gp
        x,y,z = self.position
        speed = dt * MAX_SPEED
        dz = gp.pitch * speed
        z += dz
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

    def _initialize(self):  #01#  #05#  #07#  #09#
        n = 2
        for z in xrange(-n, n + 1):
            texture = [SAND,GRASS][z%2]
            self.add_block((0, -1, z), texture, immediate=False)
        self.add_block((0, -1, 1), STONE, immediate=False)
        self.add_block((0, -1, 0), STONE, immediate=False)
        self.add_block((1, -1, 0), STONE, immediate=False)

    def exposed(self, position):
        x, y, z = position
        for dx, dy, dz in FACES:
            if (x + dx, y + dy, z + dz) not in self.world: return True
        return False

    def add_block(self, position, texture, immediate=True):
        self.count += 1
        self.world[position] = texture
        self.sectors.setdefault(sectorize(position), []).append(position)
        if immediate:
            if self.exposed(position):
                self.show_block(position)
            self.check_neighbors(position)

    def remove_block(self, position, immediate=True):
        del self.world[position]
        self.sectors[sectorize(position)].remove(position)
        if immediate:
            if position in self.shown:
                self.hide_block(position)
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
        self.labels = []

        for y in [10,40,70]:  #04#
            self.labels.append(pyglet.text.Label('', font_name='Arial', font_size=18, x=10, y=self.height - y, anchor_x='left', anchor_y='top', color=(0, 0, 0, 255)))

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

    def _update(self, dt):  #06#  #06.5#  #08#
        qc = self.model.quadcopter
        qc.update(dt)

    def on_resize(self, width, height):
        for i in range(3):  #04#
            self.labels[i].y = height - [10,40,70][i]
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
        gluPerspective(65.0, width / float(height), 0.1, 600.0)
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
        self.set_2d()
        self.draw_label()
        self.draw_reticle()

    def draw_label(self):  #04#
        qc = self.model.quadcopter
        gp = qc.gp
        x, y, z = qc.position
        self.labels[0].text = 'z=%.2f' % (z)
        self.labels[1].text = 'pitch=%.2f' % (gp.pitch)
        self.labels[2].text = 'fps=%02d' % (pyglet.clock.get_fps())
        for label in self.labels: label.draw()

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

if not CPU:
    pygame.init()
main()