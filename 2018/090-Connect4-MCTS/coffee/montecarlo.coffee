class MonteCarlo

	constructor : (@root) ->

	runSearch : (factor = 1) ->
		end = Date.now() + factor * thinkingTime 
		while Date.now() < end
			node = @select()
			if node == null then return
			winner = node.board.winner()
			if winner == null
				node = @expand node
				winner = @simulate node
			@backpropagate node, winner

	bestPlay : (node) ->
		allPlays = node.allPlays()
		bestPlay = null
		max = -Infinity
		for play in allPlays
			childNode = node.children[play]

			#ratio = childNode.t / childNode.n
			ratio = childNode.n

			if ratio > max
				bestPlay = play
				max = ratio
		bestPlay

	select : -> # väljer en nod ur trädet
		node = @root
		while node.isFullyExpanded()
			plays = node.allPlays()
			pairs = ([node.children[play].getUCB1(), play] for play in plays)
			if pairs.length==0 then return null 
			bestPlay = _.max(pairs, (pair) -> pair[0])[1]
			node = node.children[bestPlay]
		node
 
	expand : (node) -> node.expand _.sample node.unexpandedPlays() 

	simulate : (node) ->
		board = node.board
		winner = board.winner()
		while winner == null
			board = board.nextBoard _.sample board.legalPlays()
			winner = board.winner()
		winner

	backpropagate : (node, winner) ->
		while node != null
			node.n++
			if node.board.isPlayer -winner then node.t++
			node = node.parent
	
# b = new Board()
# n = new Node null,null,b
# mc = new MonteCarlo n
# mc.runSearch()
# print mc
# print mc.bestPlay mc.root
