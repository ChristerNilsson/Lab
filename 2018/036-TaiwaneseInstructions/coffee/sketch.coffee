setup = -> 
	createCanvas 600,500
	textSize 20
	makeCommands()
	xdraw()

addText = -> commands.push arguments 
addLine = -> commands.push arguments 
addComment = -> commands.push arguments 

ticks = [3,11,13]
rests = [2,7,10]

commands = []

index = 1

makeCommands = ->
	addText  0,0,0,"Använd tangenterna LEFT och RIGHT"

	addText 0,0,0,"Vi vill ta reda på vilka klockor man ska klicka på"
	addText 0,0,0,"Exempel: Klockor:[3,11,13] Rester:[2,7,10] Steg:8"

	for i in range 3
		addText ticks[i],20,20+30*i,"Skriv upp klockorna"

	for i in range 3
		addText rests[i],60,20+30*i,"Skriv upp resterna"

# addText 13,200,200,"Avbryt då de två största är lika"
# addText 13,200,200,"Kontrollera att de mindre klockorna är ok"

	addText 18,100,50,"Vrid klockan med näst störst värde. 11+7"
	addText 23,100,80,"Vrid klockan med näst störst värde. 13+10"
	addText 29,140,50,"Vrid klockan med näst störst värde. 11+18"
	addText 36,140,80,"Vrid klockan med näst störst värde"
	addText 40,180,50,"Vrid klockan med näst störst värde"
	addText 49,180,80,"Vrid klockan med näst störst värde"
	addText 51,220,50,"Vrid klockan med näst störst värde"
	addText 62,220,80,"Vrid klockan med näst störst värde"
	addText 62,260,50,"Vrid klockan med näst störst värde"

	addText 0,0,0,"De två största klockorna är nu lika. Kontrollera att alla klockor är ok"
	addText 2,60,20,"(62-2=60) modulo 3 är noll"
	addText 7,60,50,"(62-7=55) modulo 11 är noll"
	addText 10,60,80,"(62-10=52) modulo 13 är noll"
	addText 62,260,50,"Detta innebär att summan 62 är den vi söker"

	addText 0,0,0,"Nu skapar vi en differensmatris som vi kommer att behöva senare"

	# Differensmatrisen
	addText 3,60,140,"Skriv upp klockornas kolumnrubriker"
	addText 11,100,140,"Skriv upp klockornas kolumnrubriker"
	addText 13,140,140,"Skriv upp klockornas kolumnrubriker"

	addText 3,20,170,"Skriv upp klockornas radrubriker"
	addText 11,20,200,"Skriv upp klockornas radrubriker"
	addText 13,20,230,"Skriv upp klockornas radrubriker"

	for j in range 3
		for i in range 3
			x = 60+40*i
			y = 170+30*j
			addText ticks[i]-ticks[j],x,y,"Differensen blir #{ticks[i]} - #{ticks[j]}"

	addText 0,0,0,"Nu ska de åtta stegen fördelas på de tre klockorna"

	addText 3,60,270,"Skriv upp klockornas kolumnrubriker"
	addText 11,100,270,"Skriv upp klockornas kolumnrubriker"
	addText 13,140,270,"Skriv upp klockornas kolumnrubriker"
	addText 'Uppnå 62 med 8 steg',200,270

	addText 3,60,300,"Fördela inledningsvis stegen jämnt på klockorna"
	addText 3,100,300,"Fördela stegen jämnt på klockorna"
	addText 2,140,300,"Fördela stegen jämnt på klockorna"

	addText '3*3', 200,300,"Beräkna summan"
	addText '+ 3*11',240,300,"Beräkna summan"
	addText '+ 2*13',300,300,"Beräkna summan"
	addText '= 68',360,300,"Beräkna summan. Vi ligger alltså sex snäpp för högt."
	addText '62-68=-6',440,300,"I matrisen kan vi erhålla -6 genom att använda 2 och -8"

	addText '2',60+40*2,170+30*1,"2"
	addText '-8',60+40*0,170+30*1,"-8"

	addText -1,100,330,"2 uppnås genom att flytta 11 till 13"
	addText 1,140,330
	addText 'Ger summan 68 + 2 = 70',200,330

	addText -1,100,360,"-8 uppnås genom att flytta 11 till 3"
	addText 1,60,360
	addText 'Ger summan 70 - 8 = 62',200,360

	addText 4,60,390,"Beräkna det justerade antalet 3 +1 = 4"
	addText 1,100,390,"Beräkna det justerade antalet 3 -1 -1 = 1"
	addText 3,140,390,"Beräkna det justerade antalet 2 +1 = 3"
	addText "4*3 + 1*11 + 3+13 = 12 + 11 + 39 = 62",200,390,"Kontroll av summa"

	addText 0,0,0,"Dvs, klicka 4, 1 samt 3 gånger på klockorna"

xdraw = ->
	bg 0.5
	for i in range index
		[txt,x,y] = commands[i]
		if i==index-1 then fc 1,1,0 else fc 0 
		text txt,x,y
	command = commands[index-1]
	if command.length >= 4
		fc 0
		text command[3],0,height-10

keyPressed = ->
	if keyCode == LEFT_ARROW then index--
	if keyCode == RIGHT_ARROW then index++
	index = constrain index,0,commands.length
	xdraw()
