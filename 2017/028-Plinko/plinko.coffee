class Plinko
  constructor : (x, y, @r) -> World.add world, @body = Bodies.circle x, y, @r, {restitution: 1,friction: 0,isStatic: true}
  show : -> ellipse @body.position.x, @body.position.y, this.r * 2