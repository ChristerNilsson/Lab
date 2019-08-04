MARKERS = 7
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
dice = 1 # 0..4 Probability [0,1,2,3,4] == [1,4,6,4,1]

class Marker 
	constructor : (@player, @promoted=false) ->	# promoted marker is indicated by five dots	

class Tile
	constructor : (@x,@y, @markers=[],@letter=' ') ->

	inside : (mx,my) -> 
		x = width/2-100+100*@x
		y = 200+100*@y
		x-50 < mx < x+50 and y-50 < my < y+50 and @markers.length !=0 
	
	click : (target) -> if @legal target then @move target

	legal : (target) ->
		if target.markers.length == 4 and MAX[target.letter] == 4 then return false
		true

	move : (target) -> 
		if MAX[target.letter] == 1
			if target.markers.length == 1
				if target.markers[0].player == @player 
					return false
				else # throw enemy marker
					enemy = target.markers.pop()
					enemy.promoted = false
					tiles[20 + enemy.player].markers.push enemy
		marker = @markers.pop()
		target.markers.push marker
		if target.letter != 'R' then player = 1 -player

	draw : ->
		if @letter==' ' then fc 0,0,0 
		if @letter=='P' then fc 1,0,0 
		if @letter=='R' then fc 1,0,1
		if @letter=='I' then fc 0,1,0
		if @letter=='S' then fc 1,1,0
		if @letter=='M' then fc 0,1,1 
		if @letter=='A' then fc 1,1,1 
		x = width/2-100+100*@x
		y = 200+100*@y
		rect x,y,90,90
		fc 0
		text @letter,x,y+9
		for marker,i in @markers
			if marker.player == 0 then fc 1,0,0,0.75 else fc 0.5,0.5,0.5,0.75
			circle x+10*(i%2),-30+y+7*(7-i),25
			if marker.promoted
				fc 1,1,0
				circle -20+x+7*i,-20+y+7*i,10

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

	tiles.push new Tile 0,4 # 20 IN 0
	tiles.push new Tile 2,4 # 21 IN 1
	tiles.push new Tile 0,-1 # 22 OUT 0
	tiles.push new Tile 2,-1 # 23 OUT 1

createPlayer0 = ->
	for i in [20,0,1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,10,9,8,7,6,5,4,22]
		p0.push tiles[i] 

createPlayer1 = ->
	for i in [21,16,17,18,19,4,5,6,7,8,9,10,15,14,13,12,11,10,9,8,7,6,5,4,23]
		p1.push tiles[i] 

setup = ->
	createCanvas windowWidth,windowHeight

	rectMode CENTER
	textAlign CENTER,CENTER
	textSize 100

	createAllTiles()
	createPlayer0()
	createPlayer1()

	tiles[i].letter = letter for letter,i in 'SASRIAMRAMSRPAPRSASR'		

	for i in range MARKERS
		tiles[20].markers.push new Marker 0
		tiles[21].markers.push new Marker 1
		
draw = ->
	bg 0
	for tile in tiles
		tile.draw()

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
	b = a + dice

	tileA = player[a]
	if tileA.markers.length == 0 then return
	if a == 0
		tileB = player[b]
		tileA.click tileB
	else
		marker = _.last tileA.markers
		tileB = player[b]
		if a >= 12 then marker.promoted = true
		if b < player.length
			tileA.click tileB

mousePressed = -> if player == 0 then helper p0 else helper p1
