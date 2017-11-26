counter = 0
nCommands = 0
# Visa startläge och slutläge
# Räkna antalet operationer
# Avgör om succe eller ej

A = 'for i in range 10\n'
B = '\tfor j in range 10\n'
C = '\t\tx = lerp 10,30,i\n'
D = '\t\ty = lerp 10,30,j\n'
E = '\t\trect x,y,10,10\n'
ABCDE = A+B+C+D+E

iProblem = 0
buffer = ''
target = null # bör. Readonly
editor = null # är. Påverkas av tangenttryckningar enbart

PROBLEMS = [ # operations,line,ch,startläge,slutläge
	[1,2,8,ABCDE, "#{A}#{B}\t\tx = lezrp 10,30,i\n#{D}#{E}"] # z
	[1,2,8,ABCDE, "#{A}#{B}\t\tx = lrp 10,30,i\n#{D}#{E}"] # Backspace
	[1,2,8,ABCDE, "#{A}#{B}\t\tx = lep 10,30,i\n#{D}#{E}"] # Del
	[1,2,8,ABCDE, "#{A}#{B}#{D}#{E}"] # CtrlX
	[1,2,8,ABCDE, "#{A}#{B}#{C}#{C}#{D}#{E}"] # ctrl-shift-D
	[1,2,8,ABCDE, "#{A}#{B}#{C}\t\t\n#{D}#{E}"] # ctrl-Enter
	[1,2,8,ABCDE, "#{A}#{B}\t\t\n#{C}#{D}#{E}"] # ctrl-shift-Enter
	[1,2,8,ABCDE, "#{A}#{C}#{B}#{D}#{E}"] # ctrl-shift-Up
	[1,2,8,ABCDE, "#{A}#{B}#{D}#{C}#{E}"] # ctrl-shift-Down
	[1,2,8,ABCDE, "#{A}#{B}\t\tx = le\n#{D}#{E}"] # ctrl-KK
	[1,2,8,ABCDE, "#{A}#{B}\tx = lerp 10,30,i\n#{D}#{E}"] # shift-Tab
	[2,2,8,ABCDE, "#{A}#{B}\t#{C}#{D}#{E}"] # Home Tab
	[2,2,8,ABCDE, "z#{A}#{B}#{C}#{D}#{E}"] # ctrlHome z
	[2,2,8,ABCDE, "#{A}#{B}\t\tx = le 10,30,i\n#{D}#{E}"] # Del Del
	[2,2,8,ABCDE, "#{A}#{B}#{C}#{D}#{E}z"] # ctrlEnd z
	[2,2,8,ABCDE, "#{A}#{B}\t\tx = lerp 10,30,iz\n#{D}#{E}"] # End z
	[2,2,8,ABCDE, ""] # ctrlA Del
	[2,2,8,ABCDE, 'for i in range 10\nfor j in range 10\n\tx = lerp 10,30,i\n\ty = lerp 10,30,j\n\trect x,y,10,10\n'] # ctrlA shiftTab
	[2,2,8,ABCDE, "\t#{A}\t#{B}\t#{C}\t#{D}\t#{E}"] # ctrlA Tab
	[2,2,8,ABCDE, "#{A}#{B}\t\tx =  10,30,i\n#{D}#{E}"] # ctrl-D Del
	[3,2,8,ABCDE, "#{A}#{B}#{C}\t\ty = lerp 10,30,jz\n#{E}"] # Down End z
	[3,2,8,ABCDE, "for i in range 10z\n#{B}#{C}#{D}#{E}"] # ctrlHome End z
	[3,2,8,ABCDE, "#{A}#{B}z#{C}#{D}#{E}"] # Home Home z
	[4,2,8,ABCDE, "#{A}#{B}\t\tx = rple 10,30,i\n#{D}#{E}"] # ctrlShiftRight ctrlX Home paste
	[5,2,8,ABCDE, "#{A}#{B}\t\tx = lerplerplerp 10,30,i\n#{D}#{E}"] # ctrlD ctrlC ctrlV ctrlV ctrlV
	[5,2,8,ABCDE, 'for i in range 10 for j in range 10 x = lerp 10,30,i y = lerp 10,30,j rect x,y,10,10\n'] # ctrl-Home ctrl-J ctrl-J ctrl-J ctrl-J
	[5,2,8,ABCDE, "#{A}#{B}#{C}#{D}#{C}#{D}#{E}"] # ctrl-L ctrl-L ctrl-C ctrl-V ctrl-V
	[12,2,8,ABCDE, "#{A}\tx = lerp 10,30,i\n\trect x,0,10,10\n"] 
	[15,2,8, "# #{A}# #{B}# #{C}# #{D}# #{E}",ABCDE] 
	[19,2,8,ABCDE, "# #{A}# #{B}# #{C}# #{D}# #{E}"] 
	[23,2,8,ABCDE, "#{A}#{B}\t\trect 10+20*i,10+20*j,10,10\n"] 
	[21,0,0,'', "oxoxoxox\nxoxoxoxo\noxoxoxox\nxoxoxoxo\noxoxoxox\nxoxoxoxo\noxoxoxox\nxoxoxoxo"] 
] 

update = -> 
	diff = nCommands - counter
	operations.innerHTML = diff
	problem.innerHTML = iProblem
	problem.style.color = 'white'
	operations.style.color = if target.getValue()==editor.getValue() then 'green' else 'red'

# buffer används pga svårt att hantera komplexiteten
# t ex ger ctrlX både FA och AFA
dump = (ch) ->
	buffer += ch
	if buffer.length > 3 or buffer in 'AA FA AFA BA D'.split ' '
		buffer=''
		counter++
	update()

cursor_activity = -> dump 'A'
key_handled     = -> dump 'B'
my_copy         = -> dump 'D'
input_read      = -> dump 'F'

block_event = (obj,event) -> 
	editor.focus()
	event.preventDefault()

setup = ->

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
	target.on "touchstart", block_event

	editor = CodeMirror.fromTextArea document.getElementById("editor"), defaultValues
	editor.on "mousedown", block_event
	editor.on "touchstart", block_event
	editor.on "inputRead", input_read
	editor.on "keyHandled", key_handled
	editor.on "cursorActivity", cursor_activity
	editor.on "copy", my_copy

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

	counter = 0
	buffer = ''

	update()

	editor.focus()
