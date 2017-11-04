class Ship
	constructor : ->
		@pos = new p5.Vector width/2, height/2
		@r = 20
		@heading = 0 # radians
		@rotation = 0
		@vel = new p5.Vector 0,0
		@acc = 0
		@alive = true

	accelerate : (a) -> @acc = a
	setRotation : (a) -> @rotation = a

	boost : ->
		force = p5.Vector.fromAngle @heading
		force.mult @acc
		@vel.add force

	update : ->
		@boost()
		@pos.add @vel
		@pos.x = modulo @pos.x, width
		@pos.y = modulo @pos.y, height
		@vel.mult 0.99
		@heading += @rotation

	draw : ->
		push()
		if @alive
			stroke 255
		else
			stroke 255,0,0
		strokeWeight 1
		fill 0
		translate @pos.x,@pos.y
		rotate @heading + PI/2
		triangle -@r,@r, @r,@r, 0,-@r  
		pop()