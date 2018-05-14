ticks = [3,11,13]
rests = [2,7,10]

g0=null
g1=null
g2=null
indexes = null

makeCommands = ->
	g0 = new Grid 0, 0, 1,1,100,30,false,'Taiwanese Remainder 1: Använd piltangenterna eller mushjulet'

	g0.add new Text "Exempel 1:",0,0,"Tag reda på vilka klockor man ska klicka på"
	g0.add new Text "Klockor: [3,11,13]",12,0
	g0.add new Text "Rester:  [2, 7,10]",12,1
	g0.add new Text "Steg: 8",12,2
	g0.add new Text "(% innebär modulo, dvs resten vid heltalsdivision)",22,2
	g0.add new Text "Lösning:",0,3

	g1 = new Grid 0, 4, 4,1, 7, 3,true,'Chinese Remainders'
	for i in range 3
		g1.add new Text ticks[i],-1,i,"Klocka #{ticks[i]}"
	for i in range 3
		g1.add new Text rests[i],-2,i,"Rest #{rests[i]}"
	g1.verLine 2,3 
	g1.add new Text 18,-3,1,"Vrid näst största klockan (11). 11 + 7 = 18"
	g1.add new Text 23,-3,2,"Vrid största klockan (13). 13 + 10 = 23"
	g1.add new Text 29,-4,1,"Vrid klockan med näst störst värde (18). 11 + 18 = 29"
	g1.add new Text 36,-4,2,"Vrid klockan med näst störst värde"
	g1.add new Text 40,-5,1,"Vrid klockan med näst störst värde"
	g1.add new Text 49,-5,2,"Vrid klockan med näst störst värde"
	g1.add new Text 51,-6,1,"Vrid klockan med näst störst värde"
	g1.add new Text 62,-6,2,"Vrid klockan med näst störst värde"
	g1.add new Text 62,-7,1,"Vrid klockan med näst störst värde"
	g1.add new Text '', 0,0,"De två största klockorna har nu samma värde. Summa=62"
	g1.add new Text '', 0,0,"Kontrollera att alla klockor uppfyller summa % klocka = rest"
	g1.add new Text 'ok', 7.5,0,"62 % 3 = 2"
	g1.add new Text 'ok', 7.5,1,"62 % 11 = 7"
	g1.add new Text 'ok',7.5,2,"62 % 13 = 10"
	g1.add new Text 'Summa: 62',7.5,3,"Detta innebär att summan 62 är den vi söker"

	g0.add new Text '',0,0,"Nu skapar vi en differensmatris som vi kommer att behöva senare"

	g2 = new Grid 0, 9, 4,1,  ticks.length+1, ticks.length+1,true,'Differensmatris'

	g2.add new Text 3,-1,3,"från klocka 3"
	g2.add new Text 11,-2,3,"från klocka 11"
	g2.add new Text 13,-3,3,"från klocka 13"
	
	g2.horLine ticks.length,3 
	g2.add new Text 'Från',4.2,3,"Dessa klockor utgör från-klockor"

	g2.add new Text 3,-4,0,"till klocka 3"
	g2.add new Text 11,-4,1,"till klocka 11"
	g2.add new Text 13,-4,2,"till klocka 13"
	g2.verLine ticks.length,3 
	g2.add new Text 'Till',4.2,0,"Dessa klockor utgör till-klockor"

	for j in range ticks.length
		for i in range ticks.length
			x = -1-i
			y = j
			if ticks[i] != ticks[j]
				g2.add new Text ticks[j]-ticks[i],x,y,"Differensen blir #{ticks[j]} - #{ticks[i]} = #{ticks[j] - ticks[i]}"

	g0.add new Text '',0,0,"Nu ska de åtta stegen fördelas på de tre klockorna"

	g3 = new Grid 0,14, 4,1,  3, 5,true,'Ryggsäcksproblemet'
	g3.add new Text 3,-1,0,"Skriv upp klockornas kolumnrubriker"
	g3.add new Text 11,-2,0,"Skriv upp klockornas kolumnrubriker"
	g3.add new Text 13,-3,0,"Skriv upp klockornas kolumnrubriker"
	g3.horLine 1,3 
	g3.add new Text 'Uppnå summan 62 med 8 steg',4,0
	g3.add new Text 3,-1,1,"Fördela de 8 stegen på de 3 klockorna efter eget behag"
	g3.add new Text 3,-2,1,"Fördela de 8 stegen på de tre klockorna efter eget behag"
	g3.add new Text 2,-3,1,"Fördela de 8 stegen på de tre klockorna efter eget behag"
	g3.horLine 2,2
	g3.add new Text '3*3 + 3*11 + 2*13 = 68  (3+3+2=8)',4,1,"Beräkna en ny summa, 68. Den måste minskas med 6 för att bli 62"
	g3.add new Text '',0,0,"I matrisen kan vi erhålla -6, dvs 62-68, genom att addera 2 och -8"

	g2.add new Text '2',-2,2,"Här är 2"
	g2.add new Text '-8',-2,0,"Här är -8"

	g3.add new Text '-1',-2,2,"2 uppnås genom att minska antalet steg på klocka 11 ..."
	g3.add new Text '+1',-3,2,"... och öka antalet steg på klocka 13"
	g3.add new Text 'Flytta ett steg från klocka 11 till klocka 13',4,2,"Observera att ibland blir -2, +3 osv nödvändigt"
	g3.add new Text '-1',-2,3,"-8 uppnås genom att minska antalet steg på klocka 11 ..."
	g3.add new Text '+1',-1,3,"... och öka antalet steg på klocka 3"
	g3.add new Text 'Flytta ett steg från klocka 11 till klocka 3',4,3,"Observera att stegantalet för en klocka ej kan vara negativt"
	g3.horLine 4,3

	g3.add new Text 4,-1,4,"Beräkna det justerade antalet 3 +1 = 4"
	g3.add new Text 1,-2,4,"Beräkna det justerade antalet 3 -1 -1 = 1"
	g3.add new Text 3,-3,4,"Beräkna det justerade antalet 2 +1 = 3"
	g3.add new Text "4*3 + 1*11 + 3*13 = 62",4,4,"Kontroll av summa"

	g0.add new Text "Svar: Klicka 4, 1 samt 3 gånger på klockorna",0,20,"Ibland kan man behöva utföra fler flyttningar"
	g0.add new Text "",0,0,"Ibland kan man finna flera lösningar"

	indexes = [g0.index,g1.index,g2.index,g3.index]
