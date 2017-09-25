import random
import copy
avd = []
TOTAL = 0
EXPENSIVE = 1
CHEAP = 2
price = [0,0,0]

def better(rich,poor,level):
    if avd[rich][level]==0: return False
    return min(avd[poor][TOTAL]+price[level], avd[rich][TOTAL]-price[level]) > avd[poor][TOTAL]

def swap(rich,poor):
    if avd[rich][EXPENSIVE]==0: return False
    if avd[poor][CHEAP]==0: return False
    return min(avd[poor][TOTAL]+price[EXPENSIVE]- price[CHEAP], avd[rich][TOTAL]-price[EXPENSIVE]+ price[CHEAP]) > avd[poor][TOTAL]

def transfer(rich,poor,level):
    global avd
    avd[rich][TOTAL] -= price[level]
    avd[rich][level] -= 1
    avd[poor][TOTAL] += price[level]
    avd[poor][level] += 1

def f(x,a,y,b,n):
    global avd,price
    price[EXPENSIVE] = a
    price[CHEAP] = b
    old = []
    while str(old) != str(avd):
        old = copy.deepcopy(avd)
        for i in reversed(range(1,n)):
            if better(i,0,EXPENSIVE):
                transfer(i,0,EXPENSIVE)
            elif better(i,0,CHEAP):
                transfer(i,0,CHEAP)
            elif swap(i,0):
                transfer(i,0,EXPENSIVE)
                transfer(0,i,CHEAP)
        for i in range(n-1):
            if better(n-1,i,EXPENSIVE):
                transfer(n-1,i,EXPENSIVE)
            elif better(n-1,i,CHEAP):
                transfer(n-1,i,CHEAP)
            elif swap(n-1,i):
                transfer(n-1,i,EXPENSIVE)
                transfer(i,n-1,CHEAP)
        avd = sorted(avd)
        print avd
    return avd[0][TOTAL]

def init():
    global avd
    avd = []
    for i in range(n):
        avd.append([0,0,0]) # [TOTAL,EXPENSIVE,CHEAP]
    avd[n-1] = [x*a + y*b, x, y]

def initRandom(x,a,y,b,n):
    global avd
    avd = []
    for i in range(n):
        avd.append([0,0,0]) # [TOTAL,EXPENSIVE,CHEAP]
    for i in range(x):
        index = random.randint(0,n-1)
        avd[index][TOTAL] += a
        avd[index][EXPENSIVE] += 1
    for i in range(y):
        index = random.randint(0,n-1)
        avd[index][TOTAL] += b
        avd[index][CHEAP] += 1
    avd = sorted(avd)

import sys
for i in sys.stdin:
    ab = i.split()
    x = int(ab[0])
    a = int(ab[1])
    y = int(ab[2])
    b = int(ab[3])
    n = int(ab[4])

#while True:

#init()
initRandom(x,a,y,b,n)
res = f(x,a,y,b,n)
#if res != 2330:
#    break