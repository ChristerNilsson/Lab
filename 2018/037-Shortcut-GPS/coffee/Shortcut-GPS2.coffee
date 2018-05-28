buttons = []

W = 8
H = 10
w = null
h = null

myround = (x,decimals=0) ->	(round x * 10**decimals) / 10**decimals	

class Button
	constructor : (@txt,@x,@y,@url,@event) ->
	draw : -> text @txt,@x,@y
	inside : (mx,my) -> @x-w/2 < mx < @x+w/2 and @y-h/2 < my < @y+h/2

setup = ->
	createCanvas windowWidth,windowHeight
	params = getParameters()
	size = params.size
	size = parseInt size.replace 'm',''
	textAlign CENTER,CENTER
	w = width/W
	h = height/H
	textSize h/2
	sc()
	for j in range H # level
		for i in range W 
			level = j+1
			nr = level + "ABCDEFGH"[i]
			seed = myround 0.1*i,1
			speed1 = "#{myround((level-1)*0.05/size,4)}"
			if level <= 5 then speed2 = 0
			else speed2 = "#{myround((level-5)*0.01/(0.3*size),4)}"
			url = "index.html?radius1=#{size}&nr=#{nr}&level=#{level}&seed=#{seed}&speed1=#{speed1}&speed2=#{speed2}"
			buttons.push new Button nr,w/2+i*w,h/2+j*h,url, -> window.open @url

draw = ->
	bg 1
	for button in buttons 
		button.draw()

mousePressed = () ->
	for button in buttons
		if button.inside mouseX,mouseY
			button.event()