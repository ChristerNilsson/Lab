# Rita upp möjliga tal.
# Vid klick på ett tal, gråa ut de omöjliga.
# Visa antalet klick som behövts.
# Börja med en rad med talen 0-15
# Därefter en matris med talen 0-127

# bg
# fc
# sc
# textSize textAlign CENTER text
# if else for in range return
# width height

##################

# setup
# draw
# createCanvas
# random
# mousePressed mouseX mouseY
# math.floor

N = 16
sida = 0
start = 0
stopp = N*N-1
slump = 0
antal = 0
startTid = 0
tid = 0

setup = ->
	createCanvas 600,600
	textAlign CENTER,CENTER
	slump = random 0,N*N-1
	sida = width/N-1
	startTid = Date.now()

draw = ->
	bg 1
	for i in range N
		for j in range N
			fc 1
			sc()
			rect sida*i,sida*j,sida,sida
			n = N*j+i
			fc if start <= n <= stopp then 0 else 0.9
			textSize 16
			text n,sida/2+sida*i,sida/2+sida*j
			textSize 500
			sc 0,1,0
			fc()
			text antal,width/2,height/2
			textSize 50
			text tid,width/2,height/2+230

mousePressed = ->
	if start > stopp then return 
	i = Math.floor mouseX/sida
	j = Math.floor mouseY/sida
	n = N*j+i
	if start <= n <= stopp
		antal++
		tid = Date.now()-startTid
		if n <= slump then start = n+1
		if n >= slump then stopp = n-1