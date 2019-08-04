					# 0  1  2  3  4  5  6  7  8  9 10 11 12 13 14 15 16 17 18 19 20 21 22 23 24
PLAYER0 = [20, 0, 1, 2, 3, 6, 7, 8, 9,10,11,12, 4, 5,13,19,18,12,11,10, 9, 8, 7, 6,22]
PLAYER1 = [21,17,16,15,14, 6, 7, 8, 9,10,11,12,18,19,13, 5, 4,12,11,10, 9, 8, 7, 6,22]
DICE    = [0,1,1,1,1,2,2,2,2,2,2,3,3,3,3,1]
MAX     = {4:4, 5:1, R:1, I:1, T:4, P:1}

player = 0
dice = 1
tiles = []

class Marker 
	constructor : (@player, @promoted = false) ->		

class Tile
	constructor : (@x,@y,@littera) ->
		@index = tiles.length
		@markers = []

	draw : ->
		fc 1
		x = width/2-100+100*@x
		y = 200+100*@y
		rect x,y,100,100
		fc 0
		text @littera,x,y
		for marker,i in @markers
			if marker.player == 0 then fc 1,0,0 else fc 0.5
			circle -20+x+7*i,-20+y+7*i,20
			if marker.promoted
				fc 1,1,0
				circle -20+x+7*i,-20+y+7*i,10

	inside : (mx,my) -> 
		x = width/2-100+100*@x
		y = 200+100*@y
		x-50 < mx < x+50 and y-50 < my < y+50 and @markers.length !=0 

	click : (target) -> if @legal target then @move target

	legal : (target) ->
		if @markers.length == 0 then return false
		if target.markers.length == MAX[@littera] then return false
		true
		# if @littera == '4' then 
		# if @littera == '5' then
		# if @littera == 'R' then
		# if @littera == 'I' then
		# if @littera == 'T' then
		# if @littera == 'P' then

	move : (target) -> 
		marker = @markers.pop()
		target.markers.push marker

setup = ->
	createCanvas windowWidth,windowHeight
	rectMode CENTER
	textAlign CENTER,CENTER
	textSize 64

	tiles.push new Tile 0,3,'4' # 0
	tiles.push new Tile 0,2,'5' # 1
	tiles.push new Tile 0,1,'4' # 2
	tiles.push new Tile 0,0,'R' # 3
	tiles.push new Tile 0,6,'R' # 4
	tiles.push new Tile 0,7,'P' # 5

	tiles.push new Tile 1,0,'I' # 6
	tiles.push new Tile 1,1,'5' # 7
	tiles.push new Tile 1,2,'T' # 8
	tiles.push new Tile 1,3,'R' # 9
	tiles.push new Tile 1,4,'5' # 10
	tiles.push new Tile 1,5,'T' # 11
	tiles.push new Tile 1,6,'4' # 12
	tiles.push new Tile 1,7,'5' # 13

	tiles.push new Tile 2,0,'R' # 14
	tiles.push new Tile 2,1,'4' # 15
	tiles.push new Tile 2,2,'5' # 16
	tiles.push new Tile 2,3,'4' # 17
	tiles.push new Tile 2,6,'R' # 18
	tiles.push new Tile 2,7,'P' # 19

	tiles.push new Tile -0.5,4.5,'0' # 20 # start for player 0
	tiles.push new Tile 2.5,4.5,'1'  # 21 # start for player 1
	tiles.push new Tile 1,-1.25,'E'  # 22 # end for both players

	for i in range 7
		tiles[20].markers.push new Marker 0
		tiles[21].markers.push new Marker 1

draw = ->
	bg 0.5
	for tile in tiles
		tile.draw()

helper = (zero,PLAYER) ->
	for index,p in PLAYER
		tileA = tiles[index]
		if tileA.markers.length == 0 then continue
		if index == zero
			tileB = tiles[PLAYER[dice]]
		else
			marker = tileA.markers[tileA.markers.length-1]
			#d = if marker.promoted then -dice else dice
			tileB = tiles[PLAYER[p + dice]]
		if tileA.inside mouseX,mouseY 
			if p >= 16 then marker.promoted = true
			if p+dice >= 17 then marker.promoted = true
			if p+dice >= PLAYER.length then tileA.markers.pop() else tileA.click tileB

mousePressed = () ->
	if player == 0
		helper 20,PLAYER0
	else 
		helper 21,PLAYER1
