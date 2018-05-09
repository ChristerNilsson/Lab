# negativt x innebär högerjustering. Characters, not pixels

WIDTH  = 10 # pixels per character
HEIGHT = 23 # pixels per character

objects = []
index = 0

setup = -> 
	createCanvas 800,600
	textSize 20
	textFont 'monospace'
	strokeCap SQUARE
	makeCommands()
	index = 1
	xdraw()

class Text 
	constructor : (@txt,@x,@y,@comment='') -> # relative characters
	draw : (i) ->
		if i >= index then return 
		if @x < 0 then textAlign RIGHT,TOP else textAlign LEFT,TOP 
		if @index == index then fc 1,1,0 else fc 0 
		sc()
		p = @parent
		text @txt,WIDTH*(p.cx + p.cw*abs(@x)), HEIGHT*(p.cy + p.ch*@y)
		if @index == index then drawComment @comment 

class Line 
	constructor : (@x1,@y1,@x2,@y2,@d,@comment='') -> # absoluta pixlar
	draw : (i) ->
		if i >= index then return 
		sw @d
		if @index == index then sc 1,1,0 else sc 0 
		line @x1, @y1, @x2, @y2
		if @index == index then drawComment @comment

class Grid 
	constructor : (@cx,@cy,@cw,@ch,@xCount,@yCount,@visible,@comment='') -> # characters
		index++
		@index = index
		objects.push @

	xx : (i) ->  WIDTH * (@cx + @cw*i + 0.5) # pixlar
	yy : (j) -> HEIGHT * (@cy + @ch*j) # pixlar

	add : (obj) -> 
		index++
		obj.index = index
		objects.push obj
		obj.parent = @

	horLine : (j,d,comment='') -> @add new Line @xx(0), @yy(j), @xx(@xCount), @yy(j),       d, comment		
	verLine : (i,d,comment='') -> @add new Line @xx(i), @yy(0), @xx(i),       @yy(@yCount), d, comment	

	draw : (i) ->
		if @visible and i < index 
			sw 1	
			sc 0 
			if @index == index then sc 1,1,0 else sc 0 
			for i in range @xCount+1
				line @xx(i), @yy(0), @xx(i), @yy(@yCount)
			for j in range @yCount+1
				line @xx(0), @yy(j), @xx(@xCount), @yy(j)
		if @index == index then drawComment @comment
	
drawComment = (comment) ->
	fc 0
	sc()
	textAlign LEFT,BOTTOM
	text comment,10,height-10
	textAlign RIGHT,BOTTOM
	text '#' + index,width-10,height-10

xdraw = ->
	bg 0.5
	for obj,i in objects
		obj.draw i

move = (delta) ->
	lst = indexes.concat [objects.length]
	if delta == -1
		lst.reverse()
		i = _.findIndex lst, (x) -> index > x
		if i==-1 then return
		index = lst[i]
	else
		i = _.findIndex lst, (x) -> index < x
		if i==-1 then return
		index = lst[i]

keyPressed = ->
	if keyCode == LEFT_ARROW then index--
	if keyCode == RIGHT_ARROW then index++
	if keyCode in [UP_ARROW,33] then move -1 
	if keyCode in [DOWN_ARROW,34] then move 1
	if keyCode == 36 then index = 1
	if keyCode == 35 then index = objects.length 
	index = constrain index,1,objects.length
	xdraw()

mouseWheel = (event) ->
	index += event.delta/100
	index = constrain index,1,objects.length
	xdraw()
	false # blocks page scrolling
