#import time
import copy
avd = []
TOTAL = 0
CHEAP = 1
EXPENSIVE = 2

#optima = [[900,3,0],[800,1,1],[600,2,0]]
#optima = [[330,3,0],[300,0,2],[260,1,1]]
#optima = [[2330,2,5], [2258,6,2], [2221,3,4], [2184,0,6], [2149,7,1], [2112,4,3], [2075,1,5], [2040,8,0], [2003,5,2] ]

def create_optima(avg):
    global optima
    optima = []
    for x in range(10):
        for y in range(10):
            if a*x+b*y < avg:
                optima.append([a*x+b*y,x,y])
    optima = sorted(optima)
    optima = list(reversed(optima))

def optimize():
    global avd
    for optimum in optima:
        [t1,x1,y1] = optimum
        [t2,x2,y2] = avd[0]
        [dx,dy] = [x1-x2,y1-y2]
        for i in reversed(range(n)):
            [t3,x3,y3] = avd[i]
            [x4,y4] = [x3-dx,y3-dy]
            if x4>=0 and y4>=0: # make a move
                belopp = a*x4+b*y4
                if t2 != belopp and belopp > avd[0][TOTAL] and t1 != t2 and t1 > avd[0][TOTAL]:
                    avd[0] = [a*x1+b*y1,x1,y1]
                    avd[i] = [belopp,x4,y4]
                    #print dx,dy,x4,y4
                    #print 'swap',t2,t1
                    #print 'swap',t3,belopp
                    return
    #print 'no more optimas'

def f(x,a,y,b,n):
    global avd,price
    old = []
    while str(old) != str(avd):
        old = copy.deepcopy(avd)
        optimize()
        avd = sorted(avd)
        #print avd
    return avd[0][TOTAL]

def init(x,a,y,b,n):
    create_optima((x*a+y*b)/n)
    #print optima
    global avd
    avd = []
    for i in range(n):
        avd.append([0,0,0]) # [TOTAL,EXPENSIVE,CHEAP]
    index = 0
    for i in range(y):
        avd[index%n][TOTAL] += b
        avd[index%n][EXPENSIVE] += 1
        index+=1
    for i in range(x):
        avd[index%n][TOTAL] += a
        avd[index%n][CHEAP] += 1
        index+=1
    avd = sorted(avd)
    #print avd

import sys
for i in sys.stdin:
    ab = i.split()
    x = int(ab[0])
    a = int(ab[1])
    y = int(ab[2])
    b = int(ab[3])
    n = int(ab[4])

    if a>b:
        [a,b] = [b,a]
        [x,y] = [y,x]

#x,a,y,b,n = 2,500,3,300,2
#x,a,y,b,n = 3,150,5,110,3
#x,a,y,b,n = 37,255,58,364,13

#start = time.time()
init(x,a,y,b,n)
print f(x,a,y,b,n)
#print time.time() - start
