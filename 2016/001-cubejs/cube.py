import random

# Corners
URF, UFL, ULB, UBR, DFR, DLF, DBL, DRB = range(8)

# Edges
UR, UF, UL, UB, DR, DF, DL, DB, FR, FL, BL, BR = range(12)

U = lambda x: x - 1
R = lambda x: U(9) + x
F = lambda x: R(9) + x
D = lambda x: F(9) + x
L = lambda x: D(9) + x
B = lambda x: L(9) + x

[cornerFacelet, edgeFacelet] = [
    # Corners
    [
      [U(9), R(1), F(3)], [U(7), F(1), L(3)],
      [U(1), L(1), B(3)], [U(3), B(1), R(3)],
      [D(3), F(9), R(7)], [D(1), L(9), F(7)],
      [D(7), B(9), L(7)], [D(9), R(9), B(7)],
    ],
    # Edges
    [
      [U(6), R(2)], [U(8), F(2)], [U(4), L(2)], [U(2), B(2)],
      [D(6), R(8)], [D(2), F(8)], [D(4), L(8)], [D(8), B(8)],
      [F(6), R(4)], [F(4), L(6)], [B(6), L(4)], [B(4), R(6)],
    ],
  ]

cornerColor = [
  ['U', 'R', 'F'], ['U', 'F', 'L'], ['U', 'L', 'B'], ['U', 'B', 'R'],
  ['D', 'F', 'R'], ['D', 'L', 'F'], ['D', 'B', 'L'], ['D', 'R', 'B'],
]

edgeColor = [
  ['U', 'R'], ['U', 'F'], ['U', 'L'], ['U', 'B'], ['D', 'R'], ['D', 'F'],
  ['D', 'L'], ['D', 'B'], ['F', 'R'], ['F', 'L'], ['B', 'L'], ['B', 'R'],
]

faceNums = {
    'U': 0,
    'F': 1,
    'L': 2,
    'D': 3,
    'B': 4,
    'R': 5
}

faceNames = {
    0: 'U',
    1: 'F',
    2: 'L',
    3: 'D',
    4: 'B',
    5: 'R'
}


def ass(a,b):
    if a!=b:
        print a
        print b
        assert a == b

class Cube():
    def __init__(self, other=None):
        if other:
            self.init(other)
        else:
            self.identity()

        # For moves to avoid allocating new objects each time
        self.newCp = [0 for x in range(8)]
        self.newEp = [0 for x in range(12)]
        self.newCo = [0 for x in range(8)]
        self.newEo = [0 for x in range(12)]

    def init(self, state):
        if state.__class__ is Cube:
            self.cp = state.cp[:] # .slice(0)
            self.co = state.co[:] # .slice(0)
            self.ep = state.ep[:] # .slice(0)
            self.eo = state.eo[:] # .slice(0)
        else:
            self.cp = state['cp'][:] # .slice(0)
            self.co = state['co'][:] # .slice(0)
            self.ep = state['ep'][:] # .slice(0)
            self.eo = state['eo'][:] # .slice(0)

    def identity(self):
        # Initialize to the identity cube
        self.cp = range(8)
        self.co = [0 for x in range(8)]
        self.ep = range(12)
        self.eo = [0 for x in range(12)]

    def toJSON(self):
        return {'cp': self.cp, 'co': self.co, 'ep': self.ep, 'eo': self.eo}

    def __str__(self):
        result = ['' for i in range(54)]

        # Initialize centers
        for [i, c] in [[4, 'U'], [13, 'R'], [22, 'F'], [31, 'D'], [40, 'L'], [49, 'B']]:
            result[i] = c

        for i in range(8):
            corner = self.cp[i]
            ori = self.co[i]
            for n in range(3):
                result[cornerFacelet[i][(n + ori) % 3]] = cornerColor[corner][n]

        for i in range(12):
            edge = self.ep[i]
            ori = self.eo[i]
            for n in range(2):
                result[edgeFacelet[i][(n + ori) % 2]] = edgeColor[edge][n]

        return ''.join(result)

    @classmethod
    def fromString(cls,str):
        cube = Cube()

        for i in range(8):
            for ori in range(3):
                if str[cornerFacelet[i][ori]] in ['U', 'D']:
                    break
            col1 = str[cornerFacelet[i][(ori + 1) % 3]]
            col2 = str[cornerFacelet[i][(ori + 2) % 3]]

            for j in range(8):
                if col1 == cornerColor[j][1] and col2 == cornerColor[j][2]:
                    cube.cp[i] = j
                    cube.co[i] = ori % 3

        for i in range(12):
            for j in range(12):
                if str[edgeFacelet[i][0]] == edgeColor[j][0] and str[edgeFacelet[i][1]] == edgeColor[j][1]:
                    cube.ep[i] = j
                    cube.eo[i] = 0
                    break
                if (str[edgeFacelet[i][0]] == edgeColor[j][1] and str[edgeFacelet[i][1]] == edgeColor[j][0]):
                    cube.ep[i] = j
                    cube.eo[i] = 1
                    break

        return cube

    def clone(self):
        return Cube(self.toJSON())

    def randomize(self):
        #randint = lambda min, max:  min + (random.random() * (max - min + 1) | 0)

        def mixPerm (arr):
            max = len(arr) - 1
            for i in range(max-1):
                r = random.randint(i, max)

                # Ensure an even number of swaps
                if i != r:
                    arr[i], arr[r] = arr[r], arr[i]
                    arr[max], arr[max - 1] = arr[max - 1], arr[max]

        def randOri(arr, max):
            ori = 0
            for i in range(len(arr) - 1):
                arr[i] = random.randint(0, max - 1)
                ori += arr[i]

            # Set the orientation of the last cubie so that the cube is valid
            arr[len(arr) - 1] = (max - ori % max) % max

        mixPerm(self.cp)
        mixPerm(self.ep)
        randOri(self.co, 3)
        randOri(self.eo, 2)
        return self

    # A class method returning a new random cube
    @classmethod
    def random(cls):
        return Cube().randomize()

    def isSolved(self):
        for c in range(8):
            if self.cp[c] != c:
                return False
            if self.co[c] != 0:
                return False

        for e in range(12):
            if self.ep[e] != e:
                return False
            if self.eo[e] != 0:
                return False

        return True

    # Multiply this Cube with another Cube, restricted to corners.
    def cornerMultiply(self,other):
        for to in range(8):
            fr = other['cp'][to]
            self.newCp[to] = self.cp[fr]
            self.newCo[to] = (self.co[fr] + other['co'][to]) % 3
        self.cp, self.newCp = self.newCp, self.cp
        self.co, self.newCo = self.newCo, self.co
        return self

    # Multiply this Cube with another Cube, restricted to edges
    def edgeMultiply(self,other):
        for to in range(12):
            fr = other['ep'][to]
            self.newEp[to] = self.ep[fr]
            self.newEo[to] = (self.eo[fr] + other['eo'][to]) % 2
        self.ep, self.newEp = self.newEp, self.ep
        self.eo, self.newEo = self.newEo, self.eo
        return self

    # Multiply this cube with another Cube
    def multiply(self,other):
        self.cornerMultiply(other)
        self.edgeMultiply(other)
        return self

    @classmethod
    def parseAlg(cls,arg):
        if type(arg) is str: # string
            # String
            res = []
            for part in arg.split(' '):  # /\s+/
                if len(part) == 0:
                    # First and last can be empty
                    continue

                if len(part) > 2:
                    raise 'Invalid move: ' + part

                move = faceNums[part[0]]
                if move == None: #undefined:
                    raise 'Invalid move: ' + part

                if len(part) == 1:
                    power = 0
                else:
                    if part[1] == '2':
                        power = 1
                    elif part[1] == "'":
                        power = 2
                    else:
                        raise 'Invalid move: ' + part

                res.append(move * 3 + power)
            return res

        elif type(arg) is list:
            # Already an array
            return arg

        else:
            # A single move
            return [arg]

    def move(self,arg):
        for m in self.parseAlg(arg):
            face = m / 3 | 0
            power = m % 3
            for x in range(power+1):
                self.multiply(Cube.moves[face])

        return self

    @classmethod
    def inverse(cls,arg):
        result = []
        for move in cls.parseAlg(arg):
            face = move / 3 | 0
            power = move % 3
            result.append(face * 3 + -(power - 1) + 1)

        result.reverse()

        if type(arg) is str:
            st = ''
            for move in result:
                face = move / 3 | 0
                power = move % 3
                st += faceNames[face]
                if power == 1:
                    st += '2'
                elif power == 2:
                    st += "'"
                st += ' '
            return st[:len(st) - 1] #.substring(0, len(st) - 1)

        elif type(arg) is list:
            return result

        else:
            return result[0]

Cube.moves = [
    # U
    {
        'cp': [UBR, URF, UFL, ULB, DFR, DLF, DBL, DRB],
        'co': [0, 0, 0, 0, 0, 0, 0, 0],
        'ep': [UB, UR, UF, UL, DR, DF, DL, DB, FR, FL, BL, BR],
        'eo': [0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0]
    },

    # R
    {
        'cp': [DFR, UFL, ULB, URF, DRB, DLF, DBL, UBR],
        'co': [2, 0, 0, 1, 1, 0, 0, 2],
        'ep': [FR, UF, UL, UB, BR, DF, DL, DB, DR, FL, BL, UR],
        'eo': [0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0]
    },

    # F
    {
        'cp': [UFL, DLF, ULB, UBR, URF, DFR, DBL, DRB],
        'co': [1, 2, 0, 0, 2, 1, 0, 0],
        'ep': [UR, FL, UL, UB, DR, FR, DL, DB, UF, DF, BL, BR],
        'eo': [0, 1, 0, 0, 0, 1, 0, 0, 1, 1, 0, 0]
    },

    # D
    {
        'cp': [URF, UFL, ULB, UBR, DLF, DBL, DRB, DFR],
        'co': [0, 0, 0, 0, 0, 0, 0, 0],
        'ep': [UR, UF, UL, UB, DF, DL, DB, DR, FR, FL, BL, BR],
        'eo': [0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0]
    },

    # L
    {
        'cp': [URF, ULB, DBL, UBR, DFR, UFL, DLF, DRB],
        'co': [0, 1, 2, 0, 0, 2, 1, 0],
        'ep': [UR, UF, BL, UB, DR, DF, FL, DB, FR, UL, DL, BR],
        'eo': [0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0]
    },

    # B
    {
        'cp': [URF, UFL, UBR, DRB, DFR, DLF, ULB, DBL],
        'co': [0, 0, 1, 2, 0, 0, 2, 1],
        'ep': [UR, UF, UL, BR, DR, DF, DL, BL, FR, FL, UB, DB],
        'eo': [0, 0, 0, 1, 0, 0, 0, 1, 0, 0, 1, 1]
    }
]


## Globals

#if module?
#  module.exports = Cube
#else
#  @Cube = Cube

cube = Cube.fromString('UUFUUFUUFRRRRRRRRRFFDFFDFFDDDBDDBDDBLLLLLLLLLUBBUBBUBB')
ass(str(cube), 'UUFUUFUUFRRRRRRRRRFFDFFDFFDDDBDDBDDBLLLLLLLLLUBBUBBUBB')

other = Cube(cube)
ass(str(other), 'UUFUUFUUFRRRRRRRRRFFDFFDFFDDDBDDBDDBLLLLLLLLLUBBUBBUBB')

third = Cube(cube.toJSON())
ass(str(third), 'UUFUUFUUFRRRRRRRRRFFDFFDFFDDDBDDBDDBLLLLLLLLLUBBUBBUBB')

cube = Cube.fromString('UUFUUFUUFRRRRRRRRRFFDFFDFFDDDBDDBDDBLLLLLLLLLUBBUBBUBB')
ass(str(cube), 'UUFUUFUUFRRRRRRRRRFFDFFDFFDDDBDDBDDBLLLLLLLLLUBBUBBUBB')

assert Cube.inverse("F") == "F'"
assert Cube.inverse("F B' R") == "R' B F'"
assert Cube.inverse([1, 8, 12]) == [14, 6, 1]
assert Cube.inverse(8) == 6
assert Cube.inverse(7) == 7

#cube = Cube.random()
#print str(cube)
#cube.randomize()
#print str(cube)

cube = Cube()
r = Cube.random()
r.init(cube)
assert str(r) == 'UUUUUUUUURRRRRRRRRFFFFFFFFFDDDDDDDDDLLLLLLLLLBBBBBBBBB'

r = Cube.random()
r.identity()
assert r.isSolved() == True

cube = Cube()
assert cube.isSolved() == True
ass(str(cube.move("F")), 'UUFUUFUUFRRRRRRRRRFFDFFDFFDDDBDDBDDBLLLLLLLLLUBBUBBUBB')
assert cube.isSolved() == False
ass(str(cube.move("F'")), 'UUUUUUUUURRRRRRRRRFFFFFFFFFDDDDDDDDDLLLLLLLLLBBBBBBBBB')
ass(str(cube.move("B")), 'BUUBUUBUURRRRRRRRRUFFUFFUFFFDDFDDFDDLLLLLLLLLBBDBBDBBD')
ass(str(cube.move("B'")), 'UUUUUUUUURRRRRRRRRFFFFFFFFFDDDDDDDDDLLLLLLLLLBBBBBBBBB')
ass(str(cube.move("L")), 'UUUUUULLLURRURRURRFFFFFFFFFRRRDDDDDDLLDLLDLLDBBBBBBBBB')
ass(str(cube.move("L'")), 'UUUUUUUUURRRRRRRRRFFFFFFFFFDDDDDDDDDLLLLLLLLLBBBBBBBBB')
