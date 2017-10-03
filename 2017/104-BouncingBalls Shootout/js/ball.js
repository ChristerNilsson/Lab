// Generated by CoffeeScript 1.11.1
var Ball;

Ball = (function() {
  function Ball(type, radius, x, y, vx, vy) {
    this.type = type;
    this.radius = radius;
    this.x = x != null ? x : random(this.radius, width - this.radius);
    this.y = y != null ? y : this.radius;
    this.vx = vx != null ? vx : 1 + random(3);
    this.vy = vy != null ? vy : 0;
    this.age = 0;
  }

  Ball.prototype.draw = function() {
    this.age += 1;
    if (this.type === 0) {
      fc(0, 0, 0);
    }
    if (this.type === 1) {
      fc(1, 1, 0);
    }
    if (this.type === 2) {
      fc(1, 0, 0);
    }
    circle(this.x, this.y, this.radius);
    if (this.x < this.radius || this.x > width - this.radius) {
      this.vx = -this.vx;
    }
    if (this.y < this.radius || this.y > height - this.radius) {
      this.vy = -this.vy;
    } else {
      this.vy += 0.1;
    }
    this.x += this.vx;
    return this.y += this.vy;
  };

  Ball.prototype.distance = function(o) {
    return dist(this.x, this.y, o.x, o.y);
  };

  return Ball;

})();

//# sourceMappingURL=data:application/json;base64,eyJ2ZXJzaW9uIjozLCJmaWxlIjoiYmFsbC5qcyIsInNvdXJjZVJvb3QiOiIuLiIsInNvdXJjZXMiOlsiY29mZmVlXFxiYWxsLmNvZmZlZSJdLCJuYW1lcyI6W10sIm1hcHBpbmdzIjoiO0FBQUEsSUFBQTs7QUFBTTtFQUNTLGNBQ2IsSUFEYSxFQUViLE1BRmEsRUFHYixDQUhhLEVBSWIsQ0FKYSxFQUtiLEVBTGEsRUFNYixFQU5hO0lBQ2IsSUFBQyxDQUFBLE9BQUQ7SUFDQSxJQUFDLENBQUEsU0FBRDtJQUNBLElBQUMsQ0FBQSxnQkFBRCxJQUFLLE1BQUEsQ0FBTyxJQUFDLENBQUEsTUFBUixFQUFnQixLQUFBLEdBQU0sSUFBQyxDQUFBLE1BQXZCO0lBQ0wsSUFBQyxDQUFBLGdCQUFELElBQUssSUFBQyxDQUFBO0lBQ04sSUFBQyxDQUFBLGtCQUFELEtBQU0sQ0FBQSxHQUFJLE1BQUEsQ0FBTyxDQUFQO0lBQ1YsSUFBQyxDQUFBLGtCQUFELEtBQU07SUFDTixJQUFDLENBQUEsR0FBRCxHQUFPO0VBUE07O2lCQVNkLElBQUEsR0FBTyxTQUFBO0lBQ04sSUFBQyxDQUFBLEdBQUQsSUFBUTtJQUNSLElBQUcsSUFBQyxDQUFBLElBQUQsS0FBTyxDQUFWO01BQWlCLEVBQUEsQ0FBRyxDQUFILEVBQUssQ0FBTCxFQUFPLENBQVAsRUFBakI7O0lBQ0EsSUFBRyxJQUFDLENBQUEsSUFBRCxLQUFPLENBQVY7TUFBaUIsRUFBQSxDQUFHLENBQUgsRUFBSyxDQUFMLEVBQU8sQ0FBUCxFQUFqQjs7SUFDQSxJQUFHLElBQUMsQ0FBQSxJQUFELEtBQU8sQ0FBVjtNQUFpQixFQUFBLENBQUcsQ0FBSCxFQUFLLENBQUwsRUFBTyxDQUFQLEVBQWpCOztJQUNBLE1BQUEsQ0FBTyxJQUFDLENBQUEsQ0FBUixFQUFVLElBQUMsQ0FBQSxDQUFYLEVBQWEsSUFBQyxDQUFBLE1BQWQ7SUFDQSxJQUFHLElBQUMsQ0FBQSxDQUFELEdBQUcsSUFBQyxDQUFBLE1BQUosSUFBYyxJQUFDLENBQUEsQ0FBRCxHQUFLLEtBQUEsR0FBTSxJQUFDLENBQUEsTUFBN0I7TUFBeUMsSUFBQyxDQUFBLEVBQUQsR0FBSSxDQUFDLElBQUMsQ0FBQSxHQUEvQzs7SUFDQSxJQUFHLElBQUMsQ0FBQSxDQUFELEdBQUcsSUFBQyxDQUFBLE1BQUosSUFBYyxJQUFDLENBQUEsQ0FBRCxHQUFLLE1BQUEsR0FBTyxJQUFDLENBQUEsTUFBOUI7TUFDQyxJQUFDLENBQUEsRUFBRCxHQUFNLENBQUMsSUFBQyxDQUFBLEdBRFQ7S0FBQSxNQUFBO01BR0MsSUFBQyxDQUFBLEVBQUQsSUFBTyxJQUhSOztJQUlBLElBQUMsQ0FBQSxDQUFELElBQU0sSUFBQyxDQUFBO1dBQ1AsSUFBQyxDQUFBLENBQUQsSUFBTSxJQUFDLENBQUE7RUFaRDs7aUJBY1AsUUFBQSxHQUFXLFNBQUMsQ0FBRDtXQUFPLElBQUEsQ0FBSyxJQUFDLENBQUEsQ0FBTixFQUFTLElBQUMsQ0FBQSxDQUFWLEVBQWEsQ0FBQyxDQUFDLENBQWYsRUFBa0IsQ0FBQyxDQUFDLENBQXBCO0VBQVAiLCJzb3VyY2VzQ29udGVudCI6WyJjbGFzcyBCYWxsXG5cdGNvbnN0cnVjdG9yIDogKFxuXHRcdEB0eXBlXG5cdFx0QHJhZGl1c1xuXHRcdEB4ID0gcmFuZG9tIEByYWRpdXMsIHdpZHRoLUByYWRpdXNcblx0XHRAeSA9IEByYWRpdXNcblx0XHRAdnggPSAxICsgcmFuZG9tIDNcblx0XHRAdnkgPSAwKSAtPlxuXHRcdEBhZ2UgPSAwXG5cblx0ZHJhdyA6IC0+XG5cdFx0QGFnZSArPSAxXG5cdFx0aWYgQHR5cGU9PTAgdGhlbiBmYyAwLDAsMFxuXHRcdGlmIEB0eXBlPT0xIHRoZW4gZmMgMSwxLDBcblx0XHRpZiBAdHlwZT09MiB0aGVuIGZjIDEsMCwwXG5cdFx0Y2lyY2xlIEB4LEB5LEByYWRpdXNcblx0XHRpZiBAeDxAcmFkaXVzIG9yIEB4ID4gd2lkdGgtQHJhZGl1cyB0aGVuIEB2eD0tQHZ4XG5cdFx0aWYgQHk8QHJhZGl1cyBvciBAeSA+IGhlaWdodC1AcmFkaXVzXG5cdFx0XHRAdnkgPSAtQHZ5XG5cdFx0ZWxzZVxuXHRcdFx0QHZ5ICs9IDAuMVxuXHRcdEB4ICs9IEB2eFxuXHRcdEB5ICs9IEB2eVxuXG5cdGRpc3RhbmNlIDogKG8pIC0+IGRpc3QgQHgsIEB5LCBvLngsIG8ueVxuIl19
//# sourceURL=C:\Lab\2017\104-BouncingBalls Shootout\coffee\ball.coffee