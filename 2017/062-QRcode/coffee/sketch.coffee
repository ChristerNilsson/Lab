qrcode = null

setup = ->
	createCanvas windowWidth/2,windowHeight/2
	frameRate 1
	options =
		text: ""
		width: height*0.9
		height: height*0.9
		colorDark : "#000000"
		colorLight : "#ffffff"
		correctLevel : QRCode.CorrectLevel.H
	qrcode = new QRCode document.getElementById("qrcode"),options

draw = ->
	qrcode.clear()
	d = new Date()
	h = ('0' + d.getHours()).slice(-2)
	m = ('0' + d.getMinutes()).slice(-2)
	s = ('0' + d.getSeconds()).slice(-2)
	chars = "#{h}:#{m}:#{s}"
	print chars
	qrcode.makeCode chars
