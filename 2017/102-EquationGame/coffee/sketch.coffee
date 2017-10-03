buttons = []
hist = []
targets = []
undoButton = null
newButton = null

n = 3
level = 3
SHOW = true

start = []
matrix = []
arrTargets = []
R = 25

class Button
	constructor : (@i,@value,@x,@y,@r,@f) ->
	draw : ->
		fc 1
		circle @x,@y,@r
		fc 0
		text @value,@x,@y
	mousePressed : ->
		if dist(mouseX,mouseY,@x,@y) < @r then @f()

f = ->
	hist.push (button.value for button in buttons)
	undoButton.value = level - hist.length
	row = matrix[@i]
	sum = 0
	for cell,i in row
		sum += cell * buttons[i].value
	buttons[@i].value = sum

dump = ->
	print level, hist.length,level - hist.length

undo = ->
	if hist.length > 0
		item = hist.pop()
		for value,i in item
			buttons[i].value = value
		undoButton.value = level - hist.length

newGame = -> makeProblem()

randint = (a,b) -> a + int random b-a

makeProblem = ->
	start = []
	matrix = []
	arrTargets = []
	hist = []
	a = -n
	b = n+1
	for i in range n
		start.push randint a,b
		matrix.push (randint a,b for j in range n)
		buttons[i].value = start[i]
	for i in range level
		buttons[randint 0, n].f()
	for i in range n
		arrTargets.push buttons[i].value
	for i in range n
		buttons[i].value = start[i]
	print hist.concat [arrTargets] # [(button.value for button in buttons)]
	hist = []
	undoButton.value = level - hist.length

setup = ->
	createCanvas 600,400
	rectMode CENTER
	textAlign CENTER,CENTER
	for i in range n
		buttons.push new Button i,0,2*R*n+R,R+2*R*i,R,f
	undoButton = new Button -1,0,width-R,R,R,undo
	newButton = new Button -1,'new',width-R,3*R,R,newGame
	makeProblem()

draw = ->
	bg 0.5
	textSize 20
	button.draw() for button in buttons.concat [undoButton]
	if undoButton.value == 0 and _.isEqual arrTargets, (button.value for button in buttons)
		newButton.draw()
	if SHOW
		for i in range n
			for j in range n
				text matrix[i][j],R+2*R*j,R+2*R*i
	fc 0,1,0
	for i in range n
		text arrTargets[i],2*R*(n+1)+R,R+2*R*i

mousePressed = -> button.mousePressed() for button in buttons.concat [newButton,undoButton]
