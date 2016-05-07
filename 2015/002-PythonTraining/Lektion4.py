# -*- coding: utf-8 -*-

from operator import itemgetter


def ass(a, b):
    if a != b:
        print "Assert misslyckades: "
        print " Fel: ", a
        print "Rätt: ", b
        assert a == b

##########################################################################

# En ordlista är som en lista, fast man använder namn istället för heltal som index.
# Ordlistor kan innehålla allt möjligt. T ex tal, strängar, listor och andra ordlistor.


numa     = {'name': 'Numa',     'born': 2013, 'kids': []}
kasper   = {'name': 'Kasper',   'born': 1982, 'kids': [numa]}
miranda  = {'name': 'Miranda',  'born': 1984, 'kids': []}
karolina = {'name': 'Karolina', 'born': 1995, 'kids': []}
christer = {'name': 'Christer', 'born': 1954, 'kids': [kasper, miranda, karolina]}
anneli   = {'name': 'Anneli',   'born': 1963, 'kids': []}
henning  = {'name': 'Henning',  'born': 1919, 'kids': [christer, anneli]}

all = [numa, kasper, miranda, karolina, christer, anneli, henning]

assert len(all) == 7
assert len(numa) == 3
assert all[0] == {'name': 'Numa', 'born': 2013, 'kids': []}
assert all[0]['name'] == 'Numa'
assert numa['born'] == 2013
assert len(henning['kids']) == 2
assert numa.keys() == ['born', 'kids', 'name']
assert numa.values() == [2013, [], 'Numa']
assert [person['born'] for person in all] == [2013, 1982, 1984, 1995, 1954, 1963, 1919]
assert min([person['born'] for person in all]) == 1919

##########################################################################

def born(person): return person['born']
ass(born(numa), 2013)
ass(born(karolina), 1995)

def antalBarn(person): return len(person['kids'])
ass(antalBarn(christer), 3)
ass(antalBarn(kasper), 1)

def barn(person): return person['kids']
ass(barn(christer), [kasper, miranda, karolina])
ass(barn(kasper), [numa])

def nycklar(person): return person.keys()
ass(nycklar(christer), ['born', 'kids', 'name'])
ass(nycklar(kasper), ['born', 'kids', 'name'])

def varden(person): return person.values()
ass(varden(numa), [2013, [], 'Numa'])
ass(varden(kasper), [1982, [numa], 'Kasper'])

def barnbarn(person):
    return [bb for b in barn(person) for bb in barn(b)]
ass(barnbarn(christer), [numa])
ass(barnbarn(kasper), [])


def youngest(lst):
    return max([[person['born'], person] for person in lst])[1]
ass(youngest(all), numa)

def youngest1(lst):
    lst.sort(key=lambda x: x['born'])
    return lst[-1]
ass(youngest1(all), numa)

def youngest2(lst):
    lst.sort(key=itemgetter('born'))
    return lst[-1]
ass(youngest2(all), numa)
