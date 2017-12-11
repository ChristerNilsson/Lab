// Generated by CoffeeScript 2.0.3
var Button, angle, buttons, direction, draw, dt, fetchFromLocalStorage, findWords, group, handleMousePressed, index, level, mousePressed, mouseReleased, newGame, possibleWords, radius1, radius2, radius3, radius4, radius5, released, reverseString, saveToLocalStorage, selGroup, selectWords, setup, size, solution, touchEnded, touchStarted, word, wordList, words, wrap,
  modulo = function(a, b) { return (+a % (b = +b) + b) % b; },
  indexOf = [].indexOf;

wordList = null;

words = null;

index = 0;

word = '';

level = 0;

angle = 0;

direction = 1;

size = null;

group = 0; // 1 av 25 om cirka 200 ord 

radius1 = null; // avstånd till gul cirkels mittpunkt

radius2 = null; // gul cirkels radie

radius3 = null; // avstånd till siffra

radius4 = null; // gräns mellan siffror och bokstäver

radius5 = null; // siffrans radie

possibleWords = [];

solution = "";

dt = 0;

released = true;

buttons = [];

Button = class Button {
  constructor(txt, r1, degrees, r2, f) {
    this.txt = txt;
    this.r1 = r1;
    this.degrees = degrees;
    this.r2 = r2;
    this.f = f;
    this.x = this.r1 * cos(radians(this.degrees));
    this.y = this.r1 * sin(radians(this.degrees));
  }

  draw() {
    fc(0.45);
    circle(this.x, this.y, this.r2);
    fc(0);
    return text(this.txt, this.x, this.y);
  }

  mousePressed(mx, my) {
    if (this.r2 > dist(mx, my, width / 2 + this.x, height / 2 + this.y)) {
      return this.f();
    }
  }

};

fetchFromLocalStorage = function() {
  var arr, s;
  s = localStorage["letteroEasy"];
  if (s) {
    arr = s.split(' ');
    group = parseInt(arr[0]);
    return level = parseInt(arr[1]);
  } else {
    group = 0;
    return level = 0;
  }
};

saveToLocalStorage = function() {
  return localStorage["letteroEasy"] = `${group} ${level}`;
};

setup = function() {
  var grupp, i, j, k, len, len1, radius6;
  for (i = j = 0, len = ordlista.length; j < len; i = ++j) {
    grupp = ordlista[i];
    ordlista[i] = grupp.split(' ');
  }
  fetchFromLocalStorage();
  createCanvas(windowWidth, windowHeight);
  size = min(width, height);
  radius2 = size / 12;
  radius1 = 0.5 * size - radius2;
  radius3 = 0.6 * radius1;
  radius4 = radius1 - radius2;
  radius5 = 0.05 * size;
  radius6 = 0.59 * size;
  wordList = _.shuffle(ordlista[group]);
  words = selectWords();
  for (i = k = 0, len1 = words.length; k < len1; i = ++k) {
    word = words[i];
    words[i] = words[i].toLowerCase();
  }
  textAlign(CENTER, CENTER);
  print(wordList.length);
  buttons.push(new Button('+', radius6, 45, radius2, () => {
    return selGroup(1);
  }));
  buttons.push(new Button('-', radius6, 45 + 90, radius2, () => {
    return selGroup(-1);
  }));
  return newGame(0);
};

selGroup = function(d) {
  group = modulo(group + d, ordlista.length);
  saveToLocalStorage();
  return words = selectWords();
};

newGame = function(dLevel) {
  var extra;
  solution = possibleWords.join(' ');
  direction = dLevel;
  extra = int(level / 10); // straffa med 10% av level.
  if (dLevel < 0 && extra !== 0) {
    dLevel *= extra;
  }
  level += dLevel;
  if (level < 0) {
    level = 0;
  }
  word = words[index];
  index++;
  index %= words.length;
  possibleWords = findWords(word);
  if (0.5 < random()) {
    word = reverseString(word);
  }
  word = word.toUpperCase();
  angle = 360 * random();
  saveToLocalStorage();
  return false; // to prevent double click on Android
};

wrap = function(first, last, value) {
  return first + modulo(value - first, last - first + 1);
};

draw = function() {
  var button, ch, dAngle, i, j, k, len, len1, n;
  bg(0.5);
  push();
  translate(width / 2, height / 2);
  textSize(0.09 * size);
  for (j = 0, len = buttons.length; j < len; j++) {
    button = buttons[j];
    button.draw();
  }
  textSize(0.11 * size);
  text(`${1 + 200 * group}-${200 * (group + 1)}`, 0, -0.2 * size);
  textSize(0.06 * size);
  text(solution, 0, 0.18 * size);
  pop();
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
  for (i = k = 0, len1 = word.length; k < len1; i = ++k) {
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
  angle += (millis() - dt) / 50;
  return dt = millis();
};

selectWords = function() {
  return wordList = _.shuffle(ordlista[group]);
};

handleMousePressed = function() {
  var button, ch, dword, i, j, k, len, len1, n, results, rw, w, x, y;
  if (released) {
    released = false; // to make Android work 
  } else {
    return;
  }
  if (dist(mouseX, mouseY, width / 2, height / 2) < radius2) {
    return showWordInfo();
  } else if (dist(mouseX, mouseY, width / 2, height / 2) > radius1 + radius2) {
    results = [];
    for (j = 0, len = buttons.length; j < len; j++) {
      button = buttons[j];
      results.push(button.mousePressed(mouseX, mouseY));
    }
    return results;
  } else {
    // letter	
    n = word.length;
    dword = (word + word).toLowerCase();
    for (i = k = 0, len1 = word.length; k < len1; i = ++k) {
      ch = word[i];
      x = width / 2 + radius1 * cos(radians(angle + i / n * 360));
      y = height / 2 + radius1 * sin(radians(angle + i / n * 360));
      if (radius2 > dist(mouseX, mouseY, x, y)) {
        w = dword.slice(i, i + n);
        rw = reverseString(dword).slice(n - i - 1, n - i + n - 1);
        if (indexOf.call(possibleWords, w) >= 0 || indexOf.call(possibleWords, rw) >= 0) {
          return newGame(1);
        } else {
          return newGame(-1);
        }
      }
    }
  }
};

reverseString = function(str) {
  return str.split("").reverse().join("");
};

mousePressed = function() {
  handleMousePressed();
  return false; // to prevent double click on Android
};

touchStarted = function() {
  handleMousePressed();
  return false; // to prevent double click on Android
};

mouseReleased = function() {
  released = true;
  return false; // to prevent double click on Android
};

touchEnded = function() {
  released = true;
  return false; // to prevent double click on Android
};

findWords = function(word) {
  var ch, dword, i, j, len, n, res, rw, w;
  n = word.length;
  dword = (word + word).toLowerCase();
  res = [];
  for (i = j = 0, len = word.length; j < len; i = ++j) {
    ch = word[i];
    w = dword.slice(i, i + n);
    rw = reverseString(dword).slice(n - i - 1, n - i + n - 1);
    if (indexOf.call(words, w) >= 0) {
      res.push(w);
    }
    if (indexOf.call(words, rw) >= 0) {
      res.push(rw);
    }
  }
  return _.uniq(res);
};

//# sourceMappingURL=data:application/json;base64,eyJ2ZXJzaW9uIjozLCJmaWxlIjoic2tldGNoLmpzIiwic291cmNlUm9vdCI6Ii4uIiwic291cmNlcyI6WyJjb2ZmZWVcXHNrZXRjaC5jb2ZmZWUiXSwibmFtZXMiOltdLCJtYXBwaW5ncyI6IjtBQUFBLElBQUEsTUFBQSxFQUFBLEtBQUEsRUFBQSxPQUFBLEVBQUEsU0FBQSxFQUFBLElBQUEsRUFBQSxFQUFBLEVBQUEscUJBQUEsRUFBQSxTQUFBLEVBQUEsS0FBQSxFQUFBLGtCQUFBLEVBQUEsS0FBQSxFQUFBLEtBQUEsRUFBQSxZQUFBLEVBQUEsYUFBQSxFQUFBLE9BQUEsRUFBQSxhQUFBLEVBQUEsT0FBQSxFQUFBLE9BQUEsRUFBQSxPQUFBLEVBQUEsT0FBQSxFQUFBLE9BQUEsRUFBQSxRQUFBLEVBQUEsYUFBQSxFQUFBLGtCQUFBLEVBQUEsUUFBQSxFQUFBLFdBQUEsRUFBQSxLQUFBLEVBQUEsSUFBQSxFQUFBLFFBQUEsRUFBQSxVQUFBLEVBQUEsWUFBQSxFQUFBLElBQUEsRUFBQSxRQUFBLEVBQUEsS0FBQSxFQUFBLElBQUE7RUFBQTs7O0FBQUEsUUFBQSxHQUFXOztBQUNYLEtBQUEsR0FBUTs7QUFDUixLQUFBLEdBQVE7O0FBQ1IsSUFBQSxHQUFPOztBQUNQLEtBQUEsR0FBUTs7QUFDUixLQUFBLEdBQVE7O0FBQ1IsU0FBQSxHQUFZOztBQUNaLElBQUEsR0FBTzs7QUFDUCxLQUFBLEdBQVEsRUFSUjs7QUFVQSxPQUFBLEdBQVUsS0FWVjs7QUFXQSxPQUFBLEdBQVUsS0FYVjs7QUFZQSxPQUFBLEdBQVUsS0FaVjs7QUFhQSxPQUFBLEdBQVUsS0FiVjs7QUFjQSxPQUFBLEdBQVUsS0FkVjs7QUFnQkEsYUFBQSxHQUFnQjs7QUFDaEIsUUFBQSxHQUFXOztBQUNYLEVBQUEsR0FBSzs7QUFDTCxRQUFBLEdBQVc7O0FBQ1gsT0FBQSxHQUFVOztBQUVKLFNBQU4sTUFBQSxPQUFBO0VBQ0MsV0FBYyxJQUFBLElBQUEsU0FBQSxJQUFBLEdBQUEsQ0FBQTtJQUFDLElBQUMsQ0FBQTtJQUFJLElBQUMsQ0FB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QUFJLENBQUosR0FBTSxDQUF2QztJQUNMLElBQUcsYUFBSyxLQUFMLEVBQUEsQ0FBQSxNQUFIO01BQW1CLEdBQUcsQ0FBQyxJQUFKLENBQVMsQ0FBVCxFQUFuQjs7SUFDQSxJQUFHLGFBQU0sS0FBTixFQUFBLEVBQUEsTUFBSDtNQUFvQixHQUFHLENBQUMsSUFBSixDQUFTLEVBQVQsRUFBcEI7O0VBSkQ7U0FLQSxDQUFDLENBQUMsSUFBRixDQUFPLEdBQVA7QUFUVyIsInNvdXJjZXNDb250ZW50IjpbIndvcmRMaXN0ID0gbnVsbFxyXG53b3JkcyA9IG51bGxcclxuaW5kZXggPSAwXHJcbndvcmQgPSAnJ1xyXG5sZXZlbCA9IDBcclxuYW5nbGUgPSAwXHJcbmRpcmVjdGlvbiA9IDFcclxuc2l6ZSA9IG51bGxcclxuZ3JvdXAgPSAwICMgMSBhdiAyNSBvbSBjaXJrYSAyMDAgb3JkIFxyXG5cclxucmFkaXVzMSA9IG51bGwgIyBhdnN0w6VuZCB0aWxsIGd1bCBjaXJrZWxzIG1pdHRwdW5rdFxyXG5yYWRpdXMyID0gbnVsbCAjIGd1bCBjaXJrZWxzIHJhZGllXHJcbnJhZGl1czMgPSBudWxsICMgYXZzdMOlbmQgdGlsbCBzaWZmcmFcclxucmFkaXVzNCA9IG51bGwgIyBncsOkbnMgbWVsbGFuIHNpZmZyb3Igb2NoIGJva3N0w6R2ZXJcclxucmFkaXVzNSA9IG51bGwgIyBzaWZmcmFucyByYWRpZVxyXG5cclxucG9zc2libGVXb3JkcyA9IFtdXHJcbnNvbHV0aW9uID0gXCJcIlxyXG5kdCA9IDAgXHJcbnJlbGVhc2VkID0gdHJ1ZSBcclxuYnV0dG9ucyA9IFtdXHJcblxyXG5jbGFzcyBCdXR0b25cclxuXHRjb25zdHJ1Y3RvciA6IChAdHh0LEByMSxAZGVncmVlcyxAcjIsQGYpIC0+XHJcblx0XHRAeCA9IEByMSAqIGNvcyByYWRpYW5zIEBkZWdyZWVzXHJcblx0XHRAeSA9IEByMSAqIHNpbiByYWRpYW5zIEBkZWdyZWVzXHJcblxyXG5cdGRyYXcgOiAtPlxyXG5cdFx0ZmMgMC40NVxyXG5cdFx0Y2lyY2xlIEB4LEB5LEByMlxyXG5cdFx0ZmMgMFxyXG5cdFx0dGV4dCBAdHh0LEB4LEB5XHJcblxyXG5cdG1vdXNlUHJlc3NlZCA6IChteCxteSkgLT4gaWYgQHIyID4gZGlzdChteCxteSx3aWR0aC8yK0B4LGhlaWdodC8yK0B5KSB0aGVuIEBmKClcclxuXHJcbmZldGNoRnJvbUxvY2FsU3RvcmFnZSA9IC0+XHJcblx0cyA9IGxvY2FsU3RvcmFnZVtcImxldHRlcm9FYXN5XCJdXHJcblx0aWYgcyBcclxuXHRcdGFyciA9IHMuc3BsaXQgJyAnXHJcblx0XHRncm91cCA9IHBhcnNlSW50IGFyclswXVxyXG5cdFx0bGV2ZWwgPSBwYXJzZUludCBhcnJbMV1cclxuXHRlbHNlXHJcblx0XHRncm91cCA9IDBcclxuXHRcdGxldmVsID0gMFxyXG5cclxuc2F2ZVRvTG9jYWxTdG9yYWdlID0gLT4gXHJcblx0bG9jYWxTdG9yYWdlW1wibGV0dGVyb0Vhc3lcIl0gPSBcIiN7Z3JvdXB9ICN7bGV2ZWx9XCJcclxuXHJcbnNldHVwID0gLT5cclxuXHJcblx0Zm9yIGdydXBwLGkgaW4gb3JkbGlzdGFcclxuXHRcdG9yZGxpc3RhW2ldID0gZ3J1cHAuc3BsaXQgJyAnXHJcblxyXG5cdGZldGNoRnJvbUxvY2FsU3RvcmFnZSgpXHJcblxyXG5cdGNyZWF0ZUNhbnZhcyB3aW5kb3dXaWR0aCx3aW5kb3dIZWlnaHRcclxuXHRzaXplID0gbWluIHdpZHRoLGhlaWdodFxyXG5cdHJhZGl1czIgPSBzaXplLzEyXHJcblx0cmFkaXVzMSA9IDAuNSpzaXplLXJhZGl1czIgXHJcblx0cmFkaXVzMyA9IDAuNipyYWRpdXMxXHJcblx0cmFkaXVzNCA9IHJhZGl1czEgLSByYWRpdXMyXHJcblx0cmFkaXVzNSA9IDAuMDUqc2l6ZVxyXG5cdHJhZGl1czYgPSAwLjU5KnNpemUgXHJcblx0d29yZExpc3QgPSBfLnNodWZmbGUgb3JkbGlzdGFbZ3JvdXBdXHJcblx0d29yZHMgPSBzZWxlY3RXb3JkcygpXHJcblx0Zm9yIHdvcmQsaSBpbiB3b3Jkc1xyXG5cdFx0d29yZHNbaV0gPSB3b3Jkc1tpXS50b0xvd2VyQ2FzZSgpXHJcblx0dGV4dEFsaWduIENFTlRFUixDRU5URVJcclxuXHRwcmludCB3b3JkTGlzdC5sZW5ndGhcclxuXHJcblx0YnV0dG9ucy5wdXNoIG5ldyBCdXR0b24gJysnLCAgcmFkaXVzNiwgNDUsICAgICByYWRpdXMyLCAoKSA9PiBzZWxHcm91cCAxIFxyXG5cdGJ1dHRvbnMucHVzaCBuZXcgQnV0dG9uICctJywgICByYWRpdXM2LCA0NSs5MCwgIHJhZGl1czIsICgpID0+IHNlbEdyb3VwIC0xXHJcblx0bmV3R2FtZSAwXHJcblxyXG5zZWxHcm91cCA9IChkKSAtPlxyXG5cdGdyb3VwID0gKGdyb3VwICsgZCkgJSUgb3JkbGlzdGEubGVuZ3RoXHJcblx0c2F2ZVRvTG9jYWxTdG9yYWdlKClcclxuXHR3b3JkcyA9IHNlbGVjdFdvcmRzKClcclxuXHJcbm5ld0dhbWUgPSAoZExldmVsKSAtPlxyXG5cdHNvbHV0aW9uID0gcG9zc2libGVXb3Jkcy5qb2luICcgJ1xyXG5cdGRpcmVjdGlvbiA9IGRMZXZlbFxyXG5cdGV4dHJhID0gaW50IGxldmVsLzEwICMgc3RyYWZmYSBtZWQgMTAlIGF2IGxldmVsLlxyXG5cdGlmIGRMZXZlbCA8IDAgYW5kIGV4dHJhICE9IDAgdGhlbiBkTGV2ZWwgKj0gZXh0cmFcclxuXHRsZXZlbCArPSBkTGV2ZWxcclxuXHRpZiBsZXZlbCA8IDAgdGhlbiBsZXZlbCA9IDBcclxuXHR3b3JkID0gd29yZHNbaW5kZXhdXHJcblx0aW5kZXgrK1xyXG5cdGluZGV4ICU9IHdvcmRzLmxlbmd0aFxyXG5cdHBvc3NpYmxlV29yZHMgPSBmaW5kV29yZHMgd29yZFxyXG5cdGlmIDAuNSA8IHJhbmRvbSgpIHRoZW4gd29yZCA9IHJldmVyc2VTdHJpbmcgd29yZFxyXG5cdHdvcmQgPSB3b3JkLnRvVXBwZXJDYXNlKClcclxuXHRhbmdsZSA9IDM2MCAqIHJhbmRvbSgpXHJcblxyXG5cdHNhdmVUb0xvY2FsU3RvcmFnZSgpXHJcblxyXG5cdGZhbHNlICMgdG8gcHJldmVudCBkb3VibGUgY2xpY2sgb24gQW5kcm9pZFxyXG5cclxud3JhcCA9IChmaXJzdCxsYXN0LHZhbHVlKSAtPiBmaXJzdCArICh2YWx1ZS1maXJzdCkgJSUgKGxhc3QtZmlyc3QrMSlcclxuXHJcbmRyYXcgPSAtPlxyXG5cdGJnIDAuNVxyXG5cclxuXHRwdXNoKClcclxuXHR0cmFuc2xhdGUgd2lkdGgvMixoZWlnaHQvMlxyXG5cclxuXHR0ZXh0U2l6ZSAwLjA5ICogc2l6ZSBcclxuXHRmb3IgYnV0dG9uIGluIGJ1dHRvbnNcclxuXHRcdGJ1dHRvbi5kcmF3KClcclxuXHRcdFxyXG5cdHRleHRTaXplIDAuMTEgKiBzaXplIFxyXG5cdHRleHQgXCIjezErMjAwKmdyb3VwfS0jezIwMCooZ3JvdXArMSl9XCIsMCwtMC4yKnNpemUgXHJcblx0dGV4dFNpemUgMC4wNiAqIHNpemUgXHJcblx0dGV4dCBzb2x1dGlvbiwgMCwgMC4xOCpzaXplXHJcblxyXG5cdHBvcCgpXHJcblxyXG5cdHRleHRTaXplIHNpemUvNFxyXG5cdGlmIGRpcmVjdGlvbiA9PSAxIHRoZW4gZmMgMCwxLDAgZWxzZSBmYyAxLDAsMFxyXG5cdHRleHQgbGV2ZWwsd2lkdGgvMixoZWlnaHQvMiBcclxuXHRmYyAwXHJcblx0dHJhbnNsYXRlIHdpZHRoLzIsaGVpZ2h0LzJcclxuXHRuID0gd29yZC5sZW5ndGhcclxuXHRkQW5nbGUgPSAzNjAvblxyXG5cdHJkIGFuZ2xlXHJcblx0dGV4dFNpemUgc2l6ZS8xMFxyXG5cdGZvciBjaCxpIGluIHdvcmRcclxuXHRcdHB1c2goKVxyXG5cdFx0dHJhbnNsYXRlIHJhZGl1czEsMFxyXG5cdFx0cmQgOTBcclxuXHRcdGZjIDEsMSwwXHJcblx0XHRjaXJjbGUgMCwwLHJhZGl1czJcclxuXHRcdGZjIDBcclxuXHRcdHRleHQgY2gsMCwwXHJcblx0XHRwb3AoKVxyXG5cdFx0cmQgZEFuZ2xlXHJcblx0YW5nbGUgKz0gKG1pbGxpcygpLWR0KS81MFxyXG5cdGR0ID0gbWlsbGlzKClcclxuXHJcbnNlbGVjdFdvcmRzID0gLT4gXHJcblx0d29yZExpc3QgPSBfLnNodWZmbGUgb3JkbGlzdGFbZ3JvdXBdIFxyXG5cclxuaGFuZGxlTW91c2VQcmVzc2VkID0gLT5cclxuXHRpZiByZWxlYXNlZCB0aGVuIHJlbGVhc2VkID0gZmFsc2UgZWxzZSByZXR1cm4gIyB0byBtYWtlIEFuZHJvaWQgd29yayBcclxuXHRpZiBkaXN0KG1vdXNlWCxtb3VzZVksd2lkdGgvMixoZWlnaHQvMikgPCByYWRpdXMyIFxyXG5cdFx0c2hvd1dvcmRJbmZvKClcclxuXHRlbHNlIGlmIGRpc3QobW91c2VYLG1vdXNlWSx3aWR0aC8yLGhlaWdodC8yKSA+IHJhZGl1czErcmFkaXVzMiBcclxuXHRcdGZvciBidXR0b24gaW4gYnV0dG9uc1xyXG5cdFx0XHRidXR0b24ubW91c2VQcmVzc2VkIG1vdXNlWCxtb3VzZVlcclxuXHRlbHNlXHJcblx0XHQjIGxldHRlclx0XHJcblx0XHRuID0gd29yZC5sZW5ndGhcclxuXHRcdGR3b3JkID0gKHdvcmQrd29yZCkudG9Mb3dlckNhc2UoKVxyXG5cdFx0Zm9yIGNoLGkgaW4gd29yZFxyXG5cdFx0XHR4ID0gd2lkdGgvMiAgKyByYWRpdXMxICogY29zIHJhZGlhbnMgYW5nbGUgKyBpL24gKiAzNjBcclxuXHRcdFx0eSA9IGhlaWdodC8yICsgcmFkaXVzMSAqIHNpbiByYWRpYW5zIGFuZ2xlICsgaS9uICogMzYwXHJcblx0XHRcdGlmIHJhZGl1czIgPiBkaXN0IG1vdXNlWCxtb3VzZVkseCx5IFxyXG5cdFx0XHRcdHcgPSBkd29yZC5zbGljZSBpLGkrblxyXG5cdFx0XHRcdHJ3ID0gcmV2ZXJzZVN0cmluZyhkd29yZCkuc2xpY2Ugbi1pLTEsbi1pK24tMVxyXG5cdFx0XHRcdGlmIHcgaW4gcG9zc2libGVXb3JkcyBvciBydyBpbiBwb3NzaWJsZVdvcmRzXHJcblx0XHRcdFx0XHRyZXR1cm4gbmV3R2FtZSAxXHJcblx0XHRcdFx0ZWxzZVxyXG5cdFx0XHRcdFx0cmV0dXJuIG5ld0dhbWUgLTFcclxuXHJcbnJldmVyc2VTdHJpbmcgPSAoc3RyKSAtPiBzdHIuc3BsaXQoXCJcIikucmV2ZXJzZSgpLmpvaW4gXCJcIlxyXG5cclxubW91c2VQcmVzc2VkID0gLT5cclxuXHRoYW5kbGVNb3VzZVByZXNzZWQoKVxyXG5cdGZhbHNlICMgdG8gcHJldmVudCBkb3VibGUgY2xpY2sgb24gQW5kcm9pZFxyXG5cclxudG91Y2hTdGFydGVkID0gLT5cclxuXHRoYW5kbGVNb3VzZVByZXNzZWQoKVxyXG5cdGZhbHNlICMgdG8gcHJldmVudCBkb3VibGUgY2xpY2sgb24gQW5kcm9pZFxyXG5cclxubW91c2VSZWxlYXNlZCA9IC0+XHJcblx0cmVsZWFzZWQgPSB0cnVlIFxyXG5cdGZhbHNlICMgdG8gcHJldmVudCBkb3VibGUgY2xpY2sgb24gQW5kcm9pZFxyXG5cclxudG91Y2hFbmRlZCA9IC0+XHJcblx0cmVsZWFzZWQgPSB0cnVlIFxyXG5cdGZhbHNlICMgdG8gcHJldmVudCBkb3VibGUgY2xpY2sgb24gQW5kcm9pZFxyXG5cclxuZmluZFdvcmRzID0gKHdvcmQpIC0+XHJcblx0biA9IHdvcmQubGVuZ3RoXHJcblx0ZHdvcmQgPSAod29yZCt3b3JkKS50b0xvd2VyQ2FzZSgpXHJcblx0cmVzID0gW11cclxuXHRmb3IgY2gsaSBpbiB3b3JkXHJcblx0XHR3ID0gZHdvcmQuc2xpY2UgaSxpK25cclxuXHRcdHJ3ID0gcmV2ZXJzZVN0cmluZyhkd29yZCkuc2xpY2Ugbi1pLTEsbi1pK24tMVxyXG5cdFx0aWYgdyBpbiB3b3JkcyB0aGVuIHJlcy5wdXNoIHdcclxuXHRcdGlmIHJ3IGluIHdvcmRzIHRoZW4gcmVzLnB1c2ggcndcclxuXHRfLnVuaXEgcmVzXHJcbiJdfQ==
//# sourceURL=C:\Lab\2017\136-LetteroEasy\coffee\sketch.coffee