"use strict";

// Generated by CoffeeScript 2.0.3
// https://cdn.rawgit.com/chrisveness/geodesy/v1.1.2/latlon-spherical.js
var calcHeading, distance_on_geoid, precisionRound, prettyDate;

distance_on_geoid = function distance_on_geoid(p1, p2) {
  var q1, q2;
  q1 = LatLon(p1.lat, p1.lng);
  q2 = LatLon(p2.lat, p2.lng);
  return q1.distanceTo(q2);
};

calcHeading = function calcHeading(p1, p2) {
  var q1, q2;
  q1 = LatLon(p1.lat, p1.lng);
  q2 = LatLon(p2.lat, p2.lng);
  return q1.bearingTo(q2);
};

precisionRound = function precisionRound(number, precision) {
  var factor;
  factor = Math.pow(10, precision);
  return Math.round(number * factor) / factor;
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
//# sourceMappingURL=utils.js.map
