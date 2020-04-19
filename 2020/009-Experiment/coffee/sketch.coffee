level = 0

active = 0
start = null
stopp = null

COLORS = "#ff08 #0f08 #00f8".split ' '

class Circle
	constructor : (@radie, @x, @y, @col) ->
		@active = true
	rita : ->
		if not @active then return 
		fill @col
		circle @x,@y,@radie
	inside : (mx,my) -> dist(@x,@y,mx,my) < @radie

circles = []

reset = () ->
	start = new Date()
	level++
	circles = []
	for i in range 2
		createCircles COLORS[i]

setup = ->
	createCanvas windowWidth,windowHeight
	reset()
	textSize 100
	textAlign CENTER,CENTER

draw = ->
	bg 0
	for circle in circles
		circle.rita()

createCircles = (col) ->
	active++

	radie = windowHeight/2

	x = random 0,width
	y = random 0,height
	circles.push new Circle radie,x,y,col

	x = random 0,width
	y = random 0,height
	circles.push new Circle radie,x,y,col
