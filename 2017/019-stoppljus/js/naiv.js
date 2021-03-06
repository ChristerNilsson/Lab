// Generated by CoffeeScript 2.0.3
var draw, lamp, setup, state, stoppljus;

state = [0, 0, 0];

setup = function() {
  return createCanvas(windowWidth, windowHeight);
};

lamp = function(tänd, r, g, b, x, y) {
  if (tänd) {
    fc(r, g, b);
  } else {
    fc(0);
  }
  return circle(x, y, 50);
};

stoppljus = function(index, red, redyellow, green, yellow, period, x) {
  var ref, ref1, ref2, t;
  t = frameCount % period;
  if (t === red) {
    state[index] = 0;
  }
  if (t === redyellow) {
    state[index] = 1;
  }
  if (t === green) {
    state[index] = 2;
  }
  if (t === yellow) {
    state[index] = 3;
  }
  lamp((ref = state[index]) === 0 || ref === 1, 1, 0, 0, x, 100); // Red   
  lamp((ref1 = state[index]) === 1 || ref1 === 3, 1, 1, 0, x, 200); // Yellow   
  return lamp((ref2 = state[index]) === 2, 0, 1, 0, x, 300); // Green
};

draw = function() {
  stoppljus(0, 0, 180, 210, 390, 420, 100);
  stoppljus(1, 0, 120, 150, 270, 300, 210);
  return stoppljus(2, 0, 250, 260, 270, 280, 320);
};

//# sourceMappingURL=data:application/json;base64,eyJ2ZXJzaW9uIjozLCJmaWxlIjoibmFpdi5qcyIsInNvdXJjZVJvb3QiOiIuLiIsInNvdXJjZXMiOlsiY29mZmVlXFxuYWl2LmNvZmZlZSJdLCJuYW1lcyI6W10sIm1hcHBpbmdzIjoiO0FBQUEsSUFBQSxJQUFBLEVBQUEsSUFBQSxFQUFBLEtBQUEsRUFBQSxLQUFBLEVBQUE7O0FBQUEsS0FBQSxHQUFRLENBQUMsQ0FBRCxFQUFHLENBQUgsRUFBSyxDQUFMOztBQUVSLEtBQUEsR0FBUSxRQUFBLENBQUEsQ0FBQTtTQUFHLFlBQUEsQ0FBYSxXQUFiLEVBQXlCLFlBQXpCO0FBQUg7O0FBRVIsSUFBQSxHQUFPLFFBQUEsQ0FBQyxJQUFELEVBQU8sQ0FBUCxFQUFTLENBQVQsRUFBVyxDQUFYLEVBQWMsQ0FBZCxFQUFnQixDQUFoQixDQUFBO0VBQ04sSUFBRyxJQUFIO0lBQWEsRUFBQSxDQUFHLENBQUgsRUFBSyxDQUFMLEVBQU8sQ0FBUCxFQUFiO0dBQUEsTUFBQTtJQUEyQixFQUFBLENBQUcsQ0FBSCxFQUEzQjs7U0FDQSxNQUFBLENBQU8sQ0FBUCxFQUFTLENBQVQsRUFBVyxFQUFYO0FBRk07O0FBSVAsU0FBQSxHQUFZLFFBQUEsQ0FBQyxLQUFELEVBQVEsR0FBUixFQUFZLFNBQVosRUFBc0IsS0FBdEIsRUFBNEIsTUFBNUIsRUFBbUMsTUFBbkMsRUFBMkMsQ0FBM0MsQ0FBQTtBQUNYLE1BQUEsR0FBQSxFQUFBLElBQUEsRUFBQSxJQUFBLEVBQUE7RUFBQSxDQUFBLEdBQUksVUFBQSxHQUFhO0VBRWpCLElBQUcsQ0FBQSxLQUFHLEdBQU47SUFBZSxLQUFNLENBQUEsS0FBQSxDQUFOLEdBQWUsRUFBOUI7O0VBQ0EsSUFBRyxDQUFBLEtBQUcsU0FBTjtJQUFxQixLQUFNLENBQUEsS0FBQSxDQUFOLEdBQWUsRUFBcEM7O0VBQ0EsSUFBRyxDQUFBLEtBQUcsS0FBTjtJQUFpQixLQUFNLENBQUEsS0FBQSxDQUFOLEdBQWUsRUFBaEM7O0VBQ0EsSUFBRyxDQUFBLEtBQUcsTUFBTjtJQUFrQixLQUFNLENBQUEsS0FBQSxDQUFOLEdBQWUsRUFBakM7O0VBRUEsSUFBQSxRQUFLLEtBQU0sQ0FBQSxLQUFBLEVBQU4sS0FBaUIsQ0FBakIsSUFBQSxHQUFBLEtBQW1CLENBQXhCLEVBQTRCLENBQTVCLEVBQThCLENBQTlCLEVBQWdDLENBQWhDLEVBQW1DLENBQW5DLEVBQXFDLEdBQXJDLEVBUEE7RUFRQSxJQUFBLFNBQUssS0FBTSxDQUFBLEtBQUEsRUFBTixLQUFpQixDQUFqQixJQUFBLElBQUEsS0FBbUIsQ0FBeEIsRUFBNEIsQ0FBNUIsRUFBOEIsQ0FBOUIsRUFBZ0MsQ0FBaEMsRUFBbUMsQ0FBbkMsRUFBcUMsR0FBckMsRUFSQTtTQVNBLElBQUEsU0FBSyxLQUFNLENBQUEsS0FBQSxFQUFOLEtBQWlCLENBQXRCLEVBQTRCLENBQTVCLEVBQThCLENBQTlCLEVBQWdDLENBQWhDLEVBQW1DLENBQW5DLEVBQXFDLEdBQXJDLEVBVlc7QUFBQTs7QUFZWixJQUFBLEdBQU8sUUFBQSxDQUFBLENBQUE7RUFDTixTQUFBLENBQVUsQ0FBVixFQUFhLENBQWIsRUFBZSxHQUFmLEVBQW1CLEdBQW5CLEVBQXVCLEdBQXZCLEVBQTJCLEdBQTNCLEVBQWdDLEdBQWhDO0VBQ0EsU0FBQSxDQUFVLENBQVYsRUFBYSxDQUFiLEVBQWUsR0FBZixFQUFtQixHQUFuQixFQUF1QixHQUF2QixFQUEyQixHQUEzQixFQUFnQyxHQUFoQztTQUNBLFNBQUEsQ0FBVSxDQUFWLEVBQWEsQ0FBYixFQUFlLEdBQWYsRUFBbUIsR0FBbkIsRUFBdUIsR0FBdkIsRUFBMkIsR0FBM0IsRUFBZ0MsR0FBaEM7QUFITSIsInNvdXJjZXNDb250ZW50IjpbInN0YXRlID0gWzAsMCwwXVxyXG5cclxuc2V0dXAgPSAtPiBjcmVhdGVDYW52YXMgd2luZG93V2lkdGgsd2luZG93SGVpZ2h0XHJcblxyXG5sYW1wID0gKHTDpG5kLCByLGcsYiwgeCx5KSAtPlxyXG5cdGlmIHTDpG5kIHRoZW4gZmMgcixnLGIgZWxzZSBmYyAwXHJcblx0Y2lyY2xlIHgseSw1MCAgIFxyXG5cclxuc3RvcHBsanVzID0gKGluZGV4LCByZWQscmVkeWVsbG93LGdyZWVuLHllbGxvdyxwZXJpb2QsIHgpIC0+XHJcblx0dCA9IGZyYW1lQ291bnQgJSBwZXJpb2RcclxuXHJcblx0aWYgdD09cmVkIHRoZW4gc3RhdGVbaW5kZXhdID0gMFxyXG5cdGlmIHQ9PXJlZHllbGxvdyB0aGVuIHN0YXRlW2luZGV4XSA9IDFcclxuXHRpZiB0PT1ncmVlbiB0aGVuIHN0YXRlW2luZGV4XSA9IDJcclxuXHRpZiB0PT15ZWxsb3cgdGhlbiBzdGF0ZVtpbmRleF0gPSAzXHJcblxyXG5cdGxhbXAgc3RhdGVbaW5kZXhdIGluIFswLDFdLCAxLDAsMCwgeCwxMDAgIyBSZWQgICBcclxuXHRsYW1wIHN0YXRlW2luZGV4XSBpbiBbMSwzXSwgMSwxLDAsIHgsMjAwICMgWWVsbG93ICAgXHJcblx0bGFtcCBzdGF0ZVtpbmRleF0gaW4gWzJdLCAgIDAsMSwwLCB4LDMwMCAjIEdyZWVuXHJcblxyXG5kcmF3ID0gLT4gXHJcblx0c3RvcHBsanVzIDAsIDAsMTgwLDIxMCwzOTAsNDIwLCAxMDBcclxuXHRzdG9wcGxqdXMgMSwgMCwxMjAsMTUwLDI3MCwzMDAsIDIxMFxyXG5cdHN0b3BwbGp1cyAyLCAwLDI1MCwyNjAsMjcwLDI4MCwgMzIwIl19
//# sourceURL=C:\Lab\2017\019-stoppljus\coffee\naiv.coffee