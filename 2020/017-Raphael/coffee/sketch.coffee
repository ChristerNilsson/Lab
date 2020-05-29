p = null 
image = null

#SQ2 = Math.sqrt 2
messages = []

[W,H] = [innerWidth,innerHeight] # screen
[w,h] = [1639,986] # image
[cx,cy] = [0,0]
[ox,oy] = [0,0]

stdText = {font: '40px Arial', fill: '#888'}

myRound = (x,n=0) -> Math.round(x*10**n)/10**n

class Button	
	constructor : (@x, @y, @prompt, @click = ->) ->
		@circle = p.circle @x,@y,100
			.attr {fill: '#ff0', opacity: 0.5}
			.click @click
		@text = p.text @x,@y,@prompt
			.attr stdText
			.click @click

move_start = ->
	ox = image.attrs.x
	oy = image.attrs.y

move_drag = (dx, dy) ->
	image.translate (dx-ox) / image._.sx, (dy-oy) / image._.sy
	ox = dx
	oy = dy 
	info()

move_up = ->

info = ->
	{dx,dy,sx,sy} = image._
	cx = (W/2-dx)/sx
	cy = (H/2-dy)/sy
	messages[0].attr {text : "dx=#{myRound dx}\ndy=#{myRound dy}\nsx=#{myRound sx,2}\nsy=#{myRound sy,2}\ncx=#{myRound cx}\ncy=#{myRound cy}"}

startup = ->
	p = Raphael 'canvasdiv', W, H
	p.rect 0, 0, W, H
		.attr {fill: '#fff'}

	image = p.image "skarpnäck.png", 0,0, w,h
	image.translate (W-w)/2, (H-h)/2
	a = p.text(0.9*W, 200, '').attr stdText
	b = p.text(0.9*W, 500, '').attr stdText
	messages = [a,b]
	
	image.drag move_drag, move_start, move_up
	info()

	image.mousemove (e) -> 
		{dx,dy,sx,sy} = image._
		messages[1].attr {text: "x=#{myRound (e.x - dx)/sx}\ny=#{myRound (e.y - dy)/sy}"}

	p.circle W/2,H/2,20 # crossHair
	p.circle W/2,H/2,0.5 # crossHair

	new Button 100,100,'left', -> info image.translate -10,0
	new Button 100,300,'right', -> info image.translate 10,0
	new Button 100,500,'in', -> info image.scale 2,2,cx,cy
	new Button 100,700,'out', -> info image.scale 1/2,1/2,cx,cy
	new Button 100,900,'center', -> 
		# 990,216 Kaninparken
		image.translate cx-990,cy-216
		info() 
