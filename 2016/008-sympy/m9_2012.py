# -*- coding: utf-8 -*-

from sympy.simplify import simplify
from sympy.solvers import solve
from sympy.geometry import Line,Point,intersection
from sympy.core import pi,symbols,Symbol,S,N
from sympy.functions import sqrt

from datetime import datetime

####################### Nationellt prov åk 9 2012/2013 B
# http://www.su.se/polopoly_fs/1.145320.1378276827!/menu/standard/file/Delprov%20D.pdf

# 1
assert 2.35-0.5 == 1.85

# 2
assert 8*0.3 == 2.4

# 3
assert 6+4*3 == 18

# 5
assert 10**2 / 5**2 == 4

# 6
assert str(25.6 * 0.45) == '11.52'

# 7
a = Symbol('a')
assert solve(S(6)/12 - a/4, a) == [2]

# 8
assert str((S(1)/3) / 2) == '1/6'

# 9
x = Symbol('x')
assert solve(x/2+1-5,x) == [8]

# 11
a = S(3)+S(2)/5
b = pi
c = 3
d = S(10)/3
e = sqrt(8)
assert min(a,b,c,d,e) == e

# 12
a = Symbol('a')
assert solve(a+a+180-70-180,a) == [35]

# 13
x = Symbol('x')
assert solve(S(1)/4 + x/8 - 1, x) == [6]  # 13a
assert solve(S(1)/3 + 8/x - 1, x) == [12]  # 13b

# 15
assert ((S(3)*x+x)/x) == 4

# 16
a = S(8*10**7)
b = S(2*10**4)
c = S(8*10**2)
assert a/b-c == 3200

# 17
x = Symbol('x')
assert solve(S(2)*(x+1)-5+2*x, x) == [S(3)/4]

####################### Nationellt prov åk 9 2012/2013 C

A = Line(Point(0,1000), Point(50,1000))
B = Line(Point(0, 200), Point(40,1000))
C = Line(Point(0,   0), Point(25,1000))

def line(x):
    return Line(Point(x,0), Point(x,1000))

def cost(l,x):
    return intersection(l,line(x))[0].y

# 18a
assert cost(A,20) == 1000
assert cost(B,20) ==  600
assert cost(C,20) ==  800

# 18c
assert (cost(A,0) == 0) == False
assert (cost(B,0) == 0) == False
assert (cost(C,0) == 0) == True

# 18d
x = Symbol('x')
assert cost(A,x) == 1000
assert cost(B,x) == 20*x + 200
assert cost(C,x) == 40*x

####################### Nationellt prov åk 9 2012/2013 D

def proc(x):
    return x/100.0

# 19
t1 = datetime(2016,4,8,17,25)
t2 = datetime(2016,4,9,12,55)
assert str(t2-t1) == '19:30:00'

# 20
assert 50*10**6 * proc(7.5) == 3750000.0

# 21
gram,carat = symbols('gram'),3106
assert solve(carat*0.2-gram*1, gram)[0] == 621.2 # gram

gram,carat = 106,symbols('carat')
assert solve(carat*0.2-gram*1, carat)[0] == 530 # carat

assert 3106 * 0.2 == 621.2  # gram 21a
assert 106 / 0.2 == 530  # carat 21b

# 22
speed = (5500-1900)/12.0
assert str(1900/speed) == '6.33333333333'  # dagar

# 23
assert 1.55 / 0.005 == 310  # månader
assert 310 / 12 == 25  # år
assert 310 % 12 == 10  # månader

# 24
h = 200 # m
S = sqrt(13*h)  # km
assert str(N(S)) == '50.9901951359278'  # 24

# 25
tathet = 10.5 / 17  # milj per 1000 km2
assert str(450 * tathet) == '277.941176471'  # milj  # 25c

# 26
d = 1200.0 # m
t = 5*60.0 # s
speed = d/t
assert speed == 4.0  # meter per sekund   26a
r = symbols('r')
radie = solve(pi*r*r - 65*0.2, r)[1]
assert str(radie) == '2.03421447256411'  # 26b
assert str(radie*2) == '4.06842894512822'
h = symbols('h')
height = N(solve(h*h+958*958-1200*1200,h)[1])
assert str(height) == '722.658979048901'
assert str(height+363) == '1085.65897904890'

# 27
a = 0.080 * 25 # km
b = 0.140 * 25 # km
c = 0.070 * 25 # km
area = (a+b)/2*c  # km2
assert a == 2  # km
assert str(b) == '3.5'  # km
assert str(c) == '1.75'  # km
assert str(area) == '4.8125' # km2

# 28
volym = 6  # m3
height = 0.002*10**-3  # m
area = volym/height  # m2
assert area / 10**6 == 3  # kvadratkilometer

# 29
assert 4000 / 1.6 == 2500  # 29a
assert str(2500 * 1.6 ** 4) == '16384.0'  # 29b
