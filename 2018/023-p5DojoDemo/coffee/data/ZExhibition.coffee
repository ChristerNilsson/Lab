ID001 =  # clown:
	v:'2017-05-02'
	k:'bg circle fc sc sw line lerp'
	l:30
	b:"# (David Larsson)\n"
	a:"""
bg 0, 1, 0, 0.5
fc 1, 0, 0
circle 10, 10, 5
circle 20, 20, 10
for i in range 10
	x = lerp 10, 20, i
	y = x
	r = lerp 5, 10, i
	circle x, y, r
fc 0, 1, 1
circle 190, 10, 5
circle 180, 20, 10
for i in range 10
	x = lerp 190, 180, i
	y = lerp 10, 20, i
	r = lerp 5, 10, i
	circle x, y, r
fc 1
circle 100, 100, 50
fc 0
circle 80, 80, 10
circle 120, 80, 10
sc 1, 1, 0
sw 5
line 70, 105, 80, 120
line 80, 120, 115, 120
line 115, 120, 130, 105
fc 1, 0, 0
sc 1, 0, 0
circle 100, 100, 10

"""

ID002 = #tomteluva:
	v:'2017-05-02'
	k:'circle fc sc triangle'
	l:12
	b:"# (Sabrina Larsson)\n"
	a:"""
bg 0,1,0
fc 1,0,0
sc 1,0,0
triangle 60,140,100,60,140,140
fc 1
sc 1
circle 60,140,10
circle 80,140,10
circle 100,140,10
circle 120,140,10
circle 140,140,10
circle 100,60,10
"""

ID003 = # snowman:
	v:'2017-05-02'
	k:'circle fc line sc triangle'
	l:21
	b:"# (David Larsson)\n"
	a:"""
fc 1
circle 100, 150, 50
circle 100, 70, 40
fc 0
circle 80, 60, 8
circle 120, 60, 8
circle 85, 90, 6
circle 95, 95, 6
circle 115, 90, 6
circle 105, 95, 6
fc 1, 0, 0, 0.5
triangle 100, 65, 90, 80, 105, 75
sc 1, 1, 0
sw 3
line 50, 140, 30, 90
line 35, 100, 40, 80
line 140, 140, 170, 90
line 160, 105, 155, 100
fc 1
sc 1
rect 2, 180, 196, 20
"""

ID004 = # christmasTree:
	v:'2017-05-02'
	k:'bg circle fc line rect quad sc triangle'
	l:35
	b:"# (Sabrina Larsson)\n"
	a:"""
bg 0
fc 0, 1, 0
sc 0, 1, 0
triangle 100, 100, 180, 160, 20, 160
triangle 100, 60, 160, 120, 40, 120
triangle 100, 40, 140, 80, 60, 80
fc 0.5
sc 0.5
rect 80, 160, 40, 20
fc 1, 1, 0
sc 1, 1, 0
quad 100, 0, 120, 20, 100, 40, 80, 20
rect 85, 5, 30, 30
sc 1, 1, 0
line 80, 60, 140, 120
line 60, 100, 120, 160
fc 1, 0, 0
sc 1, 0, 0
circle 80, 100, 5
circle 140, 140, 5
circle 100, 60, 5
circle 60, 160, 5
circle 100, 120, 5
fc 1
sc 1
rect 0, 180, 200, 20
circle 20, 20, 5
circle 40, 40, 5
circle 10, 80, 5
circle 30, 140, 5
circle 50, 100, 5
circle 120, 50, 5
circle 160, 20, 5
circle 180, 80, 5
circle 160, 130, 5
circle 190, 180, 5
"""

ID005 = # santa:
	v:'2017-05-02'
	k:'bg circle ellipse fc rect quad sc triangle'
	l:18
	b:"# (Sabrina Larsson)\n"
	a:"""
bg 0,0,1
fc 1,0,0
sc 1,0,0
ellipse 100,50,60,70
rect 60,20,30,10
quad 140,10,145,20,120,25,115,20
fc 0
sc 0
circle 50,25,10
rect 70,40,60,10
circle 140,20,10
sc 1,1,0
rect 100,45,5,5
fc 0.5
sc 0.5
rect 60,80,80,20
rect 80,100,40,60
triangle 100,140,0,200,200,200
"""

ID006= # dist:
	v:'2017-05-02'
	k:'bg circle dist fc lerp map sc'
	l:10
	b:""
	a:"""
bg 0
fc 1
sc()
for i in range 10
	x = lerp 10,30,i
	for j in range 10
		y = lerp 10,30,j
		d = dist 100,100,x,y
		r = map(d,0,150,1,20)/2
		circle x,y,r
"""

ID007 = # bulge:
	v:'2017-05-02'
	k:'bg circle dist fill map noStroke sin'
	l:10
	b:""
	a:"""
bg 0
fill 255
noStroke()
for i in range 20
	for j in range 20
		x = i*200/20+5
		y = j*200/20+5
		r = map(sin(i*PI/20),-1,1,1,3) * map(sin(j*PI/20),-1,1,1,3) / 2
		circle x,y,r
"""

ID008 = # wave:
	v:'2017-05-02'
	k:'circle colorMode fill map noStroke sin PI'
	l:9
	b:""
	a:"""
colorMode HSB,360,100,100
noStroke()
bg 0
for i in range 21
	fill map(i,0,20,0,360),100,100
	a = map i,0,20,0,2*PI
	x = 10*i
	y = map sin(a),-1,1,0,200
	circle x,y,3
"""

ID009 = # circle:
	v:'2017-05-02'
	k:'bg circle colorMode cos fc map PI sc sin'
	l:10
	b:""
	a:"""
bg 0
colorMode HSB,360,100,100
for i in range 20
	r=map i,0,19,0,360
	fill r,255,255
	a=map i,0,20,0,2*PI
	sc()
	x=map cos(a),-1,1,0,200
	y=map sin(a),-1,1,0,200
	circle x,y,3
"""

ID010 = # circles:
	v:'2017-05-02'
	k:'bg circle colorMode cos fill map noStroke translate sin PI'
	l:12
	b:""
	a:"""
bg 0
noStroke()
colorMode HSB,360,100,100
translate 100,100
for i in range 20
	for j in range 11
		fill map(i,0,20,0,360),255,255
		a = map i,0,20,0,2*PI
		x = map cos(a),-1,1,-j*10,j*10
		y = map sin(a),-1,1,-j*10,j*10
		r = 3
		circle x,y,r
"""

ID011 = # sized_circles:
	v:'2017-05-02'
	k:'circle colorMode cos fill map noStroke PI sin translate'
	l:12
	b:""
	a:"""
bg 0
noStroke()
colorMode HSB,360,100,100
translate 100,100
for i in range 20
	fill map(i,0,20,0,360),255,255
	a = map i,0,20,0,2*PI
	for j in range 11
		x = map cos(a),-1,1,-j*10,j*10
		y = map sin(a),-1,1,-j*10,j*10
		r = map(j,0,10,0,10)/2
		circle x,y,r
"""

ID012 = # rotated_circles:
	v:'2017-05-02'
	k:'circle cos map PI push pop rotate sin translate'
	l:17
	b:""
	a:"""
colorMode HSB,360,100,100
sc()
bg 0
translate 100,100
for i in range 20
	r = map i,0,20,0,360
	a=map i,0,20,0,2*PI
	for j in range 11
		push()
		rotate map j,0,10,0,360
		fill r,255,255
		x=map cos(a),-1,1,-j*10,j*10
		y=map sin(a),-1,1,-j*10,j*10
		circle x,y,j/2
		pop()
"""

ID013 = # gravity :
	v:'2017-05-02'
	k:'circle lerp'
	l:6
	b: ""
	a: """
fc 1
for i in range 15
	x=5+10*i
	y=5+lerp(0,lerp(0,1,i),i)
	circle x,y,5
"""

ID014 = # hypnoticA :
	v:'2017-05-02'
	k:'bg circle cos fc sc sin'
	l:6
	b: ""
	a: """
bg 0.5, 0, 0
sc()
fc 1
for i in range 100
	x = 100 + cos(i) * i
	y = 100 + sin(i) * i
	circle x, y, 5
"""

ID015 = # hypnoticB :
	v:'2017-05-02'
	k:'bg circle cos fc map sc sin'
	l:7
	b: ""
	a: """
bg 0.5, 0, 0
sc()
fc 1
for i in range 100
	x = 100 + cos(i) * i
	y = 100 + sin(i) * i
	speed = i/10.0
	r = map sin(5*speed), -1, 1, 2, 5
	circle x, y, r
"""

ID016 = # Rainbow :
	v:'2017-05-02'
	k:'bg fc sc sw circle arc'
	l:37
	b:"# (Isabel T)\n"
	a:"""
bg 0.5,0.8,1

sw 11
fc()
sc 0.9,0.1,0.1
arc 100,97,190,180,PI,PI
sc 0.9,0.4,0.1
arc 100,107,180,180,PI,PI
sc 1,0.75,0
arc 100,117,170,180,PI,PI
sc 0.4,0.75,0.2
arc 100,127,160,180,PI,PI
sc 0.1,0.65,0.6
arc 100,137,150,180,PI,PI
sc 0.15,0.45,0.65
arc 100,147,140,180,PI,PI
sc 0.55,0.25,0.55
arc 100,157,130,180,PI,PI

sw 0
fc 1
circle 0,108,10
circle 10,120,13
circle 15,130,10
circle 20,145,13
circle 35,157,12
circle 37,170,12
circle 25,175,10
circle 10,170,10
circle 5,150,26

circle 200,108,10
circle 190,120,13
circle 185,130,10
circle 180,145,13
circle 165,157,12
circle 163,170,12
circle 175,175,10
circle 190,170,10
circle 195,150,26
"""

ID017 = # Melon :
	v:'2017-05-15'
	k:'bg fc sc rect'
	l:44
	b:"# (Sabrina)\n"
	a:"""
bg 0.866, 0.941, 1.000
fc 0.168, 0.615, 0.000
sc()
rect 170,40,10,60
rect 160,30,10,10
rect 150,20,10,10
rect 160,100,10,20
rect 150,110,10,20
rect 140,120,10,20
rect 130,130,10,10
rect 80,140,50,10
rect 60,130,10,10
rect 50,120,10,10
fc 0.415, 0.745, 0.000
rect 50,110,10,10
rect 60,120,10,10
rect 70,130,60,10
rect 130,120,10,10
rect 140,110,10,10
rect 150,100,10,10
rect 160,40,10,60
rect 150,30,10,10
rect 140,20,10,10
fc 0.980, 0.772, 1.000
rect 140,30,10,20
rect 150,40,10,60
rect 140,90,10,20
rect 120,110,20,10
rect 70,120,60,10
rect 60,110,20,10
fc 0.890, 0.062, 0.000
rect 80,80,40,40
rect 120,40,20,70
rect 110,50,40,40
rect 90,70,10,10
rect 100,60,10,20
rect 70,90,10,20
rect 60,100,10,10
rect 130,30,10,10
fc 0
rect 80,100,10,10
rect 100,90,10,10
rect 120,70,10,10
rect 130,50,10,10
"""

ID018 = # Sailing Boat :
	v:'2017-05-26'
	k:'bg fc sw sc circle triangle line angleMode rotate arc ellipse'
	l:24
	b:"# (Sabrina)\n"
	a:"""
bg 0,1,1
fc 1,1,0
sw 0
circle 130,100,57
sw 8
sc 1,1,0
noFill()
circle 130,100,75
circle 130,100,105
fc 1
sc()
triangle 100,120,60,120,100,56
sc 0.25,0.25,0
sw 10
line 100,60,100,125
fc 0.25,0.25,0
sw 0
sc 0
rotate 20
arc 130,70,100,100,0,1900,0
fc 0,0,1
ellipse 100,170,150,100
ellipse 170,150,150,100
ellipse 250,125,170,100
"""