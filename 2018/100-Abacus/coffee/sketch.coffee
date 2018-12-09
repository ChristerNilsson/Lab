class Digit
	constructor : (@x,@y,@value=0) ->

	bean : (y) ->
		fc 0.89, 0.77, 0.00
		quad @x-50,y, @x-25,y-25, @x+25,y-25, @x+50,y
		fc 0.95,0.70,0.30
		quad @x-50,y, @x-25,y+25, @x+25,y+25, @x+50,y

	draw : ->
		sw 5
		line @x,0,@x,500
		sw 1
		if @value >= 5 then dy=50 else dy=0
		fc 0.894, 0.772, 0.000
		@bean @y+dy
		for i in range 5 
			if i != @value % 5 then @bean @y+150+50*i
		fc 1
		text @value,@x,150+4

	click : (d) ->
		five = @value//5
		if d ==  2 and five==0 then @value += 5
		if d ==  5 and five==1 then @value -= 5

		if d ==  8 and @value%5>0 then @value = 0 + 5*five
		if d == 10 and @value%5>1 then @value = 1 + 5*five
		if d == 12 and @value%5>2 then @value = 2 + 5*five
		if d == 14 and @value%5>3 then @value = 3 + 5*five

		if d == 11 and @value%5<=1 then @value = 1 + 5*five
		if d == 13 and @value%5<=2 then @value = 2 + 5*five
		if d == 15 and @value%5<=3 then @value = 3 + 5*five
		if d == 17 and @value%5<=4 then @value = 4 + 5*five

digits = []
msg = ''

setup = ->
	createCanvas 1050,450
	textSize 48
	textAlign CENTER,CENTER
	for i in range 10 
		digits.push new Digit 75+100*i,50

draw = ->
	bg 0.5
	sw 50
	line 0,0,0,450
	line width,0,width,450

	line 0,0,width,0
	line 0,150,width,150
	line 0,450,width,450
	for digit in digits
		digit.draw()
	fc 0
	text msg, width/2,height/2

mousePressed = ->
	i = (mouseX-25)//100
	j = (mouseY+25)//25
	if j==1
		for digit in digits
			digit.value = 0
	else
		digits[i].click j
