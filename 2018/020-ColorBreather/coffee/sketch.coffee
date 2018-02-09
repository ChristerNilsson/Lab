current = null
colors = [null,null]
COLORS = {}

changeCorners = ->
	current = 0 
	colors.push _.sample _.keys COLORS
	colors.shift()

setup = ->
	COLORS.black = color 0,0,0
	COLORS.blue = color 0,0,255
	COLORS.green = color 0,255,0
	COLORS.cyan = color 0,255,255
	COLORS.red = color 255,0,0
	COLORS.magenta = color 255,0,255
	COLORS.yellow = color 255,255,0
	COLORS.white = color 255,255,255
	createCanvas windowWidth, windowHeight
	changeCorners()
	changeCorners()
	textSize 0.4*height
	textAlign CENTER,CENTER

draw = ->
	background lerpColor COLORS[colors[0]], COLORS[colors[1]], current
	if current > 1 then	changeCorners() else current += 0.001
	fc 0
	text colors[0],width/2,0.3*height
	translate width/2,0.7*height
	rd 180
	fc 1
	text colors[0],0,0
