class Snake
  constructor : (@head=createVector(10,10), @dir=0, @total=1, @tail=[]) -> 

  eat : (pos) ->
    d = dist @head.x, @head.y, pos.x, pos.y
    if d == 0 then @total++
    d == 0

  death : ->
    for pos in @tail
      d = dist @head.x, @head.y, pos.x, pos.y
      if d == 0 
        print 'starting over'
        @total = 1
        @tail = []

  update : ->
    @tail.unshift @head
    if @total <= @tail.length then @tail.pop()
    @head = createVector (@head.x + [1,0,-1,0][@dir]) %% n, (@head.y + [0,1,0,-1][@dir]) %% n

  show : -> kvadrat pos, color 255 for pos in @tail.concat @head