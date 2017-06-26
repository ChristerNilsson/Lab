// Generated by CoffeeScript 1.11.1
var create, draw, frog, grid_size, keyPressed, obstacles, resetGame, setup;

frog = null;

obstacles = [];

grid_size = 50;

resetGame = function() {
  return frog = new Frog(width / 2, height - grid_size, grid_size, grid_size);
};

create = function(a, b, c, d, e, f) {
  var i, j, len, ref, results, x, y;
  ref = range(a);
  results = [];
  for (j = 0, len = ref.length; j < len; j++) {
    i = ref[j];
    x = i * b + c;
    y = height - d * grid_size;
    results.push(obstacles.push(new Obstacle(x, y, e * grid_size, grid_size, f)));
  }
  return results;
};

setup = function() {
  createCanvas(700, 700);
  resetGame();
  create(2, 400, 10, 12, 4, 0.5);
  create(3, 250, 30, 11, 2, -1.4);
  create(2, 250, 100, 10, 3, 2.2);
  create(3, 200, 30, 9, 2, -1.3);
  create(2, 200, 100, 8, 3, 2.3);
  create(3, 150, 25, 6, 1, 1.2);
  create(2, 200, 150, 5, 1, -3.5);
  create(3, 150, 25, 4, 1, 1.3);
  create(2, 200, 150, 3, 1, -3.4);
  return create(2, 300, 0, 2, 2, 2);
};

draw = function() {
  var intersector, j, len, o;
  background(0);
  fill(255, 100);
  rect(0, 0, width, 2 * grid_size);
  rect(0, height - 7 * grid_size, width, grid_size);
  rect(0, height - grid_size, width, grid_size);
  intersector = null;
  for (j = 0, len = obstacles.length; j < len; j++) {
    o = obstacles[j];
    o.show();
    o.update();
    if (frog.intersects(o)) {
      intersector = o;
    }
  }
  frog.attach(null);
  if (frog.y >= height - grid_size * 7) {
    if (intersector !== null) {
      resetGame();
    }
  } else if (frog.y >= 2 * grid_size) {
    if (intersector === null) {
      resetGame();
    } else {
      frog.attach(intersector);
    }
  }
  frog.update();
  return frog.show();
};

keyPressed = function() {
  if (keyCode === UP_ARROW) {
    frog.move(0, -grid_size);
  }
  if (keyCode === DOWN_ARROW) {
    frog.move(0, grid_size);
  }
  if (keyCode === LEFT_ARROW) {
    frog.move(-grid_size, 0);
  }
  if (keyCode === RIGHT_ARROW) {
    return frog.move(grid_size, 0);
  }
};

//# sourceMappingURL=data:application/json;base64,eyJ2ZXJzaW9uIjozLCJmaWxlIjoic2tldGNoLmpzIiwic291cmNlUm9vdCI6Ii4uIiwic291cmNlcyI6WyJjb2ZmZWVcXHNrZXRjaC5jb2ZmZWUiXSwibmFtZXMiOltdLCJtYXBwaW5ncyI6IjtBQUFBLElBQUE7O0FBQUEsSUFBQSxHQUFPOztBQUNQLFNBQUEsR0FBWTs7QUFDWixTQUFBLEdBQVk7O0FBRVosU0FBQSxHQUFZLFNBQUE7U0FBRyxJQUFBLEdBQVcsSUFBQSxJQUFBLENBQUssS0FBQSxHQUFRLENBQWIsRUFBZ0IsTUFBQSxHQUFTLFNBQXpCLEVBQW9DLFNBQXBDLEVBQStDLFNBQS9DO0FBQWQ7O0FBRVosTUFBQSxHQUFTLFNBQUMsQ0FBRCxFQUFHLENBQUgsRUFBSyxDQUFMLEVBQU8sQ0FBUCxFQUFTLENBQVQsRUFBVyxDQUFYO0FBQ1IsTUFBQTtBQUFBO0FBQUE7T0FBQSxxQ0FBQTs7SUFDQyxDQUFBLEdBQUksQ0FBQSxHQUFJLENBQUosR0FBUTtJQUNaLENBQUEsR0FBSSxNQUFBLEdBQVMsQ0FBQSxHQUFJO2lCQUNqQixTQUFTLENBQUMsSUFBVixDQUFtQixJQUFBLFFBQUEsQ0FBUyxDQUFULEVBQVksQ0FBWixFQUFlLENBQUEsR0FBSSxTQUFuQixFQUE4QixTQUE5QixFQUF5QyxDQUF6QyxDQUFuQjtBQUhEOztBQURROztBQU1ULEtBQUEsR0FBUSxTQUFBO0VBQ1AsWUFBQSxDQUFhLEdBQWIsRUFBa0IsR0FBbEI7RUFDQSxTQUFBLENBQUE7RUFDQSxNQUFBLENBQU8sQ0FBUCxFQUFTLEdBQVQsRUFBYyxFQUFkLEVBQWlCLEVBQWpCLEVBQW9CLENBQXBCLEVBQXNCLEdBQXRCO0VBQ0EsTUFBQSxDQUFPLENBQVAsRUFBUyxHQUFULEVBQWMsRUFBZCxFQUFpQixFQUFqQixFQUFvQixDQUFwQixFQUFzQixDQUFDLEdBQXZCO0VBQ0EsTUFBQSxDQUFPLENBQVAsRUFBUyxHQUFULEVBQWEsR0FBYixFQUFpQixFQUFqQixFQUFvQixDQUFwQixFQUFzQixHQUF0QjtFQUNBLE1BQUEsQ0FBTyxDQUFQLEVBQVMsR0FBVCxFQUFjLEVBQWQsRUFBaUIsQ0FBakIsRUFBbUIsQ0FBbkIsRUFBcUIsQ0FBQyxHQUF0QjtFQUNBLE1BQUEsQ0FBTyxDQUFQLEVBQVMsR0FBVCxFQUFhLEdBQWIsRUFBaUIsQ0FBakIsRUFBbUIsQ0FBbkIsRUFBcUIsR0FBckI7RUFFQSxNQUFBLENBQU8sQ0FBUCxFQUFTLEdBQVQsRUFBYyxFQUFkLEVBQWlCLENBQWpCLEVBQW1CLENBQW5CLEVBQXFCLEdBQXJCO0VBQ0EsTUFBQSxDQUFPLENBQVAsRUFBUyxHQUFULEVBQWEsR0FBYixFQUFpQixDQUFqQixFQUFtQixDQUFuQixFQUFxQixDQUFDLEdBQXRCO0VBQ0EsTUFBQSxDQUFPLENBQVAsRUFBUyxHQUFULEVBQWMsRUFBZCxFQUFpQixDQUFqQixFQUFtQixDQUFuQixFQUFxQixHQUFyQjtFQUNBLE1BQUEsQ0FBTyxDQUFQLEVBQVMsR0FBVCxFQUFhLEdBQWIsRUFBaUIsQ0FBakIsRUFBbUIsQ0FBbkIsRUFBcUIsQ0FBQyxHQUF0QjtTQUNBLE1BQUEsQ0FBTyxDQUFQLEVBQVMsR0FBVCxFQUFlLENBQWYsRUFBaUIsQ0FBakIsRUFBbUIsQ0FBbkIsRUFBcUIsQ0FBckI7QUFiTzs7QUFlUixJQUFBLEdBQU8sU0FBQTtBQUNOLE1BQUE7RUFBQSxVQUFBLENBQVcsQ0FBWDtFQUNBLElBQUEsQ0FBSyxHQUFMLEVBQVUsR0FBVjtFQUVBLElBQUEsQ0FBSyxDQUFMLEVBQVEsQ0FBUixFQUFXLEtBQVgsRUFBa0IsQ0FBQSxHQUFJLFNBQXRCO0VBQ0EsSUFBQSxDQUFLLENBQUwsRUFBUSxNQUFBLEdBQVMsQ0FBQSxHQUFJLFNBQXJCLEVBQWdDLEtBQWhDLEVBQXVDLFNBQXZDO0VBQ0EsSUFBQSxDQUFLLENBQUwsRUFBUSxNQUFBLEdBQVMsU0FBakIsRUFBNEIsS0FBNUIsRUFBbUMsU0FBbkM7RUFFQSxXQUFBLEdBQWM7QUFDZCxPQUFBLDJDQUFBOztJQUNDLENBQUMsQ0FBQyxJQUFGLENBQUE7SUFDQSxDQUFDLENBQUMsTUFBRixDQUFBO0lBQ0EsSUFBRyxJQUFJLENBQUMsVUFBTCxDQUFnQixDQUFoQixDQUFIO01BQTBCLFdBQUEsR0FBYyxFQUF4Qzs7QUFIRDtFQUlBLElBQUksQ0FBQyxNQUFMLENBQVksSUFBWjtFQUNBLElBQUcsSUFBSSxDQUFDLENBQUwsSUFBVSxNQUFBLEdBQVMsU0FBQSxHQUFZLENBQWxDO0lBQ0MsSUFBRyxXQUFBLEtBQWUsSUFBbEI7TUFBNEIsU0FBQSxDQUFBLEVBQTVCO0tBREQ7R0FBQSxNQUVLLElBQUcsSUFBSSxDQUFDLENBQUwsSUFBVSxDQUFBLEdBQUksU0FBakI7SUFDSixJQUFHLFdBQUEsS0FBZSxJQUFsQjtNQUE0QixTQUFBLENBQUEsRUFBNUI7S0FBQSxNQUFBO01BQTZDLElBQUksQ0FBQyxNQUFMLENBQVksV0FBWixFQUE3QztLQURJOztFQUVMLElBQUksQ0FBQyxNQUFMLENBQUE7U0FDQSxJQUFJLENBQUMsSUFBTCxDQUFBO0FBbkJNOztBQXFCUCxVQUFBLEdBQWEsU0FBQTtFQUNaLElBQUcsT0FBQSxLQUFXLFFBQWQ7SUFBK0IsSUFBSSxDQUFDLElBQUwsQ0FBVSxDQUFWLEVBQWEsQ0FBQyxTQUFkLEVBQS9COztFQUNBLElBQUcsT0FBQSxLQUFXLFVBQWQ7SUFBK0IsSUFBSSxDQUFDLElBQUwsQ0FBVSxDQUFWLEVBQWEsU0FBYixFQUEvQjs7RUFDQSxJQUFHLE9BQUEsS0FBVyxVQUFkO0lBQStCLElBQUksQ0FBQyxJQUFMLENBQVUsQ0FBQyxTQUFYLEVBQXNCLENBQXRCLEVBQS9COztFQUNBLElBQUcsT0FBQSxLQUFXLFdBQWQ7V0FBK0IsSUFBSSxDQUFDLElBQUwsQ0FBVSxTQUFWLEVBQXFCLENBQXJCLEVBQS9COztBQUpZIiwic291cmNlc0NvbnRlbnQiOlsiZnJvZyA9IG51bGxcclxub2JzdGFjbGVzID0gW11cclxuZ3JpZF9zaXplID0gNTBcclxuXHJcbnJlc2V0R2FtZSA9IC0+IGZyb2cgPSBuZXcgRnJvZyB3aWR0aCAvIDIsIGhlaWdodCAtIGdyaWRfc2l6ZSwgZ3JpZF9zaXplLCBncmlkX3NpemVcclxuXHJcbmNyZWF0ZSA9IChhLGIsYyxkLGUsZikgLT5cclxuXHRmb3IgaSBpbiByYW5nZSBhXHJcblx0XHR4ID0gaSAqIGIgKyBjXHJcblx0XHR5ID0gaGVpZ2h0IC0gZCAqIGdyaWRfc2l6ZVxyXG5cdFx0b2JzdGFjbGVzLnB1c2ggbmV3IE9ic3RhY2xlIHgsIHksIGUgKiBncmlkX3NpemUsIGdyaWRfc2l6ZSwgZlxyXG5cclxuc2V0dXAgPSAtPlxyXG5cdGNyZWF0ZUNhbnZhcyA3MDAsIDcwMFxyXG5cdHJlc2V0R2FtZSgpXHJcblx0Y3JlYXRlIDIsNDAwLCAxMCwxMiw0LDAuNVxyXG5cdGNyZWF0ZSAzLDI1MCwgMzAsMTEsMiwtMS40XHJcblx0Y3JlYXRlIDIsMjUwLDEwMCwxMCwzLDIuMlxyXG5cdGNyZWF0ZSAzLDIwMCwgMzAsOSwyLC0xLjNcclxuXHRjcmVhdGUgMiwyMDAsMTAwLDgsMywyLjNcclxuXHJcblx0Y3JlYXRlIDMsMTUwLCAyNSw2LDEsMS4yXHJcblx0Y3JlYXRlIDIsMjAwLDE1MCw1LDEsLTMuNVxyXG5cdGNyZWF0ZSAzLDE1MCwgMjUsNCwxLDEuM1xyXG5cdGNyZWF0ZSAyLDIwMCwxNTAsMywxLC0zLjRcclxuXHRjcmVhdGUgMiwzMDAsICAwLDIsMiwyXHJcblxyXG5kcmF3ID0gLT5cclxuXHRiYWNrZ3JvdW5kIDBcclxuXHRmaWxsIDI1NSwgMTAwXHJcblxyXG5cdHJlY3QgMCwgMCwgd2lkdGgsIDIgKiBncmlkX3NpemVcclxuXHRyZWN0IDAsIGhlaWdodCAtIDcgKiBncmlkX3NpemUsIHdpZHRoLCBncmlkX3NpemVcclxuXHRyZWN0IDAsIGhlaWdodCAtIGdyaWRfc2l6ZSwgd2lkdGgsIGdyaWRfc2l6ZVxyXG5cclxuXHRpbnRlcnNlY3RvciA9IG51bGxcclxuXHRmb3IgbyBpbiBvYnN0YWNsZXNcclxuXHRcdG8uc2hvdygpXHJcblx0XHRvLnVwZGF0ZSgpXHJcblx0XHRpZiBmcm9nLmludGVyc2VjdHMgbyB0aGVuIGludGVyc2VjdG9yID0gb1xyXG5cdGZyb2cuYXR0YWNoIG51bGxcclxuXHRpZiBmcm9nLnkgPj0gaGVpZ2h0IC0gZ3JpZF9zaXplICogN1xyXG5cdFx0aWYgaW50ZXJzZWN0b3IgIT0gbnVsbCB0aGVuIHJlc2V0R2FtZSgpXHJcblx0ZWxzZSBpZiBmcm9nLnkgPj0gMiAqIGdyaWRfc2l6ZVxyXG5cdFx0aWYgaW50ZXJzZWN0b3IgPT0gbnVsbCB0aGVuIHJlc2V0R2FtZSgpIGVsc2UgZnJvZy5hdHRhY2ggaW50ZXJzZWN0b3JcclxuXHRmcm9nLnVwZGF0ZSgpXHJcblx0ZnJvZy5zaG93KClcclxuXHJcbmtleVByZXNzZWQgPSAtPlxyXG5cdGlmIGtleUNvZGUgPT0gVVBfQVJST1cgICAgdGhlbiBmcm9nLm1vdmUgMCwgLWdyaWRfc2l6ZVxyXG5cdGlmIGtleUNvZGUgPT0gRE9XTl9BUlJPVyAgdGhlbiBmcm9nLm1vdmUgMCwgZ3JpZF9zaXplXHJcblx0aWYga2V5Q29kZSA9PSBMRUZUX0FSUk9XICB0aGVuIGZyb2cubW92ZSAtZ3JpZF9zaXplLCAwXHJcblx0aWYga2V5Q29kZSA9PSBSSUdIVF9BUlJPVyB0aGVuIGZyb2cubW92ZSBncmlkX3NpemUsIDAiXX0=
//# sourceURL=C:\Lab\2017\053-Frogger\coffee\sketch.coffee