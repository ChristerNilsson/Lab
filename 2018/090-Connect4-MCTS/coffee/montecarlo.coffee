class MonteCarlo

	constructor : (@root) ->

	runSearch : (timeout = 3) ->
		draws = 0
		totalSims = 0    

		end = Date.now() + 100 # 3 * 1000
		while Date.now() < end
			node = @select()
			winner = node.board.winner()

			if node.isLeaf() == false and winner == null
				node = @expand node
				winner = @simulate node
			
			@backpropagate node, winner

			if winner == 0 then draws++
			totalSims++
		
		{ runtime: timeout, simulations: totalSims, draws: draws }


	bestPlay : (node) ->
		allPlays = node.allPlays()
		bestPlay = null
		max = -Infinity
		for play in allPlays
			childNode = node.children[play]

			#ratio = childNode.t / childNode.n
			ratio = childNode.n
			print 'bestPlay',play,childNode.t,childNode.n,childNode.t/childNode.n

			if ratio > max
				bestPlay = play
				max = ratio
		bestPlay


	select : -> # väljer en nod ur trädet
		node = @root
		while node.isFullyExpanded() and not node.isLeaf()
			plays = node.allPlays()
			pairs = ([node.children["#{play}"].getUCB1(), play] for play in plays)
			bestPlay = _.max(pairs, (pair) -> pair[0])[1]
			node = node.children["#{bestPlay}"]
		node
 
	expand : (node) -> node.expand _.sample node.unexpandedPlays() 

	simulate : (node) ->
		board = node.board
		winner = board.winner()
		while winner == null
			board = board.nextBoard _.sample board.legalPlays()
			winner = board.winner()
		#print winner,board
		winner

	backpropagate : (node, winner) ->
		while node != null
			node.n++
			if node.board.isPlayer -winner then node.t++
			node = node.parent
	
	# getStats : (state) ->

###### tester ######

b = new Board()
n = new Node null,null,b
mc = new MonteCarlo n
mc.runSearch()
print mc
print mc.bestPlay mc.root

# assert mc.root.board.board, ['','','','','','','']
# assert mc.root.board.moves, []
#child = mc.root.children[0]
#assert child.play, 0
#assert child.board.board[0], "X"

# print 'n1'
# n1 = mc.select()
# assert n,n1
# assert n1.board.done(), false
# assert n1.isLeaf(), false
# child = mc.expand n1,0
# print child
# assert child.board.board[child.play], 'X'
# winner = mc.simulate child
# print mc,winner
# mc.backpropagate child,winner
# print mc

# print 'n2'
# n2 = mc.select()
# #assert n,n2
# #assert n1.board.done(), false
# #assert n1.isLeaf(), false
# child = mc.expand n2,0
# print child
# #assert child.board.board[child.play], 'X'
# winner = mc.simulate child
# print mc,winner
# mc.backpropagate child,winner
# print mc

