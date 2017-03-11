// Generated by CoffeeScript 1.11.1
var Boundary;

Boundary = (function() {
  function Boundary(x, y, w, h) {
    var options;
    this.w = w;
    this.h = h;
    options = {
      isStatic: true
    };
    this.body = Bodies.rectangle(x, y, this.w, this.h, options);
    World.add(world, this.body);
  }

  Boundary.prototype.show = function() {
    var pos;
    fill(255);
    stroke(255);
    pos = this.body.position;
    push();
    translate(pos.x, pos.y);
    rectMode(CENTER);
    rect(0, 0, this.w, this.h);
    return pop();
  };

  return Boundary;

})();

//# sourceMappingURL=data:application/json;base64,eyJ2ZXJzaW9uIjozLCJmaWxlIjoiYm91bmRhcnkuanMiLCJzb3VyY2VSb290IjoiIiwic291cmNlcyI6WyJib3VuZGFyeS5jb2ZmZWUiXSwibmFtZXMiOltdLCJtYXBwaW5ncyI6IjtBQUFBLElBQUE7O0FBQU07RUFDVSxrQkFBQyxDQUFELEVBQUksQ0FBSixFQUFPLENBQVAsRUFBVyxDQUFYO0FBQ1osUUFBQTtJQURtQixJQUFDLENBQUEsSUFBRDtJQUFJLElBQUMsQ0FBQSxJQUFEO0lBQ3ZCLE9BQUEsR0FBVTtNQUNSLFFBQUEsRUFBVSxJQURGOztJQUdWLElBQUMsQ0FBQSxJQUFELEdBQVEsTUFBTSxDQUFDLFNBQVAsQ0FBaUIsQ0FBakIsRUFBb0IsQ0FBcEIsRUFBdUIsSUFBQyxDQUFBLENBQXhCLEVBQTJCLElBQUMsQ0FBQSxDQUE1QixFQUErQixPQUEvQjtJQUNSLEtBQUssQ0FBQyxHQUFOLENBQVUsS0FBVixFQUFpQixJQUFDLENBQUEsSUFBbEI7RUFMWTs7cUJBT2QsSUFBQSxHQUFPLFNBQUE7QUFDTCxRQUFBO0lBQUEsSUFBQSxDQUFLLEdBQUw7SUFDQSxNQUFBLENBQU8sR0FBUDtJQUNBLEdBQUEsR0FBTSxJQUFDLENBQUEsSUFBSSxDQUFDO0lBQ1osSUFBQSxDQUFBO0lBQ0EsU0FBQSxDQUFVLEdBQUcsQ0FBQyxDQUFkLEVBQWlCLEdBQUcsQ0FBQyxDQUFyQjtJQUNBLFFBQUEsQ0FBUyxNQUFUO0lBQ0EsSUFBQSxDQUFLLENBQUwsRUFBUSxDQUFSLEVBQVcsSUFBQyxDQUFBLENBQVosRUFBZSxJQUFDLENBQUEsQ0FBaEI7V0FDQSxHQUFBLENBQUE7RUFSSyIsInNvdXJjZXNDb250ZW50IjpbImNsYXNzIEJvdW5kYXJ5XHJcbiAgY29uc3RydWN0b3IgOiAoeCwgeSwgQHcsIEBoKSAtPlxyXG4gICAgb3B0aW9ucyA9IHtcclxuICAgICAgaXNTdGF0aWM6IHRydWVcclxuICAgIH07XHJcbiAgICBAYm9keSA9IEJvZGllcy5yZWN0YW5nbGUgeCwgeSwgQHcsIEBoLCBvcHRpb25zXHJcbiAgICBXb3JsZC5hZGQgd29ybGQsIEBib2R5XHJcblxyXG4gIHNob3cgOiAtPlxyXG4gICAgZmlsbCAyNTVcclxuICAgIHN0cm9rZSAyNTVcclxuICAgIHBvcyA9IEBib2R5LnBvc2l0aW9uXHJcbiAgICBwdXNoKClcclxuICAgIHRyYW5zbGF0ZSBwb3MueCwgcG9zLnlcclxuICAgIHJlY3RNb2RlIENFTlRFUlxyXG4gICAgcmVjdCAwLCAwLCBAdywgQGhcclxuICAgIHBvcCgpXHJcbiJdfQ==
//# sourceURL=C:\Lab\2017\028-Plinko\boundary.coffee