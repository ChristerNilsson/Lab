class Laser
	constructor : (ship) ->
		@pos = ship.pos.copy()
		@heading = ship.heading
		@vel = new p5.Vector.fromAngle @heading
		@vel.mult 10
		@r = 0

	update : -> @pos.add @vel
	draw : -> ellipse @pos.x,@pos.y,4
	inside : -> 1000 > dist @pos.x, @pos.y, width/2, height/2