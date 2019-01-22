class UtskriftPage extends Page
	constructor : (x,y,w,h) ->
		super x,y,w,h
		@selected = null
		@buttons = []
		@addButton new Button 'Utskrift', 0.75*width,0.4*height,270,45, -> window.print()
		@addButton new Button 'Fortsätt', 0.75*width,0.5*height,270,45, -> 
			myNode = document.getElementById "qrcode"
			myNode.innerHTML = ''
			pages.utskrift.active = false 
			pages.typ.createSelectButtons()
		@addButton new Button 'Slump', 0.75*width,0.6*height,270,45, -> 
			myNode = document.getElementById "qrcode"
			myNode.innerHTML = ''
			pages.utskrift.active = false 
			pages.typ.slumpa()
			pages.typ.createSelectButtons()

	stopMeasuringTime : ->
		@crc = @getCRC pages.typ.qr
		@cpu = new Date().getTime() - pages.typ.start

	getCRC : (qr) ->
		res = 0
		for char,i in qr
			index = '0123456789'.indexOf char
			res += (i+1) * (index+1)
			res %= 1000000
		res

#	showSelectedPersons : ->

	render : ->
		myNode = document.getElementById 'qrcode'
		myNode.style.position = 'absolute' 
		myNode.style.left = "#{0.5*width}px"
		myNode.style.top = "#{0.05*height}px"
		textAlign LEFT,CENTER
		bg 1
		fc 0
		# text pages.typ.qr,20,0.9*height
		text "#{'crc: ' + @getCRC pages.typ.qr.slice 10} #{'tid: '+@cpu}",0.75*width,0.7*height

		push()
		sc()
		textSize 20
		w = width
		h = height
		for typ,i in 'RLK'
			for pair,j in pages.typ.selectedPersons[typ]
				[partikod,knr] = pair
				partinamn = dbPartier[typ][partikod][1]
				if knr==0
					personnamn = ''
				else
					personnamn = dbPersoner[typ][knr][2]
				y = [0,0.25*h,0.5*h][i] + 0.05*h + 0.04*h*j
				if j==0 then text dbName[typ],10,y 
				text "#{j+1}  #{partinamn} - #{personnamn}",0.05*w,y+0.04*h
		pop()

		pages.typ.sbuttons = []
