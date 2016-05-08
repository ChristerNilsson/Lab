# -*- coding: utf-8 -*-

# https://github.com/fogleman/Minecraft

# Python 2.7 (ej anaconda)
# Pyglet had to be installed (pip install pyglet)
# texture.png was corrupted
# Then it worked!
# WS Up Down
# AD Left Right
# space Jump
# esc Quit
# tab Fly
# mouse Pan
# 1 Brick
# 2 Earth
# 3 Stone

import math
import random
import time
import euler

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
WALKING_SPEED = 5
FLYING_SPEED = 15
GRAVITY = 20.0
MAX_JUMP_HEIGHT = 1.0  # About the height of a block.
JUMP_SPEED = math.sqrt(2 * GRAVITY * MAX_JUMP_HEIGHT)
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
        self.A, self.B, self.X, self.Y = res[5:9]

TEXTURE_PATH = 'texture.png'

GRASS = tex_coords((1, 0), (0, 1), (0, 0))
SAND = tex_coords((1, 1), (1, 1), (1, 1))
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
    return (x, y, z)

def sectorize(position):
    x, y, z = normalize(position)
    x, y, z = x / SECTOR_SIZE, y / SECTOR_SIZE, z / SECTOR_SIZE
    return (x, 0, z)

class QuadCopter():
    def __init__(self, gp):

        self.acc = 0

        self.x = 0
        self.y = 0
        self.z = 0

        self.vx = 0
        self.vy = 0
        self.vz = 0

        self.angleX = 0 # grader
        self.angleY = 0
        self.angleZ = 0

        self.gp = gp
        self.position = (self.x, self.y, self.z)
        self.rotation = (self.angleX, self.angleY)

    def update(self, dt):
        gp = self.gp
        if gp.B:
            return
        self.acc = gp.thrust/100000  # accelerationen g påverkar.

        self.angleX += gp.roll/10
        self.angleY -= gp.pitch/10
        self.angleZ += gp.yaw/10

        # Räkna ut accelerationskomponenterna för x,y och z,
        # givet gas samt yaw, pitch och roll på gamePaden.
        dx,dz,dy = euler.ypr(self.angleX, self.angleZ, self.angleY, 0,0, -self.acc)

        self.vx += dx
        self.vy += dy
        self.vz += dz

        self.vy += - dt * GRAVITY / 10000.0

        self.x += self.vx
        self.y += self.vy
        self.z += self.vz

        if self.y < 0:
            self.y = 0  # Planet kan inte befinna sig under markytan
            self.vy = 0

        # speed = FLYING_SPEED * self.joystick.thrust
        #
        # d = dt * speed # distance covered this tick.
        # dx, dy, dz = self.get_motion_vector()
        # dx, dy, dz = dx * d, dy * d, dz * d
        #
        # # if not self.flying:
        # self.dy -= dt * GRAVITY
        # self.dy = max(self.dy, -TERMINAL_VELOCITY)
        # dy += self.dy * dt
        #
        # x, y, z = self.position
        # x, y, z = self.collide((x + dx, y + dy, z + dz), PLAYER_HEIGHT)
        #
        # x += self.joystick.roll / 50.0
        # z += self.joystick.pitch / 50.0
        # y += self.joystick.thrust / 50.0
        #
        self.rotation = (self.angleX, self.angleY)
        self.position = (self.x, self.y, self.z)

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
        s = 1  # step size
        y = 0  # initial y height
        for x in xrange(-n, n + 1, s):
            for z in xrange(-n, n + 1, s):
                texture = GRASS if random.randint(1,2) == 1 else SAND
                self.add_block((x, y - 2, z), texture, immediate=False)  # GRASS
                #self.add_block((x, y - 3, z), STONE, immediate=False)
                if x in (-n, n) or z in (-n, n):
                    for dy in xrange(-1, 0):
                        self.add_block((x, y + dy, z), STONE, immediate=False)
        print self.count
        self.add_ring_z((-n, 5, -n), 2)
        self.add_ring_y((n, 5, -n), 3)
        self.add_ring_x((n, 5, n), 3)
        self.add_ring_x((-n, 5, n), 3)
        print self.count

    def add_ring_z(self,pos,size):
        x,y,z = pos
        for x0 in range(x-size,x+size+1):
            for y0 in range(y-size,y+size+1):
                if x0 in [x-size,x+size] or y0 in [y-size,y+size]:
                    self.add_block((x0,y0,z), BRICK, immediate=False)

    def add_ring_y(self,pos,size):
        x,y,z = pos
        for x0 in range(x-size,x+size+1):
            for z0 in range(z-size,z+size+1):
                if x0 in [x-size,x+size] or z0 in [z-size,z+size]:
                    self.add_block((x0,y,z0), BRICK, immediate=False)

    def add_ring_x(self,pos,size):
        x,y,z = pos
        for y0 in range(y-size,y+size+1):
            for z0 in range(z-size,z+size+1):
                if y0 in [y-size,y+size] or z0 in [z-size,z+size]:
                    self.add_block((x,y0,z0), BRICK, immediate=False)

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

    # def remove_block(self, position, immediate=True):
    #     del self.world[position]
    #     self.sectors[sectorize(position)].remove(position)
    #     if immediate:
    #         if position in self.shown:
    #             self.hide_block(position)
    #         self.check_neighbors(position)

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
        #self.exclusive = False
        #self.flying = False
        #self.strafe = [0, 0]
        #self.position = (0, 0, 0)
        #self.rotation = (0, 0)
        self.sector = None
        self.reticle = None
        #self.dy = 0
        #self.num_keys = [key._1, key._2, key._3, key._4, key._5, key._6, key._7, key._8, key._9, key._0]

        # Joystick
        self.joystick = JoyStick()

        self.model = Model(self.joystick)
        self.label = pyglet.text.Label('', font_name='Arial', font_size=18,
            x=10, y=self.height - 10, anchor_x='left', anchor_y='top',
            color=(0, 0, 0, 255))
        pyglet.clock.schedule_interval(self.update, 1.0 / TICKS_PER_SEC)


    # def set_exclusive_mouse(self, exclusive):
    #     super(Window, self).set_exclusive_mouse(exclusive)
    #     self.exclusive = exclusive

    def get_sight_vector(self):
        x, y = self.model.quadcopter.rotation
        m = math.cos(math.radians(y))
        dy = math.sin(math.radians(y))
        dx = math.cos(math.radians(x - 90)) * m
        dz = math.sin(math.radians(x - 90)) * m
        return (dx, dy, dz)

    def get_motion_vector(self):
        if any(self.strafe):
            x, y = self.model.quadcopter.rotation
            strafe = math.degrees(math.atan2(*self.strafe))
            y_angle = math.radians(y)
            x_angle = math.radians(x + strafe)

            #if self.flying:
            m = math.cos(y_angle)
            dy = math.sin(y_angle)
            if self.strafe[1]:
                dy = 0.0
                m = 1
            if self.strafe[0] > 0:
                dy *= -1
            dx = math.cos(x_angle) * m
            dz = math.sin(x_angle) * m
            # else:
            #     dy = 0.0
            #     dx = math.cos(x_angle)
            #     dz = math.sin(x_angle)
        else:
            dy = 0.0
            dx = 0.0
            dz = 0.0
        return (dx, dy, dz)

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

    # def on_mouse_press(self, x, y, button, modifiers):
    #     if self.exclusive:
    #         vector = self.get_sight_vector()
    #         block, previous = self.model.hit_test(self.position, vector)
    #         if (button == mouse.RIGHT) or \
    #                 ((button == mouse.LEFT) and (modifiers & key.MOD_CTRL)):
    #             if previous:
    #                 self.model.add_block(previous, self.block)
    #         elif button == pyglet.window.mouse.LEFT and block:
    #             texture = self.model.world[block]
    #             if texture != STONE:
    #                 self.model.remove_block(block)
    #     else:
    #         self.set_exclusive_mouse(True)
    #
    # def on_mouse_motion(self, x, y, dx, dy):
    #     if self.exclusive:
    #         m = 0.15
    #         x, y = self.model.quadcopter.rotation
    #         x, y = x + dx * m, y + dy * m
    #         y = max(-90, min(90, y))
    #         self.model.quadcopter.rotation = (x, y)
    #
    # def on_key_press(self, symbol, modifiers):
    #     if symbol == key.W:
    #         self.strafe[0] -= 1
    #     elif symbol == key.S:
    #         self.strafe[0] += 1
    #     elif symbol == key.A:
    #         self.strafe[1] -= 1
    #     elif symbol == key.D:
    #         self.strafe[1] += 1
    #     elif symbol == key.SPACE:
    #         if self.dy == 0:
    #             self.dy = JUMP_SPEED
    #     elif symbol == key.ESCAPE:
    #         self.set_exclusive_mouse(False)
    #
    # def on_key_release(self, symbol, modifiers):
    #     if symbol == key.W:
    #         self.strafe[0] += 1
    #     elif symbol == key.S:
    #         self.strafe[0] -= 1
    #     elif symbol == key.A:
    #         self.strafe[1] += 1
    #     elif symbol == key.D:
    #         self.strafe[1] -= 1

    def on_resize(self, width, height):
        self.label.y = height - 10
        if self.reticle:
            self.reticle.delete()
        x, y = self.width / 2, self.height / 2
        n = 10
        self.reticle = pyglet.graphics.vertex_list(4,
            ('v2i', (x - n, y, x + n, y, x, y - n, x, y + n))
        )

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
        gluPerspective(65.0, width / float(height), 0.1, 60.0)
        glMatrixMode(GL_MODELVIEW)
        glLoadIdentity()
        x, y = self.model.quadcopter.rotation
        y -= 20  # Kameramontering ska peka ett antal grader uppåt
        glRotatef(x, 0, 1, 0)
        #glRotatef(x, 1, 0, 0)
        glRotatef(-y, math.cos(math.radians(x)), 0, math.sin(math.radians(x)))
        x, y, z = self.model.quadcopter.position
        glTranslatef(-x, -y, -z)

    def on_draw(self):
        self.joystick.update()

        self.clear()
        self.set_3d()
        glColor3d(1, 1, 1)
        self.model.batch.draw()
        self.draw_focused_block()
        self.set_2d()
        self.draw_label()
        self.draw_reticle()

    def draw_focused_block(self):
        vector = self.get_sight_vector()
        block = self.model.hit_test(self.model.quadcopter.position, vector)[0]
        if block:
            x, y, z = block
            vertex_data = cube_vertices(x, y, z, 0.51)
            glColor3d(0, 0, 0)
            glPolygonMode(GL_FRONT_AND_BACK, GL_LINE)
            pyglet.graphics.draw(24, GL_QUADS, ('v3f/static', vertex_data))
            glPolygonMode(GL_FRONT_AND_BACK, GL_FILL)

    def draw_label(self):
        qc = self.model.quadcopter
        gp = qc.gp
        x, y, z = qc.position
        self.label.text = '%02d (%.2f, %.2f, %.2f) thrust=%.2f pitch=%.2f yaw=%.2f roll=%.2f acc=%.6f' % (
            pyglet.clock.get_fps(), x, y, z,
            #len(self.model._shown), len(self.model.world),
            gp.thrust, gp.pitch, gp.yaw, gp.roll,
            qc.acc
        )
        self.label.draw()

    def draw_reticle(self):
        glColor3d(0, 0, 0)
        self.reticle.draw(GL_LINES)

def setup():
    glClearColor(0.5, 0.69, 1.0, 1)
    glEnable(GL_CULL_FACE)
    glTexParameteri(GL_TEXTURE_2D, GL_TEXTURE_MIN_FILTER, GL_NEAREST)
    glTexParameteri(GL_TEXTURE_2D, GL_TEXTURE_MAG_FILTER, GL_NEAREST)

def main():
    Window(width=1200, height=1000, caption='Pyglet', resizable=False)
    setup()
    pyglet.app.run()

if __name__ == '__main__':
    main()