rects = []

add = (a,b,c,d) -> rects.push [a,b,c,d]

setup = ->
	createCanvas 1000,660

	add "Insert Line Before",'ctrl shift Enter',0,-2
	add "Swap Line Up",'ctrl shift Up',0,-1

	add "Move to Start of Line",'Home',-2,0
	add "Move Back One Word",'ctrl Left',-1,0
	add "",'',0,0
	add "Move Forward One Word",'ctrl Right',1,0
	add "Move to End of Line",'End',2,0

	add "Select to Start of Line",'shift Home',-2,1
	add "Select Previous Word",'ctrl shift Left',-1,1
	add "Select Word (rep)",'ctrl D',0,1
	add "Select Next Word",'ctrl shift Right',1,1
	add "Select to End of Line",'shift End',2,1

	add "Select Line (rep)",'ctrl L',0,2
	add "Select Scope (rep)",'ctrl shift Space',0,3
	add "Go to Code Bracket (rep)",'ctrl M',-0.5,4
	add "Select Code Bracket (rep)",'ctrl shift M',0.5,4
	add "Outdent Line",'ctrl [',-0.5,5
	add "Indent Line",'ctrl ]',0.5,5
	add "Comment Line",'ctrl /',-0.5,6
	add "Block Comment Line(s)",'ctrl shift /',0.5,6
	add "Duplicate Line",'ctrl shift D',0,7

	add "Delete to Start of Line",'ctrl K Backspace',-2,8
	add "Delete Left Character",'Backspace',-1,8
	add "Delete Line",'ctrl shift K',0,8
	add "Delete Right Character",'Delete',1,8
	add "Delete to End of Line",'ctrl K K',2,8

	add "Swap Line Down",'ctrl shift Down',0,9
	add "Insert Line After",'shift Enter',0,10

	rectMode CENTER
	textAlign CENTER,CENTER

	bg 1
	textSize 32
	fc 0
	text 'Sublime Text 3',200,50
	text 'Cheat Sheet',width-200,50
	text 'Windows',200,height-50
	text 'p5Dojo',width-200,height-50
	translate width/2,130

	H=50
	textSize 16
	sc()
	for [a,b,i,j] in rects
		sc 0,0,0
		fc()
		rect 200 * i, H*j,198,48,10
		sc()
		fc 0
		text a,200 * i, H*j-10
		fc 0,0,0
		text b,200 * i, H*j+10
