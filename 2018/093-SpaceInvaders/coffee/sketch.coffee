aliens = []
shots = []
obstacles = []
ship = null
state = 0
timestamp = null

class Alien
	constructor : (@x1,@x2,@y) ->
		@x = (@x1+@x2)/2
		@dx = 0.5
		@radius = 25
	draw : ->
		fc 1,1,0
		circle @x,@y,@radius
		@x += @dx 
		if @x > @x2 or @x < @x1
			@dx = -@dx
			@y += 5

class Obstacle
	constructor : (@x,@y) ->
		@radius = 10
		@active = true
	draw : ->
		if @active == false then return 
		fc 1,0,0
		circle @x,@y,@radius

class Ship 
	constructor : (@x,@y) ->
		@active = true
		@dx = 0
		@radius = 25
	draw : ->
		fc 0,1,0
		circle @x,@y,@radius
		@x += @dx
	shoot : () ->
		shots.push new Shot @x,@y-@radius-15,0,-2

class Shot 
	constructor : (@x,@y,@dx,@dy) -> @active = true
	draw : ->
		if @active 
			line @x,@y-10,@x,@y+10
			@y += @dy
	hit : (other) ->
		a = other.radius > dist other.x,other.y,@x,@y-10
		b = other.radius > dist other.x,other.y,@x,@y+10
		a or b

setup = ->
	createCanvas 700,600

	rectMode CENTER
	sc 1

	for i in range 6
		col = []
		for j in range 6
			col.push new Alien 150+80*i-100,150+80*i+100,50+60*j
		aliens.push col

	ship = new Ship width/2,height-50

	for i in range 3
		for j in range 3
			for k in range 3
				if j==0 and k==0 then continue
				if j==2 and k==2 then continue
				obstacles.push new Obstacle 120+200*i+20*(j+k/2),450+20*k
	timestamp = new Date()

handleCollisions = ->
	for shot in shots
		if not shot.active then continue
		for col in aliens
			if col.length > 0
				a = _.last col			
				if shot.hit a 
					shot.active = false
					col.pop()  
					break
		for obstacle in obstacles
			if not obstacle.active then continue
			if shot.hit obstacle 
				shot.active = false
				obstacle.active = false 
		if shot.hit ship then	state = 1

draw = ->
	if state == 1 then return 
	bg 0

	for col in aliens
		for alien in col
			alien.draw()
		if col.length > 0 and 1 > random 1000
			alien = _.last col
			shots.push new Shot alien.x,alien.y+40,0,2
	shot.draw() for shot in shots
	obstacle.draw() for obstacle in obstacles
	ship.draw()
	handleCollisions()
	shots = (shot for shot in shots when shot.active and 0 < shot.y < height )

keyPressed = ->
	date = new Date()
	if date - timestamp < 500 then return
	timestamp = date 
	if keyCode == RIGHT_ARROW then ship.dx = +2
	if keyCode ==  LEFT_ARROW then ship.dx = -2	
	if key == ' ' then ship.shoot()	

keyReleased = -> ship.dx = 0	
