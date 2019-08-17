DIGITS = [
	'01110100011000110001100011000101110'
	'00100011000010000100001000010001110'
	'01110100010000100010001000100011111'
	'01110100010000100010000011000101110'
	'00010001000100010010111110001000010'
	'11111100001000011110000011000101110'
	'01110100011000011110100011000101110'
	'11111000010001000100010000100001000'
	'01110100011000101110100011000101110'
	'01110100011000101111000011000101110'
]

class Digit
	render : () ->
		@a = div {style:"float:left; clear:none"}, =>
			for i in range 7
				div {style:"width:120px"}, =>
					for j in range 5
						chkBox {checked: false}
	update : (digit) ->
		for d,i in DIGITS[digit]
			@a.children[i//5].children[i%5].checked = d == '1'
	toString : () ->
		result = range(35).map (i) => if @a.children[i//5].children[i%5].checked then '1' else '0'
		result.join ''

digits = []

setup = ->
	noCanvas()
	digits = []
	for i in range 6
		digits.push new Digit()
	body ->
		for digit in digits
			digit.render()

draw = ->
	date = new Date()
	[a,b,c,d,e,f] = digits
	a.update date.getHours() // 10
	b.update date.getHours() %% 10
	c.update date.getMinutes() // 10
	d.update date.getMinutes() %% 10
	e.update date.getSeconds() // 10
	f.update date.getSeconds() %% 10

keyPressed = ->
	print digits[6].toString()