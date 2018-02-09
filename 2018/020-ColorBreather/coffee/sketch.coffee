current = 0
COLORS = {}
keys = null

changeCorners = ->
	current = 0
	keys.push keys.shift()

setup = ->
	COLORS.black   = color 0,0,0
	COLORS.blue    = color 0,0,255
	COLORS.green   = color 0,255,0
	COLORS.cyan    = color 0,255,255
	COLORS.red     = color 255,0,0
	COLORS.magenta = color 255,0,255
	COLORS.yellow  = color 255,255,0
	COLORS.white   = color 255,255,255
	keys = _.shuffle _.keys COLORS
	createCanvas windowWidth, windowHeight
	textAlign CENTER,CENTER

draw = ->
	key1 = keys[0]
	key2 = keys[1]
	background lerpColor COLORS[key1], COLORS[key2], current
	if current > 1 then	changeCorners() else current += 0.001

	textSize 0.2*height
	fc 0.5
	text round(100*current)+"%",0.5*width,0.5*height	
	textSize 0.4*height

	fc 0
	text key1,0.5*width,0.2*height
	translate 0.5*width,0.8*height
	rd 180
	fc 1
	text key1,0,0
