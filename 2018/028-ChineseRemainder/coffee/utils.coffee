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
	primes = [2,3,5,7,11,13]
	ticks = _.sample primes, 1 + steps//5
	ticks.unshift 1

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
		restSum : rests.reduce (a,b) -> a+b 
	result 

# crt = (n,a) ->
# 	sum = 0
# 	prod = n.reduce (a,c) -> a*c
# 	for [ni,ai] in _.zip n,a
# 		p = prod // ni
# 		sum += ai * p * mulInv p,ni
# 	sum % prod
	
# mulInv = (a,b) ->
# 	b0 = b
# 	[x0,x1] = [0,1]
# 	if b==1 then return 1
# 	while a > 1
# 		q = a // b
# 		[a,b] = [b, a % b]
# 		[x0,x1] = [x1-q*x0, x0]
# 	if x1 < 0 then x1 += b0
# 	x1
	
# breadth first search for smallest total
# search = (n,a,total) ->
# 	tree = {}
# 	cands = [0]
# 	ready = false
# 	while not ready 
# 		nextcands = []
# 		for cand in cands
# 			for item in n
# 				nextcand = cand+item
# 				if nextcand not in nextcands
# 					if nextcand not of tree 
# 						tree[nextcand] = cand 
# 					nextcands.push nextcand
# 				if nextcand == total then ready = true  
# 		cands = nextcands 
# 	res = {1:0,7:0,13:0,17:0}
# 	lasttotal = total
# 	while total>0
# 		total = tree[total]
# 		res[lasttotal-total]++
# 		lasttotal = total
# 	res