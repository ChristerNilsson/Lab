class Particle
  constructor : (x, y, @r) ->
    @hue = random 360
    options = {
      restitution: 0.5,
      friction: 0,
      density: 1
    }
    x += random -1, 1
    @body = Bodies.circle x, y, @r, options
    @body.label = "particle"
    World.add world, this.body

  isOffScreen : () ->
    x = @body.position.x;
    y = @body.position.y;
    x < -50 || x > width + 50 || y > height

  show : () ->
    fill @hue, 255, 255
    noStroke()
    pos = @body.position
    push()
    translate pos.x, pos.y
    ellipse 0, 0, @r * 2
    pop()