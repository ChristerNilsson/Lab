N = 11
SIZE = 200/N
player = null
enemies = []
interval = 200
speed = 0.05
highScore = 0

newGame = ->
	player = new Player width/2,height/2
	highScore = max highScore,enemies.length
	enemies = []
	interval = 200
	speed = 1

class Enemy
	constructor : (@x,@y,@dx,@dy) ->
	draw : ->	
		fc 1,0,0
		circle @x,@y,5
		@x += @dx
		@y += @dy
		if 10 > player.dist @x,@y then newGame()

class Player
	constructor : (@x,@y) ->
	draw : ->	
		fc 1
		rect @x,@y,SIZE,SIZE
	keyPressed : ->
		if keyCode == LEFT_ARROW  then @x-=SIZE
		if keyCode == RIGHT_ARROW then @x+=SIZE
		if keyCode == UP_ARROW    then @y-=SIZE
		if keyCode == DOWN_ARROW  then @y+=SIZE
	dist : (x,y) ->	dist x,y,@x,@y 

setup = ->
	createCanvas 200,200
	newGame()	
	rectMode CENTER
	textAlign CENTER,CENTER
	textSize 20

draw = ->
	bg 0.5
	player.draw()
	for enemy in enemies
		enemy.draw()
	fc 0
	text enemies.length, 100,20
	text highScore, 100,180
	if frameCount % interval == 0
		interval -= 1
		speed *= 1.05
		r = int random 4
		if r==0 then enemies.push new Enemy player.x,0,0,speed	
		if r==1 then enemies.push new Enemy player.x,height,0,-speed	
		if r==2 then enemies.push new Enemy 0,player.y,speed,0	
		if r==3 then enemies.push new Enemy width,player.y,-speed,0	

keyPressed = ->
	player.keyPressed()
