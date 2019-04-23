'use strict';

var _slicedToArray = function () { function sliceIterator(arr, i) { var _arr = []; var _n = true; var _d = false; var _e = undefined; try { for (var _i = arr[Symbol.iterator](), _s; !(_n = (_s = _i.next()).done); _n = true) { _arr.push(_s.value); if (i && _arr.length === i) break; } } catch (err) { _d = true; _e = err; } finally { try { if (!_n && _i["return"]) _i["return"](); } finally { if (_d) throw _e; } } return _arr; } return function (arr, i) { if (Array.isArray(arr)) { return arr; } else if (Symbol.iterator in Object(arr)) { return sliceIterator(arr, i); } else { throw new TypeError("Invalid attempt to destructure non-iterable instance"); } }; }();

// Generated by CoffeeScript 2.3.2
var A, B, C, D, DATA, FILENAME, HEIGHT, SCALE, TRACKED, WIDTH, bearing, buttons, corner, cx, cy, drawButtons, drawCompass, drawPoints, drawTrack, fetchData, gps, hortal, img, locationUpdate, locationUpdateFail, makeCorners, messages, myround, points, position, preload, setup, setupCompass, show, spara, storeData, test, track, vercal, xdraw;

FILENAME = '2019-Sommar.jpg';

spara = function spara(lat, lon, x, y) {
  return { lat: lat, lon: lon, x: x, y: y };
};

// Vinterpasset 2019
// A = spara 59.285607,18.150687, 178,442   # Norra brofästet
// B = spara 59.284808,18.180402, 3222,338  # Shooting Range, mitt i huset
// C = spara 59.270078,18.150334, 359,3488  # Östra brofästet
// D = spara 59.269380,18.169612, 2303,3494 # Kolarängsvägen/Klisätravägen

// Sommarpasset 2019
// A = spara 59.300751, 18.125673, 223, 168  # Lilla halvön
// B = spara 59.300588, 18.163454, 2680, 126  # Huset Hästhagen
// C = spara 59.281980, 18.124751, 311, 2598  # Vägkorsning
// D = spara 59.269734, 18.167462, 3165, 3915 # Vändplan Klisätravägen
A = spara(59.300636, 18.125728, 126, 258); // Lilla halvön

B = spara(59.299235, 18.169492, 3048, 174); // Kranglans väg/Östervägen

C = spara(59.281980, 18.124749, 276, 2700); // Vägkorsning

D = spara(59.275129, 18.169582, 3414, 3308); // Huset Vändplan Ulvsjön

DATA = "gpsKarta";

WIDTH = null;

HEIGHT = null;

cx = 0;
cy = 0 // center (image coordinates)
;


SCALE = 1;

// released = true # to make Android work
gps = null;

TRACKED = 5; // circles shows the player's position

position = null; // gps position (pixels)

track = []; // five latest GPS positions (pixels)

buttons = [];

points = []; // remembers e.g. car/bike position

img = null;

bearing = 360;

messages = [];

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
  return print(prompt, 'http://maps.google.com/maps?q=' + p.lat + ',' + p.lon);
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
  var lat, lon;
  //print 
  lat = p.coords.latitude;
  lon = p.coords.longitude; //+0.000500
  //print 'locationUpdate',lat,lon,gps
  position = gps.gps2bmp(lat, lon);
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

setupCompass = function setupCompass() {
  return window.addEventListener("deviceorientation", function (event) {
    bearing = round(event.alpha);
    return xdraw();
  });
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
  cx = WIDTH / 2;
  cy = HEIGHT / 2;

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
    return cy -= 0.5 * height / SCALE;
  }));
  buttons.push(new Button('0', x2, y1, function () {
    if (points.length > 0) {
      points.pop();
      return storeData();
    }
  }));
  buttons.push(new Button('L', x1, y, function () {
    return cx -= 0.5 * width / SCALE;
  }));
  buttons.push(new Button('C', x, y, function () {
    var _position, _position2;

    return _position = position, _position2 = _slicedToArray(_position, 2), cx = _position2[0], cy = _position2[1], _position;
  }));
  buttons.push(new Button('R', x2, y, function () {
    return cx += 0.5 * width / SCALE;
  }));
  buttons.push(new Button('D', x, y2, function () {
    return cy += 0.5 * height / SCALE;
  }));
  buttons.push(new Button('-', x1, y2, function () {
    return SCALE /= 1.5;
  }));
  buttons.push(new Button('+', x2, y2, function () {
    return SCALE *= 1.5;
  }));
  makeCorners();
  position = [WIDTH / 2, HEIGHT / 2];
  navigator.geolocation.watchPosition(locationUpdate, locationUpdateFail, {
    enableHighAccuracy: true,
    maximumAge: 30000,
    timeout: 27000
  });
  setupCompass();
  xdraw();
  return addEventListener('touchstart', function (evt) {
    var button, j, len, touch, touches;
    touches = evt.changedTouches;
    touch = touches[touches.length - 1];
    for (j = 0, len = buttons.length; j < len; j++) {
      button = buttons[j];
      if (button.contains(touch.pageX, touch.pageY)) {
        button.click();
      }
    }
    return xdraw();
  });
};

// test 
// 	lat: 59.279170
// 	lon: 18.149327 # +0.000500
// 	x: 1932
// 	y: 2923

// test 
// 	lat:59.285496
// 	lon: 18.150525 # +0.000500
// 	x: 1978
// 	y: 2074
// # test A
// # test B
// test C
// test D
test = function test(_ref) {
  var lat = _ref.lat,
      lon = _ref.lon,
      x = _ref.x,
      y = _ref.y;

  var hash;
  print('test');
  hash = {
    coords: {
      latitude: lat,
      longitude: lon
    }
  };
  return print(x, y, locationUpdate(hash));
};

drawTrack = function drawTrack() {
  var i, j, len, x, y;
  push();
  fc();
  sw(2);
  sc(1, 1, 0); // YELLOW
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

drawButtons = function drawButtons() {
  var button, j, len, results;
  buttons[2].prompt = points.length;
  buttons[4].prompt = 360 - bearing;
  results = [];
  for (j = 0, len = buttons.length; j < len; j++) {
    button = buttons[j];
    results.push(button.draw());
  }
  return results;
};

drawCompass = function drawCompass() {
  push();
  strokeCap(SQUARE);
  translate(width / 2, height / 2);
  rotate(radians(bearing));
  sw(10);
  sc(1, 0, 0);
  line(0, -100, 0, -150);
  sc(1);
  line(0, 100, 0, 150);
  return pop();
};

xdraw = function xdraw() {
  var i, j, len, message, results;
  bg(0);
  fc();
  image(img, 0, 0, width, height, cx - width / SCALE / 2, cy - height / SCALE / 2, width / SCALE, height / SCALE);
  drawTrack();
  drawPoints();
  drawCompass();
  drawButtons();
  textSize(50);
  results = [];
  for (i = j = 0, len = messages.length; j < len; i = ++j) {
    message = messages[i];
    results.push(text(message, width / 2, 50 * (i + 1)));
  }
  return results;
};

// mousePressed = -> # For use on PC during development only.
// 	x = cx + mouseX/SCALE - width/2
// 	y = cy + mouseY/SCALE - height/2
// 	print {mouseX,mouseY,cx,cy,SCALE,x,y}
// 	print gps.bmp2gps mouseX,mouseY
// 	for button in buttons
// 		if button.contains mouseX,mouseY then button.click()
// 	xdraw()
//# sourceMappingURL=sketch.js.map
