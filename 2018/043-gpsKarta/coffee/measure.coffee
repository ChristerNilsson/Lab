img = null 

preload = -> img = loadImage '2019-Vinter.jpg'

setup = ->
	createCanvas img.width, img.height
	image img, 0,0, width,height
	print img

mousePressed = ->	print round(mouseX), round(mouseY)
