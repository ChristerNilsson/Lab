class MonteCarlo 
	constructor : (game, UCB1ExploreParam = 2) ->
		@game = game
		@UCB1ExploreParam = UCB1ExploreParam
		@nodes = new Map() 

	makeNode : (state) ->
		if !@nodes.has state.hash()
			unexpandedPlays = @game.legalPlays(state).slice()
			node = new MonteCarloNode null, null, state, unexpandedPlays
			@nodes.set state.hash(), node

	runSearch : (state, timeout = 3) ->

		@makeNode state

		draws = 0
		totalSims = 0
		
		end = Date.now() + timeout * 1000
		while Date.now() < end

			node = @select state
			winner = @game.winner node.state

			if node.isLeaf() == false and winner == null
				node = @expand node
				winner = @simulate node
			
			@backpropagate node, winner

			if winner == 0 then draws++
			totalSims++
		
		{ runtime: timeout, simulations: totalSims, draws: draws }

	bestPlay : (state, policy = "robust") ->

		@makeNode state

		print 'state.hash',state.hash()
		print 'nodes',@nodes

		if @nodes.get(state.hash()).isFullyExpanded() == false
			throw new Error "Not enough information!"

		node = @nodes.get state.hash()
		allPlays = node.allPlays()
		bestPlay = null

		if policy == "robust"
			max = -Infinity
			for play in allPlays
				childNode = node.childNode play
				if childNode.n_plays > max
					bestPlay = play
					max = childNode.n_plays

		else if policy == "max"
			max = -Infinity
			for play in allPlays
				childNode = node.childNode play
				ratio = childNode.n_wins / childNode.n_plays
				if ratio > max
					bestPlay = play
					max = ratio

		return bestPlay

	select : (state) ->
		node = @nodes.get state.hash()
		while node.isFullyExpanded() && !node.isLeaf()
			plays = node.allPlays()
			bestPlay = null
			bestUCB1 = -Infinity
			for play in plays
				childUCB1 = node.childNode(play).getUCB1 @UCB1ExploreParam
				if childUCB1 > bestUCB1
					bestPlay = play
					bestUCB1 = childUCB1
			node = node.childNode bestPlay
		return node

	expand : (node) ->

		plays = node.unexpandedPlays()
		index = Math.floor Math.random() * plays.length
		play = plays[index]

		childState = @game.nextState node.state, play
		childUnexpandedPlays = @game.legalPlays childState
		childNode = node.expand play, childState, childUnexpandedPlays
		@nodes.set childState.hash(), childNode

		return childNode

	simulate : (node) ->

		state = node.state
		winner = @game.winner state

		while winner == null
			plays = @game.legalPlays state
			play = plays[Math.floor Math.random() * plays.length]
			state = @game.nextState state, play
			winner = @game.winner state

		return winner

	backpropagate : (node, winner) ->

		while node != null
			node.n_plays++
			if node.state.isPlayer -winner then node.n_wins++
			node = node.parent

	getStats : (state) ->
		node = @nodes.get state.hash()
		stats = { n_plays: node.n_plays, n_wins: node.n_wins, children: [] }
		for child of node.children.values() 
			if child.node == null then stats.children.push { play: child.play, n_plays: null, n_wins: null}
			else stats.children.push { play: child.play, n_plays: child.node.n_plays, n_wins: child.node.n_wins}
		return stats
