setup = ->
	createCanvas windowWidth,windowHeight
	textAlign CENTER,CENTER
	textSize 250

zero = (t) -> if t<10 then "0"+t else ""+t

draw = ->
	bg 0
	d = new Date()
	lst = []
	lst.push d.getFullYear() % 100
	lst.push d.getMonth() + 1
	lst.push d.getDate()
	lst.push d.getHours()
	lst.push d.getMinutes()
	lst.push d.getSeconds()

	for n,i in lst
		if n==11 then fc 1,0,0 else fc 0,0,1
		text zero(n), 200+300*i, height/2
