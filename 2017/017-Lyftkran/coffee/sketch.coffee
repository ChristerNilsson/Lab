crane = null
balls = []
SIZE = 300

class Crane
	constructor : ->
		@r = 100
		@dir = 0
		@pos = new p5.Vector()
	draw : ->
		fc 1
		circle 0,0,SIZE
		fc 0
		circle 0,0,60
		fc 1,1,0
		circle 0,0,40
		@pos = new p5.Vector.fromAngle(@dir).mult(@r) 
		sw 5
		sc 0.5
		line 0,0,@pos.x,@pos.y
		sw 1
		circle @pos.x,@pos.y,10

		gs = navigator.getGamepads()
		print gs
		if gs and gs[0]
			@dir += gs[0].axes[0] * 0.005
			@r -= gs[0].axes[1]
			#x1 += gs[0].axes[2]
			#y1 += gs[0].axes[3]

		if keyIsDown LEFT_ARROW then	@dir -= 0.003
		if keyIsDown RIGHT_ARROW then @dir += 0.003
		if keyIsDown DOWN_ARROW then @r -= 0.5
		if keyIsDown UP_ARROW then	 @r += 0.5
		@r = constrain @r,70,SIZE-10

class Ball
	constructor : (x,y,@r) ->
		@active = true
		@pos = new p5.Vector x,y
	draw : () ->
		@update()
		fc 1,0,0
		circle @pos.x,@pos.y,@r
	update : ->
		# move in direction of line between centers
		# move it so they touches
		if @pos.dist(crane.pos) < @r + 10
			@move p5.Vector.sub @pos, crane.pos 
	move : (v) ->		
		v.normalize()
		@pos.add v
		@active = 60 < @pos.dist(new p5.Vector()) < SIZE
		for ball in balls
			if @pos.dist(ball.pos) < @r + ball.r and ball != @
				v = p5.Vector.sub ball.pos, @pos 
				ball.move v

setup = ->
	createCanvas windowWidth,windowHeight
	crane = new Crane()
	balls.push new Ball 100,100,10
	balls.push new Ball -80,100,15
	balls.push new Ball 60,-100,20
	balls.push new Ball -40,100,25

draw = ->
	bg 0
	translate width/2, height/2
	crane.draw()
	for ball in balls
		ball.draw()
	balls = (ball for ball in balls when ball.active)