# -*- coding: utf-8 -*-

from math import pi,sqrt

def ass_point(a,b):
    if round(a[0],6) != round(b[0],6) or round(a[1],6) != round(b[1],6):
        print 'assert failure!'
        print a
        print b
        assert False

# inspired by map and lerp in processing

def pmap(x, (x1, x2), (y1, y2)):
    """Re-maps a number from one range to another"""
    dx,dy = (float(x2)-x1),(float(y2)-y1)
    return  y1 + (x-x1) * dy / dx

assert pmap(0, (0,1), (0,2)) == 0
assert pmap(0.5, (0,1), (0,2)) == 1
assert pmap(1.0, (0,1), (0,2)) == 2

# Konvertering till RGB
assert pmap(0, (0,1), (0,255)) == 0
assert pmap(1, (0,1), (0,255)) == 255
assert pmap(0.5, (0,1), (0,255)) == 127.5

# Konvertering från RGB
assert pmap(0, (0,255), (0,1)) == 0
assert pmap(255, (0,255), (0,1)) == 1
assert round(pmap(128, (0,255), (0,1)),6) , 0.501961

# Konvertering från Celsius till Kelvin
assert pmap(0, (0,100), (273,373)) == 273
assert pmap(50, (0,100), (273,373)) == 323
assert pmap(100, (0,100), (273,373)) == 373
assert pmap(-273, (0,100), (273,373)) == 0

# Konvertering från grader till radianer
assert pmap(0, (0,360), (0,2*pi)) == 0
assert pmap(90, (0,360), (0,2*pi)) == pi/2
assert pmap(180, (0,360), (0,2*pi)) == pi
assert pmap(270, (0,360), (0,2*pi)) == 3*pi/2
assert pmap(360, (0,360), (0,2*pi)) == 2*pi

# Konvertering från Celsius till Fahrenheit
assert pmap(0, (0,100), (32,212)) == 32
assert pmap(100, (0,100), (32,212)) == 212
assert pmap(20, (0,100), (32,212)) == 68

# Konvertering från Fahrenheit till Celsius
assert pmap(32, (32,212), (0,100)) == 0
assert pmap(212, (32,212), (0,100)) == 100
assert round(pmap(0, (32,212), (0,100)),6) == -17.777778

def lerp(start, stop, amt):
    """Linear interpolation between two Points or Rotations"""
    return amt*stop + (1-amt)*start

assert lerp(0, 100, 0.0) == 0
assert lerp( 0, 100, 0.5) == 50
assert lerp( 0, 100, 1.0) == 100
assert lerp(10, 110, 0.0) == 10
assert lerp(10, 110, 0.5) == 60
assert lerp(10, 110, 1.0) == 110

def norm(value,low,high):
    """Normalizes a number from another range into a value between 0 and 1.
    Identical to pmap(value, low, high, 0, 1)."""
    return float(value) / (high-low)

assert norm(20, 0, 50) == 0.4
assert norm(-10, 0, 100) == -0.1

def normalize(x,y):
    """Se till att vektorn får längden 1"""
    dist = sqrt(x*x+y*y)
    return x/dist,y/dist

assert normalize(10,0) == (1, 0)
ass_point(normalize(1,1), (0.707107, 0.707107))
assert normalize(3,4) == (0.6, 0.8)
