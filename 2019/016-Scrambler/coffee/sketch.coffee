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

setup = ->
	createCanvas windowWidth-20,windowHeight-20
	textAlign CENTER,CENTER
	rectMode CENTER
	textSize 50

	buttons.push new Button '+', 100,100,100,50,-> createHash level+1
	buttons.push new Button '-', 100,200,100,50,-> createHash level-1

	buttons.push new Button 'Next', width/2,100, width/2,50, ->
		hist.unshift "#{slumpad} : #{hash[normalize korrekt]}"
		newGame()

	createHash 3

draw = ->
	bg 0.5
	for button in buttons
		button.draw()
	if hash[normalize korrekt].length	== 1 then text slumpad,width/2,200
	else text "#{slumpad} (#{hash[normalize korrekt].length})",width/2,200
	text level,100,150
	for line,i in hist
		text line,width/2,300+100*i

mousePressed = touchStarted = ->
	if released then released = false else return # to make Android work 	
	for button in buttons
		if button.inside() then button.click()
	false # to prevent double click on Android

mouseReleased = touchEnded = ->
	released = true 
	false # to prevent double click on Android	