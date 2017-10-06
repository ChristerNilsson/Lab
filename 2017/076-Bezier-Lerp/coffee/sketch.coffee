t = 0
level = 0
lst = []

setup = ->
	createCanvas 500,500
	lst = [[50,450], [50,50], [450,50],[450,450]]
	[a,b,c,d] = lst

	start = millis()
	for t in range 0,1,0.000001
		bezierPointOrig 5.0,4.50,5.0,5.0,t
		#z = 0.5*0.5*0.5
		#bezierOriginal 50,450,50,50,450,50,450,450,t # 1941
	print millis()-start

	start = millis()
	for t in range 0,1,0.000001
		bezierPt 5.0,4.50,5.0,5.0,t
		#z = Math.pow(0.5,3)
		#bezierP 50,450,50,50,450,50,450,450,t # 256
	print millis()-start

ff = (a,b,t,lvl) ->
	[x1,y1] = lst[a]
	[x2,y2] = lst[b]
	x = lerp x1,x2,t
	y = lerp y1,y2,t
	lst.push [x,y]
	if lvl <= level
		line x1,y1,x2,y2
		circle x,y,5

bezierPointOrig = (a, b, c, d, t) ->
  adjustedT = 1-t
  Math.pow(adjustedT,3)*a +
   3*(Math.pow(adjustedT,2))*t*b +
   3*adjustedT*Math.pow(t,2)*c +
   Math.pow(t,3)*d


bezierPt = (a,b,c,d,t) ->
	x = 1-t
	x*x*x*a + 3*x*x*t*b + 3*x*t*t*c + t*t*t*d
	#x*x*x*a + 3*x*t*(x*b + t*c) + t*t*t*d

# bezierP = (lst,t) ->
# 	[a,b,c,d] = lst
# 	x = bezierPt a[0],b[0],c[0],d[0],t
# 	y = bezierPt a[1],b[1],c[1],d[1],t
# 	[x,y]

# bezierOriginal = (lst,t) ->
# 	[a,b,c,d] = lst
# 	x = bezierPoint a[0],b[0],c[0],d[0],t
# 	y = bezierPoint a[1],b[1],c[1],d[1],t
# 	[x,y]

bezierP = (a,b,c,d,e,f,g,h,t) ->
	x = bezierPt a,b,c,d,t
	y = bezierPt e,f,g,h,t
	[x,y]

bezierOriginal = (a,b,c,d,e,f,g,h,t) ->
	x = bezierPoint a,b,c,d,t
	y = bezierPoint e,f,g,h,t
	[x,y]


bpp = (lst,t) ->
	[a,b,c,d] = lst
	x = bp5 a[0],b[0],c[0],d[0],t
	y = bp5 a[1],b[1],c[1],d[1],t
	[x,y]


bez = (lst,t) -> # 8 ggr långsammare än bezierPoint pga onödig rek. bl a.
	if lst.length==2
		[a,b] = lst
		[x1,y1] = a
		[x2,y2] = b
		[lerp(x1,x2,t), lerp(y1,y2,t)]
	else
		a = bez lst[0..-2],t
		b = bez lst[1..-1],t
		bez [a,b],t


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
	ff 0,1,t,1
	ff 1,2,t,1
	ff 2,3,t,1

	fc 1,0,0
	ff 4,5,t,2
	ff 5,6,t,2

	fc 1,1,0
	ff 7,8,t,3

keyPressed =  ->
	if keyCode == DOWN_ARROW then level -= 1
	if keyCode == UP_ARROW   then level += 1
	level = constrain level, 0,3
