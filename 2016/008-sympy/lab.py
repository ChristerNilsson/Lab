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

