level = 0

active = 0
start = null
stopp = null

class Ball
	constructor : (@radie, @x, @y, @dx, @dy, @r, @g, @b) ->
		@active = true
	rita : ->
		if not @active then return 
		if @x > width-@radie then @dx = -@dx
		if @x < @radie then @dx = -@dx
		@x += @dx

		if @y > height-@radie then @dy = -@dy else @dy+=0.1

		@y += @dy
		fc @r,@g,@b
		circle @x,@y,@radie
	inside : (mx,my) -> dist(@x,@y,mx,my) < @radie

balls = []

reset = () ->
	start = new Date()
	level++
	balls = []
	for i in range level
		createBall()

setup = ->
	createCanvas 800,600
	reset()
	textSize 100
	textAlign CENTER,CENTER

draw = ->
	bg 0
	for ball in balls
		ball.rita()
	if active == 0
		fc 1
		text (stopp-start)/1000, width/2,height/2

mousePressed = ->
	if active==0
		reset()
	else
		for ball in balls
			if ball.inside mouseX,mouseY 
				ball.active = false
				active--
				if active == 0
					stopp = new Date() 

createBall = ->
	active++
	x = random 50,width
	y = random 50,100
	dx = random -2,2
	dy = random -0.3,0.3

	radie = 50
	r = random 1
	g = random 1
	b = random 1
	balls.push new Ball radie,x,y,dx,dy,r,g,b
