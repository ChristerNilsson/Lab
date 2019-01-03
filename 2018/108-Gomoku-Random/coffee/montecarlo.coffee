TRACE = true

class MonteCarlo

	constructor : (@root) ->

	runSearch : (factor = 1) ->
		for b in @root.board.surr
			@root.expand b

		end = Date.now() + factor * thinkingTime 
		while Date.now() < end
		#for i in range 500
			for move,child of @root.children
				winner = @simulate child
				child.n++
				if winner == 1 then child.t++

	bestPlay : (node) ->
		pairs = ([child.t, move] for move,child of node.children)
		if pairs.length == 0 
			print 'Problem in bestPlay'
			return null 
		pair = _.max(pairs, (pair) -> pair[0])
		pair[1]

	simulate : (node) ->
		antal++
		board = node.board.copy()
		winner = board.winner()
		while winner == null
			board.move _.sample board.surr
			winner = board.winner()
		winner
