# -*- coding: utf-8 -*-

import math
import random
import time
import winsound

from collections import deque
import pyglet
from pyglet import image
from pyglet.gl import glColor3d,GL_LINES,glEnable
from pyglet.gl import glClearColor,GL_CULL_FACE
from pyglet.gl import glTexParameteri,GL_TEXTURE_2D,GL_TEXTURE_MIN_FILTER,GL_NEAREST,GL_TEXTURE_MAG_FILTER
from pyglet.gl import GL_QUADS
from pyglet.gl import glDisable,glViewport,glMatrixMode,glLoadIdentity,glOrtho,GL_DEPTH_TEST,GL_PROJECTION,gluPerspective,glRotatef,glTranslatef,GL_MODELVIEW
from pyglet.graphics import TextureGroup
from pyglet.window import key
import sys

TICKS_PER_SEC = 10
SECTOR_SIZE = 16

# todo tidmätning

N = 5

def ass_point(a,b):
    if round(a[0],6) != round(b[0],6) or round(a[1],6) != round(b[1],6):
        print 'assert failure!'

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

def rotate(px, py, angle):
    # Roterar en punkt (px,py) moturs runt origo, givet en vinkel i grader
    a = math.radians(angle)
    qx = math.cos(a) * px - math.sin(a) * py
    qy = math.sin(a) * px + math.cos(a) * py
    return qx, qy
ass_point(rotate(0,0,0), (0,0))
ass_point(rotate(0,0,90), (0,0))
ass_point(rotate(1,0,90), (0,1))
ass_point(rotate(1,0,180), (-1,0))
ass_point(rotate(1,0,270), (0,-1))
ass_point(rotate(1,0,45), (0.707107,0.707107))
ass_point(rotate(1,0,60), (0.5,math.sqrt(3)/2))

class QuadCopter():
    def __init__(self, model):
        self.model = model
        self.position = (-N-10,5,-N+1)  # x,y,z
        self.angle = 0  # grader

    def update(self, keys):
        x,y,z = self.position
        dx,dy,dz = 0,0,0
        if keys != []:
            k = keys.pop()
            if k == key.W:  # up
                dy = 1
            elif k == key.S:  # down
                dy = -1
            elif k == key.UP:
                dx = 1
            elif k == key.DOWN:
                dx = -1
            elif k == key.LEFT:
                dz = -1
            elif k == key.RIGHT:
                dz = 1

        if dy==0 and (x+10+dx,1,z+dz) in self.model.world:
            winsound.PlaySound('laser.wav', winsound.SND_FILENAME)
        else:
            self.model.remove_block((x+10,1,z), immediate=True)
            x += dx
            z += dz
            y += dy
            self.model.add_block((x+10,1,z), BRICK, immediate=True)
        self.position = (x,y,z)

class Model(object):

    def __init__(self):
        self.count = 0
        self.batch = pyglet.graphics.Batch()
        self.group = TextureGroup(image.load(TEXTURE_PATH).get_texture())
        self.world = {}
        self.shown = {}
        self._shown = {}
        self.sectors = {}
        self.queue = deque()
        self.targets = 0

        maze = Maze3D(self)

        self.quadcopter = QuadCopter(self)
        #self.quadcopter.position = (-N-3,5,0)
        self.quadcopter.angle = 90
        self.start = None
        self.time = ''

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
        self.keys = []

        self.model = Model()
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
        if self.keys==[]:
            return
        qc = self.model.quadcopter
        qc.update(self.keys)
        key = normalize(qc.position)
        if key in self.model.world: # and key[1] > 0:
            winsound.PlaySound('laser.wav', winsound.SND_FILENAME)
            if self.model.start == None:
                self.model.start = time.clock()
            self.model.targets -= 1
            #self.model.remove_block(key)
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

    def on_key_press(self, symbol, modifiers):
        self.keys.append(symbol)

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
        self.clear()
        self.set_3d()
        glColor3d(1, 1, 1)
        self.model.batch.draw()
        self.set_2d()
        self.draw_label()
        self.draw_reticle()

    def draw_label(self):
        qc = self.model.quadcopter
        x, y, z = qc.position
        self.labels[0].text = 'x=%d z=%d' % (x+10, z)
        for label in self.labels: label.draw()

    def draw_reticle(self):  # hårkors
        glColor3d(0, 0, 0)
        self.reticle.draw(GL_LINES)

class Maze3D():
    def __init__(self,model):
        self.model = model
        for x in range(-N,N+1):
            for z in range(-N,N+1):
                model.add_block((x, 1, z), GRASS, immediate=False)
                model.add_block((x, 0, z), STONE, immediate=False)
        self.build(0,1,0)
        model.remove_block((-N,1,-N+1))
        model.remove_block((N,1,N-1))
        model.add_block((-N+0,1,-N+1), BRICK, immediate=False)
        self.dump()

    def build(self,x,y,z):
        self.model.remove_block((x,y,z))
        d = [[-1,0],[1,0],[0,1],[0,-1]]
        random.shuffle(d)
        for dx,dz in d:
            x2 = x+dx+dx
            z2 = z+dz+dz
            if x2 in [-N-1,N+1]: continue
            if z2 in [-N-1,N+1]: continue
            if (x2,1,z2) not in self.model.world: continue
            self.model.remove_block((x+dx,y,z+dz))
            self.build(x2,y,z2)

    def dump(self):
        print "N =",N
        for x in reversed(range(-N,N+1)):
            s = ''
            for z in range(-N,N+1):
                if (x,1,z) in self.model.world and self.model.world[(x,1,z)] == GRASS:
                    s += 'O'
                else:
                    s += ' '
            print s
def setup():
    glClearColor(0.5, 0.69, 1.0, 1)
    glEnable(GL_CULL_FACE)
    glTexParameteri(GL_TEXTURE_2D, GL_TEXTURE_MIN_FILTER, GL_NEAREST)
    glTexParameteri(GL_TEXTURE_2D, GL_TEXTURE_MAG_FILTER, GL_NEAREST)

def main():
    Window(width=1200, height=1000, caption='Maze 2D', resizable=False)
    setup()
    pyglet.app.run()

sys.setrecursionlimit(2500)
random.seed(42)
main()