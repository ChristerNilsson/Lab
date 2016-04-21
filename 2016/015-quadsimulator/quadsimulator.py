# -*- coding: utf-8 -*-

import sys
import euler
from point3d import *

class QuadCopter(Triangel):
    def __init__(self, simulation, color):
        width,height = 0.1,0.05
        Triangel.__init__(self, simulation, width, height, color)
        self.x, self.y, self.z = 0, 0, -0.5
        self.vx,self.vy,self.vz, = 0, 0, 0

        self.yaw = 0     # actual yaw in degrees
        self.pitch = 0   # actual pitch in degrees
        self.roll = 0    # actual roll in degrees

    def update(self):
        gp = self.simulation.gamepad
        self.acc = (0.0981 + gp.thrust)/10000  # accelerationen g påverkar.

        self.angleX -= gp.roll
        self.angleY += gp.pitch
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
                lst.append(rekt)
        return lst

    def create_rings(self):
        ring1 = Ring(self, 0.6, WHITE); ring1.update3D(0, 0, -0.5, 0, 0, 0)
        ring2 = Ring(self, 0.4, RED);   ring2.update3D(1.5, 0, -0.6, 0, 90, 0)
        ring3 = Ring(self, 0.4, BLUE);  ring3.update3D(0, -1.5, -0.6, 90, 0, 0)
        return [ring1,ring2,ring3]

    def run(self):

        dx = 0.2

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

            self.objects = chessboard + rings + [self.drone]

            self.update_screen()

            if self.angleX < 0 or self.angleX > 90: dx = -dx
            self.angleX += dx

            # if self.angleY < 0 or self.angleY > 90: dx = -dx
            # self.angleY += dx

            #if self.angleZ < 0 or self.angleZ > 90: dx = -dx
            #self.angleZ += dx

Simulation().run()