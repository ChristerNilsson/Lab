setup = ->
	createCanvas 1000,1000

koch = (q1,q5) ->
	if q1.dist(q5) < 20
		line q1.x,q1.y,q5.x,q5.y
	else
		q2 = p5.Vector.lerp q1,q5,1/3
		q4 = p5.Vector.lerp q1,q5,2/3
		v = p5.Vector.sub q5,q1
		v.div 3
		v.rotate -PI/3
		q3 = p5.Vector.add q2,v

		koch q1,q2
		koch q2,q3
		koch q3,q4
		koch q4,q5

draw = ->
	bg 0.5
	scale 0.8
	translate 150,50
	q1 = createVector 0,height*sqrt(3)/2
	q2 = createVector width/2,0
	q3 = createVector width,height*sqrt(3)/2
	koch q1,q2
	koch q2,q3
	koch q3,q1
