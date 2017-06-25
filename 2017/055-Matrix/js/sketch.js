// Generated by CoffeeScript 1.11.1
var Matrix, a, b, c, d, e, g, h;

Matrix = (function() {
  function Matrix(data1, shape1) {
    this.data = data1;
    this.shape = shape1 != null ? shape1 : [this.data.length];
  }

  Matrix.prototype.reshape = function(shape1) {
    this.shape = shape1;
  };

  Matrix.prototype.iterate = function(f) {
    var i;
    return new Matrix((function() {
      var l, len, ref, results;
      ref = range(this.data.length);
      results = [];
      for (l = 0, len = ref.length; l < len; l++) {
        i = ref[l];
        results.push(f(i));
      }
      return results;
    }).call(this), this.shape);
  };

  Matrix.prototype.map = function(f) {
    return this.iterate((function(_this) {
      return function(i) {
        return f(_this.data[i]);
      };
    })(this));
  };

  Matrix.prototype.fixData = function(other) {
    if (other instanceof Matrix) {
      return other.data;
    } else {
      return [other];
    }
  };

  Matrix.prototype.matrix = function(shape, data) {
    var arg, i;
    if (shape == null) {
      shape = this.shape.slice();
    }
    if (data == null) {
      data = this.data;
    }
    if (shape.length === 1) {
      return data;
    }
    arg = shape.pop();
    return this.matrix(shape, (function() {
      var l, len, ref, results;
      ref = range(0, this.data.length, arg);
      results = [];
      for (l = 0, len = ref.length; l < len; l++) {
        i = ref[l];
        results.push(data.slice(i, i + arg));
      }
      return results;
    }).call(this));
  };

  Matrix.prototype.cell = function() {
    var arg, i, index, l, len;
    index = 0;
    for (i = l = 0, len = arguments.length; l < len; i = ++l) {
      arg = arguments[i];
      index = index * this.shape[i] + arg;
    }
    return this.data[index];
  };

  Matrix.prototype.add = function(other) {
    var data;
    data = this.fixData(other);
    return this.iterate((function(_this) {
      return function(i) {
        return _this.data[i] + data[i % data.length];
      };
    })(this));
  };

  Matrix.prototype.sub = function(other) {
    var data;
    data = this.fixData(other);
    return this.iterate((function(_this) {
      return function(i) {
        return _this.data[i] - data[i % data.length];
      };
    })(this));
  };

  Matrix.prototype.mul = function(other) {
    var data;
    data = this.fixData(other);
    return this.iterate((function(_this) {
      return function(i) {
        return _this.data[i] * data[i % data.length];
      };
    })(this));
  };

  Matrix.prototype.toArray = function() {
    return this.data;
  };

  Matrix.prototype.copy = function() {
    return this.iterate((function(_this) {
      return function(i) {
        return _this.data[i];
      };
    })(this));
  };

  Matrix.prototype.randint = function(n) {
    if (n == null) {
      n = 10;
    }
    return this.iterate(function(i) {
      return Math.floor(n * Math.random());
    });
  };

  Matrix.prototype.transpose = function() {
    var matrix;
    matrix = this.iterate((function(_this) {
      return function(index) {
        return _this.cell(index % _this.shape[0], Math.floor(index / _this.shape[0]));
      };
    })(this));
    matrix.reshape([this.shape[1], this.shape[0]]);
    return matrix;
  };

  Matrix.prototype.dot = function(other) {
    var i, j, sum;
    sum = (function(_this) {
      return function(i, j) {
        var k, l, len, ref, s;
        s = 0;
        ref = range(_this.shape[1]);
        for (l = 0, len = ref.length; l < len; l++) {
          k = ref[l];
          s += _this.cell(i, k) * other.cell(k, j);
        }
        return s;
      };
    })(this);
    return new Matrix(_.flatten((function() {
      var l, len, ref, results;
      ref = range(other.shape[1]);
      results = [];
      for (l = 0, len = ref.length; l < len; l++) {
        j = ref[l];
        results.push((function() {
          var len1, m, ref1, results1;
          ref1 = range(this.shape[0]);
          results1 = [];
          for (m = 0, len1 = ref1.length; m < len1; m++) {
            i = ref1[m];
            results1.push(sum(i, j));
          }
          return results1;
        }).call(this));
      }
      return results;
    }).call(this)), [this.shape[0], other.shape[1]]);
  };

  return Matrix;

})();

a = new Matrix([1, 2, 3, 4, 5, 6], [2, 3]);

assert(a.matrix(), [[1, 2, 3], [4, 5, 6]]);

a = new Matrix([1, 2, 3, 4], [2, 2]);

assert(a.matrix(), [[1, 2], [3, 4]]);

a = new Matrix([0, 0, 0, 0]);

assert(a.shape, [4]);

a.reshape([2, 2]);

assert(a.shape, [2, 2]);

assert(a.data, [0, 0, 0, 0]);

assert(a.matrix(), [[0, 0], [0, 0]]);

a = new Matrix([1, 2, 3, 4]);

b = new Matrix([5, 6, 7, 8]);

assert(a.cell(0), 1);

assert(a.cell(1), 2);

assert(a.cell(2), 3);

assert(a.cell(3), 4);

a.reshape([2, 2]);

b.reshape([2, 2]);

assert(a.cell(0, 0), 1);

assert(a.cell(0, 1), 2);

assert(a.cell(1, 0), 3);

assert(a.cell(1, 1), 4);

c = a.add(b);

assert(c.matrix(), [[6, 8], [10, 12]]);

b = a.add(new Matrix([2, 3]));

assert(b.matrix(), [[3, 5], [5, 7]]);

assert(a.add(10).matrix(), [[11, 12], [13, 14]]);

assert(b.sub(a).matrix(), [[2, 3], [2, 3]]);

assert(a.mul(b).matrix(), [[3, 10], [15, 28]]);

assert(a.add(2).matrix(), [[3, 4], [5, 6]]);

assert(a.sub(2).matrix(), [[-1, 0], [1, 2]]);

assert(a.mul(2).matrix(), [[2, 4], [6, 8]]);

assert(a.data, [1, 2, 3, 4]);

assert(a.copy().matrix(), [[1, 2], [3, 4]]);

assert(a.transpose().data, [1, 3, 2, 4]);

assert(a.dot(b).matrix(), [[13, 29], [19, 43]]);

c = a.map(function(x) {
  return x * x;
});

assert([[1, 4], [9, 16]], c.matrix());

d = new Matrix([1, 2, 3, 4, 5, 6], [2, 3]);

e = d.transpose();

assert(e.data, [1, 4, 2, 5, 3, 6]);

assert(e.shape, [3, 2]);

e = d.add(3);

assert(e.data, [4, 5, 6, 7, 8, 9]);

assert(e.shape, [2, 3]);

assert(e.matrix(), [[4, 5, 6], [7, 8, 9]]);

e = d.transpose();

assert(e.dot(d).matrix(), [[17, 22, 27], [22, 29, 36], [27, 36, 45]]);

assert(d.dot(e).matrix(), [[14, 32], [32, 77]]);

g = new Matrix(range(24));

g.reshape([2, 3, 4]);

assert(g.matrix()[0], [[0, 1, 2, 3], [4, 5, 6, 7], [8, 9, 10, 11]]);

assert(g.matrix()[0][0], [0, 1, 2, 3]);

assert(g.matrix()[0][0][0], 0);

assert(g.cell(0, 0, 0), 0);

assert(g.cell(1, 2, 3), 23);

h = new Matrix(range(15), [3, 5]);

assert(h.matrix(), [[0, 1, 2, 3, 4], [5, 6, 7, 8, 9], [10, 11, 12, 13, 14]]);

//# sourceMappingURL=data:application/json;base64,eyJ2ZXJzaW9uIjozLCJmaWxlIjoic2tldGNoLmpzIiwic291cmNlUm9vdCI6Ii4uIiwic291cmNlcyI6WyJjb2ZmZWVcXHNrZXRjaC5jb2ZmZWUiXSwibmFtZXMiOltdLCJtYXBwaW5ncyI6IjtBQUdBLElBQUE7O0FBQU07RUFDUyxnQkFBQyxLQUFELEVBQVEsTUFBUjtJQUFDLElBQUMsQ0FBQSxPQUFEO0lBQU8sSUFBQyxDQUFBLHlCQUFELFNBQU8sQ0FBQyxJQUFDLENBQUEsSUFBSSxDQUFDLE1BQVA7RUFBZjs7bUJBQ2QsT0FBQSxHQUFVLFNBQUMsTUFBRDtJQUFDLElBQUMsQ0FBQSxRQUFEO0VBQUQ7O21CQUNWLE9BQUEsR0FBVSxTQUFDLENBQUQ7QUFBTyxRQUFBO1dBQUksSUFBQSxNQUFBOztBQUFRO0FBQUE7V0FBQSxxQ0FBQTs7cUJBQUEsQ0FBQSxDQUFFLENBQUY7QUFBQTs7aUJBQVIsRUFBMEMsSUFBQyxDQUFBLEtBQTNDO0VBQVg7O21CQUVWLEdBQUEsR0FBTSxTQUFDLENBQUQ7V0FBTyxJQUFDLENBQUEsT0FBRCxDQUFTLENBQUEsU0FBQSxLQUFBO2FBQUEsU0FBQyxDQUFEO2VBQU8sQ0FBQSxDQUFFLEtBQUMsQ0FBQSxJQUFLLENBQUEsQ0FBQSxDQUFSO01BQVA7SUFBQSxDQUFBLENBQUEsQ0FBQSxJQUFBLENBQVQ7RUFBUDs7bUJBQ04sT0FBQSxHQUFVLFNBQUMsS0FBRDtJQUFXLElBQUcsS0FBQSxZQUFpQixNQUFwQjthQUFnQyxLQUFLLENBQUMsS0FBdEM7S0FBQSxNQUFBO2FBQWdELENBQUMsS0FBRCxFQUFoRDs7RUFBWDs7bUJBRVYsTUFBQSxHQUFTLFNBQUMsS0FBRCxFQUF1QixJQUF2QjtBQUNSLFFBQUE7O01BRFMsUUFBTSxJQUFDLENBQUEsS0FBSyxDQUFDLEtBQVAsQ0FBQTs7O01BQWdCLE9BQUssSUFBQyxDQUFBOztJQUNyQyxJQUFHLEtBQUssQ0FBQyxNQUFOLEtBQWMsQ0FBakI7QUFBd0IsYUFBTyxLQUEvQjs7SUFDQSxHQUFBLEdBQU0sS0FBSyxDQUFDLEdBQU4s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LEVBQU8sQ0FBUCxDQUF6Qjs7QUFDQSxNQUFBLENBQU8sQ0FBQyxDQUFDLE1BQUYsQ0FBQSxDQUFXLENBQUEsQ0FBQSxDQUFHLENBQUEsQ0FBQSxDQUFHLENBQUEsQ0FBQSxDQUF4QixFQUE0QixDQUE1Qjs7QUFDQSxNQUFBLENBQU8sQ0FBQyxDQUFDLElBQUYsQ0FBTyxDQUFQLEVBQVMsQ0FBVCxFQUFXLENBQVgsQ0FBUCxFQUFzQixDQUF0Qjs7QUFDQSxNQUFBLENBQU8sQ0FBQyxDQUFDLElBQUYsQ0FBTyxDQUFQLEVBQVMsQ0FBVCxFQUFXLENBQVgsQ0FBUCxFQUFzQixFQUF0Qjs7QUFFQSxDQUFBLEdBQVEsSUFBQSxNQUFBLENBQU8sS0FBQSxDQUFNLEVBQU4sQ0FBUCxFQUFpQixDQUFDLENBQUQsRUFBRyxDQUFILENBQWpCOztBQUNSLE1BQUEsQ0FBTyxDQUFDLENBQUMsTUFBRixDQUFBLENBQVAsRUFBbUIsQ0FBQyxDQUFDLENBQUQsRUFBRyxDQUFILEVBQUssQ0FBTCxFQUFPLENBQVAsRUFBUyxDQUFULENBQUQsRUFBYSxDQUFDLENBQUQsRUFBRyxDQUFILEVBQUssQ0FBTCxFQUFPLENBQVAsRUFBUyxDQUFULENBQWIsRUFBeUIsQ0FBQyxFQUFELEVBQUksRUFBSixFQUFPLEVBQVAsRUFBVSxFQUFWLEVBQWEsRUFBYixDQUF6QixDQUFuQiIsInNvdXJjZXNDb250ZW50IjpbIiMgaHR0cHM6Ly9naXRodWIuY29tL3NoaWZmbWFuL05ldXJhbC1OZXR3b3JrLXA1XHJcbiMgaHR0cHM6Ly9kb2NzLnNjaXB5Lm9yZy9kb2MvbnVtcHktZGV2L3VzZXIvcXVpY2tzdGFydC5odG1sXHJcblxyXG5jbGFzcyBNYXRyaXhcclxuXHRjb25zdHJ1Y3RvciA6IChAZGF0YSwgQHNoYXBlPVtAZGF0YS5sZW5ndGhdKSAtPlxyXG5cdHJlc2hhcGUgOiAoQHNoYXBlKSAtPiAjIGNoZWNrIG5cclxuXHRpdGVyYXRlIDogKGYpIC0+IG5ldyBNYXRyaXggKGYgaSBmb3IgaSBpbiByYW5nZSBAZGF0YS5sZW5ndGgpLCBAc2hhcGVcclxuXHJcblx0bWFwIDogKGYpIC0+IEBpdGVyYXRlIChpKSA9PiBmIEBkYXRhW2ldXHJcblx0Zml4RGF0YSA6IChvdGhlcikgLT4gaWYgb3RoZXIgaW5zdGFuY2VvZiBNYXRyaXggdGhlbiBvdGhlci5kYXRhIGVsc2UgW290aGVyXVxyXG5cclxuXHRtYXRyaXggOiAoc2hhcGU9QHNoYXBlLnNsaWNlKCksIGRhdGE9QGRhdGEpIC0+XHJcblx0XHRpZiBzaGFwZS5sZW5ndGg9PTEgdGhlbiByZXR1cm4gZGF0YVxyXG5cdFx0YXJnID0gc2hhcGUucG9wKClcclxuXHRcdEBtYXRyaXggc2hhcGUsIChkYXRhW2kuLi5pK2FyZ10gZm9yIGkgaW4gcmFuZ2UgMCxAZGF0YS5sZW5ndGgsYXJnKVxyXG5cclxuXHRjZWxsIDogLT5cclxuXHRcdGluZGV4ID0gMFxyXG5cdFx0Zm9yIGFyZyxpIGluIGFyZ3VtZW50c1xyXG5cdFx0XHRpbmRleCA9IGluZGV4ICogQHNoYXBlW2ldICsgYXJnXHJcblx0XHRAZGF0YVtpbmRleF1cclxuXHJcblx0YWRkIDogKG90aGVyKSAtPlxyXG5cdFx0ZGF0YSA9IEBmaXhEYXRhIG90aGVyXHJcblx0XHRAaXRlcmF0ZSAoaSkgPT4gQGRhdGFbaV0gKyBkYXRhW2kgJSBkYXRhLmxlbmd0aF1cclxuXHJcblx0c3ViIDogKG90aGVyKSAtPlxyXG5cdFx0ZGF0YSA9IEBmaXhEYXRhIG90aGVyXHJcblx0XHRAaXRlcmF0ZSAoaSkgPT4gQGRhdGFbaV0gLSBkYXRhW2kgJSBkYXRhLmxlbmd0aF1cclxuXHJcblx0bXVsIDogKG90aGVyKSAtPlxyXG5cdFx0ZGF0YSA9IEBmaXhEYXRhIG90aGVyXHJcblx0XHRAaXRlcmF0ZSAoaSkgPT4gQGRhdGFbaV0gKiBkYXRhW2kgJSBkYXRhLmxlbmd0aF1cclxuXHJcblx0dG9BcnJheSAgIDogLT4gQGRhdGFcclxuXHRjb3B5ICAgICAgOiAtPiBAaXRlcmF0ZSAoaSkgPT4gQGRhdGFbaV1cclxuXHRyYW5kaW50IDogKG49MTApIC0+IEBpdGVyYXRlIChpKSAtPiBNYXRoLmZsb29yIG4gKiBNYXRoLnJhbmRvbSgpXHJcblxyXG5cdHRyYW5zcG9zZSA6IC0+XHJcblx0XHRtYXRyaXggPSBAaXRlcmF0ZSAoaW5kZXgpID0+IEBjZWxsIGluZGV4ICUgQHNoYXBlWzBdLCBNYXRoLmZsb29yIGluZGV4L0BzaGFwZVswXVxyXG5cdFx0bWF0cml4LnJlc2hhcGUgW0BzaGFwZVsxXSxAc2hhcGVbMF1dXHJcblx0XHRtYXRyaXhcclxuXHJcblx0ZG90IDogKG90aGVyKSAtPlxyXG5cdFx0c3VtID0gKGksaikgPT5cclxuXHRcdFx0cyA9IDBcclxuXHRcdFx0Zm9yIGsgaW4gcmFuZ2UgQHNoYXBlWzFdXHJcblx0XHRcdFx0cyArPSBAY2VsbChpLGspICogb3RoZXIuY2VsbChrLGopXHJcblx0XHRcdHNcclxuXHRcdG5ldyBNYXRyaXggXy5mbGF0dGVuKChzdW0oaSxqKSBmb3IgaSBpbiByYW5nZSBAc2hhcGVbMF0gZm9yIGogaW4gcmFuZ2Ugb3RoZXIuc2hhcGVbMV0pKSwgW0BzaGFwZVswXSwgb3RoZXIuc2hhcGVbMV1dXHJcblxyXG5hID0gbmV3IE1hdHJpeCBbMSwyLDMsNCw1LDZdLFsyLDNdXHJcbmFzc2VydCBhLm1hdHJpeCgpLCBbWzEsMiwzXSxbNCw1LDZdXVxyXG5cclxuYSA9IG5ldyBNYXRyaXggWzEsMiwzLDRdLFsyLDJdXHJcbmFzc2VydCBhLm1hdHJpeCgpLCBbWzEsMl0sWzMsNF1dXHJcblxyXG5hID0gbmV3IE1hdHJpeCBbMCwwLDAsMF1cclxuYXNzZXJ0IGEuc2hhcGUsIFs0XVxyXG5hLnJlc2hhcGUgWzIsMl1cclxuYXNzZXJ0IGEuc2hhcGUsIFsyLDJdXHJcblxyXG5hc3NlcnQgYS5kYXRhLCBbMCwwLDAsMF1cclxuYXNzZXJ0IGEubWF0cml4KCksIFtbMCwwXSxbMCwwXV1cclxuXHJcbmEgPSBuZXcgTWF0cml4IFsxLDIsMyw0XVxyXG5iID0gbmV3IE1hdHJpeCBbNSw2LDcsOF1cclxuYXNzZXJ0IGEuY2VsbCgwKSwgMVxyXG5hc3NlcnQgYS5jZWxsKDEpLCAyXHJcbmFzc2VydCBhLmNlbGwoMiksIDNcclxuYXNzZXJ0IGEuY2VsbCgzKSwgNFxyXG5hLnJlc2hhcGUgWzIsMl1cclxuYi5yZXNoYXBlIFsyLDJdXHJcbmFzc2VydCBhLmNlbGwoMCwwKSwgMVxyXG5hc3NlcnQgYS5jZWxsKDAsMSksIDJcclxuYXNzZXJ0IGEuY2VsbCgxLDApLCAzXHJcbmFzc2VydCBhLmNlbGwoMSwxKSwgNFxyXG5cclxuYyA9IGEuYWRkKGIpXHJcbmFzc2VydCBjLm1hdHJpeCgpLCBbWzYsOF0sWzEwLDEyXV1cclxuYiA9IGEuYWRkKG5ldyBNYXRyaXggWzIsM10pXHJcbmFzc2VydCBiLm1hdHJpeCgpLCBbWzMsNV0sWzUsN11dXHJcblxyXG5hc3NlcnQgYS5hZGQoMTApLm1hdHJpeCgpLCBbWzExLDEyXSxbMTMsMTRdXVxyXG5cclxuYXNzZXJ0IGIuc3ViKGEpLm1hdHJpeCgpLCBbWzIsM10sWzIsM11dXHJcbmFzc2VydCBhLm11bChiKS5tYXRyaXgoKSwgW1szLDEwXSxbMTUsMjhdXVxyXG5cclxuYXNzZXJ0IGEuYWRkKDIpLm1hdHJpeCgpLCBbWzMsNF0sWzUsNl1dXHJcbmFzc2VydCBhLnN1YigyKS5tYXRyaXgoKSwgW1stMSwwXSxbMSwyXV1cclxuYXNzZXJ0IGEubXVsKDIpLm1hdHJpeCgpLCBbWzIsNF0sWzYsOF1dXHJcblxyXG5hc3NlcnQgYS5kYXRhLCBbMSwyLDMsNF1cclxuYXNzZXJ0IGEuY29weSgpLm1hdHJpeCgpLCBbWzEsMl0sWzMsNF1dXHJcbmFzc2VydCBhLnRyYW5zcG9zZSgpLmRhdGEsIFsxLDMsMiw0XVxyXG5cclxuYXNzZXJ0IGEuZG90KGIpLm1hdHJpeCgpLCBbWzEzLDI5XSxbMTksNDNdXVxyXG5cclxuYyA9IGEubWFwICh4KSAtPiB4KnhcclxuYXNzZXJ0IFtbMSw0XSxbOSwxNl1dLCBjLm1hdHJpeCgpXHJcblxyXG5kID0gbmV3IE1hdHJpeCBbMSwyLDMsNCw1LDZdLCBbMiwzXSAjIGksalxyXG5cclxuZSA9IGQudHJhbnNwb3NlKClcclxuYXNzZXJ0IGUuZGF0YSwgWzEsNCwyLDUsMyw2XVxyXG5hc3NlcnQgZS5zaGFwZSwgWzMsMl1cclxuXHJcbmUgPSBkLmFkZCAzXHJcbmFzc2VydCBlLmRhdGEsWzQsNSw2LDcsOCw5XVxyXG5hc3NlcnQgZS5zaGFwZSwgWzIsM11cclxuYXNzZXJ0IGUubWF0cml4KCksIFtbNCw1LDZdLFs3LDgsOV1dXHJcblxyXG5lID0gZC50cmFuc3Bvc2UoKVxyXG5hc3NlcnQgZS5kb3QoZCkubWF0cml4KCksIFtbMTcsMjIsMjddLFsyMiwyOSwzNl0sWzI3LDM2LDQ1XV1cclxuYXNzZXJ0IGQuZG90KGUpLm1hdHJpeCgpLCBbWzE0LDMyXSxbMzIsNzddXVxyXG5cclxuIyAzRFxyXG5nID0gbmV3IE1hdHJpeCByYW5nZSAyNFxyXG5nLnJlc2hhcGUgWzIsMyw0XSAjIGksaixrXHJcbmFzc2VydCBnLm1hdHJpeCgpWzBdLCBbWzAsMSwyLDNdLFs0LDUsNiw3XSxbOCw5LDEwLDExXV1cclxuYXNzZXJ0IGcubWF0cml4KClbMF1bMF0sIFswLDEsMiwzXVxyXG5hc3NlcnQgZy5tYXRyaXgoKVswXVswXVswXSwgMFxyXG5hc3NlcnQgZy5jZWxsKDAsMCwwKSwgMFxyXG5hc3NlcnQgZy5jZWxsKDEsMiwzKSwgMjNcclxuXHJcbmggPSBuZXcgTWF0cml4IHJhbmdlKDE1KSxbMyw1XVxyXG5hc3NlcnQgaC5tYXRyaXgoKSwgW1swLDEsMiwzLDRdLFs1LDYsNyw4LDldLFsxMCwxMSwxMiwxMywxNF1dIl19
//# sourceURL=C:\Lab\2017\055-Matrix\coffee\sketch.coffee