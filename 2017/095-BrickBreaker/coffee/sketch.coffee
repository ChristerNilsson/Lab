paddle = null
ball = null
bricks = []
playingGame = false
youWin = false
winText = null

setup = ->
	createCanvas windowWidth, windowHeight

	paddle = new Paddle()
	ball = new Ball()

	for i in range 20
		bricks.push new Brick()

	createText()

draw = ->
	bg 1

	for i in reverse range bricks.length
		bricks[i].display()
		if ball.hits bricks[i]
			if bricks[i].r >= 40 then bricks[i].r /= 2
			else bricks.splice i, 1
			ball.vy *= -1

	paddle.display()
	if playingGame then paddle.checkEdges()
	if playingGame then paddle.update()
	if ball.meets(paddle) then ball.vy *= -1

	ball.display()
	if playingGame then ball.checkEdges()
	if playingGame then ball.update()

	if ball.y > height
		ball.x = width / 2
		ball.y = height / 2
		playingGame = false

	if bricks.length == 0
		youWin = true
		playingGame = false

	if youWin then winText.style 'display', 'block'
	else winText.style 'display', 'none'

keyReleased = -> paddle.moving = 0

keyPressed = ->
	if key in 'aA' then paddle.moving = -20
	else if key in 'dD' then paddle.moving = 20
	else if key in 'sS'
		if bricks.length == 0
			for i in range 20
				bricks.push new Brick()
		playingGame = true
		youWin = false

createText = ->
	winText = createP 'YOU WIN!'
	winText.position width / 2, 80
