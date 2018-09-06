person = {}
enemy = {}

events = {}
data = [] # texts and buttons

Black  = (txt) -> t txt,0,0,0
Green  = (txt) -> t txt,0,1,0
Red    = (txt) -> t txt,1,0,0
Yellow = (txt) -> t txt,1,1,0
t = (txt,r,g,b) -> data.push {txt,r,g,b}
button = (name,txt='') -> data.push {name,txt} 
display = (txt) -> events[txt]()
goto = (loc) -> display loc
rand = (a,b) -> int a + random b-a

setup = ->
	createCanvas 600,600
	textSize 16
	events.Start()

draw = ->
	bg 0.75
	for item,i in data
		if 'name' of item # button
			s = item.txt
			if s == '' then s = item.name
			fc 0,0,1
			text s,20,20+20*i
		else # text
			{txt,r,g,b} = item
			fc r,g,b
			text txt,20,20+20*i

mousePressed = ->
	for item,i in data 
		if 'name' in _.keys item 
			if 20*i < mouseY < 20+20*i
				data = []
				events[item.name]()
	print JSON.stringify person
