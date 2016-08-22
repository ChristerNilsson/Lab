// Avgränsningar i 0.1 ===============
// connections är enkelriktade
// max två colors
// pit ownership avgörs av norr eller söder om y=500
// acc ownership avgörs av väster eller öster om x=500

// TODO ==============================
// Play ska visa möjliga drag direkt
// Känn av connection color då drag utförs.
// Spara json
// vända på connections. två färger.
// connection delete 
// connection color change med högerklick
// Ska ej gå att ta bort pit med connections
// Slumpad AI i egen fil. Skapa gränssnittet.
// Riktig AI

// Framtid ===========================
// Grön zon, ägd av båda spelarna
// Dubbelriktade connections
// Regel: Connection skiftar färg då den används.
// Regel: Kula skiftar färg då den läggs
// Regel: Variationer på stöld
//        Ingen stöld
//        Stöld om sista pit innehåller två eller tre
//        Stöld om sista pit är tom
// Regel: Vad händer med stenarna då man inte kan flytta? Vem får dem?

PIT = 0
CONN = 1
STEAL = 2
DEL = 3
SEL = 4
PLAY = 5
UNDO = 6

ACC_TYPE = 0
PIT_TYPE = 1

PIT_RADIUS = 50
ACC_RADIUS = 65

var buttons = []
var colSlider
var sliders = []
var mode = PIT
var pits = []  // Two Accumulators and Pits
var selected = -1
var mymouseX = 0 
var mymouseY = 0
var hand = []    // stones from starting pit
var hist = []    // list of pit indexes
var turn = 0     // 0 = Human, 1 = Computer
var legals = []  // list of possible moves
var colors = []  // list of size colors

kalaha = { 
    stones : [4,0],
    pits : [
      {type:0, x:900, y:500, stones:[0,0], neighbours:[2], colors:[0]},  // 0
      {type:0, x:150, y:500, stones:[0,0], neighbours:[8], colors:[0]},  // 1
      
      {type:1, x:900, y:350, stones:[4,0], neighbours:[3], colors:[0]},  // 2
      {type:1, x:750, y:350, stones:[4,0], neighbours:[4], colors:[0]},  // 3
      {type:1, x:600, y:350, stones:[4,0], neighbours:[5], colors:[0]},  // 4
      {type:1, x:450, y:350, stones:[4,0], neighbours:[6], colors:[0]},  // 5
      {type:1, x:300, y:350, stones:[4,0], neighbours:[7], colors:[0]},  // 6
      {type:1, x:150, y:350, stones:[4,0], neighbours:[1], colors:[0]},  // 7
      
      {type:1, x:150, y:650, stones:[4,0], neighbours:[9], colors:[0]},  // 8
      {type:1, x:300, y:650, stones:[4,0], neighbours:[10], colors:[0]}, // 9
      {type:1, x:450, y:650, stones:[4,0], neighbours:[11], colors:[0]}, // 10
      {type:1, x:600, y:650, stones:[4,0], neighbours:[12], colors:[0]}, // 11
      {type:1, x:750, y:650, stones:[4,0], neighbours:[13], colors:[0]}, // 12
      {type:1, x:900, y:650, stones:[4,0], neighbours:[0], colors:[0]},  // 13
      ],
  }

jinjala = { 
    stones : [2,2],
    pits : [
      {type:0, x:950, y:500, stones:[0,0], neighbours:[2,3],   colors:[0,1]}, // 0
      {type:0, x: 50, y:500, stones:[0,0], neighbours:[9,10],  colors:[0,1]}, // 1
    
      {type:1, x:950, y:200, stones:[2,2], neighbours:[3,4],   colors:[0,1]}, // 2
      {type:1, x:800, y:350, stones:[2,2], neighbours:[4,5],   colors:[0,1]}, // 3
      {type:1, x:650, y:200, stones:[2,2], neighbours:[5,6],   colors:[0,1]}, // 4
      {type:1, x:500, y:350, stones:[2,2], neighbours:[6,7],   colors:[0,1]}, // 5
      {type:1, x:350, y:200, stones:[2,2], neighbours:[7,8],   colors:[0,1]}, // 6
      {type:1, x:200, y:350, stones:[2,2], neighbours:[1,8,10],colors:[0,1,1]}, // 7
      {type:1, x: 50, y:200, stones:[2,2], neighbours:[1],     colors:[0]},   // 8

      {type:1, x: 50, y:800, stones:[2,2], neighbours:[10,11], colors:[0,1]}, // 9
      {type:1, x:200, y:650, stones:[2,2], neighbours:[11,12], colors:[0,1]}, // 10
      {type:1, x:350, y:800, stones:[2,2], neighbours:[12,13], colors:[0,1]}, // 11
      {type:1, x:500, y:650, stones:[2,2], neighbours:[13,14], colors:[0,1]}, // 12
      {type:1, x:650, y:800, stones:[2,2], neighbours:[14,15], colors:[0,1]}, // 13
      {type:1, x:800, y:650, stones:[2,2], neighbours:[0,3,15],colors:[0,0,1]},// 14
      {type:1, x:950, y:800, stones:[2,2], neighbours:[0],     colors:[0]},   // 15
      ],
  }
  
function logg(prompt, value)  {
  console.log(prompt )
  console.log(value.toString())
}

function Pit(x,y,stones,type) {
  this.x = x
  this.y = y
  this.type = type
  this.radius = this.type == PIT_TYPE ? PIT_RADIUS : ACC_RADIUS
  this.stones = stones  // list of stones, in color order
  this.neighbours = []  // index of pits reachable from this pit
  this.colors = []      // colors of connections
  this.owner = function() {
    if (this.type == PIT_TYPE) {
      return (this.y < 3*height/5) + 2*(this.y > 2*height/5)
    } else {
      return (this.x < 200+(width-200)/2) + 2*(this.x > 200+(width-200)/2)
    }
  }
  this.accumulator = function() {
    return this.radius != ACC_RADIUS
  }
}

function pit() { mode = PIT }
function conn() { mode = CONN }
function steal() { mode = STEAL }
function del() { mode = DEL }
function sel() { mode = SEL }
function play() { mode = PLAY; hand=[] }

function undo() {
  var a
  if (hist.length > 2) {
    a = hist.pop()
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
  if (pit == null) return
  hand = pit.stones
  pit.stones = [0,0]
  hist.push(selected)
}

function lay() {
  if (hand[0] > 0) {
    pits[selected].stones[0]++
    hand[0]--
    hist.push(selected)
    if (hand[0] == 0) hist = []
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
  var res = []
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

function last(lst) {
  return lst[lst.length-1]
}

function setup() {
  //var data = kalaha
  var data = jinjala

  colors.push(color(255,0,0))
  colors.push(color(0,255,0))
  colors.push(color(0,0,255))
  colors.push(color(255,255,0))
  colors.push(color(255,0,255))
  colors.push(color(0,255,255))
  
  createCanvas(1000, 1000)
  background(128)
  textSize(20)

  var x = 20
  var y = 20
  buttons.push(makeButton(x,y,'Pit',pit))
  x+= last(buttons).width+10
  buttons.push(makeButton(x,y,'Conn',conn))
  x+= last(buttons).width+10
  buttons.push(makeButton(x,y,'Steal',steal))
  x+= last(buttons).width+10
  buttons.push(makeButton(x,y,'Del',del))
  x+= last(buttons).width+10
  buttons.push(makeButton(x,y,'Sel',sel))
  x+= last(buttons).width+10
  buttons.push(makeButton(x,y,'Play',play))
  x+= last(buttons).width+10
  buttons.push(makeButton(x,y,'Undo',undo))
  x+= last(buttons).width+10
  
  colSlider = makeSlider(400,y,1,2,data.stones.length)
  sliders = []
  for (var i=0; i<data.stones.length; i++) {
    sliders.push(makeSlider(600+i*200,y,0,10,data.stones[i]))
  }

  colSlider.input(changeSliders)
  changeSliders()
  
  // Accumulators
  //pits.push(new Pit(240,height/2,[0,0],ACC_RADIUS))
  //pits.push(new Pit(width-40,height/2,[0,0],ACC_RADIUS))
  
  for (var i=0; i<data.pits.length; i++) {
    var dp = data.pits[i]
    var p = new Pit(dp.x, dp.y, dp.stones, dp.type)
    p.neighbours = dp.neighbours
    p.colors = dp.colors
    pits.push(p)
  }
}

function changeSliders() { 
  for (var i = 0; i<sliders.length; i++) {
    slider = sliders[i]
    slider.position(slider.x, i<colSlider.value() ? 20 : -100)
  }
}

function sliderList() {
  var res = []
  for (var i = 0; i < sliders.length; i++) {
    res.push(sliders[i].value())
  }
  return res
}

function dist(x1,y1,x2,y2) {
  var dx = x1-x2
  var dy = y1-y2
  return Math.sqrt(dx*dx+dy*dy)
}

function inRect(x,y,rx,ry,rw,rh) {
  return (x > rx && x < rx+rw) && (y > ry && y < ry+rh)
}

function find(x,y) {
  for (var i=0; i<pits.length; i++) {
    var pit = pits[i]
    if (pit) {
      if (dist(pit.x,pit.y,x,y) < pit.radius/2) return i
    }
  }
  return -1
}

function delPit() {
  pit = pits[selected]
  if (pit.radius == PIT_RADIUS) {
    pits[selected] = null
    selected = -1
  }
}

function mousePressed() {
  mymouseX = winMouseX
  mymouseY = winMouseY

  if (mouseY<100) return
  if (mode == PIT) { 
    pits.push(new Pit(mouseX,mouseY,sliderList(),PIT_TYPE))
  } else if (mode == 22) {
    selected2 = find(mouseX,mouseY)
    if (selected2 != -1) pits[selected].neighbours.push(selected2)
    mode = CONN
  } else if (mode == CONN) {
    selected = find(mouseX,mouseY)
    if (selected != -1) mode = 22
  } else if (mode == DEL) {  // Delete
    selected = find(mouseX,mouseY)
    if (selected != -1) delPit(selected)
  } else if (mode == SEL) {
    selected = find(mouseX,mouseY)
  } else if (mode == PLAY) {
    selected = find(mouseX,mouseY)
    if (hand.length==0) { pickUp() } else lay()
  }
}

function drawpit(n) {
  stroke(n==selected ? 255 : 0)
  pit = pits[n]
  
  // markera möjligt drag
  if (legals.indexOf(n) != -1) {
    noFill()
    ellipse(pit.x, pit.y, pit.radius+5, pit.radius+5)
  }
  
  // rita själva piten
  fill(100)
  strokeWeight(2)
  ellipse(pit.x, pit.y, pit.radius, pit.radius)
  
  // visa antal stenar
  noStroke(); textAlign(CENTER,CENTER); 
  if (colSlider.value()==1) {
    fill(colors[0]); text(pit.stones[0], pit.x, pit.y)
  } else if (colSlider.value()==2) {
    fill(colors[0]); text(pit.stones[0], pit.x, pit.y-11)
    fill(colors[1]); text(pit.stones[1], pit.x, pit.y+11)
  }
}

// Rita riktning för connection
function drawdirection(n) {
  stroke(n==selected ? 255 : 0)
  var pit = pits[n]
  for (var i=0; i<pit.neighbours.length; i++) {
    var nb = pit.neighbours[i]
    var p1 = pit 
    var p2 = pits[nb]
    if (p2) {
      var d = dist (p1.x,p1.y,p2.x,p2.y)
      var x = map(p2.radius/2+8,0,d,p2.x,p1.x)
      var y = map(p2.radius/2+8,0,d,p2.y,p1.y)
      stroke(0)
      ellipse(x,y,10,10)
    }
  }
}

function drawconnection(n) {
  stroke(n==selected ? 255 : 0)
  var pit = pits[n]
  for (var i=0; i<pit.neighbours.length; i++) {
    var nb = pit.neighbours[i]
    var p1 = pit 
    var p2 = pits[nb]
    if (p2) {
      strokeWeight(5)
      stroke(colors[pit.colors[i]])  
      line(p1.x,p1.y,p2.x,p2.y)
    }
  }
}

function drawHand() {
  if (hand.length==0) return
  noStroke(); textAlign(CENTER,CENTER); 
  var x = width/2
  var y = height/2
  if (colSlider.value()==1) {
    fill(colors[0]); text(hand[0], x, y)
  } else if (colSlider.value()==2) {
    fill(colors[0]); text(hand[0], x, y-11)
    fill(colors[1]); text(hand[1], x, y+11)
  }
}

function drawTexts() {
  noStroke(); 
  textAlign(CENTER,CENTER); 
  for (var i=0; i<sliders.length; i++) {
    var slider = sliders[i]
    fill(colors[i]); text(slider.value(), slider.x+slider.width+20, slider.y+12)
  }
}

function indicateMode() {
  stroke(0)
  strokeWeight(3)
  fill(0)
  var y = 45
  line(buttons[mode].x,y,buttons[mode].x+buttons[mode].width,y)
}

function draw() {
  background(128)
  
  // green neutral zone, owned by both players
  //fill(40,120,40); noStroke(); rect(200,2*height/5,width,height/5)
  line(0,500,1000,500)
  
  indicateMode()
  
  legals = legalMoves()

  for (var i=0; i<pits.length; i++) if (pits[i]!= null) drawconnection(i)
  for (var i=0; i<pits.length; i++) if (pits[i]!= null) drawdirection(i)
  for (var i=0; i<pits.length; i++) if (pits[i]!= null) drawpit(i)
  drawHand()
  drawTexts()
}

function mouseDragged(event) {
  // selected anger pit
  if (mode==SEL && selected>=0) {
    var dx = winMouseX - mymouseX 
    var dy = winMouseY - mymouseY
    mymouseX = winMouseX
    mymouseY = winMouseY
    pit = pits[selected]
    pit.x += dx
    pit.y += dy
  }
}
