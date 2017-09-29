current = 0
prompts = []
labels = []
values = []

add = (s) ->
	arr = s.split ' '
	prompts.push arr.shift()
	labels.push arr
	values.push 0

setup = ->
	createCanvas 200,200
	textSize 20
	add 'Fan o--- -o-- --o- ---o'
	add 'Temp o----- -o---- --o--- ---o-- ----o- -----o'
	add 'Blink Off Left Right'
	add 'Music Beatles Jazz Rock Stones'
	add 'Radio P1 P2 P3 P4 P5'
	add 'Volume 0 1 2 3 4 5 6 7 8 9'
	add 'Wipers o--- -o-- --o- ---o'
	drawx()

drawx = ->
	bg 0.5
	for prompt,i in prompts
		if current == i then fc 1,1,0 else fc 0
		text prompt,10,30+25*i
		text labels[i][values[i]],120,30+25*i

keyPressed = ->
	if keyCode == 38 then current = (current - 1) %% prompts.length # up
	if keyCode == 40 then current = (current + 1) %% prompts.length # down
	if keyCode == 37 then values[current] = (values[current]-1) %% labels[current].length # left
	if keyCode == 39 then values[current] = (values[current]+1) %% labels[current].length # right
	drawx()