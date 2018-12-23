N_ROWS = 6
N_COLS = 7

boardPrototype = ([0,0,0,0,0,0,0] for i in range N_ROWS)
checkPrototype = ([0,0,0,0,0,0,0,0,0] for i in range N_COLS)

class Game

	start : () ->
		newBoard = boardPrototype.map (row) => row.slice()
		new State [], newBoard, 1

	legalPlays : (state) ->
		res = []
		for col in range N_COLS
			for row in range N_ROWS-1, -1, -1
				if state.board[row][col] == 0
					res.push new Play row, col
					break
		res

	nextState : (state, play) ->
		newHistory = state.playHistory + play.col 
		newBoard = state.board.map (row) => row.slice()
		newBoard[play.row][play.col] = state.player
		newPlayer = -state.player
		new State newHistory, newBoard, newPlayer

	winner : (state) ->

		res = 0
		for item in state.board[0] 
			if item == 0 then res++
		if res == 0 then return 0

		checkBoards = ((checkPrototype.map (row) => row.slice()) for i in range 4)

		for row in range N_ROWS
			for col in range N_COLS
				cell = state.board[row][col]
				for val,i in checkBoards 
					[dr,dc] = [[1,0],[0,1],[0,0],[0,2]][i]
					acc = val[row+dr][col+dc]
					val[row + 1][col + 1] = cell
					if cell < 0 and acc < 0 or cell > 0 and acc > 0
						val[row + 1][col + 1] += acc
					
					if val[row + 1][col + 1] == 4 then return 1
					if val[row + 1][col + 1] == -4 then return -1
		null

