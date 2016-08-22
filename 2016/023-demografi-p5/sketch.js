var aSlider, bSlider, cSlider, dSlider, eSlider
var boys, girls, mothers, total
var stat

function setup() {
  createCanvas(1000, 2300)
  textSize(15)

  // sliders
  x = 230
  aSlider = createSlider(9, 39, 15)  // marriageage
  aSlider.position(x, 20)
  bSlider = createSlider(1, 4, 2)    // wives
  bSlider.position(x, 50)
  cSlider = createSlider(0, 8, 6)   // children/wife
  cSlider.position(x, 80)
  dSlider = createSlider(1, 5, 2)    // birthfreq
  dSlider.position(x, 110)
  eSlider = createSlider(0, 10, 8)   // marriagefreq
  eSlider.position(x, 140)
  
  button2 = createButton('Secular')
  button2.position(120, 195)
  button2.mousePressed(secular)  

  button2 = createButton('Religious')
  button2.position(220, 195)
  button2.mousePressed(religious)
  
  s = 'This is a calculation of the number of offsprings a single man can produce in a century<br>'
  s += 'The man is born in the year 2000<br>'
  s += 'The same policy is used for every marriage<br>'
  s += 'The spouse is always fetched from outside the country<br>'
  
  info = createP(s)
  info.position(410,5)

  stat = createP('stat')
  stat.position(0,220)
  
  secular()
}

function makerow(a,b,c,d,e) {
    s = ''
    s += '<td>' + a + '</td>'
    s += '<td>' + b + '</td>'
    s += '<td>' + c + '</td>'
    s += '<td>' + d + '</td>'
    s += '<td>' + e + '</td>'
    return '<tr>' + s + '</tr>'
}

function spaces(n) {
  var s = '' + n
  var res = ''
  for (var i=0; i<s.length; i++) {
    var j = s.length - i - 1
    res = s[j] + res
    if (i%3==2 && j!=0) res = ',' + res
  }
  return res
}

function makerow_nr(a,b,c,d,e) {
  b = (b==0) ? '' : spaces(b)
  c = (c==0) ? '' : spaces(c)
  d = (d==0) ? '' : spaces(d)
  e = (e==0) ? '' : spaces(e)
  return makerow(a,b,c,d,e)
}

function statistics() {
  s = makerow('Year','Boys','Girls','Mothers','Total')
  for (i=99; i>=0; i--) {
    a = 2000+i
    b = boys[i]
    c = girls[i]
    d = mothers[i]
    e = total[i]
    s = s + makerow_nr(a,b,c,d,e) 
  }
  stat.html('<table>' + s + '</table>')
}

function secular() {
  aSlider.value(30)
  bSlider.value(1)
  cSlider.value(2)
  dSlider.value(2)
}

function religious() {
  aSlider.value(15)
  bSlider.value(2)
  cSlider.value(3)
  dSlider.value(2)
  eSlider.value(7)
}

function calc(a,b,c,d,e) {
  MARRIAGE = a  // a=marriageage
  N = 100 + MARRIAGE 
  
  girls = []
  boys = []
  mothers = []
  total = []

  randomSeed(99);  // annars fladdrar det.

  for (var year=0; year<N + MARRIAGE+30; year++) {   // 6
    boys[year]     = 0
    girls[year]    = 0
    mothers[year]  = 0
    total[year]    = 0
  }
  boys[0] = 1 
  total[0] = 1 
  
  for (year=0; year<N; year++) {

    if (year>0 && year<100) {
      total[year] = total[year-1] + boys[year] + girls[year] + mothers[year]
    }

    // MALE
    for (i=0; i<b; i++) {  // b = wifes
      y = year + MARRIAGE + i*e  // e = marriagefreq
      if (y <= N) {
        mothers[y] += boys[year]     // behandla nyfödda, skapa en man och fyra fuar
      }
    }

    // FEMALE
    mothers[year + MARRIAGE] += girls[year]   // behandla nyfödda, skapa fruar

    count = mothers[year] // behandla nygifta kvinnor, skapa barn
    for (i=0; i<c; i++) {  // c = children/wife
    
      if (count%2==1) {  // Borde egentligen vara en normalfördelning
        g = (count-1)/2 + round(random(0,1))
      } else {
        g = count/2
      }

      girls[year + d*i+1] += g // d = birthfreq
      boys[year + d*i+1] += count-g // d = birthfreq
    }
  }
}

function drawtext(txt, value, x, y) {
  text(txt, 5, y)
  text(value, x, y)
}

function draw() {
  var a = aSlider.value()
  var b = bSlider.value()
  var c = cSlider.value()
  var d = dSlider.value()
  var e = eSlider.value()
  calc(a,b,c,d,e)
  background(255)
  x = 380
  drawtext("Marriage age: (9-39) ", a, x, 35)
  drawtext("Wives per husband: (1-4) ", b, x, 65)
  drawtext("Children per wife: (0-8) ", c, x, 95)
  drawtext("Years between births: (1-5) ", d, x, 125)
  drawtext("Years between marriages: (0-10)", e, x, 155)
  statistics()
}
