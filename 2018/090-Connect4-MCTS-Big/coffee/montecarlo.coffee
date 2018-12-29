TRACE = true

class MonteCarlo

	constructor : (@root) ->

	dump : (node,key='',level='*') ->
		print level,key,"t:#{node.t}", "n:#{node.n}", "moves:#{JSON.stringify node.board.moves}", "board:#{JSON.stringify node.board.board}"
		for child,key in node.children
			if child != null then @dump child,key,level + '|' 

	runSearch : (factor = 1) ->
		end = Date.now() + factor * thinkingTime 
		while Date.now() < end

			# if TRACE
			# 	print ''
			# 	print montecarlo
			# 	@dump montecarlo.root
			node = @select()

			if node == null then return
			winner = node.board.winner()
			if winner == null
				node = @expand node
				winner = @simulate node
			@backpropagate node, winner

		print ''
		#print montecarlo
		#@dump montecarlo.root

	bestPlay : (node) ->
		pairs = ([node.children[play].n, play] for play in node.allPlays())
		if pairs.length == 0 
			print 'Problem in bestPlay'
			return null 
		res = _.max(pairs, (pair) -> pair[0])[1]
		lst = JSON.stringify (a for [a,b] in pairs)
		if TRACE then print 'bestPlay', res, lst
		res

	select : -> # väljer en nod ur trädet
		node = @root
		while node.isFullyExpanded()
			plays = node.allPlays()
			pairs = ([node.children[play].getUCB1(), play] for play in plays)
			if pairs.length==0 then return null 
			bestPlay = _.max(pairs, (pair) -> pair[0])[1]
			node = node.children[bestPlay]
			# if TRACE then print 'selecting',JSON.stringify(node.board.moves), pairs
		# if TRACE then print 'selected',JSON.stringify node.board.moves
		node
 
	expand : (node) -> 
		randomNode = _.sample node.unexpandedPlays()  
		# if TRACE then print 'expand chooses',JSON.stringify randomNode
		node.expand randomNode

	simulate : (node) ->
		board = node.board
		winner = board.winner()
		while winner == null
			board = board.nextBoard _.sample board.legalPlays()
			winner = board.winner()
		# if TRACE then print 'simulate',winner,"#{JSON.stringify node.board.moves}",board.board,board.moves
		winner

	# Anderson & Hesselberg 2016
	backpropagate : (node, score) -> # score in [0, 0.5, 1]
		while node != null
			node.n++
			node.t += [score,1-score][node.board.moves.length % 2]
			node = node.parent
	