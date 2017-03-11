class Ball
	constructor : (x, y, @r) -> World.add world, @body = Bodies.circle x+random(-1,1), y, @r, {restitution: 0.5, friction: 0, density: 1}
	show : -> circle @body.position.x, @body.position.y, @r 