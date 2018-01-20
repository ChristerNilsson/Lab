drawHouse = (radius) ->
	push()

	# nio linjer
	dx = 0.02 * w
	sc 0
	sw 1
	for i in range -4,5
		line i*4*dx,-1.1*radius,i*4*dx,1.1*radius

	# vit omkrets
	sc 1
	sw 5
	fc()
	circle 0,0,1.1*radius

	# svarta pilen
	sc 0
	sw 0.05*h
	line 0,-1.00*radius,0,1.00*radius

	# fyra väderstreck
	sc()
	textAlign CENTER,CENTER
	textSize 0.06*h
	for i in range 4
		push()
		translate 0,0.96*radius
		rd 180
		if i==0 then fc 1 
		else if i==2 then fc 1,0,0 
		else fc 0
		text "SWNE"[i],0,0
		pop()
		rd 90	

	pop()

drawNeedle = (radius) ->
	try
		rd -bearing

		sc 0
		sw 0.035*h
		line 0,-0.98*radius,0,0.98*radius

		sc 1
		sw 0.030*h
		line 0,0,0,0.98*radius
		sc 1,0,0
		line 0,0,0,-0.98*radius

		sw 0.035*h
		sc 0
		point 0,0

drawCompass = ->
	radius = 0.4 * w 
	delta = calcDelta heading_12-bearing
	fill calcColor delta
	sw 5
	sc 1
	push()
	translate 0.5*w,0.5*h
	circle 0,0,1.1*radius
	push()

	rd -heading_12
	drawHouse radius
	pop()
	drawNeedle radius
	pop()

drawTexts = ->
	fc 0.5
	d = h/12
	sc 0.5
	sw 1
	n = 3 # columns
	helpTexts = ['Distance','Bearing','ETA','Speed','','Time','Points','','Delay','Destination']
	if normal==1 then currTexts = helpTexts else currTexts = texts  

	textSize 0.07*h
	for t,i in currTexts
		if i%n==0 then textAlign LEFT 
		if i%n==1 then textAlign CENTER 
		if i%n==2 then textAlign RIGHT
		x = i%n * w/2
		y = d*Math.floor i/n
		if i >= 6 then y += 7.8*d
		if i in [0,1,2] then fc 1 else fc 0.5
		text t,x,d+y
	textAlign LEFT

draw = ->
	bg 0
	dt = Math.round (millis() - lastObservation)/1000
	texts[8] = if dt>=2 then "#{dt} s" else ""
	texts[5] = "#{precisionRound (millis()-start)/1000,0} s" # sekunder sedan start
	drawCompass()
	drawTexts()

