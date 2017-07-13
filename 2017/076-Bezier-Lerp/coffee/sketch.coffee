t = 0
level = 0
lst = []

setup = ->
	createCanvas 500,500

f = (a,b,t,lvl) ->
	[x1,y1] = lst[a]
	[x2,y2] = lst[b]
	x = lerp x1,x2,t
	y = lerp y1,y2,t
	lst.push [x,y]
	if lvl <= level
		line x1,y1,x2,y2
		circle x,y,5

draw = ->
	bg 0.5
	fc()
	lst = [[50,450], [50,50], [450,50],[450,450]]

	fc 1
	for [x,y] in lst
		circle x,y,10

	if keyIsDown LEFT_ARROW  then t -= 0.005
	if keyIsDown RIGHT_ARROW then t += 0.005
	t = constrain t,0,1

	fc()
	bezier 50,450, 50,50, 450,50, 450,450

	fc 1
	f 0,1,t,1
	f 1,2,t,1
	f 2,3,t,1

	fc 1,0,0
	f 4,5,t,2
	f 5,6,t,2

	fc 1,1,0
	f 7,8,t,3

keyPressed =  ->
	if keyCode == DOWN_ARROW then level -= 1
	if keyCode == UP_ARROW   then level += 1
	level = constrain level, 0,3
