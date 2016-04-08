class BigNum():
    def __init__(self,digits):
        self.digits = digits

    def __str__(self):
        return ''.join(str(digit) for digit in self.digits)

    def __eq__(self,other):
        return self.digits == other.digits

    def __add__(self,b):
        res = []
        minne = 0
        a = self.digits
        b = b.digits
        for i in range(max(len(a),len(b))):
            x,y = 0,0
            if i < len(a):
                x = a[-1-i]
            if i < len(b):
                y = b[-1-i]
            summa = x+y+minne
            digit = summa % 10
            minne = summa / 10
            res.insert(0,digit)
        if minne == 1:
            res.insert(0,minne)
        return BigNum(res)

    def __mul__(self,b):
        res = BigNum([])
        a = self.digits
        for x in a:
            res.digits.append(0)
            for i in range(x):
                res = res + b
        return res

    def __pow__(self,n):
        res = BigNum([1])
        for x in range(n):
            res = res * self
        return res

assert BigNum([2]) + BigNum([3]) == BigNum([5])
assert BigNum([1,2]) + BigNum([1,9]) == BigNum([3,1])
assert BigNum([1]) + BigNum([9,9]) == BigNum([1,0,0])

assert BigNum([2]) * BigNum([3]) == BigNum([6])
assert BigNum([1,2]) * BigNum([1,9]) == BigNum([2,2,8])
x = BigNum([1,2,3,4,5,6,7,8,9])
assert str(x) == "123456789"
assert str(x * x) == "15241578750190521"

assert str(BigNum([1,2]) ** 2) == "144"

x = BigNum([2,1])
assert str(x ** 21) == "5842587018385982521381124421"

x = BigNum([2,1]) ** 99
assert len(str(x)) == 131
