from itertools import permutations

def check_a(word, letter, indexes):
    for index in indexes:
        if word[index-1] == letter: return True
    return False

def f(s,a,b):
    count = 0
    perms = [''.join(p) for p in permutations(s)]
    for word in perms:
        ok = True
        for letter, indexes in a.iteritems():
           if check_a(word,letter,indexes)==False: ok=False
        if ok:
            okb = False
            for pair in b:
                if pair in word: okb = True
            if okb == False: ok = False
        if ok: count+=1
    return count

assert f('ABCD',{'B':[1,4]},["DC","DB"]), 6
assert f('ABC',{'B':[2]},["AC","AB"]), 1
assert f('ABCD',{'B':[2]},["AC"]), 0
assert f('ABCDEFGH',{'B':[2,5,8], 'A':[2,3,5]},["AC","AE","AF","CA","CB","CC","CD","CH"]), 918
