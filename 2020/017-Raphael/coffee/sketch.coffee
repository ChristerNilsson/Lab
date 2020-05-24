boxes = []

buttons = []

p = null 
image = null

stdText = {font: '40px Arial', fill: '#000'}

class Button	
	constructor : (@x,@y,@prompt,@click) ->
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

		image = p.image "skarpnäck.png", 0, 0, 1636, 986
		p.circle w/2,h/2,50

		p.text 0.5*w, 50, '180º'
			.attr stdText
		p.text 0.95*w, 50, '345m'
			.attr stdText

		p.text 0.5*w, 0.95*h, '59.123456 18.123456'
			.attr stdText
		p.text 0.95*w, 0.95*h, '345'
			.attr stdText

		image.drag @move_drag, @move_start, @move_up

	move_start : ->
		@ox = @attr 'x'
		@oy = @attr 'y'
		image.ox = @attr 'x'
		image.oy = @attr 'y'

	move_drag : (dx, dy) ->
		@attr {x: @ox + dx, y: @oy + dy}
		image.attr {x: image.ox + dx, y: image.oy + dy}

	move_up : ->

startup = ->
	p = Raphael 'canvasdiv', window.innerWidth, window.innerHeight
	p.rect 0, 0, window.innerWidth, window.innerHeight
		.attr {fill: '#f00'}
	boxes.push new Box 100, 100, window.innerWidth, window.innerHeight, 'A'
	menu()

clearMenu = ->
	for button in buttons
		button.remove()
	buttons = []

menu = ->
	new Button 100,window.innerHeight-100,'menu', -> 
		if buttons.length > 0 
			clearMenu()
		else 
			menu1()

saveMenu = (prompt,click) ->
	n = buttons.length
	x = if n<4 then 100 else window.innerWidth-100
	y = 200+200*(n%4)
	buttons.push new Button x,y, prompt, click

menu1 = ->
	clearMenu()
	saveMenu 'center', -> clearMenu()
	saveMenu 'out', -> image.scale 2/3,2/3
	saveMenu 'take', -> menu4()
	saveMenu 'more', -> menu6()
	saveMenu 'setup', -> menu2()
	saveMenu 'aim', -> clearMenu()
	saveMenu 'save', -> clearMenu()
	saveMenu 'in', -> image.scale 3/2,3/2

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
	for letter,i in letters
		saveMenu letter, -> clearMenu()

menu6 = ->
	clearMenu()
	saveMenu 'Init', -> clearMenu()
	saveMenu 'Mail', -> clearMenu()
	saveMenu 'Delete', -> clearMenu()
	saveMenu 'Clear', -> clearMenu()
	saveMenu 'Info', -> clearMenu()
