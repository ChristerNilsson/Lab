// Generated by CoffeeScript 1.12.7
var Laser;

Laser = (function() {
  function Laser(ship) {
    this.pos = ship.pos.copy();
    this.heading = ship.heading;
    this.vel = new p5.Vector.fromAngle(this.heading);
    this.vel.mult(10);
    this.r = 0;
  }

  Laser.prototype.update = function() {
    return this.pos.add(this.vel);
  };

  Laser.prototype.draw = function() {
    return ellipse(this.pos.x, this.pos.y, 4);
  };

  Laser.prototype.inside = function() {
    return 1000 > dist(this.pos.x, this.pos.y, width / 2, height / 2);
  };

  return Laser;

})();

//# sourceMappingURL=data:application/json;base64,eyJ2ZXJzaW9uIjozLCJmaWxlIjoibGFzZXIuanMiLCJzb3VyY2VSb290IjoiLi4iLCJzb3VyY2VzIjpbImNvZmZlZVxcbGFzZXIuY29mZmVlIl0sIm5hbWVzIjpbXSwibWFwcGluZ3MiOiI7QUFBQSxJQUFBOztBQUFNO0VBQ1MsZUFBQyxJQUFEO0lBQ2IsSUFBQyxDQUFBLEdBQUQsR0FBTyxJQUFJLENBQUMsR0FBRyxDQUFDLElBQVQsQ0FBQTtJQUNQLElBQUMsQ0FBQSxPQUFELEdBQVcsSUFBSSxDQUFDO0lBQ2hCLElBQUMsQ0FBQSxHQUFELEdBQU8sSUFBSSxFQUFFLENBQUMsTUFBTSxDQUFDLFNBQWQsQ0FBd0IsSUFBQyxDQUFBLE9BQXpCO0lBQ1AsSUFBQyxDQUFBLEdBQUcsQ0FBQyxJQUFMLENBQVUsRUFBVjtJQUNBLElBQUMsQ0FBQSxDQUFELEdBQUs7RUFMUTs7a0JBT2QsTUFBQSxHQUFTLFNBQUE7V0FBRyxJQUFDLENBQUEsR0FBRyxDQUFDLEdBQUwsQ0FBUyxJQUFDLENBQUEsR0FBVjtFQUFIOztrQkFDVCxJQUFBLEdBQU8sU0FBQTtXQUFHLE9BQUEsQ0FBUSxJQUFDLENBQUEsR0FBRyxDQUFDLENBQWIsRUFBZSxJQUFDLENBQUEsR0FBRyxDQUFDLENBQXBCLEVBQXNCLENBQXRCO0VBQUg7O2tCQUNQLE1BQUEsR0FBUyxTQUFBO1dBQUcsSUFBQSxHQUFPLElBQUEsQ0FBSyxJQUFDLENBQUEsR0FBRyxDQUFDLENBQVYsRUFBYSxJQUFDLENBQUEsR0FBRyxDQUFDLENBQWxCLEVBQXFCLEtBQUEsR0FBTSxDQUEzQixFQUE4QixNQUFBLEdBQU8sQ0FBckM7RUFBViIsInNvdXJjZXNDb250ZW50IjpbImNsYXNzIExhc2VyXHJcblx0Y29uc3RydWN0b3IgOiAoc2hpcCkgLT5cclxuXHRcdEBwb3MgPSBzaGlwLnBvcy5jb3B5KClcclxuXHRcdEBoZWFkaW5nID0gc2hpcC5oZWFkaW5nXHJcblx0XHRAdmVsID0gbmV3IHA1LlZlY3Rvci5mcm9tQW5nbGUgQGhlYWRpbmdcclxuXHRcdEB2ZWwubXVsdCAxMFxyXG5cdFx0QHIgPSAwXHJcblxyXG5cdHVwZGF0ZSA6IC0+IEBwb3MuYWRkIEB2ZWxcclxuXHRkcmF3IDogLT4gZWxsaXBzZSBAcG9zLngsQHBvcy55LDRcclxuXHRpbnNpZGUgOiAtPiAxMDAwID4gZGlzdCBAcG9zLngsIEBwb3MueSwgd2lkdGgvMiwgaGVpZ2h0LzIiXX0=
//# sourceURL=C:\Lab\2017\001-asteroids\coffee\laser.coffee