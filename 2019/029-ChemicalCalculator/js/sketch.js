// Generated by CoffeeScript 2.3.2
var ATOMIC_MASS, add, molar_mass, mul;

ATOMIC_MASS = {
  H: 1.008,
  C: 12.011,
  O: 15.999,
  Na: 22.98976928,
  S: 32.06,
  Uue: 315
};

mul = function(match, p1, offset, string) {
  return '*' + p1;
};

add = function(match, p1, offset, string) {
  if (p1 === '(') {
    return '+' + p1;
  }
  return `+${ATOMIC_MASS[p1]}`;
};

molar_mass = function(s) {
  s = s.replace(/(\d+)/g, mul);
  s = s.replace(/([A-Z][a-z]{0,2}|\()/g, add);
  return parseFloat(eval(s).toFixed(3));
};

//##############################
molar_mass = function(s) {
  var i, member, name, next, result;
  result = '';
  i = 0;
  member = function(a, c) {
    var ref;
    return (a <= (ref = s[i]) && ref <= c);
  };
  next = function() {
    i += 1;
    return s[i - 1];
  };
  while (i < s.length) {
    if (s[i] === '(') {
      result += '+' + next();
    } else if (s[i] === ')') {
      result += next();
    } else if (member('0', '9')) {
      result += '*';
      while (member('0', '9')) {
        result += next();
      }
    } else if (member('A', 'Z')) {
      name = next();
      while (member('a', 'z')) {
        name += next();
      }
      result += '+' + ATOMIC_MASS[name];
    }
  }
  return parseFloat(eval(result).toFixed(3));
};

assert(1.008, molar_mass('H'));

assert(2.016, molar_mass('H2'));

assert(18.015, molar_mass('H2O'));

assert(34.014, molar_mass('H2O2'));

assert(34.014, molar_mass('(HO)2'));

assert(142.036, molar_mass('Na2SO4'));

assert(84.162, molar_mass('C6H12'));

assert(186.295, molar_mass('COOH(C(CH3)2)3CH3'));

assert(176.124, molar_mass('C6H4O2(OH)4')); // Vitamin C

assert(386.664, molar_mass('C27H46O')); // Cholesterol

assert(315, molar_mass('Uue'));

//# sourceMappingURL=data:application/json;base64,eyJ2ZXJzaW9uIjozLCJmaWxlIjoic2tldGNoLmpzIiwic291cmNlUm9vdCI6Ii4uIiwic291cmNlcyI6WyJjb2ZmZWVcXHNrZXRjaC5jb2ZmZWUiXSwibmFtZXMiOltdLCJtYXBwaW5ncyI6IjtBQUFBLElBQUEsV0FBQSxFQUFBLEdBQUEsRUFBQSxVQUFBLEVBQUE7O0FBQUEsV0FBQSxHQUFjO0VBQUMsQ0FBQSxFQUFFLEtBQUg7RUFBUyxDQUFBLEVBQUUsTUFBWDtFQUFrQixDQUFBLEVBQUUsTUFBcEI7RUFBMkIsRUFBQSxFQUFHLFdBQTlCO0VBQTBDLENBQUEsRUFBRSxLQUE1QztFQUFrRCxHQUFBLEVBQUk7QUFBdEQ7O0FBRWQsR0FBQSxHQUFNLFFBQUEsQ0FBQyxLQUFELEVBQVEsRUFBUixFQUFZLE1BQVosRUFBb0IsTUFBcEIsQ0FBQTtTQUErQixHQUFBLEdBQU07QUFBckM7O0FBQ04sR0FBQSxHQUFNLFFBQUEsQ0FBQyxLQUFELEVBQVEsRUFBUixFQUFZLE1BQVosRUFBb0IsTUFBcEIsQ0FBQTtFQUNMLElBQUcsRUFBQSxLQUFNLEdBQVQ7QUFBa0IsV0FBTyxHQUFBLEdBQU0sR0FBL0I7O1NBQ0EsQ0FBQSxDQUFBLENBQUEsQ0FBSSxXQUFZLENBQUEsRUFBQSxDQUFoQixDQUFBO0FBRks7O0FBSU4sVUFBQSxHQUFhLFFBQUEsQ0FBQyxDQUFELENBQUE7RUFDWixDQUFBLEdBQUksQ0FBQyxDQUFDLE9BQUYsQ0FBVSxRQUFWLEVBQW9CLEdBQXBCO0VBQ0osQ0FBQSxHQUFJLENBQUMsQ0FBQyxPQUFGLENBQVUsdUJBQVYsRUFBbUMsR0FBbkM7U0FDSixVQUFBLENBQVcsSUFBQSxDQUFLLENBQUwsQ0FBTyxDQUFDLE9BQVIsQ0FBZ0IsQ0FBaEIsQ0FBWDtBQUhZLEVBUGI7OztBQWNBLFVBQUEsR0FBYSxRQUFBLENBQUMsQ0FBRCxDQUFBO0FBQ1osTUFBQSxDQUFBLEVBQUEsTUFBQSxFQUFBLElBQUEsRUFBQSxJQUFBLEVBQUE7RUFBQSxNQUFBLEdBQVM7RUFDVCxDQUFBLEdBQUk7RUFDSixNQUFBLEdBQVMsUUFBQSxDQUFDLENBQUQsRUFBRyxDQUFILENBQUE7QUFBVSxRQUFBO1dBQUEsQ0FBQSxDQUFBLFdBQUssQ0FBRSxDQUFBLENBQUEsRUFBUCxPQUFBLElBQWEsQ0FBYjtFQUFWO0VBQ1QsSUFBQSxHQUFPLFFBQUEsQ0FBQSxDQUFBO0lBQ04sQ0FBQSxJQUFLO1dBQ0wsQ0FBRSxDQUFBLENBQUEsR0FBRSxDQUFGO0VBRkk7QUFHUCxTQUFNLENBQUEsR0FBSSxDQUFDLENBQUMsTUFBWjtJQUNDLElBQUcsQ0FBRSxDQUFBLENBQUEsQ0FBRixLQUFRLEdBQVg7TUFBb0IsTUFBQSxJQUFVLEdBQUEsR0FBTSxJQUFBLENBQUEsRUFBcEM7S0FBQSxNQUNLLElBQUcsQ0FBRSxDQUFBLENBQUEsQ0FBRixLQUFRLEdBQVg7TUFBb0IsTUFBQSxJQUFVLElBQUEsQ0FBQSxFQUE5QjtLQUFBLE1BQ0EsSUFBRyxNQUFBLENBQU8sR0FBUCxFQUFXLEdBQVgsQ0FBSDtNQUNKLE1BQUEsSUFBVTtBQUNPLGFBQU0sTUFBQSxDQUFPLEdBQVAsRUFBVyxHQUFYLENBQU47UUFBakIsTUFBQSxJQUFVLElBQUEsQ0FBQTtNQUFPLENBRmI7S0FBQSxNQUdBLElBQUcsTUFBQSxDQUFPLEdBQVAsRUFBVyxHQUFYLENBQUg7TUFDSixJQUFBLEdBQU8sSUFBQSxDQUFBO0FBQ1EsYUFBTSxNQUFBLENBQU8sR0FBUCxFQUFXLEdBQVgsQ0FBTjtRQUFmLElBQUEsSUFBUSxJQUFBLENBQUE7TUFBTztNQUNmLE1BQUEsSUFBVSxHQUFBLEdBQU0sV0FBWSxDQUFBLElBQUEsRUFIeEI7O0VBTk47U0FVQSxVQUFBLENBQVcsSUFBQSxDQUFLLE1BQUwsQ0FBWSxDQUFDLE9BQWIsQ0FBcUIsQ0FBckIsQ0FBWDtBQWpCWTs7QUFtQmIsTUFBQSxDQUFPLEtBQVAsRUFBYyxVQUFBLENBQVcsR0FBWCxDQUFkOztBQUNBLE1BQUEsQ0FBTyxLQUFQLEVBQWMsVUFBQSxDQUFXLElBQVgsQ0FBZDs7QUFDQSxNQUFBLENBQU8sTUFBUCxFQUFlLFVBQUEsQ0FBVyxLQUFYLENBQWY7O0FBQ0EsTUFBQSxDQUFPLE1BQVAsRUFBZSxVQUFBLENBQVcsTUFBWCxDQUFmOztBQUNBLE1BQUEsQ0FBTyxNQUFQLEVBQWUsVUFBQSxDQUFXLE9BQVgsQ0FBZjs7QUFDQSxNQUFBLENBQU8sT0FBUCxFQUFnQixVQUFBLENBQVcsUUFBWCxDQUFoQjs7QUFDQSxNQUFBLENBQU8sTUFBUCxFQUFlLFVBQUEsQ0FBVyxPQUFYLENBQWY7O0FBQ0EsTUFBQSxDQUFPLE9BQVAsRUFBZ0IsVUFBQSxDQUFXLG1CQUFYLENBQWhCOztBQUNBLE1BQUEsQ0FBTyxPQUFQLEVBQWdCLFVBQUEsQ0FBVyxhQUFYLENBQWhCLEVBekNBOztBQTBDQSxNQUFBLENBQU8sT0FBUCxFQUFnQixVQUFBLENBQVcsU0FBWCxDQUFoQixFQTFDQTs7QUEyQ0EsTUFBQSxDQUFPLEdBQVAsRUFBWSxVQUFBLENBQVcsS0FBWCxDQUFaIiwic291cmNlc0NvbnRlbnQiOlsiQVRPTUlDX01BU1MgPSB7SDoxLjAwOCxDOjEyLjAxMSxPOjE1Ljk5OSxOYToyMi45ODk3NjkyOCxTOjMyLjA2LFV1ZTozMTV9XHJcblxyXG5tdWwgPSAobWF0Y2gsIHAxLCBvZmZzZXQsIHN0cmluZykgLT4gJyonICsgcDEgXHJcbmFkZCA9IChtYXRjaCwgcDEsIG9mZnNldCwgc3RyaW5nKSAtPiBcclxuXHRpZiBwMSA9PSAnKCcgdGhlbiByZXR1cm4gJysnICsgcDEgXHJcblx0XCIrI3tBVE9NSUNfTUFTU1twMV19XCJcclxuXHJcbm1vbGFyX21hc3MgPSAocykgLT5cclxuXHRzID0gcy5yZXBsYWNlIC8oXFxkKykvZywgbXVsXHJcblx0cyA9IHMucmVwbGFjZSAvKFtBLVpdW2Etel17MCwyfXxcXCgpL2csIGFkZFxyXG5cdHBhcnNlRmxvYXQoZXZhbChzKS50b0ZpeGVkKDMpKVxyXG5cclxuIyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMjI1xyXG5cclxubW9sYXJfbWFzcyA9IChzKSAtPlxyXG5cdHJlc3VsdCA9ICcnXHJcblx0aSA9IDBcclxuXHRtZW1iZXIgPSAoYSxjKSAtPiAgYSA8PSBzW2ldIDw9IGNcclxuXHRuZXh0ID0gLT5cclxuXHRcdGkgKz0gMVxyXG5cdFx0c1tpLTFdXHJcblx0d2hpbGUgaSA8IHMubGVuZ3RoXHJcblx0XHRpZiBzW2ldID09ICcoJyB0aGVuXHRyZXN1bHQgKz0gJysnICsgbmV4dCgpXHJcblx0XHRlbHNlIGlmIHNbaV0gPT0gJyknIHRoZW4gcmVzdWx0ICs9IG5leHQoKVxyXG5cdFx0ZWxzZSBpZiBtZW1iZXIgJzAnLCc5J1xyXG5cdFx0XHRyZXN1bHQgKz0gJyonIFxyXG5cdFx0XHRyZXN1bHQgKz0gbmV4dCgpIHdoaWxlIG1lbWJlciAnMCcsJzknXHJcblx0XHRlbHNlIGlmIG1lbWJlciAnQScsJ1onXHJcblx0XHRcdG5hbWUgPSBuZXh0KClcclxuXHRcdFx0bmFtZSArPSBuZXh0KCkgd2hpbGUgbWVtYmVyICdhJywneidcclxuXHRcdFx0cmVzdWx0ICs9ICcrJyArIEFUT01JQ19NQVNTW25hbWVdXHJcblx0cGFyc2VGbG9hdCBldmFsKHJlc3VsdCkudG9GaXhlZCAzXHJcblxyXG5hc3NlcnQgMS4wMDgsIG1vbGFyX21hc3MgJ0gnXHJcbmFzc2VydCAyLjAxNiwgbW9sYXJfbWFzcyAnSDInXHJcbmFzc2VydCAxOC4wMTUsIG1vbGFyX21hc3MgJ0gyTydcclxuYXNzZXJ0IDM0LjAxNCwgbW9sYXJfbWFzcyAnSDJPMidcclxuYXNzZXJ0IDM0LjAxNCwgbW9sYXJfbWFzcyAnKEhPKTInXHJcbmFzc2VydCAxNDIuMDM2LCBtb2xhcl9tYXNzICdOYTJTTzQnXHJcbmFzc2VydCA4NC4xNjIsIG1vbGFyX21hc3MgJ0M2SDEyJ1xyXG5hc3NlcnQgMTg2LjI5NSwgbW9sYXJfbWFzcyAnQ09PSChDKENIMykyKTNDSDMnXHJcbmFzc2VydCAxNzYuMTI0LCBtb2xhcl9tYXNzICdDNkg0TzIoT0gpNCcgIyBWaXRhbWluIENcclxuYXNzZXJ0IDM4Ni42NjQsIG1vbGFyX21hc3MgJ0MyN0g0Nk8nICMgQ2hvbGVzdGVyb2xcclxuYXNzZXJ0IDMxNSwgbW9sYXJfbWFzcyAnVXVlJ1xyXG4iXX0=
//# sourceURL=C:\Lab\2019\029-ChemicalCalculator\coffee\sketch.coffee