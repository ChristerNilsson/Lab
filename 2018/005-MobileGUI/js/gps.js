"use strict";

// Generated by CoffeeScript 2.0.3
var locationUpdate, locationUpdateFail;

locationUpdate = function locationUpdate(position) {
  var eta, heading_12, lastObservation, p1, speed;
  //print 'locationUpdate', position
  p1 = {
    lat: position.coords.latitude,
    lng: position.coords.longitude,
    timestamp: position.timestamp // milliseconds since 1970
  };
  track.push(p1);
  heading_12 = calcHeading(p1, place);
  lastObservation = millis();
  texts[0] = Math.round(distance_on_geoid(p1, place)) + " m";
  texts[1] = Math.round(heading_12) + "\xB0";
  texts[2] = "" + track.length;
  if (track.length > 1) {
    speed = calcSpeed(start, millis(), track[0], _.last(track), place);
    eta = calcETA(start, millis(), track[0], _.last(track), place);
    texts[3] = precisionRound(speed, 1) + " m/s";
    return texts[6] = precisionRound(eta, 0) + " s";
  }
};

locationUpdateFail = function locationUpdateFail(error) {};

navigator.geolocation.watchPosition(locationUpdate, locationUpdateFail, {
  enableHighAccuracy: true,
  maximumAge: 30000,
  timeout: 27000
});
//# sourceMappingURL=gps.js.map
