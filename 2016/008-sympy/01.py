from sympy import *
import numpy
import math

#init_printing()

print numpy.arccos(-1)
print math.acos(-1)
print acos(-1)

print acos(0)
print acos(0)

print acos(S.One/2)

x,y,z = symbols('x,y,z')
alpha,beta,gamma = symbols('alpha,beta,gamma')
print x+1
print log(alpha ** beta) + gamma
print sin(x)**2 + cos(x)**2
print simplify(sin(x)**2 + cos(x)**2)

mu,sigma = symbols('mu,sigma')
bell = exp(-(x-mu)**2 / 2*sigma**2)
print bell.diff(x)
print bell.diff(sigma)
print bell.diff(x).diff(x).diff(x)
print simplify(bell.diff(x).diff(x).diff(x))


print (x**2).diff(x)
print sin(x).diff(x)
print (x**2+x*y+y**2).diff(x)
print (x**2+x*y+y**2).diff(y)

def equality_exercise(a,b):
    return (a==b, simplify(a-b)==0)

x=symbols('x')
assert equality_exercise(x,2) == (False,False)
assert equality_exercise((x+1)**2,x**2+2*x+1) == (False,True)
assert equality_exercise(2*x,2*x) == (True,True)
assert equality_exercise(2*x,x*2) == (True,True)

def o_e1():
    x = symbols('x')
    return x**2 + 2*x + S(1)/2
print o_e1()

def o_e2():
    x = symbols('x')
    return (S(1)/2*x ** 2+2*x+S(3)/4) ** (S(3)/2)
print o_e2()

print solve(x**2-9, x)

def ass(a,b):
    for c,d in zip(a,b):
        if simplify(c-d) != 0:
            print "assert failure:"
            print "  " + str(c)
            print "  " + str(d)
            assert False

height, width, area = symbols('height,width,area')
ass(solve(area-height*width, height), [area / width])
ass(solve(area-height*width, width),  [area / height])
ass(solve(area-height*width, area),   [height * width])

volume,r = symbols('volume,r')
print solve(volume - S(4)/3*pi*r**3, r)[0] #, [(S(3)/4*volume/pi)**(S(1)/3)])

a = x**2 + 2*x+1
print a.subs(x,sin(x))