class MonteCarloNode 
	constructor : (@parent, @play, @state, unexpandedPlays) ->

		@n_plays = 0
		@n_wins = 0

		@children = new Map()
		for play in unexpandedPlays
			@children.set play.hash(), { play: play, node: null }

	childNode : (play) ->
		child = @children.get play.hash()
		if child == undefined
			throw new Error 'No such play!'
		else if child.node == null
			throw new Error "Child is not expanded!"
		child.node

	expand : (play, childState, unexpandedPlays) ->
		if (!@children.has(play.hash())) then throw new Error("No such play!")
		childNode = new MonteCarloNode(@, play, childState, unexpandedPlays)
		@children.set(play.hash(), { play: play, node: childNode })
		childNode

	allPlays : ->
		ret = []
		@children.forEach (child, key) => ret.push child.play
		ret

	unexpandedPlays : ->
		ret = []
		@children.forEach (child, key) => if child.node == null then ret.push child.play
		ret

	isFullyExpanded : ->
		ret = true
		@children.forEach (child, key) => if child.node == null then ret = false
		ret

	isLeaf : -> @children.size == 0 
	
	getUCB1 : (biasParam) -> @n_wins / @n_plays + Math.sqrt(biasParam * Math.log(@parent.n_plays) / @n_plays)
