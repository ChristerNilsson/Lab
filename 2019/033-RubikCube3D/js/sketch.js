// Generated by CoffeeScript 2.3.2
var ALPHABET, COLORS, R, SWAPS, backup, change, cube, draw, i, setup;

COLORS = "#FFF #00F #FF0 #0F0 #FA5 #F00".split(' '); // W B Y G O R

ALPHABET = 'abcdefgh jklmnopq ABCDEFGH JKLMNOPQ STUVWXYZ stuvwxyz';

SWAPS = {
  W: 'aceg bdfh wjWN xkXO ylYP',
  B: 'lnpj moqk euAY fvBZ gwCS',
  Y: 'GECA HFDB nsJS otKT puLU',
  G: 'PNLJ QOMK EyaU FzbV GscW',
  O: 'YWUS ZXVT ajGJ hqHQ gpAP',
  R: 'suwy tvxz LClc MDmd NEne'
};

R = 60;

backup = (function() {
  var len, m, ref, results;
  ref = range(54);
  results = [];
  for (m = 0, len = ref.length; m < len; m++) {
    i = ref[m];
    results.push(Math.floor(i / 9));
  }
  return results;
})();

cube = null;

change = function(letters) {
  var LETTER, a, b, c, d, j, k, l, len, len1, letter, m, n, w, word, words;
  cube = backup.slice();
  for (m = 0, len = letters.length; m < len; m++) {
    letter = letters[m];
    LETTER = letter.toUpperCase();
    if (!(LETTER in SWAPS)) {
      return;
    }
    words = SWAPS[LETTER].split(' ');
    for (n = 0, len1 = words.length; n < len1; n++) {
      word = words[n];
      [i, j, k, l] = (function() {
        var len2, o, results;
        results = [];
        for (o = 0, len2 = word.length; o < len2; o++) {
          w = word[o];
          results.push(ALPHABET.indexOf(w));
        }
        return results;
      })();
      [a, b, c, d] = LETTER === letter ? [l, i, j, k] : [j, k, l, i];
      [cube[a], cube[b], cube[c], cube[d]] = [cube[i], cube[j], cube[k], cube[l]];
    }
  }
};

setup = function() {
  return createCanvas(800, 800, WEBGL);
};

draw = function() {
  var j, k, len, m, ref, results, side, x, z;
  change(txt.value);
  background(0);
  orbitControl(4, 4);
  ref = range(6);
  results = [];
  for (m = 0, len = ref.length; m < len; m++) {
    side = ref[m];
    rotateX(HALF_PI * [1, 1, 1, 1, 0, 0][side]);
    rotateZ(HALF_PI * [0, 0, 0, 0, 1, 2][side]);
    results.push((function() {
      var len1, len2, n, o, ref1, ref2, results1;
      ref1 = [[-1, -1], [0, -1], [1, -1], [1, 0], [1, 1], [0, 1], [-1, 1], [-1, 0], [0, 0]];
      results1 = [];
      for (k = n = 0, len1 = ref1.length; n < len1; k = ++n) {
        [i, j] = ref1[k];
        push();
        translate(2 * R * i, 2 * R, 2 * R * j);
        beginShape();
        fill(COLORS[cube[9 * side + k]]);
        ref2 = [[-R, -R], [R, -R], [R, R], [-R, R]];
        for (o = 0, len2 = ref2.length; o < len2; o++) {
          [x, z] = ref2[o];
          vertex(x, R, z);
        }
        endShape(CLOSE);
        results1.push(pop());
      }
      return results1;
    })());
  }
  return results;
};

//# sourceMappingURL=data:application/json;base64,eyJ2ZXJzaW9uIjozLCJmaWxlIjoic2tldGNoLmpzIiwic291cmNlUm9vdCI6Ii4uIiwic291cmNlcyI6WyJjb2ZmZWVcXHNrZXRjaC5jb2ZmZWUiXSwibmFtZXMiOltdLCJtYXBwaW5ncyI6IjtBQUFBLElBQUEsUUFBQSxFQUFBLE1BQUEsRUFBQSxDQUFBLEVBQUEsS0FBQSxFQUFBLE1BQUEsRUFBQSxNQUFBLEVBQUEsSUFBQSxFQUFBLElBQUEsRUFBQSxDQUFBLEVBQUE7O0FBQUEsTUFBQSxHQUFTLCtCQUErQixDQUFDLEtBQWhDLENBQXNDLEdBQXRDLEVBQVQ7O0FBQ0EsUUFBQSxHQUFXOztBQUNYLEtBQUEsR0FDQztFQUFBLENBQUEsRUFBRywwQkFBSDtFQUNBLENBQUEsRUFBRywwQkFESDtFQUVBLENBQUEsRUFBRywwQkFGSDtFQUdBLENBQUEsRUFBRywwQkFISDtFQUlBLENBQUEsRUFBRywwQkFKSDtFQUtBLENBQUEsRUFBRztBQUxIOztBQU1ELENBQUEsR0FBSTs7QUFFSixNQUFBOztBQUFlO0FBQUE7RUFBQSxLQUFBLHFDQUFBOzs0QkFBTCxJQUFHO0VBQUUsQ0FBQTs7OztBQUNmLElBQUEsR0FBTzs7QUFFUCxNQUFBLEdBQVMsUUFBQSxDQUFDLE9BQUQsQ0FBQTtBQUNSLE1BQUEsTUFBQSxFQUFBLENBQUEsRUFBQSxDQUFBLEVBQUEsQ0FBQSxFQUFBLENBQUEsRUFBQSxDQUFBLEVBQUEsQ0FBQSxFQUFBLENBQUEsRUFBQSxHQUFBLEVBQUEsSUFBQSxFQUFBLE1BQUEsRUFBQSxDQUFBLEVBQUEsQ0FBQSxFQUFBLENBQUEsRUFBQSxJQUFBLEVBQUE7RUFBQSxJQUFBLEdBQU8sTUFBTSxDQUFDLEtBQVAsQ0FBQTtFQUNQLEtBQUEseUNBQUE7O0lBQ0MsTUFBQSxHQUFTLE1BQU0sQ0FBQyxXQUFQLENBQUE7SUFDVCxJQUFHLENBQUEsQ0FBQSxNQUFBLElBQWMsS0FBZCxDQUFIO0FBQTRCLGFBQTVCOztJQUNBLEtBQUEsR0FBUSxLQUFNLENBQUEsTUFBQSxDQUFPLENBQUMsS0FBZCxDQUFvQixHQUFwQjtJQUNSLEtBQUEseUNBQUE7O01BQ0MsQ0FBQyxDQUFELEVBQUcsQ0FBSCxFQUFLLENBQUwsRUFBTyxDQUFQLENBQUE7O0FBQWdDO1FBQUEsS0FBQSx3Q0FBQTs7dUJBQW5CLFFBQVEsQ0FBQyxPQUFULENBQWlCLENBQWpCO1FBQW1CLENBQUE7OztNQUNoQyxDQUFDLENBQUQsRUFBRyxDQUFILEVBQUssQ0FBTCxFQUFPLENBQVAsQ0FBQSxHQUFlLE1BQUEsS0FBVSxNQUFiLEdBQXlCLENBQUMsQ0FBRCxFQUFHLENBQUgsRUFBSyxDQUFMLEVBQU8sQ0FBUCxDQUF6QixHQUF3QyxDQUFDLENBQUQsRUFBRyxDQUFILEVBQUssQ0FBTCxFQUFPLENBQVA7TUFDcEQsQ0FBQyxJQUFLLENBQUEsQ0FBQSxDQUFOLEVBQVMsSUFBSyxDQUFBLENBQUEsQ0FBZCxFQUFpQixJQUFLLENBQUEsQ0FBQSxDQUF0QixFQUF5QixJQUFLLENBQUEsQ0FBQSxDQUE5QixDQUFBLEdBQW9DLENBQUMsSUFBSyxDQUFBLENBQUEsQ0FBTixFQUFTLElBQUssQ0FBQSxDQUFBLENBQWQsRUFBaUIsSUFBSyxDQUFBLENBQUEsQ0FBdEIsRUFBeUIsSUFBSyxDQUFBLENBQUEsQ0FBOUI7SUFIckM7RUFKRDtBQUZROztBQVdULEtBQUEsR0FBUSxRQUFBLENBQUEsQ0FBQTtTQUFHLFlBQUEsQ0FBYSxHQUFiLEVBQWlCLEdBQWpCLEVBQXNCLEtBQXRCO0FBQUg7O0FBRVIsSUFBQSxHQUFPLFFBQUEsQ0FBQSxDQUFBO0FBQ04sTUFBQSxDQUFBLEVBQUEsQ0FBQSxFQUFBLEdBQUEsRUFBQSxDQUFBLEVBQUEsR0FBQSxFQUFBLE9BQUEsRUFBQSxJQUFBLEVBQUEsQ0FBQSxFQUFBO0VBQUEsTUFBQSxDQUFPLEdBQUcsQ0FBQyxLQUFYO0VBQ0EsVUFBQSxDQUFXLENBQVg7RUFDQSxZQUFBLENBQWEsQ0FBYixFQUFlLENBQWY7QUFDQTtBQUFBO0VBQUEsS0FBQSxxQ0FBQTs7SUFDQyxPQUFBLENBQVEsT0FBQSxHQUFVLENBQUMsQ0FBRCxFQUFHLENBQUgsRUFBSyxDQUFMLEVBQU8sQ0FBUCxFQUFTLENBQVQsRUFBVyxDQUFYLENBQWMsQ0FBQSxJQUFBLENBQWhDO0lBQ0EsT0FBQSxDQUFRLE9BQUEsR0FBVSxDQUFDLENBQUQsRUFBRyxDQUFILEVBQUssQ0FBTCxFQUFPLENBQVAsRUFBUyxDQUFULEVBQVcsQ0FBWCxDQUFjLENBQUEsSUFBQSxDQUFoQzs7O0FBQ0E7QUFBQTtNQUFBLEtBQUEsZ0RBQUE7UUFBSSxDQUFDLENBQUQsRUFBRyxDQUFIO1FBQ0gsSUFBQSxDQUFBO1FBQ0EsU0FBQSxDQUFVLENBQUEsR0FBRSxDQUFGLEdBQUksQ0FBZCxFQUFpQixDQUFBLEdBQUUsQ0FBbkIsRUFBc0IsQ0FBQSxHQUFFLENBQUYsR0FBSSxDQUExQjtRQUNBLFVBQUEsQ0FBQTtRQUNBLElBQUEsQ0FBSyxNQUFPLENBQUEsSUFBSyxDQUFBLENBQUEsR0FBRSxJQUFGLEdBQU8sQ0FBUCxDQUFMLENBQVo7QUFDYTtRQUFBLEtBQUEsd0NBQUE7VUFBSSxDQUFDLENBQUQsRUFBRyxDQUFIO1VBQWpCLE1BQUEsQ0FBTyxDQUFQLEVBQVMsQ0FBVCxFQUFXLENBQVg7UUFBYTtRQUNiLFFBQUEsQ0FBUyxLQUFUO3NCQUNBLEdBQUEsQ0FBQTtNQVBELENBQUE7OztFQUhELENBQUE7O0FBSk0iLCJzb3VyY2VzQ29udGVudCI6WyJDT0xPUlMgPSBcIiNGRkYgIzAwRiAjRkYwICMwRjAgI0ZBNSAjRjAwXCIuc3BsaXQgJyAnICMgVyBCIFkgRyBPIFJcclxuQUxQSEFCRVQgPSAnYWJjZGVmZ2ggamtsbW5vcHEgQUJDREVGR0ggSktMTU5PUFEgU1RVVldYWVogc3R1dnd4eXonIFxyXG5TV0FQUyA9IFxyXG5cdFc6ICdhY2VnIGJkZmggd2pXTiB4a1hPIHlsWVAnIFxyXG5cdEI6ICdsbnBqIG1vcWsgZXVBWSBmdkJaIGd3Q1MnXHJcblx0WTogJ0dFQ0EgSEZEQiBuc0pTIG90S1QgcHVMVSdcclxuXHRHOiAnUE5MSiBRT01LIEV5YVUgRnpiViBHc2NXJ1xyXG5cdE86ICdZV1VTIFpYVlQgYWpHSiBocUhRIGdwQVAnXHJcblx0UjogJ3N1d3kgdHZ4eiBMQ2xjIE1EbWQgTkVuZScgIFxyXG5SID0gNjBcclxuXHJcbmJhY2t1cCA9IChpLy85IGZvciBpIGluIHJhbmdlIDU0KVxyXG5jdWJlID0gbnVsbFxyXG5cclxuY2hhbmdlID0gKGxldHRlcnMpIC0+IFxyXG5cdGN1YmUgPSBiYWNrdXAuc2xpY2UoKVxyXG5cdGZvciBsZXR0ZXIgaW4gbGV0dGVyc1xyXG5cdFx0TEVUVEVSID0gbGV0dGVyLnRvVXBwZXJDYXNlKCkgXHJcblx0XHRpZiBMRVRURVIgbm90IG9mIFNXQVBTIHRoZW4gcmV0dXJuIFxyXG5cdFx0d29yZHMgPSBTV0FQU1tMRVRURVJdLnNwbGl0ICcgJ1xyXG5cdFx0Zm9yIHdvcmQgaW4gd29yZHNcclxuXHRcdFx0W2ksaixrLGxdID0gKEFMUEhBQkVULmluZGV4T2YgdyBmb3IgdyBpbiB3b3JkKVxyXG5cdFx0XHRbYSxiLGMsZF0gPSBpZiBMRVRURVIgPT0gbGV0dGVyIHRoZW4gW2wsaSxqLGtdIGVsc2UgW2osayxsLGldXHJcblx0XHRcdFtjdWJlW2FdLGN1YmVbYl0sY3ViZVtjXSxjdWJlW2RdXSA9IFtjdWJlW2ldLGN1YmVbal0sY3ViZVtrXSxjdWJlW2xdXVxyXG5cclxuc2V0dXAgPSAtPiBjcmVhdGVDYW52YXMgODAwLDgwMCwgV0VCR0xcclxuXHJcbmRyYXcgPSAtPlxyXG5cdGNoYW5nZSB0eHQudmFsdWVcclxuXHRiYWNrZ3JvdW5kIDBcclxuXHRvcmJpdENvbnRyb2wgNCw0XHJcblx0Zm9yIHNpZGUgaW4gcmFuZ2UgNlxyXG5cdFx0cm90YXRlWCBIQUxGX1BJICogWzEsMSwxLDEsMCwwXVtzaWRlXVxyXG5cdFx0cm90YXRlWiBIQUxGX1BJICogWzAsMCwwLDAsMSwyXVtzaWRlXVxyXG5cdFx0Zm9yIFtpLGpdLGsgaW4gW1stMSwtMV0sWzAsLTFdLFsxLC0xXSxbMSwwXSxbMSwxXSxbMCwxXSxbLTEsMV0sWy0xLDBdLFswLDBdXVxyXG5cdFx0XHRwdXNoKClcclxuXHRcdFx0dHJhbnNsYXRlIDIqUippLCAyKlIsIDIqUipqXHJcblx0XHRcdGJlZ2luU2hhcGUoKVxyXG5cdFx0XHRmaWxsIENPTE9SU1tjdWJlWzkqc2lkZStrXV1cclxuXHRcdFx0dmVydGV4IHgsUix6IGZvciBbeCx6XSBpbiBbWy1SLC1SXSxbUiwtUl0sW1IsUl0sWy1SLFJdXVx0XHRcdFx0XHJcblx0XHRcdGVuZFNoYXBlKENMT1NFKVxyXG5cdFx0XHRwb3AoKVxyXG4iXX0=
//# sourceURL=C:\Lab\2019\033-RubikCube3D\coffee\sketch.coffee