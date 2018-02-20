ID_EngineeringNotation =
	v:'2017-04-29'
	k:'fc sc bg int log10 constrain operators text class'
	l:28
	b:"""
class Engineering extends Application
	reset : ->
		super
	draw  : ->
	more  : ->
	less  : ->
app = new Engineering
"""
	a:"""
class Engineering extends Application
	reset : ->
		super
		@PREFIXES = "yzafpnµm kMGTPEZY"
		@numbers = "-273.15 1.6021766208e-19 3.1415926535 9.80665 101325 299792458 1073741824 6.022140857e23"
		@digits = 3
	format : (x) ->
		if x<0 then return "-" + @format(-x)
		exponent = 3 * int Math.log10(x)/3
		x = x / 10 ** exponent
		if x < 10 then factor = 10 ** (@digits-1)
		else if x < 100 then factor = 10 ** (@digits-2)
		else factor = 10 ** (@digits-3)
		Math.round(x * factor) / factor + @PREFIXES[8+exponent/3]
	draw  : ->
		bg 0
		textAlign RIGHT,TOP
		textSize 20
		textFont "monospace"
		fc 1,0,0
		sc()
		textAlign RIGHT,TOP
		for nr,i in @numbers.split " "
			x = parseFloat nr
			if i<8 then text @format(1/x), 100-5,i*20
			text @format(x), 200-5,i*20
	more  : -> @digits = constrain @digits+1, 1,6
	less  : -> @digits = constrain @digits-1, 1,6

app = new Engineering "a"
"""
	c:
		app : "reset()|more()|less()"
	d : "reset()|more()|more()|less()|less()|less()|less()"
	e:
		EngineeringNotation : "https://en.wikipedia.org/wiki/Engineering_notation"

