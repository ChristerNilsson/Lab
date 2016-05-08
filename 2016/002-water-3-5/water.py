# -*- coding: utf-8 -*-
# https://www.youtube.com/watch?v=0Oef3MHYEC0
# Problemet handlar om att med hjälp av två kärl, 5 och 3 liter mäta upp 4 liter
# Det ska också generaliseras.
# a och b får inte ha några gemensamma delare.
# starta med att fylla det första kärlet.

import time

class Water():

    directions = [[-1,1], [1,0], [0,-1]]
    explanations = ['a to b', 'fill a', 'clear b']

    def __init__(self, a, b):
        self.a = a
        self.b = b
        if Water.gcd(a,b) != 1:
            print 'impossible:',a,b

    @staticmethod
    def gcd(a, b):
        return b if (a-b) == 0 else Water.gcd(abs(a-b), min(a, b))

    def turn_hor(self,d):
        return 2-d

    def turn_ver(self,d):
        return 1-d

    def next_dir(self, x, y, d):
        if x in [0, self.a]:
            return self.turn_ver(d)
        if y in [0, self.b]:
            return self.turn_hor(d)

    # def next_pos(self, x, y, d):
    #     dx, dy = Water.directions[d]
    #     while 0 <= x <= self.a and 0 <= y <= self.b:
    #         x += dx
    #         y += dy
    #     return [x-dx, y-dy]

    def next_pos(self, x, y, d):  # executes 4028/18.1 = 222 times faster than while-version
        a,b = self.a,self.b
        if d == 0:
            if a > b:
                if y > 0:
                    return x + y - b, b
                elif x <= b:
                    return 0, x  # A
                return x-b, y+b
            else:
                if y == 0:  # A
                    return 0, x
                elif y >= b - a:  # B
                    return x + y - b, b
                return x-a, y+a
        elif d == 1:
            return a, y
        elif d == 2:
            return x, 0

    def solve(self, target):
        lst = [[0, 0, 1]]
        x, y, d = self.a, 0, 0
        while x+y != target:
            lst.append([x, y, d])
            x, y = self.next_pos(x, y, d)
            d = self.next_dir(x, y, d)
        return lst

    def find_best(self, target):
        self.a,self.b = self.b,self.a
        ab = self.solve(target)
        self.a,self.b = self.b,self.a
        ba = self.solve(target)
        return ab if len(ab) < len(ba) else ba

    @staticmethod
    def explain(lst):
        return [Water.explanations[i] for _, _, i in lst]

water = Water(5,3)

assert water.turn_hor(0) == 2
assert water.turn_hor(2) == 0

assert water.turn_ver(0) == 1
assert water.turn_ver(1) == 0

assert water.next_dir(5, 0, 1) == 0
assert water.next_dir(0, 2, 0) == 1
assert water.next_dir(2, 3, 0) == 2
assert water.next_dir(2, 0, 2) == 0

assert water.next_pos(5, 0, 0) == (2, 3)
assert water.next_pos(0, 2, 1) == (5, 2)
assert water.next_pos(2, 3, 2) == (2, 0)

assert water.explain([[5, 0, 0]]) == ['a to b']
assert water.explain([[0, 0, 1]]) == ['fill a']
assert water.explain([[2, 3, 2]]) == ['clear b']

water35 = Water(3,5)
water53 = Water(5,3)
assert water35.solve(1) == [[0, 0, 1], [3, 0, 0], [0, 3, 1], [3, 3, 0], [1, 5, 2]]
assert water53.solve(1) == [[0, 0, 1], [5, 0, 0], [2, 3, 2], [2, 0, 0], [0, 2, 1], [5, 2, 0], [4, 3, 2], [4, 0, 0], [1, 3, 2]]

assert water35.solve(6) == [[0, 0, 1], [3, 0, 0], [0, 3, 1]]
assert water53.solve(6) == [[0, 0, 1], [5, 0, 0], [2, 3, 2], [2, 0, 0], [0, 2, 1], [5, 2, 0], [4, 3, 2], [4, 0, 0], [1, 3, 2], [1, 0, 0], [0, 1, 1]]
assert Water.explain(water53.solve(6)) == ['fill a', 'a to b', 'clear b', 'a to b', 'fill a', 'a to b', 'clear b', 'a to b', 'clear b', 'a to b', 'fill a']

water711 = Water(7,11)
water117 = Water(11,7)
assert water711.solve(14) == [[0, 0, 1], [7, 0, 0], [0, 7, 1]]
assert len(water117.solve(14)) == 31

assert water53.find_best(1) == [[0, 0, 1], [3, 0, 0], [0, 3, 1], [3, 3, 0], [1, 5, 2]]
assert water117.find_best(14) == [[0, 0, 1], [7, 0, 0], [0, 7, 1]]

assert Water.gcd(6,15) == 3 and Water.gcd(15,6) == 3 and Water.gcd(3,5) == 1 and Water.gcd(5,3) == 1

start = time.clock()
assert len(Water(9999, 8887).find_best(3)) == 12601  # 50 ms
print time.clock() - start