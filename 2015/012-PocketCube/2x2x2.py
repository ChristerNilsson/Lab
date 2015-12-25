import time

# Builds a text file with all solutions (one hour)
# Reads a text file (0.6 seconds)
# Solves a 2x2x2 pocket cube ( 0.1 ms)

# Colours: white-yellow orange-red blue-green
# Moves:   up-down      front-back left-right
#
#                                0 1 2 3 4 5 6 7 8 9
#        00 01                 0       r r                     u u
#        02 03                 1       r r                     u u
# 04 05  08 09  12 13  16 17   2 b b   * w   g g   y y    l l  * f  r r  b b
# 06 07  10 11  14 15  18 19   3 b b   w w   g g   y y    l l  f f  r r  b b
#        20 21                 4       o o                     d d
#        22 23                 5       o o                     d d

# The factor 24 is handled by keeping the white marker in the same position all the time. 02, 05 and 08 are fixed.
# Only moves R, D, F are used as they will not affect the * square.
# Positions: 3674160 (same number of lines in the text file)

# Face numbers used in the cross:
#   0
#  1234
#   5
#       0      1      2      3      4      5  (face numbers)
POS = [[3,0], [0,2], [3,2], [6,2], [9,2], [3,4]]  # (x,y) coordinates for upper left corner for each face in the cross

START = 'rrrrbbbbwwwwggggyyyyoooo'

X  = '00 01 02 03 04 05 06 07 08 09 10 11 12 13 14 15 16 17 18 19 20 21 22 23'

R  = '00 09 02 11 04 05 06 07 08 21 10 23 14 12 15 13 03 17 01 19 20 18 22 16'
RI = '00 18 02 16 04 05 06 07 08 01 10 03 13 15 12 14 23 17 21 19 20 09 22 11'
R2 = '00 21 02 23 04 05 06 07 08 18 10 16 15 14 13 12 11 17 09 19 20 01 22 03'

D  = '00 01 02 03 04 05 18 19 08 09 06 07 12 13 10 11 16 17 14 15 22 20 23 21'
DI = '00 01 02 03 04 05 10 11 08 09 14 15 12 13 18 19 16 17 06 07 21 23 20 22'
D2 = '00 01 02 03 04 05 14 15 08 09 18 19 12 13 06 07 16 17 10 11 23 22 21 20'

B  = '13 15 02 03 01 05 00 07 08 09 10 11 12 23 14 22 18 16 19 17 20 21 04 06'
BI = '06 04 02 03 22 05 23 07 08 09 10 11 12 00 14 01 17 19 16 18 20 21 15 13'
B2 = '23 22 02 03 15 05 13 07 08 09 10 11 12 06 14 04 19 18 17 16 20 21 01 00'

arr = []

def _(x):
    arr = x.split(' ')
    return [int(item) for item in arr]

x = _(X)
r,ri,r2 = _(R), _(RI), _(R2)
d,di,d2 = _(D), _(DI), _(D2)
b,bi,b2 = _(B), _(BI), _(B2)

#           0  1  2 3  4  5 6  7  8
MOVES    = 'r ri r2 d di d2 b bi b2'.split(' ')
moves    = [r,ri,r2,d,di,d2,b,bi,b2]
revmoves = [1,0, 2, 4,3, 5, 7,6, 8]

class PocketCube(object):
    def __init__(self, s):
        self.state = s

    def move(self, m):
        self.state = ''.join([self.state[move] for move in moves[m]])

    def show(self):
        return self.state

    def display(self):
        a = []
        for i in range(6):
            a.append([' '] * 11)
        for i in range(6):
            x,y = POS[i]
            a[y][x]     = self.state[4*i+0]
            a[y][x+1]   = self.state[4*i+1]
            a[y+1][x]   = self.state[4*i+2]
            a[y+1][x+1] = self.state[4*i+3]
        for i in range(6):
            print ' '.join(a[i])
        print

def create_file():
    queue = [START]
    hash = {START: ''}

    cube = PocketCube(START)
    while queue != []:
        print len(hash)
        s = queue.pop(0)
        for m in range(len(moves)):
            cube = PocketCube(s)
            cube.move(m)
            key = cube.state
            if key not in hash:
                hash[key] = m
                queue.append(key)

    keys = sorted(hash.keys())
    f = open('solution.txt', 'w')
    for key in keys:
        f.write(key + ' ' + str(hash[key]) + '\n')
    f.close
    for h in hash:
        if h != START:
            print h, MOVES[hash[h]]

def read_file():
    with open('solution.txt') as f:
        return f.readlines()

def binary_search(a, x, lo=0, hi=None):
    if hi is None:
        hi = len(a)
    while lo < hi:
        mid = (lo+hi)//2
        midval = a[mid][0:24]
        if midval < x:
            lo = mid+1
        elif midval > x:
            hi = mid
        else:
            return mid
    return -1

def solve(state):
    s = sorted(state)
    assert s == sorted(START)
    cube = PocketCube(state)
    cube.display()
    solution = ''
    while True:
        m = binary_search(arr,state)
        pair = arr[m].strip().split(' ')
        if len(pair) == 1:
            m = ''
        else:
            m = int(pair[1])

        if m == '':
            break
        op = revmoves[int(m)]
        cube.move(op)
        print MOVES[op]
        solution += MOVES[op] + ' '
        cube.display()
        state = cube.state
    print solution

start = time.clock()
if False:
    create_file()
else:
    arr = read_file()
    solve('rgryybbbwbwrrwggogyyowoo')
print
print time.clock() - start

def test():
    for move in moves:
        assert sorted(move) == x
    cube = PocketCube(START)
    for i in range(len(moves)):
        cube.move(i)
        cube.move(i)
        cube.move(i)
        cube.move(i)
        assert cube.state == START
test()