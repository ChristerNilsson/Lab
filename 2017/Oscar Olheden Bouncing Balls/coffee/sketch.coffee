
balls=[]
setup = ->
	createCanvas 400,400
	for i in range 10
		createBall 0
		createBall 1

createBall =(g) ->
	ball = {}
	ball.x = 50+300 * Math.random()
	ball.y = 50
	ball.radie = 50
	ball.vx = -2+4*Math.random()
	ball.vy = -2+4*Math.random()
	ball.g = g
	balls.push ball

draw = ->
	bg 0.5
	sc 0,0,1
	for ball in balls
		fc 1,ball.g,0 

		circle ball.x,ball.y,ball.radie

		if (ball.x + ball.radie > width) or  (ball.x - ball.radie < 0) 
			ball.vx = -ball.vx

		ball.x = ball.x+ball.vx

		if (ball.y + ball.radie > width) or (ball.y - ball.radie < 0) 
			ball.vy = -ball.vy
		else
			ball.vy = ball.vy+1
		ball.y += ball.vy
