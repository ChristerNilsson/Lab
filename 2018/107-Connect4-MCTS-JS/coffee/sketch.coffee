#'use strict'

# const util = require('util')
# const Game_C4 = require('./game-c4.js')
# const MonteCarlo = require('./monte-carlo.js')

game = new Game()
mcts = new MonteCarlo(game)

state = game.start()
winner = game.winner(state)

# // Setup
setup = ->
	createCanvas 200,200
	mcts.runSearch(state, 1)
	play = mcts.bestPlay(state, "robust")
#	print mcts
#	print play
	state = game.nextState(state, play)	

# // From initial state, play games until end
dump = (board) ->
	s = ''
	for row in board
		for item in row
			if item==-1 then item=2
			s += item + ' '
		s += "\n"
	print s

draw = ->
	bg 0.5
	for row,j in state.board
		for item,i in row
			fc 0.5
			if item == -1 then fc 1,0,0
			if item == +1 then fc 1,1,0
			circle 20+20*i,20+20*j,10


mousePressed = ->
	# human move
	col = (mouseX-10) // 20
	for row in range 5,-1,-1
		if state.board[row][col] == 0 then break

	play = new Play row, col
	print play
	state = game.nextState(state, play)
	winner = game.winner(state)

	# computer move
	mcts.runSearch(state, 1)
	#print 'JSON'
	#print JSON.stringify mcts 
	#stats = mcts.getStats(state)
	play = mcts.bestPlay(state, "robust")
	state = game.nextState(state, play)
	#dump state.board
	winner = game.winner(state)
	if winner then text winner,width/2,150
