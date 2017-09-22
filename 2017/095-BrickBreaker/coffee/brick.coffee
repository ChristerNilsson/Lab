class Brick
	constructor : ->
		@x = random 100, width - 100
		@y = random 100, height - 400
		@r = random 20, 80
		@total = 6

	display : ->
		push()
		translate @x, @y
		beginShape()
		for i in range @total
			angle = i/@total*TWO_PI
			x = @r * cos angle
			y = @r * sin angle
			vertex x, y
		endShape CLOSE
		pop()