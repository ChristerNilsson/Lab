# -*- coding: utf-8 -*-

# Löser x**x = 2

def f(x):
    return x**x-2

def search(l,r):
    while True:
        m = (l+r)/2.0
        print m
        if f(m)<0: l=m
        elif f(m)>0: r=m
        else: return m
#print search(lambda x: x**x-2,0,2)
print search(0,2)