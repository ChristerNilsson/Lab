# -*- coding: utf-8 -*-


def ass(a, b):
    if a != b:
        print "Assert misslyckades: ", " Fel: ", a, "Rätt: ", b
        assert a == b

##########################################################################

# En ordlista är som en lista, fast man använder bokstäver istället för siffror som index.
# Ordlistor kan innehålla allt möjligt. T ex tal, strängar, listor och andra ordlistor.


a = {}
a['name'] = 'Harald'
assert a == {'name': 'Harald'}
a['year'] = 2007
assert a == {'name': 'Harald', 'year': 2007}
assert len(a) == 2
assert a.keys() == ['name', 'year']
assert a.values() == ['Harald', 2007]
a.clear()
assert a == {}
b = {'name': 'Jenny', 'kids': ['Viktor', 'Ivar', 'Harald']}
assert b['kids'] == ['Viktor', 'Ivar', 'Harald']
del b['kids']
assert b == {'name': 'Jenny'}

##########################################################################

a = {'name': 'Mona', 'kids': ['Alfa', 'Beta']}
b = {'name': 'Jenny', 'kids': ['Viktor', 'Ivar', 'Harald']}


def f(x): return 0
ass(f(a), 2)
ass(f(b), 2)


def g(x): return ''
ass(g(a), 'Mona')
ass(g(b), 'Jenny')


def h(x): return []
ass(h(a), ['Alfa', 'Beta'])
ass(h(b), ['Viktor','Ivar','Harald'])


def i(x): return 0
ass(i(a), 2)
ass(i(b), 3)


def j(x): return []
ass(j(a), ['kids', 'name'])
ass(j(b), ['kids', 'name'])


def k(x): return []
ass(k(a), [['Alfa', 'Beta'], 'Mona'])
ass(k(b), [['Viktor', 'Ivar', 'Harald'], 'Jenny'])
