// Generated by CoffeeScript 1.11.1
var aSlider, bSlider, boys, cSlider, calc, dSlider, drawtext, eSlider, girls, makerow, makerow_nr, mothers, religious, secular, setup, spaces, stat, statistics, total, xdraw;

aSlider = null;

bSlider = null;

cSlider = null;

dSlider = null;

eSlider = null;

stat = null;

girls = [];

boys = [];

mothers = [];

total = [];

setup = function() {
  var button2, info, s, x;
  createCanvas(1000, 2300);
  textSize(15);
  x = 230;
  aSlider = createSlider(9, 39, 15);
  aSlider.position(x, 20);
  bSlider = createSlider(1, 4, 2);
  bSlider.position(x, 50);
  cSlider = createSlider(0, 8, 6);
  cSlider.position(x, 80);
  dSlider = createSlider(1, 5, 2);
  dSlider.position(x, 110);
  eSlider = createSlider(0, 10, 8);
  eSlider.position(x, 140);
  aSlider.changed(function() {
    return xdraw();
  });
  bSlider.changed(function() {
    return xdraw();
  });
  cSlider.changed(function() {
    return xdraw();
  });
  dSlider.changed(function() {
    return xdraw();
  });
  eSlider.changed(function() {
    return xdraw();
  });
  button2 = createButton('Secular');
  button2.position(120, 195);
  button2.mousePressed(secular);
  button2 = createButton('Religious');
  button2.position(220, 195);
  button2.mousePressed(religious);
  s = 'This is a calculation of the number of offsprings a single man can produce in a century<br>';
  s += 'The man is born in the year 2000<br>';
  s += 'The same policy is used for every marriage<br>';
  s += 'The spouse is always fetched from outside the country<br>';
  info = createP(s);
  info.position(410, 5);
  stat = createP('stat');
  stat.position(0, 220);
  return secular();
};

makerow = function(a, b, c, d, e) {
  var s;
  s = '';
  s += '<td>' + a + '</td>';
  s += '<td>' + b + '</td>';
  s += '<td>' + c + '</td>';
  s += '<td>' + d + '</td>';
  s += '<td>' + e + '</td>';
  return '<tr>' + s + '</tr>';
};

spaces = function(n) {
  var i, j, k, len, ref, res, s;
  s = '' + n;
  res = '';
  ref = range(s.length);
  for (k = 0, len = ref.length; k < len; k++) {
    i = ref[k];
    j = s.length - i - 1;
    res = s[j] + res;
    if (i % 3 === 2 && j !== 0) {
      res = ',' + res;
    }
  }
  return res;
};

makerow_nr = function(a, b, c, d, e) {
  b = b === 0 ? '' : spaces(b);
  c = c === 0 ? '' : spaces(c);
  d = d === 0 ? '' : spaces(d);
  e = e === 0 ? '' : spaces(e);
  return makerow(a, b, c, d, e);
};

statistics = (function(_this) {
  return function() {
    var a, b, c, d, e, i, k, len, ref, s;
    s = makerow('Year', 'Boys', 'Girls', 'Mothers', 'Total');
    ref = range(99, -1, -1);
    for (k = 0, len = ref.length; k < len; k++) {
      i = ref[k];
      a = 2000 + i;
      b = boys[i];
      c = girls[i];
      d = mothers[i];
      e = total[i];
      s = s + makerow_nr(a, b, c, d, e);
    }
    return stat.html('<table>' + s + '</table>');
  };
})(this);

secular = function() {
  aSlider.value(30);
  bSlider.value(1);
  cSlider.value(2);
  dSlider.value(2);
  return xdraw();
};

religious = function() {
  aSlider.value(15);
  bSlider.value(2);
  cSlider.value(3);
  dSlider.value(2);
  eSlider.value(7);
  return xdraw();
};

calc = function(a, b, c, d, e) {
  var MARRIAGE, N, count, g, i, k, l, len, len1, len2, m, ref, ref1, ref2, results, y, year;
  MARRIAGE = a;
  N = 100 + MARRIAGE;
  girls = [];
  boys = [];
  mothers = [];
  total = [];
  randomSeed(99);
  ref = range(N + MARRIAGE + 30);
  for (k = 0, len = ref.length; k < len; k++) {
    year = ref[k];
    boys[year] = 0;
    girls[year] = 0;
    mothers[year] = 0;
    total[year] = 0;
  }
  boys[0] = 1;
  total[0] = 1;
  ref1 = range(N);
  results = [];
  for (l = 0, len1 = ref1.length; l < len1; l++) {
    year = ref1[l];
    if ((0 < year && year < 100)) {
      total[year] = total[year - 1] + boys[year] + girls[year] + mothers[year];
    }
    ref2 = range(b);
    for (m = 0, len2 = ref2.length; m < len2; m++) {
      i = ref2[m];
      y = year + MARRIAGE + i * e;
      if (y <= N) {
        mothers[y] += boys[year];
      }
    }
    mothers[year + MARRIAGE] += girls[year];
    count = mothers[year];
    results.push((function() {
      var len3, o, ref3, results1;
      ref3 = range(c);
      results1 = [];
      for (o = 0, len3 = ref3.length; o < len3; o++) {
        i = ref3[o];
        if (count % 2 === 1) {
          g = (count - 1) / 2 + round(random(0, 1));
        } else {
          g = count / 2;
        }
        girls[year + d * i + 1] += g;
        results1.push(boys[year + d * i + 1] += count - g);
      }
      return results1;
    })());
  }
  return results;
};

drawtext = function(txt, value, x, y) {
  text(txt, 5, y);
  return text(value, x, y);
};

xdraw = function() {
  var a, b, c, d, e, x;
  a = aSlider.value();
  b = bSlider.value();
  c = cSlider.value();
  d = dSlider.value();
  e = eSlider.value();
  calc(a, b, c, d, e);
  background(255);
  x = 380;
  drawtext("Marriage age: (9-39) ", a, x, 35);
  drawtext("Wives per husband: (1-4) ", b, x, 65);
  drawtext("Children per wife: (0-8) ", c, x, 95);
  drawtext("Years between births: (1-5) ", d, x, 125);
  drawtext("Years between marriages: (0-10)", e, x, 155);
  return statistics();
};

//# sourceMappingURL=data:application/json;base64,eyJ2ZXJzaW9uIjozLCJmaWxlIjoic2tldGNoLmpzIiwic291cmNlUm9vdCI6Ii4uIiwic291cmNlcyI6WyJjb2ZmZWVcXHNrZXRjaC5jb2ZmZWUiXSwibmFtZXMiOltdLCJtYXBwaW5ncyI6IjtBQUFBLElBQUE7O0FBQUEsT0FBQSxHQUFROztBQUNSLE9BQUEsR0FBUTs7QUFDUixPQUFBLEdBQVE7O0FBQ1IsT0FBQSxHQUFROztBQUNSLE9BQUEsR0FBUTs7QUFDUixJQUFBLEdBQU87O0FBRVAsS0FBQSxHQUFROztBQUNSLElBQUEsR0FBTzs7QUFDUCxPQUFBLEdBQVU7O0FBQ1YsS0FBQSxHQUFROztBQUVSLEtBQUEsR0FBUSxTQUFBO0FBQ1AsTUFBQTtFQUFBLFlBQUEsQ0FBYSxJQUFiLEVBQW1CLElBQW5CO0VBQ0EsUUFBQSxDQUFTLEVBQVQ7RUFHQSxDQUFBLEdBQUk7RUFDSixPQUFBLEdBQVUsWUFBQSxDQUFhLENBQWIsRUFBZ0IsRUFBaEIsRUFBb0IsRUFBcEI7RUFDVixPQUFPLENBQUMsUUFBUixDQUFpQixDQUFqQixFQUFvQixFQUFwQjtFQUNBLE9BQUEsR0FBVSxZQUFBLENBQWEsQ0FBYixFQUFnQixDQUFoQixFQUFtQixDQUFuQjtFQUNWLE9BQU8sQ0FBQyxRQUFSLENBQWlCLENBQWpCLEVBQW9CLEVBQXBCO0VBQ0EsT0FBQSxHQUFVLFlBQUEsQ0FBYSxDQUFiLEVBQWdCLENBQWhCLEVBQW1CLENBQW5CO0VBQ1YsT0FBTyxDQUFDLFFBQVIsQ0FBaUIsQ0FBakIsRUFBb0IsRUFBcEI7RUFDQSxPQUFBLEdBQVUsWUFBQSxDQUFhLENBQWIsRUFBZ0IsQ0FBaEIsRUFBbUIsQ0FBbkI7RUFDVixPQUFPLENBQUMsUUFBUixDQUFpQixDQUFqQixFQUFvQixHQUFwQjtFQUNBLE9BQUEsR0FBVSxZQUFBLENBQWEsQ0FBYixFQUFnQixFQUFoQixFQUFvQixDQUFwQjtFQUNWLE9BQU8sQ0FBQyxRQUFSLENBQWlCLENBQWpCLEVBQW9CLEdBQXBCO0VBRUEsT0FBTyxDQUFDLE9BQVIsQ0FBZ0IsU0FBQTtX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bFxyXG5jU2xpZGVyPW51bGxcclxuZFNsaWRlcj1udWxsXHJcbmVTbGlkZXI9bnVsbFxyXG5zdGF0ID0gbnVsbFxyXG5cclxuZ2lybHMgPSBbXVxyXG5ib3lzID0gW11cclxubW90aGVycyA9IFtdXHJcbnRvdGFsID0gW11cclxuXHJcbnNldHVwID0gLT5cclxuXHRjcmVhdGVDYW52YXMgMTAwMCwgMjMwMFxyXG5cdHRleHRTaXplIDE1XHJcblxyXG5cdCMgc2xpZGVyc1xyXG5cdHggPSAyMzBcclxuXHRhU2xpZGVyID0gY3JlYXRlU2xpZGVyIDksIDM5LCAxNSAgIyBtYXJyaWFnZWFnZVxyXG5cdGFTbGlkZXIucG9zaXRpb24geCwgMjBcclxuXHRiU2xpZGVyID0gY3JlYXRlU2xpZGVyIDEsIDQsIDIgICAgIyB3aXZlc1xyXG5cdGJTbGlkZXIucG9zaXRpb24geCwgNTBcclxuXHRjU2xpZGVyID0gY3JlYXRlU2xpZGVyIDAsIDgsIDYgICAgIyBjaGlsZHJlbi93aWZlXHJcblx0Y1NsaWRlci5wb3NpdGlvbiB4LCA4MFxyXG5cdGRTbGlkZXIgPSBjcmVhdGVTbGlkZXIgMSwgNSwgMiAgICAjIGJpcnRoZnJlcVxyXG5cdGRTbGlkZXIucG9zaXRpb24geCwgMTEwXHJcblx0ZVNsaWRlciA9IGNyZWF0ZVNsaWRlciAwLCAxMCwgOCAgICMgbWFycmlhZ2VmcmVxXHJcblx0ZVNsaWRlci5wb3NpdGlvbiB4LCAxNDBcclxuXHJcblx0YVNsaWRlci5jaGFuZ2VkICgpIC0+IHhkcmF3KClcclxuXHRiU2xpZGVyLmNoYW5nZWQgKCkgLT4geGRyYXcoKVxyXG5cdGNTbGlkZXIuY2hhbmdlZCAoKSAtPiB4ZHJhdygpXHJcblx0ZFNsaWRlci5jaGFuZ2VkICgpIC0+IHhkcmF3KClcclxuXHRlU2xpZGVyLmNoYW5nZWQgKCkgLT4geGRyYXcoKVxyXG5cclxuXHRidXR0b24yID0gY3JlYXRlQnV0dG9uICdTZWN1bGFyJ1xyXG5cdGJ1dHRvbjIucG9zaXRpb24gMTIwLCAxOTVcclxuXHRidXR0b24yLm1vdXNlUHJlc3NlZCBzZWN1bGFyXHJcblxyXG5cdGJ1dHRvbjIgPSBjcmVhdGVCdXR0b24gJ1JlbGlnaW91cydcclxuXHRidXR0b24yLnBvc2l0aW9uIDIyMCwgMTk1XHJcblx0YnV0dG9uMi5tb3VzZVByZXNzZWQgcmVsaWdpb3VzXHJcblxyXG5cdHMgPSAnVGhpcyBpcyBhIGNhbGN1bGF0aW9uIG9mIHRoZSBudW1iZXIgb2Ygb2Zmc3ByaW5ncyBhIHNpbmdsZSBtYW4gY2FuIHByb2R1Y2UgaW4gYSBjZW50dXJ5PGJyPidcclxuXHRzICs9ICdUaGUgbWFuIGlzIGJvcm4gaW4gdGhlIHllYXIgMjAwMDxicj4nXHJcblx0cyArPSAnVGhlIHNhbWUgcG9saWN5IGlzIHVzZWQgZm9yIGV2ZXJ5IG1hcnJpYWdlPGJyPidcclxuXHRzICs9ICdUaGUgc3BvdXNlIGlzIGFsd2F5cyBmZXRjaGVkIGZyb20gb3V0c2lkZSB0aGUgY291bnRyeTxicj4nXHJcblxyXG5cdGluZm8gPSBjcmVhdGVQIHNcclxuXHRpbmZvLnBvc2l0aW9uIDQxMCw1XHJcblxyXG5cdHN0YXQgPSBjcmVhdGVQICdzdGF0J1xyXG5cdHN0YXQucG9zaXRpb24gMCwyMjBcclxuXHJcblx0c2VjdWxhcigpXHJcblxyXG5tYWtlcm93ID0gKGEsYixjLGQsZSkgLT5cclxuXHRzID0gJydcclxuXHRzICs9ICc8dGQ+JyArIGEgKyAnPC90ZD4nXHJcblx0cyArPSAnPHRkPicgKyBiICsgJzwvdGQ+J1xyXG5cdHMgKz0gJzx0ZD4nICsgYyArICc8L3RkPidcclxuXHRzICs9ICc8dGQ+JyArIGQgKyAnPC90ZD4nXHJcblx0cyArPSAnPHRkPicgKyBlICsgJzwvdGQ+J1xyXG5cdCc8dHI+JyArIHMgKyAnPC90cj4nXHJcblxyXG5zcGFjZXMgPSAobikgLT5cclxuXHRzID0gJycgKyBuXHJcblx0cmVzID0gJydcclxuXHRmb3IgaSBpbiByYW5nZSBzLmxlbmd0aFxyXG5cdFx0aiA9IHMubGVuZ3RoIC0gaSAtIDFcclxuXHRcdHJlcyA9IHNbal0gKyByZXNcclxuXHRcdGlmIChpJTM9PTIgJiYgaiE9MCkgdGhlbiByZXMgPSAnLCcgKyByZXNcclxuXHRyZXNcclxuXHJcbm1ha2Vyb3dfbnIgPSAoYSxiLGMsZCxlKSAtPlxyXG5cdGIgPSBpZiBiPT0wIHRoZW4gJycgZWxzZSBzcGFjZXMgYlxyXG5cdGMgPSBpZiBjPT0wIHRoZW4gJycgZWxzZSBzcGFjZXMgY1xyXG5cdGQgPSBpZiBkPT0wIHRoZW4gJycgZWxzZSBzcGFjZXMgZFxyXG5cdGUgPSBpZiBlPT0wIHRoZW4gJycgZWxzZSBzcGFjZXMgZVxyXG5cdG1ha2Vyb3cgYSxiLGMsZCxlXHJcblxyXG5zdGF0aXN0aWNzID0gPT5cclxuXHRzID0gbWFrZXJvdyAnWWVhcicsJ0JveXMnLCdHaXJscycsJ01vdGhlcnMnLCdUb3RhbCdcclxuXHRmb3IgaSBpbiByYW5nZSA5OSwtMSwtMVxyXG5cdFx0YSA9IDIwMDAraVxyXG5cdFx0YiA9IGJveXNbaV1cclxuXHRcdGMgPSBnaXJsc1tpXVxyXG5cdFx0ZCA9IG1vdGhlcnNbaV1cclxuXHRcdGUgPSB0b3RhbFtpXVxyXG5cdFx0cyA9IHMgKyBtYWtlcm93X25yIGEsYixjLGQsZVxyXG5cdHN0YXQuaHRtbCAnPHRhYmxlPicgKyBzICsgJzwvdGFibGU+J1xyXG5cclxuc2VjdWxhciA9IC0+XHJcblx0YVNsaWRlci52YWx1ZSAzMFxyXG5cdGJTbGlkZXIudmFsdWUgMVxyXG5cdGNTbGlkZXIudmFsdWUgMlxyXG5cdGRTbGlkZXIudmFsdWUgMlxyXG5cdHhkcmF3KClcclxuXHJcbnJlbGlnaW91cyA9IC0+XHJcblx0YVNsaWRlci52YWx1ZSAxNVxyXG5cdGJTbGlkZXIudmFsdWUgMlxyXG5cdGNTbGlkZXIudmFsdWUgM1xyXG5cdGRTbGlkZXIudmFsdWUgMlxyXG5cdGVTbGlkZXIudmFsdWUgN1xyXG5cdHhkcmF3KClcclxuXHJcbmNhbGMgPSAoYSxiLGMsZCxlKSAtPlxyXG5cdE1BUlJJQUdFID0gYSAgIyBhPW1hcnJpYWdlYWdlXHJcblx0TiA9IDEwMCArIE1BUlJJQUdFXHJcblxyXG5cdGdpcmxzID0gW11cclxuXHRib3lzID0gW11cclxuXHRtb3RoZXJzID0gW11cclxuXHR0b3RhbCA9IFtdXHJcblxyXG5cdHJhbmRvbVNlZWQgOTkgICMgYW5uYXJzIGZsYWRkcmFyIGRldC5cclxuXHJcblx0Zm9yIHllYXIgaW4gcmFuZ2UgTiArIE1BUlJJQUdFKzMwXHJcblx0XHRib3lzW3llYXJdICAgICA9IDBcclxuXHRcdGdpcmxzW3llYXJdICAgID0gMFxyXG5cdFx0bW90aGVyc1t5ZWFyXSAgPSAwXHJcblx0XHR0b3RhbFt5ZWFyXSAgICA9IDBcclxuXHRib3lzWzBdID0gMVxyXG5cdHRvdGFsWzBdID0gMVxyXG5cclxuXHRmb3IgeWVhciBpbiByYW5nZSBOXHJcblxyXG5cdFx0aWYgIDAgPCB5ZWFyIDwgMTAwIHRoZW4gdG90YWxbeWVhcl0gPSB0b3RhbFt5ZWFyLTFdICsgYm95c1t5ZWFyXSArIGdpcmxzW3llYXJdICsgbW90aGVyc1t5ZWFyXVxyXG5cclxuXHRcdCMgTUFMRVxyXG5cdFx0Zm9yIGkgaW4gcmFuZ2UgYiAgIyBiID0gd2lmZXNcclxuXHRcdFx0eSA9IHllYXIgKyBNQVJSSUFHRSArIGkqZSAgIyBlID0gbWFycmlhZ2VmcmVxXHJcblx0XHRcdGlmIHkgPD0gTiB0aGVuIG1vdGhlcnNbeV0gKz0gYm95c1t5ZWFyXSAgICAgIyBiZWhhbmRsYSBueWbDtmRkYSwgc2thcGEgZW4gbWFuIG9jaCBmeXJhIGZ1YXJcclxuXHJcblx0XHQjIEZFTUFMRVxyXG5cdFx0bW90aGVyc1t5ZWFyICsgTUFSUklBR0VdICs9IGdpcmxzW3llYXJdICAgIyBiZWhhbmRsYSBueWbDtmRkYSwgc2thcGEgZnJ1YXJcclxuXHJcblx0XHRjb3VudCA9IG1vdGhlcnNbeWVhcl0gIyBiZWhhbmRsYSBueWdpZnRhIGt2aW5ub3IsIHNrYXBhIGJhcm5cclxuXHRcdGZvciBpIGluIHJhbmdlIGMgIyhpPTA7IGk8YzsgaSsrKSB7ICAjIGMgPSBjaGlsZHJlbi93aWZlXHJcblxyXG5cdFx0XHRpZiBjb3VudCUyPT0xICAgIyBCb3JkZSBlZ2VudGxpZ2VuIHZhcmEgZW4gbm9ybWFsZsO2cmRlbG5pbmdcclxuXHRcdFx0XHRnID0gKGNvdW50LTEpLzIgKyByb3VuZCByYW5kb20gMCwxXHJcblx0XHRcdGVsc2VcclxuXHRcdFx0XHRnID0gY291bnQvMlxyXG5cclxuXHRcdFx0Z2lybHNbeWVhciArIGQqaSsxXSArPSBnICMgZCA9IGJpcnRoZnJlcVxyXG5cdFx0XHRib3lzW3llYXIgKyBkKmkrMV0gKz0gY291bnQtZyAjIGQgPSBiaXJ0aGZyZXFcclxuXHJcbmRyYXd0ZXh0ID0gKHR4dCwgdmFsdWUsIHgsIHkpIC0+XHJcblx0dGV4dCB0eHQsIDUsIHlcclxuXHR0ZXh0IHZhbHVlLCB4LCB5XHJcblxyXG54ZHJhdyA9IC0+XHJcblx0YSA9IGFTbGlkZXIudmFsdWUoKVxyXG5cdGIgPSBiU2xpZGVyLnZhbHVlKClcclxuXHRjID0gY1NsaWRlci52YWx1ZSgpXHJcblx0ZCA9IGRTbGlkZXIudmFsdWUoKVxyXG5cdGUgPSBlU2xpZGVyLnZhbHVlKClcclxuXHRjYWxjIGEsYixjLGQsZVxyXG5cdGJhY2tncm91bmQgMjU1XHJcblx0eCA9IDM4MFxyXG5cdGRyYXd0ZXh0IFwiTWFycmlhZ2UgYWdlOiAoOS0zOSkgXCIsIGEsIHgsIDM1XHJcblx0ZHJhd3RleHQgXCJXaXZlcyBwZXIgaHVzYmFuZDogKDEtNCkgXCIsIGIsIHgsIDY1XHJcblx0ZHJhd3RleHQgXCJDaGlsZHJlbiBwZXIgd2lmZTogKDAtOCkgXCIsIGMsIHgsIDk1XHJcblx0ZHJhd3RleHQgXCJZZWFycyBiZXR3ZWVuIGJpcnRoczogKDEtNSkgXCIsIGQsIHgsIDEyNVxyXG5cdGRyYXd0ZXh0IFwiWWVhcnMgYmV0d2VlbiBtYXJyaWFnZXM6ICgwLTEwKVwiLCBlLCB4LCAxNTVcclxuXHRzdGF0aXN0aWNzKClcclxuIl19
//# sourceURL=C:\Lab\2016\023-demografi-p5\coffee\sketch.coffee