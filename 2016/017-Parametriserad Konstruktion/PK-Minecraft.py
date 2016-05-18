# -*- coding: utf-8 -*-

import math
import time

from collections import deque
import pyglet
from pyglet import image
from pyglet.gl import glColor3d,GL_LINES,glEnable
from pyglet.gl import glClearColor,GL_CULL_FACE
from pyglet.gl import glTexParameteri,GL_TEXTURE_2D,GL_TEXTURE_MIN_FILTER,GL_NEAREST,GL_TEXTURE_MAG_FILTER
from pyglet.gl import GL_QUADS
from pyglet.gl import glDisable,glViewport,glMatrixMode,glLoadIdentity,glOrtho,GL_DEPTH_TEST,GL_PROJECTION,gluPerspective,glRotatef,glTranslatef,GL_MODELVIEW
from pyglet.graphics import TextureGroup

import pygame

TICKS_PER_SEC = 60
SECTOR_SIZE = 16

CPU = True  # Eftersom min laptop och min CPU uppför sig olika. Symptomet är att programmet hänger sig vid start.

MAX_SPEED = 2.0  # boxar/sekund

def ass_point(a,b):
    if round(a[0],6) != round(b[0],6) or round(a[1],6) != round(b[1],6):
        print 'assert failure!'

def cube_vertices(x, y, z, dx, dy, dz):
    return [
        x-dx,y+dy,z-dz, x-dx,y+dy,z+dz, x+dx,y+dy,z+dz, x+dx,y+dy,z-dz,  # top
        x-dx,y-dy,z-dz, x+dx,y-dy,z-dz, x+dx,y-dy,z+dz, x-dx,y-dy,z+dz,  # bottom
        x-dx,y-dy,z-dz, x-dx,y-dy,z+dz, x-dx,y+dy,z+dz, x-dx,y+dy,z-dz,  # left
        x+dx,y-dy,z+dz, x+dx,y-dy,z-dz, x+dx,y+dy,z-dz, x+dx,y+dy,z+dz,  # right
        x-dx,y-dy,z+dz, x+dx,y-dy,z+dz, x+dx,y+dy,z+dz, x-dx,y+dy,z+dz,  # front
        x+dx,y-dy,z-dz, x-dx,y-dy,z-dz, x-dx,y+dy,z-dz, x+dx,y+dy,z-dz,  # back
    ]

def tex_coord(x, y, n=4):
    m = 1.0 / n
    dx = x * m
    dy = y * m
    return dx, dy, dx + m, dy, dx + m, dy + m, dx, dy + m

def tex_coords(aa,bb,cc):  # motsatta sidor får samma nyans
    a = tex_coord(*aa)
    b = tex_coord(*bb)
    c = tex_coord(*cc)
    result = []
    result.extend(a)
    result.extend(a)
    result.extend(b)
    result.extend(b)
    result.extend(c)
    result.extend(c)
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

TEXTURE_PATH = 'colors.png'

GREEN = tex_coords((0, 0), (1, 0), (2, 0))
GRAY  = tex_coords((0, 1), (1, 1), (2, 1))
YELLOW= tex_coords((0, 2), (1, 2), (2, 2))
RED   = tex_coords((0, 3), (1, 3), (2, 3))

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

class Camera():
    def __init__(self, gp):
        self.gp = gp
        self.position = (0,0,1.5)  # x,y,z
        self.angle = 0  # grader

    def update(self, dt):
        gp = self.gp
        if gp.B: return
        x,y,z = self.position

        speed = dt * MAX_SPEED

        if abs(gp.roll)< 0.1: gp.roll=0
        if abs(gp.thrust)< 0.1: gp.thrust=0
        if abs(gp.pitch)< 0.1: gp.pitch=0
        if abs(gp.yaw)< 0.1: gp.yaw=0

        dx = gp.roll * speed
        dy = -gp.thrust * speed * 0.5
        dz = gp.pitch * speed
        da = gp.yaw/5

        self.angle += da
        self.angle %= 360
        dx,dz = rotate(dx,dz,self.angle)

        x += dx
        z += dz
        y += dy

        self.position = (x,y,z)

class Model(object):

    def __init__(self,gp):
        self.count = 0
        self.batch = pyglet.graphics.Batch()
        self.group = TextureGroup(image.load(TEXTURE_PATH).get_texture())

        self.world = {}
        self.sizes = {}
        self.colors= {}
        self.material = []
        self.volumes = []

        self.shown = {}
        self._shown = {}
        self.sectors = {}
        self.queue = deque()
        self._initialize()
        self.camera = Camera(gp)

    def add(self,x,y,z,color):
        x0,x1 = x
        y0,y1 = y
        z0,z1 = z
        self.volumes.append([x0,x1,y0,y1,z0,z1])
        self.material.append(sorted([x1-x0,y1-y0,z1-z0]))
        x,dx = (x0+x1)/2000.0,(x1-x0)/2000.0
        y,dy = (y0+y1)/2000.0,(y1-y0)/2000.0
        z,dz = (z0+z1)/2000.0,(z1-z0)/2000.0
        self.add_block((x,y,z), (dx,dy,dz), color, immediate=False)

    def _initialize(self):
        x0,x1,x2,x3,xa = 0, 22.5, 390, 435, 450
        y0,y1,y2,y3,y4,y5 = 0, 190, 235, 280, 295, 800
        z0,z1,z2,za,z3    = 0, 270, 315, 330,360

        z21 = [-z2,-z1]
        z12 = [z1,z2]
        z22 = [-z2,z2]
        z11 = [-z1,z1]
        z2a = [z2,za]
        z32 = [-z3,-z2]

        x33 = [-x3,x3]
        x32 = [-x3,-x2]
        x11 = [-x1,x1]
        x23 = [x2,x3]
        x3a = [x3,xa]
        xaa = [-xa,xa]
        _x3a = [-x3,xa]
        xa3 = [-xa,-x3]

        y21 = -y2,-y1
        y12 = [y1,y2]
        y11 = [-y1,y1]
        y23 = [y2,y3]
        y32 = [-y3,-y2]
        y34 = [y3,y4]
        y45 = [-y4,y5]
        y25 = [-y2,y5]

        self.add(x33, y21, z21, YELLOW) # bakre ram
        self.add(x33, y12, z21, YELLOW)
        self.add(x32, y11, z21, GREEN) # stolpar
        self.add(x11, y11, z21, GREEN)
        self.add(x23, y11, z21, GREEN)

        self.add(x33, y21, z12, YELLOW) # främre ram
        self.add(x33, y12, z12, YELLOW)
        self.add(x32, y11, z12, GREEN) # stolpar
        self.add(x11, y11, z12, GREEN)
        self.add(x23, y11, z12, GREEN)

        self.add(x32, y23, z22, GREEN) # liggande övre
        self.add(x11, y23, z22, GREEN) #
        self.add(x23, y23, z22, GREEN) #

        self.add(x32, y21, z11, GREEN) # liggande undre
        self.add(x11, y21, z11, GREEN) #
        self.add(x23, y21, z11, GREEN) #

        self.add(x32, y25, z32, GRAY) # ryggstöd, stolpar
        self.add(x11, y25, z32, GRAY)
        self.add(x23, y25, z32, GRAY)

        # foder

        for y in range(5):
            self.add(xa3, [105*y-235,105*y+95-235], z22, GRAY) # foder vänster sida
            self.add(x3a, [105*y-235,105*y+95-235], z22, GRAY) # foder höger sida
            self.add(xaa, [105*y-235,105*y+95-235], z2a, RED) # foder framifrån

        for z in range(6):
            self.add(xaa, y34, [z*110-315,z*110+95-315], RED) # foder ovanifrån

        for z in range(6):
            self.add(x33, [-y1,-y1+15], [z*110-315,z*110+95-315], RED) # foder kistbotten

        for y in range(5):
            self.add(xaa, [y4+y*105,y4+y*105+95], [-z2,-z2+15], RED) # foder ryggstöd

        self.list_material()
        self.list_collisions()

    def list_material(self):
        print "Material List:"
        self.material = sorted(self.material)
        hash = {}
        for bit in self.material:
            key = tuple(bit)
            if key not in hash:
                hash[key] = 0
            hash[key] += 1
        for bit in hash:
            print '',bit,hash[bit]

    def list_collisions(self):
        print "Conflicts:"
        for a in self.volumes:
            x0,x1,y0,y1,z0,z1 = a
            for b in self.volumes:
                x2,x3,y2,y3,z2,z3 = b
                if a != b:
                    if x1 <= x2: continue
                    if x0 >= x3: continue
                    if y1 <= y2: continue
                    if y0 >= y3: continue
                    if z1 <= z2: continue
                    if z0 >= z3: continue
                    print '', a, b

    def exposed(self, position):
        x, y, z = position
        for dx, dy, dz in FACES:
            if (x + dx, y + dy, z + dz) not in self.world: return True
        return False

    def add_block(self, position, sizes, texture, immediate=True):
        self.count += 1
        self.world[position] = texture
        self.sizes[position] = sizes
        self.sectors.setdefault(sectorize(position), []).append(position)
        if immediate:
            if self.exposed(position):
                self.show_block(position, sizes)
            self.check_neighbors(position)

    def remove_block(self, position, immediate=True):
        del self.world[position]
        self.sectors[sectorize(position)].remove(position)
        if immediate:
            if position in self.shown:
                self.hide_block(position)
            self.check_neighbors(position)

    def check_neighbors(self, position, sizes):
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
        sizes = self.sizes[position]
        self.shown[position] = texture
        if immediate:
            self._show_block(position, sizes, texture)
        else:
            self._enqueue(self._show_block, position, sizes, texture)

    def _show_block(self, position, sizes, texture):
        x, y, z = position
        dx,dy,dz = sizes
        vertex_data = cube_vertices(x, y, z, dx, dy, dz)
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

        for y in [10,40,70]:
            self.labels.append(pyglet.text.Label('', font_name='Arial', font_size=18, x=10, y=self.height - y, anchor_x='left', anchor_y='top', color=(0, 0, 0, 255)))

        pyglet.clock.schedule_interval(self.update, 1.0 / TICKS_PER_SEC)

    def update(self, dt):
        self.model.process_queue()
        sector = sectorize(self.model.camera.position)
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
        qc = self.model.camera
        qc.update(dt)

    def on_resize(self, width, height):
        for i in range(3):
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
        qc = self.model.camera
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

    def draw_label(self):
        qc = self.model.camera
        gp = qc.gp
        x, y, z = qc.position
        self.labels[0].text = 'x=%.2f y=%.2f z=%.2f' % (x,y,z)
        self.labels[1].text = 'pitch=%.2f' % (gp.pitch)
        self.labels[2].text = 'fps=%02d' % (pyglet.clock.get_fps())
        for label in self.labels: label.draw()

def setup():
    glClearColor(0.5, 0.69, 1.0, 1)
    glEnable(GL_CULL_FACE)
    glTexParameteri(GL_TEXTURE_2D, GL_TEXTURE_MIN_FILTER, GL_NEAREST)
    glTexParameteri(GL_TEXTURE_2D, GL_TEXTURE_MAG_FILTER, GL_NEAREST)

def main():
    Window(width=1200, height=1000, caption='PK-Minecraft', resizable=False)
    setup()
    pyglet.app.run()

if not CPU:
    pygame.init()
main()