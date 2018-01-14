'use strict';

var _slicedToArray = function () { function sliceIterator(arr, i) { var _arr = []; var _n = true; var _d = false; var _e = undefined; try { for (var _i = arr[Symbol.iterator](), _s; !(_n = (_s = _i.next()).done); _n = true) { _arr.push(_s.value); if (i && _arr.length === i) break; } } catch (err) { _d = true; _e = err; } finally { try { if (!_n && _i["return"]) _i["return"](); } finally { if (_d) throw _e; } } return _arr; } return function (arr, i) { if (Array.isArray(arr)) { return arr; } else if (Symbol.iterator in Object(arr)) { return sliceIterator(arr, i); } else { throw new TypeError("Invalid attempt to destructure non-iterable instance"); } }; }();

var _createClass = function () { function defineProperties(target, props) { for (var i = 0; i < props.length; i++) { var descriptor = props[i]; descriptor.enumerable = descriptor.enumerable || false; descriptor.configurable = true; if ("value" in descriptor) descriptor.writable = true; Object.defineProperty(target, descriptor.key, descriptor); } } return function (Constructor, protoProps, staticProps) { if (protoProps) defineProperties(Constructor.prototype, protoProps); if (staticProps) defineProperties(Constructor, staticProps); return Constructor; }; }();

function _classCallCheck(instance, Constructor) { if (!(instance instanceof Constructor)) { throw new TypeError("Cannot call a class as a function"); } }

// Generated by CoffeeScript 2.0.3
var Korg,
    indexOf = [].indexOf;

Korg = function () {
  function Korg() {
    _classCallCheck(this, Korg);

    this.table = null;
    this.branch = [];
    this.items = [];
    this.targets = {};
  }

  _createClass(Korg, [{
    key: 'rensa',
    value: function rensa() {
      return this.table.innerHTML = "";
    }
  }, {
    key: 'add',
    value: function add(item) {
      return this.items.push(item);
    }
  }, {
    key: 'updateTotal',
    value: function updateTotal() {
      var count, total;

      var _total = this.total();

      var _total2 = _slicedToArray(_total, 2);

      count = _total2[0];
      total = _total2[1];

      return send.innerHTML = 'Order (' + count + ' meal' + (count === 1 ? '' : 's') + ', ' + total + 'kr)';
    }
  }, {
    key: 'update0',
    value: function update0(b, item, delta) {
      if (item[1] + delta < 0) {
        return;
      }
      item[1] += delta;
      b.value = pretty(item[1], item[2]);
      return this.updateTotal();
    }
  }, {
    key: 'update1',
    value: function update1(b, items, source, dir, mapping, delta) {
      var deltaValue, target;
      deltaValue = dir;
      if (delta && delta[source]) {
        deltaValue = dir * delta[source];
      }
      target = mapping[source];
      if (items[target] - deltaValue >= 0) {
        items[target] -= deltaValue;
        items[source] += deltaValue;
        this.targets[target].innerHTML = items[target];
        return b.value = items[source];
      }
    }
  }, {
    key: 'traverse',
    value: function traverse() {
      var items = arguments.length > 0 && arguments[0] !== undefined ? arguments[0] : this.items;
      var mapping = arguments.length > 1 && arguments[1] !== undefined ? arguments[1] : null;
      var passive = arguments.length > 2 && arguments[2] !== undefined ? arguments[2] : null;
      var delta = arguments.length > 3 && arguments[3] !== undefined ? arguments[3] : null;
      var level = arguments.length > 4 && arguments[4] !== undefined ? arguments[4] : 0;
      var br = arguments.length > 5 && arguments[5] !== undefined ? arguments[5] : [];

      var antal, children, delta1, i, id, item, j, key, len, mapping1, passive1, pris, results, results1, title;
      if (false === goDeeper(this.branch, br)) {
        return;
      }
      if (level === 0) {
        results = [];
        for (i = j = 0, len = items.length; j < len; i = ++j) {
          item = items[i];
          var _item = item;

          var _item2 = _slicedToArray(_item, 8);

          id = _item2[0];
          antal = _item2[1];
          pris = _item2[2];
          title = _item2[3];
          children = _item2[4];
          mapping1 = _item2[5];
          passive1 = _item2[6];
          delta1 = _item2[7];

          this.addTitle0(item, id, pris, title, br.concat(i), antal, children);
          if (children) {
            results.push(this.traverse(children, mapping1, passive1, delta1, level + 1, br.concat(i)));
          } else {
            results.push(void 0);
          }
        }
        return results;
      } else if (level === 1) {
        results1 = [];
        for (key in items) {
          results1.push(this.addTitle1(items, key, klartext[key][1], br.concat(i), mapping, passive, delta));
        }
        return results1;
      }
    }
  }, {
    key: 'handleRow',
    value: function handleRow(b1, b2, b3) {
      var tr;
      tr = document.createElement("tr");
      addCell(tr, b1, 100);
      addCell(tr, b2, 5);
      addCell(tr, b3, 5);
      return this.table.appendChild(tr);
    }
  }, {
    key: 'addTitle0',
    value: function addTitle0(item, id, pris, title, br, antal, children) {
      var _this = this;

      var b1, b2, b3;
      if (children) {
        b1 = makeButton(id + '. ' + title);
        b1.style.textAlign = 'left';
        b1.branch = br;
        b1.onclick = function () {
          _this.branch = calcBranch(_this.branch, b1.branch);
          return updateTables();
        };
      } else {
        b1 = document.createElement("div");
        b1.innerHTML = id + '. ' + title;
        b1.style.cssText = "font-size:100%; white-space:normal; width:100%;";
      }
      b2 = makeButton(pretty(antal, pris), GREEN, BLACK);
      b2.onclick = function () {
        return _this.update0(b2, item, +1);
      };
      b3 = makeButton("Del", RED, BLACK);
      b3.onclick = function () {
        return _this.update0(b2, item, -1);
      };
      return this.handleRow(b1, b2, b3);
    }
  }, {
    key: 'addTitle1',
    value: function addTitle1(items, key, title, br, mapping, passive, delta) {
      var _this2 = this;

      var antal, b1, b2, b3;
      antal = items[key];
      b1 = document.createElement("div");
      b1.innerHTML = title;
      b1.style.cssText = "font-size:100%; white-space:normal; width:100%; text-align:right";
      if (passive) {
        if (indexOf.call(passive, key) >= 0) {
          b2 = makeDiv(antal);
          b3 = makeDiv('');
          this.targets[key] = b2;
        } else {
          b2 = makeButton(antal, GREEN, BLACK);
          b3 = makeButton('Del', RED, BLACK);
        }
      } else {
        b2 = makeDiv(antal);
        b3 = makeDiv('');
      }
      b2.style.textAlign = "center";
      b2.onclick = function () {
        return _this2.update1(b2, items, key, +1, mapping, delta);
      };
      b3.onclick = function () {
        if (b2.value > 0) {
          return _this2.update1(b2, items, key, -1, mapping, delta);
        }
      };
      return this.handleRow(b1, b2, b3);
    }
  }, {
    key: 'total',
    value: function total() {
      var antal, count, id, j, len, pris, ref, res;
      res = 0;
      count = 0;
      ref = this.items;
      for (j = 0, len = ref.length; j < len; j++) {
        var _ref$j = _slicedToArray(ref[j], 3);

        id = _ref$j[0];
        antal = _ref$j[1];
        pris = _ref$j[2];

        res += antal * pris;
        if (indexOf.call(nonMeals, id) < 0) {
          count += antal;
        }
      }
      return [count, res];
    }
  }, {
    key: 'clear',
    value: function clear() {
      var newitems;
      newitems = this.items.filter(function (e) {
        return e[1] !== 0;
      });
      if (newitems.length === this.items.length) {
        return this.items = []; // alla tas bort
      } else {
        return this.items = newitems; // alla med antal==0 tas bort
      }
    }
  }, {
    key: 'send',
    value: function send() {
      var antal, children, id, j, key, len, output, pris, ref, s, sarr, ss, subantal, t, title, u;
      t = 0; // kr
      s = ''; // full text
      u = ''; // compact
      ref = this.items;
      for (j = 0, len = ref.length; j < len; j++) {
        var _ref$j2 = _slicedToArray(ref[j], 5);

        id = _ref$j2[0];
        antal = _ref$j2[1];
        pris = _ref$j2[2];
        title = _ref$j2[3];
        children = _ref$j2[4];

        if (antal > 0) {
          sarr = [];
          if (children) {
            for (key in children) {
              subantal = children[key];
              if (subantal === 1) {
                sarr.push(key);
              } else if (subantal > 1) {
                sarr.push(subantal + key);
              }
            }
          }
          if (sarr.length > 0) {
            ss = ' (' + sarr.join(' ') + ')';
          } else {
            ss = '';
          }
          t += antal * pris;
          s += (antal > 1 ? antal + ' x ' : '') + id + ". " + title + ss + CRLF;
          u += (antal > 1 ? antal + 'x' : '') + id + ss + CRLF;
        }
      }
      if (t === 0) {
        return;
      }

      // klarar ej & i restaurangnamnet.
      output = encodeURI('mailto:' + MAIL + '?&subject=Order till ' + SHOP + '&body=' + s + CRLF + t + " kr");
      if (output.length > 2000) {
        output = encodeURI('mailto:' + MAIL + '?&subject=Order till ' + SHOP + '&body=' + u + CRLF + t + " kr");
      }
      return window.open(output, '_blank');
    }
  }]);

  return Korg;
}();
//# sourceMappingURL=korg.js.map