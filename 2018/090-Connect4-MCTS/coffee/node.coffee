class Node 
	constructor : (@parent, @play, @board) ->
		@t = 0 # number of wins
		@n = 0 # number of games
		@children = {} # of Nodes
		for play in range N
			if @board.board[play].length < M
				@children[play] = null

	expand : (play) ->
		childBoard = @board.nextBoard play
		childNode = new Node @, play, childBoard
		@children[play] = childNode
		childNode

	allPlays : -> (parseInt play for play,child of @children)
	unexpandedPlays : -> (parseInt play for play,child of @children when child == null)
	getUCB1 : -> (@t / @n) + Math.sqrt(2 * Math.log(@parent.n) / @n)

	isFullyExpanded : ->
		for key,child of @children 
			if child == null then return false
		true
