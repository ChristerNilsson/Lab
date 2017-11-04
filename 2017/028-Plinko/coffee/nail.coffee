class Nail
	constructor : (x, y, @r) -> World.add world, @body = Bodies.circle x, y, @r, {restitution: 1,friction: 0,isStatic: true}
	show : -> circle @body.position.x, @body.position.y, this.r