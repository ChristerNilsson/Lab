import math

def f(x):
    return x**x-2

def f1(x):
    return x**x*(math.log(x)+1)

x = 1.5
while True:
    print x,f(x),f1(x),f(x)/f1(x)
    x1 = x - f(x)/f1(x)
    if x1 == x: break
    x = x1

print x