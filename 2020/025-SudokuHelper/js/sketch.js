// Generated by CoffeeScript 2.4.1
var COLOR, N, SIZE, SUPPORT, calcSingle, calcTabu, click, digits, draw, expert, i, mousePressed, postnord, range, setup, single, stack, tabu, undo;

range = _.range;

N = 9;

SIZE = 20;

COLOR = '#ccc #f00'.split(' ');

SUPPORT = 0; // no support

//SUPPORT = 1 # show green digit
digits = []; // 0..8 eller -1 length=81

tabu = []; // [0,0,0,0,0,0,0,0,0] 0..1          length=81

single = (function() {
  var l, len, ref, results;
  ref = range(81);
  // 0..8 eller -1 length=81
  results = [];
  for (l = 0, len = ref.length; l < len; l++) {
    i = ref[l];
    results.push(-1);
  }
  return results;
})();

stack = []; // contains 0..80

calcSingle = function() {
  var count, i0, index, ioff, ix, j, j0, joff, k, l, len, len1, len2, len3, len4, len5, len6, len7, len8, len9, m, n, o, p, q, r, ref, ref1, ref2, ref3, ref4, ref5, ref6, ref7, ref8, ref9, results, s, u, v;
  if (SUPPORT === 0) {
    return;
  }
  single = (function() {
    var l, len, ref, results;
    ref = range(81);
    results = [];
    for (l = 0, len = ref.length; l < len; l++) {
      i = ref[l];
      results.push(-1);
    }
    return results;
  })();
  ref = range(N);
  // cell
  for (l = 0, len = ref.length; l < len; l++) {
    i = ref[l];
    ref1 = range(N);
    for (m = 0, len1 = ref1.length; m < len1; m++) {
      j = ref1[m];
      if (digits[i + N * j] === -1) {
        count = 0;
        index = -1;
        ref2 = range(N);
        for (n = 0, len2 = ref2.length; n < len2; n++) {
          k = ref2[n];
          if (tabu[i + N * j][k] === 0) { // gray
            count++;
            index = k;
          }
        }
        if (count === 1) {
          if (tabu[i + N * j][index] === 0) {
            single[i + N * j] = index;
          }
        }
      }
    }
  }
  ref3 = range(N);
  // row
  for (o = 0, len3 = ref3.length; o < len3; o++) {
    j = ref3[o];
    ref4 = range(N);
    for (p = 0, len4 = ref4.length; p < len4; p++) {
      k = ref4[p];
      count = 0;
      index = -1;
      ref5 = range(N);
      for (q = 0, len5 = ref5.length; q < len5; q++) {
        i = ref5[q];
        if (digits[i + N * j] === -1 && tabu[i + N * j][k] === 0) { // gray
          count++;
          index = i;
        }
      }
      if (count === 1) {
        if (tabu[index + N * j][k] === 0) {
          single[index + N * j] = k;
        }
      }
    }
  }
  ref6 = range(N);
  // col
  for (r = 0, len6 = ref6.length; r < len6; r++) {
    i = ref6[r];
    ref7 = range(N);
    for (s = 0, len7 = ref7.length; s < len7; s++) {
      k = ref7[s];
      count = 0;
      index = -1;
      ref8 = range(N);
      for (u = 0, len8 = ref8.length; u < len8; u++) {
        j = ref8[u];
        if (digits[i + N * j] === -1 && tabu[i + N * j][k] === 0) { // gray
          count++;
          index = j;
        }
      }
      if (count === 1) {
        if (tabu[i + N * index][k] === 0) {
          single[i + N * index] = k;
        }
      }
    }
  }
  ref9 = range(N);
  // 3 by 3
  results = [];
  for (v = 0, len9 = ref9.length; v < len9; v++) {
    i = ref9[v];
    results.push((function() {
      var len10, ref10, results1, w;
      ref10 = range(N);
      results1 = [];
      for (w = 0, len10 = ref10.length; w < len10; w++) {
        j = ref10[w];
        if (digits[i + N * j] === -1) {
          ioff = i - i % 3;
          joff = j - j % 3;
          results1.push((function() {
            var i1, j1, len11, len12, len13, ref11, ref12, ref13, results2, z;
            ref11 = range(N);
            results2 = [];
            for (z = 0, len11 = ref11.length; z < len11; z++) {
              k = ref11[z];
              count = 0;
              index = -1;
              ref12 = range(3);
              for (i1 = 0, len12 = ref12.length; i1 < len12; i1++) {
                i0 = ref12[i1];
                ref13 = range(3);
                for (j1 = 0, len13 = ref13.length; j1 < len13; j1++) {
                  j0 = ref13[j1];
                  ix = (ioff + i0) + N * (joff + j0);
                  if (digits[ix] === -1) {
                    if (tabu[ix][k] === 0) { // gray
                      count++;
                      index = ix;
                    }
                  }
                }
              }
              if (count === 1) {
                if (tabu[index][k] === 0) {
                  results2.push(single[index] = k);
                } else {
                  results2.push(void 0);
                }
              } else {
                results2.push(void 0);
              }
            }
            return results2;
          })());
        } else {
          results1.push(void 0);
        }
      }
      return results1;
    })());
  }
  return results;
};

calcTabu = function() {
  var i0, index, ioff, j, j0, joff, k, l, len, ref, results;
  tabu = (function() {
    var l, len, ref, results;
    ref = range(N * N);
    results = [];
    for (l = 0, len = ref.length; l < len; l++) {
      i = ref[l];
      results.push([0, 0, 0, 0, 0, 0, 0, 0, 0]);
    }
    return results;
  })();
  ref = range(N);
  results = [];
  for (l = 0, len = ref.length; l < len; l++) {
    i = ref[l];
    results.push((function() {
      var len1, len2, len3, len4, m, n, o, p, ref1, ref2, ref3, ref4, results1;
      ref1 = range(N);
      results1 = [];
      for (m = 0, len1 = ref1.length; m < len1; m++) {
        j = ref1[m];
        k = digits[i + N * j];
        if (k === -1) {
          continue;
        }
        ref2 = range(N);
        for (n = 0, len2 = ref2.length; n < len2; n++) {
          index = ref2[n];
          tabu[i + N * j][index] = 1; // same cell
          tabu[i + N * index][k] = 1; // col
          tabu[index + N * j][k] = 1; // row
        }
        ioff = i - i % 3;
        joff = j - j % 3;
        ref3 = range(3);
        for (o = 0, len3 = ref3.length; o < len3; o++) {
          i0 = ref3[o];
          ref4 = range(3);
          for (p = 0, len4 = ref4.length; p < len4; p++) {
            j0 = ref4[p];
            tabu[(ioff + i0) + N * (joff + j0)][k] = 1;
          }
        }
        results1.push(tabu[i + N * j][k] = 2);
      }
      return results1;
    })());
  }
  return results;
};

click = function(index, k) { // 0..8 0..8 0..8
  stack.push(index);
  digits[index] = k;
  calcTabu();
  return calcSingle();
};

// dump = ->
// 	calcTabu()
// 	calcSingle()
// 	console.log single
// 	for i in range N*N
// 		console.log i,digits[i],tabu[i]
// 	for i in range N
// 		console.log i,single.slice N*i,N*i+N
undo = function() {
  if (stack.length === 0) {
    return;
  }
  digits[stack.pop()] = -1;
  calcTabu();
  return calcSingle();
};

setup = function() {
  var digit;
  createCanvas(SIZE * 28 + 2 + 2, SIZE * 28 + 2 + 2);
  textAlign(CENTER, CENTER);
  strokeWeight(0);
  digits = (function() {
    var l, len, ref, results;
    ref = range(N * N);
    results = [];
    for (l = 0, len = ref.length; l < len; l++) {
      digit = ref[l];
      results.push(-1);
    }
    return results;
  })();
  return tabu = (function() {
    var l, len, ref, results;
    ref = range(N * N);
    results = [];
    for (l = 0, len = ref.length; l < len; l++) {
      i = ref[l];
      results.push([0, 0, 0, 0, 0, 0, 0, 0, 0]);
    }
    return results;
  })();
};

//postnord()
//expert()
draw = function() {
  var j, k, l, len, len1, len2, len3, len4, len5, len6, letter, m, n, o, p, q, r, ref, ref1, ref2, ref3, ref4, ref5, ref6, results, t, x, y;
  background(128);
  fill(255);
  ref = range(N);
  for (l = 0, len = ref.length; l < len; l++) {
    i = ref[l];
    ref1 = range(N);
    for (m = 0, len1 = ref1.length; m < len1; m++) {
      j = ref1[m];
      x = SIZE * (3 * i);
      y = SIZE * (3 * j);
      rect(x + 1, y + 1, 3 * SIZE - 2, 3 * SIZE - 2);
    }
  }
  fill(0);
  textSize(20);
  ref2 = 'ABCDEFGHI';
  for (i = n = 0, len2 = ref2.length; n < len2; i = ++n) {
    letter = ref2[i];
    text(letter, 3 * SIZE * (i + 0.5), SIZE * 27.7);
    text(N - i, SIZE * 27.6, 3 * SIZE * (i + 0.5));
  }
  ref3 = range(N);
  for (o = 0, len3 = ref3.length; o < len3; o++) {
    i = ref3[o];
    ref4 = range(N);
    for (p = 0, len4 = ref4.length; p < len4; p++) {
      j = ref4[p];
      if (digits[i + N * j] === -1) {
        textSize(12);
        if (single[i + N * j] === -1) {
          fill('#fff');
        } else {
          fill('#ff0');
        }
        x = SIZE * (3 * i);
        y = SIZE * (3 * j);
        rect(x + 1, y + 1, 3 * SIZE - 2, 3 * SIZE - 2);
        ref5 = range(9);
        for (q = 0, len5 = ref5.length; q < len5; q++) {
          k = ref5[q];
          x = 3 * i + k % 3;
          y = 3 * j + int(k / 3);
          t = tabu[i + N * j][k];
          if (single[i + N * j] === k) {
            fill('#0f0');
          } else {
            fill(COLOR[t]);
          }
          text(k + 1, SIZE * (x + 0.5), SIZE * (y + 0.5) + 2);
        }
      } else {
        textSize(30);
        k = digits[i + N * j];
        x = 3 * i;
        y = 3 * j;
        fill(0);
        text(k + 1, SIZE * (x + 1.5), SIZE * (y + 1.5) + 2);
      }
    }
  }
  fill(128);
  ref6 = range(4);
  results = [];
  for (r = 0, len6 = ref6.length; r < len6; r++) {
    i = ref6[r];
    rect(SIZE * N * i, 0, 5, height - SIZE);
    results.push(rect(0, SIZE * N * i, width - SIZE, 5));
  }
  return results;
};

mousePressed = function() {
  var index, j, k, kx, ky;
  i = int(mouseX / (SIZE * 3));
  j = int(mouseY / (SIZE * 3));
  index = i + N * j;
  kx = (int(mouseX / SIZE)) % 3;
  ky = (int(mouseY / SIZE)) % 3;
  k = kx + 3 * ky;
  if (index < N * N) {
    return click(index, k);
  } else {
    return undo();
  }
};

postnord = function() {
  // 8.. .1. 3..
  // .1. 5.. 98.
  // 3.9 ..4 .1.

  // 2.. ..6 .7.
  // .7. ..3 1.9
  // 1.. .8. ...

  // 7.6 ... ..8
  // 4.. ... 5..
  // ... 32. 746
  click(0, 8 - 1);
  click(4, 1 - 1);
  click(6, 3 - 1);
  click(10, 1 - 1);
  click(12, 5 - 1);
  click(15, 9 - 1);
  click(16, 8 - 1);
  click(18, 3 - 1);
  click(20, 9 - 1);
  click(23, 4 - 1);
  click(25, 1 - 1);
  click(27, 2 - 1);
  click(32, 6 - 1);
  click(34, 7 - 1);
  click(37, 7 - 1);
  click(41, 3 - 1);
  click(42, 1 - 1);
  click(44, 9 - 1);
  click(45, 1 - 1);
  click(49, 8 - 1);
  click(54, 7 - 1);
  click(56, 6 - 1);
  click(62, 8 - 1);
  click(63, 4 - 1);
  click(69, 5 - 1);
  click(75, 3 - 1);
  click(76, 2 - 1);
  click(78, 7 - 1);
  click(79, 4 - 1);
  return click(80, 6 - 1);
};

expert = function() {
  click(2, 7 - 1);
  click(5, 4 - 1);
  click(7, 2 - 1);
  click(8, 6 - 1);
  click(10, 9 - 1);
  click(15, 8 - 1);
  click(17, 1 - 1);
  click(19, 6 - 1);
  click(25, 7 - 1);
  click(31, 9 - 1);
  click(39, 5 - 1);
  click(45, 5 - 1);
  click(46, 8 - 1);
  click(48, 1 - 1);
  click(50, 6 - 1);
  click(53, 4 - 1);
  click(54, 4 - 1);
  click(57, 9 - 1);
  click(59, 1 - 1);
  click(62, 8 - 1);
  click(65, 1 - 1);
  click(67, 7 - 1);
  return click(71, 2 - 1);
};

//# sourceMappingURL=data:application/json;base64,eyJ2ZXJzaW9uIjozLCJmaWxlIjoic2tldGNoLmpzIiwic291cmNlUm9vdCI6Ii4uIiwic291cmNlcyI6WyJjb2ZmZWVcXHNrZXRjaC5jb2ZmZWUiXSwibmFtZXMiOltdLCJtYXBwaW5ncyI6IjtBQUFBLElBQUEsS0FBQSxFQUFBLENBQUEsRUFBQSxJQUFBLEVBQUEsT0FBQSxFQUFBLFVBQUEsRUFBQSxRQUFBLEVBQUEsS0FBQSxFQUFBLE1BQUEsRUFBQSxJQUFBLEVBQUEsTUFBQSxFQUFBLENBQUEsRUFBQSxZQUFBLEVBQUEsUUFBQSxFQUFBLEtBQUEsRUFBQSxLQUFBLEVBQUEsTUFBQSxFQUFBLEtBQUEsRUFBQSxJQUFBLEVBQUE7O0FBQUEsS0FBQSxHQUFRLENBQUMsQ0FBQzs7QUFFVixDQUFBLEdBQUk7O0FBQ0osSUFBQSxHQUFPOztBQUNQLEtBQUEsR0FBUSxXQUFXLENBQUMsS0FBWixDQUFrQixHQUFsQjs7QUFFUixPQUFBLEdBQVUsRUFOVjs7O0FBU0EsTUFBQSxHQUFTLEdBVFQ7O0FBVUEsSUFBQSxHQUFPLEdBVlA7O0FBV0EsTUFBQTs7QUFBYTs7QUFBQTtFQUFBLEtBQUEscUNBQUE7O2lCQUFILENBQUM7RUFBRSxDQUFBOzs7O0FBQ2IsS0FBQSxHQUFRLEdBWlI7O0FBY0EsVUFBQSxHQUFhLFFBQUEsQ0FBQSxDQUFBO0FBQ1osTUFBQSxLQUFBLEVBQUEsRUFBQSxFQUFBLEtBQUEsRUFBQSxJQUFBLEVBQUEsRUFBQSxFQUFBLENBQUEsRUFBQSxFQUFBLEVBQUEsSUFBQSxFQUFBLENBQUEsRUFBQSxDQUFBLEVBQUEsR0FBQSxFQUFBLElBQUEsRUFBQSxJQUFBLEVBQUEsSUFBQSxFQUFBLElBQUEsRUFBQSxJQUFBLEVBQUEsSUFBQSxFQUFBLElBQUEsRUFBQSxJQUFBLEVBQUEsSUFBQSxFQUFBLENBQUEsRUFBQSxDQUFBLEVBQUEsQ0FBQSxFQUFBLENBQUEsRUFBQSxDQUFBLEVBQUEsQ0FBQSxFQUFBLEdBQUEsRUFBQSxJQUFBLEVBQUEsSUFBQSxFQUFBLElBQUEsRUFBQSxJQUFBLEVBQUEs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QUNBLEtBQUEsQ0FBTSxFQUFOLEVBQVMsQ0FBQSxHQUFFLENBQVg7RUFDQSxLQUFBLENBQU0sRUFBTixFQUFTLENBQUEsR0FBRSxDQUFYO0VBQ0EsS0FBQSxDQUFNLEVBQU4sRUFBUyxDQUFBLEdBQUUsQ0FBWDtFQUNBLEtBQUEsQ0FBTSxFQUFOLEVBQVMsQ0FBQSxHQUFFLENBQVg7RUFDQSxLQUFBLENBQU0sRUFBTixFQUFTLENBQUEsR0FBRSxDQUFYO0VBQ0EsS0FBQSxDQUFNLEVBQU4sRUFBUyxDQUFBLEdBQUUsQ0FBWDtFQUNBLEtBQUEsQ0FBTSxFQUFOLEVBQVMsQ0FBQSxHQUFFLENBQVg7RUFDQSxLQUFBLENBQU0sRUFBTixFQUFTLENBQUEsR0FBRSxDQUFYO0VBQ0EsS0FBQSxDQUFNLEVBQU4sRUFBUyxDQUFBLEdBQUUsQ0FBWDtFQUNBLEtBQUEsQ0FBTSxFQUFOLEVBQVMsQ0FBQSxHQUFFLENBQVg7RUFDQSxLQUFBLENBQU0sRUFBTixFQUFTLENBQUEsR0FBRSxDQUFYO0VBQ0EsS0FBQSxDQUFNLEVBQU4sRUFBUyxDQUFBLEdBQUUsQ0FBWDtFQUNBLEtBQUEsQ0FBTSxFQUFOLEVBQVMsQ0FBQSxHQUFFLENBQVg7RUFDQSxLQUFBLENBQU0sRUFBTixFQUFTLENBQUEsR0FBRSxDQUFYO0VBQ0EsS0FBQSxDQUFNLEVBQU4sRUFBUyxDQUFBLEdBQUUsQ0FBWDtFQUNBLEtBQUEsQ0FBTSxFQUFOLEVBQVMsQ0FBQSxHQUFFLENBQVg7RUFDQSxLQUFBLENBQU0sRUFBTixFQUFTLENBQUEsR0FBRSxDQUFYO0VBQ0EsS0FBQSxDQUFNLEVBQU4sRUFBUyxDQUFBLEdBQUUsQ0FBWDtFQUNBLEtBQUEsQ0FBTSxFQUFOLEVBQVMsQ0FBQSxHQUFFLENBQVg7RUFDQSxLQUFBLENBQU0sRUFBTixFQUFTLENBQUEsR0FBRSxDQUFYO0VBQ0EsS0FBQSxDQUFNLEVBQU4sRUFBUyxDQUFBLEdBQUUsQ0FBWDtFQUNBLEtBQUEsQ0FBTSxFQUFOLEVBQVMsQ0FBQSxHQUFFLENBQVg7RUFDQSxLQUFBLENBQU0sRUFBTixFQUFTLENBQUEsR0FBRSxDQUFYO1NBQ0EsS0FBQSxDQUFNLEVBQU4sRUFBUyxDQUFBLEdBQUUsQ0FBWDtBQTFDVTs7QUE0Q1gsTUFBQSxHQUFTLFFBQUEsQ0FBQSxDQUFBO0VBQ1IsS0FBQSxDQUFNLENBQU4sRUFBUSxDQUFBLEdBQUUsQ0FBVjtFQUNBLEtBQUEsQ0FBTSxDQUFOLEVBQVEsQ0FBQSxHQUFFLENBQVY7RUFDQSxLQUFBLENBQU0sQ0FBTixFQUFRLENBQUEsR0FBRSxDQUFWO0VBQ0EsS0FBQSxDQUFNLENBQU4sRUFBUSxDQUFBLEdBQUUsQ0FBVjtFQUNBLEtBQUEsQ0FBTSxFQUFOLEVBQVMsQ0FBQSxHQUFFLENBQVg7RUFDQSxLQUFBLENBQU0sRUFBTixFQUFTLENBQUEsR0FBRSxDQUFYO0VBQ0EsS0FBQSxDQUFNLEVBQU4sRUFBUyxDQUFBLEdBQUUsQ0FBWDtFQUNBLEtBQUEsQ0FBTSxFQUFOLEVBQVMsQ0FBQSxHQUFFLENBQVg7RUFDQSxLQUFBLENBQU0sRUFBTixFQUFTLENBQUEsR0FBRSxDQUFYO0VBQ0EsS0FBQSxDQUFNLEVBQU4sRUFBUyxDQUFBLEdBQUUsQ0FBWDtFQUNBLEtBQUEsQ0FBTSxFQUFOLEVBQVMsQ0FBQSxHQUFFLENBQVg7RUFDQSxLQUFBLENBQU0sRUFBTixFQUFTLENBQUEsR0FBRSxDQUFYO0VBQ0EsS0FBQSxDQUFNLEVBQU4sRUFBUyxDQUFBLEdBQUUsQ0FBWDtFQUNBLEtBQUEsQ0FBTSxFQUFOLEVBQVMsQ0FBQSxHQUFFLENBQVg7RUFDQSxLQUFBLENBQU0sRUFBTixFQUFTLENBQUEsR0FBRSxDQUFYO0VBQ0EsS0FBQSxDQUFNLEVBQU4sRUFBUyxDQUFBLEdBQUUsQ0FBWDtFQUNBLEtBQUEsQ0FBTSxFQUFOLEVBQVMsQ0FBQSxHQUFFLENBQVg7RUFDQSxLQUFBLENBQU0sRUFBTixFQUFTLENBQUEsR0FBRSxDQUFYO0VBQ0EsS0FBQSxDQUFNLEVBQU4sRUFBUyxDQUFBLEdBQUUsQ0FBWDtFQUNBLEtBQUEsQ0FBTSxFQUFOLEVBQVMsQ0FBQSxHQUFFLENBQVg7RUFDQSxLQUFBLENBQU0sRUFBTixFQUFTLENBQUEsR0FBRSxDQUFYO0VBQ0EsS0FBQSxDQUFNLEVBQU4sRUFBUyxDQUFBLEdBQUUsQ0FBWDtTQUNBLEtBQUEsQ0FBTSxFQUFOLEVBQVMsQ0FBQSxHQUFFLENBQVg7QUF2QlEiLCJzb3VyY2VzQ29udGVudCI6WyJyYW5nZSA9IF8ucmFuZ2VcclxuXHJcbk4gPSA5XHJcblNJWkUgPSAyMFxyXG5DT0xPUiA9ICcjY2NjICNmMDAnLnNwbGl0ICcgJ1xyXG5cclxuU1VQUE9SVCA9IDAgIyBubyBzdXBwb3J0XHJcbiNTVVBQT1JUID0gMSAjIHNob3cgZ3JlZW4gZGlnaXRcclxuXHJcbmRpZ2l0cyA9IFtdICMgMC4uOCBlbGxlciAtMSBsZW5ndGg9ODFcclxudGFidSA9IFtdICAgIyBbMCwwLDAsMCwwLDAsMCwwLDBdIDAuLjEgICAgICAgICAgbGVuZ3RoPTgxXHJcbnNpbmdsZSA9ICgtMSBmb3IgaSBpbiByYW5nZSA4MSkgIyAwLi44IGVsbGVyIC0xIGxlbmd0aD04MVxyXG5zdGFjayA9IFtdICMgY29udGFpbnMgMC4uODBcclxuXHJcbmNhbGNTaW5nbGUgPSAtPlxyXG5cdGlmIFNVUFBPUlQgPT0gMCB0aGVuIHJldHVyblxyXG5cdHNpbmdsZSA9ICgtMSBmb3IgaSBpbiByYW5nZSA4MSlcclxuXHJcblx0Zm9yIGkgaW4gcmFuZ2UgTiAjIGNlbGxcclxuXHRcdGZvciBqIGluIHJhbmdlIE5cclxuXHRcdFx0aWYgZGlnaXRzW2krTipqXSA9PSAtMVxyXG5cdFx0XHRcdGNvdW50ID0gMFxyXG5cdFx0XHRcdGluZGV4ID0gLTFcclxuXHRcdFx0XHRmb3IgayBpbiByYW5nZSBOXHJcblx0XHRcdFx0XHRpZiB0YWJ1W2kgKyBOKmpdW2tdID09IDAgIyBncmF5XHJcblx0XHRcdFx0XHRcdGNvdW50KytcclxuXHRcdFx0XHRcdFx0aW5kZXggPSBrXHJcblx0XHRcdFx0aWYgY291bnQgPT0gMVxyXG5cdFx0XHRcdFx0aWYgdGFidVtpICsgTipqXVtpbmRleF0gPT0gMCB0aGVuIHNpbmdsZVtpICsgTipqXSA9IGluZGV4XHJcblxyXG5cdGZvciBqIGluIHJhbmdlIE4gIyByb3dcclxuXHRcdGZvciBrIGluIHJhbmdlIE5cclxuXHRcdFx0Y291bnQgPSAwXHJcblx0XHRcdGluZGV4ID0gLTFcclxuXHRcdFx0Zm9yIGkgaW4gcmFuZ2UgTiBcclxuXHRcdFx0XHRpZiBkaWdpdHNbaStOKmpdID09IC0xIGFuZCB0YWJ1W2krTipqXVtrXSA9PSAwICMgZ3JheVxyXG5cdFx0XHRcdFx0Y291bnQrK1xyXG5cdFx0XHRcdFx0aW5kZXggPSBpXHJcblx0XHRcdGlmIGNvdW50ID09IDFcclxuXHRcdFx0XHRpZiB0YWJ1W2luZGV4ICsgTipqXVtrXSA9PSAwIHRoZW4gc2luZ2xlW2luZGV4ICsgTipqXSA9IGtcclxuXHJcblx0Zm9yIGkgaW4gcmFuZ2UgTiAjIGNvbFxyXG5cdFx0Zm9yIGsgaW4gcmFuZ2UgTlxyXG5cdFx0XHRjb3VudCA9IDBcclxuXHRcdFx0aW5kZXggPSAtMVxyXG5cdFx0XHRmb3IgaiBpbiByYW5nZSBOXHJcblx0XHRcdFx0aWYgZGlnaXRzW2krTipqXSA9PSAtMSBhbmQgdGFidVtpICsgTipqXVtrXSA9PSAwICMgZ3JheVxyXG5cdFx0XHRcdFx0Y291bnQrK1xyXG5cdFx0XHRcdFx0aW5kZXggPSBqXHJcblx0XHRcdGlmIGNvdW50ID09IDFcclxuXHRcdFx0XHRpZiB0YWJ1W2kgKyBOKmluZGV4XVtrXSA9PSAwIHRoZW4gc2luZ2xlW2kgKyBOKmluZGV4XSA9IGtcclxuXHJcblx0Zm9yIGkgaW4gcmFuZ2UgTiAjIDMgYnkgM1xyXG5cdFx0Zm9yIGogaW4gcmFuZ2UgTlxyXG5cdFx0XHRpZiBkaWdpdHNbaStOKmpdID09IC0xXHJcblx0XHRcdFx0aW9mZiA9IGkgLSBpICUgM1xyXG5cdFx0XHRcdGpvZmYgPSBqIC0gaiAlIDNcclxuXHRcdFx0XHRmb3IgayBpbiByYW5nZSBOXHJcblx0XHRcdFx0XHRjb3VudCA9IDBcclxuXHRcdFx0XHRcdGluZGV4ID0gLTFcclxuXHRcdFx0XHRcdGZvciBpMCBpbiByYW5nZSAzXHJcblx0XHRcdFx0XHRcdGZvciBqMCBpbiByYW5nZSAzXHJcblx0XHRcdFx0XHRcdFx0aXggPSAoaW9mZitpMCkgKyBOKihqb2ZmK2owKVxyXG5cdFx0XHRcdFx0XHRcdGlmIGRpZ2l0c1tpeF0gPT0gLTEgXHJcblx0XHRcdFx0XHRcdFx0XHRpZiB0YWJ1W2l4XVtrXSA9PSAwICMgZ3JheVxyXG5cdFx0XHRcdFx0XHRcdFx0XHRjb3VudCsrXHJcblx0XHRcdFx0XHRcdFx0XHRcdGluZGV4ID0gaXggXHJcblx0XHRcdFx0XHRpZiBjb3VudCA9PSAxXHJcblx0XHRcdFx0XHRcdGlmIHRhYnVbaW5kZXhdW2tdID09IDAgdGhlbiBzaW5nbGVbaW5kZXhdID0ga1xyXG5cclxuY2FsY1RhYnUgPSAtPlxyXG5cdHRhYnUgPSAoWzAsMCwwLDAsMCwwLDAsMCwwXSBmb3IgaSBpbiByYW5nZSBOKk4pXHJcblx0Zm9yIGkgaW4gcmFuZ2UgTlxyXG5cdFx0Zm9yIGogaW4gcmFuZ2UgTlxyXG5cdFx0XHRrID0gZGlnaXRzW2krTipqXVxyXG5cdFx0XHRpZiBrID09IC0xIHRoZW4gY29udGludWVcclxuXHRcdFx0Zm9yIGluZGV4IGluIHJhbmdlIE5cclxuXHRcdFx0XHR0YWJ1W2kgKyBOKmpdW2luZGV4XSA9IDEgIyBzYW1lIGNlbGxcclxuXHRcdFx0XHR0YWJ1W2kgKyBOKmluZGV4XVtrXSA9IDEgIyBjb2xcclxuXHRcdFx0XHR0YWJ1W2luZGV4ICsgTipqXVtrXSA9IDEgIyByb3dcclxuXHRcdFx0XHJcblx0XHRcdGlvZmYgPSBpIC0gaSAlIDNcclxuXHRcdFx0am9mZiA9IGogLSBqICUgM1xyXG5cdFx0XHRmb3IgaTAgaW4gcmFuZ2UgM1xyXG5cdFx0XHRcdGZvciBqMCBpbiByYW5nZSAzXHJcblx0XHRcdFx0XHR0YWJ1Wyhpb2ZmK2kwKSArIE4qKGpvZmYrajApXVtrXSA9IDFcclxuXHJcblx0XHRcdHRhYnVbaSArIE4qal1ba10gPSAyXHJcblxyXG5jbGljayA9IChpbmRleCxrKSAtPiAjIDAuLjggMC4uOCAwLi44XHJcblx0c3RhY2sucHVzaCBpbmRleFxyXG5cdGRpZ2l0c1tpbmRleF0gPSBrXHJcblx0Y2FsY1RhYnUoKVxyXG5cdGNhbGNTaW5nbGUoKVxyXG5cclxuIyBkdW1wID0gLT5cclxuIyBcdGNhbGNUYWJ1KClcclxuIyBcdGNhbGNTaW5nbGUoKVxyXG4jIFx0Y29uc29sZS5sb2cgc2luZ2xlXHJcbiMgXHRmb3IgaSBpbiByYW5nZSBOKk5cclxuIyBcdFx0Y29uc29sZS5sb2cgaSxkaWdpdHNbaV0sdGFidVtpXVxyXG4jIFx0Zm9yIGkgaW4gcmFuZ2UgTlxyXG4jIFx0XHRjb25zb2xlLmxvZyBpLHNpbmdsZS5zbGljZSBOKmksTippK05cclxuXHJcbnVuZG8gPSAtPlxyXG5cdGlmIHN0YWNrLmxlbmd0aCA9PSAwIHRoZW4gcmV0dXJuXHJcblx0ZGlnaXRzW3N0YWNrLnBvcCgpXSA9IC0xXHJcblx0Y2FsY1RhYnUoKVxyXG5cdGNhbGNTaW5nbGUoKVxyXG5cclxuc2V0dXAgPSAtPlxyXG5cdGNyZWF0ZUNhbnZhcyBTSVpFKjI4KzIrMixTSVpFKjI4KzIrMlxyXG5cdHRleHRBbGlnbiBDRU5URVIsQ0VOVEVSXHJcblx0c3Ryb2tlV2VpZ2h0IDBcclxuXHRkaWdpdHMgPSAoLTEgZm9yIGRpZ2l0IGluIHJhbmdlIE4qTilcclxuXHR0YWJ1ID0gKFswLDAsMCwwLDAsMCwwLDAsMF0gZm9yIGkgaW4gcmFuZ2UgTipOKVxyXG5cclxuXHQjcG9zdG5vcmQoKVxyXG5cdCNleHBlcnQoKVxyXG5cclxuZHJhdyA9IC0+XHJcblx0YmFja2dyb3VuZCAxMjhcclxuXHJcblx0ZmlsbCAyNTVcclxuXHRmb3IgaSBpbiByYW5nZSBOXHJcblx0XHRmb3IgaiBpbiByYW5nZSBOXHJcblx0XHRcdHggPSBTSVpFKigzKmkpXHJcblx0XHRcdHkgPSBTSVpFKigzKmopXHJcblx0XHRcdHJlY3QgeCsxLHkrMSwzKlNJWkUtMiwzKlNJWkUtMlxyXG5cclxuXHRmaWxsIDBcclxuXHR0ZXh0U2l6ZSAyMFxyXG5cdGZvciBsZXR0ZXIsaSBpbiAnQUJDREVGR0hJJ1xyXG5cdFx0dGV4dCBsZXR0ZXIsIDMqU0laRSooaSswLjUpLFNJWkUqMjcuN1xyXG5cdFx0dGV4dCBOLWksIFNJWkUqMjcuNiwgMypTSVpFKihpKzAuNSlcclxuXHJcblx0Zm9yIGkgaW4gcmFuZ2UgTlxyXG5cdFx0Zm9yIGogaW4gcmFuZ2UgTlxyXG5cdFx0XHRpZiBkaWdpdHNbaStOKmpdID09IC0xXHJcblx0XHRcdFx0dGV4dFNpemUgMTJcclxuXHRcdFx0XHRpZiBzaW5nbGVbaStOKmpdID09IC0xIHRoZW4gZmlsbCAnI2ZmZicgZWxzZSBmaWxsICcjZmYwJ1xyXG5cdFx0XHRcdHggPSBTSVpFKigzKmkpXHJcblx0XHRcdFx0eSA9IFNJWkUqKDMqailcclxuXHRcdFx0XHRyZWN0IHgrMSx5KzEsMypTSVpFLTIsMypTSVpFLTJcclxuXHRcdFx0XHRmb3IgayBpbiByYW5nZSA5XHJcblx0XHRcdFx0XHR4ID0gMyppK2sgJSAzXHJcblx0XHRcdFx0XHR5ID0gMypqK2ludChrIC8gMylcclxuXHRcdFx0XHRcdHQgPSB0YWJ1W2kgKyBOKmpdW2tdXHJcblx0XHRcdFx0XHRpZiBzaW5nbGVbaSArIE4qal0gPT0gayB0aGVuIGZpbGwgJyMwZjAnIGVsc2UgZmlsbCBDT0xPUlt0XVxyXG5cdFx0XHRcdFx0dGV4dCBrKzEsU0laRSooeCswLjUpLFNJWkUqKHkrMC41KSsyXHJcblx0XHRcdGVsc2VcclxuXHRcdFx0XHR0ZXh0U2l6ZSAzMFxyXG5cdFx0XHRcdGsgPSBkaWdpdHNbaStOKmpdXHJcblx0XHRcdFx0eCA9IDMqaVxyXG5cdFx0XHRcdHkgPSAzKmpcclxuXHRcdFx0XHRmaWxsIDBcclxuXHRcdFx0XHR0ZXh0IGsrMSxTSVpFKih4KzEuNSksU0laRSooeSsxLjUpKzJcclxuXHJcblx0ZmlsbCAxMjhcclxuXHRmb3IgaSBpbiByYW5nZSA0XHJcblx0XHRyZWN0IFNJWkUqTippLDAsNSxoZWlnaHQtU0laRVxyXG5cdFx0cmVjdCAwLFNJWkUqTippLHdpZHRoLVNJWkUsNVxyXG5cclxubW91c2VQcmVzc2VkID0gLT5cclxuXHRpID0gaW50IG1vdXNlWCAvIChTSVpFKjMpXHJcblx0aiA9IGludCBtb3VzZVkgLyAoU0laRSozKVxyXG5cdGluZGV4ID0gaSArIE4gKiBqXHJcblx0a3ggPSAoaW50IG1vdXNlWCAvIFNJWkUpICUgM1xyXG5cdGt5ID0gKGludCBtb3VzZVkgLyBTSVpFKSAlIDNcclxuXHRrID0ga3ggKyAzICoga3lcclxuXHRpZiBpbmRleCA8IE4qTiB0aGVuIGNsaWNrIGluZGV4LGsgZWxzZSB1bmRvKClcclxuXHJcbnBvc3Rub3JkID0gLT5cclxuXHQjIDguLiAuMS4gMy4uXHJcblx0IyAuMS4gNS4uIDk4LlxyXG5cdCMgMy45IC4uNCAuMS5cclxuXHJcblx0IyAyLi4gLi42IC43LlxyXG5cdCMgLjcuIC4uMyAxLjlcclxuXHQjIDEuLiAuOC4gLi4uXHJcblxyXG5cdCMgNy42IC4uLiAuLjhcclxuXHQjIDQuLiAuLi4gNS4uXHJcblx0IyAuLi4gMzIuIDc0NlxyXG5cclxuXHRjbGljayAwLDgtMVxyXG5cdGNsaWNrIDQsMS0xXHJcblx0Y2xpY2sgNiwzLTFcclxuXHRjbGljayAxMCwxLTFcclxuXHRjbGljayAxMiw1LTFcclxuXHRjbGljayAxNSw5LTFcclxuXHRjbGljayAxNiw4LTFcclxuXHRjbGljayAxOCwzLTFcclxuXHRjbGljayAyMCw5LTFcclxuXHRjbGljayAyMyw0LTFcclxuXHRjbGljayAyNSwxLTFcclxuXHRjbGljayAyNywyLTFcclxuXHRjbGljayAzMiw2LTFcclxuXHRjbGljayAzNCw3LTFcclxuXHRjbGljayAzNyw3LTFcclxuXHRjbGljayA0MSwzLTFcclxuXHRjbGljayA0MiwxLTFcclxuXHRjbGljayA0NCw5LTFcclxuXHRjbGljayA0NSwxLTFcclxuXHRjbGljayA0OSw4LTFcclxuXHRjbGljayA1NCw3LTFcclxuXHRjbGljayA1Niw2LTFcclxuXHRjbGljayA2Miw4LTFcclxuXHRjbGljayA2Myw0LTFcclxuXHRjbGljayA2OSw1LTFcclxuXHRjbGljayA3NSwzLTFcclxuXHRjbGljayA3NiwyLTFcclxuXHRjbGljayA3OCw3LTFcclxuXHRjbGljayA3OSw0LTFcclxuXHRjbGljayA4MCw2LTFcclxuXHJcbmV4cGVydCA9IC0+XHJcblx0Y2xpY2sgMiw3LTFcclxuXHRjbGljayA1LDQtMVxyXG5cdGNsaWNrIDcsMi0xXHJcblx0Y2xpY2sgOCw2LTFcclxuXHRjbGljayAxMCw5LTFcclxuXHRjbGljayAxNSw4LTFcclxuXHRjbGljayAxNywxLTFcclxuXHRjbGljayAxOSw2LTFcclxuXHRjbGljayAyNSw3LTFcclxuXHRjbGljayAzMSw5LTFcclxuXHRjbGljayAzOSw1LTFcclxuXHRjbGljayA0NSw1LTFcclxuXHRjbGljayA0Niw4LTFcclxuXHRjbGljayA0OCwxLTFcclxuXHRjbGljayA1MCw2LTFcclxuXHRjbGljayA1Myw0LTFcclxuXHRjbGljayA1NCw0LTFcclxuXHRjbGljayA1Nyw5LTFcclxuXHRjbGljayA1OSwxLTFcclxuXHRjbGljayA2Miw4LTFcclxuXHRjbGljayA2NSwxLTFcclxuXHRjbGljayA2Nyw3LTFcclxuXHRjbGljayA3MSwyLTFcclxuIl19
//# sourceURL=c:\Lab\2020\025-SudokuHelper\coffee\sketch.coffee