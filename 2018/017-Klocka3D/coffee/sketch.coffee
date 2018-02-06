rotation = 0 # grader. Ett varv på 12 sekunder.

setup = -> createCanvas 600,600,WEBGL

pushPop = (f) ->
	push()
	f()
	pop()

urtavla = ->
	torus 250,12,48,32
	for i in range 12
		pushPop ->
			translate 0,240
			box 20,30,20 
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
	visare second(),             60, 40, 240, 15, 6
	visare minute(),             60, 40, 220, 30, 0
	visare hour()+minute()/60.0, 12, 30, 160, 30,-6