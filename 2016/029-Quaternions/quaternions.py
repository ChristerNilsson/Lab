# https://www.youtube.com/watch?v=SCbpxiCN0U0
# https://www.youtube.com/watch?v=CRiR2eY5R_s

# EJ AVSLUTAT!
# Källkod: https://github.com/BSVino/MathForGameDevelopers/tree/quaternion-transform

import math

def ass(a,b):
    if a!=b:
        print a, "!=",b
        assert False

class Quaternion:
    def __init__(self,n,a):  # a i grader
        x,y,z = n
        a = math.radians(a)
        x = x * math.sin(a/2)
        y = y * math.sin(a/2)
        z = z * math.sin(a/2)
        self.w = math.cos(a/2)
        #assert x*x + y*y + z*z + self.w*self.w == 1
        self.x,self.y,self.z = x,y,z
    def __str__(self):
        return "{:0.6f} {:0.6f} {:0.6f} {:0.6f}".format(self.x,self.y,self.z,self.w)
    def inverse(self):
        res = Quaternion((0,0,0),0)
        res.x = -self.x
        res.y = -self.y
        res.z = -self.z
        res.w = self.w
        return res
    def mult(self):
        pass
    def rotate(self,other):
        pass

                                    #   x        y        z        w
assert str(Quaternion((1,0,0),  0)) == '0.000000 0.000000 0.000000 1.000000'
assert str(Quaternion((1,0,0), 90)) == '0.707107 0.000000 0.000000 0.707107'
assert str(Quaternion((1,0,0),180)) == '1.000000 0.000000 0.000000 0.000000'

assert str(Quaternion((0,1,0), 90)) == '0.000000 0.707107 0.000000 0.707107'
assert str(Quaternion((0,1,0),180)) == '0.000000 1.000000 0.000000 0.000000'

assert str(Quaternion((1,0,0),90).inverse()) == '-0.707107 -0.000000 -0.000000 0.707107'

