# Yttre ringen hanterar måndag
# Inre ringen hanterar fredag
# Varje ämne har en egen färg
# Pågående lektion markeras med ett streck.
# I mitten visas en klocka alternativt
#  minuter kvar tills lektion börjar eller slutar.
#  Där visas även ämne och sal.

# Day Subject hhmm hhmm Room ;
#     012345678901234
arg ='1Ma083009303323;1Sv094010403218;1Fy124013502142;'
arg+='2En083009552324;2Ma121513251957;'
arg+='3Fy103511252315;3Ma121513252323;3Id135014501957;'
arg+='4En130014253232;4Sv143515553546;'
arg+='5Ma083009303434;5Fy110512001957'

# index.html/1Ma083009303323;1Sv094010403218;1Fy124013502142;2En083009552324;2Ma121513251957;3Fy103511252315;3Ma121513252323;3Id135014501957;4En130014253232;4Sv143515553546;5Ma083009303434;5Fy110512001957

X=200
Y=200
R=200

schema = []
colors = {}

unpack = (arg) ->
	arr = arg.split ';'
	res = []
	for item in arr

		day = int item[0]
		subject = item[1..2]
		t1 = minutes day, parseInt(item[3..4]),parseInt(item[5..6])
		t2 = minutes day, parseInt(item[7..8]),parseInt(item[9..10])
		room = item[11..14]
		res.push [subject,t1,t2,room]

		print subject,t1,t2,room

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
	createCanvas 400,400
	fc()
	strokeCap SQUARE
	textAlign CENTER,CENTER

	params = getURLParams()
	schema = unpack params.s
	xdraw()

minutes = (d,h,m) -> 60 * (d*24 + h) + m
rad = (minutes) -> radians minutes/2 %% 360 - 90
myarc = (start,stopp) ->
	print 'myarc',start,stopp
	day = int start / 1440
	arc X,Y,2*110-20*day,2*110-20*day,rad(start),rad(stopp)

xdraw = ->
	bg 0.5
	state = 0

	# tday = (new Date()).getDay()
	# t = minutes(tday,hour(),minute())
	# print tday,t

	tday = 2
	t = minutes(2,21,4)
	print tday,t

	r1 = 55
	r2 = 105
	sc 0.6
	for v in range 0,360,30
		line X+r1*cos(radians(v)),Y+r1*sin(radians(v)),X+r2*cos(radians(v)),Y+r2*sin(radians(v))

	for r in range 55,110,10
		circle X,Y,r

	for item in schema
		[subject,start,stopp,room] = item

		if stopp <= t then nextstate = 0
		else if start >= t then nextstate = 2
		else nextstate = 1

		if state==0 and nextstate==2
			info subject, room, t-start
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
			print t,start,stopp,state
			sc 0.6
			myarc start,t
			[r,g,b] = colors[subject]
			sc r,g,b
			myarc t,stopp

			sw 3
			[r,g,b] = colors[subject]
			sc 1-r,1-g,1-b
			myarc t,stopp
			info subject, room, stopp-t

pretty = (minutes) ->
	if minutes<60 then return minutes
	h = int minutes/60
	m = minutes%60
	h + ':' + m

info = (subject,room,tid) ->
	sc()
	if tid<0
		[r,g,b] = [0.75,0.75,0.75]
		tid = -tid
	else
		[r,g,b] = [0,0,0]
	fc r,g,b
	textSize 32
	text pretty(tid),X,Y

	[r,g,b] = colors[subject]
	fc r,g,b
	textSize 20
	text subject,X,Y-30

	textSize 20
	fc 0
	text room,X,Y+30
