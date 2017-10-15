var a = 11
var b = 10
var count = 0

function setup() {
  lbl_a = createElement('h2', a);
  lbl_a.position(25, 0);

  lbl_b = createElement('h2', b);
  lbl_b.position(75, 0);

  button = createButton('/2')
  button.position(10, 50)
  button.mousePressed(div2)
  
  button = createButton('+2')
  button.position(50, 50)
  button.mousePressed(add2)

  button = createButton('*2')
  button.position(90, 50)
  button.mousePressed(mul2)
  
  lbl_c = createElement('h2', count);
  lbl_c.position(50, 60);
}

function calc(value) {
  a = value
  lbl_a.html(a)
  count++
  lbl_c.html(count)
}

function div2() {
  if (a%2==0) calc(a/2)
}

function add2() {
  calc(a+2)
}

function mul2() {
  calc(a*2)
}

