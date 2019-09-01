// Generated by CoffeeScript 2.3.2
var ANGLE_MODE, DISPLAY_MODE, KEY, LANGUAGE, assert, config, decode, encode, makeAnswer, memory, page, setup,
  indexOf = [].indexOf;

KEY = '008B';

ANGLE_MODE = ['Degrees', 'Radians'];

LANGUAGE = ['Coffeescript', 'Javascript'];

DISPLAY_MODE = ['Fixed', 'Engineering'];

memory = null;

page = null;

config = {
  angleMode: 0,
  language: 1,
  displayMode: 0,
  digits: 3
};

assert = function(a, b) {
  try {
    chai.assert.deepEqual(a, b);
    return '';
  } catch (error) {
    return `${a} != ${b}`;
  }
};

makeAnswer = function() {
  var JS, answer, answers, arr, cs, e, i, j, js, len, len1, line, lineNo, pos, ref, res, vertical;
  answers = [];
  res = '';
  cs = '';
  js = [];
  JS = config.language === 0 ? '' : '`';
  angleMode([DEGREES, RADIANS][config.angleMode]);
  ref = memory.split("\n");
  for (i = 0, len = ref.length; i < len; i++) {
    line = ref[i];
    pos = line.lastIndexOf(config.language === 0 ? '#' : '//');
    if (pos >= 0) {
      line = line.slice(0, pos);
    }
    cs = line.trim();
    if (cs === '') {
      js.push(transpile(JS + 'answers.push("")' + JS));
    } else {
      try {
        if (cs[cs.length - 1] === '=') {
          cs += 'undefined';
        }
        js.push(transpile(JS + 'answers.push(' + cs + ")" + JS));
      } catch (error) {
        e = error;
        js.push(transpile(JS + "answers.push('ERROR: " + e.message + "')" + JS));
      }
    }
  }
  try {
    eval(js.join("\n"));
  } catch (error) {
    e = error;
    console.log(e.stack);
    arr = e.stack.split('\n');
    lineNo = arr[1].split(':')[1];
    lineNo = (lineNo - 1) / 3;
    vertical = (range(lineNo).map((x) => {
      return '\n';
    })).join('');
    return vertical + 'ERROR: ' + e.message;
  }
  res = "";
  for (j = 0, len1 = answers.length; j < len1; j++) {
    answer = answers[j];
    if ('function' === typeof answer) {
      res += 'function defined' + "\n";
    } else if ('object' === typeof answer) {
      res += JSON.stringify(answer) + "\n";
    } else if ('number' === typeof answer) {
      if (config.displayMode === 0) {
        res += fixed(answer, config.digits) + "\n";
      }
      if (config.displayMode === 1) {
        res += engineering(answer, config.digits) + "\n";
      }
    } else {
      res += answer + "\n";
    }
  }
  return res;
};

encode = function() {
  var s;
  s = encodeURI(memory);
  s = s.replace(/=/g, '%3D');
  s = s.replace(/\?/g, '%3F');
  return window.open('?content=' + s + '&config=' + encodeURI(JSON.stringify(config)));
};

decode = function() {
  var parameters;
  memory = '';
  if (indexOf.call(window.location.href, '?') >= 0) {
    parameters = getParameters();
    if (parameters.content) {
      memory = decodeURI(parameters.content);
      memory = memory.replace(/%3D/g, '=');
      memory = memory.replace(/%3F/g, '?');
    }
    if (parameters.config) {
      return config = JSON.parse(decodeURI(parameters.config));
    }
  }
};

setup = function() {
  // memory = fetchData()
  decode();
  page = new Page(0, function() {
    var answer, enter;
    this.table.innerHTML = "";
    enter = makeTextArea();
    enter.style.left = '51%';
    enter.style.width = '48%';
    //enter.style.overflow = 'hidden'
    enter.focus();
    enter.value = memory;
    answer = makeTextArea();
    answer.style.left = '0px';
    answer.setAttribute("readonly", true);
    answer.style.textAlign = 'right';
    answer.style.overflow = 'hidden';
    answer.wrap = 'off';
    answer.value = makeAnswer();
    enter.onscroll = function(e) {
      answer.scrollTop = enter.scrollTop;
      return answer.scrollLeft = enter.scrollLeft;
    };
    answer.onscroll = function(e) {
      return e.preventDefault();
    };
    this.addRow(enter, answer);
    return enter.addEventListener("keyup", function(event) {
      var ref;
      answer.scrollTop = enter.scrollTop;
      answer.scrollLeft = enter.scrollLeft;
      if (ref = event.keyCode, indexOf.call([33, 34, 35, 36, 37, 38, 39, 40], ref) < 0) {
        memory = enter.value;
        return answer.value = makeAnswer();
      }
    });
  });
  // storeData memory
  page.addAction('Clear', function() {
    memory = "";
    return storeAndGoto(memory, page);
  });
  page.addAction('Samples', function() {
    if (config.language === 0) {
      memory = "# Coffeescript\n2+3\n\nsträcka = 150\ntid = 6\ntid\nsträcka/tid\n25 == sträcka/tid \n30 == sträcka/tid\n\n# String\na = \"Volvo\" \n5 == a.length\n'l' == a[2]\n\n# Math\n5 == sqrt 25 \n\n# Date\nc = new Date() \nc.getFullYear()\nc.getHours()\n\n# Array\nnumbers = [1,2,3] \n2 == numbers[1]\nnumbers.push 47\n4 == numbers.length\nnumbers \n47 == numbers.pop()\n3 == numbers.length\nnumbers\nassert [0,1,4,9,16,25,36,49,64,81], (x*x for x in range 10)\n\n# Object\nperson = {fnamn:'David', enamn:'Larsson'}\n'David' == person['fnamn']\n'Larsson' == person.enamn\n\n# functions (enbart one liners tillåtna!)\nkvadrat = (x) -> x*x\n25 == kvadrat 5\n\n# feluppskattning vid användande av bäring och avstånd\narea = (b1,b2,r1,r2) -> (r2*r2 - r1*r1) * Math.PI * (b2-b1)/360  \n17.671458676442587 == area 90,91,200,205\n35.12475119638588  == area 90,91,400,405\n69.81317007977317  == area 90,92,195,205\n139.62634015954634 == area 90,92,395,405\n\nserial = (a,b) -> a+b\n2 == serial 1,1\n5 == serial 2,3\n\nparallel = (a,b) -> a*b/(a+b)\n0.5 == parallel 1,1\n1.2 == parallel 2,3\n\nfak = (x) -> if x==0 then 1 else x * fak(x-1)\n3628800 == fak 10\n\nfib = (x) -> if x<=0 then 1 else fib(x-1) + fib(x-2) \n1 == fib 0\n2 == fib 1\n5 == fib 3\n8 == fib 4\n13 == fib 5\n21 == fib 6\n"; // Javascript
    } else {
      memory = "// Javascript\n2+3\n\ndistance = 150\nseconds = 6\nseconds\ndistance/seconds\n25 == distance/seconds\n30 == distance/seconds\n\n// String\na = \"Volvo\" \n5 == a.length\n'l' == a[2]\n\n// Math\n5 == sqrt(25)\n\n// Date\nc = new Date() \nc.getFullYear()\nc.getHours()\n\n// Array\nnumbers = [1,2,3] \n2 == numbers[1]\nnumbers.push(47)\n4 == numbers.length\nnumbers \n47 == numbers.pop()\n3 == numbers.length\nnumbers\nassert([0,1,4,9,16,25,36,49,64,81], range(10).map(x => x*x))\n\n// Object\nperson = {fnamn:'David', enamn:'Larsson'}\n'David' == person['fnamn']\n'Larsson' == person.enamn\n\n// functions (only one liners)\nkvadrat = (x) => x*x\n25 == kvadrat(5)\n\nserial = (a,b) => a+b\n2 == serial(1,1)\n5 == serial(2,3)\n\nparallel = (a,b) => a*b/(a+b)\n0.5 == parallel(1,1)\n1.2 == parallel(2,3)\n\nfak = (x) => (x==0 ? 1 : x * fak(x-1))\n3628800 == fak(10)\n\nfib = (x) => x<=0 ? 1 : fib(x-1) + fib(x-2)\n1 == fib(0)\n2 == fib(1)\n5 == fib(3)\n8 == fib(4)\n13 == fib(5)\n21 == fib(6)\n";
    }
    // storeAndGoto memory,page
    return encode();
  });
  page.addAction('Reference', function() {
    return window.open("https://www.w3schools.com/jsref/default.asp");
  });
  page.addAction('Hide', function() {
    return page.display();
  });
  page.addAction('URL', function() {
    return encode();
  });
  page.addAction(ANGLE_MODE[config.angleMode], function() {
    config.angleMode = 1 - config.angleMode;
    page.actions[5][0] = ANGLE_MODE[config.angleMode];
    makeAnswer();
    return storeAndGoto(memory, page);
  });
  page.addAction(LANGUAGE[config.language], function() {
    config.language = 1 - config.language;
    page.actions[6][0] = LANGUAGE[config.language];
    return storeAndGoto(memory, page);
  });
  page.addAction(DISPLAY_MODE[config.displayMode], function() {
    config.displayMode = 1 - config.displayMode;
    page.actions[7][0] = DISPLAY_MODE[config.displayMode];
    return storeAndGoto(memory, page);
  });
  page.addAction('Less', function() {
    if (config.digits > 1) {
      config.digits--;
    }
    return storeAndGoto(memory, page);
  });
  page.addAction('More', function() {
    if (config.digits < 17) {
      config.digits++;
    }
    return storeAndGoto(memory, page);
  });
  return page.display();
};

//# sourceMappingURL=data:application/json;base64,eyJ2ZXJzaW9uIjozLCJmaWxlIjoic2tldGNoLmpzIiwic291cmNlUm9vdCI6Ii4uIiwic291cmNlcyI6WyJjb2ZmZWVcXHNrZXRjaC5jb2ZmZWUiXSwibmFtZXMiOltdLCJtYXBwaW5ncyI6IjtBQUFBLElBQUEsVUFBQSxFQUFBLFlBQUEsRUFBQSxHQUFBLEVBQUEsUUFBQSxFQUFBLE1BQUEsRUFBQSxNQUFBLEVBQUEsTUFBQSxFQUFBLE1BQUEsRUFBQSxVQUFBLEVBQUEsTUFBQSxFQUFBLElBQUEsRUFBQSxLQUFBO0VBQUE7O0FBQUEsR0FBQSxHQUFNOztBQUVOLFVBQUEsR0FBYSxDQUFDLFNBQUQsRUFBVyxTQUFYOztBQUNiLFFBQUEsR0FBVyxDQUFDLGNBQUQsRUFBZ0IsWUFBaEI7O0FBQ1gsWUFBQSxHQUFlLENBQUMsT0FBRCxFQUFTLGFBQVQ7O0FBRWYsTUFBQSxHQUFTOztBQUNULElBQUEsR0FBTzs7QUFFUCxNQUFBLEdBQ0M7RUFBQSxTQUFBLEVBQVksQ0FBWjtFQUNBLFFBQUEsRUFBVyxDQURYO0VBRUEsV0FBQSxFQUFjLENBRmQ7RUFHQSxNQUFBLEVBQVM7QUFIVDs7QUFLRCxNQUFBLEdBQVMsUUFBQSxDQUFDLENBQUQsRUFBSSxDQUFKLENBQUE7QUFDUjtJQUNDLElBQUksQ0FBQyxNQUFNLENBQUMsU0FBWixDQUFzQixDQUF0QixFQUF5QixDQUF6QjtXQUNBLEdBRkQ7R0FBQSxhQUFBO1dBSUMsQ0FBQSxDQUFBLENBQUcsQ0FBSCxDQUFLLElBQUwsQ0FBQSxDQUFXLENBQVgsQ0FBQSxFQUpEOztBQURROztBQU9ULFVBQUEsR0FBYSxRQUFBLENBQUEsQ0FBQTtBQUNaLE1BQUEsRUFBQSxFQUFBLE1BQUEsRUFBQSxPQUFBLEVBQUEsR0FBQSxFQUFBLEVBQUEsRUFBQSxDQUFBLEVBQUEsQ0FBQSxFQUFBLENBQUEsRUFBQSxFQUFBLEVBQUEsR0FBQSxFQUFBLElBQUEsRUFBQSxJQUFBLEVBQUEsTUFBQSxFQUFBLEdBQUEsRUFBQSxHQUFBLEVBQUEsR0FBQSxFQUFBO0VBQUEsT0FBQSxHQUFV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UUFBUCxHQUFrQixDQUFBLEdBQUksTUFBTSxDQUFDO0lBQzdCLElBQUksQ0FBQyxPQUFRLENBQUEsQ0FBQSxDQUFHLENBQUEsQ0FBQSxDQUFoQixHQUFxQixRQUFTLENBQUEsTUFBTSxDQUFDLFFBQVA7V0FDOUIsWUFBQSxDQUFhLE1BQWIsRUFBb0IsSUFBcEI7RUFIeUMsQ0FBMUM7RUFLQSxJQUFJLENBQUMsU0FBTCxDQUFlLFlBQWEsQ0FBQSxNQUFNLENBQUMsV0FBUCxDQUE1QixFQUFpRCxRQUFBLENBQUEsQ0FBQTtJQUNoRCxNQUFNLENBQUMsV0FBUCxHQUFxQixDQUFBLEdBQUksTUFBTSxDQUFDO0lBQ2hDLElBQUksQ0FBQyxPQUFRLENBQUEsQ0FBQSxDQUFHLENBQUEsQ0FBQSxDQUFoQixHQUFxQixZQUFhLENBQUEsTUFBTSxDQUFDLFdBQVA7V0FDbEMsWUFBQSxDQUFhLE1BQWIsRUFBb0IsSUFBcEI7RUFIZ0QsQ0FBakQ7RUFLQSxJQUFJLENBQUMsU0FBTCxDQUFlLE1BQWYsRUFBdUIsUUFBQSxDQUFBLENBQUE7SUFDdEIsSUFBRyxNQUFNLENBQUMsTUFBUCxHQUFjLENBQWpCO01BQXdCLE1BQU0sQ0FBQyxNQUFQLEdBQXhCOztXQUNBLFlBQUEsQ0FBYSxNQUFiLEVBQW9CLElBQXBCO0VBRnNCLENBQXZCO0VBSUEsSUFBSSxDQUFDLFNBQUwsQ0FBZSxNQUFmLEVBQXVCLFFBQUEsQ0FBQSxDQUFBO0lBQ3RCLElBQUcsTUFBTSxDQUFDLE1BQVAsR0FBYyxFQUFqQjtNQUF5QixNQUFNLENBQUMsTUFBUCxHQUF6Qjs7V0FDQSxZQUFBLENBQWEsTUFBYixFQUFvQixJQUFwQjtFQUZzQixDQUF2QjtTQUlBLElBQUksQ0FBQyxPQUFMLENBQUE7QUExTk8iLCJzb3VyY2VzQ29udGVudCI6WyJLRVkgPSAnMDA4QidcclxuXHJcbkFOR0xFX01PREUgPSBbJ0RlZ3JlZXMnLCdSYWRpYW5zJ11cclxuTEFOR1VBR0UgPSBbJ0NvZmZlZXNjcmlwdCcsJ0phdmFzY3JpcHQnXVxyXG5ESVNQTEFZX01PREUgPSBbJ0ZpeGVkJywnRW5naW5lZXJpbmcnXVxyXG5cclxubWVtb3J5ID0gbnVsbFxyXG5wYWdlID0gbnVsbFxyXG5cclxuY29uZmlnID0gXHJcblx0YW5nbGVNb2RlIDogMFxyXG5cdGxhbmd1YWdlIDogMSBcclxuXHRkaXNwbGF5TW9kZSA6IDAgXHJcblx0ZGlnaXRzIDogM1xyXG5cclxuYXNzZXJ0ID0gKGEsIGIpIC0+XHJcblx0dHJ5XHJcblx0XHRjaGFpLmFzc2VydC5kZWVwRXF1YWwgYSwgYlxyXG5cdFx0JydcclxuXHRjYXRjaFxyXG5cdFx0XCIje2F9ICE9ICN7Yn1cIlxyXG5cclxubWFrZUFuc3dlciA9IC0+IFxyXG5cdGFuc3dlcnMgPSBbXVxyXG5cdHJlcyA9ICcnXHJcblx0Y3MgPSAnJ1xyXG5cdGpzID0gW11cclxuXHRKUyA9IGlmIGNvbmZpZy5sYW5ndWFnZSA9PSAwIHRoZW4gJycgZWxzZSAnYCcgXHJcblxyXG5cdGFuZ2xlTW9kZSBbREVHUkVFUyxSQURJQU5TXVtjb25maWcuYW5nbGVNb2RlXVxyXG5cclxuXHRmb3IgbGluZSBpbiBtZW1vcnkuc3BsaXQgXCJcXG5cIlxyXG5cdFx0cG9zID0gbGluZS5sYXN0SW5kZXhPZiBpZiBjb25maWcubGFuZ3VhZ2UgPT0gMCB0aGVuICcjJyBlbHNlICcvLydcclxuXHRcdGlmIHBvcyA+PTAgdGhlbiBsaW5lID0gbGluZS5zbGljZSAwLHBvc1xyXG5cdFx0Y3MgPSBsaW5lLnRyaW0oKSBcclxuXHRcdGlmIGNzID09ICcnXHJcblx0XHRcdGpzLnB1c2ggdHJhbnNwaWxlIEpTICsgJ2Fuc3dlcnMucHVzaChcIlwiKScgICsgSlMgXHJcblx0XHRlbHNlXHJcblx0XHRcdHRyeVxyXG5cdFx0XHRcdGlmIGNzW2NzLmxlbmd0aC0xXT09Jz0nIHRoZW4gY3MgKz0gJ3VuZGVmaW5lZCdcclxuXHRcdFx0XHRqcy5wdXNoIHRyYW5zcGlsZSBKUyArICdhbnN3ZXJzLnB1c2goJyArIGNzICsgXCIpXCIgICsgSlMgXHJcblx0XHRcdGNhdGNoIGVcclxuXHRcdFx0XHRqcy5wdXNoIHRyYW5zcGlsZSBKUyArIFwiYW5zd2Vycy5wdXNoKCdFUlJPUjogXCIgKyBlLm1lc3NhZ2UgKyBcIicpXCIgICsgSlMgXHJcblxyXG5cdHRyeVxyXG5cdFx0ZXZhbCBqcy5qb2luKFwiXFxuXCIpXHJcblx0Y2F0Y2ggZSBcclxuXHRcdGNvbnNvbGUubG9nIGUuc3RhY2tcclxuXHRcdGFyciA9IGUuc3RhY2suc3BsaXQgJ1xcbidcclxuXHRcdGxpbmVObyA9IGFyclsxXS5zcGxpdCgnOicpWzFdXHJcblx0XHRsaW5lTm8gPSAobGluZU5vLTEpLzNcclxuXHRcdHZlcnRpY2FsID0gKHJhbmdlKGxpbmVObykubWFwICh4KSA9PiAnXFxuJykuam9pbignJylcclxuXHRcdHJldHVybiB2ZXJ0aWNhbCArICdFUlJPUjogJyArIGUubWVzc2FnZVxyXG5cclxuXHRyZXMgPSBcIlwiXHJcblx0Zm9yIGFuc3dlciBpbiBhbnN3ZXJzXHJcblx0XHRpZiAnZnVuY3Rpb24nID09IHR5cGVvZiBhbnN3ZXJcclxuXHRcdFx0cmVzICs9ICdmdW5jdGlvbiBkZWZpbmVkJyArIFwiXFxuXCIgXHJcblx0XHRlbHNlIGlmICdvYmplY3QnID09IHR5cGVvZiBhbnN3ZXJcclxuXHRcdFx0cmVzICs9IEpTT04uc3RyaW5naWZ5KGFuc3dlcikgKyBcIlxcblwiIFxyXG5cdFx0ZWxzZSBpZiAnbnVtYmVyJyA9PSB0eXBlb2YgYW5zd2VyXHJcblx0XHRcdGlmIGNvbmZpZy5kaXNwbGF5TW9kZSA9PSAwIHRoZW4gcmVzICs9IGZpeGVkKGFuc3dlciwgY29uZmlnLmRpZ2l0cykgKyBcIlxcblwiXHJcblx0XHRcdGlmIGNvbmZpZy5kaXNwbGF5TW9kZSA9PSAxIHRoZW4gcmVzICs9IGVuZ2luZWVyaW5nKGFuc3dlciwgY29uZmlnLmRpZ2l0cykgKyBcIlxcblwiXHJcblx0XHRlbHNlXHJcblx0XHRcdHJlcyArPSBhbnN3ZXIgKyBcIlxcblwiXHJcblx0cmVzIFxyXG5cclxuZW5jb2RlID0gLT5cclxuXHRzID0gZW5jb2RlVVJJIG1lbW9yeVxyXG5cdHMgPSBzLnJlcGxhY2UgLz0vZywnJTNEJ1xyXG5cdHMgPSBzLnJlcGxhY2UgL1xcPy9nLCclM0YnXHJcblx0d2luZG93Lm9wZW4gJz9jb250ZW50PScgKyBzICsgJyZjb25maWc9JyArIGVuY29kZVVSSSBKU09OLnN0cmluZ2lmeSBjb25maWdcclxuXHJcbmRlY29kZSA9IC0+XHJcblx0bWVtb3J5ID0gJydcclxuXHRpZiAnPycgaW4gd2luZG93LmxvY2F0aW9uLmhyZWZcclxuXHRcdHBhcmFtZXRlcnMgPSBnZXRQYXJhbWV0ZXJzKClcclxuXHRcdGlmIHBhcmFtZXRlcnMuY29udGVudFxyXG5cdFx0XHRtZW1vcnkgPSBkZWNvZGVVUkkgcGFyYW1ldGVycy5jb250ZW50XHJcblx0XHRcdG1lbW9yeSA9IG1lbW9yeS5yZXBsYWNlIC8lM0QvZywnPSdcclxuXHRcdFx0bWVtb3J5ID0gbWVtb3J5LnJlcGxhY2UgLyUzRi9nLCc/J1xyXG5cdFx0aWYgcGFyYW1ldGVycy5jb25maWdcclxuXHRcdFx0Y29uZmlnID0gSlNPTi5wYXJzZSBkZWNvZGVVUkkgcGFyYW1ldGVycy5jb25maWdcclxuXHJcbnNldHVwID0gLT5cclxuXHJcblx0IyBtZW1vcnkgPSBmZXRjaERhdGEoKVxyXG5cdGRlY29kZSgpXHJcblxyXG5cdHBhZ2UgPSBuZXcgUGFnZSAwLCAtPlxyXG5cdFx0QHRhYmxlLmlubmVySFRNTCA9IFwiXCIgXHJcblxyXG5cdFx0ZW50ZXIgPSBtYWtlVGV4dEFyZWEoKVxyXG5cdFx0ZW50ZXIuc3R5bGUubGVmdCA9ICc1MSUnXHJcblx0XHRlbnRlci5zdHlsZS53aWR0aCA9ICc0OCUnXHJcblx0XHQjZW50ZXIuc3R5bGUub3ZlcmZsb3cgPSAnaGlkZGVuJ1xyXG5cclxuXHRcdGVudGVyLmZvY3VzKClcclxuXHRcdGVudGVyLnZhbHVlID0gbWVtb3J5XHJcblxyXG5cdFx0YW5zd2VyID0gbWFrZVRleHRBcmVhKCkgXHJcblx0XHRhbnN3ZXIuc3R5bGUubGVmdCA9ICcwcHgnXHJcblx0XHRhbnN3ZXIuc2V0QXR0cmlidXRlIFwicmVhZG9ubHlcIiwgdHJ1ZVxyXG5cdFx0YW5zd2VyLnN0eWxlLnRleHRBbGlnbiA9ICdyaWdodCdcclxuXHRcdGFuc3dlci5zdHlsZS5vdmVyZmxvdyA9ICdoaWRkZW4nXHJcblx0XHRhbnN3ZXIud3JhcCA9ICdvZmYnXHJcblxyXG5cdFx0YW5zd2VyLnZhbHVlID0gbWFrZUFuc3dlcigpXHJcblxyXG5cdFx0ZW50ZXIub25zY3JvbGwgPSAoZSkgLT5cclxuXHRcdFx0YW5zd2VyLnNjcm9sbFRvcCA9IGVudGVyLnNjcm9sbFRvcFxyXG5cdFx0XHRhbnN3ZXIuc2Nyb2xsTGVmdCA9IGVudGVyLnNjcm9sbExlZnRcclxuXHRcdGFuc3dlci5vbnNjcm9sbCA9IChlKSAtPiBlLnByZXZlbnREZWZhdWx0KClcclxuXHJcblx0XHRAYWRkUm93IGVudGVyLGFuc3dlclxyXG5cclxuXHRcdGVudGVyLmFkZEV2ZW50TGlzdGVuZXIgXCJrZXl1cFwiLCAoZXZlbnQpIC0+XHJcblx0XHRcdGFuc3dlci5zY3JvbGxUb3AgPSBlbnRlci5zY3JvbGxUb3BcclxuXHRcdFx0YW5zd2VyLnNjcm9sbExlZnQgPSBlbnRlci5zY3JvbGxMZWZ0XHJcblx0XHRcdFxyXG5cdFx0XHRpZiBldmVudC5rZXlDb2RlIG5vdCBpbiBbMzMuLjQwXVxyXG5cdFx0XHRcdG1lbW9yeSA9IGVudGVyLnZhbHVlXHJcblx0XHRcdFx0YW5zd2VyLnZhbHVlID0gbWFrZUFuc3dlcigpXHJcblx0XHRcdFx0IyBzdG9yZURhdGEgbWVtb3J5XHJcblxyXG5cdHBhZ2UuYWRkQWN0aW9uICdDbGVhcicsIC0+IFxyXG5cdFx0bWVtb3J5ID0gXCJcIlxyXG5cdFx0c3RvcmVBbmRHb3RvIG1lbW9yeSxwYWdlXHJcblxyXG5cdHBhZ2UuYWRkQWN0aW9uICdTYW1wbGVzJywgLT5cclxuXHRcdGlmIGNvbmZpZy5sYW5ndWFnZSA9PSAwIFxyXG5cdFx0XHRtZW1vcnkgPSBcIlwiXCJcclxuIyBDb2ZmZWVzY3JpcHRcclxuMiszXHJcblxyXG5zdHLDpGNrYSA9IDE1MFxyXG50aWQgPSA2XHJcbnRpZFxyXG5zdHLDpGNrYS90aWRcclxuMjUgPT0gc3Ryw6Rja2EvdGlkIFxyXG4zMCA9PSBzdHLDpGNrYS90aWRcclxuXHJcbiMgU3RyaW5nXHJcbmEgPSBcIlZvbHZvXCIgXHJcbjUgPT0gYS5sZW5ndGhcclxuJ2wnID09IGFbMl1cclxuXHJcbiMgTWF0aFxyXG41ID09IHNxcnQgMjUgXHJcblxyXG4jIERhdGVcclxuYyA9IG5ldyBEYXRlKCkgXHJcbmMuZ2V0RnVsbFllYXIoKVxyXG5jLmdldEhvdXJzKClcclxuXHJcbiMgQXJyYXlcclxubnVtYmVycyA9IFsxLDIsM10gXHJcbjIgPT0gbnVtYmVyc1sxXVxyXG5udW1iZXJzLnB1c2ggNDdcclxuNCA9PSBudW1iZXJzLmxlbmd0aFxyXG5udW1iZXJzIFxyXG40NyA9PSBudW1iZXJzLnBvcCgpXHJcbjMgPT0gbnVtYmVycy5sZW5ndGhcclxubnVtYmVyc1xyXG5hc3NlcnQgWzAsMSw0LDksMTYsMjUsMzYsNDksNjQsODFdLCAoeCp4IGZvciB4IGluIHJhbmdlIDEwKVxyXG5cclxuIyBPYmplY3RcclxucGVyc29uID0ge2ZuYW1uOidEYXZpZCcsIGVuYW1uOidMYXJzc29uJ31cclxuJ0RhdmlkJyA9PSBwZXJzb25bJ2ZuYW1uJ11cclxuJ0xhcnNzb24nID09IHBlcnNvbi5lbmFtblxyXG5cclxuIyBmdW5jdGlvbnMgKGVuYmFydCBvbmUgbGluZXJzIHRpbGzDpXRuYSEpXHJcbmt2YWRyYXQgPSAoeCkgLT4geCp4XHJcbjI1ID09IGt2YWRyYXQgNVxyXG5cclxuIyBmZWx1cHBza2F0dG5pbmcgdmlkIGFudsOkbmRhbmRlIGF2IGLDpHJpbmcgb2NoIGF2c3TDpW5kXHJcbmFyZWEgPSAoYjEsYjIscjEscjIpIC0+IChyMipyMiAtIHIxKnIxKSAqIE1hdGguUEkgKiAoYjItYjEpLzM2MCAgXHJcbjE3LjY3MTQ1ODY3NjQ0MjU4NyA9PSBhcmVhIDkwLDkxLDIwMCwyMDVcclxuMzUuMTI0NzUxMTk2Mzg1ODggID09IGFyZWEgOTAsOTEsNDAwLDQwNVxyXG42OS44MTMxNzAwNzk3NzMxNyAgPT0gYXJlYSA5MCw5MiwxOTUsMjA1XHJcbjEzOS42MjYzNDAxNTk1NDYzNCA9PSBhcmVhIDkwLDkyLDM5NSw0MDVcclxuXHJcbnNlcmlhbCA9IChhLGIpIC0+IGErYlxyXG4yID09IHNlcmlhbCAxLDFcclxuNSA9PSBzZXJpYWwgMiwzXHJcblxyXG5wYXJhbGxlbCA9IChhLGIpIC0+IGEqYi8oYStiKVxyXG4wLjUgPT0gcGFyYWxsZWwgMSwxXHJcbjEuMiA9PSBwYXJhbGxlbCAyLDNcclxuXHJcbmZhayA9ICh4KSAtPiBpZiB4PT0wIHRoZW4gMSBlbHNlIHggKiBmYWsoeC0xKVxyXG4zNjI4ODAwID09IGZhayAxMFxyXG5cclxuZmliID0gKHgpIC0+IGlmIHg8PTAgdGhlbiAxIGVsc2UgZmliKHgtMSkgKyBmaWIoeC0yKSBcclxuMSA9PSBmaWIgMFxyXG4yID09IGZpYiAxXHJcbjUgPT0gZmliIDNcclxuOCA9PSBmaWIgNFxyXG4xMyA9PSBmaWIgNVxyXG4yMSA9PSBmaWIgNlxyXG5cclxuXCJcIlwiXHJcblx0XHRlbHNlICMgSmF2YXNjcmlwdFxyXG5cdFx0XHRtZW1vcnkgPSBcIlwiXCIgXHJcbi8vIEphdmFzY3JpcHRcclxuMiszXHJcblxyXG5kaXN0YW5jZSA9IDE1MFxyXG5zZWNvbmRzID0gNlxyXG5zZWNvbmRzXHJcbmRpc3RhbmNlL3NlY29uZHNcclxuMjUgPT0gZGlzdGFuY2Uvc2Vjb25kc1xyXG4zMCA9PSBkaXN0YW5jZS9zZWNvbmRzXHJcblxyXG4vLyBTdHJpbmdcclxuYSA9IFwiVm9sdm9cIiBcclxuNSA9PSBhLmxlbmd0aFxyXG4nbCcgPT0gYVsyXVxyXG5cclxuLy8gTWF0aFxyXG41ID09IHNxcnQoMjUpXHJcblxyXG4vLyBEYXRlXHJcbmMgPSBuZXcgRGF0ZSgpIFxyXG5jLmdldEZ1bGxZZWFyKClcclxuYy5nZXRIb3VycygpXHJcblxyXG4vLyBBcnJheVxyXG5udW1iZXJzID0gWzEsMiwzXSBcclxuMiA9PSBudW1iZXJzWzFdXHJcbm51bWJlcnMucHVzaCg0NylcclxuNCA9PSBudW1iZXJzLmxlbmd0aFxyXG5udW1iZXJzIFxyXG40NyA9PSBudW1iZXJzLnBvcCgpXHJcbjMgPT0gbnVtYmVycy5sZW5ndGhcclxubnVtYmVyc1xyXG5hc3NlcnQoWzAsMSw0LDksMTYsMjUsMzYsNDksNjQsODFdLCByYW5nZSgxMCkubWFwKHggPT4geCp4KSlcclxuXHJcbi8vIE9iamVjdFxyXG5wZXJzb24gPSB7Zm5hbW46J0RhdmlkJywgZW5hbW46J0xhcnNzb24nfVxyXG4nRGF2aWQnID09IHBlcnNvblsnZm5hbW4nXVxyXG4nTGFyc3NvbicgPT0gcGVyc29uLmVuYW1uXHJcblxyXG4vLyBmdW5jdGlvbnMgKG9ubHkgb25lIGxpbmVycylcclxua3ZhZHJhdCA9ICh4KSA9PiB4KnhcclxuMjUgPT0ga3ZhZHJhdCg1KVxyXG5cclxuc2VyaWFsID0gKGEsYikgPT4gYStiXHJcbjIgPT0gc2VyaWFsKDEsMSlcclxuNSA9PSBzZXJpYWwoMiwzKVxyXG5cclxucGFyYWxsZWwgPSAoYSxiKSA9PiBhKmIvKGErYilcclxuMC41ID09IHBhcmFsbGVsKDEsMSlcclxuMS4yID09IHBhcmFsbGVsKDIsMylcclxuXHJcbmZhayA9ICh4KSA9PiAoeD09MCA/IDEgOiB4ICogZmFrKHgtMSkpXHJcbjM2Mjg4MDAgPT0gZmFrKDEwKVxyXG5cclxuZmliID0gKHgpID0+IHg8PTAgPyAxIDogZmliKHgtMSkgKyBmaWIoeC0yKVxyXG4xID09IGZpYigwKVxyXG4yID09IGZpYigxKVxyXG41ID09IGZpYigzKVxyXG44ID09IGZpYig0KVxyXG4xMyA9PSBmaWIoNSlcclxuMjEgPT0gZmliKDYpXHJcblxyXG5cIlwiXCJcclxuXHRcdCMgc3RvcmVBbmRHb3RvIG1lbW9yeSxwYWdlXHJcblx0XHRlbmNvZGUoKVxyXG5cclxuXHRwYWdlLmFkZEFjdGlvbiAnUmVmZXJlbmNlJywgLT4gd2luZG93Lm9wZW4gXCJodHRwczovL3d3dy53M3NjaG9vbHMuY29tL2pzcmVmL2RlZmF1bHQuYXNwXCJcclxuXHJcblx0cGFnZS5hZGRBY3Rpb24gJ0hpZGUnLCAtPiBcclxuXHRcdHBhZ2UuZGlzcGxheSgpXHJcblxyXG5cdHBhZ2UuYWRkQWN0aW9uICdVUkwnLCAtPiBcclxuXHRcdGVuY29kZSgpXHJcblxyXG5cdHBhZ2UuYWRkQWN0aW9uIEFOR0xFX01PREVbY29uZmlnLmFuZ2xlTW9kZV0sIC0+IFxyXG5cdFx0Y29uZmlnLmFuZ2xlTW9kZSA9IDEgLSBjb25maWcuYW5nbGVNb2RlXHJcblx0XHRwYWdlLmFjdGlvbnNbNV1bMF0gPSBBTkdMRV9NT0RFW2NvbmZpZy5hbmdsZU1vZGVdXHJcblx0XHRtYWtlQW5zd2VyKClcclxuXHRcdHN0b3JlQW5kR290byBtZW1vcnkscGFnZVxyXG5cclxuXHRwYWdlLmFkZEFjdGlvbiBMQU5HVUFHRVtjb25maWcubGFuZ3VhZ2VdLCAtPiBcclxuXHRcdGNvbmZpZy5sYW5ndWFnZSA9IDEgLSBjb25maWcubGFuZ3VhZ2VcclxuXHRcdHBhZ2UuYWN0aW9uc1s2XVswXSA9IExBTkdVQUdFW2NvbmZpZy5sYW5ndWFnZV1cclxuXHRcdHN0b3JlQW5kR290byBtZW1vcnkscGFnZVxyXG5cclxuXHRwYWdlLmFkZEFjdGlvbiBESVNQTEFZX01PREVbY29uZmlnLmRpc3BsYXlNb2RlXSwgLT5cclxuXHRcdGNvbmZpZy5kaXNwbGF5TW9kZSA9IDEgLSBjb25maWcuZGlzcGxheU1vZGVcclxuXHRcdHBhZ2UuYWN0aW9uc1s3XVswXSA9IERJU1BMQVlfTU9ERVtjb25maWcuZGlzcGxheU1vZGVdXHJcblx0XHRzdG9yZUFuZEdvdG8gbWVtb3J5LHBhZ2VcclxuXHJcblx0cGFnZS5hZGRBY3Rpb24gJ0xlc3MnLCAtPiBcclxuXHRcdGlmIGNvbmZpZy5kaWdpdHM+MSB0aGVuIGNvbmZpZy5kaWdpdHMtLVxyXG5cdFx0c3RvcmVBbmRHb3RvIG1lbW9yeSxwYWdlXHJcblxyXG5cdHBhZ2UuYWRkQWN0aW9uICdNb3JlJywgLT4gXHJcblx0XHRpZiBjb25maWcuZGlnaXRzPDE3IHRoZW4gY29uZmlnLmRpZ2l0cysrXHJcblx0XHRzdG9yZUFuZEdvdG8gbWVtb3J5LHBhZ2VcclxuXHJcblx0cGFnZS5kaXNwbGF5KClcclxuIl19
//# sourceURL=c:\Lab\2018\008-Kalkyl\coffee\sketch.coffee