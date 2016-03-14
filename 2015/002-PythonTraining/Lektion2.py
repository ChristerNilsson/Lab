# -*- coding: utf-8 -*-


def ass(a, b):
    if a != b:
        print "Assert misslyckades: ", " Fel: ", a, "Rätt: ", b
        assert a == b

##########################################################################

# Strängar kan innehålla vilka tecken som helst.
# Måste avgränsas med fnutt (') eller dubbelfnutt (").

a = "harald"
assert len(a) == 6
assert a[0] == 'h'
assert a[-1] == 'd'
assert a[1:3] == 'ar'
assert a[0:6:2] == 'hrl'
assert a[::-1] == 'dlarah'
assert list('harald') == ['h','a','r','a','l','d']
assert sorted(a) == ['a', 'a', 'd', 'h', 'l', 'r']
assert a + a == 'haraldharald'
assert 2 * a == 'haraldharald'

assert a.capitalize() == 'Harald'
assert a.count('a') == 2
assert a.startswith('h') == True
assert a.endswith('ld')
assert a.index('a') == 1
assert a.rindex('a') == 3
lst = ['adam','bertil']
assert ' '.join(lst) == 'adam bertil'
assert a.replace('a','*') == 'h*r*ld'
assert 'adam bertil'.split(' ') == ['adam','bertil']
assert ' ivar '.strip() == 'ivar'
assert a.upper() == 'HARALD'

##########################################################################


def f(x): return 00
ass(f('pelle'), 'Pelle')


def g(x): return 00
ass(g('pelle'), 'PELLE')


def h(x): return 00
ass(h('viktor'), 'k')


def i(x): return 00
ass(i('viktor'), 'kt')


def j(x): return 00
ass(j('rotkiv'), 'viktor')


def k(x): return 00
ass(k('christer nilsson'), ['chr','ster n','lsson'])


def l(a,b,c): return 00
ass(l('christer nilsson','i','#'), 'chr#ster n#lsson')
