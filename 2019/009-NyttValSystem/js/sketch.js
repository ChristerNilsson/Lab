'use strict';

// Generated by CoffeeScript 2.3.2
var N, RäknaRöster, SkapaRöster, partier, röster, save, setup;

partier = [];

save = function save(namn, andel) {
  return partier.push({
    andel: andel,
    available: true,
    total: 0,
    namn: namn
  });
};

save('Socialdemokraterna', 28.26);

save('Moderaterna', 19.84);

save('SverigeDemokraterna', 17.53);

save('Centern', 8.61);

save('Vänsterpartiet', 8.00);

save('Kristdemokraterna', 6.32);

save('Liberalerna', 5.49);

save('Miljöpartiet', 4.41);

save('Feministerna', 0.46);

save('AfS', 0.31);

N = 7497123;

röster = [];

SkapaRöster = function SkapaRSter() {
  var i, index, j, k, len, len1, n, parti, ref;
  for (index = j = 0, len = partier.length; j < len; index = ++j) {
    parti = partier[index];
    n = int(parti.andel * N / 100);
    ref = range(n);
    for (k = 0, len1 = ref.length; k < len1; k++) {
      i = ref[k];
      switch (index) {
        case 0:
          röster.push([0]);
          break;
        case 1:
          röster.push([1]);
          break;
        case 2:
          röster.push(random() < 0.3 ? [2, 5, 0] : [2, 5, 1]);
          break;
        case 3:
          röster.push(random() < 0.5 ? [3, 0] : [3, 1]);
          break;
        case 4:
          röster.push([4, 0]);
          break;
        case 5:
          röster.push([5, 1]);
          break;
        case 6:
          röster.push([6, 1]);
          break;
        case 7:
          röster.push(random() < 0.7 ? [7, 4, 0] : [7, 4, 1]);
          break;
        case 8:
          röster.push([8, 4, 7, 0]);
          break;
        case 9:
          röster.push([9, 2, 1]);
      }
    }
  }
  röster = _.shuffle(röster);
  return print(N + ' r\xF6ster inl\xE4sta');
};

RäknaRöster = function RKnaRSter() {
  var index, j, k, l, len, len1, len2, len3, m, p, parti, results, röst;
  for (j = 0, len = partier.length; j < len; j++) {
    parti = partier[j];
    parti.total = 0;
  }
  for (k = 0, len1 = röster.length; k < len1; k++) {
    röst = röster[k];
    for (l = 0, len2 = röst.length; l < len2; l++) {
      index = röst[l];
      if (partier[index].available) {
        partier[index].total++;
        break;
      }
    }
  }
  results = [];
  for (m = 0, len3 = partier.length; m < len3; m++) {
    p = partier[m];
    if (p.available) {
      results.push(print(p.andel + '% ' + p.total + ' ' + p.namn));
    } else {
      results.push(void 0);
    }
  }
  return results;
};

setup = function setup() {
  var arr, i, index, j, len, parti, ref, summa;
  SkapaRöster();
  ref = range(10);
  for (j = 0, len = ref.length; j < len; j++) {
    i = ref[j];
    print('');
    print('------- Omg\xE5ng ' + i + ' --------');
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
    arr.sort(function (item) {
      return item[0];
    });
    //print 'Partierna',arr
    summa = röster.length; // _.reduce arr, ((sum,pair) -> sum+pair[0]),0
    parti = arr[0];
    print('');
    print('St\xF6rsta parti: ' + partier[parti[1]].namn + ' med ' + nf(parti[0] / summa * 100, 0, 1) + '% av r\xF6sterna');
    //print 'summa',summa 
    if (_.last(arr)[0] > summa / 2) {
      break;
    }
    parti = _.last(arr);
    print('Tag bort ' + partier[parti[1]].namn + ' med ' + parti[0] + ' r\xF6ster');
    partier[parti[1]].available = false;
  }
  //print partier
  print('====================================================');
  index = arr[0][1];
  return print('Slutlig segrare: ' + partier[index].namn + ' med ' + nf(parti[index] / summa * 100, 0, 1) + ' r\xF6ster');
};
//# sourceMappingURL=sketch.js.map
