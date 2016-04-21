# -*- coding: utf-8 -*-

# from sympy import S,N

# Byt ut list mot dict i denna övning!

# Polynom 3: Value, Add, Mul, Diff, Integrate, Prettyprint
# Objektorienterat
# Klarar även negativa exponenter samt bråktal. Skapas mha en Hash

class Polynom(object):
    def __init__(self, polynom): # Om polynom är en list, gör om till dict!
        if type(polynom) is list:
            self.polynom = {exponent: factor for exponent, factor in enumerate(polynom) if factor != 0}
        else:
            self.polynom = polynom

    def __call__(self, x):  # Hantera anrop typ f(2)
        return sum([factor * x ** exponent for exponent, factor in self.polynom.iteritems()])

    def __eq__(self,other):  # Används vid jmf t ex med assert
        return self.polynom == other.polynom

    def __str__(self):  # Sträng skapas t ex vid utskrift
        res = []
        for degree,factor in self.polynom.items():

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
        res = {}
        for exponent, factor in self.polynom.items():
            res[exponent] = factor
        for exponent, factor in other.polynom.items():
            if exponent not in res:
                res[exponent] = 0
            res[exponent] += factor
        return Polynom(res)

    def __sub__(self, other):
        return self + Polynom({exponent: -other.polynom[exponent] for exponent in other.polynom})

    def __mul__(self,other):
        p1 = self.polynom
        p2 = other.polynom
        res = {}
        for exp1,f1 in p1.items():
            for exp2,f2 in p2.items():
                key = exp1 + exp2
                if key not in res:
                    res[key] = 0
                res[key] += f1 * f2
        return Polynom(res)

    def diff(self):  # derivera
        res = {}
        for degree,factor in self.polynom.items():
            if degree != 0:
                res[degree-1] = factor * degree
        return Polynom(res)

    def integrate(self):  # integrera
        res = {}
        for degree,factor in self.polynom.items():
            res[degree+1] = 1.0 * factor / (degree + 1)
        return Polynom(res)

a = Polynom([5, -7, 3])  # f(x) = 5 -7*x + 3*x**2
assert a(0) == 5
assert a(1) == 1
assert a(2) == 3

assert Polynom([]) + Polynom([]) == Polynom([])
assert Polynom([1]) + Polynom([]) == Polynom([1])
assert Polynom([]) + Polynom([1]) == Polynom([1])
assert Polynom([1]) + Polynom([1]) == Polynom([2])
assert Polynom([1]) + Polynom([2]) == Polynom([3])
assert Polynom([1, 0, 1]) + Polynom([2, 3]) == Polynom([3, 3, 1])

assert Polynom([]) * Polynom([]) == Polynom([])
assert Polynom([1]) * Polynom([]) == Polynom([])
assert Polynom([]) * Polynom([1]) == Polynom([])
assert Polynom([1]) * Polynom([1]) == Polynom([1])
assert Polynom([1]) * Polynom([2]) == Polynom([2])
assert Polynom([1, 0, 1]) * Polynom([2, 3]) == Polynom([2, 3, 2, 3])

assert Polynom([]).diff() == Polynom([])
assert Polynom([1]).diff() == Polynom([])
assert Polynom([1,2]).diff() == Polynom([2])
assert Polynom([1,2,3]).diff() == Polynom([2,6])
assert Polynom([5,-7,3]).diff() == Polynom([-7,6])

assert Polynom([]).integrate() == Polynom([])
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
assert str(Polynom([1])) == '1'
assert str(Polynom([0,0])) == '0'
assert str(Polynom([0,1])) == 'x'
assert str(Polynom([0,-1])) == '-x'
assert str(Polynom([0,2])) == '2*x'
assert str(Polynom([0,-2])) == '-2*x'

a = Polynom([5, -7, 3])
assert str(a) == '5-7*x+3*x**2'
assert str(a.diff()) == '-7+6*x'
assert str(a.diff().diff()) == '6'
assert str(a.diff().diff().diff()) == '0'
assert str(Polynom({1:-7,2:-3})) == '-7*x-3*x**2'

############# Här kommer godiset! ##################

p = Polynom({-1.0/2: 5})  # 5 / sqrt(x)  # eller med sympy: S(1)/2
assert str(p) == '5*x**-0.5'
assert str(p(2)) == '3.53553390593'
assert str(p*p) == '25*x**-1.0'

q = Polynom({-2: 5})  # 5/x**2
assert str(q) == '5*x**-2'
assert q(5) == 0.2

r = Polynom({0.25: 1})  # fjärde roten ur x
assert str(r) == 'x**0.25'
assert str(r(2)) == '1.189207115'
assert str(r*r*r*r) == 'x'

P = p.integrate()
Q = q.integrate()
R = r.integrate()

assert str(P) == '10.0*x**0.5'
assert str(Q) == '-5.0*x**-1'
assert str(R) == '0.8*x**1.25'

assert str(P.diff()) == '5.0*x**-0.5'
assert str(Q.diff()) == '5.0*x**-2'
assert str(R.diff()) == 'x**0.25'

assert p.integrate().diff() == p
assert q.integrate().diff() == q
assert r.integrate().diff() == r