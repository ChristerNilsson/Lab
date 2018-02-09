current = null
index = 0
COLORS = {}
keys = null

changeCorners = ->
	current = 0 
	index++
	index %= 8

setup = ->
	COLORS.black = color 0,0,0
	COLORS.blue = color 0,0,255
	COLORS.green = color 0,255,0
	COLORS.cyan = color 0,255,255
	COLORS.red = color 255,0,0
	COLORS.magenta = color 255,0,255
	COLORS.yellow = color 255,255,0
	COLORS.white = color 255,255,255
	keys = _.shuffle _.keys COLORS
	createCanvas windowWidth, windowHeight
	changeCorners()
	changeCorners()
	textSize 0.4*height
	textAlign CENTER,CENTER

draw = ->
	key1 = keys[index]
	key2 = keys[(index+1) % 8]
	background lerpColor COLORS[key1], COLORS[key2], current
	if current > 1 then	changeCorners() else current += 0.001
	fc 0
	text key1,width/2,0.3*height
	translate width/2,0.7*height
	rd 180
	fc 1
	text key1,0,0
