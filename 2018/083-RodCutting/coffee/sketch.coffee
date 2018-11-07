class Button
	constructor : (@title,@x,@y,@event) -> @r = 15
	draw : ->
		circle @x,@y,@r		
		text @title,@x,@y
	inside : (mx,my) -> @r > dist mx,my,@x,@y 
	execute : -> @event()

buttons = []
prices = null
lst = null
parts = null

cut_rod = (v, n2) ->
	n1 = v.length
	v = v.concat (0 for i in range n2-n1)
	c = (0 for i in range n2)

	parts = []
	for i in range n2
		max_c = v[i]
		indexes = [i]
		for j in range i
			k = i - j - 1
			temp = c[j] + c[k]
			if temp > max_c
				max_c = temp
				indexes = [j, k]
		c[i] = max_c
		part = (0 for j in range n1)
		if i < n1
			for index in indexes
				part[index]++
		else
			for m in range n1
				for index in indexes
					part[m] += parts[index][m]
		parts.push part
	return [c, parts]

setup = ->
	createCanvas 500,400
	textSize 16
	prices = [1,5,8,9]
	for price,i in prices
		do (i) ->
			buttons.push new Button i+1,110+50*i,30, ->
				if prices[i]>1 then prices[i]--
				buttons[2*i+1].title = prices[i]
				execute()
			buttons.push new Button price,110+50*i,70, ->
				prices[i]++
				buttons[2*i+1].title = prices[i]
				execute()
	execute()

draw = ->
	bg 0.5
	textAlign LEFT,CENTER
	text 'Rod Size:', 10,30
	text 'Rod Value:', 10,70
	textAlign CENTER,CENTER
	for button in buttons
		button.draw()	
	textAlign LEFT,CENTER
	for index,i in [0,1,2,3,4,5,6,7,8,9,9995,9996,9997,9998,9999]
		text "Rod sized #{index+1} is cut to [#{parts[index]}] and valued #{lst[index]}",10,100+20*i

execute = -> [lst,parts] = cut_rod prices, 10000

mousePressed = ->
	for button in buttons
		if button.inside mouseX,mouseY
			button.execute()