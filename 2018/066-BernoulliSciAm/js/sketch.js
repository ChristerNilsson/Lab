"use strict";

var _createClass = function () { function defineProperties(target, props) { for (var i = 0; i < props.length; i++) { var descriptor = props[i]; descriptor.enumerable = descriptor.enumerable || false; descriptor.configurable = true; if ("value" in descriptor) descriptor.writable = true; Object.defineProperty(target, descriptor.key, descriptor); } } return function (Constructor, protoProps, staticProps) { if (protoProps) defineProperties(Constructor.prototype, protoProps); if (staticProps) defineProperties(Constructor, staticProps); return Constructor; }; }();

function _classCallCheck(instance, Constructor) { if (!(instance instanceof Constructor)) { throw new TypeError("Cannot call a class as a function"); } }

// Generated by CoffeeScript 2.0.3
var B,
    Ratio,
    a,
    b,
    f,
    g,
    i,
    j,
    k,
    len,
    ref,
    res,
    modulo = function modulo(a, b) {
  return (+a % (b = +b) + b) % b;
};

Ratio = function () {
  function Ratio() {
    var a1 = arguments.length > 0 && arguments[0] !== undefined ? arguments[0] : 0;
    var b1 = arguments.length > 1 && arguments[1] !== undefined ? arguments[1] : 1;

    _classCallCheck(this, Ratio);

    var n;
    this.a = a1;
    this.b = b1;
    n = this.gcd(this.a, this.b);
    this.a /= n;
    this.b /= n;
  }

  _createClass(Ratio, [{
    key: "mul",
    value: function mul(other) {
      return new Ratio(this.a * other.a, this.b * other.b);
    }
  }, {
    key: "add",
    value: function add(other) {
      return new Ratio(other.b * this.a + other.a * this.b, this.b * other.b);
    }
  }, {
    key: "neg",
    value: function neg() {
      return new Ratio(-this.a, this.b);
    }
  }, {
    key: "gcd",
    value: function gcd(a, b) {
      if (b === 0) {
        return a;
      } else {
        return this.gcd(b, modulo(a, b));
      }
    }
  }, {
    key: "toString",
    value: function toString() {
      return this.a + "/" + this.b;
    }
  }]);

  return Ratio;
}();

a = new Ratio(10, 20);

b = new Ratio(6, 8);

assert(2, a.gcd(10, 8));

assert(1, a.gcd(5, 7));

assert("1/2", "" + a);

assert("3/4", "" + b);

assert("5/4", "" + a.add(b));

assert("3/8", "" + a.mul(b));

assert("-1/2", "" + a.neg());

f = function f(x) {
  return new Ratio(-1, 2).mul(new Ratio(2 * x - 1, 2 * x + 1));
};

assert("1/2", "" + f(0));

assert("-1/6", "" + f(1));

assert("-3/10", "" + f(2));

assert("-5/14", "" + f(3));

assert("-7/18", "" + f(4));

assert("-9/22", "" + f(5));

g = function g(x, n) {
  var i;
  return function () {
    var k, len, ref, results;
    ref = range(2 * n - 1);
    results = [];
    for (k = 0, len = ref.length; k < len; k++) {
      i = ref[k];
      results.push(new Ratio(2 * x - i, i + 2));
    }
    return results;
  }().reduce(function (t, a) {
    return t.mul(a);
  });
};

assert("2/1", "" + g(2, 1));

assert("3/1", "" + g(3, 1));

assert("5/1", "" + g(3, 2));

assert("4/1", "" + g(4, 1));

assert("14/1", "" + g(4, 2));

assert("28/3", "" + g(4, 3));

B = [new Ratio(0, 1)];

ref = range(1, 12);
for (k = 0, len = ref.length; k < len; k++) {
  i = ref[k];
  res = i === 1 ? B[0] : function () {
    var l, len1, ref1, results;
    ref1 = range(1, i);
    results = [];
    for (l = 0, len1 = ref1.length; l < len1; l++) {
      j = ref1[l];
      results.push(B[j].mul(g(i, j)));
    }
    return results;
  }().reduce(function (t, a) {
    return t.add(a);
  });
  res = res.add(f(i));
  B.push(res.neg());
}

assert("0/1", "" + B[0]);

assert("1/6", "" + B[1]);

assert("-1/30", "" + B[2]);

assert("1/42", "" + B[3]);

assert("-1/30", "" + B[4]);

assert("5/66", "" + B[5]);

assert("-691/2730", "" + B[6]);

assert("7/6", "" + B[7]);

assert("-3617/510", "" + B[8]);

assert("43867/798", "" + B[9]);

assert("-174611/330", "" + B[10]);

assert("854513/138", "" + B[11]);

print('Ready!');
//# sourceMappingURL=sketch.js.map
