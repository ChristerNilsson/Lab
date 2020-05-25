# Detta program användes när man ska
#   1) kalibrera en ny karta och behöver tre koordinater
#   2) placera ut kontroller
# Avläs koordinaterna med F12

img = null
points = []

#############################
R = 44
preload = -> img = loadImage 'data/21A.png'
#############################

setup = ->
	createCanvas img.width, img.height
	fc()
	sc 0
	sw 2
	textSize R
	textAlign LEFT,TOP

draw = ->
	image img, 0,0
	circle mouseX,mouseY,R
	sc 1
	point mouseX,mouseY
	sc 0
	text points.length+1,mouseX+0.7*R,mouseY+0.7*R

mousePressed = ->
	points.push [round(mouseX), round(mouseY)]
	arr = points.map (value,i) -> "\t\"#{i+1}\": [#{value}],"
	console.log "\n" + arr.join "\n"
