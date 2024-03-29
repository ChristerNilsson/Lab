// Generated by CoffeeScript 1.11.1
var HALF, SIDE, draw, setup;

SIDE = 300;

HALF = SIDE / 2;

setup = function() {
  return createCanvas(3 * SIDE, 3 * SIDE);
};

draw = function() {
  var a, b, d, ref, ref1, ref2, ref3, sq1, square, w, x0, x1, x2, x3, y0, y1, y2, y3;
  square = function(x, y) {
    var i, j, len, ref;
    push();
    translate(x, y);
    ref = range(4);
    for (j = 0, len = ref.length; j < len; j++) {
      i = ref[j];
      rotate(radians(90));
      quad(x0, y0, x1, y1, x2, y2, x3, y3);
    }
    return pop();
  };
  sq1 = function(w, c) {
    sw(w);
    sc(c);
    square(-HALF - d, -HALF + d);
    square(HALF - d, -HALF - d);
    square(HALF + d, HALF - d);
    return square(-HALF + d, HALF + d);
  };
  bg(1);
  fc();
  a = SIDE / (2 + sqrt(2));
  b = SIDE - a;
  ref = [-HALF, -HALF], x0 = ref[0], y0 = ref[1];
  ref1 = [a - HALF, -HALF], x1 = ref1[0], y1 = ref1[1];
  ref2 = [a + a / sqrt(2) - HALF, a / sqrt(2) - HALF], x2 = ref2[0], y2 = ref2[1];
  ref3 = [-HALF, b - HALF], x3 = ref3[0], y3 = ref3[1];
  d = (sqrt(2) - 1) * HALF;
  translate(width / 2, height / 2);
  w = map(mouseX, 0, width, 1, 20);
  sq1(w, 0);
  return sq1(w - 2, 1);
};

//# sourceMappingURL=data:application/json;base64,eyJ2ZXJzaW9uIjozLCJmaWxlIjoic2tldGNoLmpzIiwic291cmNlUm9vdCI6Ii4uIiwic291cmNlcyI6WyJjb2ZmZWVcXHNrZXRjaC5jb2ZmZWUiXSwibmFtZXMiOltdLCJtYXBwaW5ncyI6IjtBQUVBLElBQUE7O0FBQUEsSUFBQSxHQUFPOztBQUNQLElBQUEsR0FBTyxJQUFBLEdBQUs7O0FBRVosS0FBQSxHQUFRLFNBQUE7U0FBRyxZQUFBLENBQWEsQ0FBQSxHQUFFLElBQWYsRUFBb0IsQ0FBQSxHQUFFLElBQXRCO0FBQUg7O0FBRVIsSUFBQSxHQUFPLFNBQUE7QUFDTixNQUFBO0VBQUEsTUFBQSxHQUFTLFNBQUMsQ0FBRCxFQUFHLENBQUg7QUFDUixRQUFBO0lBQUEsSUFBQSxDQUFBO0lBQ0EsU0FBQSxDQUFVLENBQVYsRUFBWSxDQUFaO0FBQ0E7QUFBQSxTQUFBLHFDQUFBOztNQUNDLE1BQUEsQ0FBTyxPQUFBLENBQVEsRUFBUixDQUFQO01BQ0EsSUFBQSxDQUFLLEVBQUwsRUFBUSxFQUFSLEVBQVcsRUFBWCxFQUFjLEVBQWQsRUFBaUIsRUFBakIsRUFBb0IsRUFBcEIsRUFBdUIsRUFBdkIsRUFBMEIsRUFBMUI7QUFGRDtXQUdBLEdBQUEsQ0FBQTtFQU5RO0VBT1QsR0FBQSxHQUFNLFNBQUMsQ0FBRCxFQUFHLENBQUg7SUFDTCxFQUFBLENBQUcsQ0FBSDtJQUNBLEVBQUEsQ0FBRyxDQUFIO0lBQ0EsTUFBQSxDQUFPLENBQUMsSUFBRCxHQUFNLENBQWIsRUFBZSxDQUFDLElBQUQsR0FBTSxDQUFyQjtJQUNBLE1BQUEsQ0FBUSxJQUFBLEdBQUssQ0FBYixFQUFlLENBQUMsSUFBRCxHQUFNLENBQXJCO0lBQ0EsTUFBQSxDQUFRLElBQUEsR0FBSyxDQUFiLEVBQWdCLElBQUEsR0FBSyxDQUFyQjtXQUNBLE1BQUEsQ0FBTyxDQUFDLElBQUQsR0FBTSxDQUFiLEVBQWdCLElBQUEsR0FBSyxDQUFyQjtFQU5LO0VBUU4sRUFBQSxDQUFHLENBQUg7RUFDQSxFQUFBLENBQUE7RUFFQSxDQUFBLEdBQUksSUFBQSxHQUFLLENBQUMsQ0FBQSxHQUFFLElBQUEsQ0FBSyxDQUFMLENBQUg7RUFDVCxDQUFBLEdBQUksSUFBQSxHQUFLO0VBRVQsTUFBVSxDQUFjLENBQUMsSUFBZixFQUE4QixDQUFDLElBQS9CLENBQVYsRUFBQyxXQUFELEVBQUk7RUFDSixPQUFVLENBQWEsQ0FBQSxHQUFFLElBQWYsRUFBOEIsQ0FBQyxJQUEvQixDQUFWLEVBQUMsWUFBRCxFQUFJO0VBQ0osT0FBVSxDQUFDLENBQUEsR0FBSSxDQUFBLEdBQUUsSUFBQSxDQUFLLENBQUwsQ0FBTixHQUFjLElBQWYsRUFBcUIsQ0FBQSxHQUFFLElBQUEsQ0FBSyxDQUFMLENBQUYsR0FBVSxJQUEvQixDQUFWLEVBQUMsWUFBRCxFQUFJO0VBQ0osT0FBVSxDQUFjLENBQUMsSUFBZixFQUE2QixDQUFBLEdBQUUsSUFBL0IsQ0FBVixFQUFDLFlBQUQsRUFBSTtFQUVKLENBQUEsR0FBSSxDQUFDLElBQUEsQ0FBSyxDQUFMLENBQUEsR0FBUSxDQUFULENBQUEsR0FBWTtFQUVoQixTQUFBLENBQVUsS0FBQSxHQUFNLENBQWhCLEVBQWtCLE1BQUEsR0FBTyxDQUF6QjtFQUNBLENBQUEsR0FBSSxHQUFBLENBQUksTUFBSixFQUFXLENBQVgsRUFBYSxLQUFiLEVBQW1CLENBQW5CLEVBQXFCLEVBQXJCO0VBQ0osR0FBQSxDQUFJLENBQUosRUFBTSxDQUFOO1NBQ0EsR0FBQSxDQUFJLENBQUEsR0FBRSxDQUFOLEVBQVEsQ0FBUjtBQWhDTSIsInNvdXJjZXNDb250ZW50IjpbIiMgIGh0dHA6Ly9zY3J1c3MuY29tL2Jsb2cvMjAxNy8wOC8wNS9hLXF1aWV0LW9uZS9cclxuXHJcblNJREUgPSAzMDBcclxuSEFMRiA9IFNJREUvMlxyXG5cclxuc2V0dXAgPSAtPiBjcmVhdGVDYW52YXMgMypTSURFLDMqU0lERVxyXG5cclxuZHJhdyA9IC0+XHJcblx0c3F1YXJlID0gKHgseSkgLT5cclxuXHRcdHB1c2goKVxyXG5cdFx0dHJhbnNsYXRlIHgseVxyXG5cdFx0Zm9yIGkgaW4gcmFuZ2UgNFxyXG5cdFx0XHRyb3RhdGUgcmFkaWFucyA5MFxyXG5cdFx0XHRxdWFkIHgwLHkwLHgxLHkxLHgyLHkyLHgzLHkzXHJcblx0XHRwb3AoKVxyXG5cdHNxMSA9ICh3LGMpIC0+XHJcblx0XHRzdyB3XHJcblx0XHRzYyBjXHJcblx0XHRzcXVhcmUgLUhBTEYtZCwtSEFMRitkXHJcblx0XHRzcXVhcmUgIEhBTEYtZCwtSEFMRi1kXHJcblx0XHRzcXVhcmUgIEhBTEYrZCwgSEFMRi1kXHJcblx0XHRzcXVhcmUgLUhBTEYrZCwgSEFMRitkXHJcblxyXG5cdGJnIDFcclxuXHRmYygpXHJcblxyXG5cdGEgPSBTSURFLygyK3NxcnQoMikpICMgTWFrZXMgYW5nbGVzIDkwIGRlZ3JlZXNcclxuXHRiID0gU0lERS1hXHJcblxyXG5cdFt4MCx5MF0gPSBbICAgICAgICAgICAgIC1IQUxGLCAgICAgICAgICAtSEFMRl1cclxuXHRbeDEseTFdID0gWyAgICAgICAgICAgIGEtSEFMRiwgICAgICAgICAgLUhBTEZdXHJcblx0W3gyLHkyXSA9IFthICsgYS9zcXJ0KDIpLUhBTEYsIGEvc3FydCgyKS1IQUxGXVxyXG5cdFt4Myx5M10gPSBbICAgICAgICAgICAgIC1IQUxGLCAgICAgICAgIGItSEFMRl1cclxuXHJcblx0ZCA9IChzcXJ0KDIpLTEpKkhBTEZcclxuXHJcblx0dHJhbnNsYXRlIHdpZHRoLzIsaGVpZ2h0LzJcclxuXHR3ID0gbWFwIG1vdXNlWCwwLHdpZHRoLDEsMjBcclxuXHRzcTEgdywwXHJcblx0c3ExIHctMiwxIl19
//# sourceURL=C:\Lab\2017\085-QuietOne\coffee\sketch.coffee