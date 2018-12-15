bets = (0 for i in range 10)
total = 0

setup = ->
	createCanvas 200,200
	textAlign CENTER,CENTER
	textSize 20

gcd = (x, y) -> if y == 0 then x else gcd y, x % y

pretty = (a,b) ->
	if b == 0 then return ''
	g = gcd a,b
	a //= g
	b //= g
	if b == 1 then a else "#{a}/#{b}"

draw = ->
	bg 0.5
	for name,i in 'Adam Bertil Cesar David Erik Filip Gustav Helge Ivar Johan'.split ' '
		text name,50,10+i*20
		if bets[i]>0 then text bets[i],100,10+i*20
		text "#{pretty total,bets[i]}",150,10+i*20

mousePressed = ->
	i = mouseY//20
	bets[i]++
	total++
