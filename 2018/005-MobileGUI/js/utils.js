"use strict";

// Generated by CoffeeScript 2.0.3
var addCell, calcColor, calcDelta, calcETA, calcHeading, calcSpeed, distance_on_geoid, getField, isNumeric, makeButton, makeDiv, makeInput, precisionRound, prettyDate, test, tests;

tests = {};

addCell = function addCell(tr, value) {
  var td;
  td = document.createElement("td");
  td.appendChild(value);
  return tr.appendChild(td);
};

// Visa vinkelavvikelse med färgton. 
// -180 = black
//  -90 = red
//    0 = white
//   90 = green 
//  180 = black
calcColor = function calcColor(delta) {
  // -180 <= delta <= 180
  var res;
  if (-180 <= delta && delta < -90) {
    res = lerpColor(BLACK, RED, (delta + 180) / 90);
  } else if (-90 <= delta && delta < 0) {
    res = lerpColor(RED, WHITE, (delta + 90) / 90);
  } else if (0 <= delta && delta < 90) {
    res = lerpColor(WHITE, GREEN, (delta + 0) / 90);
  } else if (90 <= delta && delta <= 180) {
    res = lerpColor(GREEN, BLACK, (delta - 90) / 90);
  } else {
    res = color(255, 255, 0, 255); // yellow, error 
  }
  return res.levels;
};

tests.calcColor = function () {
  assert([255, 255, 255, 255], calcColor(0));
  assert([128, 255, 128, 255], calcColor(45));
  assert([0, 255, 0, 255], calcColor(90));
  assert([0, 128, 0, 255], calcColor(135));
  assert([0, 0, 0, 255], calcColor(180));
  assert([255, 128, 128, 255], calcColor(-45));
  assert([255, 0, 0, 255], calcColor(-90));
  assert([128, 0, 0, 255], calcColor(-135));
  assert([0, 0, 0, 255], calcColor(-180));
  assert([255, 255, 0, 255], calcColor(-225));
  assert([255, 255, 0, 255], calcColor(-270));
  assert([255, 255, 0, 255], calcColor(-315));
  assert([255, 255, 0, 255], calcColor(-360));
  assert([255, 255, 0, 255], calcColor(225));
  assert([255, 255, 0, 255], calcColor(270));
  assert([255, 255, 0, 255], calcColor(315));
  return assert([255, 255, 0, 255], calcColor(360));
};

calcDelta = function calcDelta(delta) {
  if (delta < -180) {
    delta += 360;
  }
  if (delta > +180) {
    delta -= 360;
  }
  return delta;
};

tests.calcDelta = function () {
  assert(0, calcDelta(-360));
  assert(90, calcDelta(-270));
  assert(-180, calcDelta(-180));
  assert(-90, calcDelta(-90));
  assert(0, calcDelta(0));
  assert(90, calcDelta(90));
  assert(180, calcDelta(180));
  assert(-90, calcDelta(270));
  return assert(0, calcDelta(360));
};

calcETA = function calcETA(ta, tp, a, p, b) {
  var ap, dt, pb;
  dt = (tp - ta) / 1000; // sekunder	
  ap = distance_on_geoid(a, p); // meter
  pb = distance_on_geoid(p, b); // meter 
  if (ap > 0) {
    return dt * (ap + pb) / ap;
  } else {
    return 0; // sekunder	
  }
};

tests.calcETA = function () {
  var a, b, p0, p1, p2, p3;
  a = {
    lat: 59.000000,
    lng: 18.100000
  };
  b = {
    lat: 59.200000,
    lng: 18.100000
  };
  p0 = {
    lat: 59.000000,
    lng: 18.000000
  };
  p1 = {
    lat: 59.100000,
    lng: 18.000000
  };
  p2 = {
    lat: 59.200000,
    lng: 18.000000
  };
  p3 = {
    lat: 59.100000,
    lng: 18.100000
  };
  assert(5009.176237166901, calcETA(0, 1000000, a, p0, b));
  assert(1999.3916011809056, calcETA(0, 1000000, a, p1, b));
  assert(1247.9772474262074, calcETA(0, 1000000, a, p2, b));
  return assert(1999.9999999998727, calcETA(0, 1000000, a, p3, b));
};

calcHeading = function calcHeading(p1, p2) {
  var q1, q2;
  q1 = LatLon(p1.lat, p1.lng);
  q2 = LatLon(p2.lat, p2.lng);
  return q1.bearingTo(q2);
};

tests.calcHeading = function () {
  var a, b, p;
  a = {
    lat: 59.000000,
    lng: 18.100000
  };
  b = {
    lat: 59.100000,
    lng: 18.100000
  };
  p = {
    lat: 59.050000,
    lng: 18.000000
  };
  assert(0, calcHeading(a, b));
  assert(180, calcHeading(b, a));
  assert(314.2148752824801, calcHeading(a, p));
  assert(134.12913607386804, calcHeading(p, a));
  assert(45.74342946571903, calcHeading(p, b));
  return assert(225.82921355457827, calcHeading(b, p));
};

// calcSpeed = (ta,tp,a,p,b) -> # anger den hastighet man har från startpunkten
// 	dt = (tp-ta)/1000 # sekunder
// 	ap = distance_on_geoid a,p # meter
// 	if dt>0 then ap/dt else 0 # m/s
// tests.calcSpeed = ->
// 	a = {lat:59.000000, lng:18.100000}
// 	b = {lat:59.100000, lng:18.100000}
// 	p = {lat:59.050000, lng:18.000000}
// 	assert 7.978798475908504, calcSpeed 0,1000000,a,p,b # 1000 sekunder
calcSpeed = function calcSpeed(ta, tp, a, p, b) {
  // anger den hastighet man närmar sig målet med. Typ vmg utan vinklar
  var ab, dt, pb;
  ab = distance_on_geoid(a, b); // meter
  pb = distance_on_geoid(p, b); // meter
  dt = (tp - ta) / 1000; // sekunder
  if (dt > 0) {
    return (ab - pb) / dt;
  } else {
    return 0; // m/s
  }
};

tests.calcSpeed = function () {
  var a, b, p;
  a = {
    lat: 59.000000,
    lng: 18.100000
  };
  b = {
    lat: 59.100000,
    lng: 18.100000
  };
  p = {
    lat: 59.050000,
    lng: 18.000000
  };
  return assert(3.1466610127605774, calcSpeed(0, 1000000, a, p, b)); // 1000 sekunder
};

// https://cdn.rawgit.com/chrisveness/geodesy/v1.1.2/latlon-spherical.js
distance_on_geoid = function distance_on_geoid(p1, p2) {
  var q1, q2;
  q1 = LatLon(p1.lat, p1.lng);
  q2 = LatLon(p2.lat, p2.lng);
  return q1.distanceTo(q2);
};

tests.distance_on_geoid = function () {
  var a, b, p;
  a = {
    lat: 59.000000,
    lng: 18.100000
  };
  b = {
    lat: 59.100000,
    lng: 18.100000
  };
  p = {
    lat: 59.050000,
    lng: 18.000000
  };
  assert(11119.492664456597, distance_on_geoid(a, b));
  return assert(7972.831651696019, distance_on_geoid(p, b));
};

getField = function getField(name) {
  var element;
  element = document.getElementById(name);
  if (element) {
    return element.value;
  } else {
    return null;
  }
};

isNumeric = function isNumeric(val) {
  return val === Number(parseFloat(val));
};

tests.isNumeric = function () {
  assert(true, isNumeric(1.2));
  assert(true, isNumeric(1));
  assert(false, isNumeric("1.2"));
  assert(false, isNumeric(null));
  assert(false, isNumeric(void 0));
  return assert(false, isNumeric(0 / 0));
};

makeButton = function makeButton(title, n, f) {
  var b, s;
  s = Math.floor(100 / n) + "%";
  //print title,s
  b = document.createElement('input');
  b.style.width = s;
  //b.style.fontSize = "100%"
  b.style.fontSize = '100%';
  b.style.webkitAppearance = "none";
  b.style.borderRadius = 0;
  b.style.padding = 0;
  b.type = 'button';
  b.value = title;
  b.onclick = f;
  return b;
};

makeDiv = function makeDiv(value) {
  var b;
  b = document.createElement('div');
  b.innerHTML = value;
  return b;
};

makeInput = function makeInput(title, value) {
  var readonly = arguments.length > 2 && arguments[2] !== undefined ? arguments[2] : false;

  var b;
  b = document.createElement('input');
  b.id = title;
  b.value = value;
  b.placeholder = title;
  b.style.fontSize = "100%";
  b.style.width = "100%";
  if (readonly) {
    b.setAttribute("readonly", true);
  }
  if (title === 'name') {
    b.autofocus = true;
  }
  //b.onfocus = "setTimeout(function () { this.select(); }, 50)"
  //b.onclick = "this.setSelectionRange(0, this.value.length)"
  return b;
};

precisionRound = function precisionRound(number, precision) {
  var factor;
  factor = Math.pow(10, precision);
  return Math.round(number * factor) / factor;
};

tests.precisionRound = function () {
  assert(3.1, precisionRound(3.1415, 1));
  assert(3, precisionRound(3.1415, 0));
  return assert(40, precisionRound(37.1415, -1));
};

prettyDate = function prettyDate(date) {
  var d, hh, m, mm, ss, y;
  y = date.getFullYear();
  m = ("0" + (date.getMonth() + 1)).slice(-2);
  d = ("0" + date.getDate()).slice(-2);
  hh = ("0" + date.getHours()).slice(-2);
  mm = ("0" + date.getMinutes()).slice(-2);
  ss = ("0" + date.getSeconds()).slice(-2);
  return y + "-" + m + "-" + d + " " + hh + ":" + mm + ":" + ss;
};

tests.prettyDate = function () {
  assert("2018-01-20 02:34:56", prettyDate(new Date(2018, 0, 20, 2, 34, 56)));
  return assert("2018-02-20 12:34:56", prettyDate(new Date(2018, 1, 20, 12, 34, 56)));
};

test = function test() {
  var e, key, start, tst;
  start = millis();
  print("test start");
  for (key in tests) {
    tst = tests[key];
    try {
      tst();
    } catch (error) {
      e = error;
      print('Click on tests.' + key + ' to see failing assert.');
      print(' first', e.actual);
      print('second', e.expected);
      print(e.stack);
    }
  }
  return print("test ready", round(millis() - start) + ' ms');
};
//# sourceMappingURL=utils.js.map
