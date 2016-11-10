from collections import deque
import time

# start from start and target and meet in the middle.
# This will execute a lot faster and handle larger problems

class Solver:

    def __init__(self, start, mode):
        self.start = start
        self.mode = mode
        self.q = deque([start])
        self.tree = {start: 0}

    def path(self,a): return [] if a == 0 else self.path(self.tree[a]) + [a]
    def expand(self,a,b):
        if not b in self.tree:
            self.q2.append(b)
            self.tree[b] = a

    def step(self):
        self.q2 = deque([])
        while len(self.q)>0:
            a = self.q.popleft()
            if a+self.mode >= 1:  self.expand(a, a+self.mode)
            self.expand(a, a*2)
            if a%2 == 0: self.expand(a, a/2)
        self.q = self.q2
        return self.q

def solve(a,b):
    a = Solver(a,2)
    b = Solver(b,-2)

    def check(a,b):
        global x
        for x in a.step():
            if x in b.tree: return True
        return False

    while True:
        if check(a,b): return a.path(x)[:-1] + b.path(x)[::-1]
        if check(b,a): return a.path(x)[:-1] + b.path(x)[::-1]

start = time.clock()
assert solve(3,2) == [3, 6, 8, 4, 2]
assert solve(30,20) == [30, 32, 16, 18, 20]
assert solve(300,200) == [300, 150, 152, 76, 38, 19, 21, 23, 25, 50, 100, 200]
assert solve(3000,2000) == [3000, 1500, 750, 752, 376, 188, 94, 96, 48, 50, 25, 27, 29, 31, 62, 124, 248, 250, 500, 1000, 2000]
assert solve(30000,20000) == [30000, 15000, 7500, 3750, 3752, 1876, 938, 940, 470, 472, 236, 118, 120, 60, 62, 31, 33, 35, 37, 39, 78, 156, 312, 624, 1248, 1250, 2500, 5000, 10000, 20000]
assert solve(300000,200000) == [300000, 150000, 75000, 37500, 18750, 18752, 9376, 4688, 2344, 1172, 586, 588, 294, 296, 148, 74, 37, 39, 41, 43, 45, 47, 94, 96, 192, 194, 388, 390, 780, 1560, 1562, 3124, 6248, 6250, 12500, 25000, 50000, 100000, 200000]
assert solve(3000000,2000000) == [3000000, 1500000, 750000, 375000, 187500, 93750, 93752, 46876, 23438, 23440, 11720, 5860, 2930, 2932, 1466, 1468, 734, 736, 368, 184, 92, 46, 48, 24, 26, 28, 30, 60, 120, 122, 244, 488, 976, 1952, 3904, 3906, 7812, 15624, 31248, 31250, 62500, 125000, 250000, 500000, 1000000, 2000000]
assert solve(30000000,20000000) == [30000000, 15000000, 7500000, 3750000, 1875000, 937500, 468750, 468752, 234376, 117188, 58594, 58596, 29298, 29300, 14650, 14652, 7326, 7328, 3664, 1832, 916, 458, 460, 230, 232, 116, 58, 29, 31, 33, 35, 37, 74, 76, 152, 304, 608, 610, 1220, 2440, 4880, 4882, 9764, 19528, 19530, 39060, 39062, 78124, 156248, 156250, 312500, 625000, 1250000, 2500000, 5000000, 10000000, 20000000]
# 24 secs, 56 steps
print time.clock()-start