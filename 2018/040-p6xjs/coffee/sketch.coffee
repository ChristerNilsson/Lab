btnLeft = null
btnRight = null
sun   = null
earth = null
moon  = null
message = ""

setup = ->
	createCanvas 600,600
	angleMode DEGREES

	textSize 20
	textAlign CENTER,CENTER

	moved = (m) -> @strokeWeight = if @contains m then 3 else 1

	btnLeft = p6.ellipse 100,100,100,80
	btnLeft.title "Left"
	btnLeft.moved = moved
	btnLeft.pressed = -> sun.move -10,0

	btnRight = p6.regular 500,100,50,6
	btnRight.title "Right"
	btnRight.moved = moved
	btnRight.pressed = -> sun.move 10,0

	sun = p6.circle 300,300,80
	sun.rotation = 45
	sun.title 's'
	sun.fill "#ff0"
	sun.moved = moved
	sun.pressed = -> message = @txt

	earth = p6.regular 200,0,40,4,sun
	earth.rotation = 60
	earth.title 'e'
	earth.fill "#00f"
	earth.moved = moved
	earth.pressed = -> message = @txt

	moon = p6.regular 80,0,15,5,earth
	moon.title 'm'
	moon.fill "#fff"
	moon.moved = moved
	moon.pressed = -> message = @txt

draw = ->
	bg 0.5
	stage.draw()
	btnLeft.rotation += 0.1
	btnRight.rotation += 0.2
	sun.rotation   += 0.05
	earth.rotation += 0.2
	moon.rotation += 0.3
	text message,width/2,100

mouseMoved   = ->	stage.mouseMoved() 
mousePressed = ->	stage.mousePressed()
