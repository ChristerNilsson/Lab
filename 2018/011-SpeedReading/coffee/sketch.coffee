data = """
Inför köttfri dag i skolan!
På vår skola serveras det varje dag någon typ av kött i matsalen. Är det inte
hamburgare eller bacon så är det köttbullar och korvar av olika slag. Men
behöver vi verkligen ha kött varje dag? Nej, vi vill att skolan inför minst en
köttfri dag en gång i veckan.
Varför?
För det första är det inte miljövänligt att äta kött. Det krävs tio gånger
mer energi för att producera kött än vad det krävs för att producera
grönsaker.
För det andra är det nyttigt att ha en köttfri dag. Enligt Livsmedelsverket
kan vi sänka vårt intag av kött med hälften och fortfarande må bra.
För det tredje skulle en köttfri dag i veckan leda till att efterfrågan på
kött skulle minska. Detta skulle i sin tur leda till bättre djurhållning och
mindre lidande för djuren. En köttfri dag leder alltså till tre goda ting: Bättre
miljö, bättre hälsa och bättre djurhållning. Nu kanske några menar att det
räcker med att använda ekologiskt kött istället för importerat. Men fakta
kvarstår fortfarande. En köttfri dag i veckan är bättre! Däremot får skolan
gärna servera ekologiskt kött de andra fyra dagarna!
Vår förhoppning är att alla skolor i kommunen från och med nästa
termin inför en köttfri dag. Vi uppmanar alla elevråd i kommunen att kräva
en köttfri dag i skolan!
Miljövännen, Hälsofreaket och Djurrättsaktivisten
"""
arr = null
iWord = 0
iLetter = 0
limit = 0
fr = 1

setup = ->
	createCanvas 200,200
	data = data.replace /\n/g," "
	arr = data.split ' '
	textAlign CENTER,CENTER
	textSize 20
	frameRate fr

draw = ->
	if iLetter >= limit and iWord < arr.length
		bg 0
		fc 1,1,0
		text arr[iWord],100,100
		iLetter=0
		limit = 1 + arr[iWord].length
		iWord++
		fc 0.5
		text "#{fr} tecken per sekund",100,180
	else
		iLetter++
	fr = Math.ceil (1+mouseX)/10
	frameRate fr

mousePressed = -> iWord = 0
