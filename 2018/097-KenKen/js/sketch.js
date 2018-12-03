'use strict';

function _toConsumableArray(arr) { if (Array.isArray(arr)) { for (var i = 0, arr2 = Array(arr.length); i < arr.length; i++) { arr2[i] = arr[i]; } return arr2; } else { return Array.from(arr); } }

// Generated by CoffeeScript 2.0.3
var ALFABET, N, arrayExcept, decr, f, g, incr, makePerms, match2, match3, match4, ok, _permute, sol6x6, sol7x7, sol9x9, solve, start, uniq, valid;

N = null;

ALFABET = ' ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz';

arrayExcept = function arrayExcept(arr, idx) {
  var res;
  res = arr.slice(0);
  res.splice(idx, 1);
  return res;
};

_permute = function permute(arr) {
  var _ref;

  var idx, perm, permutations, value;
  arr = Array.prototype.slice.call(arr, 0);
  if (arr.length === 0) {
    return [[]];
  }
  permutations = function () {
    var k, len, results;
    results = [];
    for (idx = k = 0, len = arr.length; k < len; idx = ++k) {
      value = arr[idx];
      results.push(function () {
        var l, len1, ref, results1;
        ref = _permute(arrayExcept(arr, idx));
        results1 = [];
        for (l = 0, len1 = ref.length; l < len1; l++) {
          perm = ref[l];
          results1.push([value].concat(perm));
        }
        return results1;
      }());
    }
    return results;
  }();
  return (_ref = []).concat.apply(_ref, _toConsumableArray(permutations));
};

assert([[1, 2, 3], [1, 3, 2], [2, 1, 3], [2, 3, 1], [3, 1, 2], [3, 2, 1]], _permute([1, 2, 3]));

f = function f(kenken) {
  var i, k, key, l, len, len1, letter, res;
  res = {};
  for (k = 0, len = kenken.length; k < len; k++) {
    letter = kenken[k];
    res[letter] = [];
  }
  for (i = l = 0, len1 = kenken.length; l < len1; i = ++l) {
    key = kenken[i];
    res[key].push(i);
  }
  return res;
};

//        0123456789012345  
// rf =  f("abbcddecffgghhii")
// assert rf,
// 	a:[0]
// 	b:[1,2]
// 	c:[3,7]
// 	d:[4,5]
// 	e:[6]
// 	f:[8,9]
// 	g:[10,11]
// 	h:[12,13]
// 	i:[14,15]
uniq = function uniq(lst) {
  var i, item, k, len, res;
  res = [lst[0]];
  for (i = k = 0, len = lst.length; k < len; i = ++k) {
    item = lst[i];
    if (i > 0 && !_.isEqual(item, _.last(res))) {
      res.push(item);
    }
  }
  return res;
};

match2 = function match2(total, operation) {
  var a, b, k, l, len, len1, ref, ref1, res;
  res = [];
  ref = range(1, N + 1);
  for (k = 0, len = ref.length; k < len; k++) {
    a = ref[k];
    ref1 = range(1, N + 1);
    for (l = 0, len1 = ref1.length; l < len1; l++) {
      b = ref1[l];
      if (total === operation(a, b)) {
        res.push([a, b].sort());
      }
    }
  }
  return uniq(res.sort());
};

match3 = function match3(total, operation) {
  var a, b, c, k, l, len, len1, len2, m, ref, ref1, ref2, res;
  res = [];
  ref = range(1, N + 1);
  for (k = 0, len = ref.length; k < len; k++) {
    a = ref[k];
    ref1 = range(1, N + 1);
    for (l = 0, len1 = ref1.length; l < len1; l++) {
      b = ref1[l];
      ref2 = range(1, N + 1);
      for (m = 0, len2 = ref2.length; m < len2; m++) {
        c = ref2[m];
        if (total === operation(a, b, c)) {
          res.push([a, b, c].sort());
        }
      }
    }
  }
  return uniq(res.sort());
};

match4 = function match4(total, operation) {
  var a, b, c, d, k, l, len, len1, len2, len3, m, n, ref, ref1, ref2, ref3, res;
  res = [];
  ref = range(1, N + 1);
  for (k = 0, len = ref.length; k < len; k++) {
    a = ref[k];
    ref1 = range(1, N + 1);
    for (l = 0, len1 = ref1.length; l < len1; l++) {
      b = ref1[l];
      ref2 = range(1, N + 1);
      for (m = 0, len2 = ref2.length; m < len2; m++) {
        c = ref2[m];
        ref3 = range(1, N + 1);
        for (n = 0, len3 = ref3.length; n < len3; n++) {
          d = ref3[n];
          if (total === operation(a, b, c, d)) {
            res.push([a, b, c, d].sort());
          }
        }
      }
    }
  }
  return uniq(res.sort());
};

g = function g(rf, ops) {
  // gets possible operands
  var key, res, total;
  res = {};
  for (key in rf) {
    total = parseInt(ops[key]);
    switch (rf[key].length) {
      case 1:
        res[key] = [[total]];
        break;
      case 2:
        switch (_.last(ops[key])) {
          case '/':
            res[key] = match2(total, function (a, b) {
              return Math.floor(a / b);
            });
            break;
          case '+':
            res[key] = match2(total, function (a, b) {
              return a + b;
            });
            break;
          case '*':
            res[key] = match2(total, function (a, b) {
              return a * b;
            });
            break;
          case '-':
            res[key] = match2(total, function (a, b) {
              return a - b;
            });
        }
        break;
      case 3:
        switch (_.last(ops[key])) {
          case '+':
            res[key] = match3(total, function (a, b, c) {
              return a + b + c;
            });
            break;
          case '*':
            res[key] = match3(total, function (a, b, c) {
              return a * b * c;
            });
        }
        break;
      case 4:
        switch (_.last(ops[key])) {
          case '+':
            res[key] = match4(total, function (a, b, c, d) {
              return a + b + c + d;
            });
            break;
          case '*':
            res[key] = match4(total, function (a, b, c, d) {
              return a * b * c * d;
            });
        }
        break;
      default:
        print('Problem!');
    }
  }
  return res;
};

// rg = g rf,
// 	a: '4'
// 	b: '2/'
// 	c: '12*'
// 	d: '1-'
// 	e: '3'
// 	f: '7+'
// 	g: '2/'
// 	h: '1-'
// 	i: '3-'

// assert rg,
// 	a: [[4]]
// 	b: [[1,2],[2,4]]
// 	c: [[3,4]]
// 	d: [[1,2],[2,3],[3,4]]
// 	e: [[3]]
// 	f: [[3,4]]
// 	g: [[1,2],[2,4]]
// 	h: [[1,2],[2,3],[3,4]]
// 	i: [[1,4]]
makePerms = function makePerms(rg) {
  // adds permutations
  var a, k, key, len, lst, pair, res;
  res = {};
  for (key in rg) {
    lst = rg[key];
    a = [];
    for (k = 0, len = lst.length; k < len; k++) {
      pair = lst[k];
      a = a.concat(_permute(pair));
    }
    res[key] = uniq(a.sort());
  }
  return res;
};

// rp = makePerms rg
// assert rp,
// 	a: [[4]]
// 	b: [[1,2],[2,1],[2,4],[4,2]]
// 	c: [[3,4],[4,3]]
// 	d: [[1,2],[2,1],[2,3],[3,2],[3,4],[4,3]]
// 	e: [[3]]
// 	f: [[3,4],[4,3]]
// 	g: [[1,2],[2,1],[2,4],[4,2]]
// 	h: [[1,2],[2,1],[2,3],[3,2],[3,4],[4,3]]
// 	i: [[1,4],[4,1]]
ok = function ok(lst) {
  lst = _.without(lst, 0);
  return lst.length === _.uniq(lst).length;
};

assert([1, 2, 3, 4], _.uniq([1, 2, 3, 4]));

assert(true, ok([1, 2, 3, 4]));

assert(false, ok([1, 2, 2, 4]));

assert(true, ok([0, 0, 0, 0]));

assert(true, ok([4, 0, 0, 1]));

assert(false, ok([4, 0, 0, 4]));

valid = function valid(indexes, pointer, rf, rp) {
  // 1..4 must be unique in each row and col. 0 is ok
  var col, grid, i, j, k, l, len, len1, len2, len3, m, n, p, ref, ref1, ref2, ref3, row, x, y;
  if (pointer === ' ') {
    return true;
  }
  grid = function () {
    var k, len, ref, results;
    ref = range(N * N);
    results = [];
    for (k = 0, len = ref.length; k < len; k++) {
      i = ref[k];
      results.push(0);
    }
    return results;
  }();
  ref = ALFABET.slice(1, 1 + ALFABET.indexOf(pointer));
  for (k = 0, len = ref.length; k < len; k++) {
    p = ref[k];
    ref1 = rf[p];
    for (j = l = 0, len1 = ref1.length; l < len1; j = ++l) {
      x = ref1[j];
      y = rp[p][indexes[p]][j];
      grid[x] = y;
    }
  }
  ref2 = range(N);
  for (m = 0, len2 = ref2.length; m < len2; m++) {
    row = ref2[m];
    if (!ok(function () {
      var len3, n, ref3, results;
      ref3 = range(row * N, row * N + N);
      results = [];
      for (n = 0, len3 = ref3.length; n < len3; n++) {
        i = ref3[n];
        results.push(grid[i]);
      }
      return results;
    }())) {
      return false;
    }
  }
  ref3 = range(N);
  for (n = 0, len3 = ref3.length; n < len3; n++) {
    col = ref3[n];
    if (!ok(function () {
      var len4, o, ref4, results;
      ref4 = range(col, N * N, N);
      results = [];
      for (o = 0, len4 = ref4.length; o < len4; o++) {
        i = ref4[o];
        results.push(grid[i]);
      }
      return results;
    }())) {
      return false;
    }
  }
  return true;
};

//assert true, valid {a:-1,b:-1,c:-1,d:-1,e:-1,f:-1,g:-1,h:-1,i:-1}, ' ', rf, rp	
//assert true, valid {a:0, b:0,c:0,d:0,e:0,f:0,g:0,h:2,i:1}, 'i', rf, rp	
incr = function incr(pointer) {
  return ALFABET[ALFABET.indexOf(pointer) + 1];
};

decr = function decr(pointer) {
  return ALFABET[ALFABET.indexOf(pointer) - 1];
};

assert('b', incr('a'));

assert('a', decr('b'));

solve = function solve(kenken, ops) {
  var flag, indexes, key, pointer, rf, rg, rp, stopper;
  N = Math.sqrt(kenken.length);
  rf = f(kenken);
  rg = g(rf, ops);
  rp = makePerms(rg);
  indexes = {};
  for (key in ops) {
    indexes[key] = -1;
  }
  pointer = 'A';
  indexes['A'] = 0;
  stopper = ALFABET[1 + _.size(ops)];
  while (pointer !== ' ' && pointer !== stopper) {
    flag = indexes[pointer] < rp[pointer].length;
    if (flag && valid(indexes, pointer, rf, rp)) {
      pointer = incr(pointer);
      if (pointer < stopper) {
        indexes[pointer]++;
      }
    } else if (indexes[pointer] < rp[pointer].length - 1) {
      indexes[pointer]++;
      if (pointer < indexes.length) {
        indexes[incr(pointer)] = -1;
      }
    } else {
      indexes[pointer] = -1;
      pointer = decr(pointer);
      indexes[pointer]++;
    }
  }
  return indexes;
};

start = Date.now();

assert({
  A: 0,
  B: 0,
  C: 0,
  D: 0,
  E: 0
}, solve("ABBACDEED", {
  A: '5+',
  B: '3/',
  C: '2',
  D: '1-',
  E: '2-'
}));

assert({
  A: 0,
  B: 0,
  C: 0,
  D: 0,
  E: 0,
  F: 0,
  G: 0,
  H: 2,
  I: 1
}, solve("ABBCDDECFFGGHHII", {
  A: '4',
  B: '2/',
  C: '12*',
  D: '1-',
  E: '3',
  F: '7+',
  G: '2/',
  H: '1-',
  I: '3-'
}));

assert({
  A: 0,
  B: 5,
  C: 3,
  D: 2,
  E: 2,
  F: 0,
  G: 5,
  H: 0
}, solve("AABBCDEFCDEGHHGG", {
  A: '2/',
  B: '1-',
  C: '2/',
  D: '4+',
  E: '1-',
  F: '1',
  G: '8*',
  H: '7+'
}));

sol6x6 = {
  A: 1,
  B: 13,
  C: 2,
  D: 7,
  E: 4,
  F: 3,
  G: 2,
  H: 4,
  I: 0,
  J: 4,
  K: 0,
  L: 1,
  M: 3,
  N: 4,
  O: 10,
  P: 3,
  Q: 0
};

assert(sol6x6, solve("AABCCDEEBBDDFFGGHIJFLMHNJKLMONPPQQOO", {
  A: '11+',
  B: '11+',
  C: '3/',
  D: '12*',
  E: '1-',
  F: '6*',
  G: '5+',
  H: '3-',
  I: '4',
  J: '7+',
  K: '3',
  L: '11+',
  M: '5+',
  N: '2/',
  O: '12+',
  P: '6+',
  Q: '5-'
}));

sol7x7 = {
  A: 1,
  B: 16,
  C: 2,
  D: 6,
  E: 0,
  F: 7,
  G: 2,
  H: 4,
  I: 0,
  J: 8,
  K: 1,
  L: 0,
  M: 0,
  N: 2,
  O: 5,
  P: 5,
  Q: 5,
  R: 3,
  S: 4,
  T: 1,
  U: 10,
  V: 2
};

assert(sol7x7, solve("AABBCDDEFBBCGHEFIJJGHKLIMJNOKPPMNNOQRSSSTUQRVVVTU", {
  A: '6-',
  B: '360*',
  C: '5-',
  D: '2/',
  E: '15*',
  F: '3-',
  G: '1-',
  H: '6+',
  I: '13+',
  J: '12+',
  K: '3+',
  L: '6',
  M: '8+',
  N: '120*',
  O: '1-',
  P: '3-',
  Q: '2-',
  R: '1-',
  S: '8+',
  T: '6-',
  U: '1-',
  V: '60*'
}));

sol9x9 = {
  A: 6,
  B: 1,
  C: 41,
  D: 18,
  E: 13,
  F: 19,
  G: 1,
  H: 4,
  I: 5,
  J: 13,
  K: 57,
  L: 0,
  M: 33,
  N: 2,
  O: 2,
  P: 201,
  Q: 8,
  R: 0,
  S: 4,
  T: 1,
  U: 19,
  V: 0,
  W: 47,
  X: 0,
  Y: 50,
  Z: 16,
  a: 0,
  b: 1,
  c: 5,
  d: 2,
  e: 6,
  f: 18,
  g: 0,
  h: 4 //4563ms
};

//assert sol9x9, solve "ABCCCDDEEABFGGHDEEIIFJJHKKKLMFNOOPQQLMRNSPPTTUMRVSPWWXUUYYZaaWXbbYcZZddefffcgghhe",  {A:'3-',B:'8+',C:'16+',D:'9+',E:'33+',F:'10+',G:'3+',H:'7+',I:'7+',J:'1-',K:'16+',L:'8-',M:'18+',N:'16+',O:'9+',P:'21+',Q:'4-',R:'8-',S:'2-',T:'3-',U:'16+',V:'5',W:'17+',X:'7+',Y:'16+',Z:'22+',a:'3+',b:'7-',c:'7+',d:'4+',e:'9+',f:'13+',g:'17+',h:'12+'}
print('Ready!', Date.now() - start);
//# sourceMappingURL=sketch.js.map
