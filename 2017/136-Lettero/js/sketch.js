// Generated by CoffeeScript 1.12.7
var angle, client, direction, draw, handleMousePressed, info, lastWord, level, listCircular, mousePressed, newGame, radius1, radius2, setup, size, touchStarted, word, words,
  indexOf = [].indexOf || function(item) { for (var i = 0, l = this.length; i < l; i++) { if (i in this && this[i] === item) return i; } return -1; };

words = null;

word = '';

lastWord = '';

level = -1;

angle = 0;

direction = 1;

size = null;

radius1 = null;

radius2 = null;

client = null;

setup = function() {
  createCanvas(windowWidth, windowHeight);
  size = min(windowWidth, windowHeight);
  client = info();
  radius2 = size / 10;
  radius1 = size / 2 - radius2;
  words = ordlista.split(' ');
  textAlign(CENTER, CENTER);
  return newGame(1);
};

newGame = function(dLevel) {
  direction = dLevel;
  level += dLevel;
  if (level < 0) {
    level = 0;
  }
  lastWord = word;
  word = _.sample(words);
  word = word.toUpperCase();
  return angle = 360 * random();
};

draw = function() {
  var ch, dAngle, i, j, len, n;
  bg(0.5);
  textSize(size / 10);
  text(lastWord, width / 2, height - size / 10);
  textSize(size / 4);
  if (direction === 1) {
    fc(0, 1, 0);
  } else {
    fc(1, 0, 0);
  }
  text(level, width / 2, height / 2);
  fc(0);
  translate(width / 2, height / 2);
  n = word.length;
  dAngle = 360 / n;
  rd(angle);
  textSize(size / 10);
  for (i = j = 0, len = word.length; j < len; i = ++j) {
    ch = word[i];
    push();
    translate(radius1, 0);
    rd(90);
    fc(1, 1, 0);
    circle(0, 0, radius2);
    fc(0);
    text(ch, 0, 0);
    pop();
    rd(dAngle);
  }
  return angle += 0.5;
};

handleMousePressed = function() {
  var ch, dword, i, j, len, n, w, x, y;
  n = word.length;
  dword = (word + word).toLowerCase();
  for (i = j = 0, len = word.length; j < len; i = ++j) {
    ch = word[i];
    x = width / 2 + radius1 * cos(radians(angle + i / n * 360));
    y = height / 2 + radius1 * sin(radians(angle + i / n * 360));
    if (radius2 > dist(mouseX, mouseY, x, y)) {
      w = dword.slice(i, i + n);
      if (indexOf.call(words, w) >= 0) {
        return newGame(1);
      }
    }
  }
  return newGame(-1);
};

mousePressed = function() {
  if (client.istouch_device) {
    handleMousePressed();
  }
  return false;
};

touchStarted = function() {
  if (!client.istouch_device) {
    handleMousePressed();
  }
  return false;
};

info = function() {
  var ratio;
  ratio = window.devicePixelRatio || 1;
  return {
    ratio: ratio,
    is_touch_device: indexOf.call(document.documentElement, 'ontouchstart') >= 0,
    sw: screen.width,
    sh: screen.height,
    cw: document.documentElement.clientWidth,
    ch: document.documentElement.clientHeight,
    rw: screen.width * ratio,
    rh: screen.height * ratio
  };
};

listCircular = function() {
  var antal, ch, dword, i, j, k, len, len1, n, res, w;
  print(words.length);
  antal = 0;
  for (j = 0, len = words.length; j < len; j++) {
    word = words[j];
    n = word.length;
    dword = (word + word).toLowerCase();
    res = [];
    for (i = k = 0, len1 = word.length; k < len1; i = ++k) {
      ch = word[i];
      w = dword.slice(i, i + n);
      if (indexOf.call(words, w) >= 0) {
        res.push(w);
      }
    }
    if (res.length === 2) {
      antal++;
    }
  }
  return print(antal);
};

//# sourceMappingURL=data:application/json;base64,eyJ2ZXJzaW9uIjozLCJmaWxlIjoic2tldGNoLmpzIiwic291cmNlUm9vdCI6Ii4uIiwic291cmNlcyI6WyJjb2ZmZWVcXHNrZXRjaC5jb2ZmZWUiXSwibmFtZXMiOltdLCJtYXBwaW5ncyI6IjtBQUFBLElBQUEsd0tBQUE7RUFBQTs7QUFBQSxLQUFBLEdBQVE7O0FBQ1IsSUFBQSxHQUFPOztBQUNQLFFBQUEsR0FBVzs7QUFDWCxLQUFBLEdBQVEsQ0FBQzs7QUFDVCxLQUFBLEdBQVE7O0FBQ1IsU0FBQSxHQUFZOztBQUNaLElBQUEsR0FBTzs7QUFDUCxPQUFBLEdBQVU7O0FBQ1YsT0FBQSxHQUFVOztBQUNWLE1BQUEsR0FBUzs7QUFFVCxLQUFBLEdBQVEsU0FBQTtFQUNQLFlBQUEsQ0FBYSxXQUFiLEVBQXlCLFlBQXpCO0VBQ0EsSUFBQSxHQUFPLEdBQUEsQ0FBSSxXQUFKLEVBQWdCLFlBQWhCO0VBQ1AsTUFBQSxHQUFTLElBQUEsQ0FBQTtFQUNULE9BQUEsR0FBVSxJQUFBLEdBQUs7RUFDZixPQUFBLEdBQVUsSUFBQSxHQUFLLENBQUwsR0FBTztFQUNqQixLQUFBLEdBQVEsUUFBUSxDQUFDLEtBQVQsQ0FBZSxHQUFmO0VBQ1IsU0FBQSxDQUFVLE1BQVYsRUFBaUIsTUFBakI7U0FFQSxPQUFBLENBQVEsQ0FBUjtBQVRPOztBQVdSLE9BQUEsR0FBVSxTQUFDLE1BQUQ7RUFDVCxTQUFBLEdBQVk7RUFDWixLQUFBLElBQVM7RUFDVCxJQUFHLEtBQUEsR0FBUSxDQUFYO0lBQWtCLEtBQUEsR0FBUSxFQUExQjs7RUFDQSxRQUFBLEdBQVc7RUFDWCxJQUFBLEdBQU8sQ0FBQyxDQUFDLE1BQUYsQ0FBUyxLQUFUO0VBQ1AsSUFBQSxHQUFPLElBQUksQ0FBQyxXQUFMLENBQUE7U0FDUCxLQUFBLEdBQVEsR0FBQSxHQUFNLE1BQUEsQ0FBQTtBQVBMOztBQVNWLElBQUEsR0FBTyxTQUFBO0FBQ04sTUFBQTtFQUFBLEVBQUEsQ0FBRyxHQUFIO0VBQ0EsUUFBQSxDQUFTLElBQUEsR0FBSyxFQUFkO0VBQ0EsSUFBQSxD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RUFBSyxNQUFNLENBQUMsS0FBUCxHQUFlLEtBTnBCO0lBT0EsRUFBQSxFQUFLLE1BQU0sQ0FBQyxNQUFQLEdBQWdCLEtBUHJCOztBQUZNOztBQVdQLFlBQUEsR0FBZSxTQUFBO0FBQ2QsTUFBQTtFQUFBLEtBQUEsQ0FBTSxLQUFLLENBQUMsTUFBWjtFQUNBLEtBQUEsR0FBUTtBQUNSLE9BQUEsdUNBQUE7O0lBQ0MsQ0FBQSxHQUFJLElBQUksQ0FBQztJQUNULEtBQUEsR0FBUSxDQUFDLElBQUEsR0FBSyxJQUFOLENBQVcsQ0FBQyxXQUFaLENBQUE7SUFDUixHQUFBLEdBQU07QUFDTixTQUFBLGdEQUFBOztNQUNDLENBQUEsR0FBSSxLQUFLLENBQUMsS0FBTixDQUFZLENBQVosRUFBYyxDQUFBLEdBQUUsQ0FBaEI7TUFDSixJQUFHLGFBQUssS0FBTCxFQUFBLENBQUEsTUFBSDtRQUFtQixHQUFHLENBQUMsSUFBSixDQUFTLENBQVQsRUFBbkI7O0FBRkQ7SUFHQSxJQUFHLEdBQUcsQ0FBQyxNQUFKLEtBQWMsQ0FBakI7TUFDQyxLQUFBLEdBREQ7O0FBUEQ7U0FTQSxLQUFBLENBQU0sS0FBTjtBQVpjIiwic291cmNlc0NvbnRlbnQiOlsid29yZHMgPSBudWxsXHJcbndvcmQgPSAnJ1xyXG5sYXN0V29yZCA9ICcnXHJcbmxldmVsID0gLTFcclxuYW5nbGUgPSAwXHJcbmRpcmVjdGlvbiA9IDFcclxuc2l6ZSA9IG51bGxcclxucmFkaXVzMSA9IG51bGxcclxucmFkaXVzMiA9IG51bGxcclxuY2xpZW50ID0gbnVsbFxyXG5cclxuc2V0dXAgPSAtPlxyXG5cdGNyZWF0ZUNhbnZhcyB3aW5kb3dXaWR0aCx3aW5kb3dIZWlnaHRcclxuXHRzaXplID0gbWluIHdpbmRvd1dpZHRoLHdpbmRvd0hlaWdodFxyXG5cdGNsaWVudCA9IGluZm8oKVxyXG5cdHJhZGl1czIgPSBzaXplLzEwXHJcblx0cmFkaXVzMSA9IHNpemUvMi1yYWRpdXMyIFxyXG5cdHdvcmRzID0gb3JkbGlzdGEuc3BsaXQgJyAnXHJcblx0dGV4dEFsaWduIENFTlRFUixDRU5URVJcclxuXHQjbGlzdENpcmN1bGFyKClcclxuXHRuZXdHYW1lIDFcclxuXHJcbm5ld0dhbWUgPSAoZExldmVsKSAtPlxyXG5cdGRpcmVjdGlvbiA9IGRMZXZlbFxyXG5cdGxldmVsICs9IGRMZXZlbFxyXG5cdGlmIGxldmVsIDwgMCB0aGVuIGxldmVsID0gMFxyXG5cdGxhc3RXb3JkID0gd29yZFxyXG5cdHdvcmQgPSBfLnNhbXBsZSB3b3Jkc1xyXG5cdHdvcmQgPSB3b3JkLnRvVXBwZXJDYXNlKClcclxuXHRhbmdsZSA9IDM2MCAqIHJhbmRvbSgpXHJcblxyXG5kcmF3ID0gLT5cclxuXHRiZyAwLjVcclxuXHR0ZXh0U2l6ZSBzaXplLzEwXHJcblx0dGV4dCBsYXN0V29yZCwgd2lkdGgvMixoZWlnaHQtc2l6ZS8xMFxyXG5cdHRleHRTaXplIHNpemUvNFxyXG5cdGlmIGRpcmVjdGlvbiA9PSAxIHRoZW4gZmMgMCwxLDAgZWxzZSBmYyAxLDAsMFxyXG5cdHRleHQgbGV2ZWwsd2lkdGgvMixoZWlnaHQvMiBcclxuXHRmYyAwXHJcblx0dHJhbnNsYXRlIHdpZHRoLzIsaGVpZ2h0LzJcclxuXHRuID0gd29yZC5sZW5ndGhcclxuXHRkQW5nbGUgPSAzNjAvblxyXG5cdHJkIGFuZ2xlXHJcblx0dGV4dFNpemUgc2l6ZS8xMFxyXG5cdGZvciBjaCxpIGluIHdvcmRcclxuXHRcdHB1c2goKVxyXG5cdFx0dHJhbnNsYXRlIHJhZGl1czEsMFxyXG5cdFx0cmQgOTBcclxuXHRcdGZjIDEsMSwwXHJcblx0XHRjaXJjbGUgMCwwLHJhZGl1czJcclxuXHRcdGZjIDBcclxuXHRcdHRleHQgY2gsMCwwXHJcblx0XHRwb3AoKVxyXG5cdFx0cmQgZEFuZ2xlXHJcblx0YW5nbGUgKz0gMC41XHJcblxyXG5oYW5kbGVNb3VzZVByZXNzZWQgPSAtPlxyXG5cdG4gPSB3b3JkLmxlbmd0aFxyXG5cdGR3b3JkID0gKHdvcmQrd29yZCkudG9Mb3dlckNhc2UoKVxyXG5cdGZvciBjaCxpIGluIHdvcmRcclxuXHRcdHggPSB3aWR0aC8yICArIHJhZGl1czEgKiBjb3MgcmFkaWFucyBhbmdsZSArIGkvbiAqIDM2MFxyXG5cdFx0eSA9IGhlaWdodC8yICsgcmFkaXVzMSAqIHNpbiByYWRpYW5zIGFuZ2xlICsgaS9uICogMzYwXHJcblx0XHRpZiByYWRpdXMyID4gZGlzdCBtb3VzZVgsbW91c2VZLHgseSBcclxuXHRcdFx0dyA9IGR3b3JkLnNsaWNlIGksaStuXHJcblx0XHRcdGlmIHcgaW4gd29yZHMgdGhlbiByZXR1cm4gbmV3R2FtZSAxXHJcblx0bmV3R2FtZSAtMVxyXG5cclxubW91c2VQcmVzc2VkID0gLT5cclxuXHRpZiBjbGllbnQuaXN0b3VjaF9kZXZpY2UgdGhlbiBoYW5kbGVNb3VzZVByZXNzZWQoKVxyXG5cdGZhbHNlXHJcblxyXG50b3VjaFN0YXJ0ZWQgPSAtPlxyXG5cdGlmIG5vdCBjbGllbnQuaXN0b3VjaF9kZXZpY2UgdGhlbiBoYW5kbGVNb3VzZVByZXNzZWQoKVxyXG5cdGZhbHNlXHRcclxuXHJcbmluZm8gPSAtPlxyXG5cdHJhdGlvID0gd2luZG93LmRldmljZVBpeGVsUmF0aW8gfHwgMVxyXG5cdHJhdGlvIDogcmF0aW9cclxuXHRpc190b3VjaF9kZXZpY2UgOiAnb250b3VjaHN0YXJ0JyBpbiBkb2N1bWVudC5kb2N1bWVudEVsZW1lbnRcclxuXHRzdyA6IHNjcmVlbi53aWR0aCBcclxuXHRzaCA6IHNjcmVlbi5oZWlnaHRcclxuXHRjdyA6IGRvY3VtZW50LmRvY3VtZW50RWxlbWVudC5jbGllbnRXaWR0aFxyXG5cdGNoIDogZG9jdW1lbnQuZG9jdW1lbnRFbGVtZW50LmNsaWVudEhlaWdodFxyXG5cdHJ3IDogc2NyZWVuLndpZHRoICogcmF0aW9cclxuXHRyaCA6IHNjcmVlbi5oZWlnaHQgKiByYXRpb1xyXG5cclxubGlzdENpcmN1bGFyID0gKCkgLT5cclxuXHRwcmludCB3b3Jkcy5sZW5ndGhcclxuXHRhbnRhbCA9IDAgXHJcblx0Zm9yIHdvcmQgaW4gd29yZHNcclxuXHRcdG4gPSB3b3JkLmxlbmd0aFxyXG5cdFx0ZHdvcmQgPSAod29yZCt3b3JkKS50b0xvd2VyQ2FzZSgpXHJcblx0XHRyZXMgPSBbXVxyXG5cdFx0Zm9yIGNoLGkgaW4gd29yZFxyXG5cdFx0XHR3ID0gZHdvcmQuc2xpY2UgaSxpK25cclxuXHRcdFx0aWYgdyBpbiB3b3JkcyB0aGVuIHJlcy5wdXNoIHdcclxuXHRcdGlmIHJlcy5sZW5ndGggPT0gMlxyXG5cdFx0XHRhbnRhbCsrXHJcblx0cHJpbnQgYW50YWwiXX0=
//# sourceURL=C:\Lab\2017\136-Lettero\coffee\sketch.coffee