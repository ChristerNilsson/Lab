level = 1
balls = []
bullets = []
queue = 0
counter = 0
shot = [0,0,0]

setup = ->
	createCanvas 800,800
	newLevel 1

collisions = ->
	for bullet in bullets
		for ball in balls
			if ball.distance(bullet) < ball.radius + bullet.radius
				shot[ball.type] += 1
				bullet.age = 999999
				ball.age = 999999

newLevel = (lvl) ->
	level = lvl
	if level == 0 then level = 1
	balls = []
	bullets = []
	queue = 2 * level
	counter = 0
	shot = [0,0,0]

draw = ->
	counter += 1
	if counter % 50 == 1 and queue > 0
		queue -= 1
		balls.push new Ball 1+queue%2, width/level**0.7/10

	bg 0.5
	fc 0
	sw 5
	line 0,height, 3,height-10
	sw 1
	for ball in balls.concat bullets
		ball.draw()
	collisions()
	bullets = (bullet for bullet in bullets when bullet.age < 250)
	balls = (ball for ball in balls when ball.age < 1000000)
	t1 = (ball for ball in balls when ball.type == 1)
	t2 = (ball for ball in balls when ball.type == 2)
	if shot[1] == level then newLevel level+1
	if shot[2] == level then newLevel level-1

keyPressed = ->
	bullets.push new Ball 0,2, 2,height-2, 3.2,-12.6
