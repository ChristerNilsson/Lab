# -*- coding: utf-8 -*-

from sympy import S

# Polynom 2: Lista 0,1,2,3,... Value, Add, Mul, Diff, Integrate, Prettyprint
# Objektorienterat


class Polynom(object):
    def __init__(self, polynom):
        self.polynom = polynom

    def __call__(self, x):
        return sum([factor * x ** exponent for exponent,factor in enumerate(self.polynom)])

    def __eq__(self,other):
        return self.polynom == other.polynom

    def __str__(self):
        res = []
        for degree,factor in enumerate(self.polynom):

            a,b,c,d,e = '','','','',''

            if factor == 0:
                continue
            if factor > 0:
                a = '+'

            if factor == 1:
                if degree == 0:
                    b = str(factor)
            elif factor == -1:
                b = '-'
            else:
                b = str(factor)
                if degree != 0:
                    c = '*'

            if degree == 0:
                pass
            elif degree == 1:
                d = 'x'
            else:
                d = 'x**'
                if '/' in str(degree):
                    e = '(' + str(degree) + ')'
                else:
                    e = str(degree)

            res.append(a+b+c+d+e)
        if not res:
            res.append('0')
        res = ''.join(res)
        if res[0] == '+':
            res = res[1:]
        return res

    def __add__(self, other):
        return Polynom([(0 if f1 is None else f1) + (0 if f2 is None else f2) for f1,f2 in map(None, self.polynom, other.polynom)])

    def __sub__(self, other):
        return self + Polynom([-factor for factor in other.polynom])

    def __mul__(self,other):
        p1 = self.polynom
        p2 = other.polynom
        res = [0] * (len(p1) + len(p2))
        for exp1,f1 in enumerate(p1):
            for exp2,f2 in enumerate(p2):
                res[exp1 + exp2] += f1 * f2
        if not res:
            return Polynom(res)
        while res[-1] == 0:
            res.pop()
            if not res:
                break
        return Polynom(res)

    def diff(self):
        res = []
        for degree,factor in enumerate(self.polynom):
            if degree != 0:
                res.append(factor * degree)
        return Polynom(res)

    def integrate(self):
        res = [0]
        for degree,factor in enumerate(self.polynom):
            res.append(1.0 * factor / (degree + 1))
        return Polynom(res)

a = Polynom([5,-7,3])  # f(x) = 5 -7*x + 3*x**2
assert a(0) == 5
assert a(1) == 1
assert a(2) == 3

assert Polynom([]) + Polynom([]) == Polynom([])
assert Polynom([1]) + Polynom([]) == Polynom([1])
assert Polynom([]) + Polynom([1]) == Polynom([1])
assert Polynom([1]) + Polynom([1]) == Polynom([2])
assert Polynom([1]) + Polynom([2]) == Polynom([3])
assert Polynom([1,0,1]) + Polynom([2,3]) == Polynom([3,3,1])

assert Polynom([]) * Polynom([]) == Polynom([])
assert Polynom([1]) * Polynom([]) == Polynom([])
assert Polynom([]) * Polynom([1]) == Polynom([])
assert Polynom([1]) * Polynom([1]) == Polynom([1])
assert Polynom([1]) * Polynom([2]) == Polynom([2])
assert Polynom([1,0,1]) * Polynom([2,3]) == Polynom([2,3,2,3])

assert Polynom([]).diff() == Polynom([])
assert Polynom([1]).diff() == Polynom([])
assert Polynom([1,2]).diff() == Polynom([2])
assert Polynom([1,2,3]).diff() == Polynom([2,6])
assert Polynom([5,-7,3]).diff() == Polynom([-7,6])

assert Polynom([]).integrate() == Polynom([0])
assert Polynom([1]).integrate() == Polynom([0,1])
assert Polynom([1,2]).integrate() == Polynom([0,1,1])
assert Polynom([1,2,3]).integrate() == Polynom([0,1,1,1])
assert Polynom([5,-7,3]).integrate() == Polynom([0,5,-3.5,1])

# Beräkna ytan mellan polynomen y=x och y=x*x, för x mellan 0 och 1
a = Polynom([0,1])
b = Polynom([0,0,1])
c = a - b
f = c.integrate()
assert str(f(1) - f(0)) == '0.166666666667'

assert str(Polynom([])) == '0'
assert str(Polynom([0])) == '0'
assert str(Polynom([1])) == '1'
assert str(Polynom([0,0])) == '0'
assert str(Polynom([0,1])) == 'x'
assert str(Polynom([0,-1])) == '-x'
assert str(Polynom([0,2])) == '2*x'
assert str(Polynom([0,-2])) == '-2*x'

a = [5, -7, 3]
assert str(Polynom(a)) == '5-7*x+3*x**2'
assert str(Polynom(a).diff()) == '-7+6*x'
assert str(Polynom(a).diff().diff()) == '6'
assert str(Polynom(a).diff().diff().diff()) == '0'
assert str(Polynom([0,-7,-3])) == '-7*x-3*x**2'
