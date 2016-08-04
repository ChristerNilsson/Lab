var arrlen = [89,55,34,21,13,8,5,3,2,1,1]
var stack = [[500,500]] // of [x,y]
var hist = "" // of L,R,U,D
var db = {}
var s 
var i
var skipMode = false

function generate(n) {
  var res = 'X'
  for (var i=0; i<n; i++) { res = res.replace(/X/g,'LX]RX]UX]DX]')}
  res = res.replace(/X/g,'')
  console.log(res.length)
  return res
}

function last(lst) {
  return lst[lst.length-1]
}

function stopp() {
  if (hist.includes("LR")) return true
  if (hist.includes("RL")) return true
  if (hist.includes("DU")) return true
  if (hist.includes("UD")) return true
  return false
}

function linje(dx,dy) {
  lst = stack[stack.length-1]
  xo = lst[0]
  yo = lst[1]
  var key = (xo+dx).toString() + ',' + (yo+dy).toString()
  stack.push([xo+dx,yo+dy])
  hist += s[i]
  if (stopp()==false ) {  //  && !(key in db)
    line(xo,yo,xo+dx,yo+dy)
  }
  db[key] = 1
}


function interpret() {
  i = 0 
  while (i<s.length) {
    var size = arrlen[stack.length]
    var ch = s[i]
    if (ch=='[') { 
    } else if (ch==']') {
      stack.pop()
      hist = hist.slice(0,hist.length-1)
    } else if (ch=='L') { linje(-size,0)
    } else if (ch=='R') { linje(size,0)
    } else if (ch=='U') { linje(0,-size)
    } else if (ch=='D') { linje(0,size)
    }
    i++
  }
}

function setup() {
  createCanvas(1000,1000)
  stroke(0,100)
  s = generate(5)
  interpret()
}
