XOFF = 11
N = 50

ai = false
level = 1
balls = []
bullets = []
queue = 0
counter = 0
shot = [0,0]
fCount = 0

setup = ->
	createCanvas 800,830
	textSize 600
	textAlign CENTER,CENTER
	rectMode CENTER
	newLevel 1

collisions = (balls, bullets, shot) ->
	for bullet in bullets
		for ball in balls
			di = ball.distance bullet
			if di < ball.radius + bullet.radius
				shot[ball.g] += 1
				bullet.age = 999999
				ball.age = 999999
				return shot

	for b1 in bullets
		for b2 in bullets
			if b1 != b2 and b1.distance(b2) < 5
				b1.age = 999999
				b2.age = 999999
	return shot

newLevel = (lvl) ->
	level = lvl
	if level == 0 then level = 1
	balls = []
	bullets = []
	queue = 2 * level
	counter = 0
	shot = [0,0]
	fCount = frameCount

simulate = (balls, bullets, shot) ->

	#pressLeft bullets
	pressRight bullets

	for i in range N

		ball.update() for ball in balls
		bullet.update() for bullet in bullets

		[r,y] = shot
		ret = collisions balls, bullets, shot
		if ret[0] == r+1 then return false # skjut inte
		if ret[1] == y+1 then return true  # skjut

		bullets = (bullet for bullet in bullets when bullet.age < 215)
		balls = (ball for ball in balls when ball.age < 1000000)
	return false

draw = ->

	counter += 1
	if counter % 50 == 1 and queue > 0
		queue -= 1
		balls.push new Ball queue%2, width/8 * 0.95**level

	bg 0.5
	for ball in balls
		ball.draw()
		ball.update()

	for bullet in bullets
		bullet.draw()
		bullet.update()

	fc 1,1,1,0.05
	text level,width/2,height/2
	collisions balls, bullets, shot

	bullets = (bullet for bullet in bullets when bullet.age < 215)
	balls = (ball for ball in balls when ball.age < 1000000)

	rect XOFF,      height-5,5,5
	rect width-XOFF,height-5,5,5

	if shot[1] == level then newLevel level+1
	if shot[0] == level then newLevel level-1

	if ai and frameCount > fCount+N/2 and simulate _.map(balls, _.clone), _.map(bullets, _.clone), _.map(shot, _.clone)
		#pressLeft bullets
		pressRight bullets
		fCount = frameCount
		print level,shot

pressLeft  = (bullets) -> bullets.push new Bullet XOFF,      height-2,  1.2*3.02, -1.2*12.6, 0.1*1.4
pressRight = (bullets) -> bullets.push new Bullet width-XOFF,height-2, -1.2*3.02, -1.2*12.6, 0.1*1.4

keyPressed = ->
	print keyCode
	if keyCode == LEFT_ARROW  then pressLeft bullets
	if keyCode == RIGHT_ARROW then pressRight bullets
	if keyCode == 65 then ai = not ai
