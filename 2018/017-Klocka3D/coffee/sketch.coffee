vinkel = 0

setup = -> 
  createCanvas 800,800,WEBGL
  normalMaterial()

urtavla = ->
  torus 300,10,48,32
  for i in range 60
    push()
    if i % 5 == 0
      translate 0,280
      cylinder 5, 20, 30
    else
      translate 0,290
      cylinder 3, 10, 30
    pop()
    rotateZ PI/30

visare = (tid,antal,längd,tjocklek,z) ->
  push()
  rotateZ map tid,0,antal,0,TWO_PI
  translate 0,längd*0.8,z
  box tjocklek,längd,2
  pop() 

draw = -> 
  bg 0
  rotateY vinkel
  vinkel += 0.008
  urtavla()
  rotateX PI
  visare second(),              60,200, 5,-10
  visare minute()+second()/60.0,60,200,10,0
  visare hour()+minute()/60.0,  12,160,10,10