# -*- coding: utf-8 -*-

import time
import heapq

# Builds three text files with all solutions
# Reads three text files
# Solves a 3x3x3 pocket cube

# Colours: white-yellow orange-red blue-green
# Moves:   up-down      front-back left-right
#
#                                            0 1 2 3 4 5 6 7 8 91011
#           00 24 01                       0       r r r
#           25  U 26                       1       r r r
#           02 27 03                       2       r r r
# 04 28 05  08 32 09  12 36 13  16 40 17   3 b b b * w w g g g y y y
# 29  L 30  33  F 34  37  R 38  41  B 42   4 b b b w w w g g g y y y
# 06 31 07  10 35 11  14 39 15  18 43 19   5 b b b w w w g g g y y y
#           20 44 21                       6       o o o
#           45  D 46                       7       o o o
#           22 47 23                       8       o o o
#
# Face numbers used in the cross:
#   0     U     r
#  1234  LFRB  bwgy
#   5     D     o
#
#
#        0         1         2         3         4
#        012345678901234567890123456789012345678901234567
START = 'rrrrbbbbwwwwggggyyyyoooorrrrbbbbwwwwggggyyyyoooo'

X  = '00 01 02 03 04 05 06 07 08 09 10 11 12 13 14 15 16 17 18 19 20 21 22 23 24 25 26 27 28 29 30 31 32 33 34 35 36 37 38 39 40 41 42 43 44 45 46 47'

R  = '00 09 02 11 04 05 06 07 08 21 10 23 14 12 15 13 03 17 01 19 20 18 22 16 24 25 34 27 28 29 30 31 32 33 46 35 37 39 36 38 40 26 42 43 44 45 41 47'
RI = '00 18 02 16 04 05 06 07 08 01 10 03 13 15 12 14 23 17 21 19 20 09 22 11 24 25 41 27 28 29 30 31 32 33 26 35 38 36 39 37 40 46 42 43 44 45 34 47'
R2 = '00 21 02 23 04 05 06 07 08 18 10 16 15 14 13 12 11 17 09 19 20 01 22 03 24 25 46 27 28 29 30 31 32 33 41 35 39 38 37 36 40 34 42 43 44 45 26 47'

D  = '00 01 02 03 04 05 18 19 08 09 06 07 12 13 10 11 16 17 14 15 22 20 23 21 24 25 26 27 28 29 30 43 32 33 34 31 36 37 38 35 40 41 42 39 45 47 44 46'
DI = '00 01 02 03 04 05 10 11 08 09 14 15 12 13 18 19 16 17 06 07 21 23 20 22 24 25 26 27 28 29 30 35 32 33 34 39 36 37 38 43 40 41 42 31 46 44 47 45'
D2 = '00 01 02 03 04 05 14 15 08 09 18 19 12 13 06 07 16 17 10 11 23 22 21 20 24 25 26 27 28 29 30 39 32 33 34 43 36 37 38 31 40 41 42 35 47 46 45 44'

B  = '13 15 02 03 01 05 00 07 08 09 10 11 12 23 14 22 18 16 19 17 20 21 04 06 38 25 26 27 28 24 30 31 32 33 34 35 36 37 47 39 41 43 40 42 44 45 46 29'
BI = '06 04 02 03 22 05 23 07 08 09 10 11 12 00 14 01 17 19 16 18 20 21 15 13 29 25 26 27 28 47 30 31 32 33 34 35 36 37 24 39 42 40 43 41 44 45 46 38'
B2 = '23 22 02 03 15 05 13 07 08 09 10 11 12 06 14 04 19 18 17 16 20 21 01 00 47 25 26 27 28 38 30 31 32 33 34 35 36 37 29 39 43 42 41 40 44 45 46 24'

L  = '19 01 17 03 06 04 07 05 00 09 02 11 12 13 14 15 16 22 18 20 08 21 10 23 24 42 26 27 29 31 28 30 32 25 34 35 36 37 38 39 40 41 45 43 44 33 46 47'
LI = '08 01 10 03 05 07 04 06 20 09 22 11 12 13 14 15 16 02 18 00 19 21 17 23 24 33 26 27 30 28 31 29 32 45 34 35 36 37 38 39 40 41 25 43 44 42 46 47'
L2 = '20 01 22 03 07 06 05 04 19 09 17 11 12 13 14 15 16 10 18 08 00 21 02 23 24 45 26 27 31 30 29 28 32 42 34 35 36 37 38 39 40 41 33 43 44 25 46 47'

U  = '02 00 03 01 08 09 06 07 12 13 10 11 16 17 14 15 04 05 18 19 20 21 22 23 25 27 24 26 32 29 30 31 36 33 34 35 40 37 38 39 28 41 42 43 44 45 46 47'
UI = '01 03 00 02 16 17 06 07 04 05 10 11 08 09 14 15 12 13 18 19 20 21 22 23 26 24 27 25 40 29 30 31 28 33 34 35 32 37 38 39 36 41 42 43 44 45 46 47'
U2 = '03 02 01 00 12 13 06 07 16 17 10 11 04 05 14 15 08 09 18 19 20 21 22 23 27 26 25 24 36 29 30 31 40 33 34 35 28 37 38 39 32 41 42 43 44 45 46 47'

F  = '00 01 07 05 04 20 06 21 10 08 11 09 02 13 03 15 16 17 18 19 14 12 22 23 24 25 26 30 28 29 44 31 33 35 32 34 36 27 38 39 40 41 42 43 37 45 46 47'
FI = '00 01 12 14 04 03 06 02 09 11 08 10 21 13 20 15 16 17 18 19 05 07 22 23 24 25 26 37 28 29 27 31 34 32 35 33 36 44 38 39 40 41 42 43 30 45 46 47'
F2 = '00 01 21 20 04 14 06 12 11 10 09 08 07 13 05 15 16 17 18 19 03 02 22 23 24 25 26 44 28 29 37 31 35 34 33 32 36 30 38 39 40 41 42 43 27 45 46 47'

arr = []

def _(x):
    arr = x.split(' ')
    return [int(item) for item in arr]

x = _(X)
r,ri,r2 = _(R), _(RI), _(R2)
d,di,d2 = _(D), _(DI), _(D2)
b,bi,b2 = _(B), _(BI), _(B2)

l,li,l2 = _(L), _(LI), _(L2)
u,ui,u2 = _(U), _(UI), _(U2)
f,fi,f2 = _(F), _(FI), _(F2)

#           0  1  2 3  4  5 6  7  8 9 10 11 12   14   16 17
MOVES    = 'r ri r2 d di d2 b bi b2 l li l2 u ui u2 f fi f2'.split(' ')
moves    = [r,ri,r2,d,di,d2,b,bi,b2,l,li,l2,u,ui,u2,f,fi,f2]
revmoves = [1,0, 2, 4,3, 5, 7,6, 8,10, 9,11,13,12,14,16,15,17]

class Cube(object):
    def __init__(self, s):
        self.state = s
        self.history = []

    def clone(self):
        cube = Cube(self.state)
        cube.history = self.history[:]
        return cube

    def move(self, m):
        self.state = ''.join([self.state[move] for move in moves[m]])
        self.history.append(m)

    def move_string(self, s):
        print 'move_string', self.state, self.get_key('A'), self.get_key('B'), self.get_key('C')
        arr = [MOVES.index(x) for x in s.split(' ')]
        for m in arr:
            self.move(m)
            xa = binary_search(a, self.get_key('A'), 24)
            xb = binary_search(b, self.get_key('B'), 12)
            xc = binary_search(c, self.get_key('C'), 12)
            print 'move_string', self.state, self.get_key('A'), self.get_key('B'), self.get_key('C'), xa, xb, xc

    def show(self):
        return self.state

    def display(self):
        #       0      1      2      3      4      5  (face numbers)
        POS = [[3,0], [0,3], [3,3], [6,3], [9,3], [3,6]]  # (x,y) coordinates for upper left corner for each face in the cross
        XY =  [[0,24], [4,28], [8,32], [12,36], [16,40], [20,44]]
        a = []
        for i in range(9):
            a.append([' '] * 12)
        for i in range(6):
            x,y = POS[i]
            c0,s0 = XY[i]
            a[y][x]     = self.state[c0+0]
            a[y][x+2]   = self.state[c0+1]
            a[y+2][x]   = self.state[c0+2]
            a[y+2][x+2] = self.state[c0+3]

            a[y][x+1]   = self.state[s0+0]
            a[y+1][x]   = self.state[s0+1]
            a[y+1][x+2] = self.state[s0+2]
            a[y+2][x+1] = self.state[s0+3]

        for i in range(9):
            print ' '.join(a[i])
        print

    def get_key(self, filename):
        s = self.state
        if filename == 'A':
            return s[0:24]
        if filename == 'B':
            return s[25:29] + s[30] + s[32:38] + s[44]
        if filename == 'C':
            return s[24] + s[29] + s[31] + s[38:44] + s[45:48]


def create_file(filename):
    cube = Cube(START)
    queue1 = [cube]
    count = 0
    hash = {cube.get_key(filename): count}
    while queue1 != []:
        print len(queue1)
        queue2 = []
        count += 1
        #if count == 6:
        #    break
        for c in queue1:
            for m in range(len(moves)):
                if c.history != []:
                    c3 = c.history[-1]/3
                    m3 = m/3
                    if c3 == m3: # r r, r ri, r2 r osv är ej tillåtna
                        continue
                    if m3 < 3 and m3 + 3 == c3: # r l ok men inte l r
                        continue
                cube = c.clone()
                cube.move(m)
                key = cube.get_key(filename)
                if key not in hash:
                    hash[key] = count
                queue2.append(cube)
        queue1 = queue2

    keys = sorted(hash.keys())
    f = open(filename + '.txt', 'w')
    for key in keys:
        f.write(key + ' ' + str(hash[key]) + '\n')
    f.close


def read_file(filename):
    with open(filename + '.txt') as f:
        return f.readlines()


def binary_search(a, x, n, lo=0, hi=None):
    if hi is None:
        hi = len(a)
    while lo < hi:
        mid = (lo+hi)//2
        midval = a[mid][0:n]
        if midval < x:
            lo = mid+1
        elif midval > x:
            hi = mid
        else:
            return int(a[mid].split(' ')[1])
    return -1


def h(state):
    cube = Cube(state)
    key_a = cube.get_key('A')
    key_b = cube.get_key('B')
    key_c = cube.get_key('C')
    xa = binary_search(a, key_a, 24)
    xb = binary_search(b, key_b, 12)
    xc = binary_search(c, key_c, 12)
    print 'h ',state,key_a,key_b,key_c,xa,xb,xc,' max ',max(xa, xb, xc)
    return max(xa, xb, xc)


def search(state, bound, movelist=[]):
    g = len(movelist)
    print '  '*g, 'search ', state, g, bound, movelist
    f = g + h(state)
    if f > bound:
        print '  '*g, f, []
        return f,[]
    if state == START:
        print '  '*g, True, movelist
        return True,movelist
    min = 9999

    for m in range(len(moves)):
        cube = Cube(state)
        cube.move(m)
        t,ml = search(cube.state, bound, movelist + [m])
        if t == True:
            print '  '*g, True, ml
            return True,ml
        if t < min:
            min = t
    print '  '*g, min, []
    return min,[]


def ida_star(root):
    bound = h(root)
    while True:
        print 'ida_star',bound
        t,ml = search(root, bound)
        if t == True:
            return True,' '.join([MOVES[m] for m in ml])
        if t == 9999:
            return False,[]
        bound = t


def investigate(moves):
    start = time.clock()
    cube = Cube(START)
    cube.move_string(moves)
    res,ml = ida_star(cube.state)
    print time.clock() - start
    return ml

if True:
    #create_file('A')
    #create_file('B')
    create_file('C')
else:
    a = read_file('A')
    b = read_file('B')
    c = read_file('C')

    # print investigate('r'), ' = ', 'ri'
    # print investigate('r f'), ' = ', 'fi ri'
    # print investigate('r f r'), ' = ', 'ri fi ri'
    # print investigate('r f r f'), ' = ', 'fi ri fi ri'
    print investigate('r f2 ri fi'), ' = ', 'f r f2 ri'
    # print investigate('r f2 ri fi u'), ' = ', 'ui f r f2 ri'
    # print investigate('r f2 ri fi u f'), ' = ', 'fi ui f r f2 ri'
    # print investigate('r f2 ri fi u f l'), ' = ', 'li fi ui f r f2 ri'
    # print investigate('r f2 ri fi u f l u2'), ' = ', 'u2 li fi ui f r f2 ri'
    # print investigate('r f2 ri fi u f l u2 b2'), ' = ', 'b2 u2 li fi ui f r f2 ri'
    # print investigate('r f2 ri fi u f l u2 b2 r'), ' = ', 'b2 u2 li fi ui f r f2 ri'
    # print investigate('r f2 ri fi u f l u2 b2 r fi'), ' = ', 'b2 u2 li fi ui f r f2 ri'


def test():
    for move in moves:
        print
        print sorted(move)
        print x
        assert sorted(move) == x
    cube = Cube(START)
    for i in range(len(moves)):
        cube.move(i)
        cube.move(i)
        cube.move(i)
        cube.move(i)
        assert cube.state == START

#test()

def test2():
    for i in range(18):
        cube = Cube(START)
        cube.move(i)
        print cube.state
#test2()



############################################
# def expand(state, queue, level, movelist):
#     for m in range(len(moves)):
#         cube = Cube(state)
#         cube.move(m)
#         queue.append((level + h(cube.state), cube.state, level+1, movelist + [m]))
#
#
# def solve(state):
#     assert sorted(state) == sorted(START)
#     cube = Cube(state)
#     queue = []
#     queue.append((1000, state, 0, []))  # [score, state, level, movelist]
#     while queue != []:
#         score, state, level, movelist = queue.pop(0)
#         cube = Cube(state)
#         expand(cube.state, queue, level, movelist)
#         queue = sorted(queue)
#         if cube.state == START:
#             return ' '.join([MOVES[m] for m in movelist])

