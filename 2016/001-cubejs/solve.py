# Cube = @Cube or require('./cube')

from cube import Cube
import math
import types
import time

# Corners
[URF, UFL, ULB, UBR, DFR, DLF, DBL, DRB] = range(8)

# Edges
[UR, UF, UL, UB, DR, DF, DL, DB, FR, FL, BL, BR] = range(12)

## Helpers

def revrange(a,b): # a > b
    return [i for i in reversed(range(b,a+1))]

assert revrange(3,0) == [3,2,1,0]
assert range(0,3) == [0,1,2]

# n choose k, i.e. the binomial coeffiecient
def Cnk(n, k):
    if n < k:
        return 0
    if k > n / 2:
        k = n - k
    s = 1
    i = n
    j = 1
    while i != n - k:
        s *= i
        s /= j
        i -= 1
        j += 1
    return s
assert Cnk(1,2) == 0
assert Cnk(6,4) == 6*5/2

# n!
def factorial(n):
    f = 1
    for i in range(2,n+1):
        f *= i
    return f
assert factorial(0) == 1
assert factorial(3) == 6
assert factorial(4) == 24


# Maximum of two values
# def max(a, b):
#     if a > b:
#         return a
#     else:
#         return b
assert max(1,2) == 2
assert max(2,1) == 2

# Rotate elements between l and r left by one place
def rotateLeft(array, l, r):
    tmp = array[l]
    for i in range(l,r):
        array[i] = array[i + 1]
    array[r] = tmp
arr = [1,2,3,4]
rotateLeft(arr,1,2)
assert arr == [1,3,2,4]

# Rotate elements between l and r right by one place
def rotateRight(array, l, r):
    tmp = array[r]
    for i in reversed(range(l,r+1)):
        array[i] = array[i-1]
    array[l] = tmp
arr = [1,2,3,4]
rotateRight(arr,1,2)
assert arr == [1,3,2,4]


# Generate a function that computes permutation indices.
#
# The permutation index actually encodes two indices: Combination,
# i.e. positions of the cubies start..end (A) and their respective
# permutation (B). The maximum value for B is
#
#   maxB = (end - start + 1)!
#
# and the index is A * maxB + B

def permutationIndex(context, start, end, fromEnd=False):
    maxOur = end - start
    maxB = factorial(maxOur + 1)

    if context == 'corners':
        maxAll = 7
        permName = 'cp'
    else:
        maxAll = 11
        permName = 'ep'

    our = [0 for i in range(maxOur+1)]

    def noname(target, index=None):
        if index != None:
            # Reset our to [start..end]
            for i in range(maxOur+1):
                our[i] = i + start

            b = index % maxB      # permutation
            a = index / maxB | 0  # combination

            # Invalidate all edges
            perm = getattr(target,permName)  # @[permName]
            for i in range(maxAll+1):
                perm[i] = -1

            # Generate permutation from index b
            for j in range(maxOur+1):
                k = b % (j + 1)
                b = b / (j + 1) | 0
                # TODO: Implement rotateRightBy(our, 0, j, k)
                while k > 0:
                    rotateRight(our, 0, j)
                    k -= 1

            # Generate combination and set our edges
            x = maxOur
            if fromEnd==True:
                for j in range(maxAll+1):
                    c = Cnk(maxAll - j, x + 1)
                    if a - c >= 0:
                        perm[j] = our[maxOur - x]
                        a -= c
                        x -= 1
            else:
                for j in revrange(maxAll, 0): # maxAll..0
                    c = Cnk(j, x + 1)
                    if a - c >= 0:
                        perm[j] = our[x]
                        a -= c
                        x -= 1
            #print 'noname1'
            return target

        else:
            #perm = target[permName]
            perm = getattr(target,permName)

            for i in range(maxOur+1):
                our[i] = -1
            a = b = x = 0

            # Compute the index a < ((maxAll + 1) choose (maxOur + 1)) and
            # the permutation
            if fromEnd == True:
                for j in revrange(maxAll,0): #[maxAll..0]
                    if start <= perm[j] <= end:
                        a += Cnk(maxAll - j, x + 1)
                        our[maxOur - x] = perm[j]
                        x += 1
            else:
                for j in range(maxAll+1): # [0..maxAll]
                    if start <= perm[j] <= end:
                        a += Cnk(j, x + 1)
                        our[x] = perm[j]
                        x += 1

            # Compute the index b < (maxOur + 1)! for the permutation
            for j in revrange(maxOur,0):
                k = 0
                while our[j] != start + j:
                    rotateLeft(our, 0, j)
                    k+=1
                b = (j + 1) * b + k

            #print 'noname2'
            return a * maxB + b
    return noname

def f_twist(target,twist=None):
    if twist:
        parity = 0
        for i in revrange(6,0): # 6..0
            ori = twist % 3
            twist = (twist / 3) | 0

            target.co[i] = ori
            parity += ori

        target.co[7] = ((3 - parity % 3) % 3)
        return target

    else:
        v = 0
        for i in range(7):
            v = 3 * v + target.co[i]
        return v

def f_flip(target,flip=None):
    if flip:
        parity = 0
        for i in revrange(10,0): # [10..0]
            ori = flip % 2
            flip = flip / 2 | 0

            target.eo[i] = ori
            parity += ori

        target.eo[11] = ((2 - parity % 2) % 2)
        return target
    else:
      v = 0
      for i in range(11):
          v = 2 * v + target.eo[i]
      return v

def f_cornerParity(target):
    s = 0
    for i in revrange(DRB, URF + 1):
        for j in revrange(i - 1, URF):
            if target.cp[j] > target.cp[i]:
                s += 1

    return s % 2

def f_edgeParity(target):
    s = 0
    for i in revrange(BR,UR + 1):
        for j in revrange(i - 1,UR):
            if target.ep[j] > target.ep[i]:
                s += 1
    return s % 2


Include = {
    # The twist of the 8 corners, 0 <= twist < 3^7. The orientation of
    # the DRB corner is fully determined by the orientation of the other
    # corners.
    'twist': f_twist,

    # The flip of the 12 edges, 0 <= flip < 2^11. The orientation of the
    # BR edge is fully determined by the orientation of the other edges.
    'flip': f_flip,

    # Parity of the corner permutation
    'cornerParity': f_cornerParity,

    # Parity of the edges permutation. Parity of corners and edges are
    # the same if the cube is solvable.
    'edgeParity': f_edgeParity,

    # Permutation of the six corners URF, UFL, ULB, UBR, DFR, DLF
    'URFtoDLF': permutationIndex('corners', URF, DLF),

    # Permutation of the three edges UR, UF, UL
    'URtoUL': permutationIndex('edges', UR, UL),

    # Permutation of the three edges UB, DR, DF
    'UBtoDF': permutationIndex('edges', UB, DF),

    # Permutation of the six edges UR, UF, UL, UB, DR, DF
    'URtoDF': permutationIndex('edges', UR, DF),

    # Permutation of the equator slice edges FR, FL, BL and BR
    'FRtoBR': permutationIndex('edges', FR, BR, True)

    }

# for key, value of Include
#   Cube::[key] = value

# Cube.twist = types.MethodType(Include['twist'],Cube)
# Cube.flip = types.MethodType(Include['flip'],Cube)
# Cube.cornerParity = types.MethodType(Include['cornerParity'],Cube)
# Cube.edgeParity = types.MethodType(Include['edgeParity'],Cube)
# Cube.URFtoDLF = types.MethodType(Include['URFtoDLF'],Cube)
# Cube.URtoUL = types.MethodType(Include['URtoUL'],Cube)
# Cube.UBtoDF = types.MethodType(Include['UBtoDF'],Cube)
# Cube.URtoDF = types.MethodType(Include['URtoDF'],Cube)
# Cube.FRtoBR = types.MethodType(Include['FRtoBR'],Cube)

Cube.twist = f_twist
Cube.flip = f_flip
Cube.cornerParity = f_cornerParity
Cube.edgeParity = f_edgeParity
Cube.URFtoDLF = permutationIndex('corners', URF, DLF)
Cube.URtoUL = permutationIndex('edges', UR, UL)
Cube.UBtoDF = permutationIndex('edges', UB, DF)
Cube.URtoDF = permutationIndex('edges', UR, DF)
Cube.FRtoBR = permutationIndex('edges', FR, BR, True)

#print "Cube"
#print dir(Cube)

def computeMoveTable(context, coord, size):
    # Loop through all valid values for the coordinate, setting cube's
    # state in each iteration. Then apply each of the 18 moves to the
    # cube, and compute the resulting coordinate.
    if context == 'corners':
        apply = 'cornerMultiply'
    else:
        apply = 'edgeMultiply'

    cube = Cube()

    res = []
    #print context,coord,size,apply
    for i in range(size):
        #cube[coord](i)
        getattr(cube, coord)(i)

        inner = []
        for j in range(6):
            move = Cube.moves[j]
            for k in range(3):
                #cube[apply](move)
                getattr(cube, apply)(move)
                inner.append(getattr(cube, coord)())
            # 4th face turn restores the cube
            #cube[apply](move)
            getattr(cube, apply)(move)
        res.append(inner)
    return res

# Because we only have the phase 2 URtoDF coordinates, we need to
# merge the URtoUL and UBtoDF coordinates to URtoDF in the beginning
# of phase 2.
def mergeURtoDF_():
    a = Cube()
    b = Cube()
    def noname(URtoUL, UBtoDF):
        # Collisions can be found because unset are set to -1
        a.URtoUL(URtoUL)
        b.UBtoDF(UBtoDF)
        for i in range(8):
            if a.ep[i] != -1:
                if b.ep[i] != -1:
                    return -1  # collision
                else:
                    b.ep[i] = a.ep[i]
        return b.URtoDF()
    return noname

mergeURtoDF = mergeURtoDF_()

N_TWIST = 2187    # 3^7 corner orientations
N_FLIP = 2048     # 2^11 possible edge flips
N_PARITY = 2      # 2 possible parities

N_FRtoBR = 11880  # 12!/(12-4)! permutations of FR..BR edges
N_SLICE1 = 495    # (12 choose 4) possible positions of FR..BR edges
N_SLICE2 = 24     # 4! permutations of FR..BR edges in phase 2

N_URFtoDLF = 20160  # 8!/(8-6)! permutations of URF..DLF corners

# The URtoDF move table is only computed for phase 2 because the full
# table would have >650000 entries
N_URtoDF = 20160  # 8!/(8-6)! permutation of UR..DF edges in phase 2

N_URtoUL = 1320  # 12!/(12-3)! permutations of UR..UL edges
N_UBtoDF = 1320  # 12!/(12-3)! permutations of UB..DF edges

# The move table for parity is so small that it's included here
Cube.moveTables = {
    'parity': [
        [1, 0, 1, 1, 0, 1, 1, 0, 1, 1, 0, 1, 1, 0, 1, 1, 0, 1],
        [0, 1, 0, 0, 1, 0, 0, 1, 0, 0, 1, 0, 0, 1, 0, 0, 1, 0],
    ],
    'twist': None,
    'flip': None,
    'FRtoBR': None,
    'URFtoDLF': None,
    'URtoDF': None,
    'URtoUL': None,
    'UBtoDF': None,
    'mergeURtoDF': None
    }

# Other move tables are computed on the fly
moveTableParams = {
    # name: [scope, size]
    'twist': ['corners', N_TWIST],
    'flip': ['edges', N_FLIP],
    'FRtoBR': ['edges', N_FRtoBR],
    'URFtoDLF': ['corners', N_URFtoDLF],
    'URtoDF': ['edges', N_URtoDF],
    'URtoUL': ['edges', N_URtoUL],
    'UBtoDF': ['edges', N_UBtoDF],
    'mergeURtoDF': []  # handled specially
    }

def dumpList(tableName,table,start):
    with open("data\\" + tableName + ".txt", "w") as f:
        for item in table:
            f.write(str(item) + "\n")
    print 'dumpList', tableName, len(table), time.clock()-start

def dumpMatrix(tableName,table,start):
    with open("data\\" + tableName + ".txt", "w") as f:
        for row in table:
            f.write(' '.join([str(item) for item in row]) + "\n")
    print 'dumpMatrix', tableName, len(table), time.clock()-start

def loadList(tableName):
    start = time.clock()
    with open("data\\" + tableName + ".txt", "r") as f:
        lines = f.readlines()
    table = [int(line) for line in lines]
    print 'loadList', tableName, len(table), time.clock()-start
    return table

def loadMatrix(tableName):
    start = time.clock()
    with open("data\\" + tableName + ".txt", "r") as f:
        lines = f.readlines()
    table = [[int(item) for item in line.split(' ')] for line in lines]
    print 'loadMatrix', tableName, len(table), time.clock()-start
    return table

def computeMoveTables(target, *tables):
    if len(tables) == 0:
        tables = [name for name in moveTableParams]

    for tableName in tables:
        start = time.clock()
        # Already computed
        if target.moveTables[tableName] is not None:
            continue

        target.moveTables[tableName] = loadMatrix(tableName)

        # if tableName == 'mergeURtoDF':
        #     target.moveTables['mergeURtoDF'] = [[mergeURtoDF(URtoUL, UBtoDF) for UBtoDF in range(336)] for URtoUL in range(336)]
        # else:
        #     [scope, size] = moveTableParams[tableName]
        #     target.moveTables[tableName] = computeMoveTable(scope, tableName, size)
        # dumpMatrix(tableName, target.moveTables[tableName], start)

    return target
Cube.computeMoveTables = types.MethodType(computeMoveTables, Cube)

# Phase 1: All moves are valid
allMoves1 = range(18)

# The list of next valid phase 1 moves when the given face was turned
# in the last move
def nextMoves1():
    res = []
    for lastFace in range(6):
        next = []
        # Don't allow commuting moves, e.g. U U'. Also make sure that
        # opposite faces are always moved in the same order, i.e. allow
        # U D but no D U. This avoids sequences like U D U'.
        for face in range(6):
            if face != lastFace and face != lastFace - 3:
                for power in range(3):  # single, double or inverse move
                    next.append(face * 3 + power)
        res.append(next)
    return res

# Phase 2: Double moves of all faces plus quarter moves of U and D
allMoves2 = [0, 1, 2, 4, 7, 9, 10, 11, 13, 16]

def nextMoves2():
    res = []
    for lastFace in range(6):
        next = []
        for face in range(6):
            if face != lastFace and face != lastFace - 3:
                # Allow all moves of U and D and double moves of others
                if face in [0, 3]:
                    powers = range(3)
                else:
                    powers = [1]
                for power in powers:
                    next.append(face * 3 + power)
        res.append(next)
    return res

# 8 values are encoded in one number
def pruning (table, index, value=None):
    pos = index % 8
    slot = index >> 3
    shift = pos << 2

    if value is not None:
        # Set
        #print 'pruning',value
        table[slot] &= ~(0xF << shift)
        table[slot] |= (value << shift)
        return value
    else:
        # Get
        #print index, pos, slot, table[slot], shift
        # >> och >>> same thing in Python.
        # http://stackoverflow.com/questions/6535373/special-js-operators-in-python
        return (table[slot] & (0xF << shift)) >> shift  # >> ska vara >>> (zerofill shift)

def computePruningTable(phase, size, currentCoords, nextIndex):
    # Initialize all values to 0xF
    #print size, size/8.0,math.ceil(size / 8.0), int(math.ceil(size / 8.0))
    table = [0xFFFFFFFF for x in range(int(math.ceil(size / 8.0)))]

    #print size, len(table)

    if phase == 1:
        moves = allMoves1
    else:
        moves = allMoves2

    depth = 0
    pruning(table, 0, depth)
    done = 1

    # In each iteration, take each state found in the previous depth and
    # compute the next state. Stop when all states have been assigned a
    # depth.
    while done != size:
        for index in range(size):
            if pruning(table, index) == depth:
                current = currentCoords(index)
                for move in moves:
                    next = nextIndex(current, move)
                    if pruning(table, next) == 0xF:
                       pruning(table, next, depth + 1)
                       done += 1
        depth += 1

    return table

Cube.pruningTables = {
   'sliceTwist': None,
   'sliceFlip': None,
   'sliceURFtoDLFParity': None,
   'sliceURtoDFParity': None
}

def f1(current, move):
    [slice, twist] = current
    newSlice = Cube.moveTables['FRtoBR'][slice * 24][move] / 24 | 0
    newTwist = Cube.moveTables['twist'][twist][move]
    return newTwist * N_SLICE1 + newSlice

def f2(current, move):
    [slice, flip] = current
    newSlice = Cube.moveTables['FRtoBR'][slice * 24][move] / 24 | 0
    newFlip = Cube.moveTables['flip'][flip][move]
    return newFlip * N_SLICE1 + newSlice

def f3(current, move):
    [parity, slice, URFtoDLF] = current
    newParity = Cube.moveTables['parity'][parity][move]
    newSlice = Cube.moveTables['FRtoBR'][slice][move]
    newURFtoDLF = Cube.moveTables['URFtoDLF'][URFtoDLF][move]
    return (newURFtoDLF * N_SLICE2 + newSlice) * 2 + newParity

def f4(current, move):
    [parity, slice, URtoDF] = current
    #newParity = Cube.moveTables.parity[parity][move]
    #newSlice = Cube.moveTables.FRtoBR[slice][move]
    #newURtoDF = Cube.moveTables.URtoDF[URtoDF][move]
    newParity = Cube.moveTables['parity'][parity][move]
    #print current,Cube.moveTables['FRtoBR'],slice,move
    newSlice = Cube.moveTables['FRtoBR'][slice][move]
    newURtoDF = Cube.moveTables['URtoDF'][URtoDF][move]
    return (newURtoDF * N_SLICE2 + newSlice) * 2 + newParity

pruningTableParams = {
    # name: [phase, size, currentCoords, nextIndex]

    'sliceTwist': [
        1,
        N_SLICE1 * N_TWIST,
        lambda (index): [index % N_SLICE1, index / N_SLICE1 | 0],
        f1
    ],

    'sliceFlip': [
        1,
        N_SLICE1 * N_FLIP,
        lambda (index): [index % N_SLICE1, index / N_SLICE1 | 0],
        f2
    ],

    'sliceURFtoDLFParity': [
         2,
         N_SLICE2 * N_URFtoDLF * N_PARITY,
         lambda (index): [index % 2, (index / 2 | 0) % N_SLICE2, (index / 2 | 0) / N_SLICE2 | 0],
         f3
    ],

    'sliceURtoDFParity': [
        2,
        N_SLICE2 * N_URtoDF * N_PARITY,
        lambda (index): [index % 2, (index / 2 | 0) % N_SLICE2, (index / 2 | 0) / N_SLICE2 | 0],
        f4
    ]
    }


def computePruningTables(target, *tables):

    if len(tables) is 0:
        tables = [name for name in pruningTableParams]

    for tableName in tables:
        start = time.clock()
        # Already computed
        if target.pruningTables[tableName] is not None:
            continue

        target.pruningTables[tableName] = loadList(tableName)
        #params = pruningTableParams[tableName]
        #target.pruningTables[tableName] = computePruningTable(*params)
        #dumpList(tableName, target.pruningTables[tableName], start)

    return target
Cube.computePruningTables = types.MethodType(computePruningTables, Cube)


def initSolver(target):
    Cube.computeMoveTables()
    print 'computeMoveTables done'
    Cube.computePruningTables()
    print 'computePruningTables done'
Cube.initSolver = types.MethodType(initSolver, Cube)


def solve(self, maxDepth=22):
    # Names for all moves, i.e. U, U2, U', F, F2, ...

    print self
    faceName = ['U', 'F', 'L', 'D', 'B', 'R']
    powerName = ['', '2', "'"]

    moveNames = [faceName[face] + powerName[power] for face in range(6) for power in range(3)]
    self.solution = None

    class State:
        def __init__(self,cube = None):
            self.parent = None
            self.lastMove = None
            self.depth = 0

            if cube:
                self.init(cube)

        def __str__(self):
            return 'State'

        def init(self,cube):
            # Phase 1 coordinates
            self.flip = cube.flip()
            self.twist = cube.twist()
            self.slice = cube.FRtoBR() / N_SLICE2 | 0

            # Phase 2 coordinates
            self.parity = cube.cornerParity()
            self.URFtoDLF = cube.URFtoDLF()
            self.FRtoBR = cube.FRtoBR()

            # These are later merged to URtoDF when phase 2 begins
            self.URtoUL = cube.URtoUL()
            self.UBtoDF = cube.UBtoDF()

            return self

        def solution(self):
            if self.parent:
                return self.parent.solution() + moveNames[self.lastMove] + ' '
            else:
                return ''

        ## Helpers

        def move(self, table, index, m):  # m = move
            #print 'move',table,index,m  # flip 137 0
            #print len(Cube.moveTables)  # 9
            #print len(Cube.moveTables[table]) # 2048
            #print len(Cube.moveTables[table][index]) # 18
            #print Cube.moveTables[table][index][m]
            return Cube.moveTables[table][index][m]

        def state_pruning(self, table, index):
            #print 'state_pruning',table,index
            return pruning(Cube.pruningTables[table], index)

        ## Phase 1

        # Return the next valid phase 1 moves for this state
        def moves1(self):
            if self.lastMove != None:
                return nextMoves1()[self.lastMove / 3 | 0]
            else:
                return allMoves1

        # Compute the minimum number of moves to the end of phase 1
        def minDist1(self):
            # The maximum number of moves to the end of phase 1 wrt. the
            # combination flip and slice coordinates only
            d1 = self.state_pruning('sliceFlip', N_SLICE1 * self.flip + self.slice)

            # The combination of twist and slice coordinates
            d2 = self.state_pruning('sliceTwist', N_SLICE1 * self.twist + self.slice)

            #print 'minDist1',d1,d2

            # The true minimal distance is the maximum of these two
            return max(d1, d2)

        # Compute the next phase 1 state for the given move
        def next1(self,move):
            #print 'next1',move
            next = freeStates.pop()
            next.parent = self
            next.lastMove = move
            next.depth = self.depth + 1
            next.flip = self.move('flip', self.flip, move)
            next.twist = self.move('twist', self.twist, move)
            next.slice = self.move('FRtoBR', self.slice * 24, move) / 24 | 0
            return next

        ## Phase 2

        # Return the next valid phase 2 moves for this state
        def moves2(self):
            if self.lastMove != None:
                return nextMoves2()[self.lastMove / 3 | 0]
            else:
                return allMoves2

        # Compute the minimum number of moves to the solved cube
        def minDist2(self):
            index1 = (N_SLICE2 * self.URtoDF + self.FRtoBR) * N_PARITY + self.parity
            d1 = self.state_pruning('sliceURtoDFParity', index1)

            index2 = (N_SLICE2 * self.URFtoDLF + self.FRtoBR) * N_PARITY + self.parity
            d2 = self.state_pruning('sliceURFtoDLFParity', index2)

            return max(d1, d2)

        # Initialize phase 2 coordinates
        def init2(self,top=True):
            if self.parent is None:
                # Already assigned for the initial state
                return

            # For other states, the phase 2 state is computed based on
            # parent's state
            self.parent.init2(False)

            self.URFtoDLF = self.move('URFtoDLF', self.parent.URFtoDLF, self.lastMove)
            self.FRtoBR = self.move('FRtoBR', self.parent.FRtoBR, self.lastMove)
            self.parity = self.move('parity', self.parent.parity, self.lastMove)
            self.URtoUL = self.move('URtoUL', self.parent.URtoUL, self.lastMove)
            self.UBtoDF = self.move('UBtoDF', self.parent.UBtoDF, self.lastMove)

            if top == True:
                # This is the initial phase 2 state. Get the URtoDF coordinate
                # by merging URtoUL and UBtoDF
                self.URtoDF = self.move('mergeURtoDF', self.URtoUL, self.UBtoDF)

        # Compute the next phase 2 state for the given move
        def next2(self,move):
            next = freeStates.pop()
            next.parent = self
            next.lastMove = move
            next.depth = self.depth + 1

            next.URFtoDLF = self.move('URFtoDLF', self.URFtoDLF, move)
            next.FRtoBR = self.move('FRtoBR', self.FRtoBR, move)
            next.parity = self.move('parity', self.parity, move)
            next.URtoDF = self.move('URtoDF', self.URtoDF, move)

            return next


    def phase1search(state):
        #print 'phase1search',state
        depth = 0
        for depth in range(1,maxDepth+1):
            phase1(state, depth)
            if self.solution is not None:
                break
            depth += 1

    def phase1(state, depth):
        #print 'phase1',state,depth
        if depth == 0:
            if state.minDist1() == 0:
                # Make sure we don't start phase 2 with a phase 2 move as the
                # last move in phase 1, because phase 2 would then repeat the
                # same move.
                if state.lastMove is None or state.lastMove not in allMoves2:
                    phase2search(state)

        elif depth > 0:
            if state.minDist1() <= depth:
                for move in state.moves1():
                    next = state.next1(move)
                    phase1(next, depth - 1)
                    freeStates.append(next)
                    if self.solution is not None:
                        break

    def phase2search(state):
        #print 'phase2search',state

        # Initialize phase 2 coordinates
        state.init2()

        for depth in range(1,maxDepth - state.depth+1):
           phase2(state, depth)
           if self.solution is not None:
               break
           depth += 1

    def phase2(state, depth):
        #print 'phase2',state,depth

        if depth == 0:
            if state.minDist2() == 0:
                solution = state.solution()
        elif depth > 0:
            if state.minDist2() <= depth:
                for move in state.moves2():
                    next = state.next2(move)
                    phase2(next, depth - 1)
                    freeStates.append(next)
                    if self.solution is not None:
                        break

    freeStates = [State() for x in range(maxDepth + 1 + 1)]
    print freeStates
    state = freeStates.pop().init(self)
    print state
    phase1search(state)
    freeStates.append(state)

    # Trim the trailing space
    if len(self.solution) > 0:
        self.solution = self.solution[0:len(self.solution) - 1]

    return self.solution

Cube.solve = solve
#Cube.solve = types.MethodType(solve, Cube)

def scramble():
    Cube.inverse(Cube.random().solve())
Cube.scramble = types.MethodType(scramble, Cube)

#print dir(Cube)

start = time.clock()
Cube.initSolver()
print time.clock()-start

cube = Cube()
cube.move("F R")

start = time.clock()
print cube.solve()
print time.clock()-start
