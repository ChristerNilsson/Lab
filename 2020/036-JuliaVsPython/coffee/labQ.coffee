execute = ->
	primes = []
	a = 100000000
	limit = 10001
	for j in [a+1..a+10000] by 2
		prime = true
		for k in [3..limit] by 2
			if j % k == 0
				prime = false
				break
		if prime then primes.push j
	console.log primes.length

console.time 'start'
execute()
console.timeEnd 'start'
