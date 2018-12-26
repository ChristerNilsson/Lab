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
	#isLeaf : -> false
		# antal = 0
		# for child in @children 
		# 	if child == null then antal++
		# antal == @children.length

	isFullyExpanded : ->
		for key,child of @children 
			if child == null then return false
		true
	
	getUCB1 : -> (@t / @n) + Math.sqrt(2 * Math.log(@parent.n) / @n)

###### tester ######

# b = new Board '333333'
# n = new Node null,null,b,[0,1,2,4,5,6]
# assert n.parent, null
# assert n.play, null
# assert n.board.board.length, N
# assert n.children, {0:null, 1:null, 2:null, 4:null, 5:null, 6:null}

# assert n.isLeaf(), false
# child = n.expand 2
# print n
# assert child.board.board[2], 'X'
# assert child.board.board[3], 'XOXOXO'
# assert child.n, 0
# assert child.parent, n
# assert child.play, 2
# assert child.t, 0
# assert n.isLeaf(), false
# assert child.isLeaf(), false
# assert n.allPlays(),[0, 1, 2, 4, 5, 6]
# assert n.unexpandedPlays(),[0, 1, 4, 5, 6]
# assert n.isFullyExpanded(),false
# for play in n.unexpandedPlays()
# 	n.expand parseInt play 
# assert n.unexpandedPlays(),[]
# assert n.isFullyExpanded(),true 

# child.t = 1
# child.n = 2
# grandChild = child.expand 4
# assert grandChild.isLeaf(), false 
# grandChild.t = 1
# grandChild.n = 2
# assert 1.3325546111576978, grandChild.getUCB1()
