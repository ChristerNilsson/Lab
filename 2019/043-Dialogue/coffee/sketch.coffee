w = null
h = null

released = true 

print = console.log
range = _.range

targets = []
targets.push [0,'Brotorp','X',46]
targets.push [1,'Skarpnäck','A',123]
targets.push [2,'Golfklubben','R',1234]
targets.push [3,'Adam','R',47]
targets.push [4,'Bertil','',124]
targets.push [5,'Cesar','',1235]
targets.push [6,'David','Q',48]
targets.push [7,'Erik','Z',125]
targets.push [8,'Filip','T',1236]
targets.push [9,'Gustav','T',1250]
targets.push [10,'Helge','R',1260]
targets.push [11,'Ivar','R',1600]

currentTarget = 0

Array.prototype.clear = -> @length = 0
assert = (a, b, msg='Assert failure') -> chai.assert.deepEqual a, b, msg

setup = ->
	canvas = createCanvas innerWidth-0.5, innerHeight-0.5
	canvas.position 0,0 # hides text field used for clipboard copy.

	w = width/8
	h = height/4 
	angleMode DEGREES

	display()

menu1 = -> # Main Menu
	dialogue = new Dialogue 1,int(4*w),int(2*h),int(0.15*h) 

	r1 = 0.25 * height
	r2 = 0.11 * height
	dialogue.clock ' ',4,r1,r2,true,90+360/4

	dialogue.buttons[0].info 'Take', true, -> menu4()
	dialogue.buttons[1].info 'Target', true, -> menu3()
	dialogue.buttons[2].info 'PanZoom', true, -> menu2()
	dialogue.buttons[3].info 'Center', true, -> dialogues.clear()		

menu2 = -> # Pan Zoom
	dialogue = new Dialogue 2,int(4*w),int(2*h),int(0.15*h) 

	r1 = 0.25 * height 
	r2 = 0.09 * height
	dialogue.clock ' ',8,r1,r2,false,45+360/8

	dialogue.buttons[0].info 'Up', true, -> 
	dialogue.buttons[1].info 'Restore', true, -> dialogues.clear()
	dialogue.buttons[2].info 'Right', true, ->
	dialogue.buttons[3].info 'Out', true, ->
	dialogue.buttons[4].info 'Down', true, -> 
	dialogue.buttons[5].info 'In', true, ->
	dialogue.buttons[6].info 'Left', true, ->
	dialogue.buttons[7].info 'Save', true, -> dialogues.clear()

menu3 = -> # Target
	dialogue = new Dialogue 3, 0,0, int(0.15*h)
	lst = targets.slice()
	lst = lst.sort (a,b) -> a[3] - b[3]
	dialogue.list lst, 8, false, (arr) ->
		if arr.length == 0 then return
		print arr
		currentTarget = arr[0]
		dialogues.clear()		

menu4 = -> # Take
	dialogue = new Dialogue 4,int(4*w),int(2*h),int(0.15*h) 

	r1 = 0.25 * height 
	r2 = 0.11 * height
	dialogue.clock ' ',5,r1,r2,false,55+360/5

	dialogue.buttons[0].info 'ABCDE', true, -> menu5()
	dialogue.buttons[1].info 'FGHIJ', true, -> menu6()
	dialogue.buttons[2].info 'KLMNO', true, -> menu7()
	dialogue.buttons[3].info 'PQRST', true, -> menu8()
	dialogue.buttons[4].info 'UVWXYZ', true, -> menu9()

update = (littera,index=2) ->
	targets[currentTarget][index] = littera
	dialogues.clear()

menu5 = -> # ABCDE
	dialogue = new Dialogue 5,int(4*w),int(2*h),int(0.15*h) 

	r1 = 0.25 * height 
	r2 = 0.11 * height
	dialogue.clock ' ',5,r1,r2,false,55+360/5

	dialogue.buttons[0].info 'A', true, -> update 'A'
	dialogue.buttons[1].info 'B', true, -> update 'B'
	dialogue.buttons[2].info 'C', true, -> update 'C'
	dialogue.buttons[3].info 'D', true, -> update 'D'
	dialogue.buttons[4].info 'E', true, -> update 'E'

menu6 = -> # FGHIJ
	dialogue = new Dialogue 6,int(4*w),int(2*h),int(0.15*h) 

	r1 = 0.25 * height 
	r2 = 0.11 * height
	dialogue.clock ' ',5,r1,r2,false,55+360/5

	dialogue.buttons[0].info 'F', true, -> update 'F'
	dialogue.buttons[1].info 'G', true, -> update 'G'
	dialogue.buttons[2].info 'H', true, -> update 'H'
	dialogue.buttons[3].info 'I', true, -> update 'I'
	dialogue.buttons[4].info 'J', true, -> update 'J'

menu7 = -> # KLMNO
	dialogue = new Dialogue 7,int(4*w),int(2*h),int(0.15*h) 

	r1 = 0.25 * height 
	r2 = 0.11 * height
	dialogue.clock ' ',5,r1,r2,false,55+360/5

	dialogue.buttons[0].info 'K', true, -> update 'K'
	dialogue.buttons[1].info 'L', true, -> update 'L'
	dialogue.buttons[2].info 'M', true, -> update 'M'
	dialogue.buttons[3].info 'N', true, -> update 'N'
	dialogue.buttons[4].info 'O', true, -> update 'O'

menu8 = -> # PQRST
	dialogue = new Dialogue 8,int(4*w),int(2*h),int(0.15*h) 

	r1 = 0.25 * height
	r2 = 0.11 * height
	dialogue.clock ' ',5,r1,r2,false,55+360/5

	dialogue.buttons[0].info 'P', true, -> update 'P'
	dialogue.buttons[1].info 'Q', true, -> update 'Q'
	dialogue.buttons[2].info 'R', true, -> update 'R'
	dialogue.buttons[3].info 'S', true, -> update 'S'
	dialogue.buttons[4].info 'T', true, -> update 'T'

menu9 = -> # UVWXYZ
	dialogue = new Dialogue 9,int(4*w),int(2*h),int(0.15*h) 

	r1 = 0.25 * height 
	r2 = 0.11 * height
	dialogue.clock ' ',6,r1,r2,false,60+360/6

	dialogue.buttons[0].info 'U', true, -> update 'U'
	dialogue.buttons[1].info 'V', true, -> update 'V'
	dialogue.buttons[2].info 'W', true, -> update 'W'
	dialogue.buttons[3].info 'X', true, -> update 'X'
	dialogue.buttons[4].info 'Y', true, -> update 'Y'
	dialogue.buttons[5].info 'Z', true, -> update 'Z'

display = ->
	background 0,128,0
	text targets[currentTarget],100,100
	showDialogue()

showDialogue = -> if dialogues.length > 0 then (_.last dialogues).show()

mouseReleased = ->
	released = true
	false

mousePressed = -> 

	if not released then return false
	released = false 

	if dialogues.length == 1 and dialogues[0].number == 0 then dialogues.pop() # dölj indikatorer

	dialogue = _.last dialogues
	if dialogues.length == 0 or not dialogue.execute mouseX,mouseY 
		if dialogues.length == 0 then menu1() else dialogues.pop()
		display()
		return false
		#dialogues.clear()

	display()
	false 
