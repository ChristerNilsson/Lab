# Based off code from: http://robots.dacloughb.com/project-1/logitech-game-pad/
# conda install -c https://conda.binstar.org/krisvanneste pygame
import pygame

THRESHOLD = 0.1

class GamePad():
    def __init__(self):
        self.gamepad = pygame.joystick.Joystick(0)
        self.gamepad.init()
        self.thrust = 0
        self.yaw = 0
        print 'Initialized GamePad : %s' % self.gamepad.get_name()

    def get(self):
        self.out = []
        pygame.event.pump()

        for i in range(self.gamepad.get_numaxes()):
            self.out.append(self.gamepad.get_axis(i))

        for i in range(self.gamepad.get_numbuttons()):
            self.out.append(self.gamepad.get_button(i))

        self.yaw, self.thrust, _, self.pitch, self.roll = self.out[0:5]
        self.A, self.B, self.X, self.Y = self.out[5:9]

        if abs(self.yaw) < THRESHOLD: self.yaw=0
        if abs(self.pitch) < THRESHOLD: self.pitch=0
        if abs(self.roll) < THRESHOLD: self.roll=0