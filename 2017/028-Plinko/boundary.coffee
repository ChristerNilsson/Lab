class Boundary
  constructor : (x, y, @w, @h) ->
    options = {
      isStatic: true
    };
    @body = Bodies.rectangle x, y, @w, @h, options
    World.add world, @body

  show : ->
    fill 255
    stroke 255
    pos = @body.position
    push()
    translate pos.x, pos.y
    rectMode CENTER
    rect 0, 0, @w, @h
    pop()
