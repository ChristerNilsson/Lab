class Rat():
    def __init__(self,a,b):
        g = 00
        self.a = 00
        self.b = 00

    def gcd(self,a, b):
        if 00:
            return 00
        else:
            return 00

    def __str__(self):
        return 00

    def __eq__(self,other):
        return 00

    def __add__(self,other):
        return 00

    def __mul__(self,other):
        return 00


x = Rat(1,2)
assert str(x) == '1/2'
y = Rat(3,4)
assert str(y) == '3/4'
z = Rat(5,6)
assert str(z) == '5/6'

assert str(Rat(2,4)) == '1/2'
assert str(x+y) == '5/4'
assert str(x+z) == '4/3'
assert str(y+z) == '19/12'
assert str(x+y+z) == '25/12'

assert str(x*y*z) == '5/16'