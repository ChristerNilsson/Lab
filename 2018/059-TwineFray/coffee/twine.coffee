H = 20
events = {}

texts = [] 
links = []
buttons = []

page = 'Start'


Black  = (txt) -> t txt,0,0,0
Green  = (txt) -> t txt,0,1,0
Red    = (txt) -> t txt,1,0,0
Yellow = (txt) -> t txt,1,1,0
t = (txt,r,g,b)      -> texts.push {txt,r,g,b}
link = (name,txt='') -> links.push {name,txt}
button = (txt,event) -> buttons.push {txt,event} 
display = (txt) -> events[txt]()
goto = (loc) -> display loc
rand = (a,b) -> int a + random b-a
either = _.sample

setup = ->
	createCanvas 600,600
	textSize 0.8*H
	events.Start()
	#print data 

draw = ->
	bg 0.75
	for item,i in texts
		{txt,r,g,b} = item
		fc r,g,b
		text txt,H,H+H*i
	for item,i in links
		s = item.txt
		if s == '' then s = item.name
		fc 0,0,1
		text s,H,H+H*(i+texts.length)
	for item,i in buttons
		fc 0,0,1
		text item.txt,H,H+H*(i+texts.length+links.length)
	for message,i in messages
		fc 0
		n = i+texts.length+links.length+buttons.length
		text message,H,H+H*n


clr = ->
	texts = []
	links = []
	buttons = []

mousePressed = ->
	for item,i in links 
		n = i+texts.length
		if H*n < mouseY < H+H*n
			clr()
			page = item.name
			events[item.name]()
			messages = []
			return
	for item,i in buttons 
		n = i+texts.length+links.length
		if H*n < mouseY < H+H*n
			clr()
			item.event()
			events[page]()
			messages = []
			return 
	#inventory()
	#print JSON.stringify person
