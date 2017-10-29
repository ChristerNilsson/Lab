balls = []
level = 2
bullets=[]
shots=[0,0]
class Ball
	constructor : (@r,@g,@b) ->
		@radie = 50
		@x = random 0+@radie,width-@radie
		@y = @radie
		@vx= random 1,2
		@vy= random 1,2
		@active=true
	rita : ->
		if not @active then return
		fc @r,@g,@b
		sc 0
		circle @x,@y,@radie

	flytta : ->
		@x=@x+@vx
		if @x > width-@radie then @vx=-@vx
		if @x < 0+@radie then @vx=-@vx

		@y=@y+@vy
		if @y > height-@radie or @y < 0+@radie
			@vy=-@vy
		else
			@vy = @vy + 0.125

class Bullet
	constructor : (@x,@y,@vx,@vy) ->
		@radie = 2
		@active=true
	rita : ->
		if not @active then return
		fc 0
		sc 0
		circle @x,@y,@radie

	flytta : ->
		@x=@x+@vx
		#if @x > width-@radie then @vx=-@vx
		#if @x < 0+@radie then @vx=-@vx

		@y=@y+@vy
		if @y > height-@radie #or @y < 0+@radie
			@vy=-@vy
		else
			@vy = @vy + 0.31

newLevel=(lvl) ->
	balls = []
	level+=lvl
	bullets=[]
	shots=[0,0]
	for i in range level
		balls.push new Ball 1,1,0
		balls.push new Ball 1,0,0


setup = ->
	createCanvas 500,400
	newLevel 1

collision = ->
	for ball in balls
		for bullet in bullets
			if ball.active and bullet.active and dist(bullet.x,bullet.y,ball.x,ball.y) < ball.radie+bullet.radie
				ball.active=false
				bullet.active=false
				shots[ball.g]+=1
				return
draw = ->
	bg 0.5
	textAlign CENTER,CENTER
	textSize 200
	fc 0.7
	text level, width/2,height/2
	textSize 25
	fc 0,1,1
	text "Made By Oscar Olheden 7B", width/2, height-25
	for ball in balls
		ball.rita()
		ball.flytta()
		#print "b"

	for bullet in bullets
		bullet.rita()
		bullet.flytta()
		#print "a"
	collision()
	fc 0
	rect 5,height-5,5,5
	rect width-15,height-5,5,5
	if shots[0]==level then newLevel -1
	if shots[1]==level then newLevel +1

keyPressed = ->
	if keyCode == LEFT_ARROW
		#print "c"
		bullets.push new Bullet 5,height-5,5,15

	print keyCode
	if keyCode == RIGHT_ARROW
		#print "c"
		bullets.push new Bullet width-5,height-5,-5,15
