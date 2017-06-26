# 3x3, två sidor, 96 positioner. Max sex drag.

rs = null

class RS18
	constructor : () ->	@generate()

	generate : () ->
		hash = {}
		queue = []
		sq = [0,0,0,0,0,0,0,0,0,1,1,1,1,1,1,1,1,1]
		queue.push sq
		hash[sq.join ''] = 0 #['',0]
		while queue.length > 0
			square = queue.shift()
			generation = hash[square.join '']
			res = []
			res.push @gen square,[[0,15],[3,12],[6,9]]
			res.push @gen square,[[0,11],[1,10],[2,9]]
			res.push @gen square,[[2,17],[5,14],[8,11]]
			res.push @gen square,[[6,17],[7,16],[8,15]]
			for sq in res
				key = sq.join ''
				if key not in _.keys hash
					hash[key] = generation + 1 #square.join ''
					queue.push sq
		index = 0
		for key,sq of hash
			print index,key,sq
			index++
			#@pr key
		#print _.size hash

	pr : (sq) ->
		print ' '
		print sq.substring(0,3)
		print sq.substring(3,6)
		print sq.substring(6,9)
		print ' '

	gen : (square,moves) ->
		res = square.slice()
		for [i,j] in moves
			[res[i],res[j]] = [res[j],res[i]]
		res

setup = ->
	createCanvas 400,400
	rs = new RS18

