# -*- coding: utf-8 -*-

# mysolver räknar ut den rekursiva formeln för en sekvens av heltal.
# Hanterar troligen alla vettiga sekvenser. (Nej, inte alla)
# Bl a hanteras [1,5,17,45,105,237,537,1229,2825] vilken blir 3*a[n-1] - 2*a[n-2] + 2*a[n-4] + 2

from sympy import *

letters = list(symbols('a b c d e f g h')) # a är äldst
a,b,c,d,e,f,g,h = letters
z = Symbol('z') # z innebär konstant

def check(solution,sequence):
    if solution==[]: return False
    n = len(solution)
    res = sum([sequence[i] * solution[letters[i]] for i in range(n-1)])
    res += solution[z]
    return res == sequence[n-1]

def checkAll(solution,sequence):
    n = len(sequence)-len(solution) + 1
    for i in range(n):
        if not check(solution,sequence[i:]): return False
    return True

def mysolver(sequence):
    for n in range(0, 1+len(sequence)/2):
        eqs = [(sum([letters[j] * sequence[i+j] for j in range(n)]) + z - sequence[n+i]) for i in range(n+1)]
        solution = solve(eqs,letters[:n]+[z])
        if checkAll(solution,sequence): return solution

def calc(sequence,solution): # next number in sequence
    m = len(sequence)
    n = len(solution)
    sequence = sequence[m-n+1:]
    res = sum([sequence[i] * solution[letters[i]] for i in range(n-1)])
    res += solution[z]
    return res

assert mysolver([1,1]) == {z: 1}
assert mysolver([2,2]) == {z: 2}
assert mysolver([1,2,3]) == {a: 1, z: 1}
assert mysolver([2,4,6]) == {a: 1, z: 2}
assert mysolver([1,2,4]) == {a: 2, z:0}
assert mysolver([2,3,5]) == {a: 2, z: -1}
assert mysolver([1,10,100]) == {a: 10, z:0}
assert mysolver([0,9,99]) == {a: 10, z: 9}
assert mysolver([1,11,111]) == {a: 10, z:1}
assert mysolver([1,1,2,3,5]) == {a: 1, b: 1, z:0}
assert mysolver([3,5,9]) == {a: 2, z: -1}
assert mysolver([1,5,17,45,105,237,537,1229,2825]) == {a: 2, b: 0, c: -2, d: 3, z: 2}
assert mysolver([4,12,28,60,132,300,692]) == {c: 3, b: -2, a: 1, z: -4}
assert calc([1,2,3],{a: 1, z: 1}) == 4
assert calc([1,1,2,3,5], {a: 1, b: 1, z:0}) == 8
assert calc([1,-2,3,-4,5], {b: -2, a: -1, z: 0}) == -6

print mysolver([1,10,11,100,101])
