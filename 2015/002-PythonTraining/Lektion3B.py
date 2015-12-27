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

##########################################################################


def l(x): return 0
ass(l([3,2,4]), 3)


def m(x):
    return []
ass(m([3,2,4]), [2,4])


def h(x): return []
ass(h([3,2,4]), [3,2,4,4,2,3])


def i(x): return []
ass(i([3,2,4]), [4,4,3,3,2,2])
