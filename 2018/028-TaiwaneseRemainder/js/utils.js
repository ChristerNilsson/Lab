'use strict';

// Generated by CoffeeScript 2.0.3
var copyToClipboard, createProblem, createRests;

createRests = function createRests(ticks, total) {
  var j, len, results, t;
  results = [];
  for (j = 0, len = ticks.length; j < len; j++) {
    t = ticks[j];
    results.push(total % t);
  }
  return results;
};

createProblem = function createProblem(steps) {
  var antal, h, i, pathname, primes, rests, ticks, total, url;
  primes = [2, 3, 5, 7, 11, 13, 17, 19, 23, 29, 31, 37, 41, 43, 47, 53, 59, 61, 67, 71, 73, 79, 83, 89, 97];
  antal = int(map(steps, 1, 125, 4, 25));
  ticks = _.sample(primes.slice(0, +antal + 1 || 9e9), 2 + Math.floor(steps / 5));
  ticks.sort(function (a, b) {
    return a - b;
  });
  //ticks = [3,5]
  total = function () {
    var j, len, ref, results;
    ref = range(steps);
    results = [];
    for (j = 0, len = ref.length; j < len; j++) {
      i = ref[j];
      results.push(_.sample(ticks));
    }
    return results;
  }().reduce(function (a, b) {
    return a + b;
  });
  rests = createRests(ticks, total);
  h = window.location.href;
  pathname = h.split('?')[0];
  url = pathname + '?steps=' + steps + '&ticks=' + ticks + '&rests=' + rests;
  print(url);
  return { steps: steps, ticks: ticks, rests: rests, url: url };
};

copyToClipboard = function copyToClipboard(s) {
  var el;
  el = document.createElement('textarea');
  el.value = s;
  document.body.appendChild(el);
  el.select();
  document.execCommand('copy');
  return document.body.removeChild(el);
};
//# sourceMappingURL=utils.js.map
