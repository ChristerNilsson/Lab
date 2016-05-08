# -*- coding: utf-8 -*-

# todo Skaffa allt underlag från SEB


def clean(s):
    s = s.replace('.', '')  # tag bort tusentalpunkt
    s = s.replace(',', '.')  # byt komma mot punkt
    return float(s)

with open('D:\\Thinkpad\\Ekonomi\\fonder.txt', 'r') as f:
    lines = f.readlines()

lines.pop(0)
fonder = {}
for line in lines:
    line = line.strip()
    if line == '':
        continue
    if line.startswith('Avgifter inkl skatt'):
        continue
    if len(line) == 10:  # datum
        datum = line
    else:
        arr = line.split('\t')
        arr = [x.strip() for x in arr if x != '']
        assert len(arr) == 4
        a,b,c,d = arr
        arr = [a, clean(b), clean(c), clean(d)]
        arr.insert(1, datum)
        key = arr[0]
        if key not in fonder.keys():
            fonder[key] = []
        fonder[key].append(arr)

for key in fonder:
    print
    print key
    total = 0.0
    lst = sorted(fonder[key])
    for item in lst:
        print item[1:]
        total += item[4]
    print total
