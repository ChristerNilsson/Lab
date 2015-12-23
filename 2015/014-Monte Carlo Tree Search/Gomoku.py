# http://mcts.ai/code/python.html

from math import *
import random

# todo Kan vara intressant att wrappa i GetResult()

VERBOSE = 0

#N, SIZE = 3, 3  # N*N board
N, SIZE = 8, 5
#N, SIZE = 7, 4  # uruselt
#N, SIZE = 10, 6

# Vinst = 1
# Remi = 0
# Förlust -1

class OXOState:
    def __init__(self, moves=""):
        self.board = [0] * N * N  # 0 = empty, 1 = player 1, 2 = player 2
        self.moves = []
        self.candidates = range(N*N)
        if moves != '':
            for move in moves.split(' '):
                self.DoMove(int(move))

    def playerJustMoved(self):
        return 1 + (1+len(self.moves)) % 2

    def Clone(self):
        st = OXOState()
        st.board = self.board[:]
        st.moves = self.moves[:]
        st.candidates = self.candidates[:]
        return st

    def DoMove(self,move):
        #assert 0 <= move < N*N and move == int(move) and self.board[move] == 0
        self.candidates.remove(move)
        self.moves.append(move)
        self.board[move] = self.playerJustMoved()

    def GetResult(self, playerjm):
        b = OXOState()
        for move in self.moves:
            b.DoMove(move)
            if len(self.moves) >= 2*SIZE-1:
                sq = move
                x = sq % N
                y = sq / N
                for dx, dy in [(0,1), (1,0), (1,1), (1,-1)]:

                    count = 0
                    x1,y1 = x,y
                    while 0 <= x1 < N and 0 <= y1 < N and b.board[x1 + N*y1] == b.playerJustMoved():
                        x1 += dx
                        y1 += dy
                        count += 1

                    x1,y1 = x,y
                    while 0 <= x1 < N and 0 <= y1 < N and b.board[x1 + N*y1] == b.playerJustMoved():
                        x1 -= dx
                        y1 -= dy
                        count += 1

                    if count > SIZE:
                        if b.playerJustMoved() == playerjm:
                            return 1.0
                        else:
                            return -1.0

        if b.candidates == []:
            return 0.0  # draw
        return -2  # game not finished

    def __repr__(self):
        s = ""
        for i in range(N*N):
            ch = ".XO"[self.board[i]] + ' '
            if self.moves != [] and self.moves[-1] == i:
                ch = ch.lower()
            s += ch
            if i % N == N-1:
                s += "\n"
        return s


class Node:
    def __init__(self,move=None,parent=None,state=None):
        self.move = move  # the move that got us to this node - "None" for the root node
        self.parentNode = parent  # "None" for the root node
        self.childNodes = []
        self.wins = 0
        self.visits = 0
        self.untriedMoves = state.candidates[:] #  future child nodes
        self.playerJustMoved = state.playerJustMoved()  # the only part of the state that the Node needs later

    def UCTSelectChild(self):
        arr = sorted(self.childNodes, key=lambda c: c.wins / c.visits + sqrt(2 * log(self.visits) / c.visits))
        return arr[-1]

    def AddChild(self, m, s):
        n = Node(move=m, parent=self, state=s)
        self.untriedMoves.remove(m)
        self.childNodes.append(n)
        return n

    def Update(self, result):
        self.visits += 1
        self.wins += result

    def __repr__(self):
        return "[M:" + str(self.move) + " W/V:" + str(self.wins) + "/" + str(self.visits) + " U:" + str(self.untriedMoves) + "]"

    def TreeToString(self, indent):
        s = self.IndentString(indent) + str(self)
        for c in self.childNodes:
            s += c.TreeToString(indent + 1)
        return s

    def IndentString(self, indent):
        s = "\n"
        for i in range(1, indent + 1):
            s += "| "
        return s

    def ChildrenToString(self):
        s = ""
        for c in self.childNodes:
            s += str(c) + "\n"
        return s


def UCT(rootstate, itermax, verbose=False):
    rootnode = Node(state=rootstate)

    for i in range(itermax):
        node = rootnode
        state = rootstate.Clone()

        # Select
        while node.untriedMoves == [] and node.childNodes != []:  # node is fully expanded and non-terminal
            node = node.UCTSelectChild()
            state.DoMove(node.move)

        # Expand
        if node.untriedMoves != []:  # if we can expand (i.e. state/node is non-terminal)
            m = random.choice(node.untriedMoves)
            state.DoMove(m)
            node = node.AddChild(m,state) # add child and descend tree

        # Rollout - this can often be made orders of magnitude quicker using a state.GetRandomMove() function
        while state.candidates != []:
            state.DoMove(random.choice(state.candidates))

        # Backpropagate
        arr = [0,0,0]
        arr[node.playerJustMoved] = state.GetResult(node.playerJustMoved)
        arr[3-node.playerJustMoved] = -arr[node.playerJustMoved]
        while node != None:  # backpropagate from the expanded node and work back to the root node
            node.Update(arr[node.playerJustMoved])
            node = node.parentNode

    # Output some information about the tree - can be omitted
    if verbose == 1:
        print rootnode.ChildrenToString()
    if verbose == 2:
        print rootnode.TreeToString(0)

    return sorted(rootnode.childNodes, key=lambda c: c.visits)[-1].move  # return the move that was most visited

def UCTPlayGame(state=OXOState()):
    while state.GetResult(state.playerJustMoved()) == -2:
        m = UCT(rootstate=state, itermax=10000, verbose=0)  # play with values for itermax and verbose = True
        print "Best Move: " + str(m) + "\n"
        state.DoMove(m)
        print str(state)
    if state.GetResult(state.playerJustMoved()) == 1.0:
        print "Player " + str(state.playerJustMoved()) + " wins!"
    elif state.GetResult(state.playerJustMoved()) == -1.0:
        print "Player " + str(3 - state.playerJustMoved()) + " wins!"
    else:
        print "Nobody wins!"

def test3():  # 3x3
    assert OXOState('0 1 2 3 4 5 6').GetResult(1) == 1
    assert OXOState('0 1 2 3 4 5 7').GetResult(1) == -1
    assert OXOState('0 1 2 3 4 5 8').GetResult(1) == 1
    assert OXOState('0 2 1 3 5 4 6 7 8').GetResult(1) == 0.5
    assert OXOState('0 3 1 4 2').GetResult(1) == 1
    assert OXOState('3 6 4 7 5').GetResult(1) == 1
    assert OXOState('1 2 4 3 7').GetResult(1) == 1

def test8():  # 8x8
    assert OXOState('0 1 2 3 4 5 6').GetResult(1) == -1  # game not finished
    assert OXOState('0 8 1 9 2 10 3 11 4').GetResult(1) == 1
    assert OXOState('0 8 1 9 2 10 3 11 4').GetResult(2) == 0
    assert OXOState('0 1 8 2 16 3 24 4 32').GetResult(1) == 1
    assert OXOState('0 1 9 2 18 3 27 4 36').GetResult(1) == 1
    assert OXOState('7 0 6 1 5 2 4 8 3').GetResult(1) == 1
    assert OXOState('0 8 9 1 10 2 11 3 12 4 13 5').GetResult(1) == 1
    assert OXOState('0 8 9 1 10 2 11 3 12 4 13').GetResult(1) == 1

if __name__ == "__main__":
    #test8()
    #UCTPlayGame(OXOState('2 10 3 11 4 12'))
    UCTPlayGame()