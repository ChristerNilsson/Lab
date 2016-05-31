# old style.
# recursive 2D or 3D
# start at (0,0,0)
# end at (N-1,N-1,N-1)

import random
import sys

N = 3

class Maze2D():
    def __init__(self):
        self.data = []
        for y in range(N):
            row = []
            for x in range(N):
                row.append('*')
            self.data.append(row)
        self.build(0,0)
        self.dump()

    def build(self,x,y):
        if self.data == '.': return
        else:
            self.data[x][y] = '.'
            d = [[1,0],[-1,0],[0,1],[0,-1]]
            random.shuffle(d)
            for dx,dy in d:
                x2 = x+dx+dx
                y2 = y+dy+dy
                if x2 <= -1 or x2 >= N:
                    continue
                if y2 <= -1 or y2 >= N:
                    continue
                if self.data[x2][y2] == '.':
                    continue
                self.data[x+dx][y+dy]='.'
                self.build(x2,y2)

    def dump(self):
        for y in range(N):
            print ' '.join(self.data[y])

class Maze3D():
    def __init__(self):
        self.data = {}
        for x in range(-N,N+1):
            for y in range(-N,N+1):
                for z in range(-N,N+1):
                    self.data[x,y,z] = '*'
        self.build(0,0,0)
        self.data[-N,-N+1,-N+1] = '.'
        self.data[N,N-1,N-1] = '.'
        self.dump()

    def build(self,x,y,z):
        self.data[x,y,z] = '.'
        d = [[-1,0,0],[1,0,0],[0,-1,0],[0,1,0],[0,0,1],[0,0,-1]]
        random.shuffle(d)
        for dx,dy,dz in d:
            x2 = x+dx+dx
            y2 = y+dy+dy
            z2 = z+dz+dz
            if x2 in [-N-1,N+1]: continue
            if y2 in [-N-1,N+1]: continue
            if z2 in [-N-1,N+1]: continue
            if self.data[x2,y2,z2] == '.': continue
            self.data[x+dx,y+dy,z+dz] = '.'
            self.build(x2,y2,z2)

    def dump(self):
        for z in range(-N,N+1):
            print
            for y in range(-N,N+1):
                print
                for x in range(-N,N+1):
                    print self.data[x,y,z],

sys.setrecursionlimit(2000)
maze = Maze3D()