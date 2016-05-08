# -*- coding: utf-8 -*-
# https://www.youtube.com/watch?v=0Oef3MHYEC0
# Problemet handlar om att med hjälp av två kärl, 5 och 3 liter mäta upp t ex 4 liter
# Det ska också generaliseras till godtyckliga hinkstorlekar
# Starta med att fylla det första kärlet.

def ass(a, b):
    if a != b:
        print "assert misslyckades: ", " Fel: ", a, "Rätt: ", b
        assert a == b

class Water():

    directions = [00, 00, 00]
    explanations = [00, 00, 00]

    def __init__(self, a, b):
        00
        00

    def turn_hor(self,d):
        return 00

    def turn_ver(self,d):
        return 00

    def next_dir(self, x, y, d):
        if 00:
            return 00
        if 00:
            return 00

    def next_pos(self, x, y, d):
         00
         while 00:
             00
             00
         return 00

    def solve(self, target):
        00
        00
        while 00:
            00
            00
            00
        return 00

    def find_best(self, target):
        00
        00
        00
        00
        return 00 if 00 else 00

    def explain(lst):
        return 00


####################################################

water = Water(5,3)
ass(water.a, 5)
ass(water.b, 3)

ass(water.turn_hor(0), 2)
ass(water.turn_hor(2), 0)

ass(water.turn_ver(0), 1)
ass(water.turn_ver(1), 0)

ass(water.next_dir(5, 0, 1), 0)
ass(water.next_dir(0, 2, 0), 1)
ass(water.next_dir(2, 3, 0), 2)
ass(water.next_dir(2, 0, 2), 0)

ass(water.next_pos(5, 0, 0), (2, 3))
ass(water.next_pos(0, 2, 1), (5, 2))
ass(water.next_pos(2, 3, 2), (2, 0))

ass(water.explain([[5, 0, 0]]), ['a to b'])
ass(water.explain([[0, 0, 1]]), ['fill a'])
ass(water.explain([[2, 3, 2]]), ['clear b'])

water35 = Water(3,5)
water53 = Water(5,3)
ass(water35.solve(1), [[0, 0, 1], [3, 0, 0], [0, 3, 1], [3, 3, 0], [1, 5, 2]])
ass(water53.solve(1), [[0, 0, 1], [5, 0, 0], [2, 3, 2], [2, 0, 0], [0, 2, 1], [5, 2, 0], [4, 3, 2], [4, 0, 0], [1, 3, 2]])

ass(water35.solve(6), [[0, 0, 1], [3, 0, 0], [0, 3, 1]])
ass(water53.solve(6), [[0, 0, 1], [5, 0, 0], [2, 3, 2], [2, 0, 0], [0, 2, 1], [5, 2, 0], [4, 3, 2], [4, 0, 0], [1, 3, 2], [1, 0, 0], [0, 1, 1]])
ass(Water.explain(water53.solve(6)), ['fill a', 'a to b', 'clear b', 'a to b', 'fill a', 'a to b', 'clear b', 'a to b', 'clear b', 'a to b', 'fill a'])

water711 = Water(7,11)
water117 = Water(11,7)
ass(water711.solve(14), [[0, 0, 1], [7, 0, 0], [0, 7, 1]])
ass(len(water117.solve(14)), 31)

ass(water53.find_best(1), [[0, 0, 1], [3, 0, 0], [0, 3, 1], [3, 3, 0], [1, 5, 2]])
ass(water117.find_best(14), [[0, 0, 1], [7, 0, 0], [0, 7, 1]])