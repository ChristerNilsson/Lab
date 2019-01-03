class Node 
	constructor : (@t,@n,@board) -> # t=number of wins. n=number of games
		@children = {}
		for play in @board.surr 
			@children[play] = null 

	expand : (play) ->
		childBoard = @board.nextBoard play
		childNode = new Node 0,0,childBoard
		@children[play] = childNode
		childNode
