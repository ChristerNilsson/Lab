game = null
mcts = null
state = null
winner = null

setup = ->
	createCanvas 200,200
	game = new Game()
	mcts = new MonteCarlo game
	state = game.start()
	winner = game.winner state
	computerMove()

computerMove = () ->
	mcts.runSearch state, 10 # 0.05 second
	stats = mcts.getStats state
	play = mcts.bestPlay state, "robust"
	state = game.nextState state, play
	winner = game.winner state

humanMove = () ->
	index = (mouseX-10)//20
	for i in range 6
		if state.board[i][index]==0 then row = i
	play = new Play row,index 
	state = game.nextState state, play
	winner = game.winner state

mousePressed = ->
	humanMove()
	if winner then return draw()
	computerMove()

draw = ->
	bg 0.5
	for col,i in state.board
		for item,j in col
			fc 0.5
			if item == -1 then fc 1,0,0 
			if item == +1 then fc 1,1,0
			circle 20+20*j,20+20*i,10
	if winner 
		textSize 50
		textAlign CENTER,CENTER
		fc 0
		text "winner", width/2, 0.8 * height
