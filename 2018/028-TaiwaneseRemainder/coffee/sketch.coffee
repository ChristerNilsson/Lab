# Man sparar bara de problem man själv löst till localStorage.
# Problem via url sparas ej.

buttons = []
clocks = []
game = {}
N = 60

RED   = "#F00"
GREEN = "#0F0"
BLACK = "#000"
WHITE = "#FFF"

DELAY = 60 # seconds per step before Solution is available

solutionTimer = null
solution = ""

reset = ->
	game.totalSteps = 0 
	game.totalPoints = 0
	for clock in clocks
		clock.reset()

ok = ->
	if @enabled 
		if game.steps==game.totalSteps and game.totalPoints==game.total then newGame 1
		else if game.steps==game.totalSteps then newGame 1
		else newGame -1

setup = -> 
	createCanvas 1200,590
	angleMode DEGREES
	textAlign CENTER,CENTER
	buttons.push new Button 'Steps:',120,60,48 
	buttons.push new Button 'reset',120,170,48, reset
	buttons.push new Button 'ok',120,280,48, ok
	buttons.push new Button 'All clocks green',120,360,24
	buttons.push new Button 'Use all steps',120,390,24
	buttons.push new Button 'Share via clipboard',120,450,24, -> 
		copyToClipboard game.url
		@enabled = false 
	buttons.push new Button 'Taiwanese Remainder',120,20,20 
	buttons.push new Button 'Solution',120,540,20, -> 
		if @enabled 
			solution = solve game.ticks, game.total, game.steps
			solution = solution.join ' '
			@enabled = false 
			solutionTimer = millis()
	buttons.push new Button 'Combinations',120,510,20 
	buttons.push new Button 'Level',120,480,20 

	buttons[5].enabled = true

	if '?' in window.location.href 
		params = getParameters()
		if 3 == _.size params
			game =
				level : parseInt params.level
				ticks : (parseInt r for r in params.ticks.split ',')
				rests : (parseInt r for r in params.rests.split ',') 
				url : window.location.href
			newGame1()
			return
	else 
		tr = localStorage['TaiwaneseRemainder']
		if tr?  
			game = JSON.parse tr
			if game.level?
				newGame1()
			else
				game = {level : 0}
				newGame 0
		else
			game = {level : 0}
			newGame 0

class Button
	constructor : (@txt,@x,@y,@size,@f=->) -> @enabled=false
	draw : ->
		fill if @enabled then WHITE else BLACK
		sc()
		textSize @size
		text @txt,@x,@y

class Clock
	constructor : (@rest, @tick, @x, @y) -> @reset()

	reset : ->
		@count = 0 
		@value = -@rest %% @tick
		@oldValue = @value 
		@delta = 0
		@n = N

	draw : ->
		push()
		translate @x,@y
		sw 4
		twelve = game.totalPoints % @tick == @rest
		fill if twelve then GREEN else RED
		stroke BLACK
		circle 0,0,50
		fill if twelve then BLACK else WHITE
		sw 1
		sc()
		textAlign CENTER,CENTER
		textSize 40
		text @tick,0,0
		if @tick>30
			textSize 20
			text @rest,0,30

		# subtract
		if @count>0 
			fill   if @count > 0 then WHITE else BLACK
			sc()
			textSize 40
			text @count,80,0
		
		if @n < N then @n++		
		rotate -90 + (@n * @delta/N) * 360 / @tick

		stroke WHITE
		for j in range @tick
			sw 2
			point 50,0
			sw 2
			if j == @oldValue then line 25,0,46,0
			rotate 360/@tick
		pop()

	add : (delta) ->
		@delta = delta 
		@oldValue = @value
		@value = (@value + delta) %% @tick
		@n = 0

	move : (step) ->
		if @count+step < 0 then return 
		buttons[5].enabled = true 
		tick = step * @tick
		game.totalPoints += tick
		game.totalSteps += step
		@count += step
		for clock in clocks
			clock.add tick		

okidoki = -> true

newGame = (delta) ->
	game.level += delta
	if game.level < 0 then game.level = 0
	N = int map game.level,0,100,60,10

	game = createProblem game.level
	if '?' not in window.location.href
		localStorage['TaiwaneseRemainder'] = JSON.stringify game
	newGame1()

newGame1 = ->
	game.steps = game.level % 5 + game.level // 5 + 1
	game.combinations = combinations game.steps,game.ticks.length
	print "#{game.steps}, [#{game.ticks}], [#{game.rests}]"
	reset()
	clocks = []
	C = 5
	for i in range game.ticks.length
		clock = new Clock game.rests[i], game.ticks[i], 300 + 200*(i//C), 60+110*(i%C)
		clocks.push clock
		clock.forward  = -> @move  1
		clock.backward = -> @move -1
	solutionTimer = millis()
	solution = ''

info = ->
	buttons[0].txt = 'steps: ' + (game.steps - game.totalSteps)
	buttons[1].enabled = game.totalSteps > 0
	buttons[2].enabled = okidoki()
	buttons[8].txt = 'Combinations: ' + short combinations game.steps,game.ticks.length
	buttons[9].txt = 'Level: ' + game.level
	button.draw() for button in buttons

draw = ->
	bg 0.5
	info()
	clock.draw() for clock in clocks
	buttons[7].enabled = game.total? and millis() > solutionTimer + DELAY * 1000 * game.steps 
	fc 0
	text solution,width/2,buttons[7].y+30

mousePressed = ->
	for b in buttons
		if 50 > dist mouseX,mouseY,b.x,b.y then b.f() 
	for c in clocks
		if 50 > dist mouseX,mouseY,c.x,    c.y then c.forward()
		if 50 > dist mouseX,mouseY,c.x+100,c.y then c.backward()
