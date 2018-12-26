# N_ROWS = 6
# N_COLS = 7

# boardPrototype = ([0,0,0,0,0,0,0] for i in range N_ROWS)
# checkPrototype = ([0,0,0,0,0,0,0,0,0] for in range N_COLS)

# class Game 

# 	start : ->
# 		newBoard = boardPrototype.map (row) => row.slice()
# 		new State [], newBoard, 1

# 	legalPlays : (board) -> (col for col in range N_COLS when board[col].length < N_ROWS)

# 	nextState : (board, play) ->
# 		let newHistory = state.playHistory.slice() 
# 		newHistory.push(play)
# 		let newBoard = state.board.map((row) => row.slice())
# 		newBoard[play.row][play.col] = state.player
# 		let newPlayer = -state.player

# 		return new State(newHistory, newBoard, newPlayer)
# 	}

# 	/** Return the winner of the game. */
# 	winner(state) {

# 		// if board is full, there's no winner
# 		if (!isNaN(state.board[0].reduce(
# 			(acc, cur) => cur == 0 ? NaN : acc + cur))
# 		) return 0

# 		// one board for each possible winning run orientation
# 		let checkBoards = new Map()
# 		checkBoards.set("horiz", checkPrototype.map((row) => row.slice()))
# 		checkBoards.set("verti", checkPrototype.map((row) => row.slice()))
# 		checkBoards.set("ldiag", checkPrototype.map((row) => row.slice()))
# 		checkBoards.set("rdiag", checkPrototype.map((row) => row.slice()))

# 		// iterate over the board
# 		for (let row = 0; row < N_ROWS; row++) {
# 			for (let col = 0; col < N_COLS; col++) {
# 				let cell = state.board[row][col]
# 				for (let [key, val] of checkBoards) {

# 					// accumulator
# 					let acc // = 0
# 					switch(key) {
# 						case "horiz": acc = val[row + 1][col] // left
# 						break
# 						case "verti": acc = val[row][col + 1] // top
# 						break
# 						case "ldiag": acc = val[row][col] // top left
# 						break
# 						case "rdiag": acc = val[row][col + 2] // top right
# 						break
# 					}

# 					val[row + 1][col + 1] = cell
# 					if (cell < 0 && acc < 0 || cell > 0 && acc > 0) {
# 						val[row + 1][col + 1] += acc
# 					}
# 					if (val[row + 1][col + 1] == 4) return 1
# 					if (val[row + 1][col + 1] == -4) return -1
# 				}
# 			}
# 		}
# 		return null
# 	}

# }

# // module.exports = Game_C4
