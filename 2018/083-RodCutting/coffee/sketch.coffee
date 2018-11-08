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
	c = v.concat (0 for i in range n2-n1)

	parts = []
	for i in range n2
		max_c = c[i] 
		indexes = [i]
		for j in range (i+1) // 2 
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

showInfo = (i) ->
	push()
	fc 0
	text nf(prices[i]/(i+1),0,2), 110+50*i,80
	pop()

setup = ->
	createCanvas 500,900
	textSize 16
	prices = [1,5,8,9,0,0,0,0]
	for price,i in prices
		do (i) ->
			buttons.push new Button i+1,110+50*i,20, ->
				if prices[i]>1 then prices[i]--
				buttons[2*i+1].title = prices[i]
				execute()
			buttons.push new Button price,110+50*i,50, ->
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
	for index,i in range(30).concat range 9990,10000
		text "Rod sized #{index+1} is cut to [#{parts[index]}] and valued #{lst[index]}",10,100+20*i
	textAlign CENTER,CENTER
	for price,i in prices
		showInfo i

execute = -> [lst,parts] = cut_rod prices, 10000

mousePressed = ->
	for button in buttons
		if button.inside mouseX,mouseY
			button.execute()