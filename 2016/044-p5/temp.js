function setup(){
  createCanvas(1000,1000)
  background(0)
  klockor = []
  klockor.push([100,100,100])
  klockor.push([200,70,90])
  klockor.push([1000,900,70])
  klockor.push([1000,1000,1000])
  klockor.push([795,340,420])
}

function rita(klocka) {
  x=klocka[0]
  y=klocka[1]
  storlek=klocka[2]
  noFill()
  stroke('green')
  ellipse(x,y,storlek,storlek)
}

function draw() {
  for (klocka of klockor) {
    rita(klocka)
  }
}