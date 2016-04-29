# -*- coding: utf-8 -*-

a,b = 1,256

print 'Svara < om gissningen är för liten'
print 'Svara = om gissningen är rätt'
print 'Svara > om gissningen är för stor'
print "Talen varierar mellan {0} och {1}".format(a,b)
print
svar = ''
antal = 0
while svar != '=':
    x = (a+b)/2
    antal += 1
    svar = raw_input("Jag gissar på {0} ".format(x))
    if svar == '<':
        a = x+1
    if svar == '>':
        b = x-1
print "Det krävdes {0} gissningar".format(antal)