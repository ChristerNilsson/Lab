// Ritar en quadcopter.
// - Box i centrum
// - Boxar som armar
// - cylindrar som propellrar
// - Framecount får propellrarna att snurra
// - Texture

function setup() { // 0
  createCanvas(1000,1000,WEBGL) // 1
  background(128) // 2
  img = loadImage("xbox360gamepad.jpg"); // 15
}

function draw() { // 0
  scale(1) // 18
  fill(255)
  rotateX(mouseY*0.01) // 13
  rotateZ(mouseX*0.01) // 14
  //texture(img) // 16
  box(40,100,10) // 3
  rotateZ(QUARTER_PI) // 17
  for (var i=0; i<4; i++) {  // 12
    rotateZ(HALF_PI) // 11
    push() // 9
    translate(0,100) // 5
    box(30,120,5) // 4
    translate(0,100,-30) // 7
    rotateZ([-1,1,-1,1][i] * frameCount*0.3) // 8
    cylinder(5,100) // 6
    pop() // 10
  }
}

