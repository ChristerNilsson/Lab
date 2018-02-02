vinkel = 0 # grader. Ett varv på 12 sekunder.

setup = -> createCanvas 600,600,WEBGL

urtavla = ->
	torus 250,10,48,32
	for i in range 60
		push()
		if i % 5 == 0 then translate 0,250-20 else translate 0,250-10
		if i % 5 == 0 then cylinder 5, 20, 30 else cylinder 3, 10, 30
		pop()
		rotateZ radians 6

visare = (tid,antal,längd,tjocklek,z) ->
	push()
	rotateZ radians map tid,0,antal,0,360
	translate 0,längd*0.5,z
	box tjocklek,längd,4
	pop() 

draw = -> 
	normalMaterial()
	bg 0
	rotateY radians vinkel
	vinkel -= 0.5
	urtavla()
	rotateX radians 180
	visare second(),              60,210,10,10
	visare minute()+second()/60.0,60,190,20,0
	visare hour()+minute()/60.0,  12,150,20,-10