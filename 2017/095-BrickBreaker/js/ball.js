// Generated by CoffeeScript 1.11.1
var Ball;

Ball = (function() {
  function Ball() {
    this.x = width / 2;
    this.y = height / 2;
    this.r = 30;
    this.vx = 6;
    this.vy = 6;
  }

  Ball.prototype.update = function() {
    this.x += this.vx;
    return this.y += this.vy;
  };

  Ball.prototype.display = function() {
    return ellipse(this.x, this.y, this.r * 2);
  };

  Ball.prototype.checkEdges = function() {
    if (this.x < this.r || this.x > width - this.r) {
      this.vx = -this.vx;
    }
    if (this.y < this.r && ball.vy < 0) {
      return this.vy = -this.vy;
    }
  };

  Ball.prototype.meets = function(p) {
    var ref, ref1;
    return (p.y - this.r < (ref = this.y) && ref < p.y) && (p.x - this.r < (ref1 = this.x) && ref1 < p.x + p.w + this.r);
  };

  Ball.prototype.hits = function(brick) {
    return dist(this.x, this.y, brick.x, brick.y) < brick.r + this.r;
  };

  return Ball;

})();

//# sourceMappingURL=data:application/json;base64,eyJ2ZXJzaW9uIjozLCJmaWxlIjoiYmFsbC5qcyIsInNvdXJjZVJvb3QiOiIuLiIsInNvdXJjZXMiOlsiY29mZmVlXFxiYWxsLmNvZmZlZSJdLCJuYW1lcyI6W10sIm1hcHBpbmdzIjoiO0FBQUEsSUFBQTs7QUFBTTtFQUNTLGNBQUE7SUFDYixJQUFDLENBQUEsQ0FBRCxHQUFLLEtBQUEsR0FBUTtJQUNiLElBQUMsQ0FBQSxDQUFELEdBQUssTUFBQSxHQUFTO0lBRWQsSUFBQyxDQUFBLENBQUQsR0FBSztJQUNMLElBQUMsQ0FBQSxFQUFELEdBQU07SUFDTixJQUFDLENBQUEsRUFBRCxHQUFNO0VBTk87O2lCQVFkLE1BQUEsR0FBUyxTQUFBO0lBQ1IsSUFBQyxDQUFBLENBQUQsSUFBTSxJQUFDLENBQUE7V0FDUCxJQUFDLENBQUEsQ0FBRCxJQUFNLElBQUMsQ0FBQTtFQUZDOztpQkFJVCxPQUFBLEdBQVUsU0FBQTtXQUFHLE9BQUEsQ0FBUSxJQUFDLENBQUEsQ0FBVCxFQUFZLElBQUMsQ0FBQSxDQUFiLEVBQWdCLElBQUMsQ0FBQSxDQUFELEdBQUssQ0FBckI7RUFBSDs7aUJBRVYsVUFBQSxHQUFhLFNBQUE7SUFDWixJQUFHLElBQUMsQ0FBQSxDQUFELEdBQUssSUFBQyxDQUFBLENBQU4sSUFBVyxJQUFDLENBQUEsQ0FBRCxHQUFLLEtBQUEsR0FBUSxJQUFDLENBQUEsQ0FBNUI7TUFBbUMsSUFBQyxDQUFBLEVBQUQsR0FBTSxDQUFDLElBQUMsQ0FBQSxHQUEzQzs7SUFDQSxJQUFHLElBQUMsQ0FBQSxDQUFELEdBQUssSUFBQyxDQUFBLENBQU4sSUFBWSxJQUFJLENBQUMsRUFBTCxHQUFVLENBQXpCO2FBQWdDLElBQUMsQ0FBQSxFQUFELEdBQU0sQ0FBQyxJQUFDLENBQUEsR0FBeEM7O0VBRlk7O2lCQUliLEtBQUEsR0FBUSxTQUFDLENBQUQ7QUFBTyxRQUFBO1dBQUEsQ0FBQSxDQUFDLENBQUMsQ0FBRixHQUFNLElBQUMsQ0FBQSxDQUFQLFVBQVcsSUFBQyxDQUFBLEVBQVosT0FBQSxHQUFnQixDQUFDLENBQUMsQ0FBbEIsQ0FBQSxJQUF3QixDQUFBLENBQUMsQ0FBQyxDQUFGLEdBQU0sSUFBQyxDQUFBLENBQVAsV0FBVyxJQUFDLENBQUEsRUFBWixRQUFBLEdBQWdCLENBQUMsQ0FBQyxDQUFGLEdBQU0sQ0FBQyxDQUFDLENBQVIsR0FBWSxJQUFDLENBQUEsQ0FBN0I7RUFBL0I7O2lCQUNSLElBQUEsR0FBTyxTQUFDLEtBQUQ7V0FBVyxJQUFBLENBQUssSUFBQyxDQUFBLENBQU4sRUFBUyxJQUFDLENBQUEsQ0FBVixFQUFhLEtBQUssQ0FBQyxDQUFuQixFQUFzQixLQUFLLENBQUMsQ0FBNUIsQ0FBQSxHQUFpQyxLQUFLLENBQUMsQ0FBTixHQUFVLElBQUMsQ0FBQTtFQUF2RCIsInNvdXJjZXNDb250ZW50IjpbImNsYXNzIEJhbGxcblx0Y29uc3RydWN0b3IgOiAtPlxuXHRcdEB4ID0gd2lkdGggLyAyXG5cdFx0QHkgPSBoZWlnaHQgLyAyXG5cblx0XHRAciA9IDMwXG5cdFx0QHZ4ID0gNlxuXHRcdEB2eSA9IDZcblxuXHR1cGRhdGUgOiAtPlxuXHRcdEB4ICs9IEB2eFxuXHRcdEB5ICs9IEB2eVxuXG5cdGRpc3BsYXkgOiAtPiBlbGxpcHNlIEB4LCBAeSwgQHIgKiAyXG5cblx0Y2hlY2tFZGdlcyA6IC0+XG5cdFx0aWYgQHggPCBAciBvciBAeCA+IHdpZHRoIC0gQHIgdGhlbiBAdnggPSAtQHZ4XG5cdFx0aWYgQHkgPCBAciBhbmQgYmFsbC52eSA8IDAgdGhlbiBAdnkgPSAtQHZ5XG5cblx0bWVldHMgOiAocCkgLT4gcC55IC0gQHIgPCBAeSA8IHAueSBhbmQgcC54IC0gQHIgPCBAeCA8IHAueCArIHAudyArIEByXG5cdGhpdHMgOiAoYnJpY2spIC0+IGRpc3QoQHgsIEB5LCBicmljay54LCBicmljay55KSA8IGJyaWNrLnIgKyBAciJdfQ==
//# sourceURL=C:\Lab\2017\095-BrickBreaker\coffee\ball.coffee