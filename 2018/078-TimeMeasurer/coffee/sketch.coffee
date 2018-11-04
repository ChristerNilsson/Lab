KEY = '078-TimeMeasurer'

persons = []
db = {}

class Person
	constructor : (@name,@y,@konto=0) ->
		@state = 0
		@w = 80
		@h = 30
		@lastValue = 0 # millis sedan 1970

	draw : ->
		@update()
		sc()
		fc 0
		text @name,100,@y

		# minus
		fc 1,1,1
		if @state == -1 then fc 1,0,0
		if @state == 0 then fc 1,1,1
		sc 0
		rect 200,@y,@w,@h
		sc()
		fc 0
		text '-',200,@y

		# konto
		k = @konto
		fc 0
		k //= 1000		
		s = k % 60
		k //= 60
		m = k % 60
		k //= 60
		h = k
		text "#{nf h,2}:#{nf m,2}:#{nf s,2}",300,@y

		# plus
		fc 1,1,1
		if @state == 0 then fc 1,1,1
		if @state == 1 then fc 0,1,0
		sc 0
		rect 400,@y,@w,@h
		sc()
		fc 0
		text '+',400,@y

	update : ->
		if @lastValue == 0 then @lastValue = Date.now()
		d = Date.now() # millis sedan 1970
		@konto += @state * (d - @lastValue)
		if @konto < 0 then @konto = 0
		@lastValue = d

	inside : (x,y,mx,my) -> x-@w/2 < mx < x+@w/2 and y-@h/2 < my < y+@h/2
	execute : (mx,my) ->
		if @inside 100,@y,mx,my then @state = 0
		if @inside 200,@y,mx,my then @state = -1 
		if @inside 300,@y,mx,my then @state = 0
		if @inside 400,@y,mx,my then @state = 1

setup = ->
	createCanvas 800,600

	s = localStorage[KEY] 
	if s==undefined then s='{}'
	db = JSON.parse s

	hash = getParameters()
	if hash != undefined 
		names = hash['names']
		for name,i in names.split '|'
			konto = db[name]
			if konto == null then konto = 0
			persons.push new Person name,150+i*50,konto

	sc()
	textSize 20
	textAlign CENTER,CENTER
	rectMode CENTER

draw = ->
	bg 1
	for person,i in persons
		person.draw()
		db[person.name] = person.konto
	localStorage[KEY] = JSON.stringify db

mousePressed = ->
	for person in persons
		person.execute mouseX,mouseY
