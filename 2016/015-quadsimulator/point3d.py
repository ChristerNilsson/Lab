# -*- coding: utf-8 -*-

# Origo ligger i mitten av skärmen.
# Skärmen är 4 x 4 enheter stor.
# Hörnen är (-2,-2) och (2,2)

import math
import pygame
from operator import itemgetter
from gamepad import GamePad

RED = (255,0,0)
WHITE = (255,255,255)
BLACK = (0,0,0)
GREEN = (0,255,0)
BLUE = (0,0,255)
GRAY = (128,128,128)
DARKGREEN = (0,128,0)


def radians(degrees):
    return degrees * math.pi / 180


class Point3D(object):
    def __init__(self, x, y, z=0):
        self.x = x
        self.y = y
        self.z = z

    def __str__(self):
        return str(self.x) + " " + str(self.y) + " " + str(self.z)

    def distance(self,other):
        return math.sqrt((self.x-other.x)**2 + (self.y-other.y)**2 + (self.z-other.z)**2)

    # Dessa borde köras på alla i hela listan samtidigt
    def rotate_x(self, angle):  # Rotates the point around the X axis by the given angle in degrees.
        rad = angle * math.pi / 180
        cos_a = math.cos(rad)
        sin_a = math.sin(rad)
        y = self.y * cos_a - self.z * sin_a
        z = self.y * sin_a + self.z * cos_a
        return Point3D(self.x, y, z)

    def rotate_y(self, angle):  # Rotates the point around the Y axis by the given angle in degrees.
        rad = angle * math.pi / 180
        cos_a = math.cos(rad)
        sin_a = math.sin(rad)
        z = self.z * cos_a - self.x * sin_a
        x = self.z * sin_a + self.x * cos_a
        return Point3D(x, self.y, z)

    def rotate_z(self, angle):  # Rotates the point around the Z axis by the given angle in degrees.
        rad = angle * math.pi / 180
        cos_a = math.cos(rad)
        sin_a = math.sin(rad)
        x = self.x * cos_a - self.y * sin_a
        y = self.x * sin_a + self.y * cos_a
        return Point3D(x, y, self.z)

    def project(self, win_width, win_height, fov, viewer_distance):  # Transforms this 3D point to 2D using a perspective projection.
        namnare = viewer_distance + self.z
        if namnare == 0:  # undviker div med noll
            factor = 1000
        else:
            factor = fov / namnare
        x = self.x * factor + win_width / 2
        y = -self.y * factor + win_height / 2
        return Point3D(x, y, self.z)


class Polygon(object):
    def __init__(self, simulation, points, color):  # points runt origo
        self.simulation = simulation
        self.points = points
        self.color = color
        self.x = 0
        self.y = 0
        self.z = 0
        self.angleX = 0
        self.angleY = 0
        self.angleZ = 0
        self.acc = 0
        self.vx = 0
        self.vy = 0

    def __str__(self):
        return str([str(p) for p in self.points])

    def update2D(self, x, y, angleZ=0):  # rotera och flytta
        self.update3D(x, y, 0, 0, 0, angleZ)

    def update3D(self, x, y, z, angleX, angleY, angleZ):  # rotera och flytta
        self.x,self.y,self.z = x,y,z
        self.angleX, self.angleY, self.angleZ = angleX, angleY, angleZ
        # rotera
        lst = [v.rotate_x(angleX).rotate_y(angleY).rotate_z(angleZ) for v in self.points]

        # flytta
        self.lst = [Point3D(x+v.x, y+v.y, z+v.z) for v in lst]

    def update(self):
        i = len(self.simulation.vertices)
        self.simulation.vertices.extend(self.lst)
        self.simulation.faces.append(tuple([i+j for j in range(len(self.lst))]))
        self.simulation.colors.append(self.color)


class Rektangel(Polygon):  # centrerad till origo. width och height motsvarar radien på en cirkel
    def __init__(self,simulation,width,height,color):
        self.width = width
        self.height = height
        self.color = color
        p1 = Point3D(-width, -height)
        p2 = Point3D( width, -height)
        p3 = Point3D( width,  height)
        p4 = Point3D(-width,  height)
        points = [p1, p2, p3, p4]
        Polygon.__init__(self, simulation, points, color)

    def left(self):  # 2D
        return self.x - self.width

    def right(self):  # 2D
        return self.x + self.width

    def top(self):  # 2D
        return self.y + self.height

    def bottom(self):  # 2D
        return self.y - self.height

    def contains(self, other):  # 2D
        return self.left() < other.left() and self.right() > other.right() and self.top() > other.top() and self.bottom() < other.bottom()


class Ring(Polygon):  # statisk, dvs den rör sig inte. Används i 3D
    def __init__(self, simulation, size, color, n=72, thickness=0.02):
        points = []

        # skapa en yttre ring i origo, xy-planet
        p = Point3D(size + thickness, 0, 0)
        for i in range(n):
            points.append(p)
            p = p.rotate_z(360.0/n)
        points.append(p)

        # skapa en inre ring i origo, xy-planet
        p = Point3D(size - thickness, 0, 0)
        for _ in reversed(range(n)):
            points.append(p)
            p = p.rotate_z(-360.0/n)
        points.append(p)
        Polygon.__init__(self, simulation, points, color)


class Triangel(Polygon):  # Spetsig, likbent triangel
    def __init__(self, simulation, width, height, color):  # points runt origo
        self.width = width
        self.height = height
        p1 = Point3D(-width, -height, -0.001)
        p2 = Point3D(width, 0, -0.001)
        p3 = Point3D(-width, height, -0.001)
        points = [p1, p2, p3]
        Polygon.__init__(self, simulation, points, color)

    def left(self):  # 2D
        return self.x - self.width

    def right(self):  # 2D
        return self.x + self.width

    def top(self):  # 2D
        return self.y + self.height

    def bottom(self):  # 2D
        return self.y - self.height


class App(object):
    def __init__(self,win_width, win_height, caption):
        pygame.init()
        self.gamepad = GamePad()
        self.screen = pygame.display.set_mode((win_width, win_height))
        pygame.display.set_caption(caption)
        self.clock = pygame.time.Clock()
        self.angleX = 0
        self.angleY = 0
        self.angleZ = 0
        self.vertices = []
        self.faces = []
        self.colors = []

    def update_screen(self):  # ritar projicerat
        self.vertices = []
        self.faces = []
        self.colors = []
        for obj in self.objects:
            obj.update()

        # t will hold transformed vertices.
        t = []

        for v in self.vertices:
            # Rotate the point around X axis, then around Y axis, and finally around Z axis.
            r = v.rotate_x(self.angleX).rotate_y(self.angleY).rotate_z(self.angleZ)

            # Transform the point from 3D to 2D
            p = r.project(self.screen.get_width(), self.screen.get_height(), fov=2048, viewer_distance=8)
            #p = r.project(self.screen.get_width(), self.screen.get_height(), fov=1024, viewer_distance=4)
            #p = r.project(self.screen.get_width(), self.screen.get_height(), fov=512, viewer_distance=2)

            # Put the point in the list of transformed vertices
            t.append(p)

        # Calculate the average Z values of each face.
        avg_z = []
        i = 0
        for f in self.faces:
            z = sum([t[item].z for item in f if t[item] is not None]) / len(f)
            avg_z.append([i, z])
            i += 1

        # Draw the faces using the Painter's algorithm:
        # Distant faces are drawn before the closer ones.
        for tmp in sorted(avg_z, key=itemgetter(1), reverse=True):
            face_index = tmp[0]
            f = self.faces[face_index]

            pointlist = []
            m = len(f)
            LIMIT = 2000  # snabbar upp utritningen för polygoner som ligger långt utanför fönstret
            ok = True  # Rita bara polygonen om alla punkter ligger inom LIMIT
            for i in range(len(f)):
                obj = t[f[i]]
                obj1 = t[f[(i+1) % m]]
                if abs(obj.x) > LIMIT or abs(obj.y) > LIMIT or abs(obj.z) > 2: ok = False
                if abs(obj1.x) > LIMIT or abs(obj1.y) > LIMIT or abs(obj1.z) > 2: ok = False
                pointlist.append((obj.x, obj.y))
                pointlist.append((obj1.x, obj1.y))

            if ok:
                #print pointlist
                pygame.draw.polygon(self.screen, self.colors[face_index], pointlist)

        pygame.display.flip()