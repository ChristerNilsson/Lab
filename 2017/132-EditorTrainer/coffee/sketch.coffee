counter = 0
nCommands = 0
# Visa startläge och slutläge
# Räkna antalet operationer
# Avgör om succe eller ej
ENG = 'Alpha\n\tBravo\n\tCharlie\n\tDelta\n\tEcho' 
SWE = 'Adam\n\tBertil\n\tCesar\n\tDavid\n\tErik'

PROBLEMS = [ # operations,line,ch,startläge,slutläge
	[1,2,4,ENG, 'Alpha\n\tBravo\n\tChaxrlie\n\tDelta\n\tEcho'] # x
	[1,2,4,ENG, 'Alpha\n\tBravo\n\tChrlie\n\tDelta\n\tEcho'] # Backspace
	[1,2,4,ENG, 'Alpha\n\tBravo\n\tChalie\n\tDelta\n\tEcho'] # Del
	[1,2,4,ENG, 'Alpha\n\tBravo\n\tDelta\n\tEcho'] # CtrlX
	[2,2,4,ENG, 'Alpha\n\tBravo\nCharlie\n\tDelta\n\tEcho'] # Home Backspace
	[2,2,4,ENG, 'Alpha\n\tBravo\n\t\tCharlie\n\tDelta\n\tEcho'] # Home Tab
	[2,2,4,ENG, 'xAlpha\n\tBravo\n\tCharlie\n\tDelta\n\tEcho'] # ctrlHome x
	[2,2,4,SWE, 'Adam\n\tBertil\n\tCes\n\tDavid\n\tErik'] # Del Del
	[2,2,4,ENG, 'Alpha\n\tBravo\n\txCharlie\n\tDelta\n\tEcho'] # Home x
	[2,2,4,ENG, 'Alpha\n\tBravo\n\tCharlie\n\tDelta\n\tEchox'] # ctrlEnd x
	[2,2,4,ENG, 'Alpha\n\tBravo\n\tCharliex\n\tDelta\n\tEcho'] # End x
	[2,2,4,SWE, ''] # ctrlA Del
	[2,2,4,ENG, 'Alpha\nBravo\n\Charlie\nDelta\nEcho'] # ctrlA shiftTab
	[2,2,4,ENG, '\tAlpha\n\t\tBravo\n\t\tCharlie\n\t\tDelta\n\t\tEcho'] # ctrlA Tab
	[1,2,4,SWE, 'Adam\n\tCesar\n\tBertil\n\tDavid\n\tErik'] # ctrlShiftUp
	[3,2,4,ENG, 'Alpha\n\tBravo\n\tCharlie\n\tDeltax\n\tEcho'] # Down ctrlRight x
	[3,2,4,ENG, 'Alphax\n\tBravo\n\tCharlie\n\tDelta\n\tEcho'] # ctrlHome End x
	[3,2,4,ENG, 'Alpha\n\tBravo\nx\tCharlie\n\tDelta\n\tEcho'] # Home Home x
	[3,2,4,ENG, 'Alpha\n\tBravoCharlie\n\tDelta\n\tEcho'] # Home Backspace Backspace
	[4,2,4,ENG, 'Alpha\n\tBravo\n\tCharlie\n\tCharlie\n\tDelta\n\tEcho'] # Home Home ctrlC ctrlV
	[4,2,4,ENG, 'Alpha\n\tBravo\n\tChar\n\tDelta\n\tEcho'] # Right Del Del Del
	[4,2,4,ENG, 'Alpha\n\tBravo\n\trlieCha\n\tDelta\n\tEcho'] # ctrlShiftRight ctrlX Home paste
	[4,2,4,ENG, 'Alpha\n\tBravo\n\tChrlaie\n\tDelta\n\tEcho'] # Backspace Right Right a
	[5,2,4,ENG, 'Alpha\n\tBravo\n\tCharlieCharlie\n\tDelta\n\tEcho'] # Home ctrlShiftRight ctrlC Right ctrlV
	[8,2,4,ENG, 'Alpha\n\tBravo\n\tCharlie\n\tBravo\n\tCharlie\n\tDelta\n\tEcho'] # Up Home Home shiftDown shiftDown ctrlC Down ctrlV
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
