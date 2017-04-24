setup = ->
	createCanvas 400,400
	
draw = ->
	text "#{mouseX} #{mouseY}", mouseX, mouseY	

mousePressed = ->
	bg 0.5			
