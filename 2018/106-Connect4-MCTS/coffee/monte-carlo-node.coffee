class MonteCarloNode 
	constructor : (@parent, @play, @state, unexpandedPlays) ->

		@n_plays = 0
		@n_wins = 0

		@children = {} #new Map()
		for play in unexpandedPlays
			@children[play.hash()] = { play: play, node: null }

	childNode : (play) ->
		child = @children[play.hash()]
		if child == undefined
			throw new Error 'No such play!'
		else if child.node == null
			throw new Error "Child is not expanded!"
		child.node

	expand : (play, childState, unexpandedPlays) ->
		if play.hash() not in _.keys @children then throw new Error("No such play!")
		childNode = new MonteCarloNode(@, play, childState, unexpandedPlays)
		@children[play.hash()] = { play: play, node: childNode })
		childNode

	allPlays : -> (child.play for child in @children)

	unexpandedPlays : -> (child.play for child in @children when child.node == null)
		# ret = []
		# @children.forEach (child, key) => if child.node == null then ret.push child.play
		# ret

	isFullyExpanded : -> (child.play for child in @children when child.node).length == @children.length
		# ret = true
		# @children.forEach (child, key) => if child.node == null then ret = false
		# ret

	isLeaf : -> @children.length == 0 
	
	getUCB1 : (biasParam) -> @n_wins / @n_plays + Math.sqrt(biasParam * Math.log(@parent.n_plays) / @n_plays)
