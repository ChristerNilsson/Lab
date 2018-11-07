PADDLE_SPEED = 200
WIDTH = 432
HEIGHT = 243

game = null

class Game
	constructor : ->
		@player1 = new Player 1, 5,10, 5,20, 87,83
		@player2 = new Player 2, WIDTH-5,HEIGHT-10, 5,20, UP_ARROW,DOWN_ARROW
		@ball = new Ball WIDTH/2,HEIGHT/2, 4,4
		@gameState = 'start'
		@servingPlayer = 1
		@winningPlayer = 0

	draw : ->
		scale 4
		bg 0.25

		@update 1/60

		textAlign CENTER,CENTER
		textSize 12
		fc 1
		sc()
		
		if @gameState == 'start' then @text2 12,'Welcome to Pong!',                'Press Enter to begin!'
		if @gameState == 'serve' then @text2 12,"Player #{@servingPlayer}'s serve!",'Press Enter to serve!'
		if @gameState == 'done'  then @text2 16,"Player #{@winningPlayer} wins!",   'Press Enter to restart!'

		@displayScore()
		
		@player1.render()
		@player2.render()
		@ball.render()

	text2 : (textsize, t1, t2) ->
		textSize textsize
		text t1, WIDTH/2, 10
		text t2, WIDTH/2, 2*textsize

	displayScore : ->
		textSize 20
		text @player1.score, WIDTH/2-40, HEIGHT/3
		text @player2.score, WIDTH/2+40, HEIGHT/3

	update : (dt) ->
		if @gameState == 'serve' 
			@ball.dy = random -50, 50
			if @servingPlayer == 1
				@ball.dx = random 140, 200
			else
				@ball.dx = -random 140, 200
		else if @gameState == 'play'
			@player1.checkCollision @ball,5
			@player2.checkCollision @ball,-4

			if @ball.y <= 0          then @ball.bounce 0
			if @ball.y >= HEIGHT - 4 then @ball.bounce HEIGHT-4

			if @ball.x > WIDTH then @player1.incr 1
			if @ball.x < 0     then @player2.incr 2

		@player1.handleKey()
		@player2.handleKey()

		if @gameState == 'play' then @ball.update dt

		@player1.update dt
		@player2.update dt

	keyPressed : ->
		if keyCode == ENTER or keyCode == RETURN 
			if @gameState == 'start' 
				@gameState = 'serve'
			else if @gameState == 'serve' 
				@gameState = 'play'
			else if @gameState == 'done' 
				@gameState = 'serve'
				@ball.reset()
				@player1.score = 0
				@player2.score = 0
				@servingPlayer = 3 - @winningPlayer

setup = ->
	createCanvas 4*WIDTH,4*HEIGHT
	rectMode CENTER
	game = new Game()

keyPressed = -> game.keyPressed()

draw = -> game.draw()
