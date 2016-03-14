# -*- coding: utf-8 -*-


def ass(a, b):
    if a != b:
        print "Assert misslyckades: ", " Fel: ", a, "Rätt: ", b
        assert a == b

##############################################################################

# I Python är allting objekt.
# Heltal, strängar, listor och ordlistor är exempel på objekt.
# En variabel är som en namnlapp på ett objekt.
# Ett objekt kan ha flera namnlappar samtidigt.
# Varje namnlapp förekommer bara en gång.

a = 7      # a tilldelas värdet sju. Namnlappen "a" sätts på sjuan.
a = a + 1  # a tilldelas värdet av x plus ett. "a" flyttas från sjuan till åttan.
b = a      # Både a och b sitter på åttan.

ass(a, 8)        # Det gäller att a är åtta
ass(a + 2, 10)
ass(a * 2, 16)
ass(a - 2, 6)
ass(a / 2, 4)
ass(a ** 2, 64)  # upphöjt till.  8*8
ass(2 ** a, 256) #                2*2*2*2*2*2*2*2
ass(a % 2, 0)    # resten vid division med hela tal
ass(9 % 2, 1)

# En funktion är som en maskin.
# Man stoppar in en eller flera parametrar och får ut ett eller flera resultat.
# T ex f(x)=x+2. x är enda inparametern och x+2 är resultatet.


def f(x): return x+2   # Skapa f(x) = x + 2
assert f(8) == 10      # Det gäller att f av åtta är tio
assert f(9) == 11      # Det gäller att f av nio är elva

##############################################################################

# Klicka på första länken i felmeddelandet så kommer du till problemraden!


def e(x): return 00   # byt nollan mot något annat så att ass nedan stämmer.
ass(e(5), 5)
ass(e(-3), -3)


def g(x): return 00
ass(g(5), -5)
ass(g(-3), 3)


def h(x): return 00
ass(h(3), 9)
ass(h(4), 16)


def i(x): return 00
ass(i(3), 8)
ass(i(4), 16)


def j(x): return 00
ass(j(3), 1)
ass(j(4), 0)


def k(x): return 00
ass(k(7), 14)
ass(k(8), 16)


def m(x): return 00
ass(m(10), 5)
ass(m(8),4)


def n(x): return 00
ass(n(1), 3)
ass(n(2), 5)


# Observera: nu använder vi två parametrar: x och y.


def o(x, y): return 00
ass(o(4, 5), 9)
ass(o(2, 3), 5)


def p(x, y): return 00
ass(p(4, 5), 20)
ass(p(2, 3), 6)


def q(x, y): return 00
ass(q(8, 4), 2)
ass(q(10, 5), 2)


def r(x, y): return 00
ass(r(2, 3), 8)
ass(r(3, 2), 9)
