s = null
f = null
highscore = 0
timer = 2000
images = null

preload = -> images = (loadImage for filename in 'plan.jpg fotboll.png kalkyl.png kalkyl_vinst.png'.split ' ')
setup = ->
	createCanvas images[0].width,images[0].height
	textAlign CENTER,CENTER
	s = {x:200,     y:height/2}
	f = {x:width/2, y:height/2}
	textSize 100
	
draw = ->
	bg 0
	
	fc 1,1,0,0.25
	image images[0], 0, 0 
	text "Tid kvar: "+timer, width/2, 100
	text "Antal fotbollar: "+highscore, width/2, height-100

	image images[1], f.x-25, f.y-30, 50,50
	image images[2], s.x-70, s.y-80, 100,100

	if keyIsDown UP_ARROW    then s.y = (s.y-5) %% height 
	if keyIsDown DOWN_ARROW  then s.y = (s.y+5) %% height
	if keyIsDown LEFT_ARROW  then s.x = (s.x-5) %% width
	if keyIsDown RIGHT_ARROW then s.x = (s.x+5) %% width

	timer--

	if 50 > dist s.x,s.y, f.x, f.y
		f = {x : random(50,width-50),	y : random(50,height-50)}
		highscore += 1

	if timer == 0
		noLoop()
		bg 0
		image images[3],0,50 
		fc 1
		text highscore, 100, 100
