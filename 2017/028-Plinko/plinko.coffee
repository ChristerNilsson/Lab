class Plinko
  constructor : (x, y, @r) ->
    @body = Bodies.circle x, y, @r, {restitution: 1,friction: 0,isStatic: true}
    World.add world, @body

  show : ->
    pos = @body.position
    ellipse pos.x, pos.y, this.r * 2