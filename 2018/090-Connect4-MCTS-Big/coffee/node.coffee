class Node 
	constructor : (@t,@n,@parent,@board) -> # t=number of wins. n=number of games
		antal++
		@children = {} # of Nodes
		for play in range N
			if @board.board[play].length < M
				@children[play] = null

	expand : (play) ->
		childBoard = @board.nextBoard play
		childNode = new Node 0,0,@,childBoard
		@children[play] = childNode
		childNode

	allPlays : -> (parseInt play for play,child of @children)
	unexpandedPlays : -> (parseInt play for play,child of @children when child == null)
	getUCB1 : -> @t / @n + Math.sqrt(UCB * Math.log(@parent.n) / @n)

	isFullyExpanded : ->
		for key,child of @children 
			if child == null then return false
		true
