class Page
	constructor : (@x,@y,@w,@h,@cols=1) ->
		@selected = null # anger vilken knapp man klickat på
		@buttons  = [] 
		@active = true

	clear : ->
		@selected = null
		@buttons = []

	addButton : (button) -> 
		button.page = @
		@buttons.push button

	render : ->

	draw : ->
		if @active 
			@render()
			for button in @buttons
				button.draw()

	mousePressed : ->
		if @active 
			for button in @buttons
				if button.inside mouseX,mouseY 
					button.click()
					return true
		false 

