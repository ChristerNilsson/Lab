pageNo = 1
img = null
rects = null
N = 35
SIZE = 40

markedAreas = {}
markedAreas[1] = [[4,7,1],[32,35,2]]
markedAreas[2] = [[14,17,3],[22,25,4]]

device = null

setup = ->
	#createCanvas 640,360
	createCanvas 1280,720
	fetch()
	frameRate 10
	device = info()
	print device

fetch = ->
	img = null
	rects = null
	loadImage "images/data#{pageNo}.png", (_img) -> img = _img
	xmlhttp = new XMLHttpRequest()    
	xmlhttp.onreadystatechange = () ->
		if this.readyState == 4 && this.status == 200
			rects = JSON.parse this.responseText
	xmlhttp.open "GET", "images/data#{pageNo}.json", true
	xmlhttp.send()

draw = ->
	bg 1
	sc()
	if rects and markedAreas[pageNo]
		for [start,stopp,color] in markedAreas[pageNo]
			for i in range start,stopp+1
				[x,y,w,h] = rects[i]
				if color==1 then fc 1,0,0
				if color==2 then fc 0,1,0
				if color==3 then fc 1,1,0
				if color==4 then fc 0,1,1
				if color > 0 then	rect x-6,y+8,w+10,SIZE-2
	if img then image img, 0, 0
	w = width/N
	p = (pageNo-1) * w
	sc 0
	y = height-2
	line p,y,p+w,y

mousePressed = ->
	if device.is_touch_device == false 
		if mouseX > width/2 then pageNo++ else pageNo--
		pageNo = constrain pageNo,1,N
		fetch()
	false 

touchEnded = ->
	if device.is_touch_device == true 
		if mouseX > width/2 then pageNo++ else pageNo--
		pageNo = constrain pageNo,1,N
		fetch()
	false 

info = ->
	ratio = window.devicePixelRatio || 1
	ratio : ratio
	is_touch_device : 'ontouchstart' in document.documentElement
	sw : screen.width 
	sh : screen.height
	cw : document.documentElement.clientWidth
	ch : document.documentElement.clientHeight
	rw : screen.width * ratio
	rh : screen.height * ratio
	