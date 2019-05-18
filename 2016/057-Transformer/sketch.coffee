g = 0
players = []

class Transformer
	constructor : ->
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
		@a += d
		rotate d
	scale : (ds) ->
		@s *= ds
		scale ds
	translate : (dx,dy) ->
		@x += @s * dx * cos(@a) - @s * dy * sin(@a)
		@y += @s * dy * cos(@a) + @s * dx * sin(@a)
		translate dx,dy

dump = (txt) ->
	console.log [txt, @x,@y]

setup = ->
	createCanvas 600,300
	textAlign CENTER,CENTER
	rectMode CENTER
	g = new Transformer()
	players.push new Player "WASD",color(255,0,0)
	players.push new Player "&%('",color(0,255,0)
	xdraw()

xdraw = ->
	g.push()
	g.translate width/2, height/2
	for player,i in players
		g.push()
		if i==0
			g.translate -width/4, 0
			g.rotate 90
		if i==1
			g.translate width/4, 0
			g.rotate -90
			g.scale 1
		player.draw()
		g.pop()
	g.pop()
	
mousePressed = ->
	console.log [mouseX,mouseY]
	for player in players
		player.mousePressed()

