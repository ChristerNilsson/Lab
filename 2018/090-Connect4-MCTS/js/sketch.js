// Generated by CoffeeScript 2.3.2
var SIZE, UCB, antal, board, computerMove, delta, draw, level, list, montecarlo, mousePressed, moves, newGame, setup, thinkingTime;

thinkingTime = 50; // 10 milliseconds is ok

UCB = 2;

SIZE = 600 / (N + 1);

level = 0;

list = null;

moves = null;

board = null;

delta = 0;

montecarlo = null;

antal = 0;

setup = function() {
  createCanvas(600, 600);
  newGame();
  textAlign(CENTER, CENTER);
  return textSize(SIZE / 2);
};

newGame = function() {
  var i;
  antal = 0;
  print(' ');
  level += delta;
  if (level < 0) {
    level = 0;
  }
  delta = -2;
  board = new Board();
  list = (function() {
    var k, len, ref, results;
    ref = range(7);
    results = [];
    for (k = 0, len = ref.length; k < len; k++) {
      i = ref[k];
      results.push([]);
    }
    return results;
  })();
  moves = [];
  return montecarlo = null;
};

//computerMove()
draw = function() {
  var column, i, j, k, l, len, len1, len2, len3, msg, n, nr, o, ref, ref1, x, y;
  bg(0);
  fc();
  sc(0.1, 0.3, 1);
  sw(0.2 * SIZE);
  ref = range(N);
  for (k = 0, len = ref.length; k < len; k++) {
    i = ref[k];
    x = SIZE + i * SIZE;
    ref1 = range(M);
    for (l = 0, len1 = ref1.length; l < len1; l++) {
      j = ref1[l];
      y = height - SIZE - SIZE * j;
      circle(x, y, SIZE / 2);
    }
  }
  for (i = n = 0, len2 = list.length; n < len2; i = ++n) {
    column = list[i];
    x = SIZE + i * SIZE;
    for (j = o = 0, len3 = column.length; o < len3; j = ++o) {
      nr = column[j];
      y = height - SIZE - SIZE * j;
      fc(1, nr % 2, 0);
      sw(1);
      circle(x, y, SIZE * 0.4);
      fc(0);
      sc();
      text(nr, x, y + 4);
    }
  }
  sc();
  fc(1);
  msg = ['', 'Computer wins!', 'Remis!', 'You win!'][delta + 2];
  text(msg, width / 2, SIZE / 2 + 30);
  return text(`Level:${level} Time:${2 ** level * thinkingTime} ms`, width / 2, SIZE / 2 - 10);
};

//text UCB,width-50,SIZE/2-10
computerMove = function() {
  var dator, human, m, n1, result, start;
  if (moves.length < 2) {
    montecarlo = new MonteCarlo(new Node(null, null, board));
  } else {
    human = moves[moves.length - 1];
    dator = moves[moves.length - 2];
    n1 = montecarlo.root.n;
    montecarlo.root = montecarlo.root.children[dator].children[human];
    montecarlo.root.parent = null;
    print('Reused', nf(100 * montecarlo.root.n / n1, 0, 1), '% of the tree');
  }
  start = Date.now();
  result = montecarlo.runSearch(2 ** level);
  print('ms=', Date.now() - start, 'games=' + montecarlo.root.n, 'nodes=' + antal);
  print(montecarlo);
  
  //montecarlo.dump montecarlo.root
  //print ''
  m = montecarlo.bestPlay(montecarlo.root);
  moves.push(m);
  board.move(m);
  list[m].push(moves.length);
  if (board.done()) {
    return delta = -1;
  }
  if (board.moves.length === M * N) {
    return delta = 0;
  }
};

mousePressed = function() {
  var nr;
  antal = 0;
  if (delta !== -2) {
    return newGame();
  }
  if (mouseX < SIZE / 2 || mouseX >= width - SIZE / 2 || mouseY >= height) {
    return;
  }
  nr = int((mouseX - SIZE / 2) / SIZE);
  if ((0 <= nr && nr <= N)) {
    if (list[nr].length === M) {
      return;
    }
    moves.push(nr);
    board.move(nr);
    list[nr].push(moves.length);
  }
  if (board.done()) {
    return delta = 1;
  }
  return computerMove();
};

({
  undo: function() {
    if (moves.length > 0) {
      return list[moves.pop()].pop();
    }
  }
});

//#####

// board = new Board '3233224445230330044022166666'
// print board
// moves = [3, 2, 3, 3, 2, 2, 4, 4, 4, 5, 2, 3, 0, 3, 3, 0, 0, 4, 4, 0, 2, 2, 1, 6, 6, 6, 6, 6]
// list = []
// list.push [13,16,17,20]
// list.push [23]
// list.push [2,5,6,11,21,22]
// list.push [1,3,4,12,14,15]
// list.push [7,8,9,18,19]
// list.push [10]
// list.push [24,25,26,27,28]

//montecarlo = new MonteCarlo new Node null,null,board

//# sourceMappingURL=data:application/json;base64,eyJ2ZXJzaW9uIjozLCJmaWxlIjoic2tldGNoLmpzIiwic291cmNlUm9vdCI6Ii4uIiwic291cmNlcyI6WyJjb2ZmZWVcXHNrZXRjaC5jb2ZmZWUiXSwibmFtZXMiOltdLCJtYXBwaW5ncyI6IjtBQUFBLElBQUEsSUFBQSxFQUFBLEdBQUEsRUFBQSxLQUFBLEVBQUEsS0FBQSxFQUFBLFlBQUEsRUFBQSxLQUFBLEVBQUEsSUFBQSxFQUFBLEtBQUEsRUFBQSxJQUFBLEVBQUEsVUFBQSxFQUFBLFlBQUEsRUFBQSxLQUFBLEVBQUEsT0FBQSxFQUFBLEtBQUEsRUFBQTs7QUFBQSxZQUFBLEdBQWUsR0FBZjs7QUFDQSxHQUFBLEdBQU07O0FBRU4sSUFBQSxHQUFPLEdBQUEsR0FBSSxDQUFDLENBQUEsR0FBRSxDQUFIOztBQUNYLEtBQUEsR0FBUTs7QUFDUixJQUFBLEdBQU87O0FBQ1AsS0FBQSxHQUFROztBQUNSLEtBQUEsR0FBUTs7QUFDUixLQUFBLEdBQVE7O0FBQ1IsVUFBQSxHQUFhOztBQUNiLEtBQUEsR0FBUTs7QUFFUixLQUFBLEdBQVEsUUFBQSxDQUFBLENBQUE7RUFDUCxZQUFBLENBQWEsR0FBYixFQUFpQixHQUFqQjtFQUNBLE9BQUEsQ0FBQTtFQUNBLFNBQUEsQ0FBVSxNQUFWLEVBQWlCLE1BQWpCO1NBQ0EsUUFBQSxDQUFTLElBQUEsR0FBSyxDQUFkO0FBSk87O0FBTVIsT0FBQSxHQUFVLFFBQUEsQ0FBQSxDQUFBO0FBQ1QsTUFBQTtFQUFBLEtBQUEsR0FBUTtFQUNSLEtBQUEsQ0FBTSxHQUFOO0VBQ0EsS0FBQSxJQUFTO0VBQ1QsSUFBRyxLQUFBLEdBQVEsQ0FBWDtJQUFrQixLQUFBLEdBQVEsRUFBMUI7O0VBQ0EsS0FBQSxHQUFRLENBQUM7RUFFVCxLQUFBLEdBQVEsSUFBSSxLQUFKLENBQUE7RUFDUixJQUFBOztBQUFXO0FBQUE7SUFBQSxLQUFBLHFDQUFBOzttQkFBSDtJQUFHLENBQUE7OztFQUNYLEtBQUEsR0FBUTtTQUNSLFVBQUEsR0FBYTtBQVZKLEVBbEJWOzs7QUErQkEsSUFBQSxH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QUFIO0lBQ0MsSUFBRyxJQUFLLENBQUEsRUFBQSxDQUFHLENBQUMsTUFBVCxLQUFtQixDQUF0QjtBQUE2QixhQUE3Qjs7SUFDQSxLQUFLLENBQUMsSUFBTixDQUFXLEVBQVg7SUFDQSxLQUFLLENBQUMsSUFBTixDQUFXLEVBQVg7SUFDQSxJQUFLLENBQUEsRUFBQSxDQUFHLENBQUMsSUFBVCxDQUFjLEtBQUssQ0FBQyxNQUFwQixFQUpEOztFQU1BLElBQUcsS0FBSyxDQUFDLElBQU4sQ0FBQSxDQUFIO0FBQXFCLFdBQU8sS0FBQSxHQUFRLEVBQXBDOztTQUVBLFlBQUEsQ0FBQTtBQWRjOztBQWdCZixDQUFBO0VBQUEsSUFBQSxFQUFPLFFBQUEsQ0FBQSxDQUFBO0lBQUcsSUFBRyxLQUFLLENBQUMsTUFBTixHQUFlLENBQWxCO2FBQXlCLElBQUssQ0FBQSxLQUFLLENBQUMsR0FBTixDQUFBLENBQUEsQ0FBWSxDQUFDLEdBQWxCLENBQUEsRUFBekI7O0VBQUg7QUFBUCxDQUFBOztBQXJHQSIsInNvdXJjZXNDb250ZW50IjpbInRoaW5raW5nVGltZSA9IDUwICMgMTAgbWlsbGlzZWNvbmRzIGlzIG9rXHJcblVDQiA9IDJcclxuXHJcblNJWkUgPSA2MDAvKE4rMSlcclxubGV2ZWwgPSAwXHJcbmxpc3QgPSBudWxsXHJcbm1vdmVzID0gbnVsbFxyXG5ib2FyZCA9IG51bGxcclxuZGVsdGEgPSAwXHJcbm1vbnRlY2FybG8gPSBudWxsXHJcbmFudGFsID0gMFxyXG5cclxuc2V0dXAgPSAtPlxyXG5cdGNyZWF0ZUNhbnZhcyA2MDAsNjAwXHJcblx0bmV3R2FtZSgpXHJcblx0dGV4dEFsaWduIENFTlRFUixDRU5URVJcclxuXHR0ZXh0U2l6ZSBTSVpFLzJcclxuXHJcbm5ld0dhbWUgPSAoKSAtPlxyXG5cdGFudGFsID0gMFxyXG5cdHByaW50ICcgJ1xyXG5cdGxldmVsICs9IGRlbHRhXHJcblx0aWYgbGV2ZWwgPCAwIHRoZW4gbGV2ZWwgPSAwXHJcblx0ZGVsdGEgPSAtMlxyXG5cclxuXHRib2FyZCA9IG5ldyBCb2FyZCgpXHJcblx0bGlzdCA9IChbXSBmb3IgaSBpbiByYW5nZSA3KVxyXG5cdG1vdmVzID0gW11cclxuXHRtb250ZWNhcmxvID0gbnVsbFxyXG5cdCNjb21wdXRlck1vdmUoKVxyXG5cclxuZHJhdyA9IC0+XHJcblx0YmcgMFxyXG5cdGZjKClcclxuXHRzYyAwLjEsMC4zLDFcclxuXHRzdyAwLjIgKiBTSVpFXHJcblx0Zm9yIGkgaW4gcmFuZ2UgTlxyXG5cdFx0eCA9IFNJWkUgKyBpKlNJWkVcclxuXHRcdGZvciBqIGluIHJhbmdlIE1cclxuXHRcdFx0eSA9IGhlaWdodC1TSVpFIC0gU0laRSpqXHJcblx0XHRcdGNpcmNsZSB4LCB5LCBTSVpFLzJcclxuXHJcblx0Zm9yIGNvbHVtbixpIGluIGxpc3RcclxuXHRcdHggPSBTSVpFICsgaSpTSVpFXHJcblx0XHRmb3IgbnIsaiBpbiBjb2x1bW5cclxuXHRcdFx0eSA9IGhlaWdodC1TSVpFIC0gU0laRSpqXHJcblx0XHRcdGZjIDEsbnIlMiwwXHJcblx0XHRcdHN3IDFcclxuXHRcdFx0Y2lyY2xlIHgsIHksIFNJWkUqMC40XHJcblx0XHRcdGZjIDBcclxuXHRcdFx0c2MoKVxyXG5cdFx0XHR0ZXh0IG5yLCB4LCB5KzRcclxuXHRzYygpXHJcblx0ZmMgMVxyXG5cdG1zZyA9IFsnJywnQ29tcHV0ZXIgd2lucyEnLCdSZW1pcyEnLCdZb3Ugd2luISddW2RlbHRhKzJdXHJcblx0dGV4dCBtc2csd2lkdGgvMixTSVpFLzIrMzBcclxuXHR0ZXh0IFwiTGV2ZWw6I3tsZXZlbH0gVGltZTojezIqKmxldmVsKnRoaW5raW5nVGltZX0gbXNcIix3aWR0aC8yLFNJWkUvMi0xMFxyXG5cdCN0ZXh0IFVDQix3aWR0aC01MCxTSVpFLzItMTBcclxuXHJcbmNvbXB1dGVyTW92ZSA9IC0+XHJcblx0aWYgbW92ZXMubGVuZ3RoIDwgMiBcclxuXHRcdG1vbnRlY2FybG8gPSBuZXcgTW9udGVDYXJsbyBuZXcgTm9kZSBudWxsLG51bGwsYm9hcmRcclxuXHRlbHNlXHJcblx0XHRodW1hbiA9IG1vdmVzW21vdmVzLmxlbmd0aC0xXVxyXG5cdFx0ZGF0b3IgPSBtb3Zlc1ttb3Zlcy5sZW5ndGgtMl1cclxuXHRcdG4xID0gbW9udGVjYXJsby5yb290Lm5cclxuXHRcdG1vbnRlY2FybG8ucm9vdCA9IG1vbnRlY2FybG8ucm9vdC5jaGlsZHJlbltkYXRvcl0uY2hpbGRyZW5baHVtYW5dXHJcblx0XHRtb250ZWNhcmxvLnJvb3QucGFyZW50ID0gbnVsbFxyXG5cdFx0cHJpbnQgJ1JldXNlZCcsbmYoMTAwKm1vbnRlY2FybG8ucm9vdC5uL24xLDAsMSksJyUgb2YgdGhlIHRyZWUnXHJcblxyXG5cdHN0YXJ0ID0gRGF0ZS5ub3coKVxyXG5cdHJlc3VsdCA9IG1vbnRlY2FybG8ucnVuU2VhcmNoIDIqKmxldmVsXHJcblx0cHJpbnQgJ21zPScsRGF0ZS5ub3coKS1zdGFydCwgJ2dhbWVzPScrbW9udGVjYXJsby5yb290Lm4sICdub2Rlcz0nK2FudGFsXHJcblx0cHJpbnQgbW9udGVjYXJsb1x0XHJcblxyXG5cdCNtb250ZWNhcmxvLmR1bXAgbW9udGVjYXJsby5yb290XHJcblx0I3ByaW50ICcnXHJcblxyXG5cdG0gPSBtb250ZWNhcmxvLmJlc3RQbGF5IG1vbnRlY2FybG8ucm9vdFxyXG5cdG1vdmVzLnB1c2ggbVxyXG5cdGJvYXJkLm1vdmUgbVxyXG5cdGxpc3RbbV0ucHVzaCBtb3Zlcy5sZW5ndGhcclxuXHRpZiBib2FyZC5kb25lKCkgdGhlbiByZXR1cm4gZGVsdGEgPSAtMVxyXG5cdGlmIGJvYXJkLm1vdmVzLmxlbmd0aCA9PSBNKk4gdGhlbiBkZWx0YSA9IDBcdFxyXG5cclxubW91c2VQcmVzc2VkID0gLT5cclxuXHRhbnRhbD0wXHJcblx0aWYgZGVsdGEgIT0gLTIgdGhlbiByZXR1cm4gbmV3R2FtZSgpXHJcblx0aWYgbW91c2VYPFNJWkUvMiBvciBtb3VzZVg+PXdpZHRoLVNJWkUvMiBvciBtb3VzZVk+PWhlaWdodCB0aGVuIHJldHVyblxyXG5cdG5yID0gaW50IChtb3VzZVgtU0laRS8yKS9TSVpFXHJcblxyXG5cdGlmIDAgPD0gbnIgPD0gTlxyXG5cdFx0aWYgbGlzdFtucl0ubGVuZ3RoID09IE0gdGhlbiByZXR1cm5cclxuXHRcdG1vdmVzLnB1c2ggbnJcclxuXHRcdGJvYXJkLm1vdmUgbnJcclxuXHRcdGxpc3RbbnJdLnB1c2ggbW92ZXMubGVuZ3RoXHJcblxyXG5cdGlmIGJvYXJkLmRvbmUoKSB0aGVuIHJldHVybiBkZWx0YSA9IDFcclxuXHJcblx0Y29tcHV0ZXJNb3ZlKClcclxuXHJcbnVuZG8gOiAtPiBpZiBtb3Zlcy5sZW5ndGggPiAwIHRoZW4gbGlzdFttb3Zlcy5wb3AoKV0ucG9wKClcclxuXHJcbiMjIyMjI1xyXG5cclxuXHQjIGJvYXJkID0gbmV3IEJvYXJkICczMjMzMjI0NDQ1MjMwMzMwMDQ0MDIyMTY2NjY2J1xyXG5cdCMgcHJpbnQgYm9hcmRcclxuXHQjIG1vdmVzID0gWzMsIDIsIDMsIDMsIDIsIDIsIDQsIDQsIDQsIDUsIDIsIDMsIDAsIDMsIDMsIDAsIDAsIDQsIDQsIDAsIDIsIDIsIDEsIDYsIDYsIDYsIDYsIDZdXHJcblx0IyBsaXN0ID0gW11cclxuXHQjIGxpc3QucHVzaCBbMTMsMTYsMTcsMjBdXHJcblx0IyBsaXN0LnB1c2ggWzIzXVxyXG5cdCMgbGlzdC5wdXNoIFsyLDUsNiwxMSwyMSwyMl1cclxuXHQjIGxpc3QucHVzaCBbMSwzLDQsMTIsMTQsMTVdXHJcblx0IyBsaXN0LnB1c2ggWzcsOCw5LDE4LDE5XVxyXG5cdCMgbGlzdC5wdXNoIFsxMF1cclxuXHQjIGxpc3QucHVzaCBbMjQsMjUsMjYsMjcsMjhdXHJcblxyXG5cdCNtb250ZWNhcmxvID0gbmV3IE1vbnRlQ2FybG8gbmV3IE5vZGUgbnVsbCxudWxsLGJvYXJkXHJcbiJdfQ==
//# sourceURL=C:\Lab\2018\090-Connect4-MCTS\coffee\sketch.coffee