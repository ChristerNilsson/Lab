"use strict";

var _slicedToArray = function () { function sliceIterator(arr, i) { var _arr = []; var _n = true; var _d = false; var _e = undefined; try { for (var _i = arr[Symbol.iterator](), _s; !(_n = (_s = _i.next()).done); _n = true) { _arr.push(_s.value); if (i && _arr.length === i) break; } } catch (err) { _d = true; _e = err; } finally { try { if (!_n && _i["return"]) _i["return"](); } finally { if (_d) throw _e; } } return _arr; } return function (arr, i) { if (Array.isArray(arr)) { return arr; } else if (Symbol.iterator in Object(arr)) { return sliceIterator(arr, i); } else { throw new TypeError("Invalid attempt to destructure non-iterable instance"); } }; }();

// Generated by CoffeeScript 2.3.2
var A, B, C, D, DATA, FILENAME, HEIGHT, SCALE, TRACKED, WIDTH, buttons, controls, corner, currLatLon, currentControl, cx, cy, drawButtons, drawControl, drawPoints, drawTrack, fetchData, gps, gpsLat, gpsLon, heading, hortal, img, lastLatLon, locationUpdate, locationUpdateFail, makeCorners, messages, myMousePressed, myround, points, position, preload, setup, show, spara, storeData, track, vercal, xdraw;

spara = function spara(lat, lon, x, y) {
  return { lat: lat, lon: lon, x: x, y: y };
};

// 2019-SommarN
A = spara(59.300716, 18.125680, 197, 278); // Lilla halvön

B = spara(59.299235, 18.169492, 4306, 367); // Kranglans väg/Östervägen

C = spara(59.285443, 18.124585, 236, 3082); // Ishockeyrink Mitten

D = spara(59.287806, 18.170784, 4525, 2454); // Mittenhus t v

FILENAME = '2019-SommarN.jpg';

controls = {
  1: [1830, 333],
  2: [1506, 521],
  3: [907, 711],
  4: [1193, 873],
  5: [472, 617],
  6: [228, 841],
  7: [672, 1013],
  8: [1125, 1196],
  9: [1430, 1290],
  10: [4361, 503],
  11: [4118, 1106],
  12: [3830, 640],
  13: [3192, 1133],
  14: [2664, 873],
  15: [2322, 1862],
  16: [4120, 2699],
  17: [4181, 3069],
  19: [3340, 2904],
  20: [2691, 2554],
  24: [3366, 3217],
  26: [390, 1935],
  27: [547, 2143],
  28: [1462, 2293],
  29: [1055, 2620],
  30: [371, 2502],
  31: [1090, 3104],
  32: [2250, 2750]
};

// 2019-SommarS
// A = spara 59.279157, 18.149313, 2599,676 # Mellanbron
// B = spara 59.275129, 18.169590, 4531,1328 # Ulvsjön Vändplan Huset
// C = spara 59.270072, 18.150229, 2763,2334 # Brotorpsbron
// D = spara 59.267894, 18.167087, 4339,2645 # Älta huset

// FILENAME = '2019-SommarS.jpg' 

// controls = 
// 	21: [4303,255]
// 	22: [4066,407]
// 	23: [3436,158]
// 	25: [3534,485]
// 	34: [1709,65]
// 	35: [1212,151]
// 	36: [2215,1008]
// 	37: [2571,1186]
// 	38: [2894,485]
// 	39: [3245,778]
// 	40: [4317,1003]
// 	41: [4303,685]
// 	42: [3868,1292]
// 	43: [3426,1281]
// 	44: [3536,1650]
// 	45: [4538,1763]
// 	46: [3926,2133]
// 	47: [3104,2025]
// 	48: [4256,2514]
// 	49: [3773,2493]
// 	50: [3231,2757]

//################
DATA = "gpsKarta";

WIDTH = null;

HEIGHT = null;

cx = 0;
cy = 0 // center (image coordinates)
;


SCALE = 1;

gps = null;

TRACKED = 5; // circles shows the player's position

position = null; // gps position (pixels)

track = []; // five latest GPS positions (pixels)

buttons = [];

points = []; // remembers e.g. car/bike position

img = null;

heading = 360;

messages = [];

lastLatLon = null;

currLatLon = null;

gpsLat = 0;
gpsLon = 0;


currentControl = "1";

preload = function preload() {
  return img = loadImage(FILENAME);
};

myround = function myround(x) {
  var dec = arguments.length > 1 && arguments[1] !== undefined ? arguments[1] : 6;

  x *= Math.pow(10, dec);
  x = round(x);
  return x / Math.pow(10, dec);
};

show = function show(prompt, p) {
  return print(prompt, "http://maps.google.com/maps?q=" + p.lat + "," + p.lon);
};

vercal = function vercal(a, b, y) {
  var lat, lon, x;
  x = map(y, a.y, b.y, a.x, b.x);
  lat = map(y, a.y, b.y, a.lat, b.lat);
  lon = map(y, a.y, b.y, a.lon, b.lon);
  return { lat: lat, lon: lon, x: x, y: y };
};

hortal = function hortal(a, b, x) {
  var lat, lon, y;
  y = map(x, a.x, b.x, a.y, b.y);
  lat = map(x, a.x, b.x, a.lat, b.lat);
  lon = map(x, a.x, b.x, a.lon, b.lon);
  return { lat: lat, lon: lon, x: x, y: y };
};

corner = function corner(a, b, c, d, x, y) {
  var lat, lon;
  lat = map(y, c.y, d.y, c.lat, d.lat);
  lon = map(x, a.x, b.x, a.lon, b.lon);
  return { lat: lat, lon: lon, x: x, y: y };
};

makeCorners = function makeCorners() {
  var ab0, ab1, ac0, ac1, bd0, bd1, cd0, cd1, ne, nw, se, sw;
  ac0 = vercal(A, C, 0); // beräkna x
  ac1 = vercal(A, C, HEIGHT);
  bd0 = vercal(B, D, 0);
  bd1 = vercal(B, D, HEIGHT);
  ab0 = hortal(A, B, 0); // beräkna y
  ab1 = hortal(A, B, WIDTH);
  cd0 = hortal(C, D, 0);
  cd1 = hortal(C, D, WIDTH);
  nw = corner(ac0, bd0, ab0, cd0, 0, 0); // beräkna hörnen
  ne = corner(ac0, bd0, ab1, cd1, WIDTH, 0);
  se = corner(ac1, bd1, ab1, cd1, WIDTH, HEIGHT);
  sw = corner(ac1, bd1, ab0, cd0, 0, HEIGHT);
  return gps = new GPS(nw, ne, se, sw, WIDTH, HEIGHT);
};

locationUpdate = function locationUpdate(p) {
  gpsLat = p.coords.latitude;
  gpsLon = p.coords.longitude;
  lastLatLon = currLatLon;
  currLatLon = LatLon(gpsLat, gpsLon);
  position = gps.gps2bmp(gpsLat, gpsLon);
  if (lastLatLon !== null && currLatLon !== null) {
    heading = lastLatLon.bearingTo(currLatLon);
    if (isNaN(heading)) {
      heading = null;
    }
  } else {
    heading = null;
  }
  track.push(position);
  if (track.length > TRACKED) {
    track.shift();
  }
  xdraw();
  return position;
};

locationUpdateFail = function locationUpdateFail(error) {
  if (error.code === error.PERMISSION_DENIED) {
    return messages = ['Check location permissions'];
  }
};

storeData = function storeData() {
  return localStorage[DATA] = JSON.stringify(points);
};

fetchData = function fetchData() {
  if (localStorage[DATA]) {
    return points = JSON.parse(localStorage[DATA]);
  }
};

setup = function setup() {
  var x, x1, x2, y, y1, y2;
  createCanvas(windowWidth, windowHeight);
  WIDTH = img.width;
  HEIGHT = img.height;
  SCALE = 1;
  cx = width;
  cy = height;

  fetchData();
  x = width / 2;
  y = height / 2;
  x1 = 100;
  x2 = width - 100;
  y1 = 100;
  y2 = height - 100;
  buttons.push(new Button('S', x1, y1, function () {
    points.push(position);
    return storeData();
  }));
  buttons.push(new Button('U', x, y1, function () {
    return cy -= 0.25 * height / SCALE;
  }));
  buttons.push(new Button('0', x2, y1, function () {
    if (points.length > 0) {
      points.pop();
      return storeData();
    }
  }));
  buttons.push(new Button('L', x1, y, function () {
    return cx -= 0.25 * width / SCALE;
  }));
  buttons.push(new Button(' ', x, y, function () {
    var _position, _position2;

    return _position = position, _position2 = _slicedToArray(_position, 2), cx = _position2[0], cy = _position2[1], _position;
  }));
  buttons.push(new Button('R', x2, y, function () {
    return cx += 0.25 * width / SCALE;
  }));
  buttons.push(new Button('-', x1, y2, function () {
    if (SCALE > 0.5) {
      return SCALE /= 1.2;
    }
  }));
  buttons.push(new Button('D', x, y2, function () {
    return cy += 0.25 * height / SCALE;
  }));
  buttons.push(new Button('+', x2, y2, function () {
    return SCALE *= 1.2;
  }));
  makeCorners();
  position = [WIDTH / 2, HEIGHT / 2];
  navigator.geolocation.watchPosition(locationUpdate, locationUpdateFail, {
    enableHighAccuracy: true,
    maximumAge: 30000,
    timeout: 27000
  });
  xdraw();
  return addEventListener('touchstart', function (evt) {
    var mx, my, touch, touches;
    touches = evt.changedTouches;
    touch = touches[touches.length - 1];
    mx = touch.pageX;
    my = touch.pageY;
    return myMousePressed(mx, my);
  });
};

drawTrack = function drawTrack() {
  var i, j, len, x, y;
  push();
  fc();
  sw(4);
  sc(0); // BLACK
  translate(width / 2, height / 2);
  scale(SCALE);
  for (i = j = 0, len = track.length; j < len; i = ++j) {
    var _track$i = _slicedToArray(track[i], 2);

    x = _track$i[0];
    y = _track$i[1];

    circle(x - cx, y - cy, 10 * (track.length - i));
  }
  return pop();
};

drawPoints = function drawPoints() {
  var i, j, len, x, y;
  push();
  sc();
  fc(1, 0, 0, 0.5); // RED
  translate(width / 2, height / 2);
  scale(SCALE);
  for (i = j = 0, len = points.length; j < len; i = ++j) {
    var _points$i = _slicedToArray(points[i], 2);

    x = _points$i[0];
    y = _points$i[1];

    circle(x - cx, y - cy, 20);
  }
  return pop();
};

drawControl = function drawControl() {
  var control, lat, lon, x, y;
  control = controls[currentControl];
  x = control[0];
  y = control[1];

  // latLon2 = LatLon lat,lon
  // latLon1 = LatLon gpsLat,gpsLon
  // distance = latLon1.distanceTo latLon2
  // bearing = latLon1.bearingTo latLon2
  // buttons[3].prompt = currentControl
  // buttons[4].prompt = int bearing

  // if heading == null
  // 	buttons[1].prompt = ''
  // 	buttons[7].prompt = ''
  // else
  // 	buttons[1].prompt = int heading
  // 	buttons[7].prompt = int bearing - heading
  // if distance == null
  // 	buttons[5].prompt = ''
  // else
  // 	buttons[5].prompt = int distance
  var _gps$bmp2gps = gps.bmp2gps(x, y);

  var _gps$bmp2gps2 = _slicedToArray(_gps$bmp2gps, 2);

  lat = _gps$bmp2gps2[0];
  lon = _gps$bmp2gps2[1];
  buttons[1].prompt = gpsLat;
  push();
  sc();
  fc(0, 0, 0, 0.5);
  translate(width / 2, height / 2);
  scale(SCALE);
  circle(x - cx, y - cy, 75);
  return pop();
};

drawButtons = function drawButtons() {
  var button, j, len, results;
  buttons[2].prompt = points.length;
  results = [];
  for (j = 0, len = buttons.length; j < len; j++) {
    button = buttons[j];
    results.push(button.draw());
  }
  return results;
};

xdraw = function xdraw() {
  var i, j, len, message, results;
  bg(1, 1, 0);
  fc();
  image(img, 0, 0, width, height, cx - width / SCALE / 2, cy - height / SCALE / 2, width / SCALE, height / SCALE);
  drawTrack();
  drawPoints();
  drawControl();
  drawButtons();
  textSize(50);
  results = [];
  for (i = j = 0, len = messages.length; j < len; i = ++j) {
    message = messages[i];
    results.push(text(message, width / 2, 50 * (i + 1)));
  }
  return results;
};

myMousePressed = function myMousePressed(mx, my) {
  var arr, button, closestControl, control, d, j, key, len;
  for (j = 0, len = buttons.length; j < len; j++) {
    button = buttons[j];
    if (button.contains(mx, my)) {
      button.click();
      xdraw();
      return;
    }
  }
  arr = function () {
    var results;
    results = [];
    for (key in controls) {
      control = controls[key];
      results.push([dist(cx - width / SCALE / 2 + mx / SCALE, cy - height / SCALE / 2 + my / SCALE, control[0], control[1]), key]);
    }
    return results;
  }();
  closestControl = _.min(arr, function (item) {
    return item[0];
  });
  var _closestControl = closestControl;

  var _closestControl2 = _slicedToArray(_closestControl, 2);

  d = _closestControl2[0];
  key = _closestControl2[1];

  if (d < 85) {
    currentControl = key;
    return xdraw();
  }
};

//mousePressed = -> myMousePressed mouseX,mouseY
//# sourceMappingURL=sketch.js.map
