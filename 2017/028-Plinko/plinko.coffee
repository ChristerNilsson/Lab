class Plinko
  constructor : (x, y, @r) ->
    options = 
      restitution: 1
      friction: 0
      isStatic: true
    @body = Bodies.circle x, y, @r, options
    @body.label = "plinko"
    World.add world, @body

  show : ->
    noStroke()
    fill 127
    pos = @body.position
    push()
    translate pos.x, pos.y
    ellipse 0, 0, this.r * 2
    pop()