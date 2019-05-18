// Morse

var lst = []
var unit = 500
//             012345678901234567890123456789
var alfabet = "  etianmsurwdkgohvf l pjbxcyzq";
var osc

function delay(n) {lst.push(n)}
function on() {lst.push(-1)}
function off() {lst.push(0)}

function dot()  {on(); delay(1); off(); delay(1)}
function dash() {on(); delay(3); off(); delay(1)}

function getLetter(letter) {
  var i = alfabet.indexOf(letter)
  var result = ""
  while (i>1) {
    result = ".-"[i%2] + result
    i = Math.floor(i/2)
  }
  return result
}

function sendLetter(dd) {
  for (var d of dd) {
    if (d == '.') dot();
    if (d == '-') dash();
  }  
  delay(3);   
}

function sendSentence(letters) {
  delay(10)
  for (var letter of letters) {
    if (letter == ' ') {
      delay(7)
    } else {
      var dd = getLetter(letter)
      sendLetter(dd)
    }
  }
}

function morse() {
  sendSentence("rotmos")
}

function setup() { 
  createCanvas(600,600) 
  frameRate(10)
  
  img = loadImage("hal9000.jpg")
  
  osc = new p5.Oscillator();
  osc.start();  
  
  morse()
}

function draw() { 
  background('black') 
  translate(width/2,height/2)
  var tid = -100
  var lamp = 0 
  for (var item of lst) {
    if (item <= 0) lamp = item
    if (item > 0) tid += item*unit
    if (tid >= millis()) break
  }
  if (lamp==-1) {
    image(img,-150,-100)
    osc.amp(0.5)
  } else {
    osc.amp(0)
  }
}
