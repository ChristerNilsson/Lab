# -*- coding: utf-8 -*-
# Fraktal matta baserad på fibonaccital
import time

arrlen = [10946,6765,4181,2584,1597,987,610,377,233,144,89,55,34,21,13,8,5,3,2,1,1]
#arrlen = [144,89,55,34,21,13,8,5,3,2,1,1]

class GoldenCarpet:

    def __init__(self):
        self.xo = 0
        self.yo = 0
        self.points = {}
        self.factor = 1

    def mytranslate(self,dx,dy):
      self.xo += dx
      self.yo += dy

    def setpoint(self,angle, size):
      x = self.xo
      y = self.yo
      if angle == 0:   x += size
      elif angle == 1: y += size
      elif angle == 2: x -= size
      elif angle == 3: y -= size

      key = str(x) + "," + str(y)
      if key in self.points:
        self.points[key] |= [1,2,4,8][angle]
      else:
        self.points[key] = [1,2,4,8][angle]

    def generation(self,size):
      keys = self.points.keys()
      for key in keys:
        arr = key.split(",")
        x = int(arr[0])
        y = int(arr[1])
        point = self.points[key]
        self.mytranslate(x-self.xo, y-self.yo)
        for i in range(4):
          if point & [1,2,4,8][i] == 0:
            self.setpoint((i+2)%4, self.factor*size)
            self.setpoint(i, 0)
      return len(self.points)

    def run(self):
      self.mytranslate(0,0)
      self.points["0,0"] = 0
      for g in range(20):
        start = time.time()
        print "Generation " + str(g+1) + ": " + str(self.generation(arrlen[g])) + " " + str(time.time()-start)

gc = GoldenCarpet()
gc.run()