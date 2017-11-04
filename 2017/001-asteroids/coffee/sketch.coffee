ship = 0
asteroids = []
lasers = []

modulo = (a,b) ->
	if a < 0 then return a + b 
	if a > b then return a - b 
	a
assert 5, modulo 5,10
assert 5, modulo 15,10
assert 5, modulo -5,10

setup = ->
	createCanvas 600,600
	ship = new Ship()
	for i in range 5
		asteroids.push new Asteroid()

draw = ->
	background 0
	for asteroid in asteroids
		asteroid.update()
		asteroid.draw()
		if asteroid.hit ship
			ship.alive = false
		for laser in lasers
			if asteroid.hit laser
				asteroid.r *= 0.9
				if asteroid.r < 5 
					asteroid.r = -1
				laser.r = -1
	lasers = _.filter lasers, (laser) -> laser.r!=-1 and laser.inside()
	asteroids = _.filter asteroids, (a) -> a.r!=-1
	for laser in lasers
		laser.update()
		laser.draw()
	ship.draw()
	ship.update()
	print lasers.length 

keyPressed = -> 
	if key == ' ' and ship.alive 
	  lasers.push new Laser ship
	if keyCode == RIGHT_ARROW 
	  ship.setRotation 0.05
	else if keyCode == LEFT_ARROW
	  ship.setRotation -0.05
	else if keyCode == UP_ARROW
		ship.accelerate 0.1

keyReleased = ->
	ship.setRotation 0
	ship.accelerate 0