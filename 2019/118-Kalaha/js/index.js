// Generated by CoffeeScript 2.4.1
var ActiveComputerHouse, Button, Evaluate, FinalScoring, HasSuccessors, HouseButtonActive, HouseOnClick, Relocation, beans, buttons, depth, keyPressed, messages, mousePressed, player, playerComputer, playerTitle, reset, setup, xdraw;

playerTitle = ['Human', 'Computer'];

playerComputer = [false, true];

player = 0; // 0 or 1

beans = 6;

depth = 1;

buttons = [];

messages = {};

messages.depth = depth;

messages.time = 0;

messages.result = '';

messages.letters = '';

messages.moves = 0;

Button = class Button {
  constructor(x1, y1, value, littera1 = '', click = function() {}) {
    this.x = x1;
    this.y = y1;
    this.value = value;
    this.littera = littera1;
    this.click = click;
    this.radie = 40;
  }

  draw() {
    fc(1, 0, 0);
    circle(this.x, this.y, this.radie);
    textAlign(CENTER, CENTER);
    if (this.value > 0) {
      fc(1);
      return text(this.value, this.x, this.y);
    } else {
      push();
      fc(0.8, 0, 0);
      text(this.littera, this.x, this.y);
      return pop();
    }
  }

  inside(x, y) {
    return this.radie > dist(x, y, this.x, this.y);
  }

};

setup = function() {
  var i, j, k, len, len1, littera, ref, ref1;
  createCanvas(2 * 450, 2 * 150);
  textAlign(CENTER, CENTER);
  textSize(40);
  ref = 'abcdef';
  for (i = j = 0, len = ref.length; j < len; i = ++j) {
    littera = ref[i];
    (function(i) {
      return buttons.push(new Button(2 * 100 + 2 * 50 * i, 2 * 100, beans, '', function() {
        return HouseOnClick(i);
      }));
    })(i);
  }
  buttons.push(new Button(2 * 400, 2 * 75, 0));
  ref1 = 'ABCDEF';
  for (i = k = 0, len1 = ref1.length; k < len1; i = ++k) {
    littera = ref1[i];
    buttons.push(new Button(2 * 100 + 2 * 50 * (5 - i), 2 * 50, beans, littera));
  }
  buttons.push(new Button(2 * 50, 2 * 75, 0));
  return reset(beans);
};

xdraw = function() {
  var button, j, len;
  bg(0);
  for (j = 0, len = buttons.length; j < len; j++) {
    button = buttons[j];
    button.draw();
  }
  fc(1, 1, 0);
  textAlign(LEFT, CENTER);
  text('Level: ' + messages.depth, 2 * 10, 2 * 20);
  textAlign(CENTER, CENTER);
  text(messages.result, width / 2, 2 * 135);
  text(messages.letters, width / 2, 2 * 20);
  textAlign(RIGHT, CENTER);
  text(messages.time + ' ms', width - 2 * 10, 2 * 20);
  return text(messages.moves, width - 2 * 10, 2 * 135);
};

mousePressed = function() {
  var button, j, len, results;
  if (messages.result !== '') {
    return reset(0);
  }
  messages.letters = '';
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
  messages.depth = depth;
  messages.time = 0;
  messages.result = '';
  messages.letters = '';
  messages.moves = 0;
  return xdraw();
};

keyPressed = function() {
  var index;
  if (messages.result === '') {
    return;
  }
  index = " 1234567890".indexOf(key);
  if (index >= 0) {
    return reset(index);
  }
};

ActiveComputerHouse = function() {
  var result, start;
  start = new Date();
  result = alphaBeta(depth, player);
  
  //result = minimax depth, player
  messages.time += new Date() - start;
  return HouseOnClick(result);
};

HouseButtonActive = function() {
  if (playerComputer[player]) {
    return ActiveComputerHouse();
  }
};

HouseOnClick = function(pickedHouse) {
  var again, house, i, j, k, len, len1, ref, ref1;
  messages.letters += 'abcdef ABCDEF'[pickedHouse];
  if (buttons[pickedHouse].value === 0) {
    return;
  }
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
    if (player === 1) {
      console.log(messages.letters);
      messages.moves++;
    }
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
      messages.result = playerTitle[1] + " Wins";
      depth--;
    } else if (house[13] === house[6]) {
      messages.result = "Tie";
    } else {
      messages.result = playerTitle[0] + " Wins";
      depth++;
    }
    console.log('');
  }
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
    house[playerShop] += house[12 - index] + 1;
    house[index] = house[12 - index] = 0;
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

//# sourceMappingURL=data:application/json;base64,eyJ2ZXJzaW9uIjozLCJmaWxlIjoiaW5kZXguanMiLCJzb3VyY2VSb290IjoiLi4iLCJzb3VyY2VzIjpbImNvZmZlZVxcaW5kZXguY29mZmVlIl0sIm5hbWVzIjpbXSwibWFwcGluZ3MiOiI7QUFBQSxJQUFBLG1CQUFBLEVBQUEsTUFBQSxFQUFBLFFBQUEsRUFBQSxZQUFBLEVBQUEsYUFBQSxFQUFBLGlCQUFBLEVBQUEsWUFBQSxFQUFBLFVBQUEsRUFBQSxLQUFBLEVBQUEsT0FBQSxFQUFBLEtBQUEsRUFBQSxVQUFBLEVBQUEsUUFBQSxFQUFBLFlBQUEsRUFBQSxNQUFBLEVBQUEsY0FBQSxFQUFBLFdBQUEsRUFBQSxLQUFBLEVBQUEsS0FBQSxFQUFBOztBQUFBLFdBQUEsR0FBYyxDQUFDLE9BQUQsRUFBUyxVQUFUOztBQUNkLGNBQUEsR0FBaUIsQ0FBQyxLQUFELEVBQU8sSUFBUDs7QUFDakIsTUFBQSxHQUFTLEVBRlQ7O0FBR0EsS0FBQSxHQUFROztBQUNSLEtBQUEsR0FBUTs7QUFDUixPQUFBLEdBQVU7O0FBRVYsUUFBQSxHQUFXLENBQUE7O0FBQ1gsUUFBUSxDQUFDLEtBQVQsR0FBaUI7O0FBQ2pCLFFBQVEsQ0FBQyxJQUFULEdBQWdCOztBQUNoQixRQUFRLENBQUMsTUFBVCxHQUFrQjs7QUFDbEIsUUFBUSxDQUFDLE9BQVQsR0FBbUI7O0FBQ25CLFFBQVEsQ0FBQyxLQUFULEdBQWlCOztBQUVYLFNBQU4sTUFBQSxPQUFBO0VBQ0MsV0FBYyxHQUFBLElBQUEsT0FBQSxhQUF1QixFQUF2QixVQUFpQyxRQUFBLENBQUEsQ0FBQSxFQUFBLENBQWpDLENBQUE7SUFBQyxJQUFDLENBQUE7SUFBRSxJQUFDLENBQUE7SUFBRSxJQUFDLENBQUE7SUFBTSxJQUFDLENBQUE7SUFBVyxJQUFDLENBQUE7SUFBYSxJQUFDLENBQUEsS0FBRCxHQUFPO0VBQS9DOztFQUNkLElBQU8sQ0FBQSxDQUFBO0lBQ04sRUFBQSxDQUFHLENBQUgsRUFBSyxDQUFMLEVBQU8sQ0FBUDtJQUNBLE1BQUEsQ0FBTyxJQUFDLENBQUEs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Q0FBQSxDQUFBLEdBQUksQ0FBSixDQUFOLEdBQWU7RUFIM0IsQ0FBQTs7QUFEYzs7QUFNZixRQUFBLEdBQVcsUUFBQSxDQUFDLEtBQUQsRUFBUSxPQUFSLEVBQWlCLE9BQWpCLENBQUE7U0FBNkIsS0FBTSxDQUFBLE9BQUEsQ0FBTixHQUFpQixLQUFNLENBQUEsT0FBQTtBQUFwRDs7QUFFWCxhQUFBLEdBQWdCLFFBQUEsQ0FBQyxLQUFELENBQUE7QUFDZixNQUFBLENBQUEsRUFBQSxDQUFBLEVBQUEsR0FBQSxFQUFBLE9BQUEsRUFBQSxPQUFBLEVBQUE7RUFBQSxPQUFBLEdBQVU7RUFDVixPQUFBLEdBQVU7QUFDVjtFQUFBLEtBQUEscUNBQUE7O0lBQ0MsSUFBRyxLQUFNLENBQUEsQ0FBQSxDQUFOLEtBQVksQ0FBZjtNQUFzQixPQUFBLEdBQVUsS0FBaEM7O0lBQ0EsSUFBRyxLQUFNLENBQUEsQ0FBQSxHQUFJLENBQUosQ0FBTixLQUFnQixDQUFuQjtNQUEwQixPQUFBLEdBQVUsS0FBcEM7O0VBRkQ7U0FHQSxPQUFBLElBQVk7QUFORyIsInNvdXJjZXNDb250ZW50IjpbInBsYXllclRpdGxlID0gWydIdW1hbicsJ0NvbXB1dGVyJ11cclxucGxheWVyQ29tcHV0ZXIgPSBbZmFsc2UsdHJ1ZV1cclxucGxheWVyID0gMCAjIDAgb3IgMVxyXG5iZWFucyA9IDZcclxuZGVwdGggPSAxXHJcbmJ1dHRvbnMgPSBbXVxyXG5cclxubWVzc2FnZXMgPSB7fVxyXG5tZXNzYWdlcy5kZXB0aCA9IGRlcHRoXHJcbm1lc3NhZ2VzLnRpbWUgPSAwXHJcbm1lc3NhZ2VzLnJlc3VsdCA9ICcnXHJcbm1lc3NhZ2VzLmxldHRlcnMgPSAnJ1xyXG5tZXNzYWdlcy5tb3ZlcyA9IDBcclxuXHJcbmNsYXNzIEJ1dHRvblxyXG5cdGNvbnN0cnVjdG9yIDogKEB4LEB5LEB2YWx1ZSxAbGl0dGVyYT0nJyxAY2xpY2s9LT4pIC0+IEByYWRpZT00MFxyXG5cdGRyYXcgOiAtPlxyXG5cdFx0ZmMgMSwwLDBcclxuXHRcdGNpcmNsZSBAeCxAeSxAcmFkaWVcclxuXHRcdHRleHRBbGlnbiBDRU5URVIsQ0VOVEVSXHJcblx0XHRpZiBAdmFsdWUgPiAwIFxyXG5cdFx0XHRmYyAxXHJcblx0XHRcdHRleHQgQHZhbHVlLEB4LEB5XHJcblx0XHRlbHNlXHJcblx0XHRcdHB1c2goKVxyXG5cdFx0XHRmYyAwLjgsMCwwXHJcblx0XHRcdHRleHQgQGxpdHRlcmEsQHgsQHlcclxuXHRcdFx0cG9wKClcclxuXHRpbnNpZGUgOiAoeCx5KSAtPiBAcmFkaWUgPiBkaXN0IHgseSxAeCxAeVxyXG5cclxuc2V0dXAgPSAtPlxyXG5cdGNyZWF0ZUNhbnZhcyAyKjQ1MCwyKjE1MFxyXG5cdHRleHRBbGlnbiBDRU5URVIsQ0VOVEVSXHJcblx0dGV4dFNpemUgNDBcclxuXHRmb3IgbGl0dGVyYSxpIGluICdhYmNkZWYnXHJcblx0XHRkbyAoaSkgLT5cclxuXHRcdFx0YnV0dG9ucy5wdXNoIG5ldyBCdXR0b24gMioxMDArMio1MCppLDIqMTAwLGJlYW5zLCcnLCgpIC0+IEhvdXNlT25DbGljayBpXHJcblx0YnV0dG9ucy5wdXNoIG5ldyBCdXR0b24gMio0MDAsMio3NSwwXHJcblx0Zm9yIGxpdHRlcmEsaSBpbiAnQUJDREVGJ1xyXG5cdFx0YnV0dG9ucy5wdXNoIG5ldyBCdXR0b24gMioxMDArMio1MCooNS1pKSwyKjUwLGJlYW5zLGxpdHRlcmFcclxuXHRidXR0b25zLnB1c2ggbmV3IEJ1dHRvbiAyKjUwLDIqNzUsMFxyXG5cdHJlc2V0IGJlYW5zXHJcblxyXG54ZHJhdyA9IC0+XHJcblx0YmcgMFxyXG5cdGZvciBidXR0b24gaW4gYnV0dG9uc1xyXG5cdFx0YnV0dG9uLmRyYXcoKVxyXG5cdGZjIDEsMSwwXHJcblx0dGV4dEFsaWduIExFRlQsQ0VOVEVSXHJcblx0dGV4dCAnTGV2ZWw6ICcrbWVzc2FnZXMuZGVwdGgsMioxMCwyKjIwXHJcblx0dGV4dEFsaWduIENFTlRFUixDRU5URVJcclxuXHR0ZXh0IG1lc3NhZ2VzLnJlc3VsdCx3aWR0aC8yLDIqMTM1XHJcblx0dGV4dCBtZXNzYWdlcy5sZXR0ZXJzLHdpZHRoLzIsMioyMFxyXG5cdHRleHRBbGlnbiBSSUdIVCxDRU5URVJcclxuXHR0ZXh0IG1lc3NhZ2VzLnRpbWUrJyBtcycsd2lkdGgtMioxMCwyKjIwXHJcblx0dGV4dCBtZXNzYWdlcy5tb3Zlcyx3aWR0aC0yKjEwLDIqMTM1XHJcblxyXG5tb3VzZVByZXNzZWQgPSAoKSAtPlxyXG5cdGlmIG1lc3NhZ2VzLnJlc3VsdCAhPSAnJyB0aGVuIHJldHVybiByZXNldCAwXHJcblx0bWVzc2FnZXMubGV0dGVycyA9ICcnXHJcblx0Zm9yIGJ1dHRvbiBpbiBidXR0b25zXHJcblx0XHRpZiBidXR0b24uaW5zaWRlIG1vdXNlWCxtb3VzZVkgdGhlbiBidXR0b24uY2xpY2soKVxyXG5cclxucmVzZXQgPSAoYikgLT5cclxuXHRpZiBiID4gMCB0aGVuXHRiZWFucyA9IGJcclxuXHRmb3IgYnV0dG9uIGluIGJ1dHRvbnNcclxuXHRcdGJ1dHRvbi52YWx1ZSA9IGJlYW5zXHJcblx0YnV0dG9uc1s2XS52YWx1ZSA9IDBcclxuXHRidXR0b25zWzEzXS52YWx1ZSA9IDBcclxuXHRpZiBkZXB0aCA8IDEgdGhlbiBkZXB0aCA9IDFcclxuXHRtZXNzYWdlcy5kZXB0aCA9IGRlcHRoXHJcblx0bWVzc2FnZXMudGltZSA9IDBcclxuXHRtZXNzYWdlcy5yZXN1bHQgPSAnJ1xyXG5cdG1lc3NhZ2VzLmxldHRlcnMgPSAnJ1xyXG5cdG1lc3NhZ2VzLm1vdmVzID0gMFxyXG5cdHhkcmF3KClcclxuXHJcbmtleVByZXNzZWQgPSAtPiBcclxuXHRpZiBtZXNzYWdlcy5yZXN1bHQgPT0gJycgdGhlbiByZXR1cm5cclxuXHRpbmRleCA9IFwiIDEyMzQ1Njc4OTBcIi5pbmRleE9mIGtleVxyXG5cdGlmIGluZGV4ID49IDAgdGhlbiByZXNldCBpbmRleFxyXG5cclxuQWN0aXZlQ29tcHV0ZXJIb3VzZSA9ICgpIC0+IFxyXG5cdHN0YXJ0ID0gbmV3IERhdGUoKVxyXG5cdHJlc3VsdCA9IGFscGhhQmV0YSBkZXB0aCwgcGxheWVyIFxyXG5cdCNyZXN1bHQgPSBtaW5pbWF4IGRlcHRoLCBwbGF5ZXJcclxuXHRtZXNzYWdlcy50aW1lICs9IG5ldyBEYXRlKCkgLSBzdGFydFxyXG5cclxuXHRIb3VzZU9uQ2xpY2sgcmVzdWx0XHJcblxyXG5Ib3VzZUJ1dHRvbkFjdGl2ZSA9ICgpIC0+IGlmIHBsYXllckNvbXB1dGVyW3BsYXllcl0gdGhlbiBBY3RpdmVDb21wdXRlckhvdXNlKCkgXHJcblxyXG5Ib3VzZU9uQ2xpY2sgPSAocGlja2VkSG91c2UpIC0+XHJcblx0bWVzc2FnZXMubGV0dGVycyArPSAnYWJjZGVmIEFCQ0RFRidbcGlja2VkSG91c2VdXHJcblx0aWYgYnV0dG9uc1twaWNrZWRIb3VzZV0udmFsdWUgPT0gMCB0aGVuIHJldHVybiBcclxuXHRob3VzZSA9IGJ1dHRvbnMubWFwIChidXR0b24pIC0+IGJ1dHRvbi52YWx1ZVxyXG5cdGFnYWluID0gUmVsb2NhdGlvbihob3VzZSwgcGlja2VkSG91c2UpXHJcblx0Zm9yIGkgaW4gcmFuZ2UgMTRcclxuXHRcdGJ1dHRvbnNbaV0udmFsdWUgPSBob3VzZVtpXVxyXG5cdGlmIGFnYWluID09IGZhbHNlXHJcblx0XHRpZiBwbGF5ZXI9PTFcclxuXHRcdFx0Y29uc29sZS5sb2cgbWVzc2FnZXMubGV0dGVyc1xyXG5cdFx0XHRtZXNzYWdlcy5tb3ZlcysrXHJcblx0XHRwbGF5ZXIgPSAxIC0gcGxheWVyXHJcblx0aWYgSGFzU3VjY2Vzc29ycyhob3VzZSlcclxuXHRcdEhvdXNlQnV0dG9uQWN0aXZlKClcclxuXHRlbHNlIFxyXG5cdFx0RmluYWxTY29yaW5nKGhvdXNlKVxyXG5cdFx0Zm9yIGkgaW4gcmFuZ2UgMTRcclxuXHRcdFx0YnV0dG9uc1tpXS52YWx1ZSA9IGhvdXNlW2ldXHJcblxyXG5cdFx0aWYgaG91c2VbMTNdID4gaG91c2VbNl1cclxuXHRcdFx0bWVzc2FnZXMucmVzdWx0ID0gcGxheWVyVGl0bGVbMV0gKyBcIiBXaW5zXCJcclxuXHRcdFx0ZGVwdGgtLVxyXG5cdFx0ZWxzZSBpZiBob3VzZVsxM10gPT0gaG91c2VbNl1cclxuXHRcdFx0bWVzc2FnZXMucmVzdWx0ID0gXCJUaWVcIlxyXG5cdFx0ZWxzZVxyXG5cdFx0XHRtZXNzYWdlcy5yZXN1bHQgPSBwbGF5ZXJUaXRsZVswXSArIFwiIFdpbnNcIlxyXG5cdFx0XHRkZXB0aCsrXHJcblx0XHRjb25zb2xlLmxvZyAnJ1xyXG5cdHhkcmF3KClcclxuXHJcblJlbG9jYXRpb24gPSAoaG91c2UsIHBpY2tlZEhvdXNlKSAtPlxyXG5cdHBsYXllclNob3AgPSA2XHJcblx0b3Bwb25lbnRTaG9wID0gMTNcclxuXHRpZiBwaWNrZWRIb3VzZSA+IDZcclxuXHRcdHBsYXllclNob3AgPSAxM1xyXG5cdFx0b3Bwb25lbnRTaG9wID0gNlxyXG5cclxuXHRpbmRleCA9IHBpY2tlZEhvdXNlXHJcblx0d2hpbGUgaG91c2VbcGlja2VkSG91c2VdID4gMCBcclxuXHRcdGluZGV4ID0gKGluZGV4ICsgMSkgJSAxNFxyXG5cdFx0aWYgaW5kZXggPT0gb3Bwb25lbnRTaG9wIHRoZW4gY29udGludWVcclxuXHRcdGhvdXNlW2luZGV4XSsrXHJcblx0XHRob3VzZVtwaWNrZWRIb3VzZV0tLVxyXG5cclxuXHRpZiBpbmRleCA9PSBwbGF5ZXJTaG9wIHRoZW4gcmV0dXJuIHRydWVcclxuXHJcblx0aWYgaG91c2VbaW5kZXhdID09IDEgYW5kIGhvdXNlWzEyIC0gaW5kZXhdICE9IDAgYW5kIGluZGV4ID49IChwbGF5ZXJTaG9wIC0gNikgYW5kIGluZGV4IDwgcGxheWVyU2hvcFxyXG5cdFx0aG91c2VbcGxheWVyU2hvcF0gKz0gaG91c2VbMTIgLSBpbmRleF0gKyAxXHJcblx0XHRob3VzZVtpbmRleF0gPSBob3VzZVsxMiAtIGluZGV4XSA9IDBcclxuXHRmYWxzZVxyXG5cclxuRmluYWxTY29yaW5nID0gKGhvdXNlKSAtPlxyXG5cdGZvciBpIGluIHJhbmdlIDZcclxuXHRcdGhvdXNlWzZdICs9IGhvdXNlW2ldXHJcblx0XHRob3VzZVsxM10gKz0gaG91c2VbNyArIGldXHJcblx0XHRob3VzZVtpXSA9IGhvdXNlWzcgKyBpXSA9IDBcclxuXHJcbkV2YWx1YXRlID0gKGhvdXNlLCBwbGF5ZXIxLCBwbGF5ZXIyKSAtPiBob3VzZVtwbGF5ZXIxXSAtIGhvdXNlW3BsYXllcjJdXHJcblxyXG5IYXNTdWNjZXNzb3JzID0gKGhvdXNlKSAtPlxyXG5cdHBsYXllcjEgPSBmYWxzZVxyXG5cdHBsYXllcjIgPSBmYWxzZVxyXG5cdGZvciBpIGluIHJhbmdlIDZcclxuXHRcdGlmIGhvdXNlW2ldICE9IDAgdGhlbiBwbGF5ZXIxID0gdHJ1ZVxyXG5cdFx0aWYgaG91c2VbNyArIGldICE9IDAgdGhlbiBwbGF5ZXIyID0gdHJ1ZVxyXG5cdHBsYXllcjEgYW5kIHBsYXllcjJcclxuIl19
//# sourceURL=c:\Lab\2019\118-Kalaha\coffee\index.coffee