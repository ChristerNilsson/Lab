var beeCount = 0
var beeShow = 0

// låda och cyl ritas i x-riktningen
// Med A och D kan man scrolla genom alla Bee-positions
// Kommandon:
//   fwd(x)
//   roll(vinkel)
//   pitch(vinkel)
//   yaw(vinkel)
//   låda(längd,bredd,tjocklek)
//   cyl(längd,size)
// Följande rad måste in i setup():
//   setupBee()
// Följande rad måste in i draw():
//   origin()

// Todo: Hur åstadkommer man noTexture ?

function setupBee() {
  img = loadImage("bee.png")
  pgx = loadImage("red.png")
  pgy = loadImage("green.png")
  pgz = loadImage("blue.png")
  //clr = loadImage("p5.png")
}

function origin() {
  beeCount=0

  push()
  texture(pgx)
  låda(width,1,1)
  //cyl(width,1)
  pop()

  push()
  rotateZ(radians(90)) // pitch(90)
  texture(pgy)
  låda(width,1,1)
  //cyl(width,1)
  pop()

  push()
  rotateY(radians(-90)) //yaw(-90)
  texture(pgz)
  låda(width,1,1)
  //cyl(width,1)
  pop()

  normalMaterial()
  //texture(clr)
}

function bee() {
  beeCount += 1
  if (beeCount != beeShow) return
  var size=width/40
  push()
  translate(size,0,0)
  rotateZ(HALF_PI)
  texture(pgx)
  cylinder(size,size)
  pop()

  push()
  translate(0,size,0)
  rotateY(HALF_PI)
  texture(pgy)
  cylinder(size,size)
  pop()

  push()
  translate(0,0,size)
  rotateX(HALF_PI)
  texture(pgz)
  cylinder(size,size)
  pop()

  push()
  texture(img)
  rotateZ(HALF_PI)
  sphere(2*size)
  pop()
}

function keyPressed() {
  if (key=='A') beeShow -= 1
  if (key=='D') beeShow += 1
  if (beeShow==beeCount) beeShow=0
  if (beeShow==-1) beeShow=beeCount-1
  console.log(beeShow)
}

function cyl(längd,size) {
  push()
  translate(längd,0,0) // fwd(längd)
  rotateY(radians(90)) // pitch(90)
  rotateX(radians(90)) // roll(90)
  cylinder(size,längd)
  pop()
}

function låda(längd,bredd,tjocklek) {
  push()
  translate(längd,0,0) // fwd(längd)
  box(längd,bredd,tjocklek)
  pop()
}

function fwd(x) {
  translate(x,0,0)
  bee()
}

function roll(vinkel) {
  rotateX(radians(vinkel))
  bee()
}

function pitch(vinkel) {
  rotateY(radians(vinkel))
  bee()
}

function yaw(vinkel) {
  rotateZ(radians(vinkel))
  bee()
}

