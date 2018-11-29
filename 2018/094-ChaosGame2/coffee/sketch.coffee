# Part 1: https://youtu.be/7gNzMtYo9n4
# Part 2: https://youtu.be/A0NHGTggoOQ

points = []
current = null
percent = 0.5
previous = null

setup = ->
  createCanvas windowWidth, windowHeight
  points = []
  n = 5

  for i in range n
    angle = i * TWO_PI / n
    v = p5.Vector.fromAngle angle
    v.mult width / 2
    v.add width / 2, height / 2
    points.push v

  reset()


reset = ->
  current = createVector random(width), random(height)
  bg 0
  sc 1
  sw 8
  for p in points
    point p.x, p.y

draw = ->

  for i in range 1000
    sw 1
    sc 1
    next = random points
    if next != previous
      current.x = lerp current.x, next.x, percent
      current.y = lerp current.y, next.y, percent
      point current.x, current.y
    previous = next
