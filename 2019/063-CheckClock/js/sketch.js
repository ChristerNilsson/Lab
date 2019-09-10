// Generated by CoffeeScript 2.3.2
var DIGITS, Digit, digits, draw, keyPressed, setup,
  modulo = function(a, b) { return (+a % (b = +b) + b) % b; };

DIGITS = ['01110100011000110001100011000101110', '00100011000010000100001000010001110', '01110100010000100010001000100011111', '01110100010000100010000011000101110', '00010001000100010010111110001000010', '11111100001000011110000011000101110', '01110100011000011110100011000101110', '11111000010001000100010000100001000', '01110100011000101110100011000101110', '01110100011000101111000011000101110'];

Digit = class Digit {
  render() {
    return this.dots = div({
      style: "float:left; width:119px"
    }, () => {
      var i, j, len, ref, results;
      ref = range(35);
      results = [];
      for (j = 0, len = ref.length; j < len; j++) {
        i = ref[j];
        results.push(chkBox({
          checked: false
        }));
      }
      return results;
    });
  }

  update(digit) {
    var d, i, j, len, ref, results;
    ref = DIGITS[digit];
    results = [];
    for (i = j = 0, len = ref.length; j < len; i = ++j) {
      d = ref[i];
      results.push(this.dots.children[i].checked = d === '1');
    }
    return results;
  }

  toString() {
    var result;
    result = range(35).map((i) => {
      if (this.dots.children[i].checked) {
        return '1';
      } else {
        return '0';
      }
    });
    return result.join('');
  }

};

digits = [];

setup = function() {
  var i, j, len, ref;
  noCanvas();
  digits = [];
  ref = range(6);
  for (j = 0, len = ref.length; j < len; j++) {
    i = ref[j];
    digits.push(new Digit());
  }
  return body(function() {
    var digit, k, len1, results;
    results = [];
    for (k = 0, len1 = digits.length; k < len1; k++) {
      digit = digits[k];
      results.push(digit.render());
    }
    return results;
  });
};

draw = function() {
  var a, b, c, d, date, e, f;
  date = new Date();
  [a, b, c, d, e, f] = digits;
  a.update(Math.floor(date.getHours() / 10));
  b.update(modulo(date.getHours(), 10));
  c.update(Math.floor(date.getMinutes() / 10));
  d.update(modulo(date.getMinutes(), 10));
  e.update(Math.floor(date.getSeconds() / 10));
  return f.update(modulo(date.getSeconds(), 10));
};

keyPressed = function() {
  return print(digits[6].toString());
};

//# sourceMappingURL=data:application/json;base64,eyJ2ZXJzaW9uIjozLCJmaWxlIjoic2tldGNoLmpzIiwic291cmNlUm9vdCI6Ii4uIiwic291cmNlcyI6WyJjb2ZmZWVcXHNrZXRjaC5jb2ZmZWUiXSwibmFtZXMiOltdLCJtYXBwaW5ncyI6IjtBQUFBLElBQUEsTUFBQSxFQUFBLEtBQUEsRUFBQSxNQUFBLEVBQUEsSUFBQSxFQUFBLFVBQUEsRUFBQSxLQUFBO0VBQUE7O0FBQUEsTUFBQSxHQUFTLENBQ1IscUNBRFEsRUFFUixxQ0FGUSxFQUdSLHFDQUhRLEVBSVIscUNBSlEsRUFLUixxQ0FMUSxFQU1SLHFDQU5RLEVBT1IscUNBUFEsRUFRUixxQ0FSUSxFQVNSLHFDQVRRLEVBVVIscUNBVlE7O0FBYUgsUUFBTixNQUFBLE1BQUE7RUFDQyxNQUFTLENBQUEsQ0FBQTtXQUNSLElBQUMsQ0FBQSxJQUFELEdBQVEsR0FBQSxDQUFJO01BQUMsS0FBQSxFQUFNO0lBQVAsQ0FBSixFQUF1QyxDQUFBLENBQUEsR0FBQTtBQUM5QyxVQUFBLENBQUEsRUFBQSxDQUFBLEVBQUEsR0FBQSxFQUFBLEdBQUEsRUFBQTtBQUFBO0FBQUE7TUFBQSxLQUFBLHFDQUFBOztxQkFDQyxNQUFBLENBQU87VUFBQyxPQUFBLEVBQVM7UUFBVixDQUFQO01BREQsQ0FBQTs7SUFEOEMsQ0FBdkM7RUFEQTs7RUFJVCxNQUFTLENBQUMsS0FBRCxDQUFBO0FBQ1IsUUFBQSxDQUFBLEVBQUEsQ0FBQSxFQUFBLENBQUEsRUFBQSxHQUFBLEVBQUEsR0FBQSxFQUFBO0FBQUE7QUFBQTtJQUFBLEtBQUEsNkNBQUE7O21CQUNDLElBQUMsQ0FBQSxJQUFJLENBQUMsUUFBUyxDQUFBLENBQUEsQ0FBRSxDQUFDLE9BQWxCLEdBQTRCLENBQUEsS0FBSztJQURsQyxDQUFBOztFQURROztFQUdULFFBQVcsQ0FBQSxDQUFBO0FBQ1YsUUFBQTtJQUFBLE1BQUEsR0FBUyxLQUFBLENBQU0sRUFBTixDQUFTLENBQUMsR0FBVixDQUFjLENBQUMsQ0FBRCxDQUFBLEdBQUE7TUFBTyxJQUFHLElBQUMsQ0FBQSxJQUFJLENBQUMsUUFBUyxDQUFBLENBQUEsQ0FBRSxDQUFDLE9BQXJCO2VBQWtDLElBQWxDO09BQUEsTUFBQTtlQUEyQyxJQUEzQzs7SUFBUCxDQUFkO1dBQ1QsTUFBTSxDQUFDLElBQVAsQ0FBWSxFQUFaO0VBRlU7O0FBUlo7O0FBWUEsTUFBQSxHQUFTOztBQUVULEtBQUEsR0FBUSxRQUFBLENBQUEsQ0FBQTtBQUNQLE1BQUEsQ0FBQSxFQUFBLENBQUEsRUFBQSxHQUFBLEVBQUE7RUFBQSxRQUFBLENBQUE7RUFDQSxNQUFBLEdBQVM7QUFDVDtFQUFBLEtBQUEscUNBQUE7O0lBQ0MsTUFBTSxDQUFDLElBQVAsQ0FBWSxJQUFJLEtBQUosQ0FBQSxDQUFaO0VBREQ7U0FFQSxJQUFBLENBQUssUUFBQSxDQUFBLENBQUE7QUFDSixRQUFBLEtBQUEsRUFBQSxDQUFBLEVBQUEsSUFBQSxFQUFBO0FBQUE7SUFBQSxLQUFBLDBDQUFBOzttQkFDQyxLQUFLLENBQUMsTUFBTixDQUFBO0lBREQsQ0FBQTs7RUFESSxDQUFMO0FBTE87O0FBU1IsSUFBQSxHQUFPLFFBQUEsQ0FBQSxDQUFBO0FBQ04sTUFBQSxDQUFBLEVBQUEsQ0FBQSxFQUFBLENBQUEsRUFBQSxDQUFBLEVBQUEsSUFBQSxFQUFBLENBQUEsRUFBQTtFQUFBLElBQUEsR0FBTyxJQUFJLElBQUosQ0FBQTtFQUNQLENBQUMsQ0FBRCxFQUFHLENBQUgsRUFBSyxDQUFMLEVBQU8sQ0FBUCxFQUFTLENBQVQsRUFBVyxDQUFYLENBQUEsR0FBZ0I7RUFDaEIsQ0FBQyxDQUFDLE1BQUYsWUFBUyxJQUFJLENBQUMsUUFBTCxDQUFBLElBQW1CLEdBQTVCO0VBQ0EsQ0FBQyxDQUFDLE1BQUYsUUFBUyxJQUFJLENBQUMsUUFBTCxDQUFBLEdBQW1CLEdBQTVCO0VBQ0EsQ0FBQyxDQUFDLE1BQUYsWUFBUyxJQUFJLENBQUMsVUFBTCxDQUFBLElBQXFCLEdBQTlCO0VBQ0EsQ0FBQyxDQUFDLE1BQUYsUUFBUyxJQUFJLENBQUMsVUFBTCxDQUFBLEdBQXFCLEdBQTlCO0VBQ0EsQ0FBQyxDQUFDLE1BQUYsWUFBUyxJQUFJLENBQUMsVUFBTCxDQUFBLElBQXFCLEdBQTlCO1NBQ0EsQ0FBQyxDQUFDLE1BQUYsUUFBUyxJQUFJLENBQUMsVUFBTCxDQUFBLEdBQXFCLEdBQTlCO0FBUk07O0FBVVAsVUFBQSxHQUFhLFFBQUEsQ0FBQSxDQUFBO1NBQ1osS0FBQSxDQUFNLE1BQU8sQ0FBQSxDQUFBLENBQUUsQ0FBQyxRQUFWLENBQUEsQ0FBTjtBQURZIiwic291cmNlc0NvbnRlbnQiOlsiRElHSVRTID0gW1xyXG5cdCcwMTExMDEwMDAxMTAwMDExMDAwMTEwMDAxMTAwMDEwMTExMCdcclxuXHQnMDAxMDAwMTEwMDAwMTAwMDAxMDAwMDEwMDAwMTAwMDExMTAnXHJcblx0JzAxMTEwMTAwMDEwMDAwMTAwMDEwMDAxMDAwMTAwMDExMTExJ1xyXG5cdCcwMTExMDEwMDAxMDAwMDEwMDAxMDAwMDAxMTAwMDEwMTExMCdcclxuXHQnMDAwMTAwMDEwMDAxMDAwMTAwMTAxMTExMTAwMDEwMDAwMTAnXHJcblx0JzExMTExMTAwMDAxMDAwMDExMTEwMDAwMDExMDAwMTAxMTEwJ1xyXG5cdCcwMTExMDEwMDAxMTAwMDAxMTExMDEwMDAxMTAwMDEwMTExMCdcclxuXHQnMTExMTEwMDAwMTAwMDEwMDAxMDAwMTAwMDAxMDAwMDEwMDAnXHJcblx0JzAxMTEwMTAwMDExMDAwMTAxMTEwMTAwMDExMDAwMTAxMTEwJ1xyXG5cdCcwMTExMDEwMDAxMTAwMDEwMTExMTAwMDAxMTAwMDEwMTExMCdcclxuXVxyXG5cclxuY2xhc3MgRGlnaXQgXHJcblx0cmVuZGVyIDogLT5cclxuXHRcdEBkb3RzID0gZGl2IHtzdHlsZTpcImZsb2F0OmxlZnQ7IHdpZHRoOjExOXB4XCJ9LCA9PlxyXG5cdFx0XHRmb3IgaSBpbiByYW5nZSAzNVxyXG5cdFx0XHRcdGNoa0JveCB7Y2hlY2tlZDogZmFsc2V9XHJcblx0dXBkYXRlIDogKGRpZ2l0KSAtPlxyXG5cdFx0Zm9yIGQsaSBpbiBESUdJVFNbZGlnaXRdXHJcblx0XHRcdEBkb3RzLmNoaWxkcmVuW2ldLmNoZWNrZWQgPSBkID09ICcxJ1xyXG5cdHRvU3RyaW5nIDogLT5cclxuXHRcdHJlc3VsdCA9IHJhbmdlKDM1KS5tYXAgKGkpID0+IGlmIEBkb3RzLmNoaWxkcmVuW2ldLmNoZWNrZWQgdGhlbiAnMScgZWxzZSAnMCdcclxuXHRcdHJlc3VsdC5qb2luICcnXHJcblxyXG5kaWdpdHMgPSBbXVxyXG5cclxuc2V0dXAgPSAtPlxyXG5cdG5vQ2FudmFzKClcclxuXHRkaWdpdHMgPSBbXVxyXG5cdGZvciBpIGluIHJhbmdlIDZcclxuXHRcdGRpZ2l0cy5wdXNoIG5ldyBEaWdpdCgpXHJcblx0Ym9keSAtPlxyXG5cdFx0Zm9yIGRpZ2l0IGluIGRpZ2l0c1xyXG5cdFx0XHRkaWdpdC5yZW5kZXIoKVxyXG5cclxuZHJhdyA9IC0+XHJcblx0ZGF0ZSA9IG5ldyBEYXRlKClcclxuXHRbYSxiLGMsZCxlLGZdID0gZGlnaXRzXHJcblx0YS51cGRhdGUgZGF0ZS5nZXRIb3VycygpIC8vIDEwXHJcblx0Yi51cGRhdGUgZGF0ZS5nZXRIb3VycygpICUlIDEwXHJcblx0Yy51cGRhdGUgZGF0ZS5nZXRNaW51dGVzKCkgLy8gMTBcclxuXHRkLnVwZGF0ZSBkYXRlLmdldE1pbnV0ZXMoKSAlJSAxMFxyXG5cdGUudXBkYXRlIGRhdGUuZ2V0U2Vjb25kcygpIC8vIDEwXHJcblx0Zi51cGRhdGUgZGF0ZS5nZXRTZWNvbmRzKCkgJSUgMTBcclxuXHJcbmtleVByZXNzZWQgPSAtPlxyXG5cdHByaW50IGRpZ2l0c1s2XS50b1N0cmluZygpIl19
//# sourceURL=c:\Lab\2019\063-CheckClock\coffee\sketch.coffee