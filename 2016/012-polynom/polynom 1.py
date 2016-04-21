# -*- coding: utf-8 -*-

# Polynom 1: Lista 0,1,2,3,... value, add, mul, diff, integrate, pretty


def value(polynom,x):
    return sum([factor * x ** exponent for exponent,factor in enumerate(polynom)])
a = [5,-7,3]  # f(x) = 5 -7*x + 3*x**2
assert value(a,0) == 5  # f(0) == 5
assert value(a,1) == 1
assert value(a,2) == 3


def add(p1, p2):
    return [(0 if f1 is None else f1) + (0 if f2 is None else f2) for f1,f2 in map(None, p1, p2)]
assert add([],[]) == []
assert add([1],[]) == [1]
assert add([],[1]) == [1]
assert add([1],[1]) == [2]
assert add([1],[2]) == [3]
assert add([1,0,1],[2,3]) == [3,3,1]


def mul(p1,p2):
    res = [0] * (len(p1) + len(p2))
    for exp1,f1 in enumerate(p1):
        for exp2,f2 in enumerate(p2):
            res[exp1 + exp2] += f1 * f2
    if not res:
        return res
    while res[-1] == 0:
        res.pop()
        if not res:
            break
    return res
assert mul([],[]) == []
assert mul([1],[]) == []
assert mul([],[1]) == []
assert mul([1],[1]) == [1]
assert mul([1],[2]) == [2]
assert mul([1,0,1],[2,3]) == [2,3,2,3]


def diff(polynom):
    res = []
    for degree,factor in enumerate(polynom):
        if degree != 0:
            res.append(factor * degree)
    return res
assert diff([]) == []
assert diff([1]) == []
assert diff([1,2]) == [2]
assert diff([1,2,3]) == [2,6]
a = [5,-7,3]  # f(x) = 5 -7*x + 3*x**2
assert diff(a) == [-7,6]  # f'(x) = -7 + 6*x


def integrate(polynom):
    res = [0]
    for degree,factor in enumerate(polynom):
        res.append(1.0 * factor / (degree + 1))
    return res
assert integrate([]) == [0]
assert integrate([1]) == [0,1]
assert integrate([1,2]) == [0,1,1]
assert integrate([1,2,3]) == [0,1,1,1]
a = [5,-7,3]  # f(x) = 5 -7*x + 3*x**2
assert integrate(a) == [0,5,-7 / 2.0,1]  # F(x) = 5*x -3.5X**2 + x**3

# Beräkna ytan mellan polynomen y=x och y=x*x, för x mellan 0 och 1
a = [0,1]
b = [0,0,-1]
c = add(a,b)
C = integrate(c)
assert str(value(C,1) - value(C,0)) == '0.166666666667'
# eller
A = integrate(a)
B = integrate(b)
assert str(value(A,1) - value(A,0) + value(B,1) - value(B,0)) == '0.166666666667'

def pretty(polynom):
    res = []
    for degree,factor in enumerate(polynom):

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

assert pretty([]) == '0'
assert pretty([0]) == '0'
assert pretty([1]) == '1'
assert pretty([0,0]) == '0'
assert pretty([0,1]) == 'x'
assert pretty([0,-1]) == '-x'
assert pretty([0,2]) == '2*x'
assert pretty([0,-2]) == '-2*x'

a = [5, -7, 3]
assert pretty(a) == '5-7*x+3*x**2'
assert pretty(diff(a)) == '-7+6*x'
assert pretty(diff(diff(a))) == '6'
assert pretty(diff(diff(diff(a)))) == '0'
assert pretty([-5,-7,-3]) == '-5-7*x-3*x**2'
assert pretty([0,-7,-3]) == '-7*x-3*x**2'
