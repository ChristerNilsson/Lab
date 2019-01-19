'use strict';

var _get = function get(object, property, receiver) { if (object === null) object = Function.prototype; var desc = Object.getOwnPropertyDescriptor(object, property); if (desc === undefined) { var parent = Object.getPrototypeOf(object); if (parent === null) { return undefined; } else { return get(parent, property, receiver); } } else if ("value" in desc) { return desc.value; } else { var getter = desc.get; if (getter === undefined) { return undefined; } return getter.call(receiver); } };

var _createClass = function () { function defineProperties(target, props) { for (var i = 0; i < props.length; i++) { var descriptor = props[i]; descriptor.enumerable = descriptor.enumerable || false; descriptor.configurable = true; if ("value" in descriptor) descriptor.writable = true; Object.defineProperty(target, descriptor.key, descriptor); } } return function (Constructor, protoProps, staticProps) { if (protoProps) defineProperties(Constructor.prototype, protoProps); if (staticProps) defineProperties(Constructor, staticProps); return Constructor; }; }();

function _possibleConstructorReturn(self, call) { if (!self) { throw new ReferenceError("this hasn't been initialised - super() hasn't been called"); } return call && (typeof call === "object" || typeof call === "function") ? call : self; }

function _inherits(subClass, superClass) { if (typeof superClass !== "function" && superClass !== null) { throw new TypeError("Super expression must either be null or a function, not " + typeof superClass); } subClass.prototype = Object.create(superClass && superClass.prototype, { constructor: { value: subClass, enumerable: false, writable: true, configurable: true } }); if (superClass) Object.setPrototypeOf ? Object.setPrototypeOf(subClass, superClass) : subClass.__proto__ = superClass; }

function _classCallCheck(instance, Constructor) { if (!(instance instanceof Constructor)) { throw new TypeError("Cannot call a class as a function"); } }

// Generated by CoffeeScript 2.3.2
// Beskrivning av kolumner i kandidaturer.js:
var ANMDELTAGANDE,
    ANMKAND,
    ANT_BEST_VALS,
    Button,
    FOLKBOKFÖRINGSORT,
    FÖRKLARING,
    GAP,
    GILTIG,
    KANDIDATNUMMER,
    KÖN,
    LISTNUMMER,
    LetterButton,
    LetterPage,
    NAMN,
    ORDNING,
    PARTIBETECKNING,
    PARTIFÖRKORTNING,
    PARTIKOD,
    PERSONS_PER_PAGE,
    Page,
    PartiButton,
    PartiPage,
    PersonButton,
    PersonPage,
    SAMTYCKE,
    TypButton,
    TypPage,
    UtskriftPage,
    VALBAR_PÅ_VALDAGEN,
    VALKRETSKOD,
    VALKRETSNAMN,
    VALOMRÅDESKOD,
    VALOMRÅDESNAMN,
    VALSEDELSSTATUS,
    VALSEDELSUPPGIFT,
    VALTYP,
    VOTES,
    dictionary,
    draw,
    getParameters,
    gruppera,
    kommunkod,
    länskod,
    mousePressed,
    pages,
    qr,
    readDatabase,
    setup,
    spara,
    tree,
    utskrift,
    ÅLDER_PÅ_VALDAGEN,
    indexOf = [].indexOf;

VALTYP = 0;

VALOMRÅDESKOD = 1;

VALOMRÅDESNAMN = 2;

VALKRETSKOD = 3;

VALKRETSNAMN = 4;

PARTIBETECKNING = 5;

PARTIFÖRKORTNING = 6;

PARTIKOD = 7;

VALSEDELSSTATUS = 8;

LISTNUMMER = 9;

ORDNING = 10;

ANMKAND = 11;

ANMDELTAGANDE = 12;

SAMTYCKE = 13;

FÖRKLARING = 14;

KANDIDATNUMMER = 15;

NAMN = 16;

ÅLDER_PÅ_VALDAGEN = 17;

KÖN = 18;

FOLKBOKFÖRINGSORT = 19;

VALSEDELSUPPGIFT = 20;

ANT_BEST_VALS = 21;

VALBAR_PÅ_VALDAGEN = 22;

GILTIG = 23;

PERSONS_PER_PAGE = 32;

GAP = 2;

VOTES = 5;

kommunkod = null;

länskod = null;

tree = {};

//qrcode = null
qr = null;

dictionary = {};

// S -> Socialdemokraterna
// 01 -> Stockholms läns landsting
// 0180 -> Stockholm
pages = {};

utskrift = null;

gruppera = function gruppera(letters) {
  var n = arguments.length > 1 && arguments[1] !== undefined ? arguments[1] : 32;

  var count, group, letter, m, res;
  res = {};
  group = '';
  count = 0;
  for (letter in letters) {
    m = letters[letter];
    if (count + m <= n) {
      group += letter;
      count += m;
    } else {
      if (count > 0) {
        res[group] = count;
      }
      group = letter;
      count = m;
    }
  }
  if (count > 0) {
    res[group] = count;
  }
  return res;
};

assert({
  AB: 25,
  C: 14,
  D: 57
}, gruppera({
  A: 12,
  B: 13,
  C: 14,
  D: 57
}));

assert({
  ABDEF: 28,
  GH: 25
}, gruppera({
  A: 2,
  B: 1,
  D: 3,
  E: 10,
  F: 12,
  G: 13,
  H: 12
}));

assert({
  ABDEF: 28,
  NO: 32
}, gruppera({
  A: 2,
  B: 1,
  D: 3,
  E: 10,
  F: 12,
  N: 20,
  O: 12
}));

Page = function () {
  function Page(x5, y3, w1, h1) {
    var cols1 = arguments.length > 4 && arguments[4] !== undefined ? arguments[4] : 1;

    _classCallCheck(this, Page);

    this.x = x5;
    this.y = y3;
    this.w = w1;
    this.h = h1;
    this.cols = cols1;
    this.selected = null; // anger vilken knapp man klickat på
    this.buttons = [];
    this.active = true;
  }

  _createClass(Page, [{
    key: 'clear',
    value: function clear() {
      this.selected = null;
      return this.buttons = [];
    }
  }, {
    key: 'addButton',
    value: function addButton(button) {
      button.page = this;
      return this.buttons.push(button);
    }
  }, {
    key: 'draw',
    value: function draw() {
      var button, k, len, ref, results;
      if (this.active) {
        this.render();
        ref = this.buttons;
        results = [];
        for (k = 0, len = ref.length; k < len; k++) {
          button = ref[k];
          results.push(button.draw());
        }
        return results;
      }
    }
  }, {
    key: 'mousePressed',
    value: function mousePressed() {
      var button, k, len, ref, results;
      if (this.active) {
        ref = this.buttons;
        results = [];
        for (k = 0, len = ref.length; k < len; k++) {
          button = ref[k];
          if (button.inside(mouseX, mouseY)) {
            results.push(button.click());
          } else {
            results.push(void 0);
          }
        }
        return results;
      }
    }
  }]);

  return Page;
}();

PartiPage = function (_Page) {
  _inherits(PartiPage, _Page);

  function PartiPage() {
    _classCallCheck(this, PartiPage);

    return _possibleConstructorReturn(this, (PartiPage.__proto__ || Object.getPrototypeOf(PartiPage)).apply(this, arguments));
  }

  _createClass(PartiPage, [{
    key: 'render',
    value: function render() {
      if (this.selected !== null) {
        push();
        textAlign(CENTER, CENTER);
        textSize(20); // 0.5 * pages.personer.h/17
        text(dictionary[this.selected.title][0], pages.personer.x + pages.personer.w / 2, pages.personer.y + pages.personer.h / 34);
        return pop();
      }
    }
  }, {
    key: 'select',
    value: function select(partier) {
      var _this2 = this;

      var N, h, i, k, key, keys, len, results, w, x, y;
      N = 16;
      w = this.w / 2;
      h = this.h / (N + 1);
      keys = _.keys(partier);
      keys.sort(function (a, b) {
        return _.size(partier[b]) - _.size(partier[a]);
      });
      this.buttons = [];
      pages.partier.clear();
      pages.letters.clear();
      pages.personer.clear();
      results = [];
      for (i = k = 0, len = keys.length; k < len; i = ++k) {
        key = keys[i];
        x = this.x + w * Math.floor(i / N);
        y = this.y + h * (1 + i % N);
        results.push(function (key) {
          return _this2.addButton(new PartiButton(key, x, y, w - 2, h - 2, function () {
            this.page.selected = this;
            if (PERSONS_PER_PAGE < _.size(partier[key])) {
              pages.letters.makeLetters(this, partier[key]);
              pages.personer.buttons = [];
            } else {
              pages.letters.buttons = [];
              pages.personer.makePersons(this, partier[key]);
            }
            return pages.typ.clickPartiButton(this);
          }));
        }(key));
      }
      return results;
    }
  }]);

  return PartiPage;
}(Page);

LetterPage = function (_Page2) {
  _inherits(LetterPage, _Page2);

  function LetterPage() {
    _classCallCheck(this, LetterPage);

    return _possibleConstructorReturn(this, (LetterPage.__proto__ || Object.getPrototypeOf(LetterPage)).apply(this, arguments));
  }

  _createClass(LetterPage, [{
    key: 'render',
    value: function render() {}
  }, {
    key: 'makeFreq',
    value: function makeFreq(personer) {
      var k, key, keys, len, letter, person, res;
      res = {};
      keys = function () {
        var results;
        results = [];
        for (key in personer) {
          person = personer[key];
          results.push(person[NAMN]);
        }
        return results;
      }();
      keys.sort();
      for (k = 0, len = keys.length; k < len; k++) {
        key = keys[k];
        letter = key[0];
        res[letter] = res[letter] === void 0 ? 1 : res[letter] + 1;
      }
      return res;
    }
  }, {
    key: 'makeLetters',
    value: function makeLetters(button, personer) {
      var _this4 = this;

      var N, h, i, letters, n, ref, results, title, w, x, y;
      N = 16;
      h = this.h / (N + 1);
      w = this.w / 2;
      this.selected = button;
      this.buttons = [];
      print(_.size(personer));
      i = 0;
      ref = gruppera(this.makeFreq(personer));
      results = [];
      for (letters in ref) {
        n = ref[letters];
        x = this.x + w * Math.floor(i / N);
        y = this.y + h * (1 + i % N);
        title = letters.length === 1 ? letters : letters[0] + '-' + _.last(letters);
        (function (letters, title) {
          return _this4.addButton(new LetterButton(title, x, y, w - 2, h - 2, n, function () {
            this.page.selected = this;
            return pages.personer.clickLetterButton(this, letters, personer);
          }));
        })(letters, title);
        results.push(i++);
      }
      return results;
    }
  }]);

  return LetterPage;
}(Page);

PersonPage = function (_Page3) {
  _inherits(PersonPage, _Page3);

  function PersonPage() {
    _classCallCheck(this, PersonPage);

    return _possibleConstructorReturn(this, (PersonPage.__proto__ || Object.getPrototypeOf(PersonPage)).apply(this, arguments));
  }

  _createClass(PersonPage, [{
    key: 'render',
    value: function render() {}
  }, {
    key: 'clickLetterButton',
    value: function clickLetterButton(button, letters, personer) {
      var _this6 = this;

      var N, h, j, k, key, keys, len, person, ref, results, w, x, y;
      N = PERSONS_PER_PAGE;
      w = 0.3 * width;
      h = height / (PERSONS_PER_PAGE + 2);
      this.selected = button;
      button.pageNo = (button.pageNo + 1) % button.pages;
      this.buttons = [];
      keys = _.keys(personer);
      keys.sort(function (a, b) {
        if (a.slice(a.indexOf('-')) < b.slice(b.indexOf('-'))) {
          return -1;
        } else {
          return 1;
        }
      });
      j = 0;
      results = [];
      for (k = 0, len = keys.length; k < len; k++) {
        key = keys[k];
        person = personer[key];
        if (ref = person[NAMN][0], indexOf.call(letters, ref) >= 0) {
          if (Math.floor(j / N) === button.pageNo) {
            x = this.x;
            y = this.y + h * (2 + j % N);
            //print w,h
            (function (person) {
              return _this6.addButton(new PersonButton(person, x, y, w - 2, h - 2, function () {
                this.page.selected = this;
                return pages.typ.clickPersonButton(person);
              }));
            })(person);
          }
          results.push(j++);
        } else {
          results.push(void 0);
        }
      }
      return results;
    }
  }, {
    key: 'makePersons',
    value: function makePersons(button, personer) {
      var _this7 = this;

      var N, h, j, k, key, keys, len, person, results, w, x, y;
      N = 16;
      w = 0.3 * width;
      h = height / (PERSONS_PER_PAGE + 2);
      this.selected = button;
      this.buttons = [];
      keys = _.keys(personer);
      keys.sort(function (a, b) {
        if (a.slice(a.indexOf('-')) < b.slice(b.indexOf('-'))) {
          return -1;
        } else {
          return 1;
        }
      });
      results = [];
      for (j = k = 0, len = keys.length; k < len; j = ++k) {
        key = keys[j];
        person = personer[key];
        x = this.x;
        y = this.y + h * (2 + j % PERSONS_PER_PAGE);
        //print w,h
        results.push(function (person) {
          return _this7.addButton(new PersonButton(person, x, y, w - 2, h - 2, function () {
            this.page.selected = this;
            return pages.typ.clickPersonButton(person);
          }));
        }(person));
      }
      return results;
    }
  }]);

  return PersonPage;
}(Page);

TypPage = function (_Page4) {
  _inherits(TypPage, _Page4);

  function TypPage(x, y, w, h) {
    var cols = arguments.length > 4 && arguments[4] !== undefined ? arguments[4] : 1;

    _classCallCheck(this, TypPage);

    var _this8 = _possibleConstructorReturn(this, (TypPage.__proto__ || Object.getPrototypeOf(TypPage)).call(this, x, y, w, h, cols));

    _this8.sbuttons = [];
    h = height / 51;
    _this8.yoff = [_this8.y + 0, _this8.y + 16 * h, _this8.y + 32 * h, _this8.y + 48 * h];
    //print 'yoff',@yoff
    _this8.selectedPersons = {
      R: [],
      L: [],
      K: []
    };
    _this8.addButton(new TypButton('R', 'Riksdag', _this8.x, _this8.yoff[0], _this8.w - 2, 3 * h - 2, function () {
      pages.partier.select(tree['R']);
      return this.page.selected = this;
    }));
    _this8.addButton(new TypButton('L', dictionary[länskod], _this8.x, _this8.yoff[1], _this8.w - 2, 3 * h - 2, function () {
      pages.partier.select(tree['L']);
      return this.page.selected = this;
    }));
    _this8.addButton(new TypButton('K', dictionary[kommunkod], _this8.x, _this8.yoff[2], _this8.w - 2, 3 * h - 2, function () {
      pages.partier.select(tree['K']);
      return this.page.selected = this;
    }));
    _this8.addButton(new Button('Utskrift', _this8.x, _this8.yoff[3], _this8.w / 2 - 2, 3 * h - 2, function () {
      var qrcode;
      //resizeCanvas windowWidth, windowHeight-256			
      pages.utskrift.active = true;
      qr = this.page.getQR();
      return qrcode = new QRCode(document.getElementById("qrcode"), {
        text: qr,
        width: 256,
        height: 256,
        colorDark: "#000000",
        colorLight: "#ffffff",
        correctLevel: QRCode.CorrectLevel.L // Low Medium Q High
      });
    }));
    _this8.addButton(new Button('Rensa', _this8.x + _this8.w / 2, _this8.yoff[3], _this8.w / 2 - 2, 3 * h - 2, function () {
      this.page.selectedPersons = {
        R: [],
        L: [],
        K: []
      };
      this.page.sbuttons = [];
      pages.typ.selected = null;
      pages.partier.clear();
      pages.letters.clear();
      pages.personer.clear();
      return qr = '';
    }));
    return _this8;
  }

  _createClass(TypPage, [{
    key: 'addsButton',
    value: function addsButton(button) {
      button.page = this;
      return this.sbuttons.push(button);
    }
  }, {
    key: 'getQR',
    value: function getQR() {
      var i, k, len, person, persons, ref, s, slump, typ;
      s = kommunkod;
      slump = int(random(1000000));
      s += slump.toString().padStart(6, 0); // to increase probability of uniqueness 
      for (typ in this.selectedPersons) {
        persons = this.selectedPersons[typ];
        ref = range(VOTES);
        for (k = 0, len = ref.length; k < len; k++) {
          i = ref[k];
          if (i < persons.length) {
            person = persons[i];
            s += person[KANDIDATNUMMER].padStart(6, '0');
          } else {
            s += '000000';
          }
        }
      }
      assert(s.length, 4 + 6 + 15 * 6); // 100
      return s;
    }
  }, {
    key: 'render',
    value: function render() {
      var x, y;
      if (this.selected !== null) {
        push();
        textAlign(CENTER, CENTER);
        textSize(20);
        sc();
        x = pages.partier.x + pages.partier.w / 2;
        y = pages.partier.y + pages.partier.h / 34;

        if (this.selected.typ === 'R') {
          text('Riksdag', x, y);
        }
        if (this.selected.typ === 'L') {
          text(dictionary[länskod], x, y);
        }
        if (this.selected.typ === 'K') {
          text(dictionary[kommunkod], x, y);
        }
        pop();
      }
      return this.showSelectedPersons(); // 750,100-20
    }
  }, {
    key: 'clickDelete',
    value: function clickDelete(typ, index) {
      this.selectedPersons[typ].splice(index, 1);
      return this.createSelectButtons();
    }
  }, {
    key: 'clickSwap',
    value: function clickSwap(typ, index) {
      var arr;
      arr = this.selectedPersons[typ];
      var _ref = [arr[index - 1], arr[index]];
      arr[index] = _ref[0];
      arr[index - 1] = _ref[1];

      return this.createSelectButtons();
    }
  }, {
    key: 'createSelectButtons',
    value: function createSelectButtons() {
      var d, h, i, index, person, persons, ref, results, typ, w, x1, x2, y1, y2;
      this.sbuttons = [];
      h = height / 30;
      w = this.w;
      d = 0.032 * height;
      ref = this.selectedPersons;
      results = [];
      for (typ in ref) {
        persons = ref[typ];
        index = "RLK".indexOf(typ);
        results.push(function () {
          var _this9 = this;

          var k, len, results1;
          results1 = [];
          for (i = k = 0, len = persons.length; k < len; i = ++k) {
            person = persons[i];
            x1 = this.x + 0.90 * this.w;
            x2 = this.x + 0.95 * this.w;
            y1 = this.yoff[index] + 0.061 * height + i * h;
            y2 = this.yoff[index] + 0.061 * height + i * h - h / 2;
            results1.push(function (typ, i) {
              if (i > 0) {
                _this9.addsButton(new Button('byt', x1, y2, d, d, function () {
                  return _this9.clickSwap(typ, i);
                }));
              }
              return _this9.addsButton(new Button(' x ', x2, y1, d, d, function () {
                return _this9.clickDelete(typ, i);
              }));
            }(typ, i));
          }
          return results1;
        }.call(this));
      }
      return results;
    }
  }, {
    key: 'clickPersonButton',
    value: function clickPersonButton(person) {
      var i, k, len, p, persons;
      persons = this.selectedPersons[this.selected.typ];
      // Finns partiet redan? I så fall: ersätt denna person med den nya.
      for (i = k = 0, len = persons.length; k < len; i = ++k) {
        p = persons[i];
        if (p[PARTIKOD] === person[PARTIKOD]) {
          persons[i] = person;
          return;
        }
      }
      if (persons.length < VOTES) {
        persons.push(person);
        return this.createSelectButtons();
      }
    }
  }, {
    key: 'clickPartiButton',
    value: function clickPartiButton(button) {
      var i, k, len, p, person, persons;
      persons = this.selectedPersons[this.selected.typ];
      // Finns partiet redan? I så fall: ersätt denna person med den nya.
      person = [];
      person[NAMN] = dictionary[button.title][0];
      person[PARTIKOD] = dictionary[button.title][1];
      person[PARTIFÖRKORTNING] = button.title;
      person[KANDIDATNUMMER] = '99' + person[PARTIKOD].padStart(4, '0');
      for (i = k = 0, len = persons.length; k < len; i = ++k) {
        p = persons[i];
        if (p[PARTIKOD] === person[PARTIKOD]) {
          persons[i] = person;
          return;
        }
      }
      if (persons.length < VOTES) {
        persons.push(person);
        return this.createSelectButtons();
      }
    }
  }, {
    key: 'showSelectedPersons',
    value: function showSelectedPersons() {
      var button, i, j, k, l, len, len1, len2, o, person, ref, ref1, ref2, results, typ, y, y0;
      push();
      textAlign(LEFT, CENTER);
      ref = 'RLK';
      for (i = k = 0, len = ref.length; k < len; i = ++k) {
        typ = ref[i];
        sc();
        sw(1);
        rectMode(CORNER);
        y0 = this.yoff[i];
        if (i === 0) {
          fc(1, 1, 0.5);
        }
        if (i === 1) {
          fc(0.5, 0.75, 1);
        }
        if (i === 2) {
          fc(1);
        }
        rect(this.x, y0 + 3 / 51 * height - 1, this.w - 2, 13 / 51 * height);
        fc(0);
        sc();
        sw(0);
        ref1 = this.selectedPersons[typ];
        for (j = l = 0, len1 = ref1.length; l < len1; j = ++l) {
          person = ref1[j];
          y = y0 + 80 + 40 * j;
          textSize(20);
          text(j + 1 + '  ' + person[PARTIFÖRKORTNING] + ' - ' + person[NAMN], this.x + 10, y);
        }
      }
      pop();
      ref2 = this.sbuttons;
      results = [];
      for (o = 0, len2 = ref2.length; o < len2; o++) {
        button = ref2[o];
        results.push(button.draw());
      }
      return results;
    }
  }, {
    key: 'mousePressed',
    value: function mousePressed() {
      var button, k, len, ref;
      ref = this.sbuttons;
      for (k = 0, len = ref.length; k < len; k++) {
        button = ref[k];
        if (button.inside(mouseX, mouseY)) {
          button.click();
        }
      }
      return _get(TypPage.prototype.__proto__ || Object.getPrototypeOf(TypPage.prototype), 'mousePressed', this).call(this);
    }
  }]);

  return TypPage;
}(Page);

UtskriftPage = function (_Page5) {
  _inherits(UtskriftPage, _Page5);

  function UtskriftPage(x, y, w, h) {
    _classCallCheck(this, UtskriftPage);

    var _this10 = _possibleConstructorReturn(this, (UtskriftPage.__proto__ || Object.getPrototypeOf(UtskriftPage)).call(this, x, y, w, h));

    _this10.selected = null;
    _this10.buttons = [];
    _this10.addButton(new Button('Utskrift', 100, height - 382, 270, 45, function () {
      return window.print();
    }));
    _this10.addButton(new Button('Fortsätt', 400, height - 382, 270, 45, function () {
      var myNode;
      myNode = document.getElementById("qrcode");
      myNode.innerHTML = '';
      pages.utskrift.active = false;
      return pages.typ.createSelectButtons();
    }));
    return _this10;
  }

  _createClass(UtskriftPage, [{
    key: 'showSelectedPersons',
    value: function showSelectedPersons() {
      var i, j, k, l, len, len1, person, ref, ref1, typ, y;
      push();
      textAlign(LEFT, CENTER);
      fc(0);
      sc();
      textSize(20);
      ref = 'RLK';
      for (i = k = 0, len = ref.length; k < len; i = ++k) {
        typ = ref[i];
        ref1 = pages.typ.selectedPersons[typ];
        for (j = l = 0, len1 = ref1.length; l < len1; j = ++l) {
          person = ref1[j];
          y = [0, 260, 520][i] + 50 + 40 * j;
          text(j + 1 + '  ' + person[PARTIFÖRKORTNING] + ' - ' + person[NAMN], width / 2, y);
        }
      }
      return pop();
    }
  }, {
    key: 'render',
    value: function render() {
      textAlign(LEFT, CENTER);
      bg(1);
      fc(0);
      text(qr, 20, height - 310);
      text('Riksdag', 10, 50 + 0);
      text(dictionary[länskod], 10, 50 + 260);
      text(dictionary[kommunkod], 10, 50 + 520);
      this.showSelectedPersons();
      return pages.typ.sbuttons = [];
    }
  }]);

  return UtskriftPage;
}(Page);

Button = function () {
  function Button(title1, x5, y3, w1, h1) {
    var click1 = arguments.length > 5 && arguments[5] !== undefined ? arguments[5] : function () {};

    _classCallCheck(this, Button);

    this.title = title1;
    this.x = x5;
    this.y = y3;
    this.w = w1;
    this.h = h1;
    this.click = click1;
    this.ts = 0.5 * this.h;
  }

  _createClass(Button, [{
    key: 'draw',
    value: function draw() {
      fc(0.5);
      push();
      sc();
      //sw 1
      rect(this.x, this.y, this.w, this.h);
      pop();
      textSize(this.ts);
      textAlign(CENTER, CENTER);
      if (this.page.selected === this) {
        fc(1, 1, 0);
      } else {
        fc(1);
      }
      return text(this.title, this.x + this.w / 2, this.y + this.h / 2);
    }
  }, {
    key: 'inside',
    value: function inside() {
      return this.x < mouseX && mouseX < this.x + this.w && this.y < mouseY && mouseY < this.y + this.h;
    }
  }]);

  return Button;
}();

PartiButton = function (_Button) {
  _inherits(PartiButton, _Button);

  function PartiButton() {
    _classCallCheck(this, PartiButton);

    return _possibleConstructorReturn(this, (PartiButton.__proto__ || Object.getPrototypeOf(PartiButton)).apply(this, arguments));
  }

  _createClass(PartiButton, [{
    key: 'draw',
    value: function draw() {
      fc(0.5);
      rect(this.x, this.y, this.w, this.h);
      //textSize if @title in 'S C MP L M V SD KD'.split ' ' then 28 else 20
      textSize(this.ts);
      textAlign(CENTER, CENTER);
      if (this.page.selected === this) {
        fc(1, 1, 0);
      } else {
        fc(1);
      }
      return text(this.title, this.x + this.w / 2, this.y + this.h / 2);
    }
  }]);

  return PartiButton;
}(Button);

LetterButton = function (_Button2) {
  _inherits(LetterButton, _Button2);

  function LetterButton(title, x, y, w, h, antal, click) {
    _classCallCheck(this, LetterButton);

    var _this12 = _possibleConstructorReturn(this, (LetterButton.__proto__ || Object.getPrototypeOf(LetterButton)).call(this, title, x, y, w, h, click));

    _this12.antal = antal;
    _this12.pageNo = -1;
    _this12.pages = 1 + Math.floor(_this12.antal / PERSONS_PER_PAGE);
    if (_this12.antal % PERSONS_PER_PAGE === 0) {
      _this12.pages--;
    }
    return _this12;
  }

  _createClass(LetterButton, [{
    key: 'draw',
    value: function draw() {
      fc(0.5);
      rect(this.x, this.y, this.w, this.h);
      textSize(this.ts);
      textAlign(CENTER, CENTER);
      if (this.page.selected === this) {
        fc(1, 1, 0);
      } else {
        fc(1);
      }
      text(this.title, this.x + this.w / 2, this.y + this.h / 2);
      push();
      this.pageIndicator();
      return pop();
    }
  }, {
    key: 'pageIndicator',
    value: function pageIndicator() {
      var dx, i, k, len, ref, results;
      if (this.pages <= 1) {
        return;
      }
      dx = Math.floor(this.w / (this.pages + 1));
      ref = range(this.pages);
      results = [];
      for (k = 0, len = ref.length; k < len; k++) {
        i = ref[k];
        if (i === this.pageNo) {
          fc(1);
        } else {
          fc(0);
        }
        results.push(circle(this.x + (i + 1) * dx, this.y + 0.85 * this.h, 3));
      }
      return results;
    }
  }]);

  return LetterButton;
}(Button);

PersonButton = function (_Button3) {
  _inherits(PersonButton, _Button3);

  function PersonButton(person, x, y, w, h) {
    var click = arguments.length > 5 && arguments[5] !== undefined ? arguments[5] : function () {};

    _classCallCheck(this, PersonButton);

    var title;
    title = person[NAMN] + ' - ' + person[VALSEDELSUPPGIFT];

    var _this13 = _possibleConstructorReturn(this, (PersonButton.__proto__ || Object.getPrototypeOf(PersonButton)).call(this, title, x, y, w, h, click));

    _this13.person = person;
    return _this13;
  }

  _createClass(PersonButton, [{
    key: 'draw',
    value: function draw() {
      fc(0.5);
      rect(this.x, this.y, this.w, this.h);
      textSize(this.ts);
      textAlign(LEFT, CENTER);
      fc(1);
      return text(this.title, this.x + GAP, this.y + 2 + this.h / 2);
    }
  }]);

  return PersonButton;
}(Button);

TypButton = function (_Button4) {
  _inherits(TypButton, _Button4);

  function TypButton(typ1, title, x, y, w, h) {
    var click = arguments.length > 6 && arguments[6] !== undefined ? arguments[6] : function () {};

    _classCallCheck(this, TypButton);

    var _this14 = _possibleConstructorReturn(this, (TypButton.__proto__ || Object.getPrototypeOf(TypButton)).call(this, title, x, y, w, h, click));

    _this14.typ = typ1;
    return _this14;
  }

  return TypButton;
}(Button);

spara = function spara(lista, key, value) {
  var a, current, k, len, name;
  current = tree;
  for (k = 0, len = lista.length; k < len; k++) {
    name = lista[k];
    a = current[name];
    if (a === void 0) {
      current[name] = {};
    }
    current = current[name];
  }
  return current[key] = value;
};

readDatabase = function readDatabase() {
  var arr, cells, k, knr, kommun, len, line, lines, namn, område, områdeskod, parti, partikoder, valtyp;

  var _getParameters = getParameters();

  kommun = _getParameters.kommun;

  print(kommun);
  kommunkod = kommun;
  if (!kommunkod) {
    kommunkod = '0180';
  }
  länskod = kommunkod.slice(0, 2);
  partikoder = {};
  //partier = {}
  lines = db.split('\n');
  //clowner = getClowner lines
  for (k = 0, len = lines.length; k < len; k++) {
    line = lines[k];
    cells = line.split(';');
    valtyp = cells[VALTYP];
    områdeskod = cells[VALOMRÅDESKOD];
    område = cells[VALOMRÅDESNAMN];
    parti = cells[PARTIFÖRKORTNING];
    //if parti=='' then parti = cells[PARTIKOD]
    knr = cells[KANDIDATNUMMER];
    namn = cells[NAMN];
    partikoder[cells[PARTIKOD]] = parti;
    //if knr in clowner then continue
    if (namn === void 0) {
      continue;
    }
    if (parti === '') {
      continue;
    }
    dictionary[parti] = [cells[PARTIBETECKNING], cells[PARTIKOD]];
    dictionary[områdeskod] = område; // hanterar både kommun och landsting
    // S -> ['Socialdemokraterna','1234']
    // 01 -> '01 - Stockholms läns landsting'
    // 0180 -> Stockholm
    arr = namn.split(', ');
    if (arr.length === 2) {
      namn = arr[1] + ' ' + arr[0];
      cells[NAMN] = namn;
    }
    if (parti === '' || namn === '[inte lämnat förklaring]') {
      continue;
    }
    if (valtyp === 'R') {
      spara([valtyp, parti], knr + '-' + namn, cells);
    }
    if (valtyp === 'L' && områdeskod === länskod) {
      spara([valtyp, parti], knr + '-' + namn, cells);
    }
    if (valtyp === 'K' && områdeskod === kommunkod) {
      spara([valtyp, parti], knr + '-' + namn, cells);
    }
  }
  print(dictionary);
  return print(partikoder);
};

//print partier
//for key,parti of partier
//	if 1 < _.size parti then print key,parti
getParameters = function getParameters() {
  var h = arguments.length > 0 && arguments[0] !== undefined ? arguments[0] : window.location.href;

  var arr, f;
  h = decodeURI(h);
  arr = h.split('?');
  if (arr.length !== 2) {
    return {};
  }
  if (arr[1] === '') {
    return {};
  }
  return _.object(function () {
    var k, len, ref, results;
    ref = arr[1].split('&');
    results = [];
    for (k = 0, len = ref.length; k < len; k++) {
      f = ref[k];
      results.push(f.split('='));
    }
    return results;
  }());
};

setup = function setup() {
  var x0, x1, x2, x3, x4;
  createCanvas(windowWidth, windowHeight);
  readDatabase();
  print(tree);
  x0 = 0;
  x1 = 0.2 * width;
  x2 = 0.27 * width;
  x3 = 0.57 * width;
  x4 = 1.00 * width;
  pages.typ = new TypPage(x3, 0, x4 - x3, height);
  pages.partier = new PartiPage(0, 0, x1 - x0, height);
  pages.letters = new LetterPage(x1, 0, x2 - x1, height);
  pages.personer = new PersonPage(x2, 0, x3 - x2, height);
  pages.utskrift = new UtskriftPage(0, 0, x4, height);
  pages.utskrift.active = false;
  sc();
  textAlign(CENTER, CENTER);
  return textSize(20);
};

draw = function draw() {
  var key, page, results;
  bg(0);
  if (pages.utskrift.active) {
    return pages.utskrift.draw();
  } else {
    results = [];
    for (key in pages) {
      page = pages[key];
      results.push(page.draw());
    }
    return results;
  }
};

mousePressed = function mousePressed() {
  var key, page, results;
  results = [];
  for (key in pages) {
    page = pages[key];
    results.push(page.mousePressed());
  }
  return results;
};

//windowResized = -> resizeCanvas windowWidth, windowHeight

//#####

// constructor : (@render = ->) ->
// 	super()
// 	@rbuttons = [] # RKL
// 	@init()

// radd : (button) -> @rbuttons.push button
// padd : (button) -> @pbuttons.push button
// ladd : (button) -> @lbuttons.push button
// kadd : (button) -> @kbuttons.push button
// sadd : (button) -> @sbuttons.push button

// allButtons : -> @pbuttons.concat @lbuttons.concat @kbuttons.concat @sbuttons.concat @rbuttons 

// init : ->
// 	@pbuttons = [] # parti
// 	@lbuttons = [] # letters
// 	@kbuttons = [] # kandidater
// 	@sbuttons = [] # Del, Up, Down

// draw : ->
// 	bg 0
// 	@render()
// 	for button in @allButtons()
// 		button.draw()

// mousePressed : ->
// 	for button in @allButtons()
// 		if button.inside() then button.click()

// class Page1 extends Page

// antal = (letter,personer) ->
// 	lst = (1 for key,person of personer when letter == person[NAMN][0])
// 	lst.length

// getClowner = (lines) -> # tag fram alla personer som representerar flera partier i samma valtyp
// 	res = []
// 	partier = {}
// 	for line in lines 
// 		cells = line.split ';'
// 		knr = cells[KANDIDATNUMMER]
// 		if partier[knr] == undefined then partier[knr] = {}
// 		partier[knr][cells[PARTIKOD]] = cells
// 	for knr,lista of partier
// 		if 1 == _.size lista then continue
// 		klr = {R:0,K:0,L:0}
// 		for key,item of lista
// 			klr[item[VALTYP]]++
// 		if klr.R>1 or klr.K>1 or klr.L>1 then res.push knr
// 	print 'Borttagna kandidater pga flera partier i samma valtyp: ',res
// 	res
//# sourceMappingURL=sketch.js.map
