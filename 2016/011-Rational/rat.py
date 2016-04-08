class Rat():
    def __init__(self,a,b):
        g = self.gcd(a,b)
        self.a = a/g
        self.b = b/g

    def gcd(self,a, b):
        if b == 0:
            return a
        else:
            return self.gcd(b, a % b)

    def __str__(self):
        if self.b == 1:
            return str(self.a)
        else:
            return str(self.a)+'/'+str(self.b)

    def __eq__(self,other):
        return self.a == other.a and self.b == other.b

    def __add__(self,other):
        return Rat(self.a*other.b + self.b*other.a, self.b*other.b)

    def __mul__(self,other):
        return Rat(self.a*other.a, self.b*other.b)


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
assert str(Rat(16,8)) == '2'
