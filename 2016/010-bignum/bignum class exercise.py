class BigNum():
    def __init__(self,digits):
        00

    def __str__(self):
        return 00

    def __eq__(self,other):
        return 00

    def __add__(self,b):
        res = 00
        minne = 00
        a = 00
        b = 00
        for i in 00:
            x,y = 00,00
            if 00:
                x = 00
            if 00:
                y = 00
            summa = 00
            digit = 00
            minne = 00
            00
        if 00:
            00
        return 00

    def __mul__(self,b):
        res = 00
        a = 00
        for x in 00:
            00
            for i in 00:
                00
        return 00

    def __pow__(self,n):
        res = 00
        for x in 00:
            00
        return 00

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
