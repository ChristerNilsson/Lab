from itertools import permutations

def check_a(word, letter, indexes):
    for index in indexes:
        if word[index-1] == letter: return True
    return False

def check_b(word,ch1,letters):
    for ch2 in letters:
        if ch1+ch2 in word: return True
    return False

def f(s,a,b):
    count = 0
    perms = [''.join(p) for p in permutations(s)]
    for word in perms:
        ok = True
        for letter, indexes in a.iteritems():
            if check_a(word,letter,indexes)==False: ok = False
        if ok:
            for ch1,letters in b.iteritems():
                if check_b(word,ch1,letters)==False: ok = False
        if ok:
            count+=1
            # print word
    return count

# 4 2
# B@01,04
# D:CB

# import sys
# hsh1 = {}
# hsh2 = {}
# for i,line in enumerate(sys.stdin):
#     line = line.strip()
#     if i == 0:
#         arr = line.split(' ')
#         a = int(arr[0])
#         b = int(arr[1])
#         word = ''
#         for j in range(a):
#             word += chr(65+j)
#     else:
#         if '@' in line:
#             arr = line.split('@')
#             letter = arr[0]
#             arrb = arr[1].split(',')
#             numbers = []
#             for t in arrb:
#                 numbers.append(int(t))
#             hsh1[letter] = sorted(numbers)
#         elif ':' in line:
#             arr = line.split(':')
#             letter = arr[0]
#             hsh2[letter] = arr[1]
#         else:
#             print 'error'
#
# print f(word,hsh1,hsh2)

assert f('ABCD',{'B':[1]},{}) == 6
assert f('ABCD',{'B':[1,2]},{}) == 12
assert f('ABCD',{'B':[1,2,3]},{}) == 18
assert f('ABCD',{'B':[1,2,3,4]},{}) == 24
assert f('ABCD',{'B':[1,4],'C':[2,3]},{}) == 8
assert f('ABCD',{'B':[1,4],'C':[2,4]},{}) == 6

assert f('ABCD',{'B':[1,4],'C':[3,4]},{"C":"AB","D":"CB"}) == 2
# assert f('ABCD',{'B':[1,4]},{"D":"CB"}) == 6
# assert f('ABC',{'B':[2]},{"A":"CB"}) == 1
# assert f('ABC',{'B':[2]},{"A":"C"}) == 0
# assert f('ABCDEFGH',{'E':[2,5,8], 'A':[2,3,5]},{"A":"CEF","C":"ABCDH"}) == 918
