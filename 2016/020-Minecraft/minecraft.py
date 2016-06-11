# -*- coding: utf-8 -*-

import math
import cmath
import random
import time
import winsound

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

MAX_SPEED = 5.0  # boxar/sekund

WIND_ANGLE = 0  # geographiska grader
WIND_SPEED = 0.0  # boxar/sekund

GAME = 0; SUBZERO_FLIGHT = False # Ballons
#GAME = 1; SUBZERO_FLIGHT = True # sponges 3x3x3
#GAME = 3; SUBZERO_FLIGHT = True # sponges 9x9x9
#GAME = 9; SUBZERO_FLIGHT = True # sponges 27x27x27
#GAME = 30; SUBZERO_FLIGHT = True # Maze 3  # Problem med att man ser igenom

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

# def rotate(x, y, angle):
#     # Roterar en punkt (x,y) moturs runt origo, givet en vinkel i grader
#     # Du behöver använda addition, subtraktion, multiplikation samt sinus och cosinus.
#     # Du kan alternativt omforma angle till ett komplext tal och beräkna (x+yi)*(c+di)
#     a = math.radians(angle)
#     qx = x * math.cos(a) - y * math.sin(a)
#     qy = x * math.sin(a) + y * math.cos(a)
#     return qx, qy
def rotate(x, y, angle):
    # Roterar en punkt (x,y) moturs runt origo, givet en vinkel i grader.
    # Använder komplexa tal.
    a = math.radians(angle)
    p = cmath.rect(1,a)
    q = complex(x,y)
    r = p*q
    return r.real, r.imag
ass_point(rotate(0,0,0), (0,0))
ass_point(rotate(0,0,90), (0,0))
ass_point(rotate(1,0,90), (0,1))
ass_point(rotate(2,0,90), (0,2))
ass_point(rotate(1,0,180), (-1,0))
ass_point(rotate(1,0,270), (0,-1))
ass_point(rotate(1,0,45), (0.707107,0.707107))
ass_point(rotate(1,0,60), (0.5,math.sqrt(3)/2))

class QuadCopter():
    def __init__(self, gp, model):
        self.model = model
        self.gp = gp
        self.position = (0,0,0)  # x,y,z
        self.angle = 0  # grader

    def update(self, dt):
        gp = self.gp
        if gp.B: return
        x,y,z = self.position

        dx_wind = dt * WIND_SPEED * math.cos(math.radians(90+WIND_ANGLE - self.angle))
        dz_wind = dt * WIND_SPEED * math.sin(math.radians(90+WIND_ANGLE - self.angle))

        speed = dt * MAX_SPEED

        if abs(gp.roll) < 0.1: gp.roll=0
        if abs(gp.thrust) < 0.1: gp.thrust=0
        if abs(gp.pitch) < 0.1: gp.pitch=0
        if abs(gp.yaw) < 0.1: gp.yaw=0

        dx = gp.roll * speed
        dy = -gp.thrust * speed * 0.5
        dz = gp.pitch * speed
        da = gp.yaw/5

        self.angle += da
        self.angle %= 360

        dx,dz = rotate(dx,dz,self.angle)

        if SUBZERO_FLIGHT:
            x += dx + dx_wind
            z += dz + dz_wind
        else:
            if y < 0:
                y = 0  # Planet kan inte befinna sig under markytan
            if y > 0:
                x += dx + dx_wind
                z += dz + dz_wind
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
        self.targets = 0

        if GAME == 0:
            self._initialize()
        elif GAME == 30:
            maze = Maze3D(self)
        else:
            self.sponge(0,0,0,GAME)

        self.quadcopter = QuadCopter(gp, self)
        #self.quadcopter.position = (-3,-2,-2)
        #self.quadcopter.position = (-12,-2,-2)
        #self.quadcopter.angle = 90
        self.start = None
        self.time = ''

    def sponge(self, a, b, c, n):
        if n == 0:
            self.targets += 1
            return self.add_block((a,b,c), STONE, immediate=False)
        for x in [-1,0,1]:
            for y in [-1,0,1]:
                for z in [-1,0,1]:
                    if abs(x) + abs(y) + abs(z) > 1:
                        self.sponge(a+x*n, b+y*n, c+z*n, n/3)

    def _initialize(self):
        n = 20  # 20 # 1/2 width and height of world
        for x in xrange(-n, n + 1):
            for z in xrange(-n, n + 1):
                if x in (-n, n) or z in (-n, n):
                    self.add_block((x, -1, z), STONE, immediate=False)
                else:
                    texture = GRASS if random.randint(1,2) == 1 else SAND
                    self.add_block((x, -1, z), texture, immediate=False)
        self.add_block((0, -1, 1), STONE, immediate=False)
        self.add_block((0, -1, 0), STONE, immediate=False)
        self.add_block((1, -1, 0), STONE, immediate=False)
        self.add_targets(10)

    def add_targets(self,n):
        for i in range(n):
            self.targets += 1
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
        self.stack = []

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
        position = qc.position
        self.stack.append(position)
        angle = qc.angle
        qc.update(dt)
        if GAME == 30:
            while normalize(qc.position) in self.model.world:
                qc.position = self.stack.pop()
                qc.angle = angle
        else:
            key = normalize(qc.position)
            if key in self.model.world: # and key[1] > 0:
                winsound.PlaySound('laser.wav', winsound.SND_FILENAME)
                if self.model.start == None:
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
        a = qc.angle
        y = 0
        glRotatef(a, 0, 1, 0)
        glRotatef(-y, math.cos(math.radians(a)), 0, math.sin(math.radians(a)))
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

    def draw_label(self):
        qc = self.model.quadcopter
        gp = qc.gp
        x, y, z = qc.position
        self.labels[0].text = 'x=%.6f y=%.2f z=%.2f angle=%2d' % (x, y, z, qc.angle % 360)
        self.labels[1].text = 'roll=%.2f thrust=%0.2f pitch=%.2f yaw=%0.2f' % (gp.roll, gp.thrust, gp.pitch, gp.yaw)
        self.labels[2].text = 'fps=%02d targets=%d %s' % (pyglet.clock.get_fps(), self.model.targets, self.model.time)
        for label in self.labels: label.draw()

    def draw_reticle(self):  # hårkors
        glColor3d(0, 0, 0)
        self.reticle.draw(GL_LINES)

class Maze3D():
    def __init__(self,model):
        self.model = model
        self.N = 3
        N = self.N
        for x in range(-N,N+1):
            for y in range(-N,N+1):
                for z in range(-N,N+1):
                    model.add_block((x, y, z), STONE, immediate=False)
        self.build(0,0,0)
        model.remove_block((-N,-N+1,-N+1))
        model.remove_block((N,N-1,N-1))

    def build(self,x,y,z):
        N = self.N
        self.model.remove_block((x,y,z))
        d = [[-1,0,0],[1,0,0],[0,-1,0],[0,1,0],[0,0,1],[0,0,-1]]
        random.shuffle(d)
        for dx,dy,dz in d:
            x2 = x+dx+dx
            y2 = y+dy+dy
            z2 = z+dz+dz
            if x2 in [-N-1,N+1]: continue
            if y2 in [-N-1,N+1]: continue
            if z2 in [-N-1,N+1]: continue
            if (x2,y2,z2) not in self.model.world: continue
            self.model.remove_block((x+dx,y+dy,z+dz))
            self.build(x2,y2,z2)

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