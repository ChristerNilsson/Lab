assert = chai.assert.deepEqual
range = _.range

secret = null
low = null
high = null
hist = null

level = 1

div0  = document.createElement 'div'
div1  = document.createElement 'div'
input = document.createElement 'input'
input.style.fontSize = '100px'
div2  = document.createElement 'div'
div3  = document.createElement 'div'

document.body.appendChild div0
document.body.appendChild div1
document.body.appendChild input
document.body.appendChild div2
document.body.appendChild div3

probability = (n) =>
	result = range n 
		.map (x) => (x+1)*2**x
		.reduce (a,b) => a+b
	result/(2**n-1)

newGame = (delta) =>
	level += delta
	if level < 2 then level = 2
	low = 1
	high = 2**level - 1
	hist = []
	secret = _.random low,high
	div0.innerText = 'Level: ' + level 
	div1.innerText = 'Interval: ' + low + '-' + high
	div2.innerText = 'History: '
	div3.innerText = 'Probability: ' + probability(level).toFixed(3) + ' steps'

input.onkeyup = (evt) =>
	if evt.key == 'Enter'	
		value = parseInt input.value
		input.value = ''
		hist.push value
		if value < secret and value >= low then low = value + 1
		if value > secret and value <= high then high = value - 1
		if value == secret 
			newGame if hist.length <= level then 1 else -1
		div1.innerText = 'Interval: ' + low + '-' + high
		div2.innerText = 'History: ' + hist.join ' '

newGame 1
