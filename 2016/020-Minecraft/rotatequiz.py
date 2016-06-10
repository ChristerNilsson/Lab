from math import radians,sin,cos,atan2,hypot
from random import choice

def ass(a,b):
    x1,y1=a
    x2,y2=b
    x1=round(x1,10)
    x2=round(x2,10)
    y1=round(y1,10)
    y2=round(y2,10)
    if x1!=x2 or y1!=y2:
        print a
        print b
    assert x1==x2 and y1==y2
    
angles = [i * 180 for i in range(2)]  # easy
#angles = [i * 90 for i in range(4)]
#angles = [i * 45 for i in range(8)]
#angles = [i * 30 for i in range(12)]
#angles = [i * 15 for i in range(24)]  # hard

DECS = 3
cos45 = cos(radians(45))

def rotate(x, y, angle):
    a = radians(angle)
    dx = x * cos(a) - y * sin(a)
    dy = x * sin(a) + y * cos(a)
    if abs(dx)<0.001: dx=0
    if abs(dy)<0.001: dy=0
    return dx, dy
ass(rotate(0,0,0),(0,0))
ass(rotate(0,0,90),(0,0))

ass(rotate(1,0,0),(1,0))
ass(rotate(1,0,90),(0,1))
ass(rotate(1,0,180),(-1,0))
ass(rotate(1,0,270),(0,-1))

ass(rotate(0,1,0),(0,1))
ass(rotate(0,1,90),(-1,0))
ass(rotate(0,1,180),(0,-1))
ass(rotate(0,1,270),(1,0))

ass(rotate(cos45,cos45,0),(cos45,cos45))
ass(rotate(cos45,cos45,90),(-cos45,cos45))

ass(rotate(cos45,cos45,180),(-cos45,-cos45))
ass(rotate(cos45,cos45,270),(cos45,-cos45))

ass(rotate(-1,0,90),(0,-1))
ass(rotate(-cos45,cos45,45),(-1,0))
ass(rotate(0,-1,45),(cos45,-cos45))
ass(rotate(cos45,-cos45,45),(1,0))

while True:
    v = choice(angles)
    angle = choice(angles)
    pitch = cos(radians(angle))
    roll = sin(radians(angle))
    dx, dy = rotate(pitch,roll,v)

    #if abs(pitch) < 0.001: pitch = 0.0
    #if abs(roll) < 0.001: roll = 0.0
    #if abs(dx) < 0.001: dx = 0.0
    #if abs(dy) < 0.001: dy = 0.0

    print "v", v
    print "pitch", round(pitch,DECS)
    print "roll", round(roll,DECS)
    raw_input()
    print 'dx', round(dx,DECS)
    print 'dy', round(dy,DECS)
    print
