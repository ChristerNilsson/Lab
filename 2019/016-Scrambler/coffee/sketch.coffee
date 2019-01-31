hash = null
korrekt = ''
slumpad = ''
message = ''
buttons = []
level = 3
released = true

normalize = (ord) -> 
	arr = ord.split ''
	arr.sort()
	arr.join ''

createHash = (lvl) ->
	hash = {}
	buttons[0].title = 'Facit'
	level = constrain lvl,2,25
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
	inside : -> @x-@w/2 < mouseX < @x+@w+2 and @y-@h/2 < mouseY < @y+@h+2

newGame = ->
	korrekt = _.sample _.keys hash 
	while true
		slumpad = (_.shuffle korrekt.split '').join ''
		if slumpad not in hash[normalize korrekt] then break
	message =  ''

setup = ->
	createCanvas windowWidth,windowHeight
	textAlign CENTER,CENTER
	rectMode CENTER
	textSize 50

	buttons.push new Button 'Facit', width/2,100, width/2,50, ->
		if @title == 'Slump'
			newGame()
		else
			message = hash[normalize korrekt]
		@title = if @title=='Slump' then 'Facit' else 'Slump'

	buttons.push new Button '+', width/2+100,600,100,50,-> createHash level+1
	buttons.push new Button '-', width/2-100,600,100,50,-> createHash level-1

	createHash 3

draw = ->
	bg 0.5
	for button in buttons
		button.draw()
	text slumpad,width/2,200
	text message,width/2,400
	text level,width/2,600

mousePressed = ->
	if released == false then return
	released = false 
	for button in buttons
		if button.inside() then button.click()

mouseReleased = ->
	released = true