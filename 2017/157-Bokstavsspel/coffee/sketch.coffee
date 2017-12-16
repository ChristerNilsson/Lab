game = null

class Game
	constructor : -> 
		@N = 11
		@score = 0
		@highScore = 0
		@size = min windowWidth,windowHeight
		@SIZE = @size/@N
		@newGame()

	newGame : ->
		@player = new Player width/2,height/2
		@enemies = {}
		@interval = 200
		@speed = 1
		@highScore = max @highScore,@score
		@score = 0

	draw : ->
		bg 0.5
		@player.draw()
		for k,enemy of @enemies
			if enemy then enemy.draw()
		fc 0
		text @score, @SIZE,@SIZE
		text @highScore, width-@SIZE,@SIZE
		if frameCount % @interval == 0
			@interval -= 1
			@speed *= 1.05
			r = int random 4
			while _.size(@enemies) < 30
				letter = _.sample "'"+ 'abcdefghijklmnopqrstuvwxyzåäö' + '0123456789[]{}().,-+*/%!@#=<>":'.slice 0,@score
				if letter in _.keys @enemies 
					if not @enemies[letter].active then break
				else
					break
			if r==0 then @enemies[letter] = new Enemy letter,@player.x,0,0,@speed*height/@size	
			if r==1 then @enemies[letter] = new Enemy letter,@player.x,height,0,-@speed*height/@size	
			if r==2 then @enemies[letter] = new Enemy letter,0,@player.y,@speed*width/@size,0	
			if r==3 then @enemies[letter] = new Enemy letter,width,@player.y,-@speed*width/@size,0	

	keyTyped : (k) -> 
		if (k in _.keys @enemies) and @enemies[k].active 
			@score++
			@enemies[k].active = false  
		else
			@newGame()

class Enemy
	constructor : (@letter,@x,@y,@dx,@dy) -> @active = true
	draw : ->	
		if not @active then return
		@x += @dx
		@y += @dy
		fc 0
		text @letter,@x,@y
		if 10 > game.player.dist @x,@y then game.newGame()

class Player
	constructor : (@x,@y) ->
	draw : ->	
		fc 1
		rect @x,@y,game.SIZE,game.SIZE
	dist : (x,y) ->	dist x,y,@x,@y 

draw = -> game.draw()
keyTyped = -> game.keyTyped key.toLowerCase()
setup = ->
	createCanvas windowWidth,windowHeight
	game = new Game
	rectMode CENTER
	textAlign CENTER,CENTER
	textSize game.SIZE
