class Page
	constructor : (@x,@y,@w,@h,@cols=1) ->
		@selected = null # anger vilken knapp man klickat på
		@buttons  = [] 
		@modal = false # spärra underliggande fönster

	inside : -> @x < mouseX < @x+@w and @y < mouseY < @y+@h		

	clear : ->
		@selected = null
		@buttons = []

	addButton : (button) -> 
		button.page = @
		@buttons.push button

	render : ->

	bg : -> # klarar ett eller tre argument
		fc.apply null, arguments
		rect @x,@y,@w,@h

	draw : ->
		@render()
		for button in @buttons
			button.draw()

	mousePressed : ->
		if not @inside() then return false 
		for button in @buttons
			if button.inside()
				button.click()
				return true
		false 
