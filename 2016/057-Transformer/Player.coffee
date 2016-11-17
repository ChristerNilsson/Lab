class Player

	constructor: (@keys,@col) ->  # sixties
		@w=30
		@h=60

		@buttons = []              # x   y   w   h (relativt centrum)
		@buttons.push new Button @,-10,-10, 7.5, 15, "3"
		@buttons.push new Button @, 10,-10, 7.5, 15, "2"
		@buttons.push new Button @,  0,-10, 7.5, 15, "undo"
		@buttons.push new Button @,-10, 10, 7.5, 15, "/2"
		@buttons.push new Button @,  0, 10, 7.5, 15, "+2"
		@buttons.push new Button @, 10, 10, 7.5, 15, "*2"

	draw : ->
		fill @col	
		rect 0,0, width*@w/60-2,height*@h/60-2
		for button in @buttons
			button.draw()

	mousePressed : ->
		for button in @buttons 
			button.mousePressed()

