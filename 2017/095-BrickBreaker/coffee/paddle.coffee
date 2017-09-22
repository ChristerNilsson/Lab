class Paddle
	constructor : ->
		@w = 160
		@h = 20
		@x = width / 2 - @w / 2
		@y = height - 40
		@moving = 0

	display : -> rect @x, @y, @w, @h
	update : ->	@move @moving
	move : (step) -> @x += step

	checkEdges : ->
		if @x <= 0 then @x = 0
		else if @x + @w >= width then @x = width - @w
