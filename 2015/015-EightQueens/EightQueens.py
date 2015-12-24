from itertools import permutations

n = 8
cols = range(n)
for b in permutations(cols):
    if n == len(set([b[i]-i for i in cols])) == len(set([b[i]+i for i in cols])):
        print "\n" + "\n".join('. ' * i + 'Q ' + '. ' * (n-i-1) for i in b)