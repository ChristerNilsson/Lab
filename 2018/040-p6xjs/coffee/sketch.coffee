btnLeft = null
btnRight = null
sun   = null
earth = null
moon  = null
message = ""

setup = ->
	createCanvas 600,600
	angleMode DEGREES

	textSize 12
	textAlign CENTER,CENTER

	moved = (m) -> @strokeWeight = if @contains m then 3 else 1

	btnLeft = p6.ellipse 100,100,100,80,stage,
		title : "Left"
		moved : moved
		pressed : -> sun.move -10,0

	btnRight = p6.regular 500,100,50,6,stage,
		title : "Right"
		moved : moved
		pressed : -> sun.move 10,0

	sun = p6.arc 300,300,40,-45,270-45,stage,
		rotation : 45
		title : 'Sun'
		fillColor : "#ff0"
		moved : moved
		pressed : -> message = @title

	earth = p6.regular 200,0,40,4,sun,
		rotation : 60
		title : 'Earth'
		scaleFactor : 1
		fillColor : "#00f"
		moved : moved
		pressed : -> message = @title

	moon = p6.regular 40,0,10,5,earth,
		title : 'm'
		scaleFactor : 2
		fillColor : "#fff"
		moved : moved
		pressed : -> message = @title

draw = ->
	bg 0.5
	stage.draw()
	btnLeft.rotation += 0.1
	btnRight.rotation += 0.2
	sun.rotation   += 0.05
	earth.rotation += 0.1
	moon.rotation += 0.3
	text message,width/2,100

mouseMoved   = ->	stage.mouseMoved() 
mousePressed = ->	stage.mousePressed()
