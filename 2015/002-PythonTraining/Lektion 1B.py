# -*- coding: utf-8 -*-


def ass(a, b):
    if a != b:
        print "Assert misslyckades: ", " Fel: ", a, "Rätt: ", b
        assert a == b


# Denna fil innehåller övningar där du ska kombinera TVÅ eller fler operatorer.

##########################################################################

a = 8
ass(a, 8)        # Det gäller att a är åtta
ass(a + 2, 10)
ass(a * 2, 16)
ass(a - 2, 6)
ass(a / 2, 4)
ass(a ** 2, 64)  # upphöjt till.  8*8
ass(2 ** a, 256) #                2*2*2*2*2*2*2*2
ass(a % 2, 0)    # resten vid division med hela tal
ass(9 % 2, 1)

# Exempel:


def a(x): return 3*x+5  # Här används BÅDE multiplikation och addition
ass(a(0), 5)
ass(a(1), 8)
ass(a(2), 11)
ass(a(3), 14)

##########################################################################


def b(x): return 0
ass(b(0), 1)
ass(b(1), 3)


def c(x, y): return 0
ass(c(2, 3), 13)
ass(c(3, 4), 25)


def d(x): return 0
ass(d(1), 2)
ass(d(2), 16)
ass(d(3), 512)


def e(x): return 0
ass(e(1), 1)
ass(e(2), 3)
ass(e(3), 6)
ass(e(4), 10)


def f(x, y, z): return 0
ass(f(1, 2, 3), 123)
ass(f(2, 3, 4), 234)


def g(x, y, z): return 0
ass(g(0, 0, 0), 0)
ass(g(0, 0, 1), 1)
ass(g(1, 0, 1), 5)
ass(g(1, 1, 1), 7)


def h(x): return 0  # Använd * + / % och ()
ass(h(0), 0)
ass(h(1), 1)
ass(h(5), 101)
ass(h(7), 111)


def s(x): return 0  # allmän form: a*x*x + b*x + c. Välj a,b och c.
ass(s(2), 11)
ass(s(3), 19)
ass(s(4), 29)