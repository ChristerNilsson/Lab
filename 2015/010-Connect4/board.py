# -*- coding: utf-8 -*-
import random

M = 6  # antal rader
N = 7  # antal kolumner

DOT = '.'

def ass(a, b):
    if a != b:
        print "Assert failed"
        print a
        print b
        assert a == b


class Board(object):

    def __init__(self, moves=''):
        self.clear()
        for digit in moves:
            self.move(int(digit))

    def copy(self):
        b = Board()
        b.board = [x for x in self.board]
        b.moves = self.moves[:]
        return b

    def rand(self):
        m = random.randrange(N)
        while len(self.board[m]) >= M:
            m = random.randrange(N)
        if len(self.board[m]) >= M:
            print self.board
        return m

    def clear(self):
        self.moves = []
        self.board = ['', '', '', '', '', '', '']

    def move(self, m):
        self.board[m] += self.next_marker()
        self.moves.append(m)

    def undo(self):
        m = self.moves.pop()
        self.board[m] = self.board[m][:-1]

    def last_marker(self):
        return 'OX'[len(self.moves) % 2]

    def next_marker(self):
        return 'XO'[len(self.moves) % 2]

    def display_simple(self):
        return '\n:' + '\n:'.join(self.board) + '\n 012345\n'

    def display(self):
        res = '\n'
        for j in range(5, -1, -1):
            res += str(j)
            for i in range(N):
                if j < len(self.board[i]):
                    res += ' ' + self.board[i][j]
                else:
                    res += ' ' + DOT
            res += "\n"
        res += '  0 1 2 3 4 5 6\n'
        return res

    def calc_columns(self):
        marker = self.last_marker()
        m = self.moves[-1]
        count = 0
        row = self.board[m]
        i = len(row)-1
        while row[i] == marker and i >= 0:
            count += 1
            i -= 1
        return count == 4

    def calc_rows(self):
        marker = self.last_marker()
        m = self.moves[-1]
        count = 1
        n = len(self.board[m]) - 1
        i = m+1
        while i < 7 and n < len(self.board[i]) and self.board[i][n] == marker:
            count += 1
            i += 1
        i = m-1
        while i >= 0 and n < len(self.board[i]) and self.board[i][n] == marker:
            count += 1
            i -= 1
        return count >= 4

    def calc_diagonal(self, dj):
        def helper(di, dj):
            i = m+di
            j = n+dj
            res = 0
            while 0 <= j < M and 0 <= i < N and j < len(self.board[i]) and self.board[i][j] == marker:
                res += 1
                i += di
                j += dj
            return res
        marker = self.last_marker()
        m = self.moves[-1]
        count = 1
        n = len(self.board[m]) - 1
        count += helper(1, dj)
        count += helper(-1, -dj)
        return count >= 4

    def calc(self):
        if self.calc_columns():
            return True
        if self.calc_rows():
            return True
        if self.calc_diagonal(1):
            return True
        if self.calc_diagonal(-1):
            return True
        return False

##### moves #####
b = Board()
assert b.moves == []
b.move(2)
assert b.moves == [2]
b.move(3)
assert b.moves == [2, 3]
b.undo()
assert b.moves == [2]
b.undo()
assert b.moves == []

##### last_marker(), next_marker() #####
b = Board()
assert b.next_marker() == 'X'  # X börjar alltid
b.move(2)
assert b.last_marker() == 'X'
assert b.next_marker() == 'O'
b.move(3)
assert b.last_marker() == 'O'
assert b.next_marker() == 'X'
b.undo()
assert b.last_marker() == 'X'
assert b.next_marker() == 'O'
b.undo()
assert b.last_marker() == 'O'
assert b.next_marker() == 'X'

##### board #####
b = Board()
assert b.board == ['', '', '', '', '', '', '']
b.move(2)
assert b.board == ['', '', 'X', '', '', '', '']
b.move(3)
assert b.board == ['', '', 'X', 'O', '', '', '']
b.undo()
assert b.board == ['', '', 'X', '', '', '', '']
b.undo()
assert b.board == ['', '', '', '', '', '', '']

##### display_simple() #####
b = Board()
assert b.display_simple().replace('\n', 'z') == 'z:z:z:z:z:z:z:z 012345z'
ass(b.display_simple(), '''
:
:
:
:
:
:
:
 012345
''')
b.move(2)
ass(b.display_simple(), '''
:
:
:X
:
:
:
:
 012345
''')
b.move(3)
ass(b.display_simple(), '''
:
:
:X
:O
:
:
:
 012345
''')
b.undo()
ass(b.display_simple(), '''
:
:
:X
:
:
:
:
 012345
''')
b.undo()
ass(b.display_simple(), '''
:
:
:
:
:
:
:
 012345
''')

##### display() #####
b = Board()
assert b.display().replace('\n', 'z') == 'z5 . . . . . . .z4 . . . . . . .z3 . . . . . . .z2 . . . . . . .z1 . . . . . . .z0 . . . . . . .z  0 1 2 3 4 5 6z'
assert b.display() == '''
5 . . . . . . .
4 . . . . . . .
3 . . . . . . .
2 . . . . . . .
1 . . . . . . .
0 . . . . . . .
  0 1 2 3 4 5 6
'''
b.move(2)
assert b.display() == '''
5 . . . . . . .
4 . . . . . . .
3 . . . . . . .
2 . . . . . . .
1 . . . . . . .
0 . . X . . . .
  0 1 2 3 4 5 6
'''
b.move(3)
assert b.display() == '''
5 . . . . . . .
4 . . . . . . .
3 . . . . . . .
2 . . . . . . .
1 . . . . . . .
0 . . X O . . .
  0 1 2 3 4 5 6
'''
b.undo()
assert b.display() == '''
5 . . . . . . .
4 . . . . . . .
3 . . . . . . .
2 . . . . . . .
1 . . . . . . .
0 . . X . . . .
  0 1 2 3 4 5 6
'''
b.undo()
assert b.display() == '''
5 . . . . . . .
4 . . . . . . .
3 . . . . . . .
2 . . . . . . .
1 . . . . . . .
0 . . . . . . .
  0 1 2 3 4 5 6
'''

##### Board('23') #####
b = Board('23')
assert b.moves == [2, 3]
assert b.board == ['', '', 'X', 'O', '', '', '']
ass(b.display_simple(), '''
:
:
:X
:O
:
:
:
 012345
''')
assert b.display() == '''
5 . . . . . . .
4 . . . . . . .
3 . . . . . . .
2 . . . . . . .
1 . . . . . . .
0 . . X O . . .
  0 1 2 3 4 5 6
'''

##### calc_columns() #####
assert Board('06060').calc_columns() is False
assert Board('0606060').calc_columns() is True

##### calc_rows() #####
assert Board('06152').calc_rows() is False
assert Board('0615243').calc_rows() is True

##### calc_diagonal(1) ##### /
assert Board('1122333352').calc_diagonal(1) is False
assert Board('112233335260').calc_diagonal(1) is True

##### calc_diagonal(-1) ##### \
assert Board('112233335260').calc_diagonal(-1) is False
assert Board('000000111161446222633352').calc_diagonal(-1) is True

##### calc() #####
assert Board('06060').calc() is False
assert Board('0606060').calc() is True
assert Board('0506060').calc() is True
assert Board('06060').calc() is False
assert Board('0616263').calc() is True
assert Board('0011224455663').calc() is True
assert Board('2030465').calc() is True
assert Board('20314').calc() is False
assert Board('65435234410111122120303').calc() is True
assert Board('65435234410111122120030').calc() is False
assert Board('203243665').calc() is True
