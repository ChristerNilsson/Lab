clock = Date.now

fib = (n) -> if n < 2 then 1 else fib(n-1) + fib(n-2)

# fib = (n) ->
# 	[a,b] = [0,1]
# 	for i in [0..n-1]
# 		[a,b] = [b,a+b]
# 	a

start = clock()
#for i in range(1000)
z = fib 46
print z
print clock() - start