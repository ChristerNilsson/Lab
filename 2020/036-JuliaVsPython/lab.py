import time
import math

def execute():
	primes = []
	a = 100000000
	for j in range(a,a+100):
		i=2
		k=1
		while k!=0 and i<j:
			k=j%i
			i+=1
		if i==j:
			primes.append(i)
	print(len(primes))

start = time.time()
execute()
print(time.time()-start)
