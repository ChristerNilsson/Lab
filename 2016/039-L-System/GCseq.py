from sympy import *

letters = symbols('a b c d e f g h')
a,b,c,d,e,f,g,h = letters

def check(solution,sequence):
    n = len(solution)
    res = sum([sequence[i+n] * solution[letters[i]] for i in range(n)])
    return res == sequence[n+n]

def mysolver(sequence):
    for n in range(1, 1+len(sequence)/2):
        eqs = [(sum([letters[j] * sequence[i+j] for j in range(n)]) - sequence[n+i]) for i in range(n)]
        solution = solve(eqs,letters[:n])
        if check(solution,sequence): return solution

assert mysolver([1,1,1]) == {a: 1}
assert mysolver([1,2,4]) == {a: 2}
assert mysolver([1,10,100]) == {a: 10}
assert mysolver([1,11,111,1111,11111]) == {a: -10, b:11}
assert mysolver([1,2,3,4,5]) == {a: -1, b: 2}
assert mysolver([1,1,2,3,5]) == {a: 1, b: 1}
assert mysolver([1,5,17,45,105,237,537,1229,2825,6493,14905]) == {a: -2, b: 2, c: 2, d: -5, e: 4}

assert mysolver([1,3,7,15,31]) == {b: 3, a: -2}
