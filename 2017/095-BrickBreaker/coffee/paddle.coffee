class Paddle
	constructor : ->
		@w = 160
		@h = 20
		@x = width / 2 - @w / 2
		@y = height - 40

	display : -> rect @x, @y, @w, @h
	update : ->
		if keyIsDown(65) or keyIsDown(97) then @x -= 20
		if keyIsDown(68) or keyIsDown(100) then @x += 20

	checkEdges : ->
		if @x <= 0 then @x = 0
		else if @x + @w >= width then @x = width - @w