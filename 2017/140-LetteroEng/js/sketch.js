// Generated by CoffeeScript 1.12.7
var angle, direction, draw, drawMaxWord, dt, findWords, handleMousePressed, index, level, maxWord, maxWords, mousePressed, newGame, possibleWords, radius1, radius2, radius3, radius4, radius5, reverseString, selectWords, setup, size, solution, touchStarted, word, wordList, words,
  indexOf = [].indexOf || function(item) { for (var i = 0, l = this.length; i < l; i++) { if (i in this && this[i] === item) return i; } return -1; };

wordList = null;

words = null;

index = 0;

word = '';

level = -1;

angle = 0;

direction = 1;

size = null;

radius1 = null;

radius2 = null;

radius3 = null;

radius4 = null;

radius5 = null;

possibleWords = [];

solution = "";

dt = 0;

maxWords = [4, 5, 6, 7, 8, 9];

maxWord = 0;

setup = function() {
  createCanvas(windowWidth, windowHeight);
  size = min(width, height);
  radius2 = size / 10;
  radius1 = size / 2 - radius2;
  radius3 = 0.6 * radius1;
  radius4 = radius1 - radius2;
  radius5 = size / 20;
  wordList = _.shuffle(ordlista.split(' '));
  words = selectWords();
  textAlign(CENTER, CENTER);
  print(wordList.length);
  return newGame(1);
};

newGame = function(dLevel) {
  var extra;
  solution = possibleWords.join(' ');
  direction = dLevel;
  extra = int(level / 10);
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
  return false;
};

drawMaxWord = function() {
  var ch, i, j, len;
  push();
  translate(width / 2, height / 2);
  textSize(2 * radius5);
  for (i = j = 0, len = maxWords.length; j < len; i = ++j) {
    ch = maxWords[i];
    push();
    translate(radius3, 0);
    rd(90);
    if (maxWord === i) {
      fc(1);
    } else {
      fc(0);
    }
    text(ch, 0, 0);
    pop();
    rd(60);
  }
  return pop();
};

draw = function() {
  var ch, dAngle, i, j, len, n;
  bg(0.5);
  drawMaxWord();
  textSize(size / 12);
  text(solution, width / 2, height - size / 10);
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
  angle += (millis() - dt) / 50;
  return dt = millis();
};

selectWords = function() {
  var j, len, results, w;
  wordList = _.shuffle(ordlista.split(' '));
  index = 0;
  results = [];
  for (j = 0, len = wordList.length; j < len; j++) {
    w = wordList[j];
    if (w.length <= maxWords[maxWord]) {
      results.push(w);
    }
  }
  return results;
};

handleMousePressed = function() {
  var ch, dword, i, j, k, len, len1, n, ref, rw, w, x, y;
  if (dist(mouseX, mouseY, width / 2, height / 2) < radius1 - radius2) {
    n = maxWords.length;
    ref = range(n);
    for (j = 0, len = ref.length; j < len; j++) {
      i = ref[j];
      x = width / 2 + radius3 * cos(radians(i / n * 360));
      y = height / 2 + radius3 * sin(radians(i / n * 360));
      if (radius5 > dist(mouseX, mouseY, x, y)) {
        maxWord = i;
        words = selectWords();
      }
    }
  } else {
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
  return false;
};

reverseString = function(str) {
  return str.split("").reverse().join("");
};

mousePressed = function() {
  return handleMousePressed();
};

touchStarted = function() {
  return handleMousePressed();
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

//# sourceMappingURL=data:application/json;base64,eyJ2ZXJzaW9uIjozLCJmaWxlIjoic2tldGNoLmpzIiwic291cmNlUm9vdCI6Ii4uIiwic291cmNlcyI6WyJjb2ZmZWVcXHNrZXRjaC5jb2ZmZWUiXSwibmFtZXMiOltdLCJtYXBwaW5ncyI6IjtBQUdBLElBQUEsa1JBQUE7RUFBQTs7QUFBQSxRQUFBLEdBQVc7O0FBQ1gsS0FBQSxHQUFROztBQUNSLEtBQUEsR0FBUTs7QUFDUixJQUFBLEdBQU87O0FBQ1AsS0FBQSxHQUFRLENBQUM7O0FBQ1QsS0FBQSxHQUFROztBQUNSLFNBQUEsR0FBWTs7QUFDWixJQUFBLEdBQU87O0FBRVAsT0FBQSxHQUFVOztBQUNWLE9BQUEsR0FBVTs7QUFDVixPQUFBLEdBQVU7O0FBQ1YsT0FBQSxHQUFVOztBQUNWLE9BQUEsR0FBVTs7QUFFVixhQUFBLEdBQWdCOztBQUNoQixRQUFBLEdBQVc7O0FBQ1gsRUFBQSxHQUFLOztBQUNMLFFBQUEsR0FBVyxDQUFDLENBQUQsRUFBRyxDQUFILEVBQUssQ0FBTCxFQUFPLENBQVAsRUFBUyxDQUFULEVBQVcsQ0FBWDs7QUFDWCxPQUFBLEdBQVU7O0FBRVYsS0FBQSxHQUFRLFNBQUE7RUFDUCxZQUFBLENBQWEsV0FBYixFQUF5QixZQUF6QjtFQUNBLElBQUEsR0FBTyxHQUFBLENBQUksS0FBSixFQUFVLE1BQVY7RUFDUCxPQUFBLEdBQVUsSUFBQSxHQUFLO0VBQ2YsT0FBQSxHQUFVLElBQUEsR0FBSyxDQUFMLEdBQU87RUFDakIsT0FBQSxHQUFVLEdBQUEsR0FBSTtFQUNkLE9BQUEsR0FBVSxPQUFBLEdBQVU7RUFDcEIsT0FBQSxHQUFVLElBQUEsR0FBSztFQUNmLFFBQUEsR0FBVyxDQUFDLENBQUMsT0FBRixDQUFVLFFBQVEsQ0FBQyxLQUFULENBQWUsR0FBZixDQUFWO0VBQ1gsS0FBQSxHQUFRLFdBQUEsQ0FBQTtFQUNSLFNBQUEsQ0FBVSxNQUFWLEVBQWlCLE1BQWpCO0VBRUEsS0FBQSxDQUFNLFFBQVEsQ0FBQyxNQUFmO1NBQ0EsT0FBQSxDQUFRLENBQVI7QUFiTzs7QUFlUixP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QSxHQUFNO0FBQ04sT0FBQSw4Q0FBQTs7SUFDQyxDQUFBLEdBQUksS0FBSyxDQUFDLEtBQU4sQ0FBWSxDQUFaLEVBQWMsQ0FBQSxHQUFFLENBQWhCO0lBQ0osRUFBQSxHQUFLLGFBQUEsQ0FBYyxLQUFkLENBQW9CLENBQUMsS0FBckIsQ0FBMkIsQ0FBQSxHQUFFLENBQUYsR0FBSSxDQUEvQixFQUFpQyxDQUFBLEdBQUUsQ0FBRixHQUFJLENBQUosR0FBTSxDQUF2QztJQUNMLElBQUcsYUFBSyxLQUFMLEVBQUEsQ0FBQSxNQUFIO01BQW1CLEdBQUcsQ0FBQyxJQUFKLENBQVMsQ0FBVCxFQUFuQjs7SUFDQSxJQUFHLGFBQU0sS0FBTixFQUFBLEVBQUEsTUFBSDtNQUFvQixHQUFHLENBQUMsSUFBSixDQUFTLEVBQVQsRUFBcEI7O0FBSkQ7U0FLQSxDQUFDLENBQUMsSUFBRixDQUFPLEdBQVA7QUFUVyIsInNvdXJjZXNDb250ZW50IjpbIiMgT3JpZ2luYWxrb2QgaSAxMzYtTGV0dGVyb1xyXG4jIEtvcGllcmFzIHRpbGwgMTQwLUxldHRlcm9FbmdcclxuXHJcbndvcmRMaXN0ID0gbnVsbFxyXG53b3JkcyA9IG51bGxcclxuaW5kZXggPSAwXHJcbndvcmQgPSAnJ1xyXG5sZXZlbCA9IC0xXHJcbmFuZ2xlID0gMFxyXG5kaXJlY3Rpb24gPSAxXHJcbnNpemUgPSBudWxsXHJcblxyXG5yYWRpdXMxID0gbnVsbCAjIGF2c3TDpW5kIHRpbGwgZ3VsIGNpcmtlbHMgbWl0dHB1bmt0XHJcbnJhZGl1czIgPSBudWxsICMgZ3VsIGNpcmtlbHMgcmFkaWVcclxucmFkaXVzMyA9IG51bGwgIyBhdnN0w6VuZCB0aWxsIHNpZmZyYVxyXG5yYWRpdXM0ID0gbnVsbCAjIGdyw6RucyBtZWxsYW4gc2lmZnJvciBvY2ggYm9rc3TDpHZlclxyXG5yYWRpdXM1ID0gbnVsbCAjIHNpZmZyYW5zIHJhZGllXHJcblxyXG5wb3NzaWJsZVdvcmRzID0gW11cclxuc29sdXRpb24gPSBcIlwiXHJcbmR0ID0gMCBcclxubWF4V29yZHMgPSBbNCw1LDYsNyw4LDldXHJcbm1heFdvcmQgPSAwXHJcblxyXG5zZXR1cCA9IC0+XHJcblx0Y3JlYXRlQ2FudmFzIHdpbmRvd1dpZHRoLHdpbmRvd0hlaWdodFxyXG5cdHNpemUgPSBtaW4gd2lkdGgsaGVpZ2h0XHJcblx0cmFkaXVzMiA9IHNpemUvMTBcclxuXHRyYWRpdXMxID0gc2l6ZS8yLXJhZGl1czIgXHJcblx0cmFkaXVzMyA9IDAuNipyYWRpdXMxXHJcblx0cmFkaXVzNCA9IHJhZGl1czEgLSByYWRpdXMyXHJcblx0cmFkaXVzNSA9IHNpemUvMjBcclxuXHR3b3JkTGlzdCA9IF8uc2h1ZmZsZSBvcmRsaXN0YS5zcGxpdCAnICdcclxuXHR3b3JkcyA9IHNlbGVjdFdvcmRzKClcclxuXHR0ZXh0QWxpZ24gQ0VOVEVSLENFTlRFUlxyXG5cdCNsaXN0Q2lyY3VsYXIoKVxyXG5cdHByaW50IHdvcmRMaXN0Lmxlbmd0aFxyXG5cdG5ld0dhbWUgMVxyXG5cclxubmV3R2FtZSA9IChkTGV2ZWwpIC0+XHJcblx0c29sdXRpb24gPSBwb3NzaWJsZVdvcmRzLmpvaW4gJyAnXHJcblx0ZGlyZWN0aW9uID0gZExldmVsXHJcblx0ZXh0cmEgPSBpbnQgbGV2ZWwvMTAgIyBzdHJhZmZhIG1lZCAxMCUgYXYgbGV2ZWwuXHJcblx0aWYgZExldmVsIDwgMCBhbmQgZXh0cmEgIT0gMCB0aGVuIGRMZXZlbCAqPSBleHRyYVxyXG5cdGxldmVsICs9IGRMZXZlbFxyXG5cdGlmIGxldmVsIDwgMCB0aGVuIGxldmVsID0gMFxyXG5cdHdvcmQgPSB3b3Jkc1tpbmRleF1cclxuXHRpbmRleCsrXHJcblx0aW5kZXggJT0gd29yZHMubGVuZ3RoXHJcblx0cG9zc2libGVXb3JkcyA9IGZpbmRXb3JkcyB3b3JkXHJcblx0aWYgMC41IDwgcmFuZG9tKCkgdGhlbiB3b3JkID0gcmV2ZXJzZVN0cmluZyB3b3JkXHJcblx0d29yZCA9IHdvcmQudG9VcHBlckNhc2UoKVxyXG5cdGFuZ2xlID0gMzYwICogcmFuZG9tKClcclxuXHRmYWxzZSAjIHRvIHByZXZlbnQgZG91YmxlIGNsaWNrIG9uIEFuZHJvaWRcclxuXHJcbmRyYXdNYXhXb3JkID0gLT5cclxuXHRwdXNoKClcclxuXHR0cmFuc2xhdGUgd2lkdGgvMixoZWlnaHQvMlxyXG5cdHRleHRTaXplIDIgKiByYWRpdXM1XHJcblx0Zm9yIGNoLGkgaW4gbWF4V29yZHNcclxuXHRcdHB1c2goKVxyXG5cdFx0dHJhbnNsYXRlIHJhZGl1czMsMFxyXG5cdFx0cmQgOTBcclxuXHRcdGlmIG1heFdvcmQgPT0gaSB0aGVuIGZjIDEgZWxzZSBmYyAwXHJcblx0XHR0ZXh0IGNoLDAsMFxyXG5cdFx0cG9wKClcclxuXHRcdHJkIDYwXHJcblx0cG9wKClcclxuXHJcbmRyYXcgPSAtPlxyXG5cdGJnIDAuNVxyXG5cdGRyYXdNYXhXb3JkKClcclxuXHR0ZXh0U2l6ZSBzaXplLzEyXHJcblx0dGV4dCBzb2x1dGlvbiwgd2lkdGgvMixoZWlnaHQtc2l6ZS8xMFxyXG5cdHRleHRTaXplIHNpemUvNFxyXG5cdGlmIGRpcmVjdGlvbiA9PSAxIHRoZW4gZmMgMCwxLDAgZWxzZSBmYyAxLDAsMFxyXG5cdHRleHQgbGV2ZWwsd2lkdGgvMixoZWlnaHQvMiBcclxuXHRmYyAwXHJcblx0dHJhbnNsYXRlIHdpZHRoLzIsaGVpZ2h0LzJcclxuXHRuID0gd29yZC5sZW5ndGhcclxuXHRkQW5nbGUgPSAzNjAvblxyXG5cdHJkIGFuZ2xlXHJcblx0dGV4dFNpemUgc2l6ZS8xMFxyXG5cdGZvciBjaCxpIGluIHdvcmRcclxuXHRcdHB1c2goKVxyXG5cdFx0dHJhbnNsYXRlIHJhZGl1czEsMFxyXG5cdFx0cmQgOTBcclxuXHRcdGZjIDEsMSwwXHJcblx0XHRjaXJjbGUgMCwwLHJhZGl1czJcclxuXHRcdGZjIDBcclxuXHRcdHRleHQgY2gsMCwwXHJcblx0XHRwb3AoKVxyXG5cdFx0cmQgZEFuZ2xlXHJcblx0YW5nbGUgKz0gKG1pbGxpcygpLWR0KS81MFxyXG5cdGR0ID0gbWlsbGlzKClcclxuXHJcbnNlbGVjdFdvcmRzID0gLT4gXHJcblx0d29yZExpc3QgPSBfLnNodWZmbGUgb3JkbGlzdGEuc3BsaXQgJyAnXHJcblx0aW5kZXggPSAwXHJcblx0dyBmb3IgdyBpbiB3b3JkTGlzdCB3aGVuIHcubGVuZ3RoIDw9IG1heFdvcmRzW21heFdvcmRdXHJcblxyXG5oYW5kbGVNb3VzZVByZXNzZWQgPSAtPlxyXG5cdGlmIGRpc3QobW91c2VYLG1vdXNlWSx3aWR0aC8yLGhlaWdodC8yKSA8IHJhZGl1czEtcmFkaXVzMiBcclxuXHRcdCMgZGlnaXRcclxuXHRcdG4gPSBtYXhXb3Jkcy5sZW5ndGhcclxuXHRcdGZvciBpIGluIHJhbmdlIG5cclxuXHRcdFx0eCA9IHdpZHRoLzIgICsgcmFkaXVzMyAqIGNvcyByYWRpYW5zIGkvbiAqIDM2MFxyXG5cdFx0XHR5ID0gaGVpZ2h0LzIgKyByYWRpdXMzICogc2luIHJhZGlhbnMgaS9uICogMzYwXHJcblx0XHRcdGlmIHJhZGl1czUgPiBkaXN0IG1vdXNlWCxtb3VzZVkseCx5XHJcblx0XHRcdFx0bWF4V29yZCA9IGlcclxuXHRcdFx0XHR3b3JkcyA9IHNlbGVjdFdvcmRzKClcclxuXHRlbHNlXHJcblx0XHQjIGxldHRlclx0XHJcblx0XHRuID0gd29yZC5sZW5ndGhcclxuXHRcdGR3b3JkID0gKHdvcmQrd29yZCkudG9Mb3dlckNhc2UoKVxyXG5cdFx0Zm9yIGNoLGkgaW4gd29yZFxyXG5cdFx0XHR4ID0gd2lkdGgvMiAgKyByYWRpdXMxICogY29zIHJhZGlhbnMgYW5nbGUgKyBpL24gKiAzNjBcclxuXHRcdFx0eSA9IGhlaWdodC8yICsgcmFkaXVzMSAqIHNpbiByYWRpYW5zIGFuZ2xlICsgaS9uICogMzYwXHJcblx0XHRcdGlmIHJhZGl1czIgPiBkaXN0IG1vdXNlWCxtb3VzZVkseCx5IFxyXG5cdFx0XHRcdHcgPSBkd29yZC5zbGljZSBpLGkrblxyXG5cdFx0XHRcdHJ3ID0gcmV2ZXJzZVN0cmluZyhkd29yZCkuc2xpY2Ugbi1pLTEsbi1pK24tMVxyXG5cdFx0XHRcdGlmIHcgaW4gcG9zc2libGVXb3JkcyBvciBydyBpbiBwb3NzaWJsZVdvcmRzXHJcblx0XHRcdFx0XHRyZXR1cm4gbmV3R2FtZSAxXHJcblx0XHRcdFx0ZWxzZVxyXG5cdFx0XHRcdFx0cmV0dXJuIG5ld0dhbWUgLTFcclxuXHRmYWxzZSAjIHRvIHByZXZlbnQgZG91YmxlIGNsaWNrIG9uIEFuZHJvaWRcclxuXHJcbnJldmVyc2VTdHJpbmcgPSAoc3RyKSAtPiBzdHIuc3BsaXQoXCJcIikucmV2ZXJzZSgpLmpvaW4gXCJcIlxyXG5tb3VzZVByZXNzZWQgPSAtPlx0aGFuZGxlTW91c2VQcmVzc2VkKClcclxudG91Y2hTdGFydGVkID0gLT4gaGFuZGxlTW91c2VQcmVzc2VkKClcclxuXHJcbmZpbmRXb3JkcyA9ICh3b3JkKSAtPlxyXG5cdG4gPSB3b3JkLmxlbmd0aFxyXG5cdGR3b3JkID0gKHdvcmQrd29yZCkudG9Mb3dlckNhc2UoKVxyXG5cdHJlcyA9IFtdXHJcblx0Zm9yIGNoLGkgaW4gd29yZFxyXG5cdFx0dyA9IGR3b3JkLnNsaWNlIGksaStuXHJcblx0XHRydyA9IHJldmVyc2VTdHJpbmcoZHdvcmQpLnNsaWNlIG4taS0xLG4taStuLTFcclxuXHRcdGlmIHcgaW4gd29yZHMgdGhlbiByZXMucHVzaCB3XHJcblx0XHRpZiBydyBpbiB3b3JkcyB0aGVuIHJlcy5wdXNoIHJ3XHJcblx0Xy51bmlxIHJlc1xyXG5cclxuIyBsaXN0Q2lyY3VsYXIgPSAoKSAtPlxyXG4jIFx0cHJpbnQgd29yZHMubGVuZ3RoXHJcbiMgXHRhbnRhbCA9IDBcclxuIyBcdGZvciB3b3JkIGluIHdvcmRzXHJcbiMgXHRcdHJlcyA9IGZpbmRXb3JkcyB3b3JkXHJcbiMgXHRcdGlmIHJlcy5sZW5ndGg9PTJcclxuIyBcdFx0XHRwcmludCByZXMuam9pbiAnICdcclxuIyBcdFx0XHRhbnRhbCsrXHJcbiMgXHRwcmludCBhbnRhbCJdfQ==
//# sourceURL=C:\Lab\2017\140-LetteroEng\coffee\sketch.coffee