class Boundary
  constructor : (x, y, @w, @h) ->
    @body = Bodies.rectangle x, y, @w, @h, {isStatic: true}
    World.add world, @body

  show : ->
    pos = @body.position
    rect pos.x, pos.y, @w, @h