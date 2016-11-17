g = 0

class Game
	constructor : ->
		@players = []
		@players.push new Player "WASD",color(255,0,0)
		@players.push new Player "&%('",color(0,255,0)
		@x = 0
		@y = 0
		@a = 0
		@s = 1
		@stack = []
	push : ->
		@stack.push [@x,@y,@a,@s]
		push()
	pop : ->
		[@x,@y,@a,@s] = @stack.pop()
		pop()
	rotate : (d) ->
		rotate radians d
		@a += d
	scale : (ds) ->
		scale ds
		@s *= ds
	translate : (dx,dy) ->
		v = radians @a
		@x += @s * dx * cos(v) - @s * dy * sin(v)
		@y += @s * dy * cos(v) + @s * dx * sin(v)
		translate dx,dy
	dump : (txt) ->
		console.log [txt, @x,@y]

setup = ->
	createCanvas 600,300
	textAlign CENTER,CENTER
	rectMode CENTER
	g = new Game()
	xdraw()

xdraw = ->
	g.translate width/2, height/2
	for player,i in g.players
		g.push()
		if i==0
			g.translate -width/4, 0
			g.rotate 90
		if i==1
			g.translate width/4, 0
			g.rotate -90
			g.scale 0.5
		player.draw()
		g.pop()

mousePressed = ->
	console.log [mouseX,mouseY]
	for player in g.players
		player.mousePressed()

