// Generated by CoffeeScript 1.11.1
var Matrix, expand;

expand = function(target, n) {
  var a, big, index, l, len, len1, m, ref, small;
  big = [];
  target = target.slice().reverse();
  ref = range(n);
  for (l = 0, len = ref.length; l < len; l++) {
    index = ref[l];
    small = [];
    for (m = 0, len1 = target.length; m < len1; m++) {
      a = target[m];
      small.unshift(index % a);
      index = Math.floor(index / a);
    }
    big.push(small);
  }
  return big;
};

Matrix = (function() {
  function Matrix(data1) {
    this.data = data1;
    this.shape = [this.data.length];
  }

  Matrix.prototype.reshape = function(shape1) {
    this.shape = shape1;
    return this;
  };

  Matrix.prototype.map = function(f) {
    var x;
    return new Matrix((function() {
      var l, len, ref, results;
      ref = this.data;
      results = [];
      for (l = 0, len = ref.length; l < len; l++) {
        x = ref[l];
        results.push(f(x));
      }
      return results;
    }).call(this)).reshape(this.shape);
  };

  Matrix.prototype.cell = function(indices) {
    return this.data[this.index(indices)];
  };

  Matrix.prototype.fixData = function(other) {
    if (other instanceof Matrix) {
      return other;
    } else {
      return new Matrix([other]);
    }
  };

  Matrix.prototype.toArray = function() {
    return this.data;
  };

  Matrix.prototype.copy = function() {
    return new Matrix(this.data).reshape(this.shape);
  };

  Matrix.prototype.randint = function(n) {
    if (n == null) {
      n = 10;
    }
    return Math.floor(n * Math.random());
  };

  Matrix.prototype.add = function(other) {
    return this.broadcast(other, function(a, b) {
      return a + b;
    });
  };

  Matrix.prototype.sub = function(other) {
    return this.broadcast(other, function(a, b) {
      return a - b;
    });
  };

  Matrix.prototype.mul = function(other) {
    return this.broadcast(other, function(a, b) {
      return a * b;
    });
  };

  Matrix.prototype.broadcast = function(other, f) {
    var a, antal, b, data, i, indices, n, target;
    other = this.fixData(other);
    a = this.shape;
    b = other.shape;
    antal = Math.max(a.length, b.length);
    target = (function() {
      var l, len, ref, results;
      ref = range(antal);
      results = [];
      for (l = 0, len = ref.length; l < len; l++) {
        i = ref[l];
        results.push(Math.max(a[i] || 1, b[i] || 1));
      }
      return results;
    })();
    n = target.reduce((function(a, b) {
      return a * b;
    }), 1);
    data = (function() {
      var l, len, ref, results;
      ref = expand(target, n);
      results = [];
      for (l = 0, len = ref.length; l < len; l++) {
        indices = ref[l];
        results.push(f(this.cell(indices), other.cell(indices)));
      }
      return results;
    }).call(this);
    return new Matrix(data).reshape(target);
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
      ref = range(0, data.length, arg);
      results = [];
      for (l = 0, len = ref.length; l < len; l++) {
        i = ref[l];
        results.push(data.slice(i, i + arg));
      }
      return results;
    })());
  };

  Matrix.prototype.index = function(indices) {
    var arg, i, l, len, res;
    res = 0;
    for (i = l = 0, len = indices.length; l < len; i = ++l) {
      arg = indices[i];
      res *= this.shape[i] || 1;
      res += (this.shape[i] || 1) === 1 ? 0 : arg;
    }
    return res;
  };

  Matrix.prototype.transpose = function() {
    var data, i, j, l, len, ref;
    ref = range(this.shape[1]);
    for (l = 0, len = ref.length; l < len; l++) {
      i = ref[l];
      data = (data || []).concat((function() {
        var len1, m, ref1, results;
        ref1 = range(this.shape[0]);
        results = [];
        for (m = 0, len1 = ref1.length; m < len1; m++) {
          j = ref1[m];
          results.push(this.cell([j, i]));
        }
        return results;
      }).call(this));
    }
    return new Matrix(data).reshape([this.shape[1], this.shape[0]]);
  };

  Matrix.prototype.dot = function(other) {
    var i, j, sum;
    sum = (function(_this) {
      return function(i, j) {
        var k;
        return ((function() {
          var l, len, ref, results;
          ref = range(this.shape[1]);
          results = [];
          for (l = 0, len = ref.length; l < len; l++) {
            k = ref[l];
            results.push(this.cell([i, k]) * other.cell([k, j]));
          }
          return results;
        }).call(_this)).reduce((function(a, b) {
          return a + b;
        }), 0);
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
            results1.push(sum(j, i));
          }
          return results1;
        }).call(this));
      }
      return results;
    }).call(this))).reshape([this.shape[0], other.shape[1]]);
  };

  return Matrix;

})();

//# sourceMappingURL=data:application/json;base64,eyJ2ZXJzaW9uIjozLCJmaWxlIjoic2tldGNoLmpzIiwic291cmNlUm9vdCI6Ii4uIiwic291cmNlcyI6WyJjb2ZmZWVcXHNrZXRjaC5jb2ZmZWUiXSwibmFtZXMiOltdLCJtYXBwaW5ncyI6IjtBQUdBLElBQUE7O0FBQUEsTUFBQSxHQUFTLFNBQUMsTUFBRCxFQUFRLENBQVI7QUFDUixNQUFBO0VBQUEsR0FBQSxHQUFNO0VBQ04sTUFBQSxHQUFTLE1BQU0sQ0FBQyxLQUFQLENBQUEsQ0FBYyxDQUFDLE9BQWYsQ0FBQTtBQUNUO0FBQUEsT0FBQSxxQ0FBQTs7SUFDQyxLQUFBLEdBQVE7QUFDUixTQUFBLDBDQUFBOztNQUNDLEtBQUssQ0FBQyxPQUFOLENBQWMsS0FBQSxHQUFRLENBQXRCO01BQ0EsbUJBQUEsUUFBVTtBQUZYO0lBR0EsR0FBRyxDQUFDLElBQUosQ0FBUyxLQUFUO0FBTEQ7U0FNQTtBQVRROztBQVdIO0VBQ1MsZ0JBQUMsS0FBRDtJQUFDLElBQUMsQ0FBQSxPQUFEO0lBQVUsSUFBQyxDQUFBLEtBQUQsR0FBUyxDQUFDLElBQUMsQ0FBQSxJQUFJLENBQUMsTUFBUDtFQUFwQjs7bUJBQ2QsT0FBQSxHQUFVLFNBQUMsTUFBRDtJQUFDLElBQUMsQ0FBQSxRQUFEO1dBQVc7RUFBWjs7bUJBQ1YsR0FBQSxHQUFVLFNBQUMsQ0FBRDtBQUFPLFFBQUE7V0FBSSxJQUFBLE1BQUE7O0FBQVE7QUFBQTtXQUFBLHFDQUFBOztxQkFBQSxDQUFBLENBQUUsQ0FBRjtBQUFBOztpQkFBUixDQUE0QixDQUFDLE9BQTdCLENBQXFDLElBQUMsQ0FBQSxLQUF0QztFQUFYOzttQkFDVixJQUFBLEdBQVUsU0FBQyxPQUFEO1dBQWEsSUFBQyxDQUFBLElBQUssQ0FBQSxJQUFDLENBQUEsS0FBRCxDQUFPLE9BQVAsQ0FBQTtFQUFuQjs7bUJBQ1YsT0FBQSxHQUFVLFNBQUMsS0FBRDtJQUFXLElBQUcsS0FBQSxZQUFpQixNQUFwQjthQUFnQyxNQUFoQztLQUFBLE1BQUE7YUFBK0MsSUFBQSxNQUFBLENBQU8sQ0FBQyxL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bnQiOlsiIyBodHRwczovL2dpdGh1Yi5jb20vc2hpZmZtYW4vTmV1cmFsLU5ldHdvcmstcDVcclxuIyBodHRwczovL2RvY3Muc2NpcHkub3JnL2RvYy9udW1weS1kZXYvdXNlci9xdWlja3N0YXJ0Lmh0bWxcclxuXHJcbmV4cGFuZCA9ICh0YXJnZXQsbikgLT5cclxuXHRiaWcgPSBbXVxyXG5cdHRhcmdldCA9IHRhcmdldC5zbGljZSgpLnJldmVyc2UoKVxyXG5cdGZvciBpbmRleCBpbiByYW5nZSBuXHJcblx0XHRzbWFsbCA9IFtdXHJcblx0XHRmb3IgYSBpbiB0YXJnZXRcclxuXHRcdFx0c21hbGwudW5zaGlmdCBpbmRleCAlIGFcclxuXHRcdFx0aW5kZXggLy89IGFcclxuXHRcdGJpZy5wdXNoIHNtYWxsXHJcblx0YmlnXHJcblxyXG5jbGFzcyBNYXRyaXggIyBhbnkgRFxyXG5cdGNvbnN0cnVjdG9yIDogKEBkYXRhKSAtPiBAc2hhcGUgPSBbQGRhdGEubGVuZ3RoXVxyXG5cdHJlc2hhcGUgOiAoQHNoYXBlKSAtPiBAXHJcblx0bWFwICAgICA6IChmKSAtPiBuZXcgTWF0cml4KChmIHggZm9yIHggaW4gQGRhdGEpKS5yZXNoYXBlIEBzaGFwZVxyXG5cdGNlbGwgICAgOiAoaW5kaWNlcykgLT4gQGRhdGFbQGluZGV4IGluZGljZXNdXHJcblx0Zml4RGF0YSA6IChvdGhlcikgLT4gaWYgb3RoZXIgaW5zdGFuY2VvZiBNYXRyaXggdGhlbiBvdGhlciBlbHNlIG5ldyBNYXRyaXggW290aGVyXVxyXG5cdHRvQXJyYXkgOiAtPiBAZGF0YVxyXG5cdGNvcHkgICAgOiAtPiBuZXcgTWF0cml4KEBkYXRhKS5yZXNoYXBlIEBzaGFwZVxyXG5cdHJhbmRpbnQgOiAobj0xMCkgLT4gTWF0aC5mbG9vciBuICogTWF0aC5yYW5kb20oKVxyXG5cdGFkZCAgICAgOiAob3RoZXIpIC0+IEBicm9hZGNhc3Qgb3RoZXIsIChhLGIpIC0+IGEgKyBiXHJcblx0c3ViICAgICA6IChvdGhlcikgLT4gQGJyb2FkY2FzdCBvdGhlciwgKGEsYikgLT4gYSAtIGJcclxuXHRtdWwgICAgIDogKG90aGVyKSAtPiBAYnJvYWRjYXN0IG90aGVyLCAoYSxiKSAtPiBhICogYlxyXG5cclxuXHRicm9hZGNhc3QgOiAob3RoZXIsZikgLT5cclxuXHRcdG90aGVyID0gQGZpeERhdGEgb3RoZXJcclxuXHRcdGEgPSBAc2hhcGVcclxuXHRcdGIgPSBvdGhlci5zaGFwZVxyXG5cdFx0YW50YWwgPSBNYXRoLm1heCBhLmxlbmd0aCxiLmxlbmd0aFxyXG5cdFx0dGFyZ2V0ID0gKE1hdGgubWF4IGFbaV18fDEsIGJbaV18fDEgZm9yIGkgaW4gcmFuZ2UgYW50YWwpXHJcblx0XHRuID0gdGFyZ2V0LnJlZHVjZSAoKGEsYikgLT4gYSAqIGIpLCAxXHJcblx0XHRkYXRhID0gKGYgQGNlbGwoaW5kaWNlcyksIG90aGVyLmNlbGwoaW5kaWNlcykgZm9yIGluZGljZXMgaW4gZXhwYW5kIHRhcmdldCxuKVxyXG5cdFx0bmV3IE1hdHJpeChkYXRhKS5yZXNoYXBlIHRhcmdldFxyXG5cclxuXHRtYXRyaXggOiAoc2hhcGU9QHNoYXBlLnNsaWNlKCksIGRhdGE9QGRhdGEpIC0+XHJcblx0XHRpZiBzaGFwZS5sZW5ndGg9PTEgdGhlbiByZXR1cm4gZGF0YVxyXG5cdFx0YXJnID0gc2hhcGUucG9wKClcclxuXHRcdEBtYXRyaXggc2hhcGUsIChkYXRhW2kuLi5pK2FyZ10gZm9yIGkgaW4gcmFuZ2UgMCxkYXRhLmxlbmd0aCxhcmcpXHJcblxyXG5cdGluZGV4IDogKGluZGljZXMpIC0+XHJcblx0XHRyZXMgPSAwXHJcblx0XHRmb3IgYXJnLGkgaW4gaW5kaWNlc1xyXG5cdFx0XHRyZXMgKj0gQHNoYXBlW2ldfHwxXHJcblx0XHRcdHJlcyArPSBpZiAoQHNoYXBlW2ldfHwxKSA9PSAxIHRoZW4gMCBlbHNlIGFyZ1xyXG5cdFx0cmVzXHJcblxyXG5cdHRyYW5zcG9zZSA6IC0+ICMgMkQgb25seVxyXG5cdFx0ZGF0YSA9IChkYXRhfHxbXSkuY29uY2F0IChAY2VsbCBbaixpXSBmb3IgaiBpbiByYW5nZSBAc2hhcGVbMF0pIGZvciBpIGluIHJhbmdlIEBzaGFwZVsxXVxyXG5cdFx0bmV3IE1hdHJpeChkYXRhKS5yZXNoYXBlIFtAc2hhcGVbMV0sQHNoYXBlWzBdXVxyXG5cclxuXHRkb3QgOiAob3RoZXIpIC0+ICMgMkQgb25seVxyXG5cdFx0c3VtID0gKGksaikgPT4gKEBjZWxsKFtpLGtdKSAqIG90aGVyLmNlbGwoW2ssal0pIGZvciBrIGluIHJhbmdlIEBzaGFwZVsxXSkucmVkdWNlICgoYSwgYikgLT4gYSArIGIpLCAwXHJcblx0XHRuZXcgTWF0cml4KF8uZmxhdHRlbigoc3VtKGosaSkgZm9yIGkgaW4gcmFuZ2UgQHNoYXBlWzBdIGZvciBqIGluIHJhbmdlIG90aGVyLnNoYXBlWzFdKSkpLnJlc2hhcGUgW0BzaGFwZVswXSwgb3RoZXIuc2hhcGVbMV1dXHJcbiJdfQ==
//# sourceURL=C:\Lab\2017\055-Matrix\coffee\sketch.coffee