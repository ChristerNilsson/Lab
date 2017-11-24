qrcode = null

draw = ->
	qrcode.clear()
	d = new Date()
	h = ('0' + d.getHours()).slice -2
	m = ('0' + d.getMinutes()).slice -2
	s = ('0' + d.getSeconds()).slice -2
	clearText = "#{h}:#{m}:#{s}"
	qrcode.makeCode clearText

setup = ->
	frameRate 1
	size = min windowWidth,windowHeight
	options =
		text: ""
		width: size*0.9
		height: size*0.9
		colorDark : "#000000"
		colorLight : "#ffffff"
		correctLevel : QRCode.CorrectLevel.L
	qrcode = new QRCode document.getElementById("qrcode"),options

	# createFile() # 4 minuter

createLine = (h,m,s) ->
	hh = ('0' + h).slice -2
	mm = ('0' + m).slice -2
	ss = ('0' + s).slice -2
	clearText = "#{hh}:#{mm}:#{ss}"
	qrcode.clear()
	qrcode.makeCode clearText
	txt = []
	for row in qrcode._oQRCode.modules
		for cell in row
			txt.push if cell then 1 else 0
	clearText + ' ' + txt.join ''

createFile = ->
	lst = []
	for h in range 24
		for m in range 60
			for s in range 60
				lst.push createLine h,m,s
	saveStrings lst,'qrcode_86400.txt'
