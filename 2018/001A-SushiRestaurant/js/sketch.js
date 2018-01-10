"use strict";

var _slicedToArray = function () { function sliceIterator(arr, i) { var _arr = []; var _n = true; var _d = false; var _e = undefined; try { for (var _i = arr[Symbol.iterator](), _s; !(_n = (_s = _i.next()).done); _n = true) { _arr.push(_s.value); if (i && _arr.length === i) break; } } catch (err) { _d = true; _e = err; } finally { try { if (!_n && _i["return"]) _i["return"](); } finally { if (_d) throw _e; } } return _arr; } return function (arr, i) { if (Array.isArray(arr)) { return arr; } else if (Symbol.iterator in Object(arr)) { return sliceIterator(arr, i); } else { throw new TypeError("Invalid attempt to destructure non-iterable instance"); } }; }();

function _toArray(arr) { return Array.isArray(arr) ? arr : Array.from(arr); }

// Generated by CoffeeScript 2.0.3
var CRLF, MAIL, SHOP, addTitle, body, branch, calc, clr, goDeeper, table, _traverse, update;

MAIL = "janchrister.nilsson@gmail.com";

SHOP = "FU Restaurang";

CRLF = "\n";

//CRLF = "<br/>"
body = null;

table = null;

branch = [0]; // motsvarar Meny samt Korg, dvs 2 rader i Table


// iOS visar inga radbrytningar.

// OBS: .cssText måste användas på iPhone 4s
addTitle = function addTitle(id, pris, title, count, level, br) {
  var b1, div, scount, td0, td1, tr;
  b1 = document.createElement("input");
  b1.type = 'button';
  if (count > 0) {
    scount = " (" + count + ")";
  } else {
    scount = "";
  }
  b1.value = '........'.slice(0, 4 * level) + title + scount;
  b1.branch = br;
  b1.style.cssText = "font-size:100%; white-space:normal; width:100%; text-align:left";

  //b1.onclick = -> update b2,item,+1
  b1.onclick = function () {
    branch = b1.branch.concat([]);
    table.remove();
    table = document.createElement("table");
    body.appendChild(table);
    console.log('New branch', branch);
    return _traverse(data, 0);
  };
  // b2 = document.createElement "input"
  // b2.type = 'button'
  // b2.value = if antal==0 then "" else antal
  // b2.id = id
  // b2.style.cssText = "font-size:100%; width:100%" # height:80px; 
  // b2.onclick = -> if b2.value > 0 then update b2,item,-1
  tr = document.createElement("tr");
  td0 = document.createElement("td");
  td1 = document.createElement("td");
  //	td2 = document.createElement "td"
  td0.style.cssText = "width:5%";
  td1.style.cssText = "width:85%";
  //	td2.style.cssText = "width:10%"
  table.appendChild(tr);
  tr.appendChild(td0);
  tr.appendChild(td1);
  //	tr.appendChild td2
  div = document.createElement("div");
  div.style.cssText = "font-size:70%";
  if (id !== '') {
    div.innerHTML = '<b>' + id + '</b><br>' + pris + ':-';
  }
  td0.appendChild(div);
  return td1.appendChild(b1);
};

//	td2.appendChild b2
calc = function calc(hash) {
  var key, res;
  res = 0;
  for (key in hash) {
    res += hash[key];
  }
  return res;
};

goDeeper = function goDeeper(a, b) {
  var i, j, len, ref;
  ref = range(Math.min(a.length, b.length));
  for (j = 0, len = ref.length; j < len; j++) {
    i = ref[j];
    if (a[i] !== b[i]) {
      return false;
    }
  }
  return a.length >= b.length;
};

assert(true, goDeeper([], []));

assert(true, goDeeper([0], [0]));

assert(true, goDeeper([0, 0], [0, 0]));

assert(true, goDeeper([0], []));

assert(true, goDeeper([0, 0], [0]));

assert(false, goDeeper([], [0]));

assert(false, goDeeper([0], [0, 0]));

assert(false, goDeeper([0], [1]));

assert(false, goDeeper([1], [0]));

assert(false, goDeeper([0, 0], [0, 1]));

assert(false, goDeeper([1, 0], [0]));

_traverse = function traverse(items) {
  var level = arguments.length > 1 && arguments[1] !== undefined ? arguments[1] : 0;
  var br = arguments.length > 2 && arguments[2] !== undefined ? arguments[2] : [];

  var fn, i, item, j, k, len, len1, results, x;
  if (false === goDeeper(branch, br)) {
    return;
  }
  if (level === 0 || level === 1) {
    fn = function fn(item) {
      var children, count, k, len1, title, x;

      var _item = _toArray(item);

      title = _item[0];
      children = _item.slice(1);

      if (level === 0) {
        addTitle('', 0, title, children.length, level, br.concat(i));
      } else {
        count = 0;
        for (k = 0, len1 = children.length; k < len1; k++) {
          x = children[k];
          count += x.length;
        }
        addTitle('', 0, title, count, level, br.concat(i));
      }
      return _traverse(children, level + 1, br.concat(i));
    };
    for (i = j = 0, len = items.length; j < len; i = ++j) {
      item = items[i];
      fn(item);
    }
  }
  if (level === 2) {
    results = [];
    for (k = 0, len1 = items.length; k < len1; k++) {
      item = items[k];
      results.push(function () {
        var l, len2, results1;
        results1 = [];
        for (l = 0, len2 = item.length; l < len2; l++) {
          x = item[l];
          results1.push(addTitle(x[0], x[1], x[2], calc(x[3]), level));
        }
        return results1;
      }());
    }
    return results;
  }
};

window.onload = function () {
  var closed, w;
  w = window.innerWidth;
  body = document.getElementById("body");
  table = document.createElement("table");
  body.appendChild(table);
  closed = {}; // innehåller menyer som är stängda
  return _traverse(data);
};

// total = document.createElement "input"
// total.type = 'button'
// total.id = 'total'
// total.value = "0:-"
// total.style.cssText = "font-size:200%; width:50%"
// total.onclick = -> clr()

// send = document.createElement "input"
// send.type = 'button'
// send.value = 'Skicka'
// send.style.cssText = "font-size:200%; width:50%"
// send.onclick = -> 
// 	total = document.getElementById "total"
// 	if total.value == "0:-" then return
// 	t = 0
// 	s = '' # full text
// 	u = '' # compact
// 	for [id,pris,text,antal] in data
// 		if antal > 0 
// 			s += antal + ' x ' + id + ". " + text + CRLF
// 			if antal == 1 
// 				u += id + CRLF
// 			else
// 				u += antal + 'x' + id + CRLF
// 		t += antal * pris
// 	if s.length > 500 then s = u 

// 	output = encodeURI "mailto:#{MAIL}?&subject=Order till #{SHOP}&body=" + s + CRLF + "Totalt " + t + " kr."
// 	window.location.href = output
// 	#console.log output
// 	clr()

// body.appendChild send
// body.appendChild total
clr = function clr() {
  var button, item, j, len;
  for (j = 0, len = data.length; j < len; j++) {
    item = data[j];
    item[3] = 0;
    button = document.getElementById(item[0]);
    button.value = '';
  }
  return total.value = "0:-";
};

update = function update(b, item, delta) {
  var antal, id, j, len, pris, t, text, total;
  item[3] += delta;
  b.value = item[3] === 0 ? "" : item[3];
  t = 0;
  for (j = 0, len = data.length; j < len; j++) {
    var _data$j = _slicedToArray(data[j], 4);

    id = _data$j[0];
    pris = _data$j[1];
    text = _data$j[2];
    antal = _data$j[3];

    t += antal * pris;
  }
  total = document.getElementById("total");
  return total.value = t + ':-';
};
//# sourceMappingURL=sketch.js.map