ticks = [2,3,5,7]
rests = [0,1,2,3]
# summa 52
# steps 9

g0=null
g1=null
g2=null
g3=null
indexes = null

makeCommands = ->
	g0 = new Grid 0, 0, 1,1,100,30,false,'Taiwanese Remainder 2: Använd piltangenterna eller mushjulet'

	g0.add new Text "Exempel 2:",0,0,"Tag reda på vilka klockor man ska klicka på"
	g0.add new Text "Klockor: [#{ticks}]",12,0
	g0.add new Text "Rester:  [#{rests}]",12,1
	g0.add new Text "Steg: 9",12,2
	g0.add new Text "(% innebär modulo, dvs resten vid heltalsdivision)",22,2
	g0.add new Text "Lösning:",0,3

	g1 = new Grid 0, 4, 4,1, 12, ticks.length,true,'Chinese Remainders'
	for i in range ticks.length
		g1.add new Text ticks[i],-1,i,"Klocka #{ticks[i]}"
	for i in range rests.length
		g1.add new Text rests[i],-2,i,"Rest #{rests[i]}"
	g1.verLine 2,3 
	g1.add new Text 7,-3,2,"Vrid näst största klockan (5). 5 + 2 = 7"
	g1.add new Text 10,-3,3,"Vrid största klockan (7). 7 + 3 = 10"
	g1.add new Text 12,-4,2,"Vrid klockan med näst störst värde (7). 5 + 7 = 12"
	g1.add new Text 17,-4,3,"Vrid klockan med näst störst värde"
	g1.add new Text 17,-5,2,"Vrid klockan med näst störst värde. Observera att 17 % 2 != 0"
	g1.add new Text 24,-5,3,"Vrid klockan med näst störst värde"
	g1.add new Text 22,-6,2,"Vrid klockan med näst störst värde"
	g1.add new Text 31,-6,3,"Vrid klockan med näst störst värde"
	g1.add new Text 27,-7,2,"Vrid klockan med näst störst värde"
	g1.add new Text 32,-8,2,"Vrid klockan med näst störst värde"
	g1.add new Text 38,-7,3,"Vrid klockan med näst störst värde"
	g1.add new Text 37,-9,2,"Vrid klockan med näst störst värde"
	g1.add new Text 42,-10,2,"Vrid klockan med näst störst värde"
	g1.add new Text 45,-8,3,"Vrid klockan med näst störst värde"
	g1.add new Text 47,-11,2,"Vrid klockan med näst störst värde"
	g1.add new Text 52,-9,3,"Vrid klockan med näst störst värde"
	g1.add new Text 52,-12,2,"Vrid klockan med näst störst värde"

	g1.add new Text '', 0,0,"De två största klockorna har nu samma värde. Summa=52"
	g1.add new Text '', 0,0,"Kontrollera att alla klockor uppfyller summa % klocka = rest"
	g1.add new Text 'ok', 12.5,0,"52 % 2 = 0"
	g1.add new Text 'ok', 12.5,1,"52 % 3 = 1"
	g1.add new Text 'ok', 12.5,2,"52 % 5 = 2"
	g1.add new Text 'ok', 12.5,3,"52 % 7 = 3"
	g1.add new Text 'Summa: 52',12.5,4,"Detta innebär att summan 52 är den vi söker"

	g0.add new Text '',0,0,"Nu skapar vi en differensmatris som vi kommer att behöva senare"

	g2 = new Grid 0, 9, 4,1,  ticks.length+1, ticks.length+1,true,'Differensmatris'

	g2.add new Text 2,-1,4,"från klocka 2"
	g2.add new Text 3,-2,4,"från klocka 3"
	g2.add new Text 5,-3,4,"från klocka 5"
	g2.add new Text 7,-4,4,"från klocka 7"
	
	g2.horLine 4,3 
	g2.add new Text 'Från',5.2,4,"Dessa klockor utgör från-klockor"

	g2.add new Text 2,-5,0,"till klocka 2"
	g2.add new Text 3,-5,1,"till klocka 3"
	g2.add new Text 5,-5,2,"till klocka 5"
	g2.add new Text 7,-5,3,"till klocka 7"
	g2.verLine 4,3 
	g2.add new Text 'Till',5.2,0,"Dessa klockor utgör till-klockor"

	for j in range ticks.length
		for i in range ticks.length
			x = -1-i
			y = j
			if ticks[i] != ticks[j]
				g2.add new Text ticks[j]-ticks[i],x,y,"Differensen blir #{ticks[j]} - #{ticks[i]} = #{ticks[j] - ticks[i]}"

	g0.add new Text '',0,0,"Nu ska de 9 stegen fördelas på de 4 klockorna"

	g3 = new Grid 0,15, 4,1, 4,6,true,'Ryggsäcksproblemet'
	g3.add new Text 2,-1,0,"Skriv upp klockornas kolumnrubriker"
	g3.add new Text 3,-2,0,"Skriv upp klockornas kolumnrubriker"
	g3.add new Text 5,-3,0,"Skriv upp klockornas kolumnrubriker"
	g3.add new Text 7,-4,0,"Skriv upp klockornas kolumnrubriker"
	g3.horLine 1,3  
	g3.add new Text 'Uppnå summan 52 med 9 steg',5,0
	g3.add new Text 3,-1,1,"Fördela de 9 stegen på de 4 klockorna efter eget behag"
	g3.add new Text 2,-2,1,"Fördela de 9 stegen på de 4 klockorna efter eget behag"
	g3.add new Text 2,-3,1,"Fördela de 9 stegen på de 4 klockorna efter eget behag"
	g3.add new Text 2,-4,1,"Fördela de 9 stegen på de 4 klockorna efter eget behag"
	g3.horLine 2,2 
	g3.add new Text '3*2 + 2*3 + 2*5 + 2*7 = 36  (3+2+2+2=9)',5,1,"Beräkna en ny summa, 36. Den måste ökas med 16 för att bli 52"
	g3.add new Text '',0,0,"I matrisen kan vi erhålla +16, genom att addera 5,5,4 och 2"

	g2.add new Text '5',-1,3,"Här är 2 till 7"
	g2.add new Text '4',-2,3,"Här är 3 till 7"
	g2.add new Text '2',-3,3,"Här är 5 till 7"

	g3.add new Text '-2',-1,2,"10 uppnås genom att minska antalet steg med 2 för klocka 2 ..."
	g3.add new Text '+2',-4,2,"... och öka antalet steg med 2 för klocka 7"
	g3.add new Text 'Flytta två steg från klocka 2 till klocka 7',5,2

	g3.add new Text '-1',-2,3,"4 uppnås genom att minska antalet steg med 1 för klocka 3 ..."
	g3.add new Text '+1',-4,3,"... och öka antalet steg med 1 för klocka 7"
	g3.add new Text 'Flytta ett steg från klocka 3 till klocka 7',5,3,"Observera att stegantalet för en klocka ej kan vara negativt"

	g3.add new Text '-1',-3,4,"2 uppnås genom att minska antalet steg med 1 för klocka 5 ..."
	g3.add new Text '+1',-4,4,"... och öka antalet steg med 1 för klocka 7"
	g3.add new Text 'Flytta ett steg från klocka 5 till klocka 7',5,4
	g3.horLine 5,3 

	g3.add new Text 1,-1,5,"Beräkna det justerade antalet 3 -2 = 1"
	g3.add new Text 1,-2,5,"Beräkna det justerade antalet 2 -1 = 1"
	g3.add new Text 1,-3,5,"Beräkna det justerade antalet 2 -1 = 1"
	g3.add new Text 6,-4,5,"Beräkna det justerade antalet 2 +2 +1 +1 = 6"
	g3.add new Text "1*2 + 1*3 + 1*5 + 6*7 = 52  (1+1+1+6=9)",5,5,"Kontroll av summa"

	g0.add new Text "Svar: Klicka 1, 1, 1 samt 6 gånger på klockorna",0,23,"Ibland kan man behöva utföra fler flyttningar"
	g0.add new Text "",0,0,"Ibland kan man finna flera lösningar"

	indexes = [g0.index,g1.index,g2.index,g3.index]