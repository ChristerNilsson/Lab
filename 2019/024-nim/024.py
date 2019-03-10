import time

clock = time.perf_counter

def fib(n): return 1 if n < 2 else fib(n - 1) + fib(n - 2)

# def fib(n):
# 	a,b = 0,1
# 	for i in range(n):
# 		a,b = b,a+b
# 	return a


start = clock()
#for i in range(1000):
#z = fib(46)
#print(z)

z=0
for i in range(10000):
	z=z+1
print(z)

print(clock()-start)

