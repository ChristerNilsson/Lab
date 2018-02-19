rotation = 0 # grader. Ett varv på 12 sekunder.
r = null

setup = -> 
	createCanvas windowWidth,windowHeight,WEBGL
	r = 0.01 * 0.5 * min width,height

pushPop = (f) ->
	push()
	f()
	pop()

urtavla = ->
	torus 70*r, 3*r,48,32
	for i in range 12
		pushPop ->
			translate 0,64*r
			box 6*r,9*r,6*r 
		rotateZ radians 30

visare = (tid,antal,motvikt,längd,bredd,z) ->
	pushPop ->
		rotateZ radians map tid,0,antal,180,540
		translate 0, 0.5*längd - motvikt, z
		box bredd, längd + motvikt, 4

draw = -> 
	normalMaterial()
	bg 0
	rotateY radians rotation
	rotation -= 0.5 # 360/(60*12)
	urtavla()
	visare second(),             60, 8*r, 60*r, 3*r, r
	visare minute(),             60, 8*r, 60*r, 6*r, 0
	visare hour()+minute()/60.0, 12, 6*r, 48*r, 6*r,-r