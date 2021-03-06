"use strict";

// Generated by CoffeeScript 2.0.3
var g0, g1, g2, indexes, makeCommands, rests, ticks;

ticks = [2, 3, 5, 7];

rests = [1, 1, 0, 4];

// summa 25
// steps 9
g0 = null;

g1 = null;

g2 = null;

indexes = null;

makeCommands = function makeCommands() {
  var i, j, k, len, len1, ref, ref1;
  g0 = new Grid(0, 0, 1, 1, 100, 30, false, 'Taiwanese Remainder 3: Använd piltangenterna eller mushjulet');
  g0.add(new Text("Exempel 3:", 0, 0, "Tag reda på vilka klockor man ska klicka på"));
  g0.add(new Text("Klockor: [" + ticks + "]", 12, 0));
  g0.add(new Text("Rester:  [" + rests + "]", 12, 1));
  g0.add(new Text("Steg: 9", 12, 2));
  g0.add(new Text("(% innebär modulo, dvs resten vid heltalsdivision)", 22, 2));
  g0.add(new Text("Lösning:", 0, 3));
  g1 = new Grid(0, 4, 4, 1, 7, ticks.length, true, 'Chinese Remainders');
  ref = range(ticks.length);
  for (j = 0, len = ref.length; j < len; j++) {
    i = ref[j];
    g1.add(new Text(ticks[i], -1, i, "Klocka " + ticks[i]));
  }
  ref1 = range(rests.length);
  for (k = 0, len1 = ref1.length; k < len1; k++) {
    i = ref1[k];
    g1.add(new Text(rests[i], -2, i, "Rest " + rests[i]));
  }
  g1.verLine(2, 3);
  g1.add(new Text(5, -3, 2, "Vrid näst största klockan (5). 5 + 0 = 5"));
  g1.add(new Text(11, -3, 3, "Vrid största klockan (7). 7 + 4 = 11"));
  g1.add(new Text(10, -4, 2, "Vrid klockan med näst störst värde (5). 5 + 5 = 10"));
  g1.add(new Text(15, -5, 2, "Vrid klockan med näst störst värde (10). 5 + 10 = 15"));
  g1.add(new Text(18, -4, 3, "Vrid klockan med näst störst värde (11). 11 + 7 = 18"));
  g1.add(new Text(20, -6, 2, "Vrid klockan med näst störst värde"));
  g1.add(new Text(25, -5, 3, "Vrid klockan med näst störst värde"));
  g1.add(new Text(25, -7, 2, "Vrid klockan med näst störst värde"));
  g1.add(new Text('', 0, 0, "De två största klockorna har nu samma värde. Summa=25"));
  g1.add(new Text('', 0, 0, "Kontrollera att alla klockor uppfyller summa % klocka = rest"));
  g1.add(new Text('ok', 7.5, 0, "25 % 2 = 1"));
  g1.add(new Text('ok', 7.5, 1, "25 % 3 = 1"));
  g1.add(new Text('ok', 7.5, 2, "25 % 5 = 0"));
  g1.add(new Text('ok', 7.5, 3, "25 % 7 = 4"));
  g1.add(new Text('Summa: 25', 7.5, 4, "Detta innebär att summan 25 är den vi söker"));
  g0.add(new Text('', 0, 0, "Nu skapar vi en tabell med summor och klockor"));
  g2 = new Grid(0, 9, 4, 1, ticks.length + 1, 9, true, 'Summatabell, lämplig för datoriserad lösning. Arbetskrävande.');
  g2.add(new Text(2, -2, 0, "klocka 2"));
  g2.add(new Text(3, -3, 0, "klocka 3"));
  g2.add(new Text(5, -4, 0, "klocka 5"));
  g2.add(new Text(7, -5, 0, "klocka 7"));
  g2.horLine(1, 3);
  g2.add(new Text(9, -2, 1, 'Vi börjar med att lägga alla nio stegen i minsta klockan'));
  g2.add(new Text(0, -3, 1));
  g2.add(new Text(0, -4, 1));
  g2.add(new Text(0, -5, 1));
  g2.add(new Text(18, -1, 1, 'Då får vi summan 9*2 = 18'));
  g2.add(new Text(19, -1, 2, 'Fyll i resten av summorna till målet 25'));
  g2.add(new Text(20, -1, 3));
  g2.add(new Text(21, -1, 4));
  g2.add(new Text(22, -1, 5));
  g2.add(new Text(23, -1, 6));
  g2.add(new Text(24, -1, 7));
  g2.add(new Text(25, -1, 8));
  g2.verLine(1, 3);
  g2.add(new Text('*', 5.5, 1, 'Vi börjar med första raden. Gör en tvåa till en trea, dvs +1'));
  g2.add(new Text(8, -2, 2, 'Summan blir 18+1 = 19'));
  g2.add(new Text(1, -3, 2));
  g2.add(new Text(0, -4, 2));
  g2.add(new Text(0, -5, 2));
  g2.add(new Text(8, -2, 4, 'Gör nu en tvåa till en femma, dvs 18+3 = 21'));
  g2.add(new Text(0, -3, 4));
  g2.add(new Text(1, -4, 4));
  g2.add(new Text(0, -5, 4));
  g2.add(new Text(8, -2, 6, 'Slutligen, gör en tvåa till en sjua, dvs 18+5 = 23'));
  g2.add(new Text(0, -3, 6));
  g2.add(new Text(0, -4, 6));
  g2.add(new Text(1, -5, 6));
  g2.add(new Text('ok', 6, 1, 'Markera att rad 18 är klar'));
  g2.add(new Text('*', 5.5, 2, 'Rad 19 blir nästa rad att hantera'));
  g2.add(new Text(7, -2, 3, 'Gör en tvåa till en trea. 19+1 = 20'));
  g2.add(new Text(2, -3, 3));
  g2.add(new Text(0, -4, 3));
  g2.add(new Text(0, -5, 3));
  g2.add(new Text(7, -2, 5, 'Gör en tvåa till en femma. 19+3 = 22'));
  g2.add(new Text(1, -3, 5));
  g2.add(new Text(1, -4, 5));
  g2.add(new Text(0, -5, 5));
  g2.add(new Text(7, -2, 7, 'Slutligen, gör en tvåa till en sjua. 19+5 = 24'));
  g2.add(new Text(1, -3, 7));
  g2.add(new Text(0, -4, 7));
  g2.add(new Text(1, -5, 7));
  g2.add(new Text('ok', 6, 2, 'Markera att rad 19 är klar'));
  g2.add(new Text('*', 5.5, 3, 'Gå vidare till rad 20'));
  g2.add(new Text(21, -1, 4, 'Rad 21: Redan klar'));
  g2.add(new Text(23, -1, 6, 'Rad 23: Redan klar'));
  g2.add(new Text(6, -2, 8, 'Rad 25: Gör en tvåa till en sjua. 20+5 = 25'));
  g2.add(new Text(2, -3, 8));
  g2.add(new Text(0, -4, 8));
  g2.add(new Text(1, -5, 8));
  g2.add(new Text('ok', 6, 3, 'Markera att rad 20 är klar'));
  g2.add(new Text('Vi har hittat målet, dvs summan 25', 6, 8));
  g0.add(new Text('Kontroll: 6*2 + 2*3 + 0*5 + 1*7 = 25  (6+2+0+1 = 9)', 0, 19));
  g0.add(new Text('Svar: Klicka [6,2,0,1] på klockorna [2,3,5,7]', 0, 21));
  return indexes = [g0.index, g1.index, g2.index];
};
//# sourceMappingURL=example3.js.map
