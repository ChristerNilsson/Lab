class Player
	constructor : (@nr, @x,@y, @w,@h, @up,@down) ->
		@dy = 0
		@score = 0

	update : (dt) ->
		y = @y + @dy * dt
		@y = if @dy < @h/2 then max @h/2, y else min HEIGHT - @h/2, y

	handleKey : ->
		@dy = 0
		if keyIsDown @up then	@dy = -PADDLE_SPEED
		if keyIsDown @down then	@dy = PADDLE_SPEED

	render : -> rect @x, @y, @w, @h

	checkCollision : (ball,dx) ->
		if ball.collides @
			ball.dx *= -1.03
			ball.x = @x + dx
			ball.dy = if ball.dy < 0 then -random 10, 150 else random 10, 150

	incr : (sp) ->
		game.servingPlayer = sp
		@score++
		if @score == 10 
			game.winningPlayer = @nr
			game.gameState = 'done'
		else
			game.gameState = 'serve'
			game.ball.reset()
