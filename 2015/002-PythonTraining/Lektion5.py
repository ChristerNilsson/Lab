# -*- coding: utf-8 -*-


def ass(a, b):
    if a != b:
        print "Assert misslyckades: "
        print " Fel: ", a
        print "Rätt: ", b
        assert a == b

##########################################################################

# En class innehåller både egenskaper och metoder, dvs data och kod


class Person:
    def __init__(self, name, born, kids):
        self.name = name
        self.born = born
        self.kids = kids

    def age(self):
        return 2016 - self.born

numa     = Person('Numa', 2013, [])
kasper   = Person('Kasper', 1982, [numa])
miranda  = Person('Miranda', 1984, [])
karolina = Person('Karolina', 1995, [])
christer = Person('Christer', 1954, [kasper, miranda, karolina])
anneli   = Person('Anneli', 1963, [])
henning  = Person('Henning', 1919, [christer, anneli])

all = [numa, kasper, miranda, karolina, christer, anneli, henning]

assert len(all) == 7
assert numa.name == 'Numa'
assert all[0].name == 'Numa'
assert numa.born == 2013
assert len(henning.kids) == 2
assert [person.name for person in all] == ['Numa', 'Kasper', 'Miranda', 'Karolina', 'Christer', 'Anneli', 'Henning']
assert [person.born for person in all] == [2013, 1982, 1984, 1995, 1954, 1963, 1919]
assert [person.age() for person in all] == [3, 34, 32, 21, 62, 53, 97]
assert min([person.born for person in all]) == 1919
assert [person.name for person in all if len(person.name) == 8], ['Karolina', 'Christer']
assert sorted([person.name for person in all]) == ['Anneli', 'Christer', 'Henning', 'Karolina', 'Kasper', 'Miranda', 'Numa']
assert [p.name for p in sorted(all, key=lambda (person): person.age())] == ['Numa', 'Karolina', 'Miranda', 'Kasper', 'Anneli', 'Christer', 'Henning']

##########################################################################


def born(person): return person.born
ass(born(numa), 2013)
ass(born(karolina), 1995)


def antalBarn(person): return len(person.kids)
ass(antalBarn(christer), 3)
ass(antalBarn(kasper), 1)


def namnlista(lst):
    return [person.name for person in lst]
ass(namnlista([kasper,miranda,karolina]), ['Kasper', 'Miranda', 'Karolina'])
ass(namnlista([numa]), ['Numa'])


def barn(person): return person.kids
ass(namnlista(barn(christer)), ['Kasper', 'Miranda', 'Karolina'])
ass(namnlista(barn(kasper)), ['Numa'])


def barnbarn(person):
    return [bb for b in barn(person) for bb in barn(b)]
ass(namnlista(barnbarn(christer)), ['Numa'])


def youngest(lst):
    return max([[person.born, person.name] for person in lst])
ass(youngest(all), [2013, 'Numa'])


def bornAfter(lst, year):
    return [person.name for person in lst if person.born >= year]
ass(bornAfter(all,1980), ['Numa', 'Kasper', 'Miranda', 'Karolina'])
ass(bornAfter(all,2000), ['Numa'])


def f(lst):
    return sorted([person.age() for person in lst])
ass(f(all), [3, 21, 32, 34, 53, 62, 97])


def g(lst):
    return [p.age() for p in sorted(lst, key=lambda (person): person.name)]
ass(g(all), [53, 62, 97, 21, 34, 32, 3])
