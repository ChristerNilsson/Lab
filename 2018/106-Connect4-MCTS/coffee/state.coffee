class State 

	constructor : (@playHistory, @board, @player) ->
	isPlayer : (player) -> player == @player
	#hash : -> JSON.stringify @playHistory
	hash : -> @playHistory #.join ''
