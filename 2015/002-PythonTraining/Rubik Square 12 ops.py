# -*- coding: utf-8 -*-

# Spelet går ut på att man ska ta sig från en matris till en annan matris med hjälp av tolv operationer
# Minst antal operationer är målsättningen
# Operationerna är:
#   ld md rd
# ur        ul
# mr        ml
# dr        dl
#   lu mu ru

# Dessa blir lättare att implementera på iPad.
# Dessutom liknar de Rubiks kub mera

#   z = undo
#   q = surrender

# n n-färger maxdrag       nxn-siffror  maxdrag
# 2 6        2             4!=24        4
# 3 1680     6     2 ark   9!/2=181440  8       196 ark
# 4 60M      26    41 kart 16!/2=10^13  ?       94K pallar (en pall = 48 kartonger)

import random
from string import maketrans   # Required to call maketrans function.

N = 3
LAST = N*N-1

OPERATIONS = 'ld md rd lu mu ru ur mr dr ul ml dl'
#NORMAL = '000 111 222'
NORMAL = '012 345 678'

history = []

def stringify(m):
    return [''.join(row) for row in m]

def transpose(b):
    return stringify(map(list, zip(*b)))

def flatten(b):
    return [item for sublist in b for item in sublist]

def unflatten(b):
    return [b[0:3],b[3:6],b[6:9]]

def rotate_cell(b):
    return [b[LAST]] + b[0:LAST]

def unrotate_cell(b):
    return b[1:N*N] + [b[0]]

def rotate_board(b):
    return [row[::-1] for row in transpose(b)]

def unrotate_board(b):
    return rotate_board(rotate_board(rotate_board(b)))

def rt(row):
    return row

def lt(row):
    return row

def move(board,row,col,dir):
    b = [[c for c in board[0]], [c for c in board[1]], [c for c in board[2]]]
    if col==None:
        b[row][0],b[row][1],b[row][2] = b[row][(0+dir)%3],b[row][1+dir],b[row][(2+dir)%3]
    elif row==None:
        b[0][col],b[1][col],b[2][col] = b[(0+dir)%3][col],b[1+dir][col],b[(2+dir)%3][col]
    res = [''.join(b[0]), ''.join(b[1]), ''.join(b[2])]
    return res

# ops = 'ld ur' t ex
def turn(board, ops, save=False):
    board = board.split(' ')
    a,b,c = board
    hash = {}

#   ld md rd
# ur        ul
# mr        ml
# dr        dl
#   lu mu ru

    hash['ur'] = lambda s: move(s,0,None,-1)
    hash['mr'] = lambda s: move(s,1,None,-1)
    hash['dr'] = lambda s: move(s,2,None,-1)

    hash['ul'] = lambda s: move(s,0,None,1)
    hash['ml'] = lambda s: move(s,1,None,1)
    hash['dl'] = lambda s: move(s,2,None,1)

    hash['ld'] = lambda s: move(s,None,0,-1)
    hash['md'] = lambda s: move(s,None,1,-1)
    hash['rd'] = lambda s: move(s,None,2,-1)

    hash['lu'] = lambda s: move(s,None,0,1)
    hash['mu'] = lambda s: move(s,None,1,1)
    hash['ru'] = lambda s: move(s,None,2,1)

    for op in ops.split(' '):
        if save:
            history.append(' '.join(board))
        board = hash[op](board)
    return ' '.join(board)

def expand(board, n):
    q = [board]
    solutions = {board : 0}
    q2 = []
    res = []
    for i in range(n):
        for b in q:
            for op in OPERATIONS.split():
                b2 = turn(b,op)
                if b2 not in solutions:
                    solutions[b2] = i+1
                    q2.append(b2)
                    if i == (n-1):
                        res.append(b2)
        q = q2
        q2 = []
    return res

def solve(s):
    solutions = {s: ('', '')}
    queue = [(s, '')]
    while True:
        s,ops = queue.pop(0)
        if s == NORMAL:
            return ops
        for op in OPERATIONS:
            t = turn(s, op)
            if t not in solutions:
                solutions[t] = (s, ops + op)
                queue.append((t, ops+op))

def show(board):
    for i in range(N):
        s = '  '
        for j in range(N):
            s += board[(N+1)*i+j]+' '
        print(s)

def show_all(board):
    header = ''
    canvas = []
    for op in OPERATIONS.split(' '):
        header += op + N*'  '
        canvas.append(turn(board, op).split())

    print header
    for i in range(N):
        s = ''
        for row in canvas:
            for j in range(N):
                s += row[i][j]+' '
            s += '  '
        print s
    print

def play_one_game(level):
    board = NORMAL
    boards = expand(board, level)
    i = random.randrange(len(boards))
    board = boards[i]
    del history[:]
    while True:
        print "Current board:"
        show(board)
        print
        print "Commands: " + OPERATIONS + " z=undo s=surrender"
        show_all(board)
        ops = raw_input('(' + str(len(history)) + ' of ' + str(level) + ') Command: ')
        if ops == 'z':
            if len(history) > 0:
                board = history.pop()
        elif ops == 's':
            return False
        else:
            print
            board = turn(board, ops, True)
            if board == NORMAL:
                if len(history) <= level:
                    print "Success! Level=" + str(level+1)
                    return True
                else:
                    print "Failure! Level=" + str(level-1)
                    return False

def run():
    level = 1
    while True:
        if play_one_game(level):
            level += 1
        elif level > 1:
            level -= 1

def patch(s):
    trantab = maketrans('udlr','durl')
    return s[0] + s[1].translate(trantab)

def print_solution(board):
    q = [board]
    #solutions = {board : 0}
    solutions = {board : '  '}
    q2 = []
    res = []
    i = 0
    while q:
        i += 1
        for b in q:
            for op in OPERATIONS.split():
                b2 = turn(b,op)
                if b2 not in solutions:
                    #solutions[b2] = i
                    solutions[b2] = op
                    q2.append(b2)
        q = q2
        q2 = []
    keys = sorted(solutions.keys())
    s = ''
    i = 0
    print "Rubik's Square: Solutions for n=3     Operations: " + OPERATIONS
    print

    with open("output.txt", "w") as text_file:
        for key in keys:
            #s += key + ' ' + '0123456789abcdefghijklmnopqrstuvwxyz'[solutions[key]] + '  '
            s += key + ' ' + patch(solutions[key]) + ' '
            i += 1
            if i == 6:
                text_file.write(s + "\n")
                i = 0
                s = ''

print "Try to unscramble the matrix, in level moves, into:"
print ""
print "  ld md rd"
print "ur 0  0  0 ul"
print "mr 1  1  1 ml"
print "dr 2  2  2 dl"
print "  lu mu ru"

#run()

print_solution(NORMAL)