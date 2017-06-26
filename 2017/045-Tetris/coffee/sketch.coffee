arena = (new Array(12).fill(0) for i in range 20)
player = {pos: {x: 0, y: 0},	matrix: null,	score: 0}
setup = ->
	createCanvas 20*12,20*20
	frameRate 3
	playerReset()
	updateScore()
fcc = (n) ->
	if n==0 then fc 1
	else if n==1 then fc 1,0,0
	else if n==2 then fc 0,1,0
	else if n==3 then fc 0,0,1
	else if n==4 then fc 1,1,0
	else if n==5 then fc 0,1,1
	else if n==6 then fc 1,0,1
	else if n==7 then fc 0.5
arenaSweep = ->
	for i in range arena.length
		y = 19-i
		rad = arena[y]
		if not _.contains rad, 0
			row = arena.splice(y, 1)[0].fill 0
			arena.unshift row
			player.score += 10
collide = (arena, player) ->
	m = player.matrix
	o = player.pos
	for y in range m.length
		for x in range m[y].length
			if (m[y][x] != 0 and (arena[y + o.y] and arena[y + o.y][x + o.x]) != 0) then return true
	false
createPiece = (type) ->
	if type == 'I' then	return [[0, 1, 0, 0],	[0, 1, 0, 0],	[0, 1, 0, 0],	[0, 1, 0, 0],]
	else if type == 'L' then return [[0, 2, 0],[0, 2, 0],[0, 2, 2],]
	else if type == 'J' then return [[0, 3, 0],[0, 3, 0],[3, 3, 0],]
	else if type == 'O' then return [[4, 4],[4, 4],]
	else if type == 'Z' then return [[5, 5, 0],[0, 5, 5],[0, 0, 0]]
	else if type == 'S' then return [[0, 6, 6],[6, 6, 0],[0, 0, 0]]
	else if type == 'T' then return [[0, 7, 0],[7, 7, 7],[0, 0, 0]]
drawMatrix = (matrix, offset) ->
	for row,y in matrix
		for value,x in row
			if value != 0
				fcc value
				rect 20*(x + offset.x), 20*(y + offset.y),20, 20
draw = ->
	bg 0
	drawMatrix arena, {x: 0, y: 0}
	drawMatrix player.matrix, player.pos
	#playerDrop()
	arenaSweep()
merge = (arena, player) ->
	for row,y in player.matrix
		for value,x in row
			if value != 0 then arena[y + player.pos.y][x + player.pos.x] = value
rotera = (matrix, dir) ->
	for y in range matrix.length
		for x in range y
			[matrix[x][y], matrix[y][x]] = [matrix[y][x],matrix[x][y]]
	if dir > 0
		row.reverse() for row in matrix
	else
		matrix.reverse()
playerDrop = ->
	player.pos.y++
	if collide arena, player
		player.pos.y--
		merge arena, player
		playerReset()
		arenaSweep()
		updateScore()
	dropCounter = 0
playerMove = (offset) ->
	player.pos.x += offset
	if collide arena, player then player.pos.x -= offset
playerReset = ->
	pieces = 'TJLOSZI'
	player.matrix = createPiece(pieces[pieces.length * Math.random() | 0]);
	player.pos.y = 0
	player.pos.x = (arena[0].length / 2 | 0) - (player.matrix[0].length / 2 | 0)
	if collide arena, player
		row.fill(0) for row in arena
		player.score = 0
		updateScore()
playerRotate = (dir) ->
	pos = player.pos.x
	offset = 1
	rotera player.matrix, dir
	while collide arena, player
		player.pos.x += offset
		offset = -(offset + (offset > 0 ? 1 : -1))
		if offset > player.matrix[0].length
			rotera player.matrix, -dir
			player.pos.x = pos
			return
updateScore = -> # print player.score
keyPressed = ->
	if keyCode == 37 then playerMove -1 # LEFT
	else if keyCode == 39 then playerMove 1 # RIGHT
	else if keyCode == 40 then playerDrop() # DOWN
	else if keyCode == 81 then playerRotate -1 # Q
	else if keyCode == 87 then playerRotate 1 # W
	else if keyCode == 32 then playerDrop() # W
