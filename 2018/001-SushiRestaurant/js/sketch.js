"use strict";

var _slicedToArray = function () { function sliceIterator(arr, i) { var _arr = []; var _n = true; var _d = false; var _e = undefined; try { for (var _i = arr[Symbol.iterator](), _s; !(_n = (_s = _i.next()).done); _n = true) { _arr.push(_s.value); if (i && _arr.length === i) break; } } catch (err) { _d = true; _e = err; } finally { try { if (!_n && _i["return"]) _i["return"](); } finally { if (_d) throw _e; } } return _arr; } return function (arr, i) { if (Array.isArray(arr)) { return arr; } else if (Symbol.iterator in Object(arr)) { return sliceIterator(arr, i); } else { throw new TypeError("Invalid attempt to destructure non-iterable instance"); } }; }();

// Generated by CoffeeScript 2.0.3
var MAIL, SHOP, clr, update;

MAIL = "janchrister.nilsson@gmail.com";

SHOP = "FU Restaurang";

window.onload = function () {
  var b1, body, w;
  w = window.innerWidth;
  body = document.getElementById("body");
  b1 = document.createElement("input");
  b1.type = 'button';
  b1.value = "text"; // text
  b1.style = "font-size:10px; white-space:normal; width:100%; text-align:left";
  return body.appendChild(b1);
};

// table = document.createElement "table"
// body.appendChild table
// for item in data
// 	item.push 0
// 	do (item) ->
// 		[id,pris,text,antal] = item

// 		b1 = document.createElement "input"
// 		b1.type = 'button'
// 		b1.value = "text" # text
// 		b1.style = "font-size:10px; white-space:normal; width:100%; text-align:left"

// 		b2 = document.createElement "input"
// 		b2.type = 'button'
// 		b2.value = if antal==0 then "" else antal
// 		b2.id = id
// 		b2.style = "font-size:10px; width:100%" # height:80px; 

// 		b1.onclick = -> update b2,item,+1
// 		b2.onclick = -> if b2.value > 0 then update b2,item,-1

// 		tr = document.createElement "tr"
// 		td0 = document.createElement "td"
// 		td1 = document.createElement "td"
// 		td2 = document.createElement "td"
// 		td0.style = "width:5%"
// 		td1.style = "width:85%"
// 		td2.style = "width:10%"
// 		table.appendChild tr
// 		tr.appendChild td0
// 		tr.appendChild td1
// 		tr.appendChild td2
// 		div = document.createElement "div"
// 		div.innerHTML = '<b>' + id + '</b><br>' + pris + ':-'
// 		td0.appendChild div
// 		td1.appendChild b1
// 		td2.appendChild b2

// total = document.createElement "input"
// total.type = 'button'
// total.id = 'total'
// total.value = "0:-"
// total.style = "font-size:40px; width:50%"
// total.onclick = -> clr()

// send = document.createElement "input"
// send.type = 'button'
// send.value = 'Skicka'
// send.style = "font-size:40px; width:50%"
// send.onclick = -> 
// 	total = document.getElementById "total"
// 	if total.value == "0:-" then return
// 	t = 0
// 	s = '' # full text
// 	u = '' # compact
// 	for [id,pris,text,antal] in data
// 		if antal > 0 
// 			s += antal + ' x ' + id + ". " + text + "\n"
// 			if antal == 1 
// 				u += id + "\n"
// 			else
// 				u += antal + 'x' + id + "\n"
// 		t += antal * pris
// 	if s.length > 500 then s = u 
// 	window.location.href = encodeURI "mailto:#{MAIL}?&subject=Order till #{SHOP}&body=" + s + "\nTotalt " + t + " kr." 
// 	clr()

// body.appendChild send
// body.appendChild total
clr = function clr() {
  var button, i, item, len;
  for (i = 0, len = data.length; i < len; i++) {
    item = data[i];
    item[3] = 0;
    button = document.getElementById(item[0]);
    button.value = '';
  }
  return total.value = "0:-";
};

update = function update(b, item, delta) {
  var antal, i, id, len, pris, t, text, total;
  item[3] += delta;
  b.value = item[3] === 0 ? "" : item[3];
  t = 0;
  for (i = 0, len = data.length; i < len; i++) {
    var _data$i = _slicedToArray(data[i], 4);

    id = _data$i[0];
    pris = _data$i[1];
    text = _data$i[2];
    antal = _data$i[3];

    t += antal * pris;
  }
  total = document.getElementById("total");
  return total.value = t + ':-';
};
//# sourceMappingURL=sketch.js.map
