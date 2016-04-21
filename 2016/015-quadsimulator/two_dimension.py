# -*- coding: utf-8 -*-

# Spelet går ut på att med en raket träffa en monolit i rymden.
# Raketen kan gasa och vridas.
# Kommer man utanför är spelet slut.
# Monoliten blir mindre och mindre.

import sys
import random
from point3d import *


class Rocket(Triangel):
    def __init__(self, simulation, color):
        width, height = 0.1, 0.05
        Triangel.__init__(self, simulation, width, height, color)

    def update(self):
        if self.simulation.gamepad.thrust < 0.1:
            self.acc = self.simulation.gamepad.thrust/1000
        self.angleZ -= self.simulation.gamepad.yaw * 4.000
        self.vx += self.acc * math.cos(radians(self.angleZ))
        self.vy += self.acc * math.sin(radians(self.angleZ))
        self.x += -self.vx
        self.y += -self.vy
        Triangel.update2D(self,self.x,self.y,self.angleZ)
        Triangel.update(self)


class Simulation(App):
    def __init__(self, win_width=2*640, win_height=2*400):
        App.__init__(self, win_width, win_height, "Rocket: Fungerar i stil med Asteroids. Thrust och Rotate. Kör på Monoliten och den flyttar sig och krymper.")

    def game(self, h):
        # placera både target och rocket slumpmässigt, med slumpmässig riktning
        x = random.uniform(-2+h/2,2-h/2)
        y = random.uniform(-2+h/2,2-h/2)
        self.backgr = Rektangel(self, 2.0, 2.0, GRAY)
        self.backgr.update2D(0, 0, 0)
        self.target = Rektangel(self, h/2, h/2, WHITE)
        self.target.update2D(x,y,0)
        while True:
            x = random.uniform(-1.8, 1.8)
            y = random.uniform(-1.8, 1.8)
            angleZ = random.uniform(0,360)
            self.rocket = Rocket(self, RED)
            self.rocket.update2D(x, y, angleZ)
            if not self.target.contains(self.rocket):
                break
        App.objects = [self.backgr, self.target, self.rocket]

        while True:
            for event in pygame.event.get():
                if event.type == pygame.QUIT:
                    pygame.quit()
                    sys.exit()

            self.clock.tick(50)
            self.screen.fill((0, 32, 0))
            self.gamepad.get()
            self.rocket.update()
            self.update_screen()

            if self.target.contains(self.rocket):
                self.rocket.color = GREEN
                self.update_screen()
                return True
            if not self.backgr.contains(self.rocket):
                return False

    def run(self):
        h = 2.0
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