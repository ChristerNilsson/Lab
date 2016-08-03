var colSlider
var sliders = []
var buttons = [[]]
var mode = 1
var pits = []  // bara Pits 
var selected = -1
var mymouseX = 0 
var mymouseY = 0
var hand = []
var hist = []    // list of pit indexes
var turn = 0     // 0 = Human, 1 = Computer
var legals = []  // list of possible moves

function Pit(x,y,stones,radius) {
  this.x = x
  this.y = y
  this.radius = radius
  this.stones = stones  // list of colors
  this.neighbours = []
  this.colors = []
  this.owner = function() {
    if (this.radius == 50) {
      return (this.y < 3*height/5) + 2*(this.y > 2*height/5)
    } else {
      return (this.x < 200+(width-200)/2) + 2*(this.x > 200+(width-200)/2)
    }
  }
  this.accumulator = function() {
    return this.radius != 50
  }
}

function pit() { // [mode, x, y, [color1, color2], radius]
  mode = 1
}
function conn() {
  mode = 2
}
function steal() {
  mode = 3
}
function acc() {
  mode = 4
}
function del() {
  mode = 5
}
function sel() {
  mode = 6
}
function play() {
  mode = 7
  hand[0] = 0
}

function undo() {
  if (hist.length > 2) {
    var a = hist.pop()
//    var b = hist[hist.length - 1]
    pits[a].stones[0]--
    hand[0]++
    // color code
  } else if (hist.length == 2) {
    a = hist.pop()
//    b = hist[0]
    pits[a].stones[0]--
    hand[0]++
    a = hist.pop()
    pits[a].stones = hand
    hand = [0]
  } else if (hist.length == 1) {
    a = hist.pop()
    pits[a].stones = hand
    hand = [0]
  }
}

function pickUp() {
  var pit = pits[selected]
  if (pit == null)
    return
  hand = pit.stones
  pit.stones = [0]
  //console.log("pickUp")
  //console.log(hist)
  hist.push(selected)
  //console.log(hand)
}

function lay() {
  //console.log("lay")
  //console.log(hand)
  if (hand[0] > 0) {
    pits[selected].stones[0]++
    hand[0]--
    hist.push(selected)
    if (hand[0] == 0)
      hist = []
  }
}

function legalMove(from,to) {
  var pit = pits[from]
  if (pit == null) return false
  if (hand[0] == 0 && pit.accumulator() == false) {
    return (pit.owner() & (1 << turn) != 0) && (pit.stones[0] > 0)
  } else {
    return pit.neighbours.indexOf(to) != -1
  }
}

function legalMoves() {
  res = []
  for (var i=0; i<pits.length; i++) {
    if (legalMove(i,i)) res.push(i)
    //var pit = pits[i]
    //if (pit == null) continue
    //if ((pit.owner() & (1 << turn) != 0) && (pit.stones[0] > 0)) {
//      res.push(i)
    //}
  }
  return res
}          

function makeButton(x,y,text,method) {
  var button = createButton(text)
  button.position(x, y)
  button.mousePressed(method)
  return button
}

function makeSlider(x,y,mini,maxi,val) {
  var slider = createSlider(mini, maxi, val)
  slider.position(x, y)
  return slider
}

function setup() {
  createCanvas(1000, 1000)
  background(128)
  textSize(15)

  // sliders
  x = 20
  
  buttons.push(makeButton(x,20,'Pit',pit))
  buttons.push(makeButton(x,50,'Conn',conn))
  buttons.push(makeButton(x,80,'Steal',steal))
//  buttons.push(makeButton(x,290,'Acc',acc))
  buttons.push(makeButton(x,110,'Del',del))
  buttons.push(makeButton(x,140,'Sel',sel))
  buttons.push(makeButton(x,170,'Play',play))
  buttons.push(makeButton(x,200,'Undo',undo))
  
  colSlider = makeSlider(x,230,1,6,1)
  sliders = []

  for (var i = 0; i<6; i++) {
    sliders.push(makeSlider(x,260+i*30,0,10,4))
  }

  colSlider.input(changeSliders)
  changeSliders()
  
  pits.push(new Pit(240,height/2,[0],60))
  pits.push(new Pit(width-40,height/2,[0],60))
}

function changeSliders() { // hide/show
//  console.log(colSlider)
  for (var i = 0; i<6; i++) {
    slider = sliders[i]
    slider.position(i<colSlider.value() ? 20 : -1000, slider.y)
  }
}

function dist(x1,y1,x2,y2) {
  dx = x1-x2
  dy = y1-y2
  return Math.sqrt(dx*dx+dy*dy)
}

function inRect(x,y,rx,ry,rw,rh) {
  return (x > rx && x < rx+rw) && (y > ry && y < ry+rh)
}

function find(x,y) {
  for (var i=0; i<pits.length; i++) {
    pit = pits[i]
    if (pit) {
      if (dist(pit.x,pit.y,x,y) < pit.radius/2) return i
    }
  }
  return -1
}

function delPit() {
  pit = pits[selected]
  if (pit.radius == 50) {
    pits[selected] = null
    selected = -1
  }
}

function mousePressed() {
  mymouseX = winMouseX
  mymouseY = winMouseY

  if (mouseX<200) return
  if (mode == 1) { // Create Pit
//    console.log("mousePressed")
    pits.push(new Pit(mouseX,mouseY,[sliders[0].value()],50))
//    console.log(pits)    
  } else if (mode == 22) {
    selected2 = find(mouseX,mouseY)
    if (selected2 != -1) pits[selected].neighbours.push(selected2)
    mode = 2
  } else if (mode == 2) {
    selected = find(mouseX,mouseY)
    if (selected != -1) mode = 22
  } else if (mode == 4) { // Create Accumulator
    pits.push(new Pit(mouseX,mouseY,[0],60))
  } else if (mode == 5) {  // Delete
    selected = find(mouseX,mouseY)
    if (selected != -1) delPit(selected)
  } else if (mode == 6) {
    selected = find(mouseX,mouseY)
  } else if (mode == 7) {
    selected = find(mouseX,mouseY)
    if (hand[0] == 0)
      pickUp()
    else
      lay()
  }
}

function drawpit(n) {
  if (n==selected) {
    stroke(255)
  } else {
    stroke(0)
  }
  pit = pits[n]
  if (legals.indexOf(n) != -1) {
    noFill()
    ellipse(pit.x,pit.y,pit.radius + 5,pit.radius+5)
  }
  fill(0)
  ellipse(pit.x,pit.y,pit.radius,pit.radius)
  noStroke(); fill(255,0,0); textAlign(CENTER,CENTER); text(pit.stones[0], pit.x, pit.y)
}

function drawdirection(n) {
  if (n==selected) {
    stroke(255)
  } else {
    stroke(0)
  }
  pit = pits[n]
  for (var i=0; i<pit.neighbours.length; i++) {
    var nb = pit.neighbours[i]
    p1 = pit //lst[item[1]]
    p2 = pits[nb]
    if (p2) {
      d = dist (p1.x,p1.y,p2.x,p2.y)
      x = map(25,0,d,p1.x,p2.x)
      y = map(25,0,d,p1.y,p2.y)
      stroke(0)
      ellipse(x,y,10,10)
    }
  }
}

function drawconnection(n) {
  if (n==selected) {
    stroke(255)
  } else {
    stroke(0)
  }
  //console.log(pits)
  pit = pits[n]
  for (var i=0; i<pit.neighbours.length; i++) {
    var nb = pit.neighbours[i]
    p1 = pit //lst[item[1]]
    p2 = pits[nb]
    if (p2) {
      stroke (255)
      line(p1.x,p1.y,p2.x,p2.y)
    }
  }
}

function drawHand() {
  noStroke(); fill(255,255,0); textAlign(CENTER,CENTER); text(hand, 20, 700)
}

function draw() {
  background(128)
  fill(40,120,40)
  noStroke()
  
  rect(200,2*height/5,width,height/5)
  
  stroke(0)
  fill(0)
  ellipse(10,0+30*mode,10,10)
  
  legals = legalMoves()
  //console.log(legals)

  for (var i=0; i<pits.length; i++) if (pits[i]!= null) drawconnection(i)
  for (var i=0; i<pits.length; i++) if (pits[i]!= null) drawdirection(i)
  for (var i=0; i<pits.length; i++) if (pits[i]!= null) drawpit(i)
  drawHand()
}

function mouseDragged(event) {
  // selected anger pit
  if (mode==6 && selected>=0) {
    var dx = winMouseX - mymouseX 
    var dy = winMouseY - mymouseY
    mymouseX = winMouseX
    mymouseY = winMouseY
    pit = pits[selected]
    pit.x += dx
    pit.y += dy
  }
}
