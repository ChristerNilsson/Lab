# Yttre ringen hanterar måndag=1
# Inre ringen hanterar fredag=5
# Varje ämne har en egen färg
# Pågående lektion markeras med ett streck.
# I mitten visas tid kvar tills lektion börjar eller slutar.
# Där visas även ämne, sal, starttid samt sluttid

# Day Subject hhmm hhmm Room ;
# 1Ma08300930S323 => Day=1 Subject=Ma start=0830 stopp=0930 Room=S323
#     012345678901234
arg ='Mo08300930MaS323;Mo09401040SvS218;Mo12401350FyS142;'
arg+='Tu08300955EnS324;Tu12151325MaP957;'
arg+='We10351125FyP315;We12151325MaQ323;We13501450IdQ957;'
arg+='Th13001425EnQ232;Th14351555SvS546;'
arg+='Fr08300930MaS434;Fr11051200FyP957'



# http://christernilsson.github.io/Lab/2017/082-CalendarClock/index.html?s=Mo08300930MaS323;Mo09401040SvS218;Mo12401350FyS142;Tu08300955EnS324;Tu12151325MaP957;We10351125FyP315;We12151325MaQ323;We13501450IdQ957;Th13001425EnQ232;Th14351555SvS546;Fr08300930MaS434;Fr11051200FyP957'



schema = []
colors = {}

unpack = (arg) ->
	arr = arg.split ';'
	res = []
	for item in arr

		day = item[0..1]
		day = 1 + 'MoTuWeThFr'.indexOf(day) / 2
		subject = item[2..3]
		hhmm1 = item[4..7]
		hhmm2 = item[8..11]
		t1 = minutes day, parseInt(item[4..5]),parseInt(item[6..7])
		t2 = minutes day, parseInt(item[8..9]),parseInt(item[10..11])
		room = item[12..15]
		res.push [subject,t1,t2,room,hhmm1,hhmm2]

		if subject not in _.keys colors
			n = _.size colors
			if n==0 then c=[0,0,0]
			if n==1 then c=[1,0,0]
			if n==2 then c=[1,1,0]
			if n==3 then c=[0,1,0]
			if n==4 then c=[1,1,1]
			if n==5 then c=[1,0,1]
			if n==6 then c=[0,0,1]
			if n==7 then c=[0,1,0]
			colors[subject] = c
	res

setup = ->
	createCanvas windowWidth,windowHeight

	fc()
	strokeCap SQUARE
	textAlign CENTER,CENTER
	frameRate 1

	params = getURLParams()
	if _.size(params) == 0
		schema = unpack arg
	else
		schema = unpack params.s

minutes = (d,h,m) -> 60 * (d*24 + h) + m
rad = (minutes) -> radians minutes/2 %% 360 - 90
myarc = (start,stopp) ->
	day = int start / 1440
	arc 0,0,2*110-20*day,2*110-20*day,rad(start),rad(stopp)

myline = (t) ->
	day = int t / 1440
	sw 11
	arc 0,0,2*110-20*day,2*110-20*day,rad(t),rad(t+1)

draw = ->
	r = 100
	translate width/2,height/2
	scale _.min([width,height])/220
	bg 0.5
	state = 0
	sw 1

	tday = (new Date()).getDay()
	t = minutes tday,hour(),minute()

	r1 = 55
	r2 = 105
	sc 0.6
	for v in range 0,360,30
		line r1*cos(radians(v)),r1*sin(radians(v)),r2*cos(radians(v)),r2*sin(radians(v))

	for r in range 55,110,10
		circle 0,0,r

	for item in schema
		[subject,start,stopp,room,hhmm1,hhmm2] = item

		if stopp <= t then nextstate = 0
		else if start >= t then nextstate = 2
		else nextstate = 1

		if state==0 and nextstate==2
			info subject, room, t-start, hhmm1,hhmm2
		state = nextstate

		sw 9
		fc()
		if state==0
			sc 0.6
			myarc start,stopp
		if state==2
			[r,g,b] = colors[subject]
			sc r,g,b
			myarc start,stopp
		if state==1
			sc 0.6
			myarc start,t
			[r,g,b] = colors[subject]
			sc r,g,b
			myarc t,stopp

			sw 3
			[r,g,b] = colors[subject]
			sc 1-r,1-g,1-b
			myarc t,stopp
			info subject, room, stopp-t, hhmm1,hhmm2
	sc 0
	myline t

pretty = (minutes) ->
	if minutes<60 then return minutes
	h = int minutes/60
	m = minutes%60
	if m<10 then h + ':0' + m else h + ':' + m

info = (subject,room,tid,hhmm1,hhmm2) ->
	sc()
	if tid<0
		[r,g,b] = [0.75,0.75,0.75]
		tid = -tid
	else
		[r,g,b] = [0,0,0]
	fc r,g,b
	textSize 32
	text pretty(tid),0,0

	[r,g,b] = colors[subject]
	fc r,g,b
	textSize 20
	text subject,0,-28

	fc 0
	text room,0,30
	textSize 12
	text hhmm1,-30,-25
	text hhmm2,30,-25
