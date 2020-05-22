maximum = 3600
speed = 1
startX = 0
button = null
target = maximum/2
results = []
start = new Date()
cx = 0

class Button 
	constructor : (@x,@y,@r,@click) ->
	inside : (mx,my) -> dist(mx,my,@x,@y) < @r
	draw : ->
		fc()
		circle @x,@y,@r 
		fc 0
		text target,@x,@y

setup = ->
	createCanvas windowWidth,windowHeight
	button = new Button width/2,0.25*height,50, ->
		if target == int cx
			stopp = new Date()
			results.push stopp - start
			target = _.random 0,maximum
			button.prompt = target
			start = new Date()
	textSize 32
	textAlign CENTER,CENTER
	fc 0
	target = _.random 0,maximum

draw = ->
	bg 0.5
	fc 0
	text int(cx),width/2,height/2
	button.draw()
	for result,i in results
		res = result/1000
		if res < 10 then fc 0 else fc 1,0,0
		text result/1000,100,(i+1)*height/10

mousePressed = ->
	if button.inside mouseX,mouseY 
		button.click()
	else
		startX = mouseX
		speed = 0.2 + maximum/width * abs(mouseX - width/2) / (width/2)

mouseDragged = ->
	if button.inside mouseX,mouseY 
	else
		cx += speed * (mouseX - startX)
		cx = constrain cx,0,maximum
		startX = mouseX
