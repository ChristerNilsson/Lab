'use strict';

// Generated by CoffeeScript 2.0.3
var bearing,
    calcColor,
    calcDelta,
    draw,
    drawCompass,
    drawHouse,
    drawNeedle,
    drawTexts,
    h,
    heading_12,
    lastObservation,
    locationUpdate,
    locationUpdateFail,
    mousePressed,
    p1,
    place,
    placeIndex,
    places,
    setup,
    texts,
    track,
    w,
    modulo = function modulo(a, b) {
  return (+a % (b = +b) + b) % b;
};

places = [];

places.push({
  name: 'Bagarmossen Sushi',
  lat: 59.277560,
  lng: 18.132739
});

places.push({
  name: 'Bagarmossen T',
  lat: 59.276264,
  lng: 18.131465
});

places.push({
  name: 'Björkhagens Golfklubb',
  lat: 59.284052,
  lng: 18.145925
});

places.push({
  name: 'Björkhagen T',
  lat: 59.291114,
  lng: 18.115521
});

places.push({
  name: 'Brotorpsbron',
  lat: 59.270067,
  lng: 18.150236
});

places.push({
  name: 'Brotorpsstugan',
  lat: 59.270542,
  lng: 18.148473
});

places.push({
  name: 'Kärrtorp T',
  lat: 59.284505,
  lng: 18.114477
});

places.push({
  name: 'Hellasgården',
  lat: 59.289813,
  lng: 18.160577
});

places.push({
  name: 'Hem',
  lat: 59.265205,
  lng: 18.132735
});

places.push({
  name: 'Parkeringsgran',
  lat: 59.274916,
  lng: 18.161353
});

places.push({
  name: 'Pers badställe',
  lat: 59.289571,
  lng: 18.170767
});

places.push({
  name: 'Skarpnäck T',
  lat: 59.266432,
  lng: 18.133093
});

places.push({
  name: 'Söderbysjön N Bron',
  lat: 59.285500,
  lng: 18.150542
});

places.push({
  name: 'Söderbysjön S Bron',
  lat: 59.279155,
  lng: 18.149318
});

places.push({
  name: 'Ulvsjön, Udden',
  lat: 59.277103,
  lng: 18.164897
});

placeIndex = 0;

place = places[placeIndex];

w = null;

h = null;

track = [];

bearing = 0;

heading_12 = 0;

lastObservation = 0;

p1 = null;

texts = ['', '', '', '', '', '', '', '', '', '', '', ''];

locationUpdate = function locationUpdate(position) {
  var ds, dt, p0;
  p1 = {
    lat: position.coords.latitude,
    lng: position.coords.longitude,
    accuracy: position.coords.accuracy,
    timestamp: position.timestamp / 1000
  };
  track.push(p1);
  heading_12 = calcHeading(p1, place);
  lastObservation = millis();
  texts[0] = precisionRound(place.lat, 6);
  texts[1] = precisionRound(place.lng, 6);
  texts[3] = '' + track.length;
  texts[6] = Math.round(p1.accuracy) + ' m';
  texts[8] = Math.round(heading_12) + '\xB0';
  //texts[3] = 'nospeed' #p1.spd
  //texts[4] = p1.timestamp
  texts[10] = Math.round(distance_on_geoid(p1, place)) + ' m';
  if (track.length >= 2) {
    p0 = track[track.length - 2];
    dt = p1.timestamp - p0.timestamp;
    ds = distance_on_geoid(p0, p1);
    texts[2] = precisionRound(dt, 3) + ' s';
    texts[4] = Math.round(ds) + ' m';
    texts[5] = precisionRound(ds / dt, 1) + ' m/s';
    return texts[9] = Math.round(calcHeading(p0, p1)) + '\xB0';
  }
};

locationUpdateFail = function locationUpdateFail(error) {
  texts[0] = "n/a";
  return texts[1] = "n/a";
};

navigator.geolocation.watchPosition(locationUpdate, locationUpdateFail, {
  enableHighAccuracy: true,
  maximumAge: 30000,
  timeout: 27000
});

calcDelta = function calcDelta(delta) {
  if (delta < -180) {
    delta += 360;
  }
  if (delta > +180) {
    delta -= 360;
  }
  return delta;
};

// Visa vinkelavvikelse med färgton. 
// -180 = black
//  -90 = red
//    0 = white
//   90 = green 
//  180 = black
calcColor = function calcColor(delta) {
  var black, green, red, res, white;
  // -180 <= delta <= 180
  white = color(255, 255, 255);
  green = color(0, 255, 0);
  black = color(0, 0, 0);
  red = color(255, 0, 0);
  if (-180 <= delta && delta < -90) {
    res = lerpColor(black, red, (delta + 180) / 90);
  } else if (-90 <= delta && delta < 0) {
    res = lerpColor(red, white, (delta + 90) / 90);
  } else if (0 <= delta && delta < 90) {
    res = lerpColor(white, green, (delta + 0) / 90);
  } else if (90 <= delta && delta <= 180) {
    res = lerpColor(green, black, (delta - 90) / 90);
  } else {
    res = color(255, 255, 0, 255); // error 
  }
  return res.levels;
};

setup = function setup() {
  createCanvas(windowWidth, windowHeight);
  w = windowWidth;
  h = windowHeight;
  window.addEventListener("deviceorientation", function (event) {
    var delta;
    bearing = event.alpha;
    if (typeof event.webkitCompassHeading !== "undefined") {
      bearing = event.webkitCompassHeading; // iOS non-standard
    }
    texts[7] = Math.round((millis() - lastObservation) / 1000) + ' s';
    texts[9] = Math.round(bearing) + '\xB0';
    delta = calcDelta(heading_12 - bearing);
    return texts[11] = Math.round(delta) + '\xB0';
  });
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

drawHouse = function drawHouse(radius) {
  var dx, i, j, k, len, len1, ref, ref1;
  fc(1);
  sc();
  textAlign(CENTER, CENTER);
  ref = range(4);
  for (j = 0, len = ref.length; j < len; j++) {
    i = ref[j];
    push();
    translate(0, 1.3 * radius);
    rd(180);
    text("SWNE"[i], 0, 0);
    pop();
    rd(90);
  }
  push();
  dx = 0.02 * w;
  sc(0);
  sw(1);
  ref1 = range(-3, 4);
  for (k = 0, len1 = ref1.length; k < len1; k++) {
    i = ref1[k];
    line(i * 4 * dx, -1.1 * radius, i * 4 * dx, 1.1 * radius);
  }
  sc(1);
  sw(5);
  fc();
  circle(0, 0, 1.1 * radius);
  sc(0);
  sw(1);
  fc(0.5);
  rect(-dx, -0.9 * radius, 2 * dx, 1.9 * radius);
  triangle(-1.5 * dx, -0.9 * radius, 0, -1.05 * radius, 1.5 * dx, -0.9 * radius);
  return pop();
};

drawNeedle = function drawNeedle(radius) {
  try {
    rd(-bearing);
    sc(0);
    sw(0.025 * h);
    line(0, -0.95 * radius, 0, 0.95 * radius);
    sc(1);
    sw(0.02 * h);
    line(0, 0, 0, 0.95 * radius);
    sc(1, 0, 0);
    line(0, 0, 0, -0.95 * radius);
    sw(0.025 * h);
    sc(0);
    return point(0, 0);
  } catch (error1) {}
};

drawCompass = function drawCompass() {
  var delta, radius;
  radius = 0.25 * w;
  delta = calcDelta(heading_12 - bearing);
  fill(calcColor(delta));
  sw(5);
  sc(1);
  push();
  translate(0.5 * w, 0.7 * h);
  circle(0, 0, 1.1 * radius);
  push();
  rd(-heading_12);
  drawHouse(radius);
  pop();
  textSize(0.08 * h);
  fc(1);
  sc();
  textAlign(CENTER);
  text(texts[10], 0, -2 * radius);
  text(texts[8], 0, -1.6 * radius);
  drawNeedle(radius);
  return pop();
};

drawTexts = function drawTexts() {
  var d, i, j, len, t, x, y;
  fc(0.5);
  d = h / 12;
  sc(0.5);
  sw(1);
  textSize(0.08 * h);
  for (i = j = 0, len = texts.length; j < len; i = ++j) {
    t = texts[i];
    x = i % 2 * w;
    if (i % 2 === 0) {
      textAlign(LEFT);
    } else {
      textAlign(RIGHT);
    }
    y = d * Math.floor(i / 2);
    if (i !== 8 && i !== 9 && i !== 10 && i !== 11) {
      text(t, x, 2 * d + y);
    }
  }
  textAlign(LEFT);
  return text(placeIndex + ' ' + place.name, 0, d);
};

draw = function draw() {
  bg(0);
  drawCompass();
  return drawTexts();
};

mousePressed = function mousePressed() {
  var p;
  if (mouseY > h / 2 && track.length > 0) {
    p = track[track.length - 1];
    places.push({
      name: prettyDate(new Date()),
      lat: p.lat,
      lng: p.lng
    });
    placeIndex = places.length - 1;
  } else if (mouseX > w / 2) {
    placeIndex++;
  } else {
    placeIndex--;
  }
  placeIndex = modulo(placeIndex, places.length);
  place = places[placeIndex];
  texts = ['', '', '', '', '', '', '', '', '', '', '', ''];
  texts[0] = precisionRound(place.lat, 6);
  return texts[1] = precisionRound(place.lng, 6);
};
//# sourceMappingURL=sketch.js.map
