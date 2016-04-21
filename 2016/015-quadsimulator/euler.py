# http://personal.maths.surrey.ac.uk/st/T.Bridges/SLOSH/3-2-1-Eulerangles.pdf

# -*- coding: utf-8 -*-

# handles yaw, pitch and roll transformations

from math import cos,sin,pi


def rad(degrees):
    return pi * degrees / 180


def make_ypr(yaw,pitch,roll):
    y = rad(yaw)
    p = rad(pitch)
    r = rad(roll)

    cy = cos(y)
    cp = cos(p)
    cr = cos(r)

    sy = sin(y)
    sp = sin(p)
    sr = sin(r)

    a = cp * cy
    b = sr * sp * cy - cr * sy
    c = cr * sp * cy + sr * sy

    d = cp * sy
    e = sr * sp * sy + cr * cy
    f = cr * sp * sy - sr * cy

    g = -sp
    h = sr * cp
    i = cr * cp

    return [[a,b,c],[d,e,f],[g,h,i,]]


def convert_ypr(ypr,x,y,z):  # ypr = 3x3 matris
    [[a,b,c],[d,e,f],[g,h,i,]] = ypr
    x1 = round(a*x+b*y+c*z,16)
    y1 = round(d*x+e*y+f*z,16)
    z1 = round(g*x+h*y+i*z,16)
    return [x1,y1,z1]


def ypr(yaw,pitch,roll,x,y,z):
    m = make_ypr(yaw,pitch,roll)
    return convert_ypr(m,x,y,z)

# assert ypr( 0, 0, 0, 1,2,3) == [1.0, 2.0, 3.0]
#
# assert ypr( 0, 0,90, 1,2,3) == [1.0, -3.0, 2.0]
# assert ypr(90, 0, 0, 1,2,3) == [-2.0, 1.0, 3.0]
# assert ypr( 0,90, 0, 1,2,3) == [3.0, 2.0, -1.0]
#
# assert ypr(90, 0,90, 1,2,3) == [3.0, 1.0, 2.0]
# assert ypr(90,90, 0, 1,2,3) == [-2.0, 3.0, -1.0]
# assert ypr( 0,90,90, 1,2,3) == [2.0, -3.0, -1.0]
#
# assert ypr(90,90,90, 1,2,3) == [3.0, 2.0, -1.0]
#
# assert ypr( 0, 0,45, 1,2,3) == [1.0, -0.707107, 3.535534]
# assert ypr(45, 0, 0, 1,2,3) == [-0.707107, 2.12132, 3.0]
# assert ypr( 0,45, 0, 1,2,3) == [2.828427, 2.0, 1.414214]
#
# ##############################
#
# assert ypr( 0, 0, 0, 1,1,1) == [1.0, 1.0, 1.0]
#
# assert ypr(90, 0, 0, 1,1,1) == [-1.0, 1.0, 1.0]
# assert ypr( 0,90, 0, 1,1,1) == [1.0, 1.0, -1.0]
# assert ypr( 0, 0,90, 1,1,1) == [1.0, -1.0, 1.0]
#
# assert ypr( 0,90,90, 1,1,1) == [1.0, -1.0, -1.0]
# assert ypr(90, 0,90, 1,1,1) == [1.0, 1.0, 1.0]
# assert ypr(90,90, 0, 1,1,1) == [-1.0, 1.0, -1.0]
#
# assert ypr(90,90,90, 1,1,1) == [1.0, 1.0, -1.0]
