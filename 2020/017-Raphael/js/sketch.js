// Generated by CoffeeScript 2.4.1
var Button, H, SQ2, VERSION, W, cx, cy, h, image, info, messages, move_drag, move_start, move_up, myRound, ox, oy, p, startup, stdText, w;

VERSION = 4;

p = null;

image = null;

SQ2 = Math.sqrt(2);

messages = [];

[W, H] = [
  innerWidth - 10,
  innerHeight - 10 // screen
];

[w, h] = [
  1639,
  986 // image
];

[cx, cy] = [0, 0];

[ox, oy] = [0, 0];

stdText = {
  font: '40px Arial',
  fill: '#888'
};

myRound = function(x, n = 0) {
  return Math.round(x * 10 ** n) / 10 ** n;
};

Button = class Button {
  constructor(x1, y1, prompt, click = function() {}) {
    this.x = x1;
    this.y = y1;
    this.prompt = prompt;
    this.click = click;
    this.circle = p.circle(this.x, this.y, 100).attr({
      fill: '#ff0',
      opacity: 0.5
    }).click(this.click);
    this.text = p.text(this.x, this.y, this.prompt).attr(stdText).click(this.click);
  }

};

move_start = function(x, y, event) {
  //event.preventDefault()
  ox = image.attrs.x;
  oy = image.attrs.y;
  return info();
};

move_drag = function(dx, dy, x, y, event) {
  //event.preventDefault()
  image.translate((dx - ox) / image._.sx, (dy - oy) / image._.sy);
  ox = dx;
  oy = dy;
  return info();
};

move_up = function(event) {};

//event.preventDefault()
//info()
info = function() {
  var dx, dy, sx, sy;
  ({dx, dy, sx, sy} = image._);
  cx = (W / 2 - dx) / sx;
  cy = (H / 2 - dy) / sy;
  return messages[0].attr({
    text: `dx=${myRound(dx)}\ndy=${myRound(dy)}\nsx=${myRound(sx, 2)}\nsy=${myRound(sy, 2)}\ncx=${myRound(cx)}\ncy=${myRound(cy)}`
  });
};

startup = function() {
  var a, b;
  p = Raphael('canvasdiv', W, H);
  p.rect(0, 0, W, H).attr({
    fill: '#fff'
  });
  image = p.image("skarpnäck.png", 0, 0, w, h);
  image.translate((W - w) / 2, (H - h) / 2);
  a = p.text(0.9 * W, 200, "").attr(stdText);
  b = p.text(0.9 * W, 500, `Ver:${VERSION}`).attr(stdText);
  messages = [a, b];
  image.drag(move_drag, move_start, move_up);
  info();
  p.circle(W / 2, H / 2, 20); // crossHair
  p.circle(W / 2, H / 2, 0.5); // crossHair
  new Button(100, 100, 'in', function() {
    return info(image.scale(SQ2, SQ2, cx, cy));
  });
  new Button(100, 300, 'out', function() {
    return info(image.scale(1 / SQ2, 1 / SQ2, cx, cy));
  });
  return new Button(100, 500, 'center', function() {
    return info(image.translate(cx - 990, cy - 216)); // 990,216 Kaninparken
  });
};


// document.getElementById("canvasdiv").addEventListener "wheel", (event) -> 
// 	if event.deltaY > 0 then image.scale 1.1,1.1,cx,cy
// 	else image.scale 1/1.1,1/1.1,cx,cy
// 	info()

// image.mousemove (e) -> 
// 	{dx,dy,sx,sy} = image._
// 	messages[1].attr {text: "x=#{myRound (e.x - dx)/sx}\ny=#{myRound (e.y - dy)/sy}"}

//# sourceMappingURL=data:application/json;base64,eyJ2ZXJzaW9uIjozLCJmaWxlIjoic2tldGNoLmpzIiwic291cmNlUm9vdCI6Ii4uIiwic291cmNlcyI6WyJjb2ZmZWVcXHNrZXRjaC5jb2ZmZWUiXSwibmFtZXMiOltdLCJtYXBwaW5ncyI6IjtBQUFBLElBQUEsTUFBQSxFQUFBLENBQUEsRUFBQSxHQUFBLEVBQUEsT0FBQSxFQUFBLENBQUEsRUFBQSxFQUFBLEVBQUEsRUFBQSxFQUFBLENBQUEsRUFBQSxLQUFBLEVBQUEsSUFBQSxFQUFBLFFBQUEsRUFBQSxTQUFBLEVBQUEsVUFBQSxFQUFBLE9BQUEsRUFBQSxPQUFBLEVBQUEsRUFBQSxFQUFBLEVBQUEsRUFBQSxDQUFBLEVBQUEsT0FBQSxFQUFBLE9BQUEsRUFBQTs7QUFBQSxPQUFBLEdBQVU7O0FBRVYsQ0FBQSxHQUFJOztBQUNKLEtBQUEsR0FBUTs7QUFFUixHQUFBLEdBQU0sSUFBSSxDQUFDLElBQUwsQ0FBVSxDQUFWOztBQUNOLFFBQUEsR0FBVzs7QUFFWCxDQUFDLENBQUQsRUFBRyxDQUFILENBQUEsR0FBUTtFQUFDLFVBQUEsR0FBVyxFQUFaO0VBQWUsV0FBQSxHQUFZLEVBQTNCOzs7QUFDUixDQUFDLENBQUQsRUFBRyxDQUFILENBQUEsR0FBUTtFQUFDLElBQUQ7RUFBTSxHQUFOOzs7QUFDUixDQUFDLEVBQUQsRUFBSSxFQUFKLENBQUEsR0FBVSxDQUFDLENBQUQsRUFBRyxDQUFIOztBQUNWLENBQUMsRUFBRCxFQUFJLEVBQUosQ0FBQSxHQUFVLENBQUMsQ0FBRCxFQUFHLENBQUg7O0FBRVYsT0FBQSxHQUFVO0VBQUMsSUFBQSxFQUFNLFlBQVA7RUFBcUIsSUFBQSxFQUFNO0FBQTNCOztBQUVWLE9BQUEsR0FBVSxRQUFBLENBQUMsQ0FBRCxFQUFHLElBQUUsQ0FBTCxDQUFBO1NBQVcsSUFBSSxDQUFDLEtBQUwsQ0FBVyxDQUFBLEdBQUUsRUFBQSxJQUFJLENBQWpCLENBQUEsR0FBb0IsRUFBQSxJQUFJO0FBQW5DOztBQUVKLFNBQU4sTUFBQSxPQUFBO0VBQ0MsV0FBYyxHQUFBLElBQUEs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QUssQ0FBQyxLQUFOLENBQVksQ0FBQSxHQUFFLEdBQWQsRUFBa0IsQ0FBQSxHQUFFLEdBQXBCLEVBQXdCLEVBQXhCLEVBQTJCLEVBQTNCLENBQUw7RUFBSCxDQUE3QjtTQUNBLElBQUksTUFBSixDQUFXLEdBQVgsRUFBZSxHQUFmLEVBQW1CLFFBQW5CLEVBQTZCLFFBQUEsQ0FBQSxDQUFBO1dBQUcsSUFBQSxDQUFLLEtBQUssQ0FBQyxTQUFOLENBQWdCLEVBQUEsR0FBRyxHQUFuQixFQUF1QixFQUFBLEdBQUcsR0FBMUIsQ0FBTCxFQUFIO0VBQUEsQ0FBN0I7QUFuQlM7O0FBakRWIiwic291cmNlc0NvbnRlbnQiOlsiVkVSU0lPTiA9IDRcclxuXHJcbnAgPSBudWxsIFxyXG5pbWFnZSA9IG51bGxcclxuXHJcblNRMiA9IE1hdGguc3FydCAyXHJcbm1lc3NhZ2VzID0gW11cclxuXHJcbltXLEhdID0gW2lubmVyV2lkdGgtMTAsaW5uZXJIZWlnaHQtMTBdICMgc2NyZWVuXHJcblt3LGhdID0gWzE2MzksOTg2XSAjIGltYWdlXHJcbltjeCxjeV0gPSBbMCwwXVxyXG5bb3gsb3ldID0gWzAsMF1cclxuXHJcbnN0ZFRleHQgPSB7Zm9udDogJzQwcHggQXJpYWwnLCBmaWxsOiAnIzg4OCd9XHJcblxyXG5teVJvdW5kID0gKHgsbj0wKSAtPiBNYXRoLnJvdW5kKHgqMTAqKm4pLzEwKipuXHJcblxyXG5jbGFzcyBCdXR0b25cdFxyXG5cdGNvbnN0cnVjdG9yIDogKEB4LCBAeSwgQHByb21wdCwgQGNsaWNrID0gLT4pIC0+XHJcblx0XHRAY2lyY2xlID0gcC5jaXJjbGUgQHgsQHksMTAwXHJcblx0XHRcdC5hdHRyIHtmaWxsOiAnI2ZmMCcsIG9wYWNpdHk6IDAuNX1cclxuXHRcdFx0LmNsaWNrIEBjbGlja1xyXG5cdFx0QHRleHQgPSBwLnRleHQgQHgsQHksQHByb21wdFxyXG5cdFx0XHQuYXR0ciBzdGRUZXh0XHJcblx0XHRcdC5jbGljayBAY2xpY2tcclxuXHJcbm1vdmVfc3RhcnQgPSAoeCx5LGV2ZW50KSAtPlxyXG5cdCNldmVudC5wcmV2ZW50RGVmYXVsdCgpXHJcblx0b3ggPSBpbWFnZS5hdHRycy54XHJcblx0b3kgPSBpbWFnZS5hdHRycy55XHJcblx0aW5mbygpXHJcblxyXG5tb3ZlX2RyYWcgPSAoZHgsIGR5LCB4LCB5LCBldmVudCkgLT5cclxuXHQjZXZlbnQucHJldmVudERlZmF1bHQoKVxyXG5cdGltYWdlLnRyYW5zbGF0ZSAoZHgtb3gpIC8gaW1hZ2UuXy5zeCwgKGR5LW95KSAvIGltYWdlLl8uc3lcclxuXHRveCA9IGR4XHJcblx0b3kgPSBkeVxyXG5cdGluZm8oKVxyXG5cclxubW92ZV91cCA9IChldmVudCkgLT5cclxuXHQjZXZlbnQucHJldmVudERlZmF1bHQoKVxyXG5cdCNpbmZvKClcclxuXHJcbmluZm8gPSAtPlxyXG5cdHtkeCxkeSxzeCxzeX0gPSBpbWFnZS5fXHJcblx0Y3ggPSAoVy8yLWR4KS9zeFxyXG5cdGN5ID0gKEgvMi1keSkvc3lcclxuXHRtZXNzYWdlc1swXS5hdHRyIHt0ZXh0IDogXCJkeD0je215Um91bmQgZHh9XFxuZHk9I3tteVJvdW5kIGR5fVxcbnN4PSN7bXlSb3VuZCBzeCwyfVxcbnN5PSN7bXlSb3VuZCBzeSwyfVxcbmN4PSN7bXlSb3VuZCBjeH1cXG5jeT0je215Um91bmQgY3l9XCJ9XHJcblxyXG5zdGFydHVwID0gLT5cclxuXHRwID0gUmFwaGFlbCAnY2FudmFzZGl2JywgVywgSFxyXG5cdHAucmVjdCAwLCAwLCBXLCBIXHJcblx0XHQuYXR0ciB7ZmlsbDogJyNmZmYnfVxyXG5cclxuXHRpbWFnZSA9IHAuaW1hZ2UgXCJza2FycG7DpGNrLnBuZ1wiLCAwLDAsIHcsaFxyXG5cdGltYWdlLnRyYW5zbGF0ZSAoVy13KS8yLCAoSC1oKS8yXHJcblx0YSA9IHAudGV4dCgwLjkqVywgMjAwLCBcIlwiKS5hdHRyIHN0ZFRleHRcclxuXHRiID0gcC50ZXh0KDAuOSpXLCA1MDAsIFwiVmVyOiN7VkVSU0lPTn1cIikuYXR0ciBzdGRUZXh0XHJcblx0bWVzc2FnZXMgPSBbYSxiXVxyXG5cclxuXHRpbWFnZS5kcmFnIG1vdmVfZHJhZywgbW92ZV9zdGFydCwgbW92ZV91cFxyXG5cdGluZm8oKVxyXG5cclxuXHRwLmNpcmNsZSBXLzIsSC8yLDIwICMgY3Jvc3NIYWlyXHJcblx0cC5jaXJjbGUgVy8yLEgvMiwwLjUgIyBjcm9zc0hhaXJcclxuXHJcblx0bmV3IEJ1dHRvbiAxMDAsMTAwLCdpbicsICAgICAtPiBpbmZvIGltYWdlLnNjYWxlIFNRMixTUTIsY3gsY3lcclxuXHRuZXcgQnV0dG9uIDEwMCwzMDAsJ291dCcsICAgIC0+IGluZm8gaW1hZ2Uuc2NhbGUgMS9TUTIsMS9TUTIsY3gsY3lcclxuXHRuZXcgQnV0dG9uIDEwMCw1MDAsJ2NlbnRlcicsIC0+IGluZm8gaW1hZ2UudHJhbnNsYXRlIGN4LTk5MCxjeS0yMTYgIyA5OTAsMjE2IEthbmlucGFya2VuXHJcblxyXG5cdCMgZG9jdW1lbnQuZ2V0RWxlbWVudEJ5SWQoXCJjYW52YXNkaXZcIikuYWRkRXZlbnRMaXN0ZW5lciBcIndoZWVsXCIsIChldmVudCkgLT4gXHJcblx0IyBcdGlmIGV2ZW50LmRlbHRhWSA+IDAgdGhlbiBpbWFnZS5zY2FsZSAxLjEsMS4xLGN4LGN5XHJcblx0IyBcdGVsc2UgaW1hZ2Uuc2NhbGUgMS8xLjEsMS8xLjEsY3gsY3lcclxuXHQjIFx0aW5mbygpXHJcblxyXG5cdCMgaW1hZ2UubW91c2Vtb3ZlIChlKSAtPiBcclxuXHQjIFx0e2R4LGR5LHN4LHN5fSA9IGltYWdlLl9cclxuXHQjIFx0bWVzc2FnZXNbMV0uYXR0ciB7dGV4dDogXCJ4PSN7bXlSb3VuZCAoZS54IC0gZHgpL3N4fVxcbnk9I3tteVJvdW5kIChlLnkgLSBkeSkvc3l9XCJ9XHJcbiJdfQ==
//# sourceURL=c:\Lab\2020\017-Raphael\coffee\sketch.coffee