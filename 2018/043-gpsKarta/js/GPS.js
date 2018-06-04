"use strict";

var _slicedToArray = function () { function sliceIterator(arr, i) { var _arr = []; var _n = true; var _d = false; var _e = undefined; try { for (var _i = arr[Symbol.iterator](), _s; !(_n = (_s = _i.next()).done); _n = true) { _arr.push(_s.value); if (i && _arr.length === i) break; } } catch (err) { _d = true; _e = err; } finally { try { if (!_n && _i["return"]) _i["return"](); } finally { if (_d) throw _e; } } return _arr; } return function (arr, i) { if (Array.isArray(arr)) { return arr; } else if (Symbol.iterator in Object(arr)) { return sliceIterator(arr, i); } else { throw new TypeError("Invalid attempt to destructure non-iterable instance"); } }; }();

var _createClass = function () { function defineProperties(target, props) { for (var i = 0; i < props.length; i++) { var descriptor = props[i]; descriptor.enumerable = descriptor.enumerable || false; descriptor.configurable = true; if ("value" in descriptor) descriptor.writable = true; Object.defineProperty(target, descriptor.key, descriptor); } } return function (Constructor, protoProps, staticProps) { if (protoProps) defineProperties(Constructor.prototype, protoProps); if (staticProps) defineProperties(Constructor, staticProps); return Constructor; }; }();

function _classCallCheck(instance, Constructor) { if (!(instance instanceof Constructor)) { throw new TypeError("Cannot call a class as a function"); } }

// Generated by CoffeeScript 2.0.3
var GPS;

GPS = function () {
  // hanterar GPS konvertering
  function GPS(N, O, P, Q, w, h) {
    _classCallCheck(this, GPS);

    this.N = N;
    this.O = O;
    this.P = P;
    this.Q = Q;
    this.w = w;
    this.h = h;
  }

  //@xo = @w/2
  //@yo = @h/2
  // p0 = LatLon @lat,@lon
  // p1 = p0.destinationPoint @h/2, 0
  // @lat2 = p1.lat
  // p2 = p0.destinationPoint @w/2, 90
  // @lon2 = p2.lon
  // p3 = p0.destinationPoint @h/2, 180
  // @lat1 = p3.lat
  // p4 = p0.destinationPoint @w/2, 270
  // @lon1 = p4.lon
  // toXY : (lat,lon) ->
  // 	x = @xo + SCALE * map lon, @lon1, @lon2, -@w/2, @w/2
  // 	y = @yo + SCALE * map lat, @lat2, @lat1, -@h/2, @h/2 # turned
  // 	{x,y}
  // toWGS84 : (x,y) -> # not used
  // 	lon = map (x-xo)/SCALE, -@w/2, @w/2, @lon1, @lon2
  // 	lat = map (y-yo)/SCALE, -@h/2, @h/2, @lat1, @lat2
  // 	{lat,lon}


  _createClass(GPS, [{
    key: "calcLon",
    value: function calcLon(mlat, mlon, a, b) {
      var lat, lon, x, y;
      x = map(mlon, a.lon, b.lon, a.x, b.x);
      y = map(mlon, a.lon, b.lon, a.y, b.y);
      lat = map(mlon, a.lon, b.lon, a.lat, b.lat);
      lon = mlon;
      return { lat: lat, lon: lon, x: x, y: y };
    }
  }, {
    key: "calcLat",
    value: function calcLat(mlat, mlon, a, b) {
      var lat, lon, x, y;
      x = map(mlat, a.lat, b.lat, a.x, b.x);
      y = map(mlat, a.lat, b.lat, a.y, b.y);
      lat = mlat;
      lon = map(mlat, a.lat, b.lat, a.lon, b.lon);
      return { lat: lat, lon: lon, x: x, y: y };
    }
  }, {
    key: "gps2bmp",
    value: function gps2bmp(mlat, mlon) {
      var q1, q2, x, y;
      q1 = this.calcLon(mlat, mlon, this.N, this.O);
      q2 = this.calcLon(mlat, mlon, this.Q, this.P);
      x = map(mlat, q1.lat, q2.lat, q1.x, q2.x);
      y = map(mlat, q1.lat, q2.lat, q1.y, q2.y);
      // q3 = calcLat mlat,mlon,N,Q
      // q4 = calcLat mlat,mlon,O,P
      // x2 = map mlon, q3.lon,q4.lon, q3.x, q4.x
      // y2 = map mlon, q3.lon,q4.lon, q3.y, q4.y
      return { x: x, y: y };
    }

    //[int(x1),int(y1)]

  }, {
    key: "check_gps2bmp",
    value: function check_gps2bmp(p, error) {
      var x, y;

      var _gps2bmp = gps2bmp(p.lat, p.lon);

      var _gps2bmp2 = _slicedToArray(_gps2bmp, 2);

      x = _gps2bmp2[0];
      y = _gps2bmp2[1];

      return assert(error, [x - p.x, y - p.y]);
    }
  }]);

  return GPS;
}();
//# sourceMappingURL=GPS.js.map
