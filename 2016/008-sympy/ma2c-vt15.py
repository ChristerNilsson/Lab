# -*- coding: utf-8 -*-

from sympy.simplify import simplify
from sympy.solvers import solve
from sympy.geometry import Line,Point,Point2D,intersection
from sympy.core import pi,symbols,Symbol,S,N
from sympy.functions import sqrt
from sympy import *
import sympy

# 1
x,y = symbols('x y')
assert solve(y*(x-5)-(x*x-25),y)[0] == x + 5

# 2
assert solve(5**x-3,x)[0] == log(3)/log(5)  # 2a
assert solve(sqrt(x+1) - 5,x)[0]  == 24  # 2b

# 3
# y = 2 + x  # 3a
# y = 4  # 3b

# 4
# a C
# b E
# c B
# d F
# e D

# 5
x = symbols('x')
assert solve(x*x+3-1,x) == [-sqrt(2)*I, sqrt(2)*I]
assert solve(x*x+6*x-3-2,x) ==[-3 + sqrt(14), -sqrt(14) - 3]
assert solve(x*x+9,x) ==[-3*I, 3*I]
assert solve(x*x-4*x+9-2,x) == [2 - sqrt(3)*I, 2 + sqrt(3)*I]
assert solve((x-2)*(x+2),x) == [-2, 2]
# Svar: B och E

# 6
x = symbols('x')
ans = solve(log(x),x)[0]
assert ans == 1
assert 10**-ans == 0.1

# 7
a = symbols('a', real=True)
assert str(solve(a**14 - 16514/44.0, a)[1]) == '1.52716402865093'  # Svar: 1.53
assert str(1.52716402865093**14 - 16514/44.0) == '-1.1823431123e-11'

# 8
# 8a Svar: -3 < x < 4
# 8b Svar: x==-2 och x=4

# 9
x = symbols('x')
assert simplify(((sqrt(x)+sqrt(3))**2 - (x+3)) / 2) == sqrt(3*x)
assert log(x**(S(1)/2)) * 2 * log(x/2) / log(x/2) == 2*log(sqrt(x))
# sympy ser inte den enklare lsg: log(x)
f = 2*ln(sqrt(x))
g = ln(x)
#print N(f.subs({x:2})), N(g.subs({x:2}))
#print N(f.subs({x:3})), N(g.subs({x:3}))

# 10
assert solve(x*x-6*x+5,x) == [1,5]

# 11
x,y = symbols('x y')
assert solve([y-2*x-5, 2*y-x-4], [x,y]) == {x: -2, y: 1}

# 12
x = symbols('x')
f = (8-x) * x * 2
fp = diff(f,x)
assert fp == -4*x + 16
assert solve(fp,x)[0] == 4
assert f.subs({x:4}) == 32

# 13
x = symbols('x')
a = x*2+1
b = x*2-S(3)/2
assert simplify((a*a-b*2)/4) == x**2 + 1

# 14
a,b,x = symbols('a b x')
f = expand((x-1)*(x+3))
assert f == x**2 + 2*x - 3
assert solve(a+4-2,a)[0] == -2
assert solve(b+5+3,b)[0] == -8

# 15
# Likformighet ger 4/x == x/2 => 8 = x*x. x är kvadratens sida

# 16
# Avståndet från A till origo är sqrt(2)*a == a+r
# Detta ger r = a*(sqrt(2)-1)

# 17
#             x**2 - 2bx + 4
# (x-b)**2 == x**2 - 2bx + b**2
# Vi ser att om b=-2 eller 2 så blir f(x) = 0
# f(-2) = 0
# f(0) = -2
# f(2) = 0
# Ekv.system ger att g(x) = 0.5*x**2 - 2

