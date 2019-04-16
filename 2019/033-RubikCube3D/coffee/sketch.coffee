COLORS = "#FFF #00F #FF0 #0F0 #FA5 #F00".split ' ' # W B Y G O R
ALPHABET = 'abcdefgh jklmnopq ABCDEFGH JKLMNOPQ STUVWXYZ stuvwxyz' 
SWAPS = 
	W: 'aceg bdfh wjWN xkXO ylYP' 
	B: 'lnpj moqk euAY fvBZ gwCS'
	Y: 'GECA HFDB nsJS otKT puLU'
	G: 'PNLJ QOMK EyaU FzbV GscW'
	O: 'YWUS ZXVT ajGJ hqHQ gpAP'
	R: 'suwy tvxz LClc MDmd NEne'  
R = 60

cube = null

change = (letters) -> 
	cube = (i//9 for i in range 54)
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
	change txt.value
	background 0
	orbitControl 4,4
	for side in range 6
		rotateX HALF_PI * [1,1,1,1,0,0][side]
		rotateZ HALF_PI * [0,0,0,0,1,2][side]
		for [i,j],k in [[-1,-1],[0,-1],[1,-1],[1,0],[1,1],[0,1],[-1,1],[-1,0],[0,0]]
			translate 2*R*i, 2*R, 2*R*j
			beginShape()
			fill COLORS[cube[9*side+k]]
			vertex x,R,z for [x,z] in [[-R,-R],[R,-R],[R,R],[-R,R]]				
			endShape()
			translate -2*R*i, -2*R, -2*R*j