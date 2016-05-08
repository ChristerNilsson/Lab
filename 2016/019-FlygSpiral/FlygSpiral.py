# -*- coding: utf-8 -*-
#
#  Mät längden på en spiral
# a = Startradie
# b = slutradie
# n = antal varv
# m = upplösning. T ex m=90 innebär 90 grader.

import math

def spiral(a,b):
    return math.pi * (a + b)

assert str(spiral(1,2)) == '9.42477796077'

# 35 km/h * 4 h = 140 km

def calc(d,varv):
    sum = 0
    for i in range(varv):
        a = d*(i+0.5)
        b = a+d
        sum += spiral(a,b)
        res = [spiral(a,b), sum, sum/d]
    return res

print "varvlängd, sträcka per plan, antal plan"

assert calc(1,6) == [37.69911184307752, 131.94689145077132, 131.94689145077132] # [1,2,3,4,5,6] km radie
assert calc(2,4) == [50.26548245743669, 125.66370614359172, 62.83185307179586]  # [  2,  4,  6,  8] km radie
assert calc(3,3) == [56.548667764616276, 113.09733552923255, 37.69911184307752] # [    3,    6,    9] km radie
assert calc(4,2) == [50.26548245743669, 75.39822368615503, 18.84955592153876]   # [      4,      8] km radie

# 1 km mellan planen
# sum = 0
# for i in range(1,7):
#     sum += spiral(i,i+1)
#     print spiral(i,i+1),sum
# 151 plan, 151 km per plan [1,2,3,4,5,6] km radier

# 2 km mellan planen
# sum = 0
# for i in range(2,13,2):
#     sum += spiral(i,i+1)
#     print spiral(i,i+1), sum, sum/2
# 69 plan, 138 km per plan [2,4,6,8] km radier

# 3 km mellan planen
# sum = 0
# for i in range(3,12,3):
#     sum += spiral(i,i+1)
#     print spiral(i,i+1), sum, sum/3
# 41 plan, 122 km per plan [3,6,9] km radier

# 4 km mellan planen
# sum = 0
# for i in range(4,16,4):
#     sum += spiral(i,i+1)
#     print spiral(i,i+1), sum, sum/4
# # 40 plan, 160 km per plan [4,8,12] km radier