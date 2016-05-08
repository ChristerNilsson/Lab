# -*- coding: utf-8 -*-

# Spelet går ut på att styra en jetdriven hiss.
# Man måste hålla den röda hissen inom det vita området i tre sekunder.
# Tiden börjar räknas från det att man fått in hela hissen i det vita området.
# Hissen och det vita området krymper om man lyckas, med 10%.
# Starta med B.

import sys
import time
from point3d import *

class Camera():
    def __init__(self):
        self.x = 0
        self.y = 0
        self.z = 0
        self.angleX = 0
        self.angleY = -90
        self.angleZ = 45

class Elevator(Rektangel):
    def __init__(self,simulation,width,height,color):
        self.speed = 0
        self.acc = 0
        Rektangel.__init__(self,simulation,width,height,color)

    def update(self):
        self.acc = -self.simulation.gamepad.thrust / 1000
        self.speed += self.acc
        self.y += self.speed
        self.update2D(self.x,self.y)
        Rektangel.update(self)

class Simulation(App):
    def __init__(self,win_width=2 * 640,win_height=2 * 480):
        App.__init__(self,win_width,win_height,"Den röda hissen ska befinna sig inom det vita området. Starta med B")
        App.camera = Camera()

    def game(self,h):
        self.target = Rektangel(self, 1.6, h, WHITE)
        self.target.update2D(0,1.8 - h, -0.001)
        self.elevator = Elevator(self,1.2,h / 2,RED)
        self.elevator.update2D(0,-2 + h,-0.002)
        App.objects = [self.target,self.elevator]

        inside = False
        while True:
            for event in pygame.event.get():
                if event.type == pygame.QUIT:
                    pygame.quit()
                    sys.exit()

            self.clock.tick(50)
            self.screen.fill((0,32,0))

            self.gamepad.get()
            self.elevator.update()

            if inside:
                if not self.target.contains(self.elevator):
                    return False
                if time.clock() > start + 3:
                    self.elevator.color = GREEN
                    self.update_screen(App.camera)
                    return True
            else:
                if self.target.contains(self.elevator):
                    start = time.clock()
                    inside = True

            self.update_screen(App.camera)

    def run(self):
        h = 1.0
        level = 0
        while True:
            level += 1
            print("Level: " + str(level) + ". Tryck på B")
            while True:
                self.gamepad.get()
                if self.gamepad.B == 1:
                    break

            if not self.game(h):
                pygame.quit()
                sys.exit()
            h *= 0.9

Simulation().run()
