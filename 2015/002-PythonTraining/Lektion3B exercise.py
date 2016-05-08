# -*- coding: utf-8 -*-

def ass(a, b):
    if a != b:
        print "Assert misslyckades: ", " Fel: ", a, "Rätt: ", b
        assert a == b

##########################################################################

# En lista är som en hiss i ett hus.
# Startar med noll i gatuplanet, men saknar källare.
# Man använder heltal för att ange våning.
# Listor kan innehålla allt möjligt.
# T ex tal, strängar, ordlistor och andra listor.

a = []
a.append(10)
assert a == [10]

a.append(11)
assert a == [10,11]
assert a[1] == 11

a[0] = 9
assert a == [9,11]

a.insert(1,10)
assert a == [9,10,11]

del a[1]
assert a == [9,11]
assert len(a) == 2

a.append(11)
assert a == [9,11,11]
assert a.count(11) == 2
assert a.index(11) == 1

b = a.pop()
assert b == 11
assert a == [9,11]

a.remove(9)
assert a == [11]

a.extend([9,10])
assert a == [11,9,10]
assert a[::-1] == [10,9,11]
assert sorted(a) == [9,10,11]
assert 2*a == [11,9,10,11,9,10]
assert a+a == [11,9,10,11,9,10]

b = a.pop(0)
assert b == 11
assert a == [9,10]

assert [x*x for x in [2,1,3,5]] == [4,1,9,25]

##########################################################################


def l(x): return 00
ass(l([3,2,4]), 3)
ass(l([7,8]), 7)


def m(x):
    00
    return 00
ass(m([3,2,4]), [2,4])
ass(m([7,8]), [8])


def h(x): return 00
ass(h([3,2,4]), [3,2,4,4,2,3])
ass(h([7,8]), [7,8,8,7])


def i(x): return 00
ass(i([3,2,4]), [4,4,3,3,2,2])
ass(i([7,8]), [8,8,7,7])


def j(lst): return 00
ass(j([1,10,100]), [3,21,201])
ass(j([7,8]), [15,17])