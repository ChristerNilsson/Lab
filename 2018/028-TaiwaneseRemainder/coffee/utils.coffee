createRests = (ticks,total) -> (total % t for t in ticks)

createProblem = (steps) ->
	primes = [2,3,5,7,11,13,17,19]
	ticks = _.sample primes, 2 + steps // 5
	ticks.sort (a,b) -> a-b
	total = (_.sample ticks for i in range steps).reduce (a,b)->a+b

	rests = createRests ticks,total
	h = window.location.href
	pathname = h.split('?')[0]

	url = pathname
	url += '?steps=' + steps 
	url += '&ticks=' + ticks
	url += '&rests=' + rests
	print url

	{steps,ticks,rests,url}