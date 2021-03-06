'use strict';

var _slicedToArray = function () { function sliceIterator(arr, i) { var _arr = []; var _n = true; var _d = false; var _e = undefined; try { for (var _i = arr[Symbol.iterator](), _s; !(_n = (_s = _i.next()).done); _n = true) { _arr.push(_s.value); if (i && _arr.length === i) break; } } catch (err) { _d = true; _e = err; } finally { try { if (!_n && _i["return"]) _i["return"](); } finally { if (_d) throw _e; } } return _arr; } return function (arr, i) { if (Array.isArray(arr)) { return arr; } else if (Symbol.iterator in Object(arr)) { return sliceIterator(arr, i); } else { throw new TypeError("Invalid attempt to destructure non-iterable instance"); } }; }();

// Generated by CoffeeScript 2.3.2
var AFS, C, FI, KD, L, M, MED, MP, N, RäknaRöster, S, SD, SkapaRöster, V, eliminera, partier, process, riksdag, riksdagsOmgång, röster, save, setup, summa, ÖVRIGA;

S = 0;

M = 1;

SD = 2;

C = 3;

V = 4;

KD = 5;

L = 6;

MP = 7;

FI = 8;

AFS = 9;

MED = 10;

ÖVRIGA = 11;

partier = [];

save = function save(namn, andel) {
  return partier.push({
    andel: andel,
    available: true,
    total: 0,
    namn: namn
  });
};

save('S', 28.26);

save('M', 19.84);

save('SD', 17.53);

save('C', 8.61);

save('V', 8.00);

save('KD', 6.32);

save('L', 5.49);

save('MP', 4.41);

save('FI', 0.46);

save('AfS', 0.31);

save('MED', 0.30);

save('Övriga', 0.47);

N = 7497123;

röster = [];

riksdagsOmgång = -1;

summa = 0;

process = function process(lst) {
  var andel = arguments.length > 1 && arguments[1] !== undefined ? arguments[1] : 1;

  var i, index, j, len, n, parti, ref, results;
  index = lst[0];
  parti = partier[index];
  n = round(parti.andel * andel * N / 100);
  ref = range(n);
  results = [];
  for (j = 0, len = ref.length; j < len; j++) {
    i = ref[j];
    results.push(röster.push(lst));
  }
  return results;
};

SkapaRöster = function SkapaRSter() {
  process([S]);
  process([M]);
  process([SD, V, S], 0.3);
  process([SD, KD, M], 0.7);
  process([C, S], 0.5);
  process([C, M], 0.5);
  process([V, S]);
  process([KD, M]);
  process([L, M]);
  process([MP, V, S], 0.7);
  process([MP, V, M], 0.3);
  process([FI, V, MP, S]);
  process([AFS, SD, M]);
  process([MED, SD, M]);
  process([ÖVRIGA]);
  röster = _.shuffle(röster);
  return print(röster.length + ' r\xF6ster inl\xE4sta');
};

RäknaRöster = function RKnaRSter() {
  var index, j, k, l, len, len1, len2, len3, m, p, parti, results, röst;
  for (j = 0, len = partier.length; j < len; j++) {
    parti = partier[j];
    parti.total = 0;
  }
  summa = 0;
  for (k = 0, len1 = röster.length; k < len1; k++) {
    röst = röster[k];
    for (l = 0, len2 = röst.length; l < len2; l++) {
      index = röst[l];
      if (partier[index].available) {
        partier[index].total++;
        summa++;
        break;
      }
    }
  }
  results = [];
  for (m = 0, len3 = partier.length; m < len3; m++) {
    p = partier[m];
    if (p.available) {
      results.push(print(nf(100 * p.total / summa, 0, 2) + '% ' + p.total + ' ' + p.namn));
    } else {
      results.push(void 0);
    }
  }
  return results;
};

eliminera = function eliminera(_ref) {
  var _ref2 = _slicedToArray(_ref, 2),
      antal = _ref2[0],
      index = _ref2[1];

  var parti;
  parti = partier[index];
  print('Tag bort ' + parti.namn + ' med ' + antal + ' r\xF6ster');
  return parti.available = false;
};

riksdag = function riksdag(omgång) {
  if (riksdagsOmgång !== -1) {
    return;
  }
  return riksdagsOmgång = omgång;
};

setup = function setup() {
  var antal, arr, i, index, j, len, omgång, parti, ref, störst;
  SkapaRöster();
  ref = range(partier.length - 1);
  for (j = 0, len = ref.length; j < len; j++) {
    omgång = ref[j];
    print('');
    print('------- Omg\xE5ng ' + omgång + ' --------');
    RäknaRöster();
    arr = function () {
      var k, len1, results;
      results = [];
      for (i = k = 0, len1 = partier.length; k < len1; i = ++k) {
        parti = partier[i];
        if (parti.total > 0) {
          results.push([parti.total, i]);
        }
      }
      return results;
    }();
    arr.sort(function (a, b) {
      return b[0] - a[0];
    });

    var _$last = _.last(arr);

    var _$last2 = _slicedToArray(_$last, 2);

    antal = _$last2[0];
    index = _$last2[1];

    if (antal >= 0.04 * summa) {
      riksdag(omgång);
    }

    var _arr$ = _slicedToArray(arr[0], 2);

    antal = _arr$[0];
    index = _arr$[1];

    störst = partier[index];
    print('');
    print('St\xF6rsta parti: ' + störst.namn + ' med ' + nf(antal / summa * 100, 0, 2) + '% av r\xF6sterna');
    eliminera(_.last(arr));
  }
  print('');
  print('======= SLUTRESULTAT ===========================================');

  var _arr$2 = _slicedToArray(arr[0], 2);

  antal = _arr$2[0];
  index = _arr$2[1];

  parti = partier[index];
  print('Regering: ' + parti.namn + ' med ' + nf(antal / summa * 100, 0, 2) + ' r\xF6ster');
  return print('Riksdag: Se Omg\xE5ng ' + riksdagsOmgång);
};
//# sourceMappingURL=sketch.js.map
