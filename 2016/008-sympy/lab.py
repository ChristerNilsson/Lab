# -*- coding: utf-8 -*-

from sympy.simplify import simplify
from sympy.solvers import solve
from sympy.geometry import Line,Point,intersection
from sympy.core import pi,symbols,Symbol,S,N
from sympy.functions import sqrt

from datetime import datetime

###################### Stora tal

x = 123456789
assert x * x == 15241578750190521
assert 21 ** 21 == 5842587018385982521381124421
assert 21 ** 99 == 79379832590301779009332005145274596627014317515664334015779308064863477574777517458715860220591757446709567525956962506247921694381

###################### Bråktal

x = S(1)/2
y = S(3)/4
z = S(5)/6

xx = S(2)/4
zz = S(16)/8

assert str(x) == '1/2'
assert str(y) == '3/4'
assert str(z) == '5/6'
assert str(N(z)) == '0.833333333333333'

assert str(xx) == '1/2'
assert str(x+y) == '5/4'
assert str(x+z) == '4/3'
assert str(y+z) == '19/12'
assert str(x+y+z) == '25/12'

assert str(x*y*z) == '5/16'
assert str(zz) == '2'

######################## ekvationer

x = Symbol('x')
assert solve(x**2-1, x) == [-1, 1]
assert solve(x**2-2, x) == [-sqrt(2), sqrt(2)]

######################## geometri

# C = Point(0,8)
# D = Point(0,2)
# xaxis = Line(Point(0,0),Point(1,0))
# CircleD = Circle(D,2)
# tangentE = CircleD.tangent_lines(C)[0]
# E = intersection(tangentE,CircleD)[0]
#
# CD = Line(C,D)
# tangentK = tangentE.perpendicular_line(C)
# P1 = intersection(tangentK, CD)[0]
# P2 = intersection(tangentK, xaxis)[0]
# T = Triangle(P1,C,P2)
# circle = T.incircle

####################### Nationellt prov åk 9 2012/2013 B
# http://www.su.se/polopoly_fs/1.145320.1378276827!/menu/standard/file/Delprov%20D.pdf

assert 2.35-0.5 == 1.85  # 1
assert 8*0.3 == 2.4  # 2
assert 6+4*3 == 18  # 3
# 4
assert 10**2 / 5**2 == 4  # 5
assert str(25.6 * 0.45) == '11.52'  # 6
a = Symbol('a')
assert solve(S(6)/12 - a/4, a) == [2]  # 7
assert str((S(1)/3) / 2) == '1/6'  # 8
assert solve(x/2+1-5,x) == [8]  # 9
# 10
a = S(3)+S(2)/5
b = pi
c = 3
d = S(10)/3
e = sqrt(8)
assert min(a,b,c,d,e) == e  # 11
a = Symbol('a')
assert solve(a+a+180-70-180,a) == [35]  # 12
x = Symbol('x')
assert solve(S(1)/4 + x/8 - 1, x) == [6]  # 13a
assert solve(S(1)/3 + 8/x - 1, x) == [12]  # 13b
# 14
assert simplify((S(3)*x+x)/x) == 4  # 15

a = S(8*10**7)
b = S(2*10**4)
c = S(8*10**2)
assert a/b-c == 3200  # 16
x = Symbol('x')
assert solve(S(2)*(x+1)-5+2*x, x) == [S(3)/4]  # 17

####################### Nationellt prov åk 9 2012/2013 C

A = Line(Point(0,1000), Point(50,1000))
B = Line(Point(0, 200), Point(40,1000))
C = Line(Point(0,   0), Point(25,1000))

def line(x):
    return Line(Point(x,0), Point(x,1000))

def cost(l,x):
    return intersection(l,line(x))[0].y

assert cost(A,20) == 1000  # 18a
assert cost(B,20) ==  600
assert cost(C,20) ==  800

assert (cost(A,0) == 0) == False  # 18c
assert (cost(B,0) == 0) == False
assert (cost(C,0) == 0) == True

x = Symbol('x')
assert cost(A,x) == 1000  # 18d
assert cost(B,x) == 20*x + 200
assert cost(C,x) == 40*x

####################### Nationellt prov åk 9 2012/2013 D

def proc(x):
    return x/100.0

t1 = datetime(2016,4,8,17,25)
t2 = datetime(2016,4,9,12,55)
assert str(t2-t1) == '19:30:00'  # 19
assert 50*10**6 * proc(7.5) == 3750000.0  # 20
carat,gram = symbols('carat gram')
assert 3106 * 0.2 == 621.2  # 21a
assert 106 / 0.2 == 530  # 21b

speed = (5500-1900)/12.0  # 22
assert str(1900/speed) == '6.33333333333' # dagar

assert 1.55 / 0.005 == 310 # månader # 23
assert 310 / 12 == 25  # år
assert 310 % 12 == 10 # månader


h = 200 # m
S = sqrt(13*h) # km
assert str(N(S)) == '50.9901951359278'  # 24

tathet =  10.5 / 17 # milj per 1000 km2
assert str(450 * tathet) == '277.941176471' # milj  # 25c

# 26
d = 1200.0 # m
t = 5*60.0 # s
speed = d/t
assert speed == 4.0  # meter per sekund   26a
r = symbols('r')
radie = solve(pi*r*r - 65*0.2, r)[1]
assert str(radie) == '2.03421447256411'  # 26b
assert str(radie*2) == '4.06842894512822'
h =symbols('h')
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
height = 0.002*10**-3 # m
area = volym/height  # m2
assert area / 10**6 == 3 # kvadratkilometer

# 29
assert 4000 / 1.6 == 2500  # 29a
assert str(2500 * 1.6 ** 4)  == '16384.0'  # 29b
