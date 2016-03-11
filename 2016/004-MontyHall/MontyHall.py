# -*- coding: utf-8 -*-

# https://sv.wikipedia.org/wiki/Monty_Hall-problemet

import random

GOAT = 0
CAR = 1
N = 1000

def Strategi1(): # Byt ej
    lst = [GOAT, GOAT, CAR]
    random.shuffle(lst)
    return lst[0]

def Strategi2(): # Byt
    lst = [GOAT, GOAT, CAR]
    random.shuffle(lst)
    lst.pop(0)
    lst.remove(GOAT)
    return lst[0]

count1 = 0
count2 = 0
for i in range(N):
    count1 += Strategi1()
    count2 += Strategi2()

print N, count1, count2
