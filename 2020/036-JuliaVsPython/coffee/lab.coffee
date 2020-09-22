execute = ->
	primes = []
	a = 100000000
	for j in [a..a+100]
		k = 1
		i = 2
		while k != 0 and i < j
			k = j % i
			i++
		if i == j then primes.push j
	console.log primes.length

console.time 'start'
execute()
console.timeEnd 'start'
