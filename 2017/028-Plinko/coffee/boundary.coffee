class Boundary
	constructor : (x, y, @w, @h) -> World.add world, @body = Bodies.rectangle x, y, @w, @h, {isStatic: true}
	show : -> rect @body.position.x, @body.position.y, @w, @h