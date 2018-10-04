class Curve 
	constructor : -> @reset()
	addPoint : (x,y) -> @path.push createVector x,y 
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
		last = _.last @path
		point last.x, last.y
	