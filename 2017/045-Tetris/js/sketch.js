// Generated by CoffeeScript 1.11.1
var arena, arenaSweep, collide, createPiece, draw, drawMatrix, fcc, i, keyPressed, merge, player, playerDrop, playerMove, playerReset, playerRotate, rotera, setup, updateScore;

arena = (function() {
  var j, len, ref, results;
  ref = range(20);
  results = [];
  for (j = 0, len = ref.length; j < len; j++) {
    i = ref[j];
    results.push(new Array(12).fill(0));
  }
  return results;
})();

player = {
  pos: {
    x: 0,
    y: 0
  },
  matrix: null,
  score: 0
};

setup = function() {
  createCanvas(20 * 12, 20 * 20);
  frameRate(3);
  playerReset();
  return updateScore();
};

fcc = function(n) {
  if (n === 0) {
    return fc(1);
  } else if (n === 1) {
    return fc(1, 0, 0);
  } else if (n === 2) {
    return fc(0, 1, 0);
  } else if (n === 3) {
    return fc(0, 0, 1);
  } else if (n === 4) {
    return fc(1, 1, 0);
  } else if (n === 5) {
    return fc(0, 1, 1);
  } else if (n === 6) {
    return fc(1, 0, 1);
  } else if (n === 7) {
    return fc(0.5);
  }
};

arenaSweep = function() {
  var j, len, rad, ref, results, row, y;
  ref = range(arena.length);
  results = [];
  for (j = 0, len = ref.length; j < len; j++) {
    i = ref[j];
    y = 19 - i;
    rad = arena[y];
    if (!_.contains(rad, 0)) {
      row = arena.splice(y, 1)[0].fill(0);
      arena.unshift(row);
      results.push(player.score += 10);
    } else {
      results.push(void 0);
    }
  }
  return results;
};

collide = function(arena, player) {
  var j, k, len, len1, m, o, ref, ref1, x, y;
  m = player.matrix;
  o = player.pos;
  ref = range(m.length);
  for (j = 0, len = ref.length; j < len; j++) {
    y = ref[j];
    ref1 = range(m[y].length);
    for (k = 0, len1 = ref1.length; k < len1; k++) {
      x = ref1[k];
      if (m[y][x] !== 0 && (arena[y + o.y] && arena[y + o.y][x + o.x]) !== 0) {
        return true;
      }
    }
  }
  return false;
};

createPiece = function(type) {
  if (type === 'I') {
    return [[0, 1, 0, 0], [0, 1, 0, 0], [0, 1, 0, 0], [0, 1, 0, 0]];
  } else if (type === 'L') {
    return [[0, 2, 0], [0, 2, 0], [0, 2, 2]];
  } else if (type === 'J') {
    return [[0, 3, 0], [0, 3, 0], [3, 3, 0]];
  } else if (type === 'O') {
    return [[4, 4], [4, 4]];
  } else if (type === 'Z') {
    return [[5, 5, 0], [0, 5, 5], [0, 0, 0]];
  } else if (type === 'S') {
    return [[0, 6, 6], [6, 6, 0], [0, 0, 0]];
  } else if (type === 'T') {
    return [[0, 7, 0], [7, 7, 7], [0, 0, 0]];
  }
};

drawMatrix = function(matrix, offset) {
  var j, len, results, row, value, x, y;
  results = [];
  for (y = j = 0, len = matrix.length; j < len; y = ++j) {
    row = matrix[y];
    results.push((function() {
      var k, len1, results1;
      results1 = [];
      for (x = k = 0, len1 = row.length; k < len1; x = ++k) {
        value = row[x];
        if (value !== 0) {
          fcc(value);
          results1.push(rect(20 * (x + offset.x), 20 * (y + offset.y), 20, 20));
        } else {
          results1.push(void 0);
        }
      }
      return results1;
    })());
  }
  return results;
};

draw = function() {
  bg(0);
  drawMatrix(arena, {
    x: 0,
    y: 0
  });
  drawMatrix(player.matrix, player.pos);
  return arenaSweep();
};

merge = function(arena, player) {
  var j, len, ref, results, row, value, x, y;
  ref = player.matrix;
  results = [];
  for (y = j = 0, len = ref.length; j < len; y = ++j) {
    row = ref[y];
    results.push((function() {
      var k, len1, results1;
      results1 = [];
      for (x = k = 0, len1 = row.length; k < len1; x = ++k) {
        value = row[x];
        if (value !== 0) {
          results1.push(arena[y + player.pos.y][x + player.pos.x] = value);
        } else {
          results1.push(void 0);
        }
      }
      return results1;
    })());
  }
  return results;
};

rotera = function(matrix, dir) {
  var j, k, l, len, len1, len2, ref, ref1, ref2, results, row, x, y;
  ref = range(matrix.length);
  for (j = 0, len = ref.length; j < len; j++) {
    y = ref[j];
    ref1 = range(y);
    for (k = 0, len1 = ref1.length; k < len1; k++) {
      x = ref1[k];
      ref2 = [matrix[y][x], matrix[x][y]], matrix[x][y] = ref2[0], matrix[y][x] = ref2[1];
    }
  }
  if (dir > 0) {
    results = [];
    for (l = 0, len2 = matrix.length; l < len2; l++) {
      row = matrix[l];
      results.push(row.reverse());
    }
    return results;
  } else {
    return matrix.reverse();
  }
};

playerDrop = function() {
  var dropCounter;
  player.pos.y++;
  if (collide(arena, player)) {
    player.pos.y--;
    merge(arena, player);
    playerReset();
    arenaSweep();
    updateScore();
  }
  return dropCounter = 0;
};

playerMove = function(offset) {
  player.pos.x += offset;
  if (collide(arena, player)) {
    return player.pos.x -= offset;
  }
};

playerReset = function() {
  var j, len, pieces, row;
  pieces = 'TJLOSZI';
  player.matrix = createPiece(pieces[pieces.length * Math.random() | 0]);
  player.pos.y = 0;
  player.pos.x = (arena[0].length / 2 | 0) - (player.matrix[0].length / 2 | 0);
  if (collide(arena, player)) {
    for (j = 0, len = arena.length; j < len; j++) {
      row = arena[j];
      row.fill(0);
    }
    player.score = 0;
    return updateScore();
  }
};

playerRotate = function(dir) {
  var offset, pos, ref;
  pos = player.pos.x;
  offset = 1;
  rotera(player.matrix, dir);
  while (collide(arena, player)) {
    player.pos.x += offset;
    offset = -(offset + ((ref = offset > 0) != null ? ref : {
      1: -1
    }));
    if (offset > player.matrix[0].length) {
      rotera(player.matrix, -dir);
      player.pos.x = pos;
      return;
    }
  }
};

updateScore = function() {};

keyPressed = function() {
  if (keyCode === 37) {
    return playerMove(-1);
  } else if (keyCode === 39) {
    return playerMove(1);
  } else if (keyCode === 40) {
    return playerDrop();
  } else if (keyCode === 81) {
    return playerRotate(-1);
  } else if (keyCode === 87) {
    return playerRotate(1);
  } else if (keyCode === 32) {
    return playerDrop();
  }
};

//# sourceMappingURL=data:application/json;base64,eyJ2ZXJzaW9uIjozLCJmaWxlIjoic2tldGNoLmpzIiwic291cmNlUm9vdCI6Ii4uIiwic291cmNlcyI6WyJjb2ZmZWVcXHNrZXRjaC5jb2ZmZWUiXSwibmFtZXMiOltdLCJtYXBwaW5ncyI6IjtBQUFBLElBQUE7O0FBQUEsS0FBQTs7QUFBUztBQUFBO09BQUEscUNBQUE7O2lCQUFJLElBQUEsS0FBQSxDQUFNLEVBQU4sQ0FBUyxDQUFDLElBQVYsQ0FBZSxDQUFmO0FBQUo7Ozs7QUFDVCxNQUFBLEdBQVM7RUFBQyxHQUFBLEVBQUs7SUFBQyxDQUFBLEVBQUcsQ0FBSjtJQUFPLENBQUEsRUFBRyxDQUFWO0dBQU47RUFBb0IsTUFBQSxFQUFRLElBQTVCO0VBQWtDLEtBQUEsRUFBTyxDQUF6Qzs7O0FBQ1QsS0FBQSxHQUFRLFNBQUE7RUFDUCxZQUFBLENBQWEsRUFBQSxHQUFHLEVBQWhCLEVBQW1CLEVBQUEsR0FBRyxFQUF0QjtFQUNBLFNBQUEsQ0FBVSxDQUFWO0VBQ0EsV0FBQSxDQUFBO1NBQ0EsV0FBQSxDQUFBO0FBSk87O0FBS1IsR0FBQSxHQUFNLFNBQUMsQ0FBRDtFQUNMLElBQUcsQ0FBQSxLQUFHLENBQU47V0FBYSxFQUFBLENBQUcsQ0FBSCxFQUFiO0dBQUEsTUFDSyxJQUFHLENBQUEsS0FBRyxDQUFOO1dBQWEsRUFBQSxDQUFHLENBQUgsRUFBSyxDQUFMLEVBQU8sQ0FBUCxFQUFiO0dBQUEsTUFDQSxJQUFHLENBQUEsS0FBRyxDQUFOO1dBQWEsRUFBQSxDQUFHLENBQUgsRUFBSyxDQUFMLEVBQU8sQ0FBUCxFQUFiO0dBQUEsTUFDQSxJQUFHLENBQUEsS0FBRyxDQUFOO1dBQWEsRUFBQSxDQUFHLENBQUgsRUFBSyxDQUFMLEVBQU8sQ0FBUCxFQUFiO0dBQUEsTUFDQSxJQUFHLENBQUEsS0FBRyxDQUFOO1dBQWEsRUFBQSxDQUFHLENBQUgsRUFBSyxDQUFMLEVBQU8sQ0FBUCxFQUFiO0dBQUEsTUFDQSxJQUFHLENBQUEsS0FBRyxDQUFOO1dBQWEsRUFBQSxDQUFHLENBQUgsRUFBSyxDQUFMLEVB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QUE3QjtNQUNDLE1BQUEsQ0FBTyxNQUFNLENBQUMsTUFBZCxFQUFzQixDQUFDLEdBQXZCO01BQ0EsTUFBTSxDQUFDLEdBQUcsQ0FBQyxDQUFYLEdBQWU7QUFDZixhQUhEOztFQUhEO0FBSmM7O0FBV2YsV0FBQSxHQUFjLFNBQUEsR0FBQTs7QUFDZCxVQUFBLEdBQWEsU0FBQTtFQUNaLElBQUcsT0FBQSxLQUFXLEVBQWQ7V0FBc0IsVUFBQSxDQUFXLENBQUMsQ0FBWixFQUF0QjtHQUFBLE1BQ0ssSUFBRyxPQUFBLEtBQVcsRUFBZDtXQUFzQixVQUFBLENBQVcsQ0FBWCxFQUF0QjtHQUFBLE1BQ0EsSUFBRyxPQUFBLEtBQVcsRUFBZDtXQUFzQixVQUFBLENBQUEsRUFBdEI7R0FBQSxNQUNBLElBQUcsT0FBQSxLQUFXLEVBQWQ7V0FBc0IsWUFBQSxDQUFhLENBQUMsQ0FBZCxFQUF0QjtHQUFBLE1BQ0EsSUFBRyxPQUFBLEtBQVcsRUFBZDtXQUFzQixZQUFBLENBQWEsQ0FBYixFQUF0QjtHQUFBLE1BQ0EsSUFBRyxPQUFBLEtBQVcsRUFBZDtXQUFzQixVQUFBLENBQUEsRUFBdEI7O0FBTk8iLCJzb3VyY2VzQ29udGVudCI6WyJhcmVuYSA9IChuZXcgQXJyYXkoMTIpLmZpbGwoMCkgZm9yIGkgaW4gcmFuZ2UgMjApXHJcbnBsYXllciA9IHtwb3M6IHt4OiAwLCB5OiAwfSxcdG1hdHJpeDogbnVsbCxcdHNjb3JlOiAwfVxyXG5zZXR1cCA9IC0+XHJcblx0Y3JlYXRlQ2FudmFzIDIwKjEyLDIwKjIwXHJcblx0ZnJhbWVSYXRlIDNcclxuXHRwbGF5ZXJSZXNldCgpXHJcblx0dXBkYXRlU2NvcmUoKVxyXG5mY2MgPSAobikgLT5cclxuXHRpZiBuPT0wIHRoZW4gZmMgMVxyXG5cdGVsc2UgaWYgbj09MSB0aGVuIGZjIDEsMCwwXHJcblx0ZWxzZSBpZiBuPT0yIHRoZW4gZmMgMCwxLDBcclxuXHRlbHNlIGlmIG49PTMgdGhlbiBmYyAwLDAsMVxyXG5cdGVsc2UgaWYgbj09NCB0aGVuIGZjIDEsMSwwXHJcblx0ZWxzZSBpZiBuPT01IHRoZW4gZmMgMCwxLDFcclxuXHRlbHNlIGlmIG49PTYgdGhlbiBmYyAxLDAsMVxyXG5cdGVsc2UgaWYgbj09NyB0aGVuIGZjIDAuNVxyXG5hcmVuYVN3ZWVwID0gLT5cclxuXHRmb3IgaSBpbiByYW5nZSBhcmVuYS5sZW5ndGhcclxuXHRcdHkgPSAxOS1pXHJcblx0XHRyYWQgPSBhcmVuYVt5XVxyXG5cdFx0aWYgbm90IF8uY29udGFpbnMgcmFkLCAwXHJcblx0XHRcdHJvdyA9IGFyZW5hLnNwbGljZSh5LCAxKVswXS5maWxsIDBcclxuXHRcdFx0YXJlbmEudW5zaGlmdCByb3dcclxuXHRcdFx0cGxheWVyLnNjb3JlICs9IDEwXHJcbmNvbGxpZGUgPSAoYXJlbmEsIHBsYXllcikgLT5cclxuXHRtID0gcGxheWVyLm1hdHJpeFxyXG5cdG8gPSBwbGF5ZXIucG9zXHJcblx0Zm9yIHkgaW4gcmFuZ2UgbS5sZW5ndGhcclxuXHRcdGZvciB4IGluIHJhbmdlIG1beV0ubGVuZ3RoXHJcblx0XHRcdGlmIChtW3ldW3hdICE9IDAgYW5kIChhcmVuYVt5ICsgby55XSBhbmQgYXJlbmFbeSArIG8ueV1beCArIG8ueF0pICE9IDApIHRoZW4gcmV0dXJuIHRydWVcclxuXHRmYWxzZVxyXG5jcmVhdGVQaWVjZSA9ICh0eXBlKSAtPlxyXG5cdGlmIHR5cGUgPT0gJ0knIHRoZW5cdHJldHVybiBbWzAsIDEsIDAsIDBdLFx0WzAsIDEsIDAsIDBdLFx0WzAsIDEsIDAsIDBdLFx0WzAsIDEsIDAsIDBdLF1cclxuXHRlbHNlIGlmIHR5cGUgPT0gJ0wnIHRoZW4gcmV0dXJuIFtbMCwgMiwgMF0sWzAsIDIsIDBdLFswLCAyLCAyXSxdXHJcblx0ZWxzZSBpZiB0eXBlID09ICdKJyB0aGVuIHJldHVybiBbWzAsIDMsIDBdLFswLCAzLCAwXSxbMywgMywgMF0sXVxyXG5cdGVsc2UgaWYgdHlwZSA9PSAnTycgdGhlbiByZXR1cm4gW1s0LCA0XSxbNCwgNF0sXVxyXG5cdGVsc2UgaWYgdHlwZSA9PSAnWicgdGhlbiByZXR1cm4gW1s1LCA1LCAwXSxbMCwgNSwgNV0sWzAsIDAsIDBdXVxyXG5cdGVsc2UgaWYgdHlwZSA9PSAnUycgdGhlbiByZXR1cm4gW1swLCA2LCA2XSxbNiwgNiwgMF0sWzAsIDAsIDBdXVxyXG5cdGVsc2UgaWYgdHlwZSA9PSAnVCcgdGhlbiByZXR1cm4gW1swLCA3LCAwXSxbNywgNywgN10sWzAsIDAsIDBdXVxyXG5kcmF3TWF0cml4ID0gKG1hdHJpeCwgb2Zmc2V0KSAtPlxyXG5cdGZvciByb3cseSBpbiBtYXRyaXhcclxuXHRcdGZvciB2YWx1ZSx4IGluIHJvd1xyXG5cdFx0XHRpZiB2YWx1ZSAhPSAwXHJcblx0XHRcdFx0ZmNjIHZhbHVlXHJcblx0XHRcdFx0cmVjdCAyMCooeCArIG9mZnNldC54KSwgMjAqKHkgKyBvZmZzZXQueSksMjAsIDIwXHJcbmRyYXcgPSAtPlxyXG5cdGJnIDBcclxuXHRkcmF3TWF0cml4IGFyZW5hLCB7eDogMCwgeTogMH1cclxuXHRkcmF3TWF0cml4IHBsYXllci5tYXRyaXgsIHBsYXllci5wb3NcclxuXHQjcGxheWVyRHJvcCgpXHJcblx0YXJlbmFTd2VlcCgpXHJcbm1lcmdlID0gKGFyZW5hLCBwbGF5ZXIpIC0+XHJcblx0Zm9yIHJvdyx5IGluIHBsYXllci5tYXRyaXhcclxuXHRcdGZvciB2YWx1ZSx4IGluIHJvd1xyXG5cdFx0XHRpZiB2YWx1ZSAhPSAwIHRoZW4gYXJlbmFbeSArIHBsYXllci5wb3MueV1beCArIHBsYXllci5wb3MueF0gPSB2YWx1ZVxyXG5yb3RlcmEgPSAobWF0cml4LCBkaXIpIC0+XHJcblx0Zm9yIHkgaW4gcmFuZ2UgbWF0cml4Lmxlbmd0aFxyXG5cdFx0Zm9yIHggaW4gcmFuZ2UgeVxyXG5cdFx0XHRbbWF0cml4W3hdW3ldLCBtYXRyaXhbeV1beF1dID0gW21hdHJpeFt5XVt4XSxtYXRyaXhbeF1beV1dXHJcblx0aWYgZGlyID4gMFxyXG5cdFx0cm93LnJldmVyc2UoKSBmb3Igcm93IGluIG1hdHJpeFxyXG5cdGVsc2VcclxuXHRcdG1hdHJpeC5yZXZlcnNlKClcclxucGxheWVyRHJvcCA9IC0+XHJcblx0cGxheWVyLnBvcy55KytcclxuXHRpZiBjb2xsaWRlIGFyZW5hLCBwbGF5ZXJcclxuXHRcdHBsYXllci5wb3MueS0tXHJcblx0XHRtZXJnZSBhcmVuYSwgcGxheWVyXHJcblx0XHRwbGF5ZXJSZXNldCgpXHJcblx0XHRhcmVuYVN3ZWVwKClcclxuXHRcdHVwZGF0ZVNjb3JlKClcclxuXHRkcm9wQ291bnRlciA9IDBcclxucGxheWVyTW92ZSA9IChvZmZzZXQpIC0+XHJcblx0cGxheWVyLnBvcy54ICs9IG9mZnNldFxyXG5cdGlmIGNvbGxpZGUgYXJlbmEsIHBsYXllciB0aGVuIHBsYXllci5wb3MueCAtPSBvZmZzZXRcclxucGxheWVyUmVzZXQgPSAtPlxyXG5cdHBpZWNlcyA9ICdUSkxPU1pJJ1xyXG5cdHBsYXllci5tYXRyaXggPSBjcmVhdGVQaWVjZShwaWVjZXNbcGllY2VzLmxlbmd0aCAqIE1hdGgucmFuZG9tKCkgfCAwXSk7XHJcblx0cGxheWVyLnBvcy55ID0gMFxyXG5cdHBsYXllci5wb3MueCA9IChhcmVuYVswXS5sZW5ndGggLyAyIHwgMCkgLSAocGxheWVyLm1hdHJpeFswXS5sZW5ndGggLyAyIHwgMClcclxuXHRpZiBjb2xsaWRlIGFyZW5hLCBwbGF5ZXJcclxuXHRcdHJvdy5maWxsKDApIGZvciByb3cgaW4gYXJlbmFcclxuXHRcdHBsYXllci5zY29yZSA9IDBcclxuXHRcdHVwZGF0ZVNjb3JlKClcclxucGxheWVyUm90YXRlID0gKGRpcikgLT5cclxuXHRwb3MgPSBwbGF5ZXIucG9zLnhcclxuXHRvZmZzZXQgPSAxXHJcblx0cm90ZXJhIHBsYXllci5tYXRyaXgsIGRpclxyXG5cdHdoaWxlIGNvbGxpZGUgYXJlbmEsIHBsYXllclxyXG5cdFx0cGxheWVyLnBvcy54ICs9IG9mZnNldFxyXG5cdFx0b2Zmc2V0ID0gLShvZmZzZXQgKyAob2Zmc2V0ID4gMCA/IDEgOiAtMSkpXHJcblx0XHRpZiBvZmZzZXQgPiBwbGF5ZXIubWF0cml4WzBdLmxlbmd0aFxyXG5cdFx0XHRyb3RlcmEgcGxheWVyLm1hdHJpeCwgLWRpclxyXG5cdFx0XHRwbGF5ZXIucG9zLnggPSBwb3NcclxuXHRcdFx0cmV0dXJuXHJcbnVwZGF0ZVNjb3JlID0gLT4gIyBwcmludCBwbGF5ZXIuc2NvcmVcclxua2V5UHJlc3NlZCA9IC0+XHJcblx0aWYga2V5Q29kZSA9PSAzNyB0aGVuIHBsYXllck1vdmUgLTEgIyBMRUZUXHJcblx0ZWxzZSBpZiBrZXlDb2RlID09IDM5IHRoZW4gcGxheWVyTW92ZSAxICMgUklHSFRcclxuXHRlbHNlIGlmIGtleUNvZGUgPT0gNDAgdGhlbiBwbGF5ZXJEcm9wKCkgIyBET1dOXHJcblx0ZWxzZSBpZiBrZXlDb2RlID09IDgxIHRoZW4gcGxheWVyUm90YXRlIC0xICMgUVxyXG5cdGVsc2UgaWYga2V5Q29kZSA9PSA4NyB0aGVuIHBsYXllclJvdGF0ZSAxICMgV1xyXG5cdGVsc2UgaWYga2V5Q29kZSA9PSAzMiB0aGVuIHBsYXllckRyb3AoKSAjIFdcclxuIl19
//# sourceURL=C:\Lab\2017\045-Tetris\coffee\sketch.coffee