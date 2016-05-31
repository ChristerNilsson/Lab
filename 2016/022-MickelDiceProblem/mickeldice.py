# -*- coding: utf-8 -*-

def answer(*ds): return sum([d-1 for d in ds if d % 2 == 1])
assert answer(5, 1, 5, 6) == 8
assert answer(1, 6, 6, 4) == 0
assert answer(5, 5, 3, 3) == 12
assert answer(2, 3, 3, 5) == 8
assert answer(3, 4, 5, 3) == 8
assert answer(2, 2, 1, 3) == 2
assert answer(6, 1, 5, 2) == 4
assert answer(1, 1, 2, 4) == 0
assert answer(1, 4, 6, 2) == 0
assert answer(5, 3, 6, 1) == 6

##############################

lst = []

lst.append([5, 1, 5, 6, 8])
lst.append([1, 6, 6, 4, 0])
lst.append([5, 5, 3, 3, 12])
lst.append([2, 3, 3, 5, 8])
lst.append([3, 4, 5, 3, 8])
lst.append([2, 2, 1, 3, 2])
lst.append([6, 1, 5, 2, 4])
lst.append([1, 1, 2, 4, 0])
lst.append([1, 4, 6, 2, 0])
lst.append([5, 3, 6, 1, 6])

alla = []
for x in lst:
    arr = [0,0,0,0,0,0,0]
    arr[x[0]] += 1
    arr[x[1]] += 1
    arr[x[2]] += 1
    arr[x[3]] += 1
    alla.append([arr,x[4]])


# Bygger på att koefficienterna är 0..6. De kan faktiskt vara vad som helst.
# Då måste man lösa ekvationssystemet istället.
for a in range(7):
    for b in range(7):
        for c in range(7):
            for d in range(7):
                for e in range(7):
                    for f in range(7):
                        flag = True
                        for y,z in alla:
                            if a*y[1] + b*y[2] + c*y[3] + d*y[4] + e*y[5] + f*y[6] != z:
                                flag = False
                        if flag:
                            print a,b,c,d,e,f

# Skriver ut:
# 0 0 2 0 4 0
