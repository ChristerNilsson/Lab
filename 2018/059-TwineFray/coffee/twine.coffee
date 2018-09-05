person = {}
enemy = {}

events = {}
data = [] # texts and buttons

t = (txt) -> data.push {txt}
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
			fc 0
			text item.txt,20,20+20*i

mousePressed = ->
	for item,i in data 
		if 'name' in _.keys item 
			if 20*i < mouseY < 20+20*i
				data = []
				events[item.name]()
	print JSON.stringify person
