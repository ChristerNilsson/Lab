buttons = []

class Button	
	constructor : (@x, @y, @prompt, @click = ->) ->
		@circle = raphael.circle @x,@y,100
			.attr {fill: '#ff0', opacity: 0.25}
			.click @click
		@text = raphael.text @x,@y,@prompt
			.attr stdText
			.click @click
	remove : ->
		@circle.remove()
		@text.remove()

clearMenu = ->
	for button in buttons
		button.remove()
	buttons = [] 
	scale 1

SetSector = (sector) ->
	general.SECTOR = sector
	saveGeneral()
	clearMenu()

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

make = (x,y) -> 
	image.translate x,y
	# dx = image.attrs.dx
	# dy = image.attrs.dy
	# s0 = image._.sx
	# x: window.innerWidth/2 - s0*WIDTH/2 - (x-WIDTH/2)*s0
	# y: window.innerHeight/2 - s0*HEIGHT/2 - (y-HEIGHT/2)*s0

menu1 = ->
	clearMenu()
	saveMenu 'center', ->
		#[cx,cy] = position
		#image.attr {x: position[0], y:position[1]}
    # center = (x0,y0,s0,x,y) -> [x0-x/s0,y0-y/s0]
		#console.log s0

		#image.attr {x: window.innerWidth/2 - (WIDTH - 1141)/s0 , y:  window.innerHeight/2 - 712/s0 } 
		#image.attr {x: (window.innerWidth-WIDTH)/2 - (1141-WIDTH/2) , y:  (window.innerHeight-HEIGHT)/2 - (712-HEIGHT/2) } 
		#image.attr {x: window.innerWidth/2 - 1141/s0 , y:  window.innerHeight/2 - 714/s0 } 

		# ingen skalning
		#image.attr {x: window.innerWidth/2 , y:  window.innerHeight/2}  # centrera NW
		#image.attr {x: window.innerWidth/2 - WIDTH/2 , y:  window.innerHeight/2 - HEIGHT/2} 		# centrera centrum
		#image.attr {x: window.innerWidth/2 - WIDTH , y:  window.innerHeight/2 - HEIGHT} 		# centrera SE

		{dx,dy,sx,sy} = image._
		x = (990 - dx)/sx #- image.attrs.x
		y = (216 - dx)/sx #- image.attrs.y
		image.translate WIDTH/2-x, HEIGHT/2-y
		
		# skalning
		#image.attr make x,y  # centrera Kaninparken
		#image.attr make WIDTH/2, HEIGHT/2 #{x: (innerWidth-WIDTH)/2/s0, y:  (innerHeight-HEIGHT)/2/s0}  # CENTER
		#image.attr make WIDTH, HEIGHT #{x: -WIDTH/2/s0, y:  -HEIGHT/2/s0}  # centrera SE


#		image.attr {x: 1920/2, y: 1127/2} 
#		image.attr {x: 1920/2, y: 1127/2} 
		console.log image,position
		clearMenu()
	saveMenu 'out', -> scale 1/SQ2
	saveMenu 'take', -> menu4()
	saveMenu 'more', -> menu6()
	saveMenu 'setup', -> menu2()
	saveMenu 'aim', -> clearMenu()
	saveMenu 'save', -> clearMenu()
	saveMenu 'in', -> scale SQ2

menu2 = ->
	clearMenu()
	saveMenu 'PanSpeed', -> 
		general.PANSPEED = not general.PANSPEED
		saveGeneral()
		clearMenu()
	saveMenu 'Coins', ->
		general.COINS = not general.COINS
		saveGeneral()
		clearMenu()
	saveMenu 'Distance', ->
		general.DISTANCE = not general.DISTANCE
		saveGeneral()
		clearMenu()
	saveMenu 'Trail', ->
		general.TRAIL = not general.TRAIL
		saveGeneral()
		clearMenu()
	saveMenu 'Sector', -> menu3()

menu3 = ->
	clearMenu()
	saveMenu '10', -> SetSector 10
	saveMenu '20', -> SetSector 20
	saveMenu '30', -> SetSector 30
	saveMenu '45', -> SetSector 45
	saveMenu '60', -> SetSector 60
	saveMenu '90', -> SetSector 90

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
	saveMenu 'Init', -> initSpeaker()
	saveMenu 'Mail', -> executeMail()
	saveMenu 'Delete', -> storage.deleteControl()
	saveMenu 'Clear', -> storage.clear()
	saveMenu 'Info', -> 
		for item in info()
			console.log item
		clearMenu()
	saveMenu 'GPS', ->
		locationUpdate {coords: {latitude: 59.269494, longitude: 18.168736}}
		clearMenu()
