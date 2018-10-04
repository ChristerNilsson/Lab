class Curve 

	constructor : ->
		@path = []
		@x = 0
		@y = 0
	
	addPoint : -> @path.push createVector @x,@y 
	reset : -> @path = []

	show : ->
		stroke 255
		strokeWeight 1
		noFill()
		beginShape()
		for v in @path
			vertex v.x, v.y
		endShape()

		strokeWeight 8
		point @x, @y
	