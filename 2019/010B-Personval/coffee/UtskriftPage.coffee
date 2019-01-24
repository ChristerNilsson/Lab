class UtskriftPage extends Page
	constructor : (x,y,w,h) ->
		super x,y,w,h
		@selected = null
		@buttons = []
		@addButton new Button 'Utskrift', 0.02*width,0.6*height,0.12*w,0.06*h, -> window.print()
		@addButton new Button 'Fortsätt', 0.02*width,0.7*height,0.12*w,0.06*h, -> 
			myNode = document.getElementById "qrcode"
			myNode.innerHTML = ''
			pageStack.pop()
			pages.rlk.createSelectButtons()
		@addButton new Button 'Slump', 0.02*width,0.8*height,0.12*w,0.06*h, -> 
			myNode = document.getElementById "qrcode"
			myNode.innerHTML = ''
			pageStack.pop()
			pages.rlk.slumpa()
			pages.rlk.createSelectButtons()

	stopMeasuringTime : ->
		@crc = @getCRC pages.rlk.qr
		@cpu = new Date().getTime() - pages.rlk.start

	getCRC : (qr) ->
		res = 0
		for char,i in qr
			index = '0123456789'.indexOf char
			res += (i+1) * (index+1)
			res %= 1000000
		res

	render : ->
		print 'UtskriftPage.render'
		myNode = document.getElementById 'qrcode'
		myNode.style.position = 'absolute' 
		myNode.style.left = "#{int 0.02*width}px"
		myNode.style.top = "#{int 0.02*height}px"
		textAlign LEFT,CENTER
		@bg 1
		fc 0
		# text pages.rlk.qr,20,0.9*height
		text "#{'crc: ' + @getCRC pages.rlk.qr.slice 10} #{'tid: '+@cpu}",0.02*width,0.95*height

		push()
		sc()
		w = width
		h = height
		for rlk,i in 'RLK'
			for pair,j in pages.rlk.selectedPersons[rlk]
				[partikod,knr] = pair
				partinamn = dbPartier[rlk][partikod][1]
				if knr==0
					personnamn = ''
				else
					personnamn = dbPersoner[rlk][knr][2]
				y = [0,0.3*h,0.6*h][i] + 0.04*h + 0.05*h*j
				if j==0 
					textSize 0.028 * h
					text dbName[rlk],0.31*width,y 
				textSize 0.020 * h
				text "#{j+1}  #{partinamn} - #{personnamn}",0.3*w,y+0.05*h
		pop()

		pages.rlk.sbuttons = []
