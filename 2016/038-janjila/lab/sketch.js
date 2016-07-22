WIDTH = 800
HEIGHT = 800

INTERVAL = 500

data = {}

function setup() {
  createCanvas(WIDTH,HEIGHT) 
  setInterval(loadData,INTERVAL)
}

function loadData() {
  loadJSON('data.json',loaded)
}

function loaded(dta) {
  data = dta
  x = data['x']
  y = data['y']
  r = data['r']
  c = data['c']
  stones = data['stones']
  positions = data['p']
  hints = data['hints']
  moves = data['m']
  col = data['color']
  pending = data['pending']
  mydraw()
}

function mydraw() {
  background(128)
  scale(1)
  strokeWeight(1);
  draw_moves()
  draw_pits()
  draw_pending()
}

function draw_pits() {
  for (var ip=0; ip<positions.length; ip++) {
    var pair = positions[ip]
    var i=pair[0]
    var j=pair[1]
    var lst_stone = stones[ip]
    r1 = WIDTH*r[0][0]/x[x.length-1]
    var xc = WIDTH*x[i]/x[x.length-1]
    var yc = HEIGHT*y[j]/y[y.length-1]
    strokeWeight(0+3*hints[ip]); stroke(0); fill(184); ellipse(xc,yc,2*r1,2*r1)
    textSize(20)
    noStroke(); fill(220); textAlign(CENTER,CENTER); text('ABCDEFGHIJKLMNOP'[ip], xc, yc+2)
    textSize(20)
    for (var ic=0; ic<c.length; ic++) {
      draw_stones(ic, lst_stone[ic], xc, yc, [-17,17][ic])
    }
  }
}

function draw_pending() {
  for (var ic=0; ic<c.length; ic++) {
    draw_stones(ic, pending[ic], WIDTH/2, HEIGHT/2, [-17,17][ic])
  }
}

function draw_stones(ic, n, xc, yc, delta) {
  fill(c[ic]); text('o'.repeat(min(n,10)), xc, yc+delta)
  if (n>10) draw_stones(ic,n-10,xc,yc+delta, delta)    
}

function draw_moves() {
  for (var im=0; im<moves.length; im++) {
    var icol = col[im]
    var move = moves[im]
    var ip1=move[0]
    var ip2=move[1]
    var pos1 = positions[ip1]
    var pos2 = positions[ip2]
    var i1 = pos1[0]
    var j1 = pos1[1]
    var i2 = pos2[0]
    var j2 = pos2[1]
    var x1 = WIDTH*x[i1]/x[x.length-1]
    var y1 = HEIGHT*y[j1]/y[y.length-1]
    var x2 = WIDTH*x[i2]/x[x.length-1]
    var y2 = HEIGHT*y[j2]/y[y.length-1]
    strokeWeight(20); stroke(c[icol]); line(x1,y1,x2,y2)
  }
}

