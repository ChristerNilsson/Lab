snake = null
side = 20
n = 30
food = null

kvadrat = (pos,color) -> 
  fill color
  rect side*pos.x, side*pos.y, side, side

setup = ->
  createCanvas 600, 600
  snake = new Snake()
  frameRate 10
  pickLocation()

pickLocation = -> food = createVector floor(random(0,n)), floor(random(0,n))

draw =  ->
  background 51

  if snake.eat food then pickLocation()
  
  snake.death()
  snake.update()
  snake.show()

  kvadrat food, color 255,0,100

keyPressed = ->
  if keyCode == RIGHT_ARROW then snake.dir = [1,2,3,0][snake.dir]
  if keyCode == LEFT_ARROW then snake.dir = [3,0,1,2][snake.dir]