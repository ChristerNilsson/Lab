counter = 0
nCommands = 0
# Visa startläge och slutläge
# Räkna antalet operationer
# Avgör om succe eller ej

ENG = 'for i in range 10\n\tfor j in range 10\n\t\tx = lerp 10,30,i\n\t\ty = lerp 10,30,j\n\t\trect x,y,10,10'

PROBLEMS = [ # operations,line,ch,startläge,slutläge
	[1,2,8,ENG, 'for i in range 10\n\tfor j in range 10\n\t\tx = lezrp 10,30,i\n\t\ty = lerp 10,30,j\n\t\trect x,y,10,10'] # x
	[1,2,8,ENG, 'for i in range 10\n\tfor j in range 10\n\t\tx = lrp 10,30,i\n\t\ty = lerp 10,30,j\n\t\trect x,y,10,10'] # Backspace
	[1,2,8,ENG, 'for i in range 10\n\tfor j in range 10\n\t\tx = lep 10,30,i\n\t\ty = lerp 10,30,j\n\t\trect x,y,10,10'] # Del
	[1,2,8,ENG, 'for i in range 10\n\tfor j in range 10\n\t\ty = lerp 10,30,j\n\t\trect x,y,10,10'] # CtrlX
	[2,2,8,ENG, 'for i in range 10\n\tfor j in range 10\n\tx = lerp 10,30,i\n\t\ty = lerp 10,30,j\n\t\trect x,y,10,10'] # Home Backspace
	[2,2,8,ENG, 'for i in range 10\n\tfor j in range 10\n\t\t\tx = lerp 10,30,i\n\t\ty = lerp 10,30,j\n\t\trect x,y,10,10'] # Home Tab
	[2,2,8,ENG, 'zfor i in range 10\n\tfor j in range 10\n\t\tx = lerp 10,30,i\n\t\ty = lerp 10,30,j\n\t\trect x,y,10,10'] # ctrlHome x
	[2,2,8,ENG, 'for i in range 10\n\tfor j in range 10\n\t\tx = le 10,30,i\n\t\ty = lerp 10,30,j\n\t\trect x,y,10,10'] # Del Del
	[2,2,8,ENG, 'for i in range 10\n\tfor j in range 10\n\t\tzx = lerp 10,30,i\n\t\ty = lerp 10,30,j\n\t\trect x,y,10,10'] # Home x
	[2,2,8,ENG, 'for i in range 10\n\tfor j in range 10\n\t\tx = lerp 10,30,i\n\t\ty = lerp 10,30,j\n\t\trect x,y,10,10z'] # ctrlEnd z
	[2,2,8,ENG, 'for i in range 10\n\tfor j in range 10\n\t\tx = lerp 10,30,iz\n\t\ty = lerp 10,30,j\n\t\trect x,y,10,10'] # End z
	[2,2,8,ENG, ''] # ctrlA Del
	[2,2,8,ENG, 'for i in range 10\nfor j in range 10\n\tx = lerp 10,30,i\n\ty = lerp 10,30,j\n\trect x,y,10,10'] # ctrlA shiftTab
	[2,2,8,ENG, '\tfor i in range 10\n\t\tfor j in range 10\n\t\t\tx = lerp 10,30,i\n\t\t\ty = lerp 10,30,j\n\t\t\trect x,y,10,10'] # ctrlA Tab
	[1,2,8,ENG, 'for i in range 10\n\t\tx = lerp 10,30,i\n\tfor j in range 10\n\t\ty = lerp 10,30,j\n\t\trect x,y,10,10'] # ctrlShiftUp
	[1,2,8,ENG, 'for i in range 10\n\tfor j in range 10\n\t\ty = lerp 10,30,j\n\t\tx = lerp 10,30,i\n\t\trect x,y,10,10'] # ctrlShiftDown
	[3,2,8,ENG, 'for i in range 10\n\tfor j in range 10\n\t\tx = lerp 10,30,i\n\t\ty = lerp 10,30,jz\n\t\trect x,y,10,10'] # Down End z
	[3,2,8,ENG, 'for i in range 10z\n\tfor j in range 10\n\t\tx = lerp 10,30,i\n\t\ty = lerp 10,30,j\n\t\trect x,y,10,10'] # ctrlHome End z
	[3,2,8,ENG, 'for i in range 10\n\tfor j in range 10\nz\t\tx = lerp 10,30,i\n\t\ty = lerp 10,30,j\n\t\trect x,y,10,10'] # Home Home z
	[4,2,8,ENG, 'for i in range 10\n\tfor j in range 10x = lerp 10,30,i\n\t\ty = lerp 10,30,j\n\t\trect x,y,10,10'] # Home Backspace Backspace
	[4,2,8,ENG, 'for i in range 10\n\tfor j in range 10\n\t\tx = lerp 10,30,i\n\t\tx = lerp 10,30,i\n\t\ty = lerp 10,30,j\n\t\trect x,y,10,10'] # Home Home ctrlC ctrlV
	[2,2,8,ENG, 'for i in range 10\n\tfor j in range 10\n\t\tx = le\n\t\ty = lerp 10,30,j\n\t\trect x,y,10,10'] # shiftEnd Del
	[4,2,8,ENG, 'for i in range 10\n\tfor j in range 10\n\t\tx = rple 10,30,i\n\t\ty = lerp 10,30,j\n\t\trect x,y,10,10'] # ctrlShiftRight ctrlX Home paste
	[6,2,8,ENG, 'for i in range 10\n\tfor j in range 10\n\t\tx = lerplerplerp 10,30,i\n\t\ty = lerp 10,30,j\n\t\trect x,y,10,10'] # ctrlLeft ctrlShiftRight ctrlC ctrlV ctrlV ctrlV
	[7,2,8,ENG, 'for i in range 10\n\tfor j in range 10\n\t\tx = lerp 10,30,i\n\t\ty = lerp 10,30,j\n\t\tx = lerp 10,30,i\n\t\ty = lerp 10,30,j\n\t\trect x,y,10,10'] # Home Home shiftDown shiftDown ctrlC Down ctrlV
] 

iProblem = 0

target = null # bör. Readonly
editor = null # är. Påverkas av tangenttryckningar enbart

class Button
	constructor : (@txt, @x,@y,@size,@f=null,@r=1,@g=1,@b=1) ->
	draw : ->
		textAlign CENTER,CENTER
		fc @r,@g,@b
		circle @x,@y,@size
		fc 0
		text @txt, @x,@y
	execute : -> if @f and @size > dist mouseX,mouseY, @x,@y then @f()
	setColor : (r,g,b) -> [@r,@g,@b] = [r,g,b]

buttons = []
buttons.push new Button 'Prev', 30,30,20,() -> nextProblem -1
buttons.push new Button 'Next', 170,30,20,() -> nextProblem +1
buttons.push new Button 'xxx', 100,100,20
buttons.push new Button 'yyy',  100,30,20
buttons.push new Button 'Undo', 100,150,20,() -> nextProblem 0

mouseReleased = ->
	for button in buttons
		button.execute()
	editor.focus()

update = -> 
	bg 0.5
	diff = nCommands - counter
	buttons[2].txt = diff
	if diff > 0
		buttons[2].setColor 1,1,0
	else if diff == 0 and target.getValue()==editor.getValue() 
		buttons[2].setColor 0,1,0
	else
		buttons[2].setColor 1,0,0

	buttons[3].txt = iProblem
	for button in buttons
		button.draw()

cursor_activity = (doc) -> 
	counter++ 
	update()
key_handled = (obj,name,event) -> #update()
my_cut = -> counter--
my_copy = (obj) -> 
	counter++ 
	update()

block_event = (obj,event) -> 
	editor.focus()
	event.preventDefault()

setup = ->
	c = createCanvas 200,200
	c.parent 'canvas'
	bg 0

	defaultValues =
		lineNumbers: true
		mode: "coffeescript"	
		keyMap: "sublime"
		theme: "dracula"
		autoCloseBrackets: true
		lineWiseCopyCut: true
		tabSize: 2
		indentWithTabs: true
		matchBrackets : true

	target = CodeMirror.fromTextArea document.getElementById("target"), defaultValues
	target.on "mousedown", block_event
	target.on "touchENG", block_event

	editor = CodeMirror.fromTextArea document.getElementById("editor"), defaultValues

	#editor.on "keyHandled", key_handled
	editor.on "cursorActivity", cursor_activity
	editor.on "cut", my_cut
	editor.on "copy", my_copy

	editor.on "mousedown", block_event
	editor.on "touchENG", block_event

	editor.focus()
	cursor = editor.getCursor()
	nextProblem 0

nextProblem = (d) ->
	iProblem += d
	iProblem = constrain iProblem,0,PROBLEMS.length-1
	[nCommands,line,ch,start,slut] = PROBLEMS[iProblem]

	target.setValue slut
	target.setCursor line,ch

	editor.setValue start
	editor.setCursor line,ch

	divDbg.innerHTML = ""
	counter = 0

	update()

	editor.focus()

dbg = (msg) -> divDbg.innerHTML += msg + '<br>'
