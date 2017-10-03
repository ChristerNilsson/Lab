SIZE = 20
N  = 20

apple = [10,10]
snakes = []
state = -1

class Snake
	constructor : (@index,x,y,@dir) ->
		@head = [x,y]
		@body = []

	distans : (other) -> abs(@head[0]-other[0]) + abs(@head[1]-other[1])

	collision : (other) ->
		for b in other.body
			if @distans(b)==0 then return true
		false

	update : ->
		@body.unshift @head
		if @distans(apple)==0
			apple = [int(random(N)), int(random(N))]
		else if @collision(snakes[1-@index])
			state = @index
		else
			@body.pop()
		@head = [(@head[0]+[1,0,-1,0][@dir]) %% N, (@head[1]+[0,1,0,-1][@dir]) %% N]

	draw : ->
		fc 1
		for [x,y] in @body.concat [@head]
			rect SIZE*x,SIZE*y,SIZE,SIZE
		fc 1,0,0
		rect SIZE*apple[0],SIZE*apple[1],SIZE,SIZE

setup = ->
	createCanvas 400,400
	frameRate 5
	snakes.push new Snake 0,5,5,0
	snakes.push new Snake 1,15,15,2

draw = ->
	if state == -1
		bg 0.5
		for snake in snakes
			snake.draw()
			snake.update()
	else
		textSize 30
		textAlign CENTER,CENTER
		fc 1,1,0
		text ['Left','Right'][state] + ' wins!',width/2,height/2

keyPressed = ->
	[a,b] = snakes
	if keyCode==65          then a.dir = (a.dir - 1) %% 4
	if keyCode==68          then a.dir = (a.dir + 1) %% 4
	if keyCode==LEFT_ARROW  then b.dir = (b.dir - 1) %% 4
	if keyCode==RIGHT_ARROW then b.dir = (b.dir + 1) %% 4
