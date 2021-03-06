'use strict';

// Generated by CoffeeScript 2.3.2
var PersonButton,
    PersonPage,
    indexOf = [].indexOf;

PersonPage = function () {
  var N;

  class PersonPage extends Page {
    render() {
      var namn, pp, rlk, s, selected;
      this.bg(0);
      selected = pages.partier.selected;
      pp = pages.personer;
      if (selected !== null) {
        push();
        textAlign(LEFT, CENTER);
        textSize(0.4 * pp.h / (N + 1));
        rlk = pages.rlk.selected.rlk;
        namn = dbPartier[rlk][selected.partikod][PARTI_BETECKNING];
        s = `${namn} (${pp.buttons.length} av ${_.size(pp.personer)})`;
        fc(1);
        text(s, pp.x, pp.y + pp.h / 34);
        return pop();
      }
    }

    clickLetterButton(rlk, button, partikod, letters, knrs) {
      var h, i, j, knr, len, person, ref, results, w, x, y;
      this.personer = knrs;
      N = PERSONS_PER_PAGE;
      w = this.w;
      h = height / (PERSONS_PER_PAGE + 1);
      this.selected = button;
      button.pageNo = (button.pageNo + 1) % button.pages;
      this.buttons = [];
      print(PERSON_NAMN);
      knrs.sort(function (a, b) {
        if (dbPersoner[rlk][a][PERSON_NAMN] < dbPersoner[rlk][b][PERSON_NAMN]) {
          return -1;
        } else {
          return 1;
        }
      });
      j = 0;
      results = [];
      for (i = 0, len = knrs.length; i < len; i++) {
        knr = knrs[i];
        person = dbPersoner[rlk][knr];
        if (ref = person[PERSON_NAMN][0], indexOf.call(letters, ref) >= 0) {
          if (Math.floor(j / N) === button.pageNo) {
            x = 0;
            y = h * (1 + j % N);
            (knr => {
              return this.addButton(new PersonButton(rlk, partikod, knr, this.x + x, this.y + y, w - 2, h - 2, function () {
                this.page.selected = this;
                return pages.rlk.clickPersonButton([partikod, knr]);
              }));
            })(knr);
          }
          results.push(j++);
        } else {
          results.push(void 0);
        }
      }
      return results;
    }

    makePersons(rlk, button, partikod, knrs) {
      // knrs är en lista med knr
      var h, i, j, knr, len, results, w, x, y;
      this.personer = knrs;
      w = this.w;
      h = height / (PERSONS_PER_PAGE + 1);
      this.selected = button;
      this.buttons = [];
      knrs.sort(function (a, b) {
        if (dbPersoner[rlk][a][PERSON_NAMN] < dbPersoner[rlk][b][PERSON_NAMN]) {
          return -1;
        } else {
          return 1;
        }
      });
      results = [];
      for (j = i = 0, len = knrs.length; i < len; j = ++i) {
        knr = knrs[j];
        x = 0;
        y = h * (1 + j % N);
        results.push((knr => {
          return this.addButton(new PersonButton(rlk, partikod, knr, this.x + x, this.y + y, w - 2, h - 2, function () {
            this.page.selected = this;
            return pages.rlk.clickPersonButton([partikod, knr]);
          }));
        })(knr));
      }
      return results;
    }

  };

  N = 16;

  return PersonPage;
}.call(undefined);

PersonButton = class PersonButton extends Button {
  constructor(rlk1, partikod1, knr, x, y, w, h, click = function () {}) {
    var person;
    super(knr, x, y, w, h, click);
    this.rlk = rlk1;
    this.partikod = partikod1;
    this.knr = knr;
    person = dbPersoner[this.rlk][knr];
    this.title0 = person[PERSON_NAMN];
    this.title1 = person[PERSON_UPPGIFT];
    if (this.title1 === '') {
      this.title1 = `${{
        M: 'Man',
        K: 'Kvinna'
      }[person[1]]} ${person[0]} år`;
    }
  }

  draw() {
    fc(0.5);
    rect(this.x, this.y, this.w, this.h);
    textAlign(LEFT, CENTER);
    textSize(1 * this.ts);
    fc(1);
    text(this.title0, this.x + 2, this.y + 2 + 0.3 * this.h);
    textAlign(RIGHT, CENTER);
    textSize(0.6 * this.ts);
    fc(0.9);
    return text(this.title1, this.x + this.w - 2, this.y + 3 + 0.75 * this.h);
  }

};
//# sourceMappingURL=PersonPage.js.map
