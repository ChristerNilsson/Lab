# Editor för URL-parametrar.
# T ex 082-Calendar Clock
# Indata: parametrar som styr alternativen.
# Utdata: URL-sträng till nästa program

params = {}
selects = []

spara = (s) ->
	arr = s.split ' '
	params[arr[0]] = arr[1..].join '|'

url = 'http://christernilsson.github.io/Lab/2017/084-Configuration/index.html?hh=08|09|10|11|12|13|14|15|16|17&mm=00|05|10|15|20|25|30|35|40|45|50|55&su=Ma|En|Sv|Fy|Fr&da=Mo|Tu|We|Th|Fr&lo=A123|B234|C345|D456&fields=da|hh|mm|hh|mm|su|lo'

setup = ->
	createCanvas 400,400
	# spara 'hh 08 09 10 11 12 13 14 15 16 17'
	# spara 'mm 00 05 10 15 20 25 30 35 40 45 50 55'
	# spara 'su Ma En Sv Fy Ty Fr'
	# spara 'da Mo Tu We Th Fr'
	# spara 'lo A123 B234 C345 D456'
	# spara 'fields da hh mm hh mm su lo'
	params = getURLParams()
	print params

	for field,i in params.fields.split '|'
		print field
		sel = createSelect()
		sel.position 300+i*40,10
		selects.push sel
		for alt in params[field].split '|'
			sel.option alt
	button = createButton '+'
	button.position 270,10
	button.mousePressed () ->
		res = (sel.selected() for sel in selects)
		res = res.join ' '
		textarea.value += res + '\n'

	btnFinal = createButton 'final'
	btnFinal.position 270,30
	btnFinal.mousePressed () ->
		res = (lines.replace(/ /g, '') for lines in textarea.value.split '\n')
		final.value = res.join ';'


