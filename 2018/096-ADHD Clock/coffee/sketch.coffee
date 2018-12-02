# Använd _.range istf range
# Före setup, draw och mousePressed måste 'window.' användas

class Button
  constructor : (@title,@x,@y,@r, @radie=20) ->
  inside : (x,y) -> @radie > dist @x,@y,x,y
  draw : -> 
    fc 0.5
    if @title == ""  
      circle @x,@y,@radie
    fc 0
    text @title,@x,@y
    
buttons = []
startTid = null
minute = 0
h = null
snd = null

preload = -> snd = new Audio "https://www.soundjay.com/button/beep-01a.wav"

setup = ->
  h = windowHeight
  createCanvas windowWidth,windowHeight
# scale 0.25
  print 'Hello p5.js and Coffeescript!'
  angleMode DEGREES
  sc()
  
  for i in _.range 60 # minut
    vinkel = 360/60*i-90
    x = 0.48*h * cos vinkel
    y = 0.48*h * sin vinkel
    if  vinkel % 30 == 0 then radie = 0.012*h else radie = 0.01*h
    buttons.push new Button "", x,y, 1,radie

  for i in _.range 12 # timme
    vinkel = 360/12*i-90
    x = 0.4*h * cos vinkel
    y = 0.4*h * sin vinkel
    buttons.push new Button (60-5*i) % 60, x,y, 1, 0.07*h

draw = ->
  textAlign CENTER,CENTER
  textSize 0.1*h
  bg 1
  translate width/2, height/2
  for button in buttons
    button.draw()
  
  tid = new Date()
  t = minute-(tid-startTid)/-60000
  if t > 60 
    snd.play()
    t = 0
  start = 6*t-90
  stopp = 360-90 
  fc 1,0,0
  arc 0, 0, 0.65*h, 0.65*h, start, stopp
  fc 0
  textSize 20

mouseDragged = ->
  minute = map mouseY, 0,height, 0,60
  startTid = new Date()
      
