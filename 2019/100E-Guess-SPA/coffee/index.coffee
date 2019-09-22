createAndAppend = (parent,type,attributes) =>
	elem  = document.createElement type
	parent.appendChild elem
	for key,attribute of attributes
		elem[key] = attribute
	elem

render = =>
	div0.innerText = 'Level: ' + game.level 
	div1.innerText = 'Interval: ' + game.low + '-' + game.high
	div2.innerText = 'History: ' + game.hist.join ' '

div0 = createAndAppend document.body, 'div'
div1 = createAndAppend document.body, 'div'
input = createAndAppend document.body, 'input', {style:"font-size:100px"}
div2 = createAndAppend document.body, 'div'
input.onkeyup = (evt) => 
	if evt.key == 'Enter' 
		game.action input.value
		input.value = ''
		render()

game = new Game 2
render()
