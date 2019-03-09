#? replace(sub = "\t", by = "  ")

from times import cpuTime

proc clock() : float = cpuTime()


# proc fib(n: uint64): uint64 = 
# 	if n < 2.uint64: 1.uint64 else: fib(n - 1) + fib(n - 2)

proc fib(n: int): uint64 = 
	var a,b : uint64 
	(a,b) = (1.uint64, 1.uint64)

	for i in 1..<n:
		(a,b) = (b,a+b)
	b

let start = clock()
var z : uint64
for i in 0..<100000000:
	z = fib 46
echo z
echo clock()-start