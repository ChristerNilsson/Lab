# -*- coding: utf-8 -*-

# Från Svenska Dagbladet.
# Givet nio bokstäver, bilda alla svenska ord mellan 4 och 9 bokstäver långa.
# Tillåtna ord ges av filen ord.txt med 116236 ord.

# Läs in filen
# Ange de nio bokstäverna.
# Visa alla bildade ord

# Tricket är att använda heltal där varje bit anger en bokstav.
# Genom att snabbt gå igenom en sådan lista erhålles kandidater.
# Därefter sker gallring, det kan finnas kandidater som ska bort pga dubletter.
# Exempel: abba => 1+2 = 3

from collections import Counter as mset

LETTERS = 'abcdefghijklmnopqrstuvwxyzåäö'

def bitify(word):
    pattern = 0
    for ch in word:
        pattern |= 1 << LETTERS.index(ch)
    return pattern

def read_file():
    hash = {}
    with open('ord.txt') as f:
        for word in f.readlines():
            word = word.strip()
            if 4 <= len(word) <= 9:
                hash[word] = bitify(word)
    return hash

def find_words(letters):
    res = []
    bits = bitify(letters)
    for key in hash:
        if letters[4] not in key:
            continue
        if hash[key] & bits == hash[key]:
            a = mset(key)
            b = mset(letters)
            if a & b == a:
                res.append(key)
    return sorted(res)

hash = read_file()

assert find_words('abalorsst') == ['abort', 'albatross', 'alrot', 'aorta', 'asatro', 'barstol', 'bloss', 'blossa', 'blot', 'blota', 'bola', 'borst', 'borsta', 'bort', 'borta', 'boss', 'bota', 'broa', 'brossla', 'lasso', 'lort', 'lorta', 'loss', 'lossa', 'losta', 'lots', 'lotsa', 'oart', 'oblat', 'olat', 'oral', 'osta', 'otal', 'rosa', 'rossla', 'rost', 'rosta', 'rota', 'rots', 'sola', 'solar', 'sorb', 'sorl', 'sorla', 'sort', 'sota', 'stol', 'stola', 'stor', 'strosa', 'tosa', 'tossa', 'trosa', 'tross']
assert find_words('aaekllnrt') == ['alert', 'alka', 'alla', 'alle', 'allena', 'allra', 'allt', 'altan', 'altare', 'altea', 'alter', 'anal', 'ankel', 'antal', 'areal', 'arla', 'earl', 'elak', 'elan', 'enkla', 'ental', 'kall', 'kalla', 'kallna', 'kalna', 'kanal', 'kanel', 'kantarell', 'karel', 'karl', 'kartell', 'kela', 'klan', 'klant', 'klanta', 'klar', 'klara', 'klarna', 'klen', 'klena', 'klet', 'kleta', 'knal', 'knall', 'knalla', 'knalle', 'kraal', 'kral', 'kralla', 'laka', 'lakan', 'lake', 'lala', 'lana', 'laner', 'lank', 'lanka', 'lata', 'later', 'lateral', 'leka', 'lekt', 'lena', 'lera', 'leta', 'letal', 'nalla', 'nalle', 'rall', 'ralla', 'real', 'tala', 'talan', 'talar', 'talare', 'talk', 'talka', 'tall', 'teln', 'trala', 'trall', 'tralla']