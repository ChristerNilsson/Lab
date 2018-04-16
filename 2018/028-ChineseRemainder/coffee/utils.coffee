createRests = (ticks,path) ->
	rests = (0 for t in ticks)
	lastp = 0
	path.reverse()
	for p in path		
		for t,i in ticks
			rests[i] = (rests[i]+p-lastp) % t
		lastp = p
	path.reverse()
	rests 

createProblem = (steps) ->
	primes = [2,3,5,7,11,13,17,19]
	ticks = _.sample primes, 2 + steps // 5
	ticks.sort (a,b) -> a-b
	tree = {}
	cands = [0]
	for step in range steps 
		nextcands = []
		for cand in cands
			for item in ticks
				nextcand = cand+item
				if nextcand not in nextcands
					if nextcand not of tree 
						tree[nextcand] = cand 
						nextcands.push nextcand
		cands = nextcands 
	path = []
	total = _.sample cands
	while total > 0
		path.push total
		total = tree[total]

	rests = createRests ticks,path

	result = 
		rests : rests 
		ticks : ticks
		total : path[0]
		steps : path.length
		path : path
	result 
