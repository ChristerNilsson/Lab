# -*- coding: utf-8 -*-

import codecs

h = {}


def ass(a, b):
    if a != b:
        print a
        print b
        assert a == b


def clean(s):
    s = s.replace('.', '')  # tag bort tusentalpunkt
    s = s.replace(',', '.')  # byt komma mot punkt
    return float(s)


def splitter(s, m=3):
    arr = s.split(' ')
    while u'SEK' in arr: arr.remove(u'SEK')
    n = len(arr)
    return ' '.join(arr[:n-m]), clean(arr[-m]), clean(arr[-m+1]), clean(arr[-m+2])
ass(splitter(u'SEB Råvaror Indexfond - Lux -3,1355 952,7300 SEK -2.987,28'), (u'SEB Råvaror Indexfond - Lux', -3.1355, 952.73, -2987.28))
ass(splitter(u'HSBC GIF Brazil Equity 671,5110 148,9178 SEK 100.000,00 100.000,00', 4), (u'HSBC GIF Brazil Equity', 671.5110, 148.9178, 100000))


def trans(s, m=3):
    arrb = splitter(s,m)
    if arrb[0] not in h: h[arrb[0]] = [0,0]
    antal, kurs = h[arrb[0]]
    antal += arrb[-3]
    kurs = arrb[-2]
    h[arrb[0]] = [antal,kurs]


def premie_placering(s):
    trans(s,4)


def fondbyte(b,d):
    trans(b)
    trans(d)


def avgifter(s):
    trans(s)


def utgaende_varde(s):
    pass

fonder = {}
with codecs.open('fonder.txt', 'r', "utf-8") as f:
    while True:
        line = f.readline()
        if not line: break
        line = line.strip()

        # Hoppa över dessa rader
        if line == '': continue
        if u"Datum Uppdrag Antal Handels- Insatt Avgift Belopp" in line: continue
        if u"Fond andelar Kurs valuta belopp" in line: continue
        if u"Byte från" in line: continue
        if u"Byte till" in line: continue

        if u"Utgående värde" in line:
            while True:
                a = f.readline().strip()
                if a == "": break
                utgaende_varde(a)
        elif u"Fondbyte" in line:
            _ = f.readline().strip()
            b = f.readline().strip()
            _ = f.readline().strip()
            d = f.readline().strip()
            fondbyte(b,d)
        elif u"Avgifter" in line:
            while True:
                a = f.readline().strip()
                if a == "": break
                avgifter(a)
        elif u"Ingående värde" in line:
            pass
        elif u"Premieplacering" in line:
            while True:
                a = f.readline().strip()
                if a == "": break
                premie_placering(a)
        else:
            print line

for key in h:
    if round(h[key][0],4) != 0.0:
        print round(h[key][0],4), h[key][1], key
