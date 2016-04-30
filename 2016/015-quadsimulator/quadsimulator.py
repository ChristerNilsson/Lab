# -*- coding: utf-8 -*-

import sys
from point3d import *

class QuadCopter(Triangel):
    def __init__(self, simulation, color):
        width,height = 0.1,0.05
        Triangel.__init__(self, simulation, width, height, color)
        self.x, self.y, self.z = 0, 0, -0.5
        self.vx,self.vy,self.vz, = 0, 0, 0

    def update(self):
        gp = self.simulation.gamepad
        self.acc = (0.0981 + gp.thrust)/10000  # accelerationen g påverkar.

        self.angleX -= gp.roll
        self.angleY -= gp.pitch
        self.angleZ -= gp.yaw

        # Räkna ut accelerationskomponenterna för x,y och z,
        # givet gas samt yaw, pitch och roll på gamePaden.
        dx,dy,dz = euler.ypr(self.angleZ,self.angleY,self.angleX, 0,0,-self.acc)

        self.vx += dx
        self.vy += dy
        self.vz += dz

        self.x += -self.vx
        self.y += -self.vy
        self.z += -self.vz

        if self.z > -0.1:
            self.z = -0.1  # Planet kan inte befinna sig under markytan
            self.vz = 0

        Triangel.update3D(self,self.x,self.y,self.z,self.angleX,self.angleY,self.angleZ)
        Triangel.update(self)


class Simulation(App):
    def __init__(self, win_width=2*640, win_height=2*480):
        App.__init__(self, win_width, win_height, "Simulation of a quadcopter")
        self.drone = QuadCopter(self, RED)
        #self.angleX=45


    def create_chessboard(self):
        lst = []
        n = 8
        size = 0.5
        for x in range(n):
            for y in range(n):
                rekt = Rektangel(self, size/2, size/2, [GREEN, DARKGREEN][(x+y) % 2])
                rekt.update2D(-n*size/2 + x*size+size/2, -n*size/2 + y*size+size/2)
                #if y0 <= -n*size/2 + y*size+size/2:
                lst.append(rekt)
        return lst

    def create_rings(self):
        res = []
        r=Ring(self, 0.6, WHITE)
        res.append(r)
        r.update3D(0, 0, -0.5, 0, 0, 0)

        r=Ring(self, 0.4, RED)
        res.append(r)
        r.update3D(1.5, 0, -0.6, 0, 90, 0)

        r=Ring(self, 0.4, BLUE)
        res.append(r)
        r.update3D(0, -1.5, -0.6, 90, 0, 0)
        return res

    def run(self):

        while True:
            for event in pygame.event.get():
                if event.type == pygame.QUIT:
                    pygame.quit()
                    sys.exit()

            self.clock.tick(50)
            self.screen.fill((0, 32, 0))
            self.gamepad.get()

            self.vertices = []
            self.faces = []
            self.colors = []
            chessboard = self.create_chessboard()
            rings = self.create_rings()

            self.drone.update()

            self.objects = chessboard + rings # + [self.drone]

            self.update_screen(self.drone)

Simulation().run()