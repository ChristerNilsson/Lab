# -*- coding: utf-8 -*-

from sympy.simplify import simplify
from sympy.solvers import solve
from sympy.geometry import Line,Point,Point2D,intersection
from sympy.core import pi,symbols,Symbol,S,N
from sympy.functions import sqrt
from sympy import *
import sympy

# 1
x = -2
assert 25 - 3*x == 31

# 2
assert S(1)-S(2)/3-S(1)/9 == S(2)/9

# 3
assert str(100 * (1.0 - 0.8)) == '20.0'

# 4
x = Symbol('x')
assert solve(x*9 + 10**2 - 10**3,x)[0] == 100

# 5
x,y = symbols('x y')
a = x + y
b = x - y
assert a-b == 2*y

# 6
y = S(3)/2 * x - 2000
assert y == 3*x/2 - 2000

# 7
x = symbols('x')
assert solve(sqrt(x)-9,x)[0] == 81

# 8
P = Point(2,2)
Q = Point(2,0)
assert Q-P == Point2D(0, -2)

# 9
assert 2*2 + 0*0 == 4

# 10
p1 = Point(0,3)
p2 = Point(4,0)
p3 = Point(4,3)
segment = Segment(Point(0,0), p1+p2+p3)
assert segment.length == 10

# 11
assert (S(10)**102 + S(10) ** 100) / S(10)**100 == 101

#12
x = symbols('x')
assert x*2+3 - (x+2) == x+1  # för vissa x-värden större än

# 13
x,y = symbols('x y')
y = 145 - x
# 0 < y < 145

# 14
a4 = S(297*210)
a5 = a4/2
a6 = a5/2
assert a4/a6 == 4
a3 = 2 * a4
a2 = 2 * a3
a1 = 2 * a2
a0 = 2 * a1
assert a0 == 997920 # 0.998 kvm
assert str(297/210.0) == '1.41428571429'
assert str(280/215.0) == '1.3023255814'
assert str(397/280.0) == '1.41785714286'

#15
v = symbols('v')
# 1  # 15a
assert solve(1 - (S(1)/2**2 + x*x),x)[1] == sqrt(3)/2  # 15b

# 16
assert 1121*12*10 == 134520
ranta = 6.85/100 * 100000 / 12
assert str(ranta/1121) == '0.509217960155'  # Svar 51 %

# 17 Svar: 1/6
lst = [abs(x-y) == 3 for x in range(6) for y in range(6)]
assert S(lst.count(True))/len(lst) == S(1)/6

# 18 Svar: 30 och 60 grader
assert str(N(asin(2/3.0) * 180 / pi)) == '41.8103148957786'  # Svar: 41.8 grader

# 19
x = symbols('x')
assert str(solve(x ** 2 - 1.37,x)[1]) == '1.17046999107196'  # Svar: 17.0%
assert str(1.37**(S(1)/2)) == '1.17046999107196'

# 20
n = 0
ok = false
while not ok:
    n += 1
    ok = true
    for i in range(1,10):
        if n%i != 0: ok = false

assert n == 2520
assert 5*7*8*9 == 2520

# 21
# Anna gör rätt, Erik fel. Hans summa ska vara 5*180 = 900 grader

# 22
# 22a Lågenergi kostar 85 kronor
#     Glödlampa kostar 10 kronor
# En lågenergilampa varar 9000 timmar. Kostnad 85 + 3 * (130-85) = cirka 220 kr
# Glödlampor kostar cirka 9 * 90 kr = cirka 810 kr
#

# 23
assert 6*30 + 6*29 == 354  # 23a Svar: sex månader
assert 33*(2012-622)/32 == 1433  # 23b
assert str(365/354.0) == '1.03107344633'
assert str(33/32.0) == '1.03125' # 23c
x = symbols('x')
assert solve(x-S(33)*(x-622)/32,x)[0] == 20526  # 23d


