# http://users.rcn.com/python/download/puzzle.py

from __future__ import generators
import time

''' Generic Puzzle Solving Framework
    Designed for Python 2.2 or later
    License:  Public Domain
    Author:   Raymond Hettinger
    Updates:  http://users.rcn.com/python/download/python.htm
'''

#  Revision In Use:  'File %n, Ver %v, Date %f'
version = 'File PUZZLE.PY, Ver 9, Date 27-Mar-2002,3:17:34'

''' Simple Instructions:

Create your puzzle as a subclass of Puzzle().
The first step is to choose a representation of the problem
state preferably stored as a string.  Set 'pos' to the starting
position and 'goal' to the ending position.  Create a genmoves()
method that computes all possible new puzzle states reachable from
the current state.  Call the .solve() method to solve the puzzle.

Important Note:

The genmoves() method must return a list of puzzle instances, not
their representations.  It should be written as a generator, returning
its results through yield.

Advanced Instructions:

1. .solve(depthFirst=1) will override the default breadth first search.
Use depth first when the puzzle known to be solved in a fixed number
of moves (for example, the eight queens problem is solved only when
the eighth queen is placed on the board; also, the triangle tee problem
removes one tee on each move until all tees are removed).  Breadth first
is ideal when the shortest path solution needs to be found or when
some paths have a potential to wander around infinitely (i.e. you can
randomly twist a Rubik's cube all day and never come near a solution).

2. Define __repr__ for a pretty printed version of the current position.
The state for the Tee puzzle looks best when the full triangle is drawn.

3. If the goal state can't be defined as a string, override the isgoal()
method.  For instance, the block puzzle is solved whenever block 1 is
in the lower left, it doesn't matter where the other pieces are; hence,
isgoal() is defined to check the lower left corner and return a boolean.

4. Some puzzle's can be simplified by treating symmetric positions as
equal.  Override the .canonical() method to pick one of the equilavent
positions as a representative.  This allows the solver to recognize paths
similar ones aleady explored.  In tic-tac-toe an upper left corner on
the first move is symmetrically equivalent to a move on the upper right;
hence there are only three possible first moves (a corner, a midde side,
or in the center).
'''

class Puzzle:
    pos = ""                    # default starting position
    goal = ""                   # ending position used by isgoal()
    def __init__( self, pos=None ):
        if pos: self.pos = pos
    def __repr__(self):         # returns a string representation of the position for printing the object
        return repr(self.pos)
    def canonical(self):        # returns a string representation after adjusting for symmetry
        return repr(self)
    def isgoal(self):
        return self.pos == self.goal
    def __iter__(self):         # returns list of objects of this class
        if 0: yield self
    def solve( pos, depthFirst=0 ):
        queue, trail, solution = [pos], {intern(pos.canonical()):None}, []
        load = depthFirst and queue.append or (lambda m: queue.insert(0,m))
        while not pos.isgoal():
            for m in pos:
                c = m.canonical()
                if c in trail: continue
                trail[intern(c)] = pos
                load(m)
            pos = queue.pop()
        while pos:
            solution.insert(0, pos)
            pos = trail[pos.canonical()]
        return solution

# Sample Puzzles start here
if __name__ == '__main__':

    class JugFill(Puzzle):
        """Given a two empty jugs with 3 and 5 liter capacities and a full
           jug with 8 liters, find a sequence of pours leaving four liters
           in the two largest jugs"""

        #pos = (0, 0, 8)
        #capacity = (3, 5, 8)
        #goal = (0, 4, 4)

        # assert len(Water(9999, 8887).find_best(9443)) == 18885  # 50 ms
        a = 9999
        b = 8887
        c = 8886
        total = a+b
        pos = (0, 0, total)
        capacity = (a, b, total)
        goal = (0, c, total-c)

        def __iter__(self):
            for i in range(len(self.pos)):
                for j in range(len(self.pos)):
                    if i == j:
                        continue
                    qty = min(self.pos[i], self.capacity[j] - self.pos[j])
                    if not qty:
                        continue
                    dup = list(self.pos)
                    dup[i] -= qty
                    dup[j] += qty
                    yield JugFill(tuple(dup))

    class EightQueens( Puzzle ):
        ' Place 8 queens on chess board such that no two queens attack each other'
        def isgoal(self):
            return len(self.pos) == 8
        def __iter__( self ):
            x = len(str(self))
            for y in range(8):
                if str(y) in self.pos: continue
                for xp in range(len(self.pos)):
                    yp = int(self.pos[xp])
                    if abs(x-xp) == abs(y-yp):
                        break
                else:
                    yield EightQueens(self.pos + str(y))

    class TriPuzzle( Puzzle ):
        ''' Triangle Tee Puzzle
        Tees are arranged in holes on a 5x5 equalateral triangle except for the
        top center which left open.  A move consist of a checker style jump of
        one tee over the next into an open hole and removed the jumped tee. Find
        a sequence of jumps leaving the last tee in the top center position.
        '''
        pos = '011111111111111'
        goal = '100000000000000'
        triples = [[0,1,3], [1,3,6], [3,6,10], [2,4,7], [4,7,11], [5,8,12],
                   [10,11,12], [11,12,13], [12,13,14], [6,7,8], [7,8,9], [3,4,5],
                   [0,2,5], [2,5,9], [5,9,14], [1,4,8], [4,8,13], [3,7,12]]
        def __iter__( self ):
            for t in self.triples:
                if self.pos[t[0]]=='1' and self.pos[t[1]]=='1' and self.pos[t[2]]=='0':
                    yield TriPuzzle(self.produce(t,'001'))
                if self.pos[t[0]]=='0' and self.pos[t[1]]=='1' and self.pos[t[2]]=='1':
                    yield TriPuzzle(self.produce(t,'100'))
        def produce( self, t, sub ):
            return self.pos[:t[0]] + sub[0] + self.pos[t[0]+1:t[1]] + sub[1] + self.pos[t[1]+1:t[2]] + sub[2] + self.pos[t[2]+1:]
        def canonical( self ):
            return self.pos
        def __repr__( self ):
            return '\n        %s\n      %s   %s\n    %s   %s   %s\n  %s   %s   %s   %s\n%s   %s   %s   %s   %s\n' % tuple(self.pos)

    class MarblePuzzle( Puzzle ):
        ''' Black/White Marble
        Given eleven slots in a line with four white marbles in the leftmost
        slots and four black marbles in the rightmost, make moves to put the
        white ones on the right and the black on the left.  A valid move for
        a while marble isto shift right into an empty space or hop over a single
        adjacent black marble into an adjacent empty space -- don't hop over
        your own color, don't hop into an occupied space, don't hop over more
        than one marble.  The valid black moves are in the opposite direction.
        Alternate moves between black and white marbles.

        In the tuple representation below, zeros are open holes, ones are whites,
        negative ones are blacks, and the outer tuple tracks whether it is
        whites move or blacks.
        '''
        pos = (1,(1,1,1,1,0,0,0,-1,-1,-1,-1))
        goal =  (-1,-1,-1,-1,0,0,0,1,1,1,1)
        def isgoal( self ):
            return self.pos[1] == self.goal
        def __iter__( self ):
            (m,b) = self.pos
            for i in range(len(b)):
                if b[i] != m: continue
                if 0<=i+m+m<len(b) and b[i+m] == 0:
                    newmove = list(b)
                    newmove[i] = 0
                    newmove[i+m] = m
                    yield MarblePuzzle((-m,tuple(newmove)))
                    continue
                if 0<=i+m+m<len(b) and b[i+m]==-m and b[i+m+m]==0:
                    newmove = list(b)
                    newmove[i] = 0
                    newmove[i+m+m] = m
                    yield MarblePuzzle((-m,tuple(newmove)))
                    continue
        def __repr__( self ):
            s = ''
            for p in self.pos[1]:
                if p==1: s='b'+s
                elif p==0: s='.'+s
                else: s='w'+s
            return s

    class RowboatPuzzle( Puzzle ):
        ''' Rowboat problem:  Man, Dog, Cat, Squirrel
        Cross the river two at a time, don't leave the dog alone with the
        cat or the cat alone with the squirrel.

        The bitmap representation shows who is on the opposite side.
        Bit 1 is the squirrel, bit 2 is the cat, bit 3 is the dog, bit 4 is the man.
        Genmoves takes the current position and flips any two bits which is the
        same as moving those two creatures to the opposite shore.  It then
        filters out any moves which leave the dog and cat together or the
        cat and squirrel.
        '''
        pos = 0
        goal = 15
        def __iter__( self ):
            for m in [8,12,10,9]:
                n = self.pos ^ m
                if ((n>>1)&1 == (n>>3)&1) or ( (n>>2)&1 != (n>>1)&1 != (n&1) ):
                    yield RowboatPuzzle(n)
        def __repr__( self ):
            v = ','
            if self.pos&8: v=v+'M'
            else: v='M'+v
            if self.pos&4: v=v+'D'
            else: v='D'+v
            if self.pos&2: v=v+'C'
            else: v='C'+v
            if self.pos&1: v=v+'S'
            else: v='S'+v
            return v

    import re
    import string
    class PaPuzzle( Puzzle ):
        ''' PaPuzzle
        This sliding block puzzle has 9 blocks of varying sizes:
        one 2x2, four 1x2, two 2x1, and two 1x1.  The blocks are
        on a 5x4 grid with two empty 1x1 spaces.  Starting from
        the position shown, slide the blocks around until the
        2x2 is in the lower left:

            1122
            1133
            45
            6788
            6799
        '''
        pos = '11221133450067886799'
        goal = re.compile( r'................1...' )
        def isgoal(self):
            return self.goal.search(self.pos) != None
        def __repr__( self ):
            ans = '\n'
            pos = self.pos.replace( '0', '.' )
            for i in [0,4,8,12,16]:
                ans = ans + pos[i:i+4] + '\n'
            return ans
        xlat = string.maketrans('38975','22264')
        def canonical( self ):
            return self.pos.translate( self.xlat )
        block = { (0,-4):None, (1,-4):None, (2,-4):None, (3,-4):None,
                  (16,4):None, (17,4):None, (18,4):None, (19,4):None,
                  (0,-1):None, (4,-1):None, (8,-1):None, (12,-1):None, (16,-1):None,
                  (3,1):None, (7,1):None, (11,1):None, (15,1):None, (19,1):None, }
        def __iter__( self ):
            dsone = self.pos.find('0')
            dstwo = self.pos.find('0',dsone+1)
            for dest in [dsone, dstwo]:
                for adj in [-4,-1,1,4]:
                    if (dest,adj) in self.block: continue
                    piece = self.pos[dest+adj]
                    if piece == '0': continue
                    newmove = self.pos.replace(piece, '0')
                    for i in range(20):
                        if 0 <= i+adj < 20 and self.pos[i+adj]==piece:
                            newmove = newmove[:i] + piece + newmove[i+1:]
                    if newmove.count('0') != 2: continue
                    yield PaPuzzle(newmove)

    start = time.clock()
    #print Puzzle().solve()
    print len(JugFill().solve())
    #print EightQueens().solve( depthFirst=1 )
    #print TriPuzzle().solve()
    #print MarblePuzzle().solve(depthFirst=1)
    #print RowboatPuzzle().solve()
    #print PaPuzzle().solve()
    print time.clock()-start

