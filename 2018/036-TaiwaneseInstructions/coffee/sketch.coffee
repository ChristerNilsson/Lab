# negativt x innebär högerjustering. Characters, not pixels

WIDTH  = 10 # pixels per character
HEIGHT = 23 # pixels per character

setup = -> 
	createCanvas 800,600
	textSize 20
	textFont 'monospace'
	strokeCap SQUARE
	makeCommands()
	print objects 
	xdraw()

ticks = [3,11,13]
rests = [2,7,10]
objects = []
g0=null
g1=null
g2=null
g3=null

index = 0 

class Text 
	constructor : (@txt,@x,@y,@comment='') -> 
	draw : (i) ->
		if i >= index then return 
		if @x < 0 then textAlign RIGHT,TOP else textAlign LEFT,TOP 
		if @index == index then fc 1,1,0 else fc 0 
		sc()
		p = @parent
		text @txt,WIDTH*(p.x + p.w*abs(@x)),HEIGHT*(p.y + p.h*@y)
		if @index == index then drawComment @comment 

class Line 
	constructor : (@x1,@y1,@x2,@y2,@d,@comment='') -> 
	draw : (i) ->
		if i >= index then return 
		sw @d
		if @index == index then fc 1,1,0 else fc 0 
		p = @parent
		line WIDTH*(p.x + p.w*@x1+0.5),HEIGHT*(p.y + p.h*@y1),WIDTH*(p.x + p.w*@x2+0.5),HEIGHT*(p.y + p.h*@y2)
		if @index == index then drawComment @comment

class Grid 
	constructor : (@x,@y,@w,@h,@xCount,@yCount,@visible,@comment='') -> 
		index++
		@index = index
		objects.push @
	add : (obj) -> 
		index++
		obj.index = index
		objects.push obj
		obj.parent = @
	draw : (i) ->
		if @visible and i <= index 
			sw 1	
			sc 0 
			if @index == index then sc 1,1,0 else sc 0 
			for j in range @xCount+1
				line WIDTH*(0.5+@x+@w*j), HEIGHT*@y, WIDTH*(0.5+@x+@w*j), HEIGHT*(@y+@yCount*@h)
			for j in range @yCount+1
				line WIDTH*(0.5+@x), HEIGHT*(@y+@h*j), WIDTH*(0.5+@x+@xCount*@w), HEIGHT*(@y+@h*j)
		if @index == index then drawComment @comment
	
makeCommands = ->
	g0 = new Grid 0, 0, 1,1,100,30,false,'Taiwanese Remainders: Använd piltangenterna'

	g0.add new Text "Problem:",0,0,"Tag reda på vilka klockor man ska klicka på"
	g0.add new Text "Klockor: [3,11,13]",10,0
	g0.add new Text "Rester:  [2, 7,10]",10,1
	g0.add new Text "Steg: 8",10,2
	g0.add new Text "(% innebär modulo, dvs resten vid heltalsdivision)",20,2
	g0.add new Text "Lösning:",0,3

	g1 = new Grid 0, 4, 4,1, 10, 3,true,'Chinese Remainders'
	for i in range 3
		g1.add new Text ticks[i],-1,i,"Klocka #{ticks[i]}"
	for i in range 3
		g1.add new Text rests[i],-2,i,"Rest #{rests[i]}"
	g1.add new Line 2,0,2,3,3
	g1.add new Text 18,-3,1,"Vrid klockan med näst störst värde (7). 11 + 7 = 18"
	g1.add new Text 23,-3,2,"Vrid klockan med näst störst värde (10). 13 + 10 = 23"
	g1.add new Text 29,-4,1,"Vrid klockan med näst störst värde (18). 11 + 18 = 29"
	g1.add new Text 36,-4,2,"Vrid klockan med näst störst värde"
	g1.add new Text 40,-5,1,"Vrid klockan med näst störst värde"
	g1.add new Text 49,-5,2,"Vrid klockan med näst störst värde"
	g1.add new Text 51,-6,1,"Vrid klockan med näst störst värde"
	g1.add new Text 62,-6,2,"Vrid klockan med näst störst värde"
	g1.add new Text 62,-7,1,"Vrid klockan med näst störst värde"
	g1.add new Text '', 0,0,"De två största klockorna har nu samma värde. Summa=62"
	g1.add new Text '', 0,0,"Kontrollera att alla klockor uppfyller summa % klocka = rest"
	g1.add new Text 2, -2,0,"62 % 3 = 2"
	g1.add new Text 7, -2,1,"62 % 11 = 7"
	g1.add new Text 10,-2,2,"62 % 13 = 10"
	g1.add new Text 62,-7,1,"Detta innebär att summan 62 är den vi söker"

	g0.add new Text '',0,0,"Nu skapar vi en differensmatris som vi kommer att behöva senare"

	g2 = new Grid 0, 8, 4,1,  4, 4,true,'Differensmatris'

	g2.add new Text 3,-1,1,"från-klocka 3"
	g2.add new Text 11,-1,2,"från-klocka 11"
	g2.add new Text 13,-1,3,"från-klocka 13"
	g2.add new Line 1,0,1,4,3
	g2.add new Text 'Från',0,4,"Dessa klockor utgör från-klockor"

	g2.add new Text 3,-2,0,"till-klocka 3"
	g2.add new Text 11,-3,0,"till-klocka 11"
	g2.add new Text 13,-4,0,"till-klocka 13"
	g2.add new Line 0,1,4,1,3
	g2.add new Text 'Till',4.2,0,"Dessa klockor utgör till-klockor"

	for j in range 3
		for i in range 3
			x = -2-i
			y = 1+j
			if ticks[i] != ticks[j]
				g2.add new Text ticks[i]-ticks[j],x,y,"Differensen blir #{ticks[i]} - #{ticks[j]} = #{ticks[i] - ticks[j]}"

	g0.add new Text '',0,0,"Nu ska de åtta stegen fördelas på de tre klockorna"

	g3 = new Grid 4,14, 4,1,  3, 5,true,'Ryggsäcksproblemet'
	g3.add new Text 3,-1,0,"Skriv upp klockornas kolumnrubriker"
	g3.add new Text 11,-2,0,"Skriv upp klockornas kolumnrubriker"
	g3.add new Text 13,-3,0,"Skriv upp klockornas kolumnrubriker"
	g3.add new Line 0,1,3,1,3
	g3.add new Text 'Uppnå summan 62 med 8 steg',4,0
	g3.add new Text 3,-1,1,"Fördela de 8 stegen på de 3 klockorna efter eget behag"
	g3.add new Text 3,-2,1,"Fördela de 8 stegen på de tre klockorna efter eget behag"
	g3.add new Text 2,-3,1,"Fördela de 8 stegen på de tre klockorna efter eget behag"
	g3.add new Line 0,2,3,2,2
	g3.add new Text '3*3 + 3*11 + 2*13 = 68  (3+3+2=8)',4,1,"Beräkna en ny summa, 68. Den måste minskas med 6 för att bli 62"
	g3.add new Text '',0,0,"I matrisen kan vi erhålla -6, dvs 62-68, genom att addera 2 och -8"

	g2.add new Text '2',-4,2,"Här är 2"
	g2.add new Text '-8',-2,2,"Här är -8"

	g3.add new Text '-1',-2,2,"2 uppnås genom att minska antalet steg på klocka 11 ..."
	g3.add new Text '+1',-3,2,"... och öka antalet steg på klocka 13"
	g3.add new Text 'Flytta ett steg från klocka 11 till klocka 13',4,2,"Observera att ibland blir -2, +3 osv nödvändigt"
	g3.add new Text '-1',-2,3,"-8 uppnås genom att minska antalet steg på klocka 11 ..."
	g3.add new Text '+1',-1,3,"... och öka antalet steg på klocka 3"
	g3.add new Text 'Flytta ett steg från klocka 11 till klocka 3',4,3,"Observera att stegantalet för en klocka ej kan vara negativt"
	g3.add new Line 0,4,3,4,3

	g3.add new Text 4,-1,4,"Beräkna det justerade antalet 3 +1 = 4"
	g3.add new Text 1,-2,4,"Beräkna det justerade antalet 3 -1 -1 = 1"
	g3.add new Text 3,-3,4,"Beräkna det justerade antalet 2 +1 = 3"
	g3.add new Text "4*3 + 1*11 + 3*13 = 62",4,4,"Kontroll av summa"

	g0.add new Text "Svar: Klicka 4, 1 samt 3 gånger på klockorna",0,20,"Ibland kan man behöva utföra fler flyttningar"
	g0.add new Text "",0,0,"Ibland kan man finna flera lösningar"

	index = 1

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
	if delta == -1
		lstr = [objects.length,g3.index,g2.index,g1.index,g0.index]
		i = _.findIndex lstr, (x) => index > x
		if i==-1 then return
		index = lstr[i]
	else
		lst = [g0.index,g1.index,g2.index,g3.index,objects.length]
		i = _.findIndex lst, (x) => index < x
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
