assert = chai.assert.deepEqual

MARKERS = 7
COLORS = {P:'#f00',R:'#f0f',I:'#0f0',S:'#ff0',M:'#0ff',A:'#fff',O:'#000', X:'#000'}
MAX = 
	P:1 # Promotion
	R:1 # Replay
	I:1 # Promoted Protection
	S:4 # Stack 4 
	M:4 # Mixed 4
	A:1 # Attack

p0 = [] # Path of player 0
p1 = [] # Path of player 1

tiles = [] # Twenty tiles

player = 0 # 0 or 1
dice = null 

class Dice
	constructor : () ->
		@throw()
	throw : ->
		@value = random [1,1,1,2,2,2,3,4] # three tetras
		#@value = random [0,1,1,1,1,2,2,2,2,2,2,2,3,3,3,3,4] # four tetras
	inside : (mx,my) -> 
		x = width/2-100+100*player*2
		y = 200+100*5
		x-50 < mx < x+50 and y-50 < my < y+50
	rotate : ->
		@value = @value + 1
		if @value == 5 then @value = 1
	draw : ->
		x = width/2-100+100*player*2
		y = 200+100*5
		fc 1
		textSize 50
		text @value,x,y+7

class Marker 
	constructor : (@player, @promoted=false) ->	# promoted marker is indicated by five dots	
	draw : (x,y) ->
		if @player == 0 then fc 1,0,0,0.75 else fc 0.5,0.5,0.5,0.75
		circle x,y,25
		if @promoted
			fill '#ff0'
			for [dx,dy] in [[-1,-1],[-1,1],[1,1],[1,-1],[0,0]]
				circle x+10*dx,y+10*dy,5

class Tile
	constructor : (@x, @y) ->
		@letter = ' '
		@markers = []

	inside : (mx,my) -> 
		x = width/2-100+100*@x
		y = 200+100*@y
		x-50 < mx < x+50 and y-50 < my < y+50 and @markers.length !=0 
	
	click : (marker,target) -> 
		if @legal marker,target then @move target

	legal : (marker,target) -> 
		if marker.player != player then return false 
		n = target.markers.length
		letter = target.letter

		if letter == 'P'
			if n == 0 then return true
			return marker.player != target.markers[0].player

		if letter == 'R'
			if n == 0 then return true
			return marker.player != target.markers[0].player

		if letter == 'I'
			if n == 0 then return true
			if marker.player == target.markers[0].player
				return false
			else
				return marker.promoted == target.markers[0].promoted

		if letter == 'S'
			if n == 4 then return false
			if n == 0 then return true
			return marker.player == target.markers[0].player

		if letter == 'M'
			return n < 4 

		if letter == 'A'
			if n == 0 then return true
			return marker.player != target.markers[0].player

		if letter == 'X'
			return true

		assert 0,1

	move : (target) ->
		n = target.markers.length
		if MAX[target.letter] == 1
			if n == 1
				enemy = target.markers.pop()
				enemy.promoted = false
				tiles[20 + enemy.player].markers.push enemy
			marker = @markers.pop()
			target.markers.push marker
		else # MAX = 4, just move
			marker = @markers.pop()
			target.markers.push marker
		if target.letter != 'R' then player = 1 - player
		dice.throw()

	draw : ->
		fill COLORS[@letter]
		x = width/2-100+100*@x
		y = 200+100*@y
		rect x,y,90,90
		fc 0
		textSize 100
		text @letter,x,y+9
		for marker,i in @markers
			marker.draw x+10*(i%2), y+7*(7-i)-30

createAllTiles = () ->
	for i in range 4
		tiles.push new Tile 0,3-i # 0 1 2 3

	for i in range 6
		tiles.push new Tile 1,i # 4 5 6 7 8 9

	tiles.push new Tile 1,6 # 10
	tiles.push new Tile 0,6 # 11
	tiles.push new Tile 0,7 # 12
	tiles.push new Tile 1,7 # 13
	tiles.push new Tile 2,7 # 14
	tiles.push new Tile 2,6 # 15

	for i in range 4
		tiles.push new Tile 2,3-i # 16 17 18 19

	tiles.push new Tile 0,4  # 20 IN 0
	tiles.push new Tile 2,4  # 21 IN 1
	tiles.push new Tile 0,-1 # 22 OUT 0
	tiles.push new Tile 2,-1 # 23 OUT 1

createPlayer0 = -> p0.push tiles[i] for i in [20, 0, 1, 2, 3,4,5,6,7,8,9,10,11,12,13,14,15,10,9,8,7,6,5,4,22]
createPlayer1 = -> p1.push tiles[i] for i in [21,16,17,18,19,4,5,6,7,8,9,10,15,14,13,12,11,10,9,8,7,6,5,4,23]

setup = ->
	createCanvas windowWidth,windowHeight

	rectMode CENTER
	textAlign CENTER,CENTER
	textSize 100

	createAllTiles()
	createPlayer0()
	createPlayer1()

	dice = new Dice()

	for i in range MARKERS
		tiles[20].markers.push new Marker 0
		tiles[21].markers.push new Marker 1

	tiles[i].letter = letter for letter,i in 'SASRIAMRAMSRPAPRSASROOXX'		
		
draw = ->
	bg 0
	for tile in tiles
		tile.draw()
	dice.draw()

helper = (player) -> # a,b anger index till player-vektorn
	a = null
	for p,i in player
		if p.inside mouseX,mouseY 
			a = i	
			if _.last(p.markers).promoted 
				if a >= 12 then break
			else
				break
	if a == null then return 
	b = a + dice.value

	tileA = player[a]
	if tileA.markers.length == 0 then return
	marker = _.last tileA.markers
	if a == 0
		tileB = player[b]
		tileA.click marker,tileB
	else
		marker = _.last tileA.markers
		tileB = player[b]
		if a >= 12 then marker.promoted = true
		if b < player.length
			tileA.click marker,tileB

mousePressed = -> 
	if dice.inside mouseX,mouseY
		dice.rotate()
	else
		if player == 0 then helper p0 else helper p1
