s = null
f = null
highscore = null
timer = null

img0 = null
img1 = null
img2 = null
img3 = null

preload = ->
	img0 = loadImage "plan.jpg"
	img1 = loadImage "fotboll.png"
	img2 = loadImage "kalkyl.png"
	img3 = loadImage "kalkyl_vinst.png"

setup = ->
	createCanvas img0.width,img0.height
	textAlign CENTER,CENTER
	s = 
		x: 200
		y: height/2

	f = 
		x: width/2
		y: height/2

	highscore = 0
	timer = 2000
	textSize 100
	
draw = ->
	bg 0
	
	fc 1,1,0,0.25
	image img0, 0, 0 
	text "Tid kvar: "+timer, width/2, 100
	text "Antal fotbollar: "+highscore, width/2, height-100

	image img1, f.x-25, f.y-30, 50,50
	image img2, s.x-70, s.y-80, 100,100

	if keyIsDown UP_ARROW    then s.y = (s.y-5) %% height 
	if keyIsDown DOWN_ARROW  then s.y = (s.y+5) %% height
	if keyIsDown LEFT_ARROW  then s.x = (s.x-5) %% width
	if keyIsDown RIGHT_ARROW then s.x = (s.x+5) %% width

	timer--

	if 50 > dist s.x,s.y, f.x, f.y
		f = 
			x : random 50,width-50
			y : random 50,height-50
		highscore += 1

	if timer == 0
		noLoop()
		bg 0
		image img3,0,50 
		fc 1
		text highscore, 100, 100
