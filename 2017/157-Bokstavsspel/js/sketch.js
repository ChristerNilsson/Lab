// Generated by CoffeeScript 2.0.3
var Enemy, Game, Player, draw, game, keyTyped, setup,
  indexOf = [].indexOf;

game = null;

Game = class Game {
  constructor() {
    this.N = 11;
    this.size = null;
    this.SIZE = null;
    this.player = null;
    this.enemies = null;
    this.interval = null;
    this.speed = null;
    this.score = 0;
    this.highScore = 0;
    this.size = min(windowWidth, windowHeight);
    this.SIZE = this.size / this.N;
    this.newGame();
  }

  newGame() {
    this.player = new Player(width / 2, height / 2);
    this.enemies = {};
    this.interval = 200;
    this.speed = 1;
    this.highScore = max(this.highScore, this.score);
    return this.score = 0;
  }

  draw() {
    var enemy, k, letter, r, ref;
    bg(0.5);
    this.player.draw();
    ref = this.enemies;
    for (k in ref) {
      enemy = ref[k];
      if (enemy) {
        enemy.draw();
      }
    }
    fc(0);
    text(this.score, this.SIZE, this.SIZE);
    text(this.highScore, width - this.SIZE, this.SIZE);
    if (frameCount % this.interval === 0) {
      this.interval -= 1;
      this.speed *= 1.05;
      r = int(random(4));
      while (_.size(this.enemies) < 30) {
        letter = _.sample('abcdefghijklmnopqrstuvwxyzåäö' + '0123456789[]{}().,-+*/%#@=<>'.slice(0, this.score));
        if (indexOf.call(_.keys(this.enemies), letter) >= 0) {
          if (this.enemies[letter].active === false) {
            break;
          }
        } else {
          break;
        }
      }
      if (r === 0) {
        this.enemies[letter] = new Enemy(letter, this.player.x, 0, 0, this.speed * height / this.size);
      }
      if (r === 1) {
        this.enemies[letter] = new Enemy(letter, this.player.x, height, 0, -this.speed * height / this.size);
      }
      if (r === 2) {
        this.enemies[letter] = new Enemy(letter, 0, this.player.y, this.speed * width / this.size, 0);
      }
      if (r === 3) {
        return this.enemies[letter] = new Enemy(letter, width, this.player.y, -this.speed * width / this.size, 0);
      }
    }
  }

  keyTyped(k) {
    if ((indexOf.call(_.keys(this.enemies), k) >= 0) && this.enemies[k].active) {
      this.score++;
      return this.enemies[k].active = false;
    } else {
      return this.newGame();
    }
  }

};

Enemy = class Enemy {
  constructor(letter1, x1, y1, dx, dy) {
    this.letter = letter1;
    this.x = x1;
    this.y = y1;
    this.dx = dx;
    this.dy = dy;
    this.active = true;
  }

  draw() {
    if (!this.active) {
      return;
    }
    this.x += this.dx;
    this.y += this.dy;
    fc(0);
    text(this.letter, this.x, this.y);
    if (10 > game.player.dist(this.x, this.y)) {
      return game.newGame();
    }
  }

};

Player = class Player {
  constructor(x1, y1) {
    this.x = x1;
    this.y = y1;
  }

  draw() {
    fc(1);
    return rect(this.x, this.y, game.SIZE, game.SIZE);
  }

  dist(x, y) {
    return dist(x, y, this.x, this.y);
  }

};

draw = function() {
  return game.draw();
};

keyTyped = function() {
  return game.keyTyped(key.toLowerCase());
};

setup = function() {
  createCanvas(windowWidth, windowHeight);
  game = new Game;
  rectMode(CENTER);
  textAlign(CENTER, CENTER);
  return textSize(game.SIZE);
};

//# sourceMappingURL=data:application/json;base64,eyJ2ZXJzaW9uIjozLCJmaWxlIjoic2tldGNoLmpzIiwic291cmNlUm9vdCI6Ii4uIiwic291cmNlcyI6WyJjb2ZmZWVcXHNrZXRjaC5jb2ZmZWUiXSwibmFtZXMiOltdLCJtYXBwaW5ncyI6IjtBQUFBLElBQUEsS0FBQSxFQUFBLElBQUEsRUFBQSxNQUFBLEVBQUEsSUFBQSxFQUFBLElBQUEsRUFBQSxRQUFBLEVBQUEsS0FBQTtFQUFBOztBQUFBLElBQUEsR0FBTzs7QUFFRCxPQUFOLE1BQUEsS0FBQTtFQUNDLFdBQWMsQ0FBQSxDQUFBO0lBQ2IsSUFBQyxDQUFBLENBQUQsR0FBSztJQUNMLElBQUMsQ0FBQSxJQUFELEdBQU07SUFDTixJQUFDLENBQUEsSUFBRCxHQUFRO0lBQ1IsSUFBQyxDQUFBLE1BQUQsR0FBVTtJQUNWLElBQUMsQ0FBQSxPQUFELEdBQVc7SUFDWCxJQUFDLENBQUEsUUFBRCxHQUFZO0lBQ1osSUFBQyxDQUFBLEtBQUQsR0FBUztJQUNULElBQUMsQ0FBQSxLQUFELEdBQVM7SUFDVCxJQUFDLENBQUEsU0FBRCxHQUFhO0lBQ2IsSUFBQyxDQUFBLElBQUQsR0FBUSxHQUFBLENBQUksV0FBSixFQUFnQixZQUFoQjtJQUNSLElBQUMsQ0FBQSxJQUFELEdBQVEsSUFBQyxDQUFBLElBQUQsR0FBTSxJQUFDLENBQUE7SUFDZixJQUFDLENBQUEsT0FBRCxDQUFBO0VBWmE7O0VBY2QsT0FBVSxDQUFBLENBQUE7SUFDVCxJQUFDLENBQUEsTUFBRCxHQUFVLElBQUksTUFBSixDQUFXLEtBQUEsR0FBTSxDQUFqQixFQUFtQixNQUFBLEdBQU8sQ0FBMUI7SUFDVixJQUFDLENBQUEsT0FBRCxHQUFXLENBQUE7SUFDWCxJQUFDLENBQUEsUUFBRCxHQUFZO0lBQ1osSUFBQyxDQUFBLEtBQUQsR0FBUztJQUNULElBQUMsQ0FBQSxTQUFELEdBQWEsR0FBQSxDQUFJLElBQUMsQ0FBQSxTQUFMLEVBQWUsSUFBQyxDQUFBLEtBQWhCO1dBQ2IsSUFBQyxDQUFBLEtBQUQsR0FBUztFQU5BOztFQVFWLElBQU8s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QUExQjtFQUZNOztFQUdQLElBQU8sQ0FBQyxDQUFELEVBQUcsQ0FBSCxDQUFBO1dBQVMsSUFBQSxDQUFLLENBQUwsRUFBTyxDQUFQLEVBQVMsSUFBQyxDQUFBLENBQVYsRUFBWSxJQUFDLENBQUEsQ0FBYjtFQUFUOztBQUxSOztBQU9BLElBQUEsR0FBTyxRQUFBLENBQUEsQ0FBQTtTQUFHLElBQUksQ0FBQyxJQUFMLENBQUE7QUFBSDs7QUFDUCxRQUFBLEdBQVcsUUFBQSxDQUFBLENBQUE7U0FBRyxJQUFJLENBQUMsUUFBTCxDQUFjLEdBQUcsQ0FBQyxXQUFKLENBQUEsQ0FBZDtBQUFIOztBQUNYLEtBQUEsR0FBUSxRQUFBLENBQUEsQ0FBQTtFQUNQLFlBQUEsQ0FBYSxXQUFiLEVBQXlCLFlBQXpCO0VBQ0EsSUFBQSxHQUFPLElBQUk7RUFDWCxRQUFBLENBQVMsTUFBVDtFQUNBLFNBQUEsQ0FBVSxNQUFWLEVBQWlCLE1BQWpCO1NBQ0EsUUFBQSxDQUFTLElBQUksQ0FBQyxJQUFkO0FBTE8iLCJzb3VyY2VzQ29udGVudCI6WyJnYW1lID0gbnVsbFxyXG5cclxuY2xhc3MgR2FtZVxyXG5cdGNvbnN0cnVjdG9yIDogLT4gXHJcblx0XHRATiA9IDExXHJcblx0XHRAc2l6ZT1udWxsXHJcblx0XHRAU0laRSA9IG51bGxcclxuXHRcdEBwbGF5ZXIgPSBudWxsXHJcblx0XHRAZW5lbWllcyA9IG51bGxcclxuXHRcdEBpbnRlcnZhbCA9IG51bGxcclxuXHRcdEBzcGVlZCA9IG51bGxcclxuXHRcdEBzY29yZSA9IDBcclxuXHRcdEBoaWdoU2NvcmUgPSAwXHJcblx0XHRAc2l6ZSA9IG1pbiB3aW5kb3dXaWR0aCx3aW5kb3dIZWlnaHRcclxuXHRcdEBTSVpFID0gQHNpemUvQE5cclxuXHRcdEBuZXdHYW1lKClcclxuXHJcblx0bmV3R2FtZSA6IC0+XHJcblx0XHRAcGxheWVyID0gbmV3IFBsYXllciB3aWR0aC8yLGhlaWdodC8yXHJcblx0XHRAZW5lbWllcyA9IHt9XHJcblx0XHRAaW50ZXJ2YWwgPSAyMDBcclxuXHRcdEBzcGVlZCA9IDFcclxuXHRcdEBoaWdoU2NvcmUgPSBtYXggQGhpZ2hTY29yZSxAc2NvcmVcclxuXHRcdEBzY29yZSA9IDBcclxuXHJcblx0ZHJhdyA6IC0+XHJcblx0XHRiZyAwLjVcclxuXHRcdEBwbGF5ZXIuZHJhdygpXHJcblx0XHRmb3IgayxlbmVteSBvZiBAZW5lbWllc1xyXG5cdFx0XHRpZiBlbmVteSB0aGVuIGVuZW15LmRyYXcoKVxyXG5cdFx0ZmMgMFxyXG5cdFx0dGV4dCBAc2NvcmUsIEBTSVpFLEBTSVpFXHJcblx0XHR0ZXh0IEBoaWdoU2NvcmUsIHdpZHRoLUBTSVpFLEBTSVpFXHJcblx0XHRpZiBmcmFtZUNvdW50ICUgQGludGVydmFsID09IDBcclxuXHRcdFx0QGludGVydmFsIC09IDFcclxuXHRcdFx0QHNwZWVkICo9IDEuMDVcclxuXHRcdFx0ciA9IGludCByYW5kb20gNFxyXG5cdFx0XHR3aGlsZSBfLnNpemUoQGVuZW1pZXMpPDMwXHJcblx0XHRcdFx0bGV0dGVyID0gXy5zYW1wbGUgJ2FiY2RlZmdoaWprbG1ub3BxcnN0dXZ3eHl6w6XDpMO2JyArICcwMTIzNDU2Nzg5W117fSgpLiwtKyovJSNAPTw+Jy5zbGljZSAwLEBzY29yZVxyXG5cdFx0XHRcdGlmIGxldHRlciBpbiBfLmtleXMgQGVuZW1pZXMgXHJcblx0XHRcdFx0XHRpZiBAZW5lbWllc1tsZXR0ZXJdLmFjdGl2ZSA9PSBmYWxzZSB0aGVuIGJyZWFrXHJcblx0XHRcdFx0ZWxzZVxyXG5cdFx0XHRcdFx0YnJlYWtcclxuXHRcdFx0aWYgcj09MCB0aGVuIEBlbmVtaWVzW2xldHRlcl0gPSBuZXcgRW5lbXkgbGV0dGVyLEBwbGF5ZXIueCwwLDAsQHNwZWVkKmhlaWdodC9Ac2l6ZVx0XHJcblx0XHRcdGlmIHI9PTEgdGhlbiBAZW5lbWllc1tsZXR0ZXJdID0gbmV3IEVuZW15IGxldHRlcixAcGxheWVyLngsaGVpZ2h0LDAsLUBzcGVlZCpoZWlnaHQvQHNpemVcdFxyXG5cdFx0XHRpZiByPT0yIHRoZW4gQGVuZW1pZXNbbGV0dGVyXSA9IG5ldyBFbmVteSBsZXR0ZXIsMCxAcGxheWVyLnksQHNwZWVkKndpZHRoL0BzaXplLDBcdFxyXG5cdFx0XHRpZiByPT0zIHRoZW4gQGVuZW1pZXNbbGV0dGVyXSA9IG5ldyBFbmVteSBsZXR0ZXIsd2lkdGgsQHBsYXllci55LC1Ac3BlZWQqd2lkdGgvQHNpemUsMFx0XHJcblxyXG5cdGtleVR5cGVkIDogKGspIC0+IFxyXG5cdFx0aWYgKGsgaW4gXy5rZXlzIEBlbmVtaWVzKSBhbmQgQGVuZW1pZXNba10uYWN0aXZlIFxyXG5cdFx0XHRAc2NvcmUrK1xyXG5cdFx0XHRAZW5lbWllc1trXS5hY3RpdmUgPSBmYWxzZSAgXHJcblx0XHRlbHNlXHJcblx0XHRcdEBuZXdHYW1lKClcclxuXHJcbmNsYXNzIEVuZW15XHJcblx0Y29uc3RydWN0b3IgOiAoQGxldHRlcixAeCxAeSxAZHgsQGR5KSAtPiBAYWN0aXZlID0gdHJ1ZVxyXG5cdGRyYXcgOiAtPlx0XHJcblx0XHRpZiBub3QgQGFjdGl2ZSB0aGVuIHJldHVyblxyXG5cdFx0QHggKz0gQGR4XHJcblx0XHRAeSArPSBAZHlcclxuXHRcdGZjIDBcclxuXHRcdHRleHQgQGxldHRlcixAeCxAeVxyXG5cdFx0aWYgMTAgPiBnYW1lLnBsYXllci5kaXN0IEB4LEB5IHRoZW4gZ2FtZS5uZXdHYW1lKClcclxuXHJcbmNsYXNzIFBsYXllclxyXG5cdGNvbnN0cnVjdG9yIDogKEB4LEB5KSAtPlxyXG5cdGRyYXcgOiAtPlx0XHJcblx0XHRmYyAxXHJcblx0XHRyZWN0IEB4LEB5LGdhbWUuU0laRSxnYW1lLlNJWkVcclxuXHRkaXN0IDogKHgseSkgLT5cdGRpc3QgeCx5LEB4LEB5IFxyXG5cclxuZHJhdyA9IC0+IGdhbWUuZHJhdygpXHJcbmtleVR5cGVkID0gLT4gZ2FtZS5rZXlUeXBlZCBrZXkudG9Mb3dlckNhc2UoKVxyXG5zZXR1cCA9IC0+XHJcblx0Y3JlYXRlQ2FudmFzIHdpbmRvd1dpZHRoLHdpbmRvd0hlaWdodFxyXG5cdGdhbWUgPSBuZXcgR2FtZVxyXG5cdHJlY3RNb2RlIENFTlRFUlxyXG5cdHRleHRBbGlnbiBDRU5URVIsQ0VOVEVSXHJcblx0dGV4dFNpemUgZ2FtZS5TSVpFXHJcbiJdfQ==
//# sourceURL=C:\Lab\2017\157-Bokstavsspel\coffee\sketch.coffee