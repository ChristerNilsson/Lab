assert = chai.assert.deepEqual

MARKERS = 7
COLORS = {P:'#f00',R:'#f0f',I:'#0f0',S:'#bb4',M:'#0ff',A:'#00f',O:'#000', X:'#000'}

P0 = 'xabcdefghijklmnopqrstuvwy' # left player
P1 = 'XZÅÄÖEFGHIJKPONMLQRSTUVWY' # right player

MAX = 
	P:1 # Promotion
	R:1 # Replay
	I:1 # Promoted Protection
	S:4 # Stack 4 
	M:4 # Mixed 4
	A:1 # Attack

p0 = [] # Path of left player
p1 = [] # Path of right player

tiles = [] # Twenty tiles

player = 0 # 0=left 1=right
dice = null 
buttons = []
inMoves = ''
outMoves = ''
current = null

class Button 
	constructor : (@x,@y,@title,@click = ->) ->
	draw : ->
		fc 1
		rect @x,@y,90,90
		textSize 40
		fc 0
		text @title,@x,@y
	inside : (mx,my) -> @x-45 < mx < @x+45 and @y-45 < my < @y+45 

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
	constructor : (@player, @promoted=false) ->	# promoted marker is indicated with a golden ring
	draw : (x,y) ->
		if @player == 0 then fc 0.8 else fc 0
		if @player == 1 then sc 1 else sc 0
		sw 2
		if @promoted
			sc 1,1,0
			sw 5
		circle x,y,25
		sc 0
		sw 1

class Tile
	constructor : (@x, @y) ->
		@letter = ' '
		@markers = []

	inside : (mx,my) -> 
		x = width/2-100+100*@x
		y = 200+100*@y
		x-50 < mx < x+50 and y-50 < my < y+50 and @markers.length !=0 
	
	click : (marker,target,a,b) -> 
		if @legal marker,target then @move target,a,b

	legal : (marker,target) -> 
		if marker.player != player then return false 
		n = target.markers.length
		letter = target.letter

		if letter == 'S' and n == 4 then return false

		if letter in 'PRA'
			if n == 0 then return true
			bool1 = marker.player != target.markers[0].player
			bool2 = marker.promoted == target.markers[0].promoted
			return bool1 and bool2

		if letter in 'S'
			if n == 0 then return true
			return marker.player == target.markers[0].player

		if letter == 'I'
			if n == 0 then return true
			if marker.player == target.markers[0].player then return false
			else return marker.promoted == target.markers[0].promoted

		if letter == 'M' then return n < 4 
		if letter == 'X' then return true

		assert 0,1

	move : (target,a,b) ->
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

		if player == 0 then outMoves += P0[a] + P0[b] + ' '
		if player == 1 then outMoves += (P1[a] + P1[b] + ' ').toUpperCase()

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

	x = width/2
	y = 200+100*8

	buttons.push new Button x-100,y,'Prev', -> inspector -1
	buttons.push new Button x+100,y,'Next', -> inspector +1

	rectMode CENTER
	textAlign CENTER,CENTER
	textSize 100

	current = 0
	init()
	dice = new Dice()

	inMoves = 'xb XÖ ÖF bd df XZ xa ZÅ ad fh hi XÄ df ÅÖ XZ xb ZÅ xa ÖF bd ij ÄÖ FH HK ab KO jl ln OM np ps ML LS df ÖH ÅÖ ÖF bd xc HP ST PO xa OM ab ML XÖ LR ce ÖE df XÖ EF xc XÅ ce ÖE xd xa TU ac RT ÅÖ EG xa TU dg XZ ce FH ÖE gh bd dg EF hi ZÖ ÖH FI ad dh hk XÅ km ÅÖ IP XÄ gi UW mn PN ij GH NL LQ jl ln QR nr HI'.split ' '
	inspector 0

init = ->
	player = 0 
	tiles = []
	p0 = []
	p1 = []
	createAllTiles()
	createPlayer0()
	createPlayer1()

	for i in range MARKERS
		tiles[20].markers.push new Marker 0
		tiles[21].markers.push new Marker 1

	tiles[i].letter = letter for letter,i in 'SASRIAMRAMSRPAPRSASROOXX'		
		
draw = ->
	bg 0
	for tile in tiles
		tile.draw()
	dice.draw()
	for button in buttons	
		button.draw()
	fc 1
	text current,width/2,200+100*8

helper = (a,playerx,diceValue) -> # a,b anger index till player-vektorn
	b = a + diceValue

	tileA = playerx[a]
	if tileA.markers.length == 0 then return
	marker = _.last tileA.markers
	if a == 0
		tileA.click marker,playerx[b],a,b
	else
		if b >= 14 then marker.promoted = true
		if b < playerx.length then tileA.click marker,playerx[b],a,b

mousePressed = -> 
	for button in buttons
		if button.inside mouseX,mouseY then return button.click()
	if dice.inside mouseX,mouseY
		return dice.rotate()
	a = null
	if player==0 then q = p0 else q = p1
	for p,i in q
		if p.inside mouseX,mouseY 
			a = i	
			if _.last(p.markers).promoted 
				if a >= 12 then break
			else
				break
	if a == null then return 
	if player == 0 then helper a,p0,dice.value else helper a,p1,dice.value
	console.log outMoves

inspector = (delta) ->
	outMoves = ''
	init()
	current += delta
	if current < 0 then current = 0
	for move,index in inMoves
		if index >= current then break
		if move[0].toLowerCase() == move[0] then p=0 else p=1
		if p==0 
			a = P0.indexOf move[0]
			b = P0.indexOf move[1]
			helper a,p0,b-a
		if p==1
			a = P1.indexOf move[0]
			b = P1.indexOf move[1]
			helper a,p1,b-a

	print 'xxx',current,inMoves[current]
