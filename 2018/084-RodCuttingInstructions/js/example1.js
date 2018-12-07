'use strict';

// Generated by CoffeeScript 2.0.3
var c, fixa, g1, indexen, makeCommands, v;

indexen = [1, 2, 3, 4, 5, 6, 7, 8, 9, 10];

v = [1, 5, 8, 9, 0, 0, 0, 0, 0, 0];

c = [0, 0, 0, 0, 0, 0, 0, 0, 0, 0];

g1 = null;

//indexes = null
fixa = function fixa(i, value) {
  var j, k, l, len, ref, x;
  x = i + 1.5;
  g1.add(new Text(indexen[i], x, 0, 'i=' + (i + 1)));
  g1.add(new Text(v[i], x, 1, 'v[' + (i + 1) + '] = ' + v[i]));
  g1.add(new Text(v[i], x, 4, 'Kopiera ner v[' + (i + 1) + ']'));
  ref = range(i);
  for (l = 0, len = ref.length; l < len; l++) {
    j = ref[l];
    k = i - j - 1;
    g1.add(new Text(v[j], j + 1.5, 1, 'Summera v[' + (j + 1) + '] = ' + v[j] + ' ...'));
    g1.add(new Text(c[k], k + 1.5, 2, '... och c[' + (k + 1) + '] = ' + c[k]));
    g1.add(new Text(v[j] + c[k], x, j + 5, v[j] + ' + ' + c[k] + ' = ' + (v[j] + c[k])));
  }
  g1.add(new Text(value, x, 2, value + ' \xE4r st\xF6rst'));
  return c[i] = value;
};

makeCommands = function makeCommands() {
  g1 = new Grid(8, 4, 4, 1, 11, 3, true, 'Rod Cutting: Använd piltangenterna eller mushjulet');
  g1.add(new Text('i', 0.5, 0, "indexraden (samma som storlek)"));
  g1.add(new Text('v', 0.5, 1, "värderaden (priset för en bit med en viss storlek)"));
  g1.add(new Text('c', 0.5, 2, "c-raden (det korrigerade värdet, efter uppdelning)"));
  fixa(0, 1);
  fixa(1, 5);
  fixa(2, 8);
  fixa(3, 10);
  fixa(4, 13);
  fixa(5, 16);
  fixa(6, 18);
  fixa(7, 21);
  fixa(8, 24);
  return fixa(9, 26);
};
//# sourceMappingURL=example1.js.map