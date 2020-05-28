VERSION = 1
DELAY = 100 # ms, delay between sounds
DIST = 1 # meter. Movement less than DIST makes no sound 1=walk. 5=bike
LIMIT = 20 # meter. Under this value is no bearing given.

platform = window.navigator.platform # Win32|iPad|Linux

DIGITS = 'zero one two three four five six seven eight niner'.split ' '
BR = if platform in ['Win32','iPad'] then "\n" else '<br>'

# http://www.bvsok.se/Kartor/Skolkartor/
# Högupplösta orienteringskartor: https://www.omaps.net
# https://omaps.blob.core.windows.net/map-excerpts/1fdc587ffdea489dbd69e29b10b48395.jpeg Nackareservatet utan kontroller.

DISTLIST = [0,2,4,6,8,10,12,14,16,18,20,30,40,50,60,70,80,90,100, 120,140,160,180,200,250,300,350,400,450,500,600,700,800,900,1000,2000,3000,4000,5000,6000,7000,8000,9000,10000]

released = true
mapName = "" # t ex skarpnäck
params = null
voices = null
measure = {}
surplus = 0
pois = null
speed = 1
distbc = 0

raphael = null

start = new Date()

state = 0 # 0=uninitialized 1=normal 2=info

data = null

img = null

b2w = null
w2b = null

startX = 0
startY = 0

menuButton = null

crossHair = null
lastTouchEnded = new Date() # to prevent double bounce in menus

fraction = (x) -> x - int x 
Array.prototype.clear = -> @length = 0
assert = (a, b, msg='Assert failure') -> chai.assert.deepEqual a, b, msg

general = {COINS: true, DISTANCE: true, TRAIL: true, SECTOR: 10, PANSPEED : true}
loadGeneral = -> if localStorage.gpsKarta then general = _.extend general, JSON.parse localStorage.gpsKarta
saveGeneral = -> localStorage.gpsKarta = JSON.stringify general

class Storage
	constructor : (@mapName) ->
		key = 'gpsKarta' + @mapName
		if localStorage[key]
			try
				obj = JSON.parse localStorage[key]
				@controls = obj.controls
				@trail = obj.trail
		@clear()

	save : -> localStorage['gpsKarta' + @mapName] = JSON.stringify @

	clear : ->
		@controls = data.controls
		@trail = []
		@init()
		crossHair = null
		@save()

	init : ->
		for key,control of @controls
			[x,y,littera] = control
			[lon,lat] = b2w.convert x,y
			control[2] = ""
			control[3] = lat
			control[4] = lon

	deleteControl : ->
		[pLon,pLat] = b2w.convert cx,cy
		b = LatLon pLat,pLon
		for key,control of @controls
			[z,z,z,qLat,qLon] = control
			c = LatLon qLat,qLon
			dbc = b.distanceTo(c) 
			if dbc < data.radius and key not in "ABC" then delete @controls[key]
		@save()

storage = null

class Dump
	constructor : ->
		@data = []
		@active = false
	store : (msg) ->
		if @active
			console.log msg
			@data.push msg
	get : ->
		result = @data.join BR
		@data = []
		result + BR
dump = new Dump()

[cx,cy] = [0,0] # center (image coordinates)
SCALE = 1

gps = null
TRACKED = 5 # circles shows the user position
position = [500,500] # gps position [x,y] # [lon,lat,alt,hhmmss]
track = [] # five latest GPS positions (bitmap coordinates)

speaker = null

soundUp = null
soundDown = null
soundQueue = 0 # integer neg=minskat avstånd pos=ökat avstånd

#messages = ['','','','','','']
gpsCount = 0

[gpsLat,gpsLon] = [0,0] # avgör om muntlig information ska ges

timeout = null

voiceQueue = []
bearingSaid = '' # förhindrar upprepning
distanceSaid = '' # förhindrar upprepning

sendMail = (subject,body) ->
	mail.href = "mailto:" + data.mail + "?subject=" + encodeURIComponent(subject) + "&body=" + encodeURIComponent(body) # encodeURI 
	console.log mail.href
	mail.click()

say = (m) ->
	if speaker == null then return
	speechSynthesis.cancel()
	speaker.text = m
	dump.store ""
	dump.store "say #{m} #{JSON.stringify voiceQueue}"
	speechSynthesis.speak speaker

# request = (jsonfile) => 
# 	response = await fetch jsonfile
# 	console.log response
# 	response.json()

# request = (name) ->
# 	await fetch name
# 		.then (response) -> await response.json()
# 		.then (data) -> await return data

request = (name) ->
	await fetch name
		.then (response) => response.json()

preload = ->
	params = getParameters()
	mapName = params.map || "Skarpnäck"
	if params.debug then dump.active = params.debug == '1'

	data = await request "data/#{mapName}.json"
	console.log data
	for key,control of data.controls
		control.push ""
		control.push 0
		control.push 0

	pois = await request "data/poi.json"
	console.log pois

	# Replace ./data.json with your JSON feed
	# fetch "data/#{mapName}.json"
	# 	.then (response) => 
	# 		data = response.json()
	# 		#img = loadImage "data/" + data.map
	# 		return data
	# 	.then (data) => 
	# 		console.log data
	# 		startup2()
	# 	.catch (err) => 
	# 		console.log 'Error',err

	# fetch "data/poi.json"
	# 	.then (response) => 
	# 		pois = response.json()
	# 		return pois
	# 	.then (data) =>
	# 		console.log 'pois',data
	# 	.catch (err) => 
	# 		console.log 'Error',err

#	loadJSON "data/#{mapName}.json", (json) ->
#	loadJSON "data/poi.json", (json) -> pois = json

sayDistance = (a,b) -> # a is newer (meter)
	# if a border is crossed, produce speech
	dump.store "D #{myRound a,1} #{myRound b,1}"
	a = round a
	b = round b
	if b == -1 then return a
	for d in DISTLIST
		if a == d and b != d then return d
		if (a-d) * (b-d) < 0 then return d
	""

sayBearing = (a0,b0) -> # a is newer (degrees)
	dump.store "B #{myRound a0,1} #{myRound b0,1}"
	# if a sector limit is crossed, tell the new bearing
	a = general.SECTOR * round(a0/general.SECTOR)
	b = general.SECTOR * round(b0/general.SECTOR)
	if a == b and b0 != -1 then return "" # samma sektor
	a = round a / 10 
	if a == 0 then a = 36 # 01..36
	tiotal = DIGITS[a // 10]
	ental = DIGITS[a %% 10]
	"#{tiotal} #{ental}"

increaseQueue = (p) ->
	dump.store "increaseQueue #{p.coords.latitude} #{p.coords.longitude}"

	if crossHair == null then return 

	[trgLon,trgLat] = b2w.convert crossHair[0],crossHair[1]

	a = LatLon p.coords.latitude,p.coords.longitude # newest
	b = LatLon gpsLat, gpsLon
	c = LatLon trgLat, trgLon # target

	distac = a.distanceTo c # meters
	distbc = b.distanceTo c
	distance = (distac - distbc)/DIST

	bearingac = a.bearingTo c
	bearingbc = b.bearingTo c
	sBearing = if distac >= LIMIT then sayBearing bearingac,bearingbc else ""
	sDistance = sayDistance distac,distbc

	if sBearing != "" and sDistance != "" then voiceQueue.push "both #{sBearing} #{sDistance}"
	else if sBearing != "" then voiceQueue.push "bearing #{sBearing}"
	else if sDistance != "" then voiceQueue.push "distance #{sDistance}"

	if abs(distance) >= 0.5 # update only if DIST detected. Otherwise some beeps will be lost.
		gpsLat = myRound p.coords.latitude,6
		gpsLon = myRound p.coords.longitude,6

	if distance < -10 then soundQueue = -10
	else if distance > 10 then soundQueue = 10
	else soundQueue = round distance

firstInfo = ->
	[x,y] = crossHair
	[lon,lat] = b2w.convert x,y

	b = LatLon gpsLat, gpsLon
	c = LatLon lat, lon 

	distb = round b.distanceTo c
	distance = round (distb)/DIST

	bearingb = b.bearingTo c
	voiceQueue.push "target #{key} #{sayBearing bearingb,-1} #{sayDistance distb,-1}"
	dump.store ""
	dump.store "target #{crossHair}"
	dump.store "gps #{[gpsLat,gpsLon]}"
	dump.store "trg #{[lat,lon]}"
	dump.store "voiceQueue #{voiceQueue}"
	
	if distance < 10 then soundQueue = distance else soundQueue = 1 # ett antal DIST

playSound = ->
	if not general.COINS then return 
	if soundQueue == 0 then return
	dump.store "playSound #{soundQueue}"
	if soundQueue < 0 and soundDown != null
		soundQueue++
		soundDown.play()
	else if soundQueue > 0 and soundUp != null
		soundQueue--
		soundUp.play()

decreaseQueue = ->
	if voiceQueue.length == 0 then return
	msg = voiceQueue.shift()
	arr = msg.split ' '

	if arr[0] == 'both'
		result = ""
		msg = arr[1] + ' ' + arr[2] # skippa ordet. t ex 'bäring etta tvåa'
		if bearingSaid != arr[1] + ' ' + arr[2]
			bearingSaid = arr[1] + ' ' + arr[2]
			result += arr[1] + ' ' + arr[2]
		if distanceSaid != arr[3]
			distanceSaid = arr[3]
			result += '. ' + arr[3]
		if result != "" then say result
	else if arr[0] == 'bearing'
		msg = arr[1] + ' ' + arr[2] # skippa ordet. t ex 'bäring etta tvåa'
		if bearingSaid != msg then say msg
		bearingSaid = msg
	else if arr[0] == 'distance' and (general.DISTANCE or arr[1] < LIMIT)
		msg = arr[1]                # skippa ordet. t ex 'distans 30'
		if distanceSaid != msg then say msg
		distanceSaid = msg
	else if arr[0] == 'target'
		bearingSaid = arr[2] + ' ' + arr[3]
		distanceSaid = arr[4]
		msg = "#{arr[0]} #{arr[1]}. bearing #{bearingSaid}. distance #{distanceSaid} meters"
		# Example: 'target 11. bearing zero niner. distance 250 meters'
		say msg
	else if arr[0] == 'saved'
		say msg.replace ':',' and '

locationUpdate = (p) ->
	console.log 'locationUpdate',p.coords
	pLat = myRound p.coords.latitude,6
	pLon = myRound p.coords.longitude,6
	if storage.trail.length == 0
		gpsLat = pLat
		gpsLon = pLon
	messages[3].attrs.text = gpsCount++
	decreaseQueue()
	increaseQueue p # meters
	uppdatera pLat, pLon

uppdatera = (pLat, pLon) ->
	dump.store ""
	dump.store "LU #{pLat} #{pLon}"
	[x,y] = w2b.convert pLon,pLat
	updateTrack pLat, pLon, x,y
	updateTrail pLat, pLon, x,y

updateTrack = (pLat, pLon, x,y) -> # senaste fem positionerna
	track.push [x,y]
	if track.length > TRACKED then track.shift()
	t = _.last track
	dump.store "T #{t[0]} #{t[1]}"
	messages[2].attrs.text = pLat + ' ' + pLon

updateTrail = (pLat, pLon, x,y)->
	position = [x,y]
	console.log 'updateTrail',x,y
	if storage.trail.length == 0
		storage.trail.push position
		return
	[qx, qy] = _.last storage.trail
	[qLon,qLat] = b2w.convert qx,qy
	a = LatLon pLat, pLon # newest
	b = LatLon qLat, qLon # last
	dist = a.distanceTo b # meters
	if dist > 5 + surplus
		dump.store "updateTrail #{dist}"
		storage.trail.push position
		surplus += 5 - dist

locationUpdateFail = (error) ->	if error.code == error.PERMISSION_DENIED then messages = ['','','','','','Check location permissions']
window.speechSynthesis.onvoiceschanged = -> voices = window.speechSynthesis.getVoices()

initSpeaker = ->
	#dump.store "initSpeaker in #{index}"
	index = int getParameters().speaker || 5
	speaker = new SpeechSynthesisUtterance()
	speaker.voiceURI = "native"
	speaker.volume = 1
	speaker.rate = 1.0
	speaker.pitch = 0
	speaker.text = '' 
	speaker.lang = 'en-GB'
	if voices and index <= voices.length-1 then speaker.voice = voices[index]

	soundUp = loadSound 'soundUp.wav'
	soundDown = loadSound 'soundDown.wav'
	soundUp.setVolume 0.1
	soundDown.setVolume 0.1
	clearInterval timeout
	timeout = setInterval playSound, DELAY
	soundQueue = 0

	dialogues.clear()
	say "Welcome!"
	track = []
	dump.store "initSpeaker out"

getMeters = (w,skala) ->
	[lon0,lat0] = b2w.convert 0,height
	[lon1,lat1] = b2w.convert w,height
	p0 = LatLon lat0, lon0
	p1 = LatLon lat1, lon1
	distans = p0.distanceTo(p1) / skala
	d = Math.log10 distans
	fract = fraction d
	for i in [1,2,5]
		if 10**fract > i then n = i
	[round(distans), n * 10**int d]

# myTest = ->
# 	getMeters 1920,1 # Smäller här
# 	getMeters 1920,1.5 # eller här. Android
# 	getMeters 1920,1.5*1.5
# 	getMeters 1920,1.5*1.5*1.5
	# assert [1434,1000], getMeters 1920,1 # Smäller här
	# assert [956,500], getMeters 1920,1.5 # eller här. Android
	# assert [638,500], getMeters 1920,1.5*1.5
	# assert [425,200], getMeters 1920,1.5*1.5*1.5
	#console.log "Ready!"

startup = ->
	await preload()

	raphael = Raphael 'raphael', window.innerWidth, window.innerHeight
	raphael.rect 0, 0, window.innerWidth, window.innerHeight
		.attr {fill: '#00f'}
	new Box 100, 100, window.innerWidth, window.innerHeight, mapName
	menu()

	#canvas = createCanvas innerWidth-0.0, innerHeight #-0.5
	#canvas.position 0,0 # hides text field used for clipboard copy.

	loadGeneral()

	#angleMode DEGREES
	SCALE = data.scale

	dcs = data.controls
	bmp = [dcs.A[0], dcs.A[1], dcs.B[0], dcs.B[1], dcs.C[0], dcs.C[1]]
	abc = data.ABC
	wgs = [abc[1],abc[0],abc[3],abc[2],abc[5],abc[4]] # lat lon <=> lon lat

	console.log 'startup2'
	b2w = new Converter bmp,wgs,6
	w2b = new Converter wgs,bmp,0

	storage = new Storage mapName
	storage.trail = []
	if params.trail then storage.trail = decodeAll params.trail

	# myTest() Do not execute! Very dependent on .json file.

	# [cx,cy] = [img.width/2,img.height/2]
	[cx,cy] = [WIDTH/2,HEIGHT/2]
	

	# navigator.geolocation.watchPosition locationUpdate, locationUpdateFail,
	# 	enableHighAccuracy: true
	# 	maximumAge: 30000
	# 	timeout: 27000

#	menuButton = new MenuButton width-160

info = () ->
	[x,y] = position
	[lon,lat] = b2w.convert x,y

	[
		"Platform: #{platform}"
		"Map: #{mapName}"
		"Version: #{VERSION}"
		"TrailPoints: #{storage.trail.length}"
		"GpsPoints: #{gpsCount}"
		"Bearing:  #{messages[0].attrs.text}"
		"Distance: #{messages[1].attrs.text}"
		"Position: #{messages[2].attrs.text}"
		"GPSCount: #{messages[3].attrs.text}"
		"PanSpeed: #{general.PANSPEED}"
		"Sector: #{general.SECTOR}"
		"Hear Coins: #{general.COINS}"
		"Hear Distance: #{general.DISTANCE}"
		"See Trail: #{general.TRAIL}"
		"Scale: #{SCALE}"
		"Dump: #{dump.data.length}"

	]

drawCrossHair = (x,y) ->
	r = 0.9 * data.radius
	if crossHair
		sw 1
		sc 1,1,1,0.5
		fc 1,0,0,0.5
	else
		sw 1
		sc 1,0,0
		fc 0,0,0,0.25
		r *= SCALE
	circle x,y,r
	line x,y-r,x,y+r
	line x-r,y,x+r,y

drawInfo = ->
	textAlign LEFT,CENTER
	sc()
	fc 0
	for m,i in info()
		text m,20,(i+0.5) * height / info().length

drawTrack = ->
	fc()
	sw 2/SCALE
	sc 0
	for [x,y],i in track
		circle x-cx, y-cy, 5 * (track.length-i)

drawTrail = ->
	if not general.TRAIL then return
	fc 1,1,0
	sw 1
	sc 0
	for [x,y] in storage.trail
		circle x-cx, y-cy, 2

drawControls = ->
	sw 2
	for key,control of storage.controls
		if control == null then continue
		[x,y,littera] = control

		r = data.radius

		if key in 'ABC' # Half Size
			stroke "#0f08"
			fill "#ff08"
			circle x-cx, y-cy, r/2
			sc()
			fc 0
			textSize r*0.75
			textAlign CENTER,CENTER
			text key, x-cx, y-cy
		else # Full Size
			if littera == ''
				stroke 0
				fc()
				circle x-cx, y-cy, r
				sc()
				fc 0
				textSize 1.5*data.radius
				textAlign CENTER,CENTER
				text key, x-cx, y-cy
			else
				sc()
				fc 0
				textSize 1.5*data.radius
				textAlign CENTER,CENTER
				text littera, x-cx, y-cy

		stroke 0
		point x-cx, y-cy

drawControl = ->
	if gpsLat == 0 or gpsLon == 0
		messages[0].attrs.text = ""
		messages[1].attrs.text = ""
	#	messages[2].text = ""
		return
	if crossHair
		[trgLon,trgLat] = b2w.convert crossHair[0],crossHair[1]
	else
		[trgLon,trgLat] = b2w.convert cx,cy
	latLon2 = LatLon trgLat,trgLon
	latLon1 = LatLon gpsLat,gpsLon
	bearing = latLon1.bearingTo latLon2
	#messages[0].text = ""
	messages[0].attrs.text = "#{int bearing}º"
	messages[1].attrs.text = "#{round(latLon1.distanceTo latLon2)} m"

drawRuler = ->
	[w1,w0] = getMeters width, SCALE
	d = (w1-w0)/2/w1 * width
	x = d
	y = height * 0.9
	w = w0/w1 * width
	h = height * 0.03
	sc 0
	sw 1
	fc()
	rect x,y,w,h
	textSize height/30
	textAlign CENTER,CENTER
	sc()
	fc 0
	text w0+"m",width/2,y+h*0.6

drawPois = ->
	for key,poi of pois
		[lat,lon] = poi
		[x,y] = w2b.convert lon,lat
		sw 1
		stroke "#ff0"
		fill "#000"
		textSize 0.25 * data.radius
		textAlign CENTER,CENTER
		text key, x-cx, y-cy

draw = ->
	bg 0,1,0
	if state == 0 
		textSize 100
		textAlign CENTER,CENTER
		x = width/2
		y = height/2
		text mapName, x,y-100
		text 'Version: '+VERSION, x,y
		if dump.active then text 'debug',x,y+100
		text "Click to continue!", x,y+200
		return

	if state == 1
		push()
		translate width/2, height/2
		scale SCALE

		image img, -cx,-cy
		drawTrail()
		drawTrack()

		if data.drawControls then drawControls()
		drawControl()
		if crossHair then drawCrossHair crossHair[0]-cx, crossHair[1]-cy # detached
		drawPois()
		pop()
		if not crossHair then drawCrossHair width/2,height/2 # attached
		fc 0
		sc 1,1,0
		sw 3
		margin = 25
		for message,i in messages
			textAlign [LEFT,CENTER,RIGHT][i%3], [TOP,BOTTOM][i//3]
			textSize [100,50][i//3]
			text message, [margin,width/2,width-margin][i%3], [margin,height][i//3] 
		drawRuler()

		showDialogue()
		menuButton.draw()
		#messages[3] = round frameRate()
		return

	if state == 2
		drawInfo()
		return

setTarget = ->
	soundQueue = 0
	firstInfo()
	storage.save()
	dialogues.clear()

executeMail = ->
	xxx = storage.trail
	link = "https://christernilsson.github.io/gpsKarta/index.html?map=" + mapName + "&trail=" + encodeAll xxx
	r = info().join BR
	t = ("#{key} #{x} #{y} #{littera} #{lat} #{lon}" for key,[x,y,littera,lat, lon] of storage.controls).join BR
	sendMail "#{mapName}", link + BR+BR + r + BR+BR + t + BR+BR + dump.get() + xxx
	storage.clear()

findKey = ->
	for key in 'DEFGHIJKLMNOPQRSTUVWXYZ'
		if key not of storage.controls then return key
	false

savePosition = ->
	[x,y] = w2b.convert gpsLon,gpsLat
	key = findKey()
	storage.controls[key] = [x,y,'',gpsLat,gpsLon]
	storage.save()
	voiceQueue.push "saved #{key}"
	dialogues.clear()

aim = ->
	if crossHair == null 
		crossHair = [cx,cy]
		setTarget()
	else
		crossHair = null
	dialogues.clear()

# menu1 = -> # Main Menu
# 	dialogue = new Dialogue()
# 	dialogue.add 'Center', ->
# 		[cx,cy] = position
# 		dialogues.clear()
# 	dialogue.add 'Out', ->
# 		if SCALE > data.scale then SCALE /= 1.5
# 		dialogues.clear()
# 	dialogue.add 'Take...', -> menu4()
# 	dialogue.add 'More...', -> menu6()
# 	dialogue.add 'Setup...', -> menu2()
# 	dialogue.add 'Aim', -> aim()
# 	dialogue.add 'Save', -> savePosition()
# 	dialogue.add 'In', -> 
# 		SCALE *= 1.5
# 		dialogues.clear()
# 	dialogue.clock ' ',true
# 	dialogue.textSize *= 1.5

# menu2 = -> # Setup
# 	dialogue = new Dialogue()
# 	dialogue.add 'PanSpeed', -> 
# 		general.PANSPEED = not general.PANSPEED
# 		saveGeneral()
# 		dialogues.clear()
# 	dialogue.add 'Coins', -> 
# 		general.COINS = not general.COINS
# 		saveGeneral()
# 		dialogues.clear()
# 	dialogue.add 'Distance', -> 
# 		general.DISTANCE = not general.DISTANCE
# 		saveGeneral()
# 		dialogues.clear()
# 	dialogue.add 'Trail', -> 
# 		general.TRAIL = not general.TRAIL
# 		saveGeneral()
# 		dialogues.clear()
# 	dialogue.add 'Sector...', -> menu3()
# 	dialogue.clock()
# 	dialogue.textSize *= 1.5

# menu3 = -> # Sector
# 	dialogue = new Dialogue()
# 	dialogue.add '10', -> SetSector 10 # 36
# 	dialogue.add '20', -> SetSector 20 # 18
# 	dialogue.add '30', -> SetSector 30 # 12
# 	dialogue.add '45', -> SetSector 45 # 8
# 	dialogue.add '60', -> SetSector 60 # 6
# 	dialogue.add '90', -> SetSector 90 # 4
# 	dialogue.clock()

# menu4 = -> # Take
# 	dialogue = new Dialogue()
# 	dialogue.add 'ABCDE', -> menu5 'ABCDE'
# 	dialogue.add 'KLMNO', -> menu5 'KLMNO'
# 	dialogue.add 'UVWXYZ', -> menu5 'UVWXYZ'
# 	dialogue.add 'Clear', -> update ' '
# 	dialogue.add 'PQRST', -> menu5 'PQRST'
# 	dialogue.add 'FGHIJ', -> menu5 'FGHIJ'
# 	dialogue.clock()

# menu5 = (letters) -> # ABCDE
# 	dialogue = new Dialogue()
# 	for letter in letters
# 		dialogue.add letter, -> update @title
# 	dialogue.clock()

# menu6 = -> # More
# 	dialogue = new Dialogue()
# 	dialogue.add 'Init', -> initSpeaker()
# 	dialogue.add 'Mail...', ->
# 		executeMail()
# 		dialogues.clear()
# 	dialogue.add 'Delete', ->
# 		storage.deleteControl()
# 		dialogues.clear()
# 	dialogue.add 'Clear', ->
# 		storage.clear()
# 		dialogues.clear()
# 	dialogue.add 'Info...', -> 
# 		state = 2
# 		dialogues.clear()
# 	dialogue.clock()
# 	dialogue.textSize *= 1.5


update = (littera) ->
	key = findKey()
	[x,y] = crossHair
	[lon,lat] = b2w.convert x,y
	storage.controls[key] = [x,y,littera,lat,lon]
	storage.save()
	crossHair = null
	dialogues.clear()
	#executeMail()

showDialogue = -> if dialogues.length > 0 then (_.last dialogues).show()

touchStarted = (event) ->
	lastTouchStarted = new Date()
	#console.log 'touchStarted',released,state
	event.preventDefault()
	if not released then return 
	speed = 1
	if general.PANSPEED then speed = 0.1 + 0.9 * dist(mouseX,mouseY,width/2,height/2) / dist(0,0,width/2,height/2)
	dump.store "touchStarted #{(new Date())-start} #{JSON.stringify touches}"
	released = false
	startX = mouseX
	startY = mouseY
	false

touchMoved = (event) ->
	#console.log 'touchMoved',released,state
	dump.store "touchMoved #{(new Date())-start} #{JSON.stringify touches}"
	event.preventDefault()
	if dialogues.length == 0 and state == 1
		cx += speed * (startX - mouseX)/SCALE
		cy += speed * (startY - mouseY)/SCALE
		startX = mouseX
		startY = mouseY
	false

touchEnded = (event) ->
	#console.log 'touchEnded',released,state
	event.preventDefault()
	if (new Date()) - lastTouchEnded < 500
		lastTouchEnded = new Date()
		return # to prevent double bounce
	if released then return
	dump.store "touchEnded #{(new Date())-start} #{JSON.stringify touches}"
	released = true
	if state == 0 then initSpeaker()
	if state == 2 then dialogues.clear()
	if state in [0,2]
		state = 1
		return false
	#console.log 'ADAM',mouseX,mouseY
	if menuButton.inside mouseX,mouseY
		#console.log 'BERTIL'
		menuButton.click()
		return false
	if dialogues.length > 0
		#console.log 'CESAR'
		dialogue = _.last dialogues
		#if not dialogue.execute mouseX,mouseY then dialogues.pop()
		dialogue.execute mouseX,mouseY # then dialogues.pop()
	false

keyPressed = -> # Används för att avläsa ABC bitmapskoordinater
	console.log key
	if key == ' '
		x = round cx + (mouseX - width/2) / SCALE  	# image koordinater
		y = round cy + (mouseY - height/2) / SCALE
		console.log x,y
		letter = "ABC"[_.size measure]
		measure[letter] = [x,y]
		if letter == 'C' then console.log '"controls": ' + JSON.stringify measure
