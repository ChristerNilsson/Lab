// Generated by CoffeeScript 2.4.1
var Box, HEIGHT, RADIUS, SQ2, WIDTH, crossHair, image, messages, scale, stdText;

SQ2 = 2; // Math.sqrt 2

WIDTH = 1639;

HEIGHT = 986;

RADIUS = 35;

messages = [];

stdText = {
  font: '40px Arial',
  fill: '#000'
};

image = null;

crossHair = null;

scale = function(factor) {
  var dx, dy, h, w, x, y;
  w = window.innerWidth;
  h = window.innerHeight;
  dx = w / 2 - image.attrs.x;
  dy = h / 2 - image.attrs.y;
  image.scale(factor);
  //x = w/2 - dx * image._.sx
  //y = h/2 - dy * image._.sy
  x = image.attrs.x;
  y = image.attrs.y;
  //image.attr {x: x, y: y}
  console.log(factor, image._.sx, w, h, dx, dy, x, y);
  if (crossHair) {
    return crossHair.scale(factor);
  }
};

Box = class Box {
  constructor(x, y, w, h, name) {
    var a, b, c, d;
    image = raphael.image("data/Skarpnäck.png", 0, 0, WIDTH, HEIGHT);
    //image.translate (1920-WIDTH)/2, (1127-HEIGHT)/2
    image.attr({
      x: (1920 - WIDTH) / 2,
      y: (1127 - HEIGHT) / 2
    });
    crossHair = raphael.circle(w / 2, h / 2, RADIUS);
    
    //scale SQ2
    scale(1);
    a = raphael.text(0.5 * w, 50, '180º').attr(stdText);
    b = raphael.text(0.95 * w, 50, '345m').attr(stdText);
    c = raphael.text(0.5 * w, 0.95 * h, '59.123456 18.123456').attr(stdText);
    d = raphael.text(0.95 * w, 0.95 * h, '345').attr(stdText);
    messages = [a, b, c, d];
    console.log(messages);
    image.drag(this.move_drag, this.move_start, this.move_up);
    image.mousemove(function(e) { // Ska ge image koordinater
      var dx, dy, sx, sy;
      ({dx, dy, sx, sy} = image._);
      return messages[2].attr({
        text: `${(e.x - dx) / sx - image.attrs.x} = ${e.x} ${dx} ${x} ${sx}   ` + `${(e.y - dy) / sy - image.attrs.y} = ${e.y} ${dy} ${y} ${sy}`
      });
    });
  }

  move_start() {
    return [this.ox, this.oy] = [0, 0];
  }

  move_drag(dx, dy) {
    image.translate((dx - this.ox) / image._.sx, (dy - this.oy) / image._.sy);
    this.ox = dx;
    return this.oy = dy;
  }

  move_up() {
    return console.dir(JSON.stringify(image.attrs));
  }

};

//# sourceMappingURL=data:application/json;base64,eyJ2ZXJzaW9uIjozLCJmaWxlIjoiYm94LmpzIiwic291cmNlUm9vdCI6Ii4uIiwic291cmNlcyI6WyJjb2ZmZWVcXGJveC5jb2ZmZWUiXSwibmFtZXMiOltdLCJtYXBwaW5ncyI6IjtBQUFBLElBQUEsR0FBQSxFQUFBLE1BQUEsRUFBQSxNQUFBLEVBQUEsR0FBQSxFQUFBLEtBQUEsRUFBQSxTQUFBLEVBQUEsS0FBQSxFQUFBLFFBQUEsRUFBQSxLQUFBLEVBQUE7O0FBQUEsR0FBQSxHQUFNLEVBQU47O0FBRUEsS0FBQSxHQUFROztBQUNSLE1BQUEsR0FBUzs7QUFDVCxNQUFBLEdBQVM7O0FBRVQsUUFBQSxHQUFXOztBQUVYLE9BQUEsR0FBVTtFQUFDLElBQUEsRUFBTSxZQUFQO0VBQXFCLElBQUEsRUFBTTtBQUEzQjs7QUFFVixLQUFBLEdBQVE7O0FBQ1IsU0FBQSxHQUFZOztBQUVaLEtBQUEsR0FBUSxRQUFBLENBQUMsTUFBRCxDQUFBO0FBQ1AsTUFBQSxFQUFBLEVBQUEsRUFBQSxFQUFBLENBQUEsRUFBQSxDQUFBLEVBQUEsQ0FBQSxFQUFBO0VBQUEsQ0FBQSxHQUFJLE1BQU0sQ0FBQztFQUNYLENBQUEsR0FBSSxNQUFNLENBQUM7RUFDWCxFQUFBLEdBQUssQ0FBQSxHQUFFLENBQUYsR0FBTSxLQUFLLENBQUMsS0FBSyxDQUFDO0VBQ3ZCLEVBQUEsR0FBSyxDQUFBLEdBQUUsQ0FBRixHQUFNLEtBQUssQ0FBQyxLQUFLLENBQUM7RUFDdkIsS0FBSyxDQUFDLEtBQU4sQ0FBWSxNQUFaLEVBSkE7OztFQU9BLENBQUEsR0FBSSxLQUFLLENBQUMsS0FBSyxDQUFDO0VBQ2hCLENBQUEsR0FBSSxLQUFLLENBQUMsS0FBSyxDQUFDLEVBUmhCOztFQVVBLE9BQU8sQ0FBQyxHQUFSLENBQVksTUFBWixFQUFtQixLQUFLLENBQUMsQ0FBQyxDQUFDLEVBQTNCLEVBQStCLENBQS9CLEVBQWlDLENBQWpDLEVBQW1DLEVBQW5DLEVBQXNDLEVBQXRDLEVBQXlDLENBQXpDLEVBQTJDLENBQTNDO0VBRUEsSUFBRyxTQUFI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QyxJQUFDLENBQUEsRUFBRixFQUFLLElBQUMsQ0FBQSxFQUFOLENBQUEsR0FBWSxDQUFDLENBQUQsRUFBRyxDQUFIO0VBQWY7O0VBRWIsU0FBWSxDQUFDLEVBQUQsRUFBSyxFQUFMLENBQUE7SUFDWCxLQUFLLENBQUMsU0FBTixDQUFnQixDQUFDLEVBQUEsR0FBRyxJQUFDLENBQUEsRUFBTCxDQUFBLEdBQVcsS0FBSyxDQUFDLENBQUMsQ0FBQyxFQUFuQyxFQUF1QyxDQUFDLEVBQUEsR0FBRyxJQUFDLENBQUEsRUFBTCxDQUFBLEdBQVcsS0FBSyxDQUFDLENBQUMsQ0FBQyxFQUExRDtJQUNBLElBQUMsQ0FBQSxFQUFELEdBQU07V0FDTixJQUFDLENBQUEsRUFBRCxHQUFNO0VBSEs7O0VBS1osT0FBVSxDQUFBLENBQUE7V0FDVCxPQUFPLENBQUMsR0FBUixDQUFZLElBQUksQ0FBQyxTQUFMLENBQWUsS0FBSyxDQUFDLEtBQXJCLENBQVo7RUFEUzs7QUFuQ1giLCJzb3VyY2VzQ29udGVudCI6WyJTUTIgPSAyICMgTWF0aC5zcXJ0IDJcclxuXHJcbldJRFRIID0gMTYzOVxyXG5IRUlHSFQgPSA5ODZcclxuUkFESVVTID0gMzVcclxuXHJcbm1lc3NhZ2VzID0gW11cclxuXHJcbnN0ZFRleHQgPSB7Zm9udDogJzQwcHggQXJpYWwnLCBmaWxsOiAnIzAwMCd9XHJcblxyXG5pbWFnZSA9IG51bGxcclxuY3Jvc3NIYWlyID0gbnVsbFxyXG5cclxuc2NhbGUgPSAoZmFjdG9yKSAtPlxyXG5cdHcgPSB3aW5kb3cuaW5uZXJXaWR0aFxyXG5cdGggPSB3aW5kb3cuaW5uZXJIZWlnaHRcclxuXHRkeCA9IHcvMiAtIGltYWdlLmF0dHJzLnhcclxuXHRkeSA9IGgvMiAtIGltYWdlLmF0dHJzLnlcclxuXHRpbWFnZS5zY2FsZSBmYWN0b3JcclxuXHQjeCA9IHcvMiAtIGR4ICogaW1hZ2UuXy5zeFxyXG5cdCN5ID0gaC8yIC0gZHkgKiBpbWFnZS5fLnN5XHJcblx0eCA9IGltYWdlLmF0dHJzLnhcclxuXHR5ID0gaW1hZ2UuYXR0cnMueVxyXG5cdCNpbWFnZS5hdHRyIHt4OiB4LCB5OiB5fVxyXG5cdGNvbnNvbGUubG9nIGZhY3RvcixpbWFnZS5fLnN4LCB3LGgsZHgsZHkseCx5XHJcblxyXG5cdGlmIGNyb3NzSGFpciB0aGVuIGNyb3NzSGFpci5zY2FsZSBmYWN0b3JcclxuXHJcbmNsYXNzIEJveCBcclxuXHRjb25zdHJ1Y3RvciA6ICh4LHksdyxoLG5hbWUpIC0+XHJcblx0XHRpbWFnZSA9IHJhcGhhZWwuaW1hZ2UgXCJkYXRhL1NrYXJwbsOkY2sucG5nXCIsIDAsMCwgV0lEVEgsIEhFSUdIVFxyXG5cdFx0I2ltYWdlLnRyYW5zbGF0ZSAoMTkyMC1XSURUSCkvMiwgKDExMjctSEVJR0hUKS8yXHJcblx0XHRpbWFnZS5hdHRyIHt4OigxOTIwLVdJRFRIKS8yLCB5OigxMTI3LUhFSUdIVCkvMn1cclxuXHRcdGNyb3NzSGFpciA9IHJhcGhhZWwuY2lyY2xlIHcvMixoLzIsUkFESVVTIFxyXG5cdFx0I3NjYWxlIFNRMlxyXG5cdFx0c2NhbGUgMVxyXG5cclxuXHRcdGEgPSByYXBoYWVsLnRleHQgMC41KncsIDUwLCAnMTgwwronXHJcblx0XHRcdC5hdHRyIHN0ZFRleHRcclxuXHRcdGIgPSByYXBoYWVsLnRleHQgMC45NSp3LCA1MCwgJzM0NW0nXHJcblx0XHRcdC5hdHRyIHN0ZFRleHRcclxuXHJcblx0XHRjID0gcmFwaGFlbC50ZXh0IDAuNSp3LCAwLjk1KmgsICc1OS4xMjM0NTYgMTguMTIzNDU2J1xyXG5cdFx0XHQuYXR0ciBzdGRUZXh0XHJcblx0XHRkID0gcmFwaGFlbC50ZXh0IDAuOTUqdywgMC45NSpoLCAnMzQ1J1xyXG5cdFx0XHQuYXR0ciBzdGRUZXh0XHJcblxyXG5cdFx0bWVzc2FnZXMgPSBbYSxiLGMsZF1cclxuXHJcblx0XHRjb25zb2xlLmxvZyBtZXNzYWdlc1xyXG5cclxuXHRcdGltYWdlLmRyYWcgQG1vdmVfZHJhZywgQG1vdmVfc3RhcnQsIEBtb3ZlX3VwXHJcblx0XHRpbWFnZS5tb3VzZW1vdmUgKGUpIC0+ICMgU2thIGdlIGltYWdlIGtvb3JkaW5hdGVyXHJcblx0XHRcdHtkeCxkeSxzeCxzeX0gPSBpbWFnZS5fXHJcblx0XHRcdG1lc3NhZ2VzWzJdLmF0dHIge3RleHQ6IFwiI3soZS54IC0gZHgpL3N4IC0gaW1hZ2UuYXR0cnMueH0gPSAje2UueH0gI3tkeH0gI3t4fSAje3N4fSAgIFwiICsgXCIjeyhlLnkgLSBkeSkvc3kgLSBpbWFnZS5hdHRycy55fSA9ICN7ZS55fSAje2R5fSAje3l9ICN7c3l9XCJ9XHJcblxyXG5cdG1vdmVfc3RhcnQgOiAtPiBbQG94LEBveV0gPSBbMCwwXVxyXG5cclxuXHRtb3ZlX2RyYWcgOiAoZHgsIGR5KSAtPlxyXG5cdFx0aW1hZ2UudHJhbnNsYXRlIChkeC1Ab3gpIC8gaW1hZ2UuXy5zeCwgKGR5LUBveSkgLyBpbWFnZS5fLnN5XHJcblx0XHRAb3ggPSBkeFxyXG5cdFx0QG95ID0gZHkgXHJcblxyXG5cdG1vdmVfdXAgOiAtPlxyXG5cdFx0Y29uc29sZS5kaXIgSlNPTi5zdHJpbmdpZnkgaW1hZ2UuYXR0cnNcclxuIl19
//# sourceURL=c:\Lab\2020\018-SVGGPSKarta\coffee\box.coffee