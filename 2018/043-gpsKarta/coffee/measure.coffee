# Denna fil användes istället för sketch.coffee när man ska kalibrera en ny karta
# Klicka på tydliga referenspunkter i de fyra hörnen
# T ex vägskäl, hus, broar, kraftledningar, osv
# Avläs koordinaterna med tangent F12

img = null 

preload = -> img = loadImage '2019-Sommar.jpg'

setup = ->
	createCanvas img.width, img.height
	image img, 0,0, width,height
	print img

mousePressed = ->	print round(mouseX), round(mouseY)
