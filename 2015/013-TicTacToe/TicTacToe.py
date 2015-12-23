import tttMonteCarlo
import human
import random

Z = 5

# Not only 3x3. Also plays 7x7 and 5 in a row. Maximum 9x9
# Text only. 200 lines of code.
# Uses Monte Carlo as AI

class TicTacToe():
    def __init__(self, n=3, moves=''):
        self.n = n
        self.moves = []
        self.board = []
        for j in range(n):
            row = []
            for i in range(n):
                row.append(' ')
            self.board.append(row)

        if moves == '':
            return
        for move in moves.split(' '):
            x = 'ABCDEFGHI'.index(move[0])
            y = int(move[1]) - 1
            self.moves.append((x,y))
            self.board[y][x] = self.last_marker()

    def rand(self):
        n = random.randrange(self.n*self.n - len(self.moves))
        count = 0
        for x in range(self.n):
            for y in range(self.n):
                if self.board[y][x] == ' ':
                    if count == n:
                        return x,y
                    count += 1
        return x,y

    def copy(self):
        b = TicTacToe(self.n)
        b.board = []
        for y in range(self.n):
            row = []
            for x in range(self.n):
                row.append(self.board[y][x])
            b.board.append(row)
        b.moves = [x for x in self.moves]
        return b

    def move(self, key):
        x,y = key
        self.board[y][x] = self.next_marker()
        self.moves.append(key)

    def undo(self):
        x, y = self.moves.pop()
        self.board[y][x] = ' '

    def last_marker(self):
        return 'XO'[len(self.moves) % 2]

    def next_marker(self):
        return 'OX'[len(self.moves) % 2]

    def show(self):
        res = '  ' + 'A B C D E F G H I'[:self.n*2-1] + '\n'
        for j in range(self.n):
            res += str(j+1) + ' '
            row = self.board[j]
            for i in range(self.n):
                if row[i] == ' ':
                    res += '.'
                else:
                    res += str(row[i])
                res += ' '
            res += '\n'
        return res

    def calc_rows(self):
        if len(self.moves) == 0:
            return False
        marker = self.last_marker()
        x,y = self.moves[-1]
        count = 1
        i = x+1
        while i < self.n and self.board[y][i] == marker:
            count += 1
            i += 1
        i = x-1
        while i >= 0 and self.board[y][i] == marker:
            count += 1
            i -= 1
        return count >= Z
    def calc_columns(self):
        marker = self.last_marker()
        x,y = self.moves[-1]
        count = 1
        j = y+1
        while j < self.n and self.board[j][x] == marker:
            count += 1
            j += 1
        j = y-1
        while j >= 0 and self.board[j][x] == marker:
            count += 1
            j -= 1
        return count >= Z
    def calc_diagonal(self, dj):
        def helper(di, dj):
            i = x+di
            j = y+dj
            res = 0
            while 0 <= j < self.n and 0 <= i < self.n and self.board[j][i] == marker:
                res += 1
                i += di
                j += dj
            return res
        marker = self.last_marker()
        x,y = self.moves[-1]
        count = 1
        count += helper(1, dj)
        count += helper(-1, -dj)
        return count >= Z
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

#assert TicTacToe(7).calc_rows() == False
#assert TicTacToe(7, 'C3 D4').calc_rows() == False
#assert TicTacToe(7, 'A1 A2 B1 B2 C1 C2 D1').calc_rows() == True
#assert TicTacToe(7, 'A1 A2 B1 B2 C1 C2 D1 D2').calc_rows() == True
#assert TicTacToe(7, 'A1 B1 A2 B2 A3 B3 A4').calc_columns() == True
#assert TicTacToe(7, 'A1 E1 B2 E2 C3 E3').calc_diagonal(1) == False
#assert TicTacToe(7, 'A1 E1 B2 E2 C3 E3 D4').calc_diagonal(1) == True
#assert TicTacToe(7, 'A1 E1 B2 E2 C3 E3 D4').calc_diagonal(-1) == False
#assert TicTacToe(7, 'A4 E1 B3 E2 C2 E3 D1').calc_diagonal(-1) == True
#assert TicTacToe(7, 'A4 E1 B3 E2 C2 E3 D1').calc() == True
#assert TicTacToe(7, 'B5 A1 A2 C4 D3').calc() == False

#b = TicTacToe(3, 'B2 A1 A2 B1')
#b = TicTacToe(3, 'A2 A1 A3 B1')  # C1 expected
b = TicTacToe(3, 'B2 A1 B3 B1')  # C1 expected
p = tttMonteCarlo.Player()

#key = p.move(b)
#print key
#b.move(key)
#print b.calc()
#print b.show()

p1 = tttMonteCarlo.Player()
p2 = human.Human('Christer')
b = TicTacToe(8)

for i in range(b.n*b.n):
    p = [p1,p2][i % 2]
    key = p.move(b)
    if key == None:
        print "draw"
        break
    b.move(key)
    print b.show()
    if b.calc():
        print "vinst for " + b.last_marker()
        break
