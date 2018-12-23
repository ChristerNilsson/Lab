class State 
	constructor : (@playHistory, @board, @player) ->
	isPlayer : (player) -> player == @player
	hash : -> @playHistory
