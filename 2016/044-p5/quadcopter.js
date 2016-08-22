function setup() { 
  createCanvas(1000,1000,WEBGL) 
  background(128) 
  img = loadImage("xbox360gamepad.jpg")
  //setupBee()
}

function draw() { 
  scale(1) 
  fill(255)
  pitch(mouseX*0.2)
  roll(mouseY*0.2)
  //origin()
  texture(img) 
  box(100,40,10)
  yaw(45) 
  for (var i=0; i<4; i++) {  
    yaw(90) 
    push() 
    box(200,30,5) 
    fwd(190)
    pitch(90)
    fwd(20)
    pitch(-90)
    yaw([-1,1][i%2] * frameCount*10) 
    cylinder(5,100) 
    pop() 
  }
}