setup = ->
	input = createInput()
	input.position 0, 10
	answer = createElement 'h2'
	answer.position 0,20
	button = createButton 'solve'
	button.position input.x + input.width, 10
	button.mousePressed ->
		[a,b] = input.value().split ' '
		a = parseInt a
		b = parseInt b
		answer.html solve a,b

solve = (a,b) ->
	back = {}
	la = [a]
	lb = []

	save = (x,y) ->
		if y of back then return 
		lb.push y
		back[y] = x

	while b not of back 
		for item in la
			save item,item+2
			save item,item*2
			if item%2==0 then save item,item/2
		[la,lb] = [lb,la]

	solution = []
	p = b
	while true
		solution.push p
		p = back[p]
		if p==a then return solution.concat(a).reverse().join ' '
