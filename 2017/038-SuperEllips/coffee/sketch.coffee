N = 600
setup = ->
	createCanvas 600,600
	bg 0.5
	drawx()

safeExp = (x,y) -> Math.sign(x) * abs(x) ** y 
				
drawx = ->		
	n = 10
	bg 0

	sc 1
	sw 1
	for i in range N/n+1

		x = n * i
		y = N/2 + n * i
		line x,N,0,y
		y = N/2 - n * i
		line x,0,0,y

		x = N/2 + n * i
		y = N - n * i
		line x,N,N,y
		y = n * i
		line x,0,N,y

	sw 2	
	circle N/2,N/2,N/2

	sc 1,0,0
	sw 1
	for i in range 100
		a = i * 2*PI/100
		x = N/2 * safeExp cos(a), 2/2.4 # 2.4 is closer than 2.5 of Piet Hein
		y = N/2 * safeExp sin(a), 2/2.4 # log(2)/log(4/3) = 2.40942083965
		point x+N/2,y+N/2


