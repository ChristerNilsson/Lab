SQ2 = 2 # Math.sqrt 2

WIDTH = 1639
HEIGHT = 986
RADIUS = 35

messages = []

stdText = {font: '40px Arial', fill: '#000'}

image = null
crossHair = null

scale = (factor) ->
	w = window.innerWidth
	h = window.innerHeight
	dx = w/2 - image.attrs.x
	dy = h/2 - image.attrs.y
	image.scale factor
	#x = w/2 - dx * image._.sx
	#y = h/2 - dy * image._.sy
	x = image.attrs.x
	y = image.attrs.y
	#image.attr {x: x, y: y}
	console.log factor,image._.sx, w,h,dx,dy,x,y

	if crossHair then crossHair.scale factor

class Box 
	constructor : (x,y,w,h,name) ->
		image = raphael.image "data/Skarpnäck.png", 0,0, WIDTH, HEIGHT
		#image.translate (1920-WIDTH)/2, (1127-HEIGHT)/2
		image.attr {x:(1920-WIDTH)/2, y:(1127-HEIGHT)/2}
		crossHair = raphael.circle w/2,h/2,RADIUS 
		#scale SQ2
		scale 1

		a = raphael.text 0.5*w, 50, '180º'
			.attr stdText
		b = raphael.text 0.95*w, 50, '345m'
			.attr stdText

		c = raphael.text 0.5*w, 0.95*h, '59.123456 18.123456'
			.attr stdText
		d = raphael.text 0.95*w, 0.95*h, '345'
			.attr stdText

		messages = [a,b,c,d]

		console.log messages

		image.drag @move_drag, @move_start, @move_up
		image.mousemove (e) -> # Ska ge image koordinater
			{dx,dy,sx,sy} = image._
			messages[2].attr {text: "#{(e.x - dx)/sx - image.attrs.x} = #{e.x} #{dx} #{x} #{sx}   " + "#{(e.y - dy)/sy - image.attrs.y} = #{e.y} #{dy} #{y} #{sy}"}

	move_start : -> [@ox,@oy] = [0,0]

	move_drag : (dx, dy) ->
		image.translate (dx-@ox) / image._.sx, (dy-@oy) / image._.sy
		@ox = dx
		@oy = dy 

	move_up : ->
		console.dir JSON.stringify image.attrs
