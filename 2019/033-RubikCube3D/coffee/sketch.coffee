COLORS = "#FFF #00F #FF0 #0F0 #FA5 #F00".split ' '
R = 60

#       U T S
#       V   Z                       Orange
#       W X Y 
# J Q P a h g j q p A H G 
# K   O b   f k   o B   F     Green White Blue Yellow
# L M N c d e l m n C D E    
#       y x w
#       z   v                       Red
#       s t u 

#           White    Blue     Yellow   Green    Orange   Red
ALPHABET = 'abcdefgh jklmnopq ABCDEFGH JKLMNOPQ STUVWXYZ stuvwxyz' 
SWAPS = 
	W: 'aceg bdfh wjWN xkXO ylYP' 
	B: 'lnpj moqk euAY fvBZ gwCS'
	Y: 'GECA HFDB nsJS otKT puLU'
	G: 'PNLJ QOMK EyaU FzbV GscW'
	R: 'suwy tvxz LClc MDmd NEne'  
	O: 'YWUS ZXVT ajGJ hqHQ gpAP'

cube = (i//9 for i in range 54)
backup = cube.slice()
rot = [50,50]
last = [0,0]

turn = (letters) -> 
	cube = backup.slice()
	for letter in letters
		LETTER = letter.toUpperCase() 
		if LETTER not of SWAPS then return 
		words = SWAPS[LETTER].split ' '
		for word in words
			[i,j,k,l] = (ALPHABET.indexOf w for w in word)
			[a,b,c,d] = if LETTER == letter then [l,i,j,k] else [j,k,l,i]
			[cube[a],cube[b],cube[c],cube[d]] = [cube[i],cube[j],cube[k],cube[l]]

setup = -> createCanvas 800,800, WEBGL

draw = ->
	rotateX -rot[1] * 0.01
	rotateY -rot[0] * 0.01
	background 0

	index = 0
	for side in range 6
		rotateX HALF_PI * [1,1,1,1,0,0][side]
		rotateZ HALF_PI * [0,0,0,0,1,2][side]
		for [i,j] in [[-1,-1],[0,-1],[1,-1],[1,0],[1,1],[0,1],[-1,1],[-1,0],[0,0]]
			push()
			translate 2*R*i, 2*R, 2*R*j

			beginShape()
			fill COLORS[cube[index]]
			vertex -R,R,-R
			vertex +R,R,-R
			vertex +R,R,+R
			vertex -R,R,+R
			endShape(CLOSE)

			pop()
			index += 1

change = (s) ->	turn s

mousePressed = -> last = [mouseX,mouseY]

mouseDragged = ->
	rot = [rot[0] + mouseX-last[0], rot[1] + mouseY-last[1]]
	last = [mouseX,mouseY]