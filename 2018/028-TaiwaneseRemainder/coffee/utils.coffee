createRests = (ticks,total) -> (total % t for t in ticks)

createProblem = (steps) ->
	primes = [2,3,5,7,11,13,17,19]
	ticks = _.sample primes, 2 + steps // 5
	ticks.sort (a,b) -> a-b
	total = 0
	for i in range steps
		total += _.sample ticks

	rests = createRests ticks,total

	h = window.location.href
	if '?' in h 
		pathname = h.split('?')[0]
	else
		pathname = h 

	url = pathname
	url += '?steps=' + steps 
	url += '&ticks=' + ticks
	url += '&rests=' + rests
	print url

	result = 
		steps : steps
		ticks : ticks
		rests : rests 
		url : url
	result 
