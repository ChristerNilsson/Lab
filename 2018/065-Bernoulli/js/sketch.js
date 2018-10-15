"use strict";

var _createClass = function () { function defineProperties(target, props) { for (var i = 0; i < props.length; i++) { var descriptor = props[i]; descriptor.enumerable = descriptor.enumerable || false; descriptor.configurable = true; if ("value" in descriptor) descriptor.writable = true; Object.defineProperty(target, descriptor.key, descriptor); } } return function (Constructor, protoProps, staticProps) { if (protoProps) defineProperties(Constructor.prototype, protoProps); if (staticProps) defineProperties(Constructor, staticProps); return Constructor; }; }();

function _classCallCheck(instance, Constructor) { if (!(instance instanceof Constructor)) { throw new TypeError("Cannot call a class as a function"); } }

// Generated by CoffeeScript 2.0.3
var Ratio,
    a,
    b,
    _bernoulli,
    cache,
    _gcd,
    polynomialTerm,
    modulo = function modulo(a, b) {
  return (+a % (b = +b) + b) % b;
};

_gcd = function gcd(a, b) {
  if (b === 0) {
    return a;
  } else {
    return _gcd(b, modulo(a, b));
  }
};

assert(2, _gcd(10, 8));

Ratio = function () {
  function Ratio() {
    var a1 = arguments.length > 0 && arguments[0] !== undefined ? arguments[0] : 0;
    var b1 = arguments.length > 1 && arguments[1] !== undefined ? arguments[1] : 1;

    _classCallCheck(this, Ratio);

    var n;
    this.a = a1;
    this.b = b1;
    n = _gcd(this.a, this.b);
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
    key: "toString",
    value: function toString() {
      return this.a + "/" + this.b;
    }
  }]);

  return Ratio;
}();

a = new Ratio(10, 20);

b = new Ratio(6, 8);

assert("1/2", "" + a);

assert("3/4", "" + b);

assert("5/4", "" + a.add(b));

assert("3/8", "" + a.mul(b));

assert("-1/2", "" + a.neg(b));

cache = {};

_bernoulli = function bernoulli(n) {
  var count, i, index, j, len, ref, sum, temp, value;
  if (n in cache) {
    return cache[n];
  }
  if (n % 2 === 0) {
    return new Ratio();
  }
  sum = new Ratio(-1, 2).mul(new Ratio(n, n + 2));
  count = (n - 1) / 2;
  ref = range(count);
  for (j = 0, len = ref.length; j < len; j++) {
    i = ref[j];
    index = 2 * i + 1;
    value = polynomialTerm(index, count + 1);
    temp = _bernoulli(index);
    sum = sum.add(temp.mul(value));
  }
  return cache[n] = sum.neg();
};

polynomialTerm = function polynomialTerm(degree, n) {
  var i, j, len, ref;
  a = 1;
  b = 1;
  ref = range(degree);
  for (j = 0, len = ref.length; j < len; j++) {
    i = ref[j];
    a *= 2 * n - i;
    b *= 2 + i;
  }
  return new Ratio(a, b);
};

assert("0/1", "" + _bernoulli(0));

assert("1/6", "" + _bernoulli(1));

assert("-1/30", "" + _bernoulli(3));

assert("1/42", "" + _bernoulli(5));

assert("-1/30", "" + _bernoulli(7));

assert("5/66", "" + _bernoulli(9));

assert("-691/2730", "" + _bernoulli(11));

assert("7/6", "" + _bernoulli(13));

assert("-3617/510", "" + _bernoulli(15));

assert("43867/798", "" + _bernoulli(17));

assert("-174611/330", "" + _bernoulli(19));

print("Ready!");
//# sourceMappingURL=sketch.js.map
