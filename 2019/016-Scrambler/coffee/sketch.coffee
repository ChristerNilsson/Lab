hash = null
korrekt = ''
slumpad = ''
buttons = []
level = 3
released = true
hist = []

normalize = (ord) -> 
	arr = ord.split ''
	arr.sort()
	arr.join ''

createHash = (lvl) ->
	hash = {}
	level = constrain lvl,3,25
	for ord in ordlista.split ' '
		if ord.length == level
			key = normalize ord
			if hash[key] then hash[key].push ord else hash[key] = [ord] 
	newGame()

class Button
	constructor : (@title,@x,@y,@w,@h,@click) ->
	draw : ->
		rect @x,@y,@w,@h
		text @title,@x,@y
	inside : -> 
		mx = mouseX * 1000 / windowWidth
		my = mouseY * 1000 / windowHeight
		@x-@w/2 < mx < @x+@w+2 and @y-@h/2 < my < @y+@h+2

newGame = ->
	korrekt = _.sample _.keys hash 
	while true
		slumpad = (_.shuffle korrekt.split '').join ''
		if slumpad not in hash[normalize korrekt] then break

setup = ->
	createCanvas windowWidth-18,windowHeight-20
	textAlign CENTER,CENTER
	rectMode CENTER

	buttons.push new Button '+', 900,100,100,50,-> createHash level+1
	buttons.push new Button '-', 700,100,100,50,-> createHash level-1

	buttons.push new Button 'Next', 150,100, 200,50, ->
		hist.unshift [slumpad, hash[normalize korrekt]]
		newGame()

	createHash 3

draw = ->
	scale windowWidth/1000,windowHeight/1000
	bg 0.5
	for button in buttons
		button.draw()
	textSize 50

	push()
	textSize 60
	if hash[normalize korrekt].length	== 1 then text slumpad,500,200
	else text "#{slumpad} (#{hash[normalize korrekt].length})",500,200
	pop()

	text level,800,100

	push()
	for pair,i in hist
		[line0,line1] = pair
		textAlign LEFT,CENTER
		text line0,50,300+100*i
		textAlign RIGHT,CENTER
		text line1,900,350+100*i
	pop()

mousePressed = touchStarted = ->
	if released then released = false else return # to make Android work 	
	for button in buttons
		if button.inside() then button.click()
	false # to prevent double click on Android

mouseReleased = touchEnded = ->
	released = true 
	false # to prevent double click on Android	