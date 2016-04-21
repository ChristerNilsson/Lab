# -*- coding: utf-8 -*-

# Träning av add och mult.
# Horisontellt och vertikalt
# 2x2, 3x3, 4x4 eller större
# Värdemängd, t ex 1-4, 1-9, 1-16 osv
# enbart add eller mult i hela matrisen

# Exempel:

# Välj a,b,c,d ur [1,2,3,4] så att radsummor och kolumnsummor stämmer.
# a b 7
# c d 3
# 6 4
# Efter lite funderande inser man att [[a,b],[c,d]] == [[4,3],[2,1]]

import operator
import random

m2 = [[4,3],[2,1]]
m3 = [[5,4,1],[2,9,3],[7,6,8]]

def mul(lst):
    return reduce(operator.mul, lst, 1)

def group(lst,n):
    return [lst[i:i+n] for i in range(0, n*n, n)]

def sum_A(m):
    00
    00
    00
    return [00,00]

def mul_A(m):
    00
    00
    00
    return [00,00]

assert sum([1,2,3]) == 6
assert sum([1,2,3,4]) == 10

assert mul([1,2,3]) == 6
assert mul([1,2,3,4]) == 24

assert group([1,2,3,4],2) == [[1,2], [3,4]]

assert sum_A(m2) == [[7,3],[6,4]]
assert sum_A(m3) == [[10,14,21],[14,19,12]]

assert mul_A(m2) == [[12,2],[8,3]]
assert mul_A(m3) == [[20,54,336],[70,216,24]]

# När du vill slumpa, använd t ex
# lst = range(1,10)
# random.shuffle(lst)
# print lst
# matris = group(lst,3)
# print matris
# print sum_A(matris)
# print mul_A(matris)