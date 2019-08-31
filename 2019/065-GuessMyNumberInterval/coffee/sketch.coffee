assert = chai.assert.deepEqual
range = _.range

createAndAppend = (parent,type,attributes) =>
	elem  = document.createElement type
	parent.appendChild elem
	for key,attribute of attributes
		elem[key] = attribute
	elem

class Game 
	constructor : (level) -> @init level

	init : (@level) =>
		if @level < 2 then @level = 2
		@low = 1
		@high = 2**@level - 1
		@secret = _.random @low, @high
		@hist = []
		div0.innerText = 'Level: ' + @level 
		@render()
		div3.innerText = 'Probability: ' + probability(@level).toFixed(3) + ' steps'
	
	action : =>
		if input.value == '' then return 
		value = parseInt input.value
		input.value = ''
		@hist.push value
		if value < @secret and value >= @low then @low = value + 1
		if value > @secret and value <= @high then @high = value - 1
		if value == @secret 
			@init @level + if @hist.length <= @level then 1 else -1
		@render()

	render : =>
		div1.innerText = 'Interval: ' + @low + '-' + @high
		div2.innerText = 'History: ' + @hist.join ' '

probability = (n) =>
	result = range n 
		.map (x) => (x+1)*2**x
		.reduce (a,b) => a+b
	result/(2**n-1)

div0 = createAndAppend document.body, 'div'
div1 = createAndAppend document.body, 'div'
input = createAndAppend document.body, 'input', {style:"font-size:100px"}
div2 = createAndAppend document.body, 'div'
div3 = createAndAppend document.body, 'div'
input.onkeyup = (evt) => if evt.key == 'Enter' then game.action()

game = new Game 2
