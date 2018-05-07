setup = -> 
	createCanvas 800,600
	textSize 20
	textFont 'monospace'
	strokeCap SQUARE
	makeCommands()
	xdraw()

addText = -> commands.push arguments 
addLine = -> commands.push arguments 

ticks = [3,11,13]
rests = [2,7,10]

commands = []

index = 1

gridLines = (x,y,w,h,xCount,yCount) ->
	sc 0
	sw 1	
	for i in range xCount+1
		line x+w*i,y, x+w*i,y+yCount*h
	for j in range yCount+1
		line x,y+h*j,x+xCount*w,y+h*j

makeCommands = ->
	addText  0,0,0,"Använd piltangenterna"

	addText "Problem:",100,20,"Tag reda på vilka klockor man ska klicka på"
	addText "Klockor: [3,11,13]",120,20
	addText "Rester:  [2, 7,10]",120,50
	addText "Steg: 8",120,80
	addText "Lösning:",15,80+30

	#addText 0,0,0,

	for i in range 3
		addText ticks[i],40,30+125+30*i,"Skriv upp klockorna"

	for i in range 3
		addText rests[i],80,30+125+30*i,"Skriv upp resterna"

	addLine 90,30+100+4,90,30+100+94,3

	addText 18,120,30+100+55,"Vrid klockan med näst störst värde (11). 11 + 7 = 18"
	addText 23,120,30+100+85,"Vrid klockan med näst störst värde (13). 13 + 10 = 23"
	addText 29,160,30+100+55,"Vrid klockan med näst störst värde (11). 11 + 18 = 29"
	addText 36,160,30+100+85,"Vrid klockan med näst störst värde"
	addText 40,200,30+100+55,"Vrid klockan med näst störst värde"
	addText 49,200,30+100+85,"Vrid klockan med näst störst värde"
	addText 51,240,30+100+55,"Vrid klockan med näst störst värde"
	addText 62,240,30+100+85,"Vrid klockan med näst störst värde"
	addText 62,280,30+100+55,"Vrid klockan med näst störst värde"

	addText 0,0,0,"De två största klockorna har nu samma värde. Summa=62"
	addText 0,0,0,"Kontrollera att alla klockor uppfyller summa % klocka = rest"
	addText 2,80,30+100+25,"62 % 3 är 2"
	addText 7,80,30+100+55,"62 % 11 är 7"
	addText 10,80,30+100+85,"62 % 13 är 10"
	
	addText 62,280,30+155,"Detta innebär att summan 62 är den vi söker"

	addText 0,0,0,"Nu skapar vi en differensmatris som vi kommer att behöva senare"

	# Differensmatrisen
	addText 3,80,30+100+140,"Skriv upp klockornas kolumnrubriker"
	addText 11,120,30+100+140,"Skriv upp klockornas kolumnrubriker"
	addText 13,160,30+100+140,"Skriv upp klockornas kolumnrubriker"
	addLine 4,30+100+148,164,30+100+148,3

	addText 3,40,30+100+170,"Skriv upp klockornas radrubriker"
	addText 11,40,30+100+200,"Skriv upp klockornas radrubriker"
	addText 13,40,30+100+230,"Skriv upp klockornas radrubriker"
	addLine 45,30+100+119,45,30+100+238,3

	for j in range 3
		for i in range 3
			x = 80+40*i
			y = 30+100+170+30*j
			addText ticks[i]-ticks[j],x,y,"Differensen blir #{ticks[i]} - #{ticks[j]}"

	addText 0,0,0,"Nu ska de åtta stegen fördelas på de tre klockorna"

	addText 3,60,30+100+270,"Skriv upp klockornas kolumnrubriker"
	addText 11,100,30+100+270,"Skriv upp klockornas kolumnrubriker"
	addText 13,140,30+100+270,"Skriv upp klockornas kolumnrubriker"

	addLine 25,30+100+280,145,30+100+280,3

	addText 'Uppnå summan 62 med 8 steg',160,30+100+270

	addText 3,60,30+100+300,"Fördela de 8 stegen på de 3 klockorna efter eget behag"
	addText 3,100,30+100+300,"Fördela de 8 stegen på de tre klockorna efter eget behag"
	addText 2,140,30+100+300,"Fördela de 8 stegen på de tre klockorna efter eget behag"
	addLine 25,30+100+310,145,30+100+310,2

	addText '3*3 + 3*11 + 2*13 = 68',400,30+100+300,"Beräkna en ny summa, 68. Den måste minskas med 6 för att bli 62"
	addText 0,0,0,"I matrisen kan vi erhålla -6 genom att lägga ihop 2 och -8"

	addText '2',80+40*2,30+270+30*1,"Här är 2"
	addText '-8',80+40*0,30+270+30*1,"Här är -8"

	addText '-1',100,30+100+330,"2 uppnås genom att minska antalet steg på 11 ..."
	addText '+1',140,30+100+330,"... och öka antalet steg på 13"
	addText 'Ger summan 68 + 2 = 70',160,30+100+330

	addText '-1',100,30+100+360,"-8 uppnås genom att minska antalet steg på 11 ..."
	addText '+1',60,30+100+360,"... och öka antalet steg på 3"
	addText 'Ger summan 70 - 8 = 62',160,30+100+360
	addLine 25,30+100+370,145,30+100+370,3

	addText 4,60,30+100+390,"Beräkna det justerade antalet 3 +1 = 4"
	addText 1,100,30+100+390,"Beräkna det justerade antalet 3 -1 -1 = 1"
	addText 3,140,30+100+390,"Beräkna det justerade antalet 2 +1 = 3"
	addText "4*3 + 1*11 + 3*13 = 62",400,30+100+390,"Kontroll av summa"

	addLine 25,30+100+403,145,30+100+403,1

	addText 0,0,0,"Dvs, klicka 4, 1 samt 3 gånger på klockorna"

	#index = 70 #commands.length

xdraw = ->
	bg 0.5
	textAlign RIGHT

	gridLines 10,30+100+4,40,30,10,3
	gridLines 4,30+100+118,40,30,4,4 
	gridLines 25,30+100+250,40,30,3,5

	for i in range index
		if commands[i].length == 5 # line
			[x1,y1,x2,y2,d] = commands[i]
			sw d
			if i==index-1 then sc 1,1,0 else sc 0 
			line x1,y1,x2,y2
		else 
			textAlign if commands[i].length==4 then RIGHT else LEFT 
			[txt,x,y] = commands[i]
			if i==index-1 then fc 1,1,0 else fc 0 
			sc()
			text txt,x,y
	command = commands[index-1]
	fc 0
	sc()
	if command.length == 4
		textAlign LEFT
		text command[3],10,height-10
	textAlign RIGHT
	text '#' + index,width-10,height-10

move = (delta) ->
		if delta == -1
			lstr = [commands.length,47,29,6,1]
			i = _.findIndex lstr, (x) => index > x
			if i==-1 then return
			index = lstr[i]
		else
			lst = [1,6,29,47,commands.length]
			i = _.findIndex lst, (x) => index < x
			if i==-1 then return
			index = lst[i]

keyPressed = ->
	if keyCode == LEFT_ARROW then index--
	if keyCode == RIGHT_ARROW then index++
	if keyCode in [UP_ARROW,33] then move -1 
	if keyCode in [DOWN_ARROW,34] then move 1
	if keyCode == 36 then index = 1
	if keyCode == 35 then index = commands.length 
	index = constrain index,1,commands.length
	xdraw()
