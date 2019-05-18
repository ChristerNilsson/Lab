from itertools import permutations

n = 8
cols = range(n)
nr=0
for p in permutations(cols):
	print(p)
for b in permutations(cols):
	if n == len(set([b[i]-i for i in cols])) == len(set([b[i]+i for i in cols])):
		nr+=1
		print(f"{nr}\n" + "\n".join('. ' * i + 'Q ' + '. ' * (n-i-1) for i in b))
