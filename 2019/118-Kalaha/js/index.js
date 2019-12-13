// Generated by CoffeeScript 2.4.1
var ActiveComputerHouse, Button, Evaluate, FinalScoring, HasSuccessors, HouseButtonActive, HouseOnClick, Relocation, beans, buttons, depth, keyPressed, messages, mousePressed, player, playerComputer, playerTitle, reset, setup, xdraw;

playerTitle = ['Human', 'Computer'];

playerComputer = [false, true];

player = 0; // 0 or 1

beans = 3;

depth = 1;

buttons = [];

messages = '1 0'.split(' ');

Button = class Button {
  constructor(x1, y1, value, click = function() {}) {
    this.x = x1;
    this.y = y1;
    this.value = value;
    this.click = click;
    this.radie = 20;
  }

  draw() {
    circle(this.x, this.y, this.radie);
    textAlign(CENTER, CENTER);
    if (this.value > 0) {
      return text(this.value, this.x, this.y);
    }
  }

  inside(x, y) {
    return this.radie > dist(x, y, this.x, this.y);
  }

};

setup = function() {
  var i, j, k, len, len1, ref, ref1;
  createCanvas(450, 150);
  textAlign(CENTER, CENTER);
  textSize(20);
  ref = range(6);
  for (j = 0, len = ref.length; j < len; j++) {
    i = ref[j];
    (function(i) {
      return buttons.push(new Button(100 + 50 * i, 100, beans, function() {
        return HouseOnClick(i);
      }));
    })(i);
  }
  buttons.push(new Button(400, 75, 0));
  ref1 = range(7, 13);
  for (k = 0, len1 = ref1.length; k < len1; k++) {
    i = ref1[k];
    buttons.push(new Button(100 + 50 * (12 - i), 50, beans));
  }
  buttons.push(new Button(50, 75, 0));
  return reset(beans);
};

xdraw = function() {
  var button, j, len;
  bg(0.5);
  for (j = 0, len = buttons.length; j < len; j++) {
    button = buttons[j];
    button.draw();
  }
  textAlign(CENTER, CENTER);
  text(messages[0], 20, 20);
  text(messages[1] + 'ms', width - 40, 130);
  textAlign(LEFT, CENTER);
  return text(messages[2], 20, 130);
};

mousePressed = function() {
  var button, j, len, results;
  results = [];
  for (j = 0, len = buttons.length; j < len; j++) {
    button = buttons[j];
    if (button.inside(mouseX, mouseY)) {
      results.push(button.click());
    } else {
      results.push(void 0);
    }
  }
  return results;
};

reset = function(b) {
  var button, j, len;
  if (b > 0) {
    beans = b;
  }
  for (j = 0, len = buttons.length; j < len; j++) {
    button = buttons[j];
    button.value = beans;
  }
  buttons[6].value = 0;
  buttons[13].value = 0;
  if (depth < 1) {
    depth = 1;
  }
  messages[0] = depth;
  messages[1] = 0;
  messages[2] = '';
  return xdraw();
};

keyPressed = function() {
  var index;
  if (messages[2] === '') {
    return;
  }
  index = " 1234567890".indexOf(key);
  if (index >= 0) {
    return reset(index);
  }
};

ActiveComputerHouse = function() {
  return HouseOnClick(MinMaxDecisionAlphaBetaPruning(depth, player)); // MinMaxDecisionNormal depth, player
};

HouseButtonActive = function() {
  if (playerComputer[player]) {
    return ActiveComputerHouse();
  }
};

HouseOnClick = function(pickedHouse) {
  var again, house, i, j, k, len, len1, ref, ref1, start;
  if (buttons[pickedHouse].value === 0) {
    return;
  }
  start = new Date();
  house = buttons.map(function(button) {
    return button.value;
  });
  again = Relocation(house, pickedHouse);
  ref = range(14);
  for (j = 0, len = ref.length; j < len; j++) {
    i = ref[j];
    buttons[i].value = house[i];
  }
  if (again === false) {
    player = 1 - player;
  }
  if (HasSuccessors(house)) {
    HouseButtonActive();
  } else {
    FinalScoring(house);
    ref1 = range(14);
    for (k = 0, len1 = ref1.length; k < len1; k++) {
      i = ref1[k];
      buttons[i].value = house[i];
    }
    if (house[13] > house[6]) {
      messages[2] = playerTitle[1] + " Win";
      depth--;
    } else if (house[13] === house[6]) {
      messages[2](" Tie");
    } else {
      messages[2] = playerTitle[0] + " Win";
      depth++;
    }
  }
  messages[1] = new Date() - start;
  return xdraw();
};

Relocation = function(house, pickedHouse) {
  var index, opponentShop, playerShop;
  playerShop = 6;
  opponentShop = 13;
  if (pickedHouse > 6) {
    playerShop = 13;
    opponentShop = 6;
  }
  index = pickedHouse;
  while (house[pickedHouse] > 0) {
    index = (index + 1) % 14;
    if (index === opponentShop) {
      continue;
    }
    house[index]++;
    house[pickedHouse]--;
  }
  if (index === playerShop) {
    return true;
  }
  if (house[index] === 1 && house[12 - index] !== 0 && index >= (playerShop - 6) && index < playerShop) {
    house[playerShop] += house[12 - index];
    house[playerShop]++;
    house[index] = 0;
    house[12 - index] = 0;
  }
  return false;
};

FinalScoring = function(house) {
  var i, j, len, ref, results;
  ref = range(6);
  results = [];
  for (j = 0, len = ref.length; j < len; j++) {
    i = ref[j];
    house[6] += house[i];
    house[13] += house[7 + i];
    results.push(house[i] = house[7 + i] = 0);
  }
  return results;
};

Evaluate = function(house, player1, player2) {
  return house[player1] - house[player2];
};

HasSuccessors = function(house) {
  var i, j, len, player1, player2, ref;
  player1 = false;
  player2 = false;
  ref = range(6);
  for (j = 0, len = ref.length; j < len; j++) {
    i = ref[j];
    if (house[i] !== 0) {
      player1 = true;
    }
    if (house[7 + i] !== 0) {
      player2 = true;
    }
  }
  return player1 && player2;
};

//# sourceMappingURL=data:application/json;base64,eyJ2ZXJzaW9uIjozLCJmaWxlIjoiaW5kZXguanMiLCJzb3VyY2VSb290IjoiLi4iLCJzb3VyY2VzIjpbImNvZmZlZVxcaW5kZXguY29mZmVlIl0sIm5hbWVzIjpbXSwibWFwcGluZ3MiOiI7QUFBQSxJQUFBLG1CQUFBLEVBQUEsTUFBQSxFQUFBLFFBQUEsRUFBQSxZQUFBLEVBQUEsYUFBQSxFQUFBLGlCQUFBLEVBQUEsWUFBQSxFQUFBLFVBQUEsRUFBQSxLQUFBLEVBQUEsT0FBQSxFQUFBLEtBQUEsRUFBQSxVQUFBLEVBQUEsUUFBQSxFQUFBLFlBQUEsRUFBQSxNQUFBLEVBQUEsY0FBQSxFQUFBLFdBQUEsRUFBQSxLQUFBLEVBQUEsS0FBQSxFQUFBOztBQUFBLFdBQUEsR0FBYyxDQUFDLE9BQUQsRUFBUyxVQUFUOztBQUNkLGNBQUEsR0FBaUIsQ0FBQyxLQUFELEVBQU8sSUFBUDs7QUFDakIsTUFBQSxHQUFTLEVBRlQ7O0FBR0EsS0FBQSxHQUFROztBQUNSLEtBQUEsR0FBUTs7QUFDUixPQUFBLEdBQVU7O0FBQ1YsUUFBQSxHQUFXLEtBQUssQ0FBQyxLQUFOLENBQVksR0FBWjs7QUFFTCxTQUFOLE1BQUEsT0FBQTtFQUNDLFdBQWMsR0FBQSxJQUFBLE9BQUEsVUFBcUIsUUFBQSxDQUFBLENBQUEsRUFBQSxDQUFyQixDQUFBO0lBQUMsSUFBQyxDQUFBO0lBQUUsSUFBQyxDQUFBO0lBQUUsSUFBQyxDQUFBO0lBQU0sSUFBQyxDQUFBO0lBQWEsSUFBQyxDQUFBLEtBQUQsR0FBTztFQUFuQzs7RUFDZCxJQUFPLENBQUEsQ0FBQTtJQUNOLE1BQUEsQ0FBTyxJQUFDLENBQUEsQ0FBUixFQUFVLElBQUMsQ0FBQSxDQUFYLEVBQWEsSUFBQyxDQUFBLEtBQWQ7SUFDQSxTQUFBLENBQVUsTUFBVixFQUFpQixNQUFqQjtJQUNBLElBQUcsSUFBQyxDQUFBLEtBQUQsR0FBUyxDQUFaO2FBQW1CLElBQUEsQ0FBSyxJQUFDLENBQUEsS0FBTixFQUFZLElBQUMsQ0FBQSxDQUFiLEVBQWUsSUFBQyxDQUFBLENBQWhCLEVB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QUFDZixNQUFBLENBQUEsRUFBQSxDQUFBLEVBQUEsR0FBQSxFQUFBLE9BQUEsRUFBQSxPQUFBLEVBQUE7RUFBQSxPQUFBLEdBQVU7RUFDVixPQUFBLEdBQVU7QUFDVjtFQUFBLEtBQUEscUNBQUE7O0lBQ0MsSUFBRyxLQUFNLENBQUEsQ0FBQSxDQUFOLEtBQVksQ0FBZjtNQUFzQixPQUFBLEdBQVUsS0FBaEM7O0lBQ0EsSUFBRyxLQUFNLENBQUEsQ0FBQSxHQUFJLENBQUosQ0FBTixLQUFnQixDQUFuQjtNQUEwQixPQUFBLEdBQVUsS0FBcEM7O0VBRkQ7U0FHQSxPQUFBLElBQVk7QUFORyIsInNvdXJjZXNDb250ZW50IjpbInBsYXllclRpdGxlID0gWydIdW1hbicsJ0NvbXB1dGVyJ11cclxucGxheWVyQ29tcHV0ZXIgPSBbZmFsc2UsdHJ1ZV1cclxucGxheWVyID0gMCAjIDAgb3IgMVxyXG5iZWFucyA9IDNcclxuZGVwdGggPSAxXHJcbmJ1dHRvbnMgPSBbXVxyXG5tZXNzYWdlcyA9ICcxIDAnLnNwbGl0ICcgJ1xyXG5cclxuY2xhc3MgQnV0dG9uXHJcblx0Y29uc3RydWN0b3IgOiAoQHgsQHksQHZhbHVlLEBjbGljaz0tPikgLT4gQHJhZGllPTIwXHJcblx0ZHJhdyA6IC0+XHJcblx0XHRjaXJjbGUgQHgsQHksQHJhZGllXHJcblx0XHR0ZXh0QWxpZ24gQ0VOVEVSLENFTlRFUlxyXG5cdFx0aWYgQHZhbHVlID4gMCB0aGVuIHRleHQgQHZhbHVlLEB4LEB5XHJcblx0aW5zaWRlIDogKHgseSkgLT4gQHJhZGllID4gZGlzdCB4LHksQHgsQHlcclxuXHJcbnNldHVwID0gLT5cclxuXHRjcmVhdGVDYW52YXMgNDUwLDE1MFxyXG5cdHRleHRBbGlnbiBDRU5URVIsQ0VOVEVSXHJcblx0dGV4dFNpemUgMjBcclxuXHRmb3IgaSBpbiByYW5nZSA2XHJcblx0XHRkbyAoaSkgLT5cclxuXHRcdFx0YnV0dG9ucy5wdXNoIG5ldyBCdXR0b24gMTAwKzUwKmksMTAwLGJlYW5zLCgpIC0+IEhvdXNlT25DbGljayBpXHJcblx0YnV0dG9ucy5wdXNoIG5ldyBCdXR0b24gNDAwLDc1LDBcclxuXHRmb3IgaSBpbiByYW5nZSA3LDEzXHJcblx0XHRidXR0b25zLnB1c2ggbmV3IEJ1dHRvbiAxMDArNTAqKDEyLWkpLDUwLGJlYW5zXHJcblx0YnV0dG9ucy5wdXNoIG5ldyBCdXR0b24gNTAsNzUsMFxyXG5cdHJlc2V0IGJlYW5zXHJcblxyXG54ZHJhdyA9IC0+XHJcblx0YmcgMC41XHJcblx0Zm9yIGJ1dHRvbiBpbiBidXR0b25zXHJcblx0XHRidXR0b24uZHJhdygpXHJcblx0dGV4dEFsaWduIENFTlRFUixDRU5URVJcclxuXHR0ZXh0IG1lc3NhZ2VzWzBdLDIwLDIwXHJcblx0dGV4dCBtZXNzYWdlc1sxXSsnbXMnLHdpZHRoLTQwLDEzMFxyXG5cdHRleHRBbGlnbiBMRUZULENFTlRFUlxyXG5cdHRleHQgbWVzc2FnZXNbMl0sMjAsMTMwXHJcblxyXG5tb3VzZVByZXNzZWQgPSAoKSAtPlxyXG5cdGZvciBidXR0b24gaW4gYnV0dG9uc1xyXG5cdFx0aWYgYnV0dG9uLmluc2lkZSBtb3VzZVgsbW91c2VZIHRoZW4gYnV0dG9uLmNsaWNrKClcclxuXHJcbnJlc2V0ID0gKGIpIC0+XHJcblx0aWYgYiA+IDAgdGhlblx0YmVhbnMgPSBiXHJcblx0Zm9yIGJ1dHRvbiBpbiBidXR0b25zXHJcblx0XHRidXR0b24udmFsdWUgPSBiZWFuc1xyXG5cdGJ1dHRvbnNbNl0udmFsdWUgPSAwXHJcblx0YnV0dG9uc1sxM10udmFsdWUgPSAwXHJcblx0aWYgZGVwdGggPCAxIHRoZW4gZGVwdGggPSAxXHJcblx0bWVzc2FnZXNbMF0gPSBkZXB0aFxyXG5cdG1lc3NhZ2VzWzFdID0gMFxyXG5cdG1lc3NhZ2VzWzJdID0gJydcclxuXHR4ZHJhdygpXHJcblxyXG5rZXlQcmVzc2VkID0gLT4gXHJcblx0aWYgbWVzc2FnZXNbMl09PScnIHRoZW4gcmV0dXJuIFxyXG5cdGluZGV4ID0gXCIgMTIzNDU2Nzg5MFwiLmluZGV4T2Yga2V5XHJcblx0aWYgaW5kZXggPj0gMCB0aGVuIHJlc2V0IGluZGV4XHJcblxyXG5BY3RpdmVDb21wdXRlckhvdXNlID0gKCkgLT4gSG91c2VPbkNsaWNrIE1pbk1heERlY2lzaW9uQWxwaGFCZXRhUHJ1bmluZyBkZXB0aCwgcGxheWVyICMgTWluTWF4RGVjaXNpb25Ob3JtYWwgZGVwdGgsIHBsYXllclxyXG5Ib3VzZUJ1dHRvbkFjdGl2ZSA9ICgpIC0+IGlmIHBsYXllckNvbXB1dGVyW3BsYXllcl0gdGhlbiBBY3RpdmVDb21wdXRlckhvdXNlKCkgXHJcblxyXG5Ib3VzZU9uQ2xpY2sgPSAocGlja2VkSG91c2UpIC0+XHJcblx0aWYgYnV0dG9uc1twaWNrZWRIb3VzZV0udmFsdWUgPT0gMCB0aGVuIHJldHVybiBcclxuXHRzdGFydCA9IG5ldyBEYXRlKClcclxuXHRob3VzZSA9IGJ1dHRvbnMubWFwIChidXR0b24pIC0+IGJ1dHRvbi52YWx1ZVxyXG5cdGFnYWluID0gUmVsb2NhdGlvbihob3VzZSwgcGlja2VkSG91c2UpXHJcblx0Zm9yIGkgaW4gcmFuZ2UgMTRcclxuXHRcdGJ1dHRvbnNbaV0udmFsdWUgPSBob3VzZVtpXVxyXG5cdGlmIGFnYWluID09IGZhbHNlIHRoZW4gcGxheWVyID0gMSAtIHBsYXllclxyXG5cdGlmIEhhc1N1Y2Nlc3NvcnMoaG91c2UpXHJcblx0XHRIb3VzZUJ1dHRvbkFjdGl2ZSgpXHJcblx0ZWxzZSBcclxuXHRcdEZpbmFsU2NvcmluZyhob3VzZSlcclxuXHRcdGZvciBpIGluIHJhbmdlIDE0XHJcblx0XHRcdGJ1dHRvbnNbaV0udmFsdWUgPSBob3VzZVtpXVxyXG5cclxuXHRcdGlmIGhvdXNlWzEzXSA+IGhvdXNlWzZdXHJcblx0XHRcdG1lc3NhZ2VzWzJdID0gcGxheWVyVGl0bGVbMV0gKyBcIiBXaW5cIlxyXG5cdFx0XHRkZXB0aC0tXHJcblx0XHRlbHNlIGlmIGhvdXNlWzEzXSA9PSBob3VzZVs2XVxyXG5cdFx0XHRtZXNzYWdlc1syXSBcIiBUaWVcIlxyXG5cdFx0ZWxzZVxyXG5cdFx0XHRtZXNzYWdlc1syXSA9IHBsYXllclRpdGxlWzBdICsgXCIgV2luXCJcclxuXHRcdFx0ZGVwdGgrK1xyXG5cdG1lc3NhZ2VzWzFdID0gbmV3IERhdGUoKSAtIHN0YXJ0XHJcblx0eGRyYXcoKVxyXG5cclxuUmVsb2NhdGlvbiA9IChob3VzZSwgcGlja2VkSG91c2UpIC0+XHJcblx0cGxheWVyU2hvcCA9IDZcclxuXHRvcHBvbmVudFNob3AgPSAxM1xyXG5cdGlmIHBpY2tlZEhvdXNlID4gNlxyXG5cdFx0cGxheWVyU2hvcCA9IDEzXHJcblx0XHRvcHBvbmVudFNob3AgPSA2XHJcblxyXG5cdGluZGV4ID0gcGlja2VkSG91c2VcclxuXHR3aGlsZSBob3VzZVtwaWNrZWRIb3VzZV0gPiAwIFxyXG5cdFx0aW5kZXggPSAoaW5kZXggKyAxKSAlIDE0XHJcblx0XHRpZiBpbmRleCA9PSBvcHBvbmVudFNob3AgdGhlbiBjb250aW51ZVxyXG5cdFx0aG91c2VbaW5kZXhdKytcclxuXHRcdGhvdXNlW3BpY2tlZEhvdXNlXS0tXHJcblxyXG5cdGlmIGluZGV4ID09IHBsYXllclNob3AgdGhlbiByZXR1cm4gdHJ1ZVxyXG5cclxuXHRpZiBob3VzZVtpbmRleF0gPT0gMSBhbmQgaG91c2VbMTIgLSBpbmRleF0gIT0gMCBhbmQgaW5kZXggPj0gKHBsYXllclNob3AgLSA2KSBhbmQgaW5kZXggPCBwbGF5ZXJTaG9wXHJcblx0XHRob3VzZVtwbGF5ZXJTaG9wXSArPSBob3VzZVsxMiAtIGluZGV4XVxyXG5cdFx0aG91c2VbcGxheWVyU2hvcF0rK1xyXG5cdFx0aG91c2VbaW5kZXhdID0gMFxyXG5cdFx0aG91c2VbMTIgLSBpbmRleF0gPSAwXHJcblx0ZmFsc2VcclxuXHJcbkZpbmFsU2NvcmluZyA9IChob3VzZSkgLT5cclxuXHRmb3IgaSBpbiByYW5nZSA2XHJcblx0XHRob3VzZVs2XSArPSBob3VzZVtpXVxyXG5cdFx0aG91c2VbMTNdICs9IGhvdXNlWzcgKyBpXVxyXG5cdFx0aG91c2VbaV0gPSBob3VzZVs3ICsgaV0gPSAwXHJcblxyXG5FdmFsdWF0ZSA9IChob3VzZSwgcGxheWVyMSwgcGxheWVyMikgLT4gaG91c2VbcGxheWVyMV0gLSBob3VzZVtwbGF5ZXIyXVxyXG5cclxuSGFzU3VjY2Vzc29ycyA9IChob3VzZSkgLT5cclxuXHRwbGF5ZXIxID0gZmFsc2VcclxuXHRwbGF5ZXIyID0gZmFsc2VcclxuXHRmb3IgaSBpbiByYW5nZSA2XHJcblx0XHRpZiBob3VzZVtpXSAhPSAwIHRoZW4gcGxheWVyMSA9IHRydWVcclxuXHRcdGlmIGhvdXNlWzcgKyBpXSAhPSAwIHRoZW4gcGxheWVyMiA9IHRydWVcclxuXHRwbGF5ZXIxIGFuZCBwbGF5ZXIyXHJcbiJdfQ==
//# sourceURL=c:\Lab\2019\118-Kalaha\coffee\index.coffee