// Generated by CoffeeScript 1.11.1
var EMPTY, MARKERS, WINNERS, ai, drawOnce, hist, marks, mousePressed, move, newGame, setup, state,
  indexOf = [].indexOf || function(item) { for (var i = 0, l = this.length; i < l; i++) { if (i in this && this[i] === item) return i; } return -1; };

EMPTY = ' ';

MARKERS = 'XO';

WINNERS = [1 + 2 + 4, 8 + 16 + 32, 64 + 128 + 256, 1 + 8 + 64, 2 + 16 + 128, 4 + 32 + 256, 1 + 16 + 256, 4 + 16 + 64];

marks = null;

state = null;

hist = null;

ai = function() {
  return _.sample(_.difference(range(9), hist));
};

drawOnce = function() {
  var i, index, len, ref, ref1, x, y;
  ref = range(9);
  for (i = 0, len = ref.length; i < len; i++) {
    index = ref[i];
    ref1 = [100 * (index % 3), 100 * int(index / 3)], x = ref1[0], y = ref1[1];
    fc(1);
    rect(x, y, 100, 100);
    fc(0);
    if (indexOf.call(hist, index) >= 0) {
      text(MARKERS[hist.indexOf(index) % 2], x + 50, y + 50);
    }
  }
  fc(1, 0, 0);
  return text(state, 150, 150);
};

mousePressed = function() {
  var index;
  if (state !== '') {
    return newGame();
  }
  index = (int(mouseX / 100)) + 3 * int(mouseY / 100);
  if (indexOf.call(hist, index) < 0) {
    move(0, index);
    if (hist.length === 9) {
      state = 'draw!';
    } else {
      move(1, ai());
    }
    return drawOnce();
  }
};

move = function(player, position) {
  var i, len, results, winner;
  if (state !== '') {
    return;
  }
  hist.push(position);
  marks[player] |= 1 << position;
  results = [];
  for (i = 0, len = WINNERS.length; i < len; i++) {
    winner = WINNERS[i];
    if ((winner & marks[player]) === winner) {
      results.push(state = MARKERS[player] + ' wins!');
    } else {
      results.push(void 0);
    }
  }
  return results;
};

newGame = function() {
  marks = [0, 0];
  state = '';
  hist = [];
  return drawOnce();
};

setup = function() {
  createCanvas(400, 400);
  textAlign(CENTER, CENTER);
  textSize(90);
  return newGame();
};

//# sourceMappingURL=data:application/json;base64,eyJ2ZXJzaW9uIjozLCJmaWxlIjoic2tldGNoLmpzIiwic291cmNlUm9vdCI6Ii4uIiwic291cmNlcyI6WyJjb2ZmZWVcXHNrZXRjaC5jb2ZmZWUiXSwibmFtZXMiOltdLCJtYXBwaW5ncyI6IjtBQUFBLElBQUEsNkZBQUE7RUFBQTs7QUFBQSxLQUFBLEdBQVE7O0FBQ1IsT0FBQSxHQUFVOztBQUNWLE9BQUEsR0FBVSxDQUFDLENBQUEsR0FBRSxDQUFGLEdBQUksQ0FBTCxFQUFPLENBQUEsR0FBRSxFQUFGLEdBQUssRUFBWixFQUFlLEVBQUEsR0FBRyxHQUFILEdBQU8sR0FBdEIsRUFBMEIsQ0FBQSxHQUFFLENBQUYsR0FBSSxFQUE5QixFQUFpQyxDQUFBLEdBQUUsRUFBRixHQUFLLEdBQXRDLEVBQTBDLENBQUEsR0FBRSxFQUFGLEdBQUssR0FBL0MsRUFBbUQsQ0FBQSxHQUFFLEVBQUYsR0FBSyxHQUF4RCxFQUE0RCxDQUFBLEdBQUUsRUFBRixHQUFLLEVBQWpFOztBQUVWLEtBQUEsR0FBUTs7QUFDUixLQUFBLEdBQVE7O0FBQ1IsSUFBQSxHQUFPOztBQUVQLEVBQUEsR0FBSyxTQUFBO1NBQUcsQ0FBQyxDQUFDLE1BQUYsQ0FBUyxDQUFDLENBQUMsVUFBRixDQUFhLEtBQUEsQ0FBTSxDQUFOLENBQWIsRUFBdUIsSUFBdkIsQ0FBVDtBQUFIOztBQUVMLFFBQUEsR0FBVyxTQUFBO0FBQ1YsTUFBQTtBQUFBO0FBQUEsT0FBQSxxQ0FBQTs7SUFDQyxPQUFRLENBQUMsR0FBQSxHQUFNLENBQUMsS0FBQSxHQUFNLENBQVAsQ0FBUCxFQUFrQixHQUFBLEdBQU0sR0FBQSxDQUFJLEtBQUEsR0FBTSxDQUFWLENBQXhCLENBQVIsRUFBQyxXQUFELEVBQUc7SUFDSCxFQUFBLENBQUcsQ0FBSDtJQUNBLElBQUEsQ0FBSyxDQUFMLEVBQU8sQ0FBUCxFQUFTLEdBQVQsRUFBYSxHQUFiO0lBQ0EsRUFBQSxDQUFHLENBQUg7SUFDQSxJQUFHLGFBQVMsSUFBVCxFQUFBLEtBQUEsTUFBSDtNQUFzQixJQUFBLENBQUssT0FBUSxDQUFBLElBQUksQ0FBQyxPQUFMLENBQWEsS0FBYixDQUFBLEdBQW9CLENBQXBCLENBQWIsRUFBcUMsQ0FBQSxHQUFFLEVBQXZDLEVBQTBDLENBQUEsR0FBRSxFQUE1QyxFQUF0Qjs7QUFMRDtFQU1BLEVBQUEsQ0FBRyxDQUFILEVBQUssQ0FBTCxFQUFPLENBQVA7U0FDQSxJQUFBLENBQUssS0FBTCxFQUFXLEdBQVgsRUFBZSxHQUFmO0FBUlU7O0FBVVgsWUFBQSxHQUFlLFNBQUE7QUFDZCxNQUFBO0VBQUEsSUFBRyxLQUFBLEtBQVMsRUFBWjtBQUFvQixXQUFPLE9BQUEsQ0FBQSxFQUEzQjs7RUFDQSxLQUFBLEdBQVEsQ0FBQyxHQUFBLENBQUksTUFBQSxHQUFPLEdBQVgsQ0FBRCxDQUFBLEdBQW1CLENBQUEsR0FBSSxHQUFBLENBQUksTUFBQSxHQUFPLEdBQVg7RUFDL0IsSUFBRyxhQUFhLElBQWIsRUFBQSxLQUFBLEtBQUg7SUFDQyxJQUFBLENBQUssQ0FBTCxFQUFPLEtBQVA7SUFDQSxJQUFHLElBQUksQ0FBQyxNQUFMLEtBQWEsQ0FBaEI7TUFBdUIsS0FBQSxHQUFRLFFBQS9CO0tBQUEsTUFBQTtNQUE0QyxJQUFBLENBQUssQ0FBTCxFQUFPLEVBQUEsQ0FBQSxDQUFQLEVBQTVDOztXQUNBLFFBQUEsQ0FBQSxFQUhEOztBQUhjOztBQVFmLElBQUEsR0FBTyxTQUFDLE1BQUQsRUFBUSxRQUFSO0FBQ04sTUFBQTtFQUFBLElBQUcsS0FBQSxLQUFTLEVBQVo7QUFBb0IsV0FBcEI7O0VBQ0EsSUFBSSxDQUFDLElBQUwsQ0FBVSxRQUFWO0VBQ0EsS0FBTSxDQUFBLE1BQUEsQ0FBTixJQUFpQixDQUFBLElBQUs7QUFDdEI7T0FBQSx5Q0FBQTs7SUFDQyxJQUFHLENBQUMsTUFBQSxHQUFTLEtBQU0sQ0FBQSxNQUFBLENBQWhCLENBQUEsS0FBNEIsTUFBL0I7bUJBQTJDLEtBQUEsR0FBUSxPQUFRLENBQUEsTUFBQSxDQUFSLEdBQWtCLFVBQXJFO0tBQUEsTUFBQTsyQkFBQTs7QUFERDs7QUFKTTs7QUFPUCxPQUFBLEdBQVUsU0FBQTtFQUNULEtBQUEsR0FBUSxDQUFDLENBQUQsRUFBRyxDQUFIO0VBQ1IsS0FBQSxHQUFRO0VBQ1IsSUFBQSxHQUFPO1NBQ1AsUUFBQSxDQUFBO0FBSlM7O0FBTVYsS0FBQSxHQUFRLFNBQUE7RUFDUCxZQUFBLENBQWEsR0FBYixFQUFpQixHQUFqQjtFQUNBLFNBQUEsQ0FBVSxNQUFWLEVBQWlCLE1BQWpCO0VBQ0EsUUFBQSxDQUFTLEVBQVQ7U0FDQSxPQUFBLENBQUE7QUFKTyIsInNvdXJjZXNDb250ZW50IjpbIkVNUFRZID0gJyAnXHJcbk1BUktFUlMgPSAnWE8nXHJcbldJTk5FUlMgPSBbMSsyKzQsOCsxNiszMiw2NCsxMjgrMjU2LDErOCs2NCwyKzE2KzEyOCw0KzMyKzI1NiwxKzE2KzI1Niw0KzE2KzY0XVxyXG5cclxubWFya3MgPSBudWxsXHJcbnN0YXRlID0gbnVsbFxyXG5oaXN0ID0gbnVsbFxyXG5cclxuYWkgPSAtPiBfLnNhbXBsZSBfLmRpZmZlcmVuY2UgcmFuZ2UoOSksIGhpc3RcclxuXHJcbmRyYXdPbmNlID0gLT5cclxuXHRmb3IgaW5kZXggaW4gcmFuZ2UgOVxyXG5cdFx0W3gseV0gPSBbMTAwICogKGluZGV4JTMpLCAxMDAgKiBpbnQgaW5kZXgvM11cclxuXHRcdGZjIDFcclxuXHRcdHJlY3QgeCx5LDEwMCwxMDBcclxuXHRcdGZjIDBcclxuXHRcdGlmIGluZGV4IGluIGhpc3QgdGhlbiB0ZXh0IE1BUktFUlNbaGlzdC5pbmRleE9mKGluZGV4KSUyXSwgeCs1MCx5KzUwXHJcblx0ZmMgMSwwLDBcclxuXHR0ZXh0IHN0YXRlLDE1MCwxNTBcclxuXHJcbm1vdXNlUHJlc3NlZCA9IC0+XHJcblx0aWYgc3RhdGUgIT0gJycgdGhlbiByZXR1cm4gbmV3R2FtZSgpXHJcblx0aW5kZXggPSAoaW50IG1vdXNlWC8xMDApICsgMyAqIGludCBtb3VzZVkvMTAwXHJcblx0aWYgaW5kZXggbm90IGluIGhpc3RcclxuXHRcdG1vdmUgMCxpbmRleFxyXG5cdFx0aWYgaGlzdC5sZW5ndGg9PTkgdGhlbiBzdGF0ZSA9ICdkcmF3IScgZWxzZSBtb3ZlIDEsYWkoKVxyXG5cdFx0ZHJhd09uY2UoKVxyXG5cclxubW92ZSA9IChwbGF5ZXIscG9zaXRpb24pIC0+XHJcblx0aWYgc3RhdGUgIT0gJycgdGhlbiByZXR1cm5cclxuXHRoaXN0LnB1c2ggcG9zaXRpb25cclxuXHRtYXJrc1twbGF5ZXJdIHw9IDEgPDwgcG9zaXRpb25cclxuXHRmb3Igd2lubmVyIGluIFdJTk5FUlNcclxuXHRcdGlmICh3aW5uZXIgJiBtYXJrc1twbGF5ZXJdKSA9PSB3aW5uZXIgdGhlbiBzdGF0ZSA9IE1BUktFUlNbcGxheWVyXSArICcgd2lucyEnXHJcblxyXG5uZXdHYW1lID0gLT5cclxuXHRtYXJrcyA9IFswLDBdXHJcblx0c3RhdGUgPSAnJ1xyXG5cdGhpc3QgPSBbXVxyXG5cdGRyYXdPbmNlKClcclxuXHJcbnNldHVwID0gLT5cclxuXHRjcmVhdGVDYW52YXMgNDAwLDQwMFxyXG5cdHRleHRBbGlnbiBDRU5URVIsQ0VOVEVSXHJcblx0dGV4dFNpemUgOTBcclxuXHRuZXdHYW1lKCkiXX0=
//# sourceURL=C:\Lab\2017\078-TicTacToe\coffee\sketch.coffee