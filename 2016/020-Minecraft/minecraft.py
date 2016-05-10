# -*- coding: utf-8 -*-

# https://github.com/fogleman/Minecraft
# Python 2.7 (ej anaconda)
# Pyglet had to be installed (pip install pyglet)
# texture.png was corrupted
# Startar i riktning norrut, dvs 90 grader matematiskt
# Internt motsvarar y-axeln altituden
# Externt motsvarar z-axeln altituden

# Uppgifter:
#   Spela ljud då man tagit den sista ballongen
#   Ändra skuggan till grå
#   Ändra tegelstenar till något snyggare
#   Spela ljudet i bakgrunden
#   Skapa rotate()
#   Skapa exercise version
#     10 st block längs y-axeln
#     Går bara att åka längs denna
#     Eleverna får lägga in hantering av x-axel, z-axel och rotation
#     Eleverna skapar schackbrädet
#     Skriv ut texter
#     Eleverna skapar targets
#     Lägg in ljud

import math
import random
import time
import winsound

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

    def rotate(self, px, py, angle):
        # Rotate a point counterclockwise by a given angle around (0,0).
        # angle in degrees.
        a = math.radians(angle)
        qx = math.cos(a) * px - math.sin(a) * py
        qy = math.sin(a) * px + math.cos(a) * py
        return qx, qy

    def update(self, dt):
        gp = self.gp
        if gp.B: return
        x,y,z = self.position

        dx = gp.roll/100
        dy = gp.thrust/250
        dz = gp.pitch/100
        da = gp.yaw/5

        self.angle += da
        self.angle %= 360
        dx,dz = self.rotate(dx,dz,self.angle)

        if y < 0: y = 0  # Planet kan inte befinna sig under markytan

        if y > 0:
            x += dx
            z += dz
        y += dy

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
        self.start = None
        self.time = ''

    def _initialize(self):
        n = 20  # 20 # 1/2 width and height of world
        for x in xrange(-n, n + 1):
            for z in xrange(-n, n + 1):
                if x in (-n, n) or z in (-n, n):
                    self.add_block((x, -1, z), STONE, immediate=False)
                else:
                    texture = GRASS if random.randint(1,2) == 1 else SAND
                    self.add_block((x, -1, z), texture, immediate=False)
        self.add_targets(10)

    def add_targets(self,n):
        self.targets = n
        for i in range(n):
            x = random.randint(-20,20)
            y = random.randint(1,10)
            z = random.randint(-20,20)
            self.add_block((x,y,z), BRICK, immediate=False)
            self.add_block((x,-1,z), BRICK, immediate=False)

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

        for y in [10,40,70,100,130]:
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

    def _update(self, dt):
        qc = self.model.quadcopter
        qc.update(dt)
        key = normalize(qc.position)
        if key in self.model.world and key[1] > 0:
            winsound.PlaySound('laser.wav', winsound.SND_FILENAME)
            if self.model.targets == 10:
                self.model.start = time.clock()
            self.model.targets -= 1
            self.model.remove_block(key)
        if self.model.targets > 0 and self.model.start is not None:
            self.model.time = 'time=%.3f' % (time.clock() - self.model.start)

    def on_resize(self, width, height):
        for i in range(5):
            self.labels[i].y = height - [10,40,70,100,130][i]
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
        self.labels[0].text = 'x=%.2f roll=%.2f' % (z, gp.roll)
        self.labels[1].text = 'y=%.2f pitch=%.2f' % (x, -gp.pitch)
        self.labels[2].text = 'z=%.2f thrust=%0.2f' % (y, gp.thrust)
        self.labels[3].text = 'angle=%2d yaw=%0.2f' % ((-qc.angle-180) % 360, gp.yaw)
        self.labels[4].text = 'fps=%02d targets=%d %s' % (pyglet.clock.get_fps(), self.model.targets, self.model.time)
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

main()