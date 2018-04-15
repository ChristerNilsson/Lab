'use strict';

// Generated by CoffeeScript 2.0.3
var assert, _spacesToTabs, transpile;

assert = function assert(a) {
  var b = arguments.length > 1 && arguments[1] !== undefined ? arguments[1] : true;

  if (!_.isEqual(a, b)) {
    return print(JSON.stringify(a) + " != " + JSON.stringify(b));
  }
};

_spacesToTabs = function spacesToTabs(line) {
  if (line.indexOf('  ') === 0) {
    return '\t' + _spacesToTabs(line.substring(2));
  }
  if (line.indexOf('\t') === 0) {
    return '\t' + _spacesToTabs(line.substring(1));
  }
  if (line.indexOf(' \t') === 0) {
    return '\t' + _spacesToTabs(line.substring(2));
  }
  return line;
};

assert(_spacesToTabs('    '), '\t\t');

assert(_spacesToTabs('\t  '), '\t\t');

assert(_spacesToTabs('  \t'), '\t\t');

assert(_spacesToTabs(' \t  '), '\t\t');

transpile = function transpile(code) {
  var line, lines, temp;
  lines = code.split('\n');
  temp = function () {
    var i, len, results;
    results = [];
    for (i = 0, len = lines.length; i < len; i++) {
      line = lines[i];
      results.push(_spacesToTabs(line));
    }
    return results;
  }();
  code = temp.join('\n');
  return CoffeeScript.compile(code, {
    bare: true
  });
};
//# sourceMappingURL=transpile.js.map