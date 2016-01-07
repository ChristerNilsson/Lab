# -*- coding: utf-8 -*-
# https://www.youtube.com/watch?v=0Oef3MHYEC0
# Problemet handlar om att med hjälp av två kärl, 5 och 3 liter mäta upp 4 liter
# Det ska också generaliseras.
# a och b får inte ha några gemensamma delare.
# starta med det första kärlet fyllt.

directions   = [ [-1, 1],  [1, 0],   [0, -1] ]
explanations = ['a to b', 'fill a', 'clear b']

def next_dir(x, y, a, b, d):
    if x in [0,a]:
        return 1-d
    if y in [0,b]:
        return 2-d

def next_pos(x, y, a, b, d):
    dx, dy = directions[d]
    while 0 <= x <= a and 0 <= y <= b:
        x, y = x+dx, y+dy
    return [x-dx, y-dy]

def solve(a, b, target):
    lst = [[0, 0, 1]]
    x, y, d = a,0,0
    while x+y != target:
        lst.append([x, y, d])
        x, y = next_pos(x, y, a, b, d)
        d = next_dir(x, y, a, b, d)
    return lst

def explain(lst):
    return [explanations[i] for _, _, i in lst]

assert next_dir(5, 0, 5, 3, 1) == 0
assert next_dir(0, 2, 5, 3, 0) == 1
assert next_dir(2, 3, 5, 3, 0) == 2

assert next_pos(5, 0, 5, 3, 0) == [2, 3]
assert next_pos(0, 2, 5, 3, 1) == [5, 2]
assert next_pos(2, 3, 5, 3, 2) == [2, 0]

assert explain([[5, 0, 0]]) == ['a to b']
assert explain([[0, 0, 1]]) == ['fill a']
assert explain([[2, 3, 2]]) == ['clear b']

assert solve(3, 5, 1) == [[0, 0, 1], [3, 0, 0], [0, 3, 1], [3, 3, 0], [1, 5, 2]]
assert solve(5, 3, 1) == [[0, 0, 1], [5, 0, 0], [2, 3, 2], [2, 0, 0], [0, 2, 1], [5, 2, 0], [4, 3, 2], [4, 0, 0], [1, 3, 2]]

assert solve(5, 3, 6) == [[0, 0, 1], [5, 0, 0], [2, 3, 2], [2, 0, 0], [0, 2, 1], [5, 2, 0], [4, 3, 2], [4, 0, 0], [1, 3, 2], [1, 0, 0], [0, 1, 1]]
assert explain(solve(5, 3, 6)) == ['fill a', 'a to b', 'clear b', 'a to b', 'fill a', 'a to b', 'clear b', 'a to b', 'clear b', 'a to b', 'fill a']

assert len(solve(11, 7, 14)) == 31

# def gcd(m,n):
#     return n if (m-n) == 0 else gcd(abs(m-n), min(m, n))
# assert gcd(6,15) == 3 and gcd(15,6) == 3 and gcd(3,5) == 1 and gcd(5,3) == 1

# Leta upp längsta lösningen på tvåsiffriga problem
# best_solution = []
# for a in range(1,100):
#     for b in range(a+1,100):
#         if gcd(a,b) == 1:
#             for target in range(1,a+b):
#                 if target==a:
#                     continue
#                 solution = solve(b,a,target)
#                 if len(solution) > len(best_solution):
#                     best_solution = solution
#                     print a,b,target,len(solution),solution