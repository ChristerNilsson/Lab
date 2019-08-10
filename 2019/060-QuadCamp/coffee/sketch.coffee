squares = []
SIZE = 100
class Square
	constructor:(@x,@y, @letter = 'R') ->
	draw: ->
		if @letter == 'R' then fc 1,0,1
		if @letter == 'S' then fc 1,1,0
		if @letter == 'I' then fc 0,1,0
		if @letter == 'A' then fc 1
		if @letter == 'P' then fc 1,0,0
		if @letter == 'M' then fc 0,255,255
		rectMode CENTER
		rect SIZE*@x+SIZE,SIZE*@y+SIZE,SIZE,SIZE
		fc 0
		textSize SIZE
		textAlign CENTER,CENTER
		text @letter, SIZE*@x+SIZE,SIZE*@y+SIZE+10
setup = ->
	createCanvas windowWidth,windowHeight
	for i in range 4
		squares.push new Square 0,i
	for i in range 6
		squares.push new Square 1,i
	for i in range 4
		squares.push new Square 2,i
	squares.push new Square 1,6 
	squares.push new Square 0,6 
	squares.push new Square 0,7 
	squares.push new Square 1,7 
	squares.push new Square 2,7
	squares.push new Square 2,6 
	for letter,i in 'RSASIAMRAMRSASSRPAPR'
		console.log i
		squares[i].letter = letter
	console.log squares

draw = ->
	bg 0
	for square in squares
		square.draw()