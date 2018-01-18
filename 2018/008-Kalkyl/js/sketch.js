'use strict';

// Generated by CoffeeScript 2.0.3
var KEY, makeAnswer, memory, page, setup, transpile;

KEY = '008B';

memory = null;

page = null;

transpile = function transpile(line) {
  var body, name, p, parameters, q;
  p = line.indexOf('(');
  q = line.indexOf('=');
  if (p >= 0 && p < q) {
    name = line.slice(0, p);
    parameters = line.slice(p, q);
    body = line.slice(q + 1);
    return name + ' = function ' + parameters + ' {return ' + body + '}';
  }
  return line;
};

makeAnswer = function makeAnswer() {
  var e, i, len, line, message, ref, res, value;
  res = '';
  ref = memory.split("\n");
  for (i = 0, len = ref.length; i < len; i++) {
    line = ref[i];
    line = transpile(line);
    message = '';
    value = void 0;
    try {
      try {
        value = eval('window.' + line);
      } catch (error) {
        value = eval(line);
      }
    } catch (error) {
      e = error;
      message = 'ERROR: ' + e.message;
    }
    if (message === '' && value !== void 0 && !_.isFunction(value)) {
      res += JSON.stringify(value);
    } else {
      res += message;
    }
    res += "\n";
  }
  return res;
};

setup = function setup() {
  memory = fetchData();
  page = new Page(0, function () {
    var answer, enter;
    this.table.innerHTML = "";
    enter = makeTextArea();
    enter.style.left = '0px';
    enter.focus();
    enter.value = memory;
    answer = makeTextArea();
    answer.style.left = '50%';
    answer.setAttribute("readonly", true);
    answer.value = makeAnswer();
    enter.onscroll = function (e) {
      answer.scrollTop = enter.scrollTop;
      return answer.scrollLeft = enter.scrollLeft;
    };
    answer.onscroll = function (e) {
      return e.preventDefault();
    };
    this.addRow(enter, answer);
    return enter.addEventListener("keyup", function (event) {
      memory = enter.value;
      answer.value = makeAnswer();
      return storeData(memory);
    });
  });
  page.addAction('Hide', function () {
    return page.display();
  });
  page.addAction('Clear', function () {
    memory = "";
    return storeAndGoto(memory, page);
  });
  page.addAction('Samples', function () {
    memory = "2+3\n\nsträcka = 150\ntid = 6\ntid\nsträcka/tid\n25 == sträcka/tid \n30 == sträcka/tid\n\n// String\na = \"Volvo\" \n5 == a.length\n'l' == a[2]\n\n// Math\n5 == sqrt(25) \n\n// Date\nc = new Date() \n2018 == c.getFullYear()\n\n// Array\nnumbers = [1,2,3] \n2 == numbers[1]\nnumbers.push(47)\n4 == numbers.length\nnumbers \n47 == numbers.pop()\n3 == numbers.length\nnumbers\n\n// Object\nperson = {fnamn:'David', enamn:'Larsson'}\n'David' == person['fnamn']\n'Larsson' == person.enamn\n\n// functions\nkvadrat(x)=x*x\n25 == kvadrat(5)\n\nserial(a,b) = a+b\n2 == serial(1,1)\n5 == serial(2,3)\n\nparallel(a,b) = a*b/(a+b)\n0.5 == parallel(1,1)\n1.2 == parallel(2,3)\n\nfak(x) = x==0 ? 1 : x * fak(x-1)\n3628800 == fak(10)\n\nfib(x) = x<=0 ? 1 : fib(x-1)+fib(x-2) \n1 == fib(0)\n2 == fib(1)\n5 == fib(3)\n8 == fib(4)\n13 == fib(5)\n21 == fib(6)\n// Extra rader pga Android\n// 2\n// 3\n// 4\n// 5";
    return storeAndGoto(memory, page);
  });
  page.addAction('Reference', function () {
    return window.open("https://www.w3schools.com/jsref/default.asp");
  });
  return page.display();
};
//# sourceMappingURL=sketch.js.map
