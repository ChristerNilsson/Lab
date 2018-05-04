PRIMES = [2,3,5,7,11, 13,19,23,29,31, 37,41,43,47,53, 59,61,67,71,73, 79,83,89,97,101, 103,107,109,113,127] #,131,137,139,149,151,157,163,167,173]

createRests = (ticks,total) -> (total % t for t in ticks)

createProblem = (steps) ->
	antalPrimtal = int map steps,1,125,4,PRIMES.length
	antalPrimtal = constrain antalPrimtal,4,PRIMES.length
	antalKlockor = constrain 2 + steps // 5, 2, 125
	ticks = _.sample PRIMES[..antalPrimtal], antalKlockor
	ticks.sort (a,b) -> a-b

	# första metoden ger alltför jämnt fördelade problem.
	# total = (_.sample ticks for i in range steps).reduce (a,b)->a+b 
	# Vissa totalsummor är omöjliga att uppnå. Max 50%
	solution = null
	while solution == null
		total = _.random steps * ticks[0], steps * _.last ticks
		solution = solve ticks,total,steps

	rests = createRests ticks,total
	h = window.location.href
	pathname = h.split('?')[0]

	url = pathname + '?steps=' + steps + '&ticks=' + ticks + '&rests=' + rests
	print url

	{steps,ticks,rests,url}

solve = (ticks,sum,n) ->
	tabell = new Array sum+1
	tabell.fill null
	rad = new Array ticks.length
	rad.fill 0
	tabell[n * ticks[0]] = rad
	tabell[n * ticks[0]][0] = n
	for i in range n,sum
		rad = tabell[i]
		if rad == null then continue
		for j in range ticks.length
			if rad[j] == 0 then continue
			tj = ticks[j]
			for k in range ticks.length
				if k <= j then continue
				tk = ticks[k]
				index = i - tj + tk
				if index > sum then continue
				if tabell[index] == null
					tabell[index] = rad[..]
					tabell[index][j] -= 1
					tabell[index][k] += 1
	tabell[sum]
assert [5,1,0,0,0,4], solve [2,3,5,7,11,13],65,10

copyToClipboard = (s) -> 
	el = document.createElement 'textarea'
	el.value = s
	document.body.appendChild el
	el.select()
	document.execCommand 'copy'
	document.body.removeChild el
