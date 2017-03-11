// Generated by CoffeeScript 1.11.1
var Plinko;

Plinko = (function() {
  function Plinko(x, y, r) {
    var options;
    this.r = r;
    options = {
      restitution: 1,
      friction: 0,
      isStatic: true
    };
    this.body = Bodies.circle(x, y, this.r, options);
    this.body.label = "plinko";
    World.add(world, this.body);
  }

  Plinko.prototype.show = function() {
    var pos;
    noStroke();
    fill(127);
    pos = this.body.position;
    push();
    translate(pos.x, pos.y);
    ellipse(0, 0, this.r * 2);
    return pop();
  };

  return Plinko;

})();

//# sourceMappingURL=data:application/json;base64,eyJ2ZXJzaW9uIjozLCJmaWxlIjoicGxpbmtvLmpzIiwic291cmNlUm9vdCI6IiIsInNvdXJjZXMiOlsicGxpbmtvLmNvZmZlZSJdLCJuYW1lcyI6W10sIm1hcHBpbmdzIjoiO0FBQUEsSUFBQTs7QUFBTTtFQUNVLGdCQUFDLENBQUQsRUFBSSxDQUFKLEVBQU8sQ0FBUDtBQUNaLFFBQUE7SUFEbUIsSUFBQyxDQUFBLElBQUQ7SUFDbkIsT0FBQSxHQUNFO01BQUEsV0FBQSxFQUFhLENBQWI7TUFDQSxRQUFBLEVBQVUsQ0FEVjtNQUVBLFFBQUEsRUFBVSxJQUZWOztJQUdGLElBQUMsQ0FBQSxJQUFELEdBQVEsTUFBTSxDQUFDLE1BQVAsQ0FBYyxDQUFkLEVBQWlCLENBQWpCLEVBQW9CLElBQUMsQ0FBQSxDQUFyQixFQUF3QixPQUF4QjtJQUNSLElBQUMsQ0FBQSxJQUFJLENBQUMsS0FBTixHQUFjO0lBQ2QsS0FBSyxDQUFDLEdBQU4sQ0FBVSxLQUFWLEVBQWlCLElBQUMsQ0FBQSxJQUFsQjtFQVBZOzttQkFTZCxJQUFBLEdBQU8sU0FBQTtBQUNMLFFBQUE7SUFBQSxRQUFBLENBQUE7SUFDQSxJQUFBLENBQUssR0FBTDtJQUNBLEdBQUEsR0FBTSxJQUFDLENBQUEsSUFBSSxDQUFDO0lBQ1osSUFBQSxDQUFBO0lBQ0EsU0FBQSxDQUFVLEdBQUcsQ0FBQyxDQUFkLEVBQWlCLEdBQUcsQ0FBQyxDQUFyQjtJQUNBLE9BQUEsQ0FBUSxDQUFSLEVBQVcsQ0FBWCxFQUFjLElBQUksQ0FBQyxDQUFMLEdBQVMsQ0FBdkI7V0FDQSxHQUFBLENBQUE7RUFQSyIsInNvdXJjZXNDb250ZW50IjpbImNsYXNzIFBsaW5rb1xyXG4gIGNvbnN0cnVjdG9yIDogKHgsIHksIEByKSAtPlxyXG4gICAgb3B0aW9ucyA9IFxyXG4gICAgICByZXN0aXR1dGlvbjogMVxyXG4gICAgICBmcmljdGlvbjogMFxyXG4gICAgICBpc1N0YXRpYzogdHJ1ZVxyXG4gICAgQGJvZHkgPSBCb2RpZXMuY2lyY2xlIHgsIHksIEByLCBvcHRpb25zXHJcbiAgICBAYm9keS5sYWJlbCA9IFwicGxpbmtvXCJcclxuICAgIFdvcmxkLmFkZCB3b3JsZCwgQGJvZHlcclxuXHJcbiAgc2hvdyA6IC0+XHJcbiAgICBub1N0cm9rZSgpXHJcbiAgICBmaWxsIDEyN1xyXG4gICAgcG9zID0gQGJvZHkucG9zaXRpb25cclxuICAgIHB1c2goKVxyXG4gICAgdHJhbnNsYXRlIHBvcy54LCBwb3MueVxyXG4gICAgZWxsaXBzZSAwLCAwLCB0aGlzLnIgKiAyXHJcbiAgICBwb3AoKSJdfQ==
//# sourceURL=C:\Lab\2017\028-Plinko\plinko.coffee