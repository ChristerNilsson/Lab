# -*- coding: utf-8 -*-

# Spelet går ut på att man ska ta sig från en matris till en annan matris med hjälp av åtta operationer
# Minst antal operationer är målsättningen
# Operationerna är:
#   u = rotate rows up
#   d = rotate rows down
#   r = reverse rows
#   t = transpose
#   > = right shift
#   < = left shift
#   c = clockwise
#   a = anti-clockwise

#   z = undo
#   q = surrender

import random

N = 3   #  2 ark  (1680 rader)
#N = 4  # 40 kartonger (63M rader)
LAST = N*N-1

#OPERATIONS = 'udrt'
#OPERATIONS = 'udrtca'
#OPERATIONS = 'udrt<>'
#OPERATIONS = 'udrt<>ca'
#OPERATIONS = 't<>' # 1680
OPERATIONS = 't<>'

if N == 3:
    NORMAL = '000 111 222'
else:
    NORMAL = '0000 1111 2222 3333'

history = []

def stringify(m):
    return [''.join(row) for row in m]

def transpose(b):
    return stringify(map(list, zip(*b)))

def flatten(b):
    return [item for sublist in b for item in sublist]

def unflatten(b):
    if N == 3:
        return [b[0:3],b[3:6],b[6:9]]
    elif N == 4:
        return [b[0:4],b[4:8],b[8:12],b[12:16]]

def rotate_cell(b):
    return [b[LAST]] + b[0:LAST]

def unrotate_cell(b):
    return b[1:N*N] + [b[0]]

def rotate_board(b):
    return [row[::-1] for row in transpose(b)]

def unrotate_board(b):
    return rotate_board(rotate_board(rotate_board(b)))

def turn(b, ops, save=False):
    b = b.split()
    hash = {}
    if N == 3:
        hash['u'] = lambda s: [s[1],s[2],s[0]]
        hash['d'] = lambda s: [s[2],s[0],s[1]]
        hash['r'] = lambda s: [s[2],s[1],s[0]]
    elif N == 4:
        hash['u'] = lambda s: [s[1],s[2],s[3],s[0]]
        hash['d'] = lambda s: [s[3],s[0],s[1],s[2]]
        hash['r'] = lambda s: [s[3],s[2],s[1],s[0]]

    hash['t'] = lambda s: transpose(s)
    hash['>'] = lambda s: stringify(unflatten(rotate_cell(flatten(s))))
    hash['<'] = lambda s: stringify(unflatten(unrotate_cell(flatten(s))))
    hash['c'] = lambda s: rotate_board(s)
    hash['a'] = lambda s: unrotate_board(s)
    for op in ops:
        if save:
            history.append(' '.join(b))
        b = hash[op](b)
    return ' '.join(b)

def expand(board, n):
    q = [board]
    solutions = {board : 0}
    q2 = []
    res = []
    for i in range(n):
        for b in q:
            for op in OPERATIONS:
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
    for op in OPERATIONS:
        header += op + N*'  ' + ' '
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
        print "Commands: up down reverse transpose left right clockwise anti-clockwise z=undo s=surrender"
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

def print_solution(board):
    q = [board]
    solutions = {board : 0}
    q2 = []
    res = []
    i=0
    while q:
        i += 1
        for b in q:
            for op in OPERATIONS:
                b2 = turn(b,op)
                if b2 not in solutions:
                    solutions[b2] = i
                    q2.append(b2)
        q = q2
        q2 = []
    keys = sorted(solutions.keys())
    s = ''
    i = 0
    print "Rubik's Square: Solutions for n=3     Operations: " + OPERATIONS
    print
    for key in keys:
        s += key + ' ' + '0123456789abcdefghijklmnopqrstuvwxyz'[(solutions[key])] + '  '
        i += 1
        if i == 6:
            print s
            i = 0
            s = ''

if N == 4:
    assert turn('abcd efgh ijkl mnop','c') == 'miea njfb okgc plhd'
    assert turn('abcd efgh ijkl mnop','a') == 'dhlp cgko bfjn aeim'

print "Try to unscramble the matrix, in level moves, into:"
if N == 3:
    print "  0 0 0"
    print "  1 1 1"
    print "  2 2 2"
elif N == 4:
    print "  0 0 0 0"
    print "  1 1 1 1"
    print "  2 2 2 2"
    print "  3 3 3 3"

run()

#print_solution(NORMAL)