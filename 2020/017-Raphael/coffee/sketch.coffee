buttons = []
p = null 
image = null
crossHair = null

SQ2 = Math.sqrt 2
messages = []

WIDTH = 2338
HEIGHT = 1654
RADIUS = 35

stdText = {font: '40px Arial', fill: '#000'}

scale = (factor) -> 
	image.scale factor,factor,WIDTH/2,HEIGHT/2
	crossHair.scale factor

class Button	
	constructor : (@x, @y, @prompt, @click = ->) ->
		@circle = p.circle @x,@y,100
			.attr {fill: '#ff0', opacity: 0.25}
			.click @click
		@text = p.text @x,@y,@prompt
			.attr stdText
			.click @click
	remove : ->
		@circle.remove()
		@text.remove()

class Box 
	constructor : (x,y,w,h,name) ->
		image = p.image "21C.png", 0,0, WIDTH, HEIGHT
		image.translate (1920-WIDTH)/2, (1127-HEIGHT)/2
		crossHair = p.circle w/2,h/2,RADIUS 
		scale SQ2

		a = p.text 0.5*w, 50, '180º'
			.attr stdText
		b = p.text 0.95*w, 50, '345m'
			.attr stdText

		c = p.text 0.5*w, 0.95*h, '59.123456 18.123456'
			.attr stdText
		d = p.text 0.95*w, 0.95*h, '345'
			.attr stdText

		messages = [a,b,c,d]

		console.log messages

		image.drag @move_drag, @move_start, @move_up

	move_start : ->
		@ox = @attr 'x'
		@oy = @attr 'y'

	move_drag : (dx, dy) ->
		newx = @ox + dx / image._.sx
		newy = @oy + dy / image._.sy
		cx = WIDTH/2 - newx
		cy = HEIGHT/2 - newy
		messages[2].attr {text: "#{Math.round cx} #{Math.round cy}"}
		image.attr {x: newx, y: newy}

	move_up : ->

startup = ->
	p = Raphael 'canvasdiv', window.innerWidth, window.innerHeight
	p.rect 0, 0, window.innerWidth, window.innerHeight
		.attr {fill: '#00f'}
	new Box 100, 100, window.innerWidth, window.innerHeight, 'A'
	menu()

clearMenu = ->
	for button in buttons
		button.remove()
	buttons = []
	scale 1

menu = ->
	new Button 100,window.innerHeight-100,'menu', -> 
		if buttons.length > 0 
			clearMenu()
		else 
			menu1()
			console.log 'image.attrs.x',image.attrs.x
			console.log 'image.attrs.y',image.attrs.y
			console.log 'image._.dx',image._.dx
			console.log 'image._.dy',image._.dy
			console.log image

saveMenu = (prompt,click) ->
	n = buttons.length
	x = if n < 4 then 100 else window.innerWidth-100
	y = 200 + 200 * (n % 4)
	buttons.push new Button x,y, prompt, click

menu1 = ->
	clearMenu()
	saveMenu 'center', -> clearMenu()
	saveMenu 'out', -> scale 1/SQ2
	saveMenu 'take', -> menu4()
	saveMenu 'more', -> menu6()
	saveMenu 'setup', -> menu2()
	saveMenu 'aim', -> clearMenu()
	saveMenu 'save', -> clearMenu()
	saveMenu 'in', -> scale SQ2

menu2 = ->
	clearMenu()
	saveMenu 'PanSpeed', -> clearMenu()
	saveMenu 'Coins', -> clearMenu()
	saveMenu 'Distance', -> clearMenu()
	saveMenu 'Trail', -> clearMenu()
	saveMenu 'Sector', -> menu3()

menu3 = ->
	clearMenu()
	saveMenu '10', -> clearMenu()
	saveMenu '20', -> clearMenu()
	saveMenu '30', -> clearMenu()
	saveMenu '45', -> clearMenu()
	saveMenu '60', -> clearMenu()
	saveMenu '90', -> clearMenu()

menu4 = ->
	clearMenu()
	saveMenu 'ABCDE', -> menu5 'ABCDE'
	saveMenu 'FGHIJ', -> menu5 'FGHIJ'
	saveMenu 'KLMNO', -> menu5 'KLMNO'
	saveMenu 'PQRST', -> menu5 'PQRST'
	saveMenu 'UVWXYZ', -> menu5 'UVWXYZ'
	saveMenu 'Clear', -> clearMenu()

menu5 = (letters) -> # ABCDE
	clearMenu()
	for letter in letters
		saveMenu letter, -> clearMenu()

menu6 = ->
	clearMenu()
	saveMenu 'Init', -> clearMenu()
	saveMenu 'Mail', -> clearMenu()
	saveMenu 'Delete', -> clearMenu()
	saveMenu 'Clear', -> clearMenu()
	saveMenu 'Info', -> clearMenu()
