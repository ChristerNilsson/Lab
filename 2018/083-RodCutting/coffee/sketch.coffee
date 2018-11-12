class Button
	constructor : (@title,@x,@y,@event) -> @r = 20
	draw : ->
		circle @x,@y,@r	
		sc 0.8
		line @x,@y-@r,@x,@y+@r	
		sc()
		text @title,@x,@y
	inside : (mx,my) -> @r > dist mx,my,@x,@y 
	execute : -> @event()

buttons = []
prices = null
parts = null
X = [30,90,170,300,450,600]
rodsize = 10

showInfo = (i) ->
	push()
	fc 0
	x = Math.round(prices[i]/(i+1) * 100) / 100
	text nf(x,0,2), X[2],110+50*i
	pop()

setup = ->
	createCanvas 610,700
	textSize 16
	prices = [1,5,7,10,0,0,0,0,0,0]
	for price,i in prices
		do (i) ->
			buttons.push new Button prices[i],X[1],110+50*i, ->
				if mouseX < X[1]
					if prices[i]>0 then prices[i]--
				else
					prices[i]++
				buttons[i].title = prices[i]
				execute()
	execute()

text3 = (texts,x) ->
	for t,i in texts.split ' '
		text t,x,[20,40,60][i]

draw = ->
	bg 0.5
	textSize 20
	textAlign CENTER,CENTER
	push()
	fc 0.75
	text3 'piece size', X[0]
	text3 'piece price -|+', X[1]
	textAlign RIGHT,CENTER
	text3 'price / size', X[2]
	text3 'piece count', X[3]
	text3 'size x count', X[4]
	text3 'price x count', X[5]
	for price,i in prices
		showInfo i
	pop()

	total = [0,0,0]
	textAlign CENTER,CENTER
	for button in buttons
		button.draw()
	textAlign RIGHT,CENTER
	for part,i in parts
		push()
		fc 0.75
		text i+1, X[0],110+50*i
		pop()
		text parts[i],           X[3],110+50*i
		text (i+1)*parts[i],     X[4],110+50*i
		text prices[i]*parts[i], X[5],110+50*i
		total[0] += parts[i]
		total[1] += (i+1)*parts[i]
		total[2] += prices[i]*parts[i]
		sc 0.75
		y = 135+50*i
		if i==0 then line 0,y-50,width,y-50
		line 0,y,width,y
		sc()
	textAlign CENTER,CENTER

	textAlign LEFT,CENTER
	text 'Total:',X[1],610
	textAlign RIGHT,CENTER
	text total[0],X[3],610
	text total[1],X[4],610
	text total[2],X[5],610
	textAlign CENTER,CENTER
	push()
	fc 0.75
	text 'janchrister.nilsson@gmail.com',width/2,680
	textSize 50
	text 'Constant Time Rod Cutter',width/2,650
	pop()

execute = -> parts = gc prices, rodsize

rodSize = (input) -> 
	rodsize = parseInt input.value
	if rodsize < 0 then rodsize=1
	execute()

mousePressed = ->
	for button in buttons
		if button.inside mouseX,mouseY then button.execute()

######

# Constant + Parts
gc = (prices, n) ->
	# Om lika maxkvot, välj högsta index
	lst = ([price/(i+1),i+1] for price,i in prices)
	lst.sort()
	[q, clen] = _.last lst

	if n < clen then return g prices, n, clen
	part = g prices,clen + n % clen,clen
	part[clen-1] += (n-clen)//clen
	part


# Quadratic + Parts
g = (v, n2, clen) ->
	n1 = v.length
	c = v.concat (0 for i in range n2) # [0] * n2
	parts = []
	for i in range n2
		max_c = c[i]
		indexes = [i]
		for j in range n2
			k = i - j - 1
			if k >= 0
				temp = c[j] + c[k]
				if temp >= max_c
					max_c = temp
					indexes = [k, j]
		c[i] = max_c
		part = (0 for z in range n1) 
		if i <= clen
			for index in indexes
				part[index] += 1
		else
			for m in range n1
				for index in indexes
					part[m] += parts[index][m]
		parts.push part
	_.last parts


assert [0,2,0,0], g [1,5,7,10],4,4  # 26

prices = [1, 6, 10, 14]  # 1 3 3.33 3.5 clen=4
assert g(prices,1,4) , [1,0,0,0] # 1
assert g(prices,2,4) , [0,1,0,0] # 6
assert g(prices,3,4) , [0,0,1,0] # 10
assert g(prices,4,4) , [0,0,0,1] # 14
assert g(prices,5,4) , [0,1,1,0] # 16
assert g(prices,6,4) , [0,1,0,1] # 20
assert g(prices,7,4) , [0,0,1,1] # 24
assert g(prices,8,4) , [0,0,0,2] # 28
assert g(prices,9,4) , [0,1,1,1] # 30
assert g(prices,10,4), [0,1,0,2] # 34

prices = [5, 6, 7, 10]  # 5 3 3.5 2.5 clen=1
assert g(prices,1,1) , [1,0,0,0]
assert g(prices,2,1) , [2,0,0,0]
assert g(prices,3,1) , [3,0,0,0]
assert g(prices,4,1) , [4,0,0,0]
assert g(prices,5,1) , [5,0,0,0]
assert g(prices,6,1) , [6,0,0,0]
assert g(prices,7,1) , [7,0,0,0]

prices = [1, 5, 8, 9]  # 1 2.5 2.67 2.25 clen=3
assert g(prices,1,3) , [1,0,0,0] # 1
assert g(prices,2,3) , [0,1,0,0] # 5
assert g(prices,3,3) , [0,0,1,0] # 8
assert g(prices,4,3) , [0,2,0,0] # 10
assert g(prices,5,3) , [0,1,1,0] # 13
assert g(prices,6,3) , [0,0,2,0] # 16
assert g(prices,7,3) , [0,2,1,0] # 18
assert g(prices,8,3) , [0,1,2,0] # 21
assert g(prices,9,3) , [0,0,3,0] # 24
assert g(prices,10,3), [0,2,2,0] # 26


#####################################

assert gc([1,12,19,25],10) , [0,0, 2,1]
assert gc([1,5,7,10],4), [0,2, 0,0]

prices = [1,5,8,9]  # 1 2.5 2.67 2.25 clen=3
assert gc(prices,1) , [1,0, 0,0]
assert gc(prices,2) , [0,1, 0,0]
assert gc(prices,3) , [0,0, 1,0]
assert gc(prices,4) , [0,2, 0,0]
assert gc(prices,5) , [0,1, 1,0]
assert gc(prices,6) , [0,0, 2,0]
assert gc(prices,7) , [0,2, 1,0]
assert gc(prices,8) , [0,1, 2,0]
assert gc(prices,9) , [0,0, 3,0]
assert gc(prices,10), [0,2, 2,0]

prices = [1,6,10,14]  # 1 3 3.33 3.5 clen=4
assert gc(prices,1) , [1,0, 0,0]
assert gc(prices,2) , [0,1, 0,0]
assert gc(prices,3) , [0,0, 1,0]
assert gc(prices,4) , [0,0, 0,1]
assert gc(prices,5) , [0,1, 1,0]
assert gc(prices,6) , [0,1, 0,1]
assert gc(prices,7) , [0,0, 1,1]
assert gc(prices,8) , [0,0, 0,2]
assert gc(prices,9) , [0,1, 1,1]
assert gc(prices,10), [0,1, 0,2]
assert gc(prices,11), [0,0, 1,2]
assert gc(prices,12), [0,0, 0,3]

prices = [5,6,7,10]  # 5 3 3.5 2.5 clen=1
assert gc(prices,1) , [1,0,0,0] # 5
assert gc(prices,2) , [2,0,0,0] # 10
assert gc(prices,3) , [3,0,0,0] # 15
assert gc(prices,4) , [4,0,0,0] # 20
assert gc(prices,5) , [5,0,0,0] # 25
assert gc(prices,6) , [6,0,0,0] # 30
assert gc(prices,7) , [7,0,0,0] # 35
assert gc(prices,8) , [8,0,0,0] # 40
assert gc(prices,9) , [9,0,0,0] # 45
assert gc(prices,10), [10,0,0,0] # 50

prices = [46, 64, 75, 96] # 46 32 25 24 clen=1
assert gc(prices,1) , [1,0,0,0] # 46
assert gc(prices,2) , [2,0,0,0] # 92
assert gc(prices,3) , [3,0,0,0] # ...
assert gc(prices,4) , [4,0,0,0] #
assert gc(prices,5) , [5,0,0,0] #
assert gc(prices,6) , [6,0,0,0] #
assert gc(prices,7) , [7,0,0,0] #
assert gc(prices,8) , [8,0,0,0] #
assert gc(prices,9) , [9,0,0,0] #
assert gc(prices,10), [10,0,0,0] #

# for k in range 100
# 	prices = []
# 	for i in range 10
# 		prices.push Math.round 10 + 90 * Math.random()
# 	prices.sort()
# 	print prices 
# 	for i in range 1,101
# 		print gc prices,i
# print 'Ready!'