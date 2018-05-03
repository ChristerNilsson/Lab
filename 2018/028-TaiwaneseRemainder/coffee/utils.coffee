createRests = (ticks,total) -> (total % t for t in ticks)

createProblem = (steps) ->
	primes = [2,3,5,7,11,13,17,19,23,29,31,37,41,43,47,53,59,61,67,71,73,79,83,89,97]
	antal = int map steps,1,125,4,25
	ticks = _.sample primes[..antal], 2 + steps // 5
	ticks.sort (a,b) -> a-b
	#ticks = [3,5]
	total = (_.sample ticks for i in range steps).reduce (a,b)->a+b

	rests = createRests ticks,total
	h = window.location.href
	pathname = h.split('?')[0]

	url = pathname + '?steps=' + steps + '&ticks=' + ticks + '&rests=' + rests
	print url

	{steps,ticks,rests,url}

copyToClipboard = (s) -> 
	el = document.createElement 'textarea'
	el.value = s
	document.body.appendChild el
	el.select()
	document.execCommand 'copy'
	document.body.removeChild el
