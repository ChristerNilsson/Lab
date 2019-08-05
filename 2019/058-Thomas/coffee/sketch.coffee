class Ball
	constructor:(@x,@y,@vx,@vy,@R,@r,@g,@b)->
	draw: ->
		fc @r,@g,@b
		sc 1,1,1
		sw 5
		circle @x,@y,@R
		if @x+@R > width then @vx = -@vx
		if @x-@R < 0 then @vx = -@vx
		if @y+@R > height 
			@vy = -@vy
		else
			@vy+=1

		@x+=@vx
		@y+=@vy

balls = []

setup = ->
	createCanvas windowWidth,windowHeight
	for i in range 200
		R = 50+50*random()
		x = R+ (width-2*R)*random()
		y = R
		vx = -5+10*random()
		vy = 0
		r = random()
		g = random()
		b = random()
		balls.push new Ball x,y,vx,vy,R,r,g,b


draw = ->
	bg 0.5
	for ball in balls
		ball.draw()