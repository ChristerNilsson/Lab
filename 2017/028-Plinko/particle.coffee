class Particle
  constructor : (x, y, @r) ->
    x += random -1, 1
    @body = Bodies.circle x, y, @r, {restitution: 0.5,friction: 0,density: 1}
    World.add world, @body

  isOffScreen : () ->
    x = @body.position.x;
    y = @body.position.y;
    x < -50 || x > width + 50 || y > height

  show : () ->
    pos = @body.position
    ellipse pos.x, pos.y, @r * 2