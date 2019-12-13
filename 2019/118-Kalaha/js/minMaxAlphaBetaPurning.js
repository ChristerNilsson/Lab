// Generated by CoffeeScript 2.4.1
var MaxValueAlphaBetaPruning, MinMaxDecisionAlphaBetaPruning, MinValueAlphaBetaPruning;

MinMaxDecisionAlphaBetaPruning = function(depthMax, player) {
  var alpha, beta, house, playerShop;
  alpha = -1000;
  beta = 1000;
  house = buttons.map(function(button) {
    return button.value;
  });
  playerShop = 6;
  if (player === 1) {
    playerShop = 13;
  }
  return MaxValueAlphaBetaPruning(house, depthMax, 0, alpha, beta, playerShop);
};

MaxValueAlphaBetaPruning = function(house, depthMax, depth, alpha, beta, playerShop) {
  var action, i, j, len, ref, tempHouse, tempValue;
  if (HasSuccessors(house) === false) {
    FinalScoring(house);
    return Evaluate(house, playerShop, (playerShop + 7) % 14);
  } else if (depth >= depthMax) {
    return Evaluate(house, playerShop, (playerShop + 7) % 14);
  } else {
    action = null;
    ref = range(playerShop - 6, playerShop);
    for (j = 0, len = ref.length; j < len; j++) {
      i = ref[j];
      if (house[i] === 0) {
        continue;
      }
      tempHouse = house.slice();
      tempValue = null;
      if (Relocation(tempHouse, i)) {
        tempValue = MaxValueAlphaBetaPruning(tempHouse, depthMax, depth + 2, alpha, beta, playerShop);
      } else {
        tempValue = MinValueAlphaBetaPruning(tempHouse, depthMax, depth + 1, alpha, beta, playerShop);
      }
      if (alpha < tempValue) {
        alpha = tempValue;
        action = i;
      }
      if (alpha >= beta) {
        break;
      }
    }
    if (depth === 0) {
      return action;
    } else {
      return alpha;
    }
  }
};

MinValueAlphaBetaPruning = function(house, depthMax, depth, alpha, beta, playerShop) {
  var i, j, len, opponentShop, ref, tempHouse, tempValue;
  if (HasSuccessors(house) === false) {
    FinalScoring(house);
    return Evaluate(house, playerShop, (playerShop + 7) % 14);
  } else if (depth >= depthMax) {
    return Evaluate(house, playerShop, (playerShop + 7) % 14);
  } else {
    opponentShop = (playerShop + 7) % 14;
    ref = range(opponentShop - 6, opponentShop);
    for (j = 0, len = ref.length; j < len; j++) {
      i = ref[j];
      if (house[i] === 0) {
        continue;
      }
      tempHouse = house.slice();
      tempValue = null;
      if (Relocation(tempHouse, i)) {
        tempValue = MinValueAlphaBetaPruning(tempHouse, depthMax, depth + 2, alpha, beta, playerShop);
      } else {
        tempValue = MaxValueAlphaBetaPruning(tempHouse, depthMax, depth + 1, alpha, beta, playerShop);
      }
      if (beta > tempValue) {
        beta = tempValue;
      }
      if (alpha >= beta) {
        break;
      }
    }
    return beta;
  }
};

//# sourceMappingURL=data:application/json;base64,eyJ2ZXJzaW9uIjozLCJmaWxlIjoibWluTWF4QWxwaGFCZXRhUHVybmluZy5qcyIsInNvdXJjZVJvb3QiOiIuLiIsInNvdXJjZXMiOlsiY29mZmVlXFxtaW5NYXhBbHBoYUJldGFQdXJuaW5nLmNvZmZlZSJdLCJuYW1lcyI6W10sIm1hcHBpbmdzIjoiO0FBQUEsSUFBQSx3QkFBQSxFQUFBLDhCQUFBLEVBQUE7O0FBQUEsOEJBQUEsR0FBaUMsUUFBQSxDQUFDLFFBQUQsRUFBVyxNQUFYLENBQUE7QUFDaEMsTUFBQSxLQUFBLEVBQUEsSUFBQSxFQUFBLEtBQUEsRUFBQTtFQUFBLEtBQUEsR0FBUSxDQUFDO0VBQ1QsSUFBQSxHQUFPO0VBQ1AsS0FBQSxHQUFRLE9BQU8sQ0FBQyxHQUFSLENBQVksUUFBQSxDQUFDLE1BQUQsQ0FBQTtXQUFZLE1BQU0sQ0FBQztFQUFuQixDQUFaO0VBQ1IsVUFBQSxHQUFhO0VBQ2IsSUFBRyxNQUFBLEtBQVUsQ0FBYjtJQUFvQixVQUFBLEdBQWEsR0FBakM7O1NBQ0Esd0JBQUEsQ0FBeUIsS0FBekIsRUFBZ0MsUUFBaEMsRUFBMEMsQ0FBMUMsRUFBNkMsS0FBN0MsRUFBb0QsSUFBcEQsRUFBMEQsVUFBMUQ7QUFOZ0M7O0FBUWpDLHdCQUFBLEdBQTJCLFFBQUEsQ0FBQyxLQUFELEVBQVEsUUFBUixFQUFrQixLQUFsQixFQUF5QixLQUF6QixFQUFnQyxJQUFoQyxFQUFzQyxVQUF0QyxDQUFBO0FBQzFCLE1BQUEsTUFBQSxFQUFBLENBQUEsRUFBQSxDQUFBLEVBQUEsR0FBQSxFQUFBLEdBQUEsRUFBQSxTQUFBLEVBQUE7RUFBQSxJQUFHLGFBQUEsQ0FBYyxLQUFkLENBQUEsS0FBd0IsS0FBM0I7SUFDQyxZQUFBLENBQWEsS0FBYjtBQUNBLFdBQU8sUUFBQSxDQUFTLEtBQVQsRUFBZ0IsVUFBaEIsRUFBNEIsQ0FBQyxVQUFBLEdBQWEsQ0FBZCxDQUFBLEdBQW1CLEVBQS9DLEVBRlI7R0FBQSxNQUdLLElBQUcsS0FBQSxJQUFTLFFBQVo7QUFDSixXQUFPLFFBQUEsQ0FBUyxLQUFULEVBQWdCLFVBQWhCLEVBQTRCLENBQUMsVUFBQSxHQUFhLENBQWQsQ0FBQSxHQUFtQixFQUEvQyxFQURIO0dBQUEsTUFBQTtJQUdKLE1BQUEsR0FBUztBQUNUO0lBQUEsS0FBQSxxQ0FBQTs7TUFDQyxJQUFHLEtBQU0sQ0FBQSxDQUFBLENBQU4sS0FBWSxDQUFmO0FBQXNCLGlCQUF0Qjs7TUFFQSxTQUFBLEdBQVksS0FBSyxDQUFDLEtBQU4sQ0FBQTtNQUNaLFNBQUEsR0FBWTtNQUVaLElBQUcsVUFBQSxDQUFXLFNBQVgsRUFBc0IsQ0FBdEIsQ0FBSDtRQUNDLFNBQUEsR0FBWSx3QkFBQSxDQUF5QixTQUF6QixFQUFvQyxRQUFwQyxFQUE4QyxLQUFBLEdBQVEsQ0FBdEQsRUFBeUQsS0FBekQsRUFBZ0UsSUFBaEUsRUFBc0UsVUFBdEUsRUFEYjtPQUFBLE1BQUE7UUFHQyxTQUFBLEdBQVksd0JBQUEsQ0FBeUIsU0FBekIsRUFBb0MsUUFBcEMsRUFBOEMsS0FBQSxHQUFRLENBQXRELEVBQXlELEtBQXpELEVBQWdFLElBQWhFLEVBQXNFLFVBQXRFLEVBSGI7O01BS0EsSUFBRyxLQUFBLEdBQVEsU0FBWDtRQUNDLEtBQUEsR0FBUTtRQUNSLE1BQUEsR0FBUyxFQUZWOztNQUlBLElBQUcsS0FBQSxJQUFTLElBQVo7QUFBc0IsY0FBdEI7O0lBZkQ7SUFpQk8sSUFBRyxLQUFBLEtBQVMsQ0FBWjthQUFtQixPQUFuQjtLQUFBLE1BQUE7YUFBK0IsTUFBL0I7S0FyQkg7O0FBSnFCOztBQTJCM0Isd0JBQUEsR0FBMkIsUUFBQSxDQUFDLEtBQUQsRUFBUSxRQUFSLEVBQWtCLEtBQWxCLEVBQXlCLEtBQXpCLEVBQWdDLElBQWhDLEVBQXNDLFVBQXRDLENBQUE7QUFDMUIsTUFBQSxDQUFBLEVBQUEsQ0FBQSxFQUFBLEdBQUEsRUFBQSxZQUFBLEVBQUEsR0FBQSxFQUFBLFNBQUEsRUFBQTtFQUFBLElBQUcsYUFBQSxDQUFjLEtBQWQsQ0FBQSxLQUF3QixLQUEzQjtJQUNDLFlBQUEsQ0FBYSxLQUFiO0FBQ0EsV0FBTyxRQUFBLENBQVMsS0FBVCxFQUFnQixVQUFoQixFQUE0QixDQUFDLFVBQUEsR0FBYSxDQUFkLENBQUEsR0FBbUIsRUFBL0MsRUFGUjtHQUFBLE1BR0ssSUFBRyxLQUFBLElBQVMsUUFBWjtBQUNKLFdBQU8sUUFBQSxDQUFTLEtBQVQsRUFBZ0IsVUFBaEIsRUFBNEIsQ0FBQyxVQUFBLEdBQWEsQ0FBZCxDQUFBLEdBQW1CLEVBQS9DLEVBREg7R0FBQSxNQUFBO0lBR0osWUFBQSxHQUFlLENBQUMsVUFBQSxHQUFhLENBQWQsQ0FBQSxHQUFtQjtBQUNsQztJQUFBLEtBQUEscUNBQUE7O01BQ0MsSUFBRyxLQUFNLENBQUEsQ0FBQSxDQUFOLEtBQVksQ0FBZjtBQUFzQixpQkFBdEI7O01BRUEsU0FBQSxHQUFZLEtBQUssQ0FBQyxLQUFOLENBQUE7TUFDWixTQUFBLEdBQVk7TUFFWixJQUFHLFVBQUEsQ0FBVyxTQUFYLEVBQXNCLENBQXRCLENBQUg7UUFDQyxTQUFBLEdBQVksd0JBQUEsQ0FBeUIsU0FBekIsRUFBb0MsUUFBcEMsRUFBOEMsS0FBQSxHQUFRLENBQXRELEVBQXlELEtBQXpELEVBQWdFLElBQWhFLEVBQXNFLFVBQXRFLEVBRGI7T0FBQSxNQUFBO1FBR0MsU0FBQSxHQUFZLHdCQUFBLENBQXlCLFNBQXpCLEVBQW9DLFFBQXBDLEVBQThDLEtBQUEsR0FBUSxDQUF0RCxFQUF5RCxLQUF6RCxFQUFnRSxJQUFoRSxFQUFzRSxVQUF0RSxFQUhiOztNQUtBLElBQUcsSUFBQSxHQUFPLFNBQVY7UUFBeUIsSUFBQSxHQUFPLFVBQWhDOztNQUVBLElBQUcsS0FBQSxJQUFTLElBQVo7QUFBc0IsY0FBdEI7O0lBYkQ7QUFjQSxXQUFPLEtBbEJIOztBQUpxQiIsInNvdXJjZXNDb250ZW50IjpbIk1pbk1heERlY2lzaW9uQWxwaGFCZXRhUHJ1bmluZyA9IChkZXB0aE1heCwgcGxheWVyKSAtPlxyXG5cdGFscGhhID0gLTEwMDBcclxuXHRiZXRhID0gMTAwMFxyXG5cdGhvdXNlID0gYnV0dG9ucy5tYXAgKGJ1dHRvbikgLT4gYnV0dG9uLnZhbHVlXHJcblx0cGxheWVyU2hvcCA9IDZcclxuXHRpZiBwbGF5ZXIgPT0gMSB0aGVuIHBsYXllclNob3AgPSAxM1xyXG5cdE1heFZhbHVlQWxwaGFCZXRhUHJ1bmluZyhob3VzZSwgZGVwdGhNYXgsIDAsIGFscGhhLCBiZXRhLCBwbGF5ZXJTaG9wKVxyXG5cclxuTWF4VmFsdWVBbHBoYUJldGFQcnVuaW5nID0gKGhvdXNlLCBkZXB0aE1heCwgZGVwdGgsIGFscGhhLCBiZXRhLCBwbGF5ZXJTaG9wKSAtPlxyXG5cdGlmIEhhc1N1Y2Nlc3NvcnMoaG91c2UpID09IGZhbHNlXHJcblx0XHRGaW5hbFNjb3JpbmcoaG91c2UpXHJcblx0XHRyZXR1cm4gRXZhbHVhdGUoaG91c2UsIHBsYXllclNob3AsIChwbGF5ZXJTaG9wICsgNykgJSAxNClcclxuXHRlbHNlIGlmIGRlcHRoID49IGRlcHRoTWF4XHJcblx0XHRyZXR1cm4gRXZhbHVhdGUoaG91c2UsIHBsYXllclNob3AsIChwbGF5ZXJTaG9wICsgNykgJSAxNClcclxuXHRlbHNlXHJcblx0XHRhY3Rpb24gPSBudWxsXHJcblx0XHRmb3IgaSBpbiByYW5nZSBwbGF5ZXJTaG9wIC0gNiwgcGxheWVyU2hvcFxyXG5cdFx0XHRpZiBob3VzZVtpXSA9PSAwIHRoZW4gY29udGludWVcclxuXHJcblx0XHRcdHRlbXBIb3VzZSA9IGhvdXNlLnNsaWNlKClcclxuXHRcdFx0dGVtcFZhbHVlID0gbnVsbFxyXG5cclxuXHRcdFx0aWYgUmVsb2NhdGlvbih0ZW1wSG91c2UsIGkpXHJcblx0XHRcdFx0dGVtcFZhbHVlID0gTWF4VmFsdWVBbHBoYUJldGFQcnVuaW5nKHRlbXBIb3VzZSwgZGVwdGhNYXgsIGRlcHRoICsgMiwgYWxwaGEsIGJldGEsIHBsYXllclNob3ApXHJcblx0XHRcdGVsc2VcclxuXHRcdFx0XHR0ZW1wVmFsdWUgPSBNaW5WYWx1ZUFscGhhQmV0YVBydW5pbmcodGVtcEhvdXNlLCBkZXB0aE1heCwgZGVwdGggKyAxLCBhbHBoYSwgYmV0YSwgcGxheWVyU2hvcClcclxuXHJcblx0XHRcdGlmIGFscGhhIDwgdGVtcFZhbHVlXHJcblx0XHRcdFx0YWxwaGEgPSB0ZW1wVmFsdWVcclxuXHRcdFx0XHRhY3Rpb24gPSBpXHJcblxyXG5cdFx0XHRpZiBhbHBoYSA+PSBiZXRhIHRoZW4gYnJlYWtcclxuXHJcblx0XHRyZXR1cm4gaWYgZGVwdGggPT0gMCB0aGVuIGFjdGlvbiBlbHNlIGFscGhhXHJcblxyXG5NaW5WYWx1ZUFscGhhQmV0YVBydW5pbmcgPSAoaG91c2UsIGRlcHRoTWF4LCBkZXB0aCwgYWxwaGEsIGJldGEsIHBsYXllclNob3ApIC0+XHJcblx0aWYgSGFzU3VjY2Vzc29ycyhob3VzZSkgPT0gZmFsc2VcclxuXHRcdEZpbmFsU2NvcmluZyhob3VzZSlcclxuXHRcdHJldHVybiBFdmFsdWF0ZShob3VzZSwgcGxheWVyU2hvcCwgKHBsYXllclNob3AgKyA3KSAlIDE0KVxyXG5cdGVsc2UgaWYgZGVwdGggPj0gZGVwdGhNYXhcclxuXHRcdHJldHVybiBFdmFsdWF0ZShob3VzZSwgcGxheWVyU2hvcCwgKHBsYXllclNob3AgKyA3KSAlIDE0KVxyXG5cdGVsc2UgXHJcblx0XHRvcHBvbmVudFNob3AgPSAocGxheWVyU2hvcCArIDcpICUgMTRcclxuXHRcdGZvciBpIGluIHJhbmdlIG9wcG9uZW50U2hvcCAtIDYsIG9wcG9uZW50U2hvcFxyXG5cdFx0XHRpZiBob3VzZVtpXSA9PSAwIHRoZW4gY29udGludWVcclxuXHJcblx0XHRcdHRlbXBIb3VzZSA9IGhvdXNlLnNsaWNlKClcclxuXHRcdFx0dGVtcFZhbHVlID0gbnVsbFxyXG5cdFx0XHRcclxuXHRcdFx0aWYgUmVsb2NhdGlvbih0ZW1wSG91c2UsIGkpXHJcblx0XHRcdFx0dGVtcFZhbHVlID0gTWluVmFsdWVBbHBoYUJldGFQcnVuaW5nKHRlbXBIb3VzZSwgZGVwdGhNYXgsIGRlcHRoICsgMiwgYWxwaGEsIGJldGEsIHBsYXllclNob3ApXHJcblx0XHRcdGVsc2VcclxuXHRcdFx0XHR0ZW1wVmFsdWUgPSBNYXhWYWx1ZUFscGhhQmV0YVBydW5pbmcodGVtcEhvdXNlLCBkZXB0aE1heCwgZGVwdGggKyAxLCBhbHBoYSwgYmV0YSwgcGxheWVyU2hvcClcclxuXHJcblx0XHRcdGlmIGJldGEgPiB0ZW1wVmFsdWUgdGhlbiBiZXRhID0gdGVtcFZhbHVlXHJcblxyXG5cdFx0XHRpZiBhbHBoYSA+PSBiZXRhIHRoZW4gYnJlYWtcclxuXHRcdHJldHVybiBiZXRhXHJcbiJdfQ==
//# sourceURL=c:\Lab\2019\118-Kalaha\coffee\minMaxAlphaBetaPurning.coffee