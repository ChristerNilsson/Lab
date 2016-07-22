import itertools
import time

lst = [0,1,2,3,4,5,6,7,8,9]
#      A B E F L M O R T U

def trans(a,lst):
    res = 0
    for pos in a:
        res = 10*res + lst[pos]
    return res
assert trans([2,9,4,2,7],lst) == 29427

start = time.time()

for item in itertools.permutations(lst):
    euler    = trans([2,9,4,2,7],item)
    abel       = trans([0,1,2,4],item)
    boole    = trans([1,6,6,4,2],item)
    fermat = trans([3,1,7,5,0,8],item)
    if euler+abel+boole == fermat:
        print '  '+str(euler)
        print '+  '+str(abel)
        print '+ '+str(boole)
        print '='+str(fermat)
        print item
        print

print time.time()-start

#   97693
# +  5496
# + 40069
# =143258
# (5, 4, 9, 1, 6, 2, 0, 3, 8, 7)
#
#   95792
# +  6497
# + 40079
# =142368
# (6, 4, 9, 1, 7, 3, 0, 2, 8, 5)
#
# 15.0590000153