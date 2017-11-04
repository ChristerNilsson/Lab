class Asteroid
	constructor : (@pos = new p5.Vector(random(width),random(height)), @r=15+random(20))->
		@offset = []
		@total = 5 + random 10
		for i in range @total
			@offset.push 0.7 + random 0.6
		@vel = p5.Vector.random2D()

	update : ->
		@pos.add @vel
		@pos.x = modulo @pos.x, width
		@pos.y = modulo @pos.y, height

	hit : (body) -> body.r + @r > dist body.pos.x, body.pos.y, @pos.x, @pos.y

	draw : ->
		push()
		stroke 255
		strokeWeight 1
		noFill()
		translate @pos.x,@pos.y
		beginShape()
		for i in range @total
			angle = map i, 0, @total, 0, TWO_PI
			r = @r * @offset[i]
			x = r * cos angle 
			y = r * sin angle
			vertex x, y
		endShape CLOSE
		pop()