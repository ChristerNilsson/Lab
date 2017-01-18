setup = ->
	createCanvas 600,600
	textSize 16
	textAlign CENTER,CENTER
	bg 0
	fc 1,1,0,0.5

draw = ->

mousePressed = -> text "x=#{mouseX} y=#{mouseY}",mouseX,mouseY