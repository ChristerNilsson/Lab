XOFF = 11

level = 1
balls = []
bullets = []
queue = 0
counter = 0
shot = [0,0,0]

setup = ->
	createCanvas 800,800
	textSize 600
	textAlign CENTER,CENTER
	rectMode CENTER
	newLevel 1

collisions = ->
	for bullet in bullets
		for ball in balls
			if ball.distance(bullet) < ball.radius + bullet.radius
				shot[ball.type] += 1
				bullet.age = 999999
				ball.age = 999999
	for b1 in bullets
		for b2 in bullets
			if b1 != b2 and b1.distance(b2) < 5
				b1.age = 999999
				b2.age = 999999

newLevel = (lvl) ->
	level = lvl
	if level == 0 then level = 1
	balls = []
	bullets = []
	queue = 2 * level
	counter = 0
	shot = [0,0,0]
	#bg 0.5

draw = ->
	counter += 1
	if counter % 50 == 1 and queue > 0
		queue -= 1
		balls.push new Ball 1+queue%2, width/level**0.7/10

	bg 0.5
	for ball in balls.concat bullets
		ball.draw()
	fc 1,1,1,0.05
	text level,width/2,height/2
	collisions()

	bullets = (bullet for bullet in bullets when bullet.age < 252)
	balls = (ball for ball in balls when ball.age < 1000000)

	rect XOFF,      height-5,5,5
	rect width-XOFF,height-5,5,5

	if shot[1] == level then newLevel level+1
	if shot[2] == level then newLevel level-1

keyPressed = ->
	if keyCode == LEFT_ARROW  then bullets.push new Ball 0,2, XOFF,      height-2,  3.1,-12.6
	if keyCode == RIGHT_ARROW then bullets.push new Ball 0,2, width-XOFF,height-2, -3.1,-12.6
