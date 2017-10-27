la = []
lb = []
DECIMALS = 2
FONT_SIZE = 12

newNf = (a,b,c) ->
	a = a * 10 ** c
	a = round a
	a = a * 10 ** -c
	nf a,b,c

setup = ->
	createCanvas 200,200
#calc '10 2','100 20 3'
#calc '10 5','1000 200 30 4'
#calc '10 -4','500 40 3'
#calc '40 6','90 7'

	calc '4 0.6','1000 100 10 2 -0.3 -0.02'

	# assert '123456.8',newNf 123456.78,0, 1 
	# assert '123457',  newNf 123456.78,0, 0 
	# assert '123460',  newNf 123456.78,0,-1 
	# assert '123500',  newNf 123456.78,0,-2 
	# assert '123000',  newNf 123456.78,0,-3
	# assert '120000',  newNf 123456.78,0,-4
	# assert '100000',  newNf 123456.78,0,-5
	# assert '0',       newNf 123456.78,0,-6
	
draw = ->
	bg 0.5
	textAlign RIGHT,TOP
	textSize FONT_SIZE

	rect 50+2,25-5,50*(la.length-1),25*(lb.length-1)

	#for b,j in lb

	for a,i in la 
		text a,100+50*i,0
		for b,j in lb
			text b,50,25+25*j
			text newNf(a*b,1,DECIMALS),100+50*i,25+25*j


sum = (lst) -> lst.reduce (res, item) -> res+item

# sa maximalt 2 tal
# sb maximalt 6 tal
calc = (sa,sb) ->
	la = (parseFloat item for item in sa.split ' ')
	lb = (parseFloat item for item in sb.split ' ')
	la.push sum la 
	lb.push sum lb

