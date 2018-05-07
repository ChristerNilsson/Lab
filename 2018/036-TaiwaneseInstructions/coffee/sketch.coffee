WIDTH  = 10 # pixels per character
HEIGHT = 23 # pixels per character

setup = -> 
	createCanvas 800,600
	textSize 20
	textFont 'monospace'
	strokeCap SQUARE
	makeCommands()
	xdraw()

# negativt x innebär högerjustering. Characters, not pixels
addText = -> commands.push arguments 
addLine = -> commands.push arguments 

ticks = [3,11,13]
rests = [2,7,10]
commands = []
index = 1

# characters, not pixels
gridLines = (x,y,w,h,xCount,yCount) ->
	sc 0
	sw 1	
	for i in range xCount+1
		line WIDTH*(0.5+x+w*i), HEIGHT*y, WIDTH*(0.5+x+w*i), HEIGHT*(y+yCount*h)
	for j in range yCount+1
		line WIDTH*(0.5+x), HEIGHT*(y+h*j), WIDTH*(0.5+x+xCount*w), HEIGHT*(y+h*j)

makeCommands = ->
	addText  '',0,0,"Använd piltangenterna"

	addText "Problem:",0,0,"Tag reda på vilka klockor man ska klicka på"
	addText "Klockor: [3,11,13]",10,0
	addText "Rester:  [2, 7,10]",10,1
	addText "Steg: 8",10,2
	addText "(% innebär modulo, dvs resten vid heltalsdivision)",20,2
	addText "Lösning:",0,3

	for i in range 3
		addText ticks[i],-4,4+i,"Klocka #{ticks[i]}"

	for i in range 3
		addText rests[i],-8,4+i,"Rest #{rests[i]}"

	addLine 8,4,8,7,3

	addText 18,-12,5,"Vrid klockan med näst störst värde (7). 11 + 7 = 18"
	addText 23,-12,6,"Vrid klockan med näst störst värde (10). 13 + 10 = 23"
	addText 29,-16,5,"Vrid klockan med näst störst värde (18). 11 + 18 = 29"
	addText 36,-16,6,"Vrid klockan med näst störst värde"
	addText 40,-20,5,"Vrid klockan med näst störst värde"
	addText 49,-20,6,"Vrid klockan med näst störst värde"
	addText 51,-24,5,"Vrid klockan med näst störst värde"
	addText 62,-24,6,"Vrid klockan med näst störst värde"
	addText 62,-28,5,"Vrid klockan med näst störst värde"

	addText '',0,0,"De två största klockorna har nu samma värde. Summa=62"
	addText '',0,0,"Kontrollera att alla klockor uppfyller summa % klocka = rest"
	addText 2,-8,4,"62 % 3 = 2"
	addText 7,-8,5,"62 % 11 = 7"
	addText 10,-8,6,"62 % 13 = 10"
	
	addText 62,-28,5,"Detta innebär att summan 62 är den vi söker"

	addText '',0,0,"Nu skapar vi en differensmatris som vi kommer att behöva senare"

	# Differensmatrisen
	addText 3,-8,8,"till-klocka 3"
	addText 11,-12,8,"till-klocka 11"
	addText 13,-16,8,"till-klocka 13"
	addLine 0,9,16,9,3
	addText 'Till',17,8,"Dessa klockor utgör till-klockor"

	addText 3,-4,9,"från-klocka 3"
	addText 11,-4,10,"från-klocka 11"
	addText 13,-4,11,"från-klocka 13"
	addLine 4,8,4,12,3
	addText 'Från',0,12,"Dessa klockor utgör från-klockor"

	for j in range 3
		for i in range 3
			x = -8-4*i
			y = 9+j
			if ticks[i] != ticks[j]
				addText ticks[i]-ticks[j],x,y,"Differensen blir #{ticks[i]} - #{ticks[j]} = #{ticks[i] - ticks[j]}"

	addText '',0,0,"Nu ska de åtta stegen fördelas på de tre klockorna"

	addText 3,-8,14,"Skriv upp klockornas kolumnrubriker"
	addText 11,-12,14,"Skriv upp klockornas kolumnrubriker"
	addText 13,-16,14,"Skriv upp klockornas kolumnrubriker"

	addLine 4,15,16,15,3

	addText 'Uppnå summan 62 med 8 steg',20,14

	addText 3,-8,15,"Fördela de 8 stegen på de 3 klockorna efter eget behag"
	addText 3,-12,15,"Fördela de 8 stegen på de tre klockorna efter eget behag"
	addText 2,-16,15,"Fördela de 8 stegen på de tre klockorna efter eget behag"
	addLine 4,16,16,16,2

	addText '3*3 + 3*11 + 2*13 = 68',20,15,"Beräkna en ny summa, 68. Den måste minskas med 6 för att bli 62"
	addText '',0,0,"I matrisen kan vi erhålla -6, dvs 62-68, genom att addera 2 och -8"

	addText '2',-16,10,"Här är 2"
	addText '-8',-8,10,"Här är -8"

	addText '-1',-12,16,"2 uppnås genom att minska antalet steg på klocka 11 ..."
	addText '+1',-16,16,"... och öka antalet steg på klocka 13"
	addText 'Flytta ett steg från klocka 11 till klocka 13',20,16,"Observera att ibland blir -2, +3 osv nödvändigt"

	addText '-1',-12,17,"-8 uppnås genom att minska antalet steg på klocka 11 ..."
	addText '+1',-8,17,"... och öka antalet steg på klocka 3"
	addText 'Flytta ett steg från klocka 11 till klocka 3',20,17,"Observera att stegantalet ej kan vara negativt"
	addLine 4,18,16,18,3

	addText 4,-8, 18,"Beräkna det justerade antalet 3 +1 = 4"
	addText 1,-12,18,"Beräkna det justerade antalet 3 -1 -1 = 1"
	addText 3,-16,18,"Beräkna det justerade antalet 2 +1 = 3"
	addText "4*3 + 1*11 + 3*13 = 62",20,18,"Kontroll av summa"

	addText "Svar: Klicka 4, 1 samt 3 gånger på klockorna",0,20,"Ibland kan man behöva utföra fler flyttningar"
	addText "",0,0,"Ibland kan man finna flera lösningar"

	#index = 70 #commands.length

xdraw = ->
	bg 0.5

	gridLines 0,4,4,1,10,3
	gridLines 0,8,4,1,4,4 
	gridLines 4,14,4,1,3,5

	for i in range index
		if commands[i].length == 5 # line
			[x1,y1,x2,y2,d] = commands[i]
			sw d
			if i==index-1 then sc 1,1,0 else sc 0 
			line WIDTH*(x1+0.5),HEIGHT*y1,WIDTH*(x2+0.5),HEIGHT*y2
		else 
			[txt,x,y] = commands[i]
			if x < 0 then textAlign RIGHT,TOP else textAlign LEFT,TOP 
			if i==index-1 then fc 1,1,0 else fc 0 
			sc()
			text txt,WIDTH*abs(x),HEIGHT*y
	command = commands[index-1]
	fc 0
	sc()
	if command.length == 4
		textAlign LEFT,BOTTOM
		text command[3],10,height-10
	textAlign RIGHT,BOTTOM
	text '#' + index,width-10,height-10

move = (delta) ->
		if delta == -1
			lstr = [commands.length,47,30,7,1]
			i = _.findIndex lstr, (x) => index > x
			if i==-1 then return
			index = lstr[i]
		else
			lst = [1,7,30,47,commands.length]
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
