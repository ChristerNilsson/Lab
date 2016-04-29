# -*- coding: utf-8 -*-

# Löser problemet i math_square.py genom att skapa alla permutationer

import operator
import itertools

m2 = [[4,3],[2,1]]
m3 = [[5,4,1],[2,9,3],[7,6,8]]

def mul(lst):
    return reduce(operator.mul, lst, 1)

def group(lst,n):
    return [lst[i:i+n] for i in range(0, n*n, n)]

def sum_A(m):
    mt = zip(*m)
    hor = [sum(row) for row in m]
    ver = [sum(row) for row in mt]
    return [hor,ver]

def mul_A(m):
    mt = zip(*m)
    hor = [mul(row) for row in m]
    ver = [mul(row) for row in mt]
    return [hor,ver]

def solve_add(m,sums):
    for lst in itertools.permutations(m):
        g = group(lst,len(sums[0]))
        res = sum_A(g)
        if res == sums:
            return g

def solve_mul(m,prods):
    for lst in itertools.permutations(m):
        g = group(lst,len(prods[0]))
        res = mul_A(g)
        if res == prods:
            return g

assert sum([1,2,3]) == 6
assert sum([1,2,3,4]) == 10

assert mul([1,2,3]) == 6
assert mul([1,2,3,4]) == 24

assert group([1,2,3,4],2) == [[1,2], [3,4]]

assert sum_A(m2) == [[7,3],[6,4]]
assert sum_A(m3) == [[10,14,21],[14,19,12]]

assert mul_A(m2) == [[12,2],[8,3]]
assert mul_A(m3) == [[20,54,336],[70,216,24]]

assert solve_add(range(1,10),[[10,14,21],[14,19,12]]) == [(1, 3, 6), (5, 7, 2), (8, 9, 4)]
assert solve_add(range(1,10),[[22,11,12],[17,16,12]]) == [(6, 9, 7), (8, 2, 1), (3, 5, 4)]
assert solve_mul(range(1,10),[[20,54,336],[70,216,24]]) == [(5, 4, 1), (2, 9, 3), (7, 6, 8)]
