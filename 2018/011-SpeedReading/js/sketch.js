"use strict";

// Generated by CoffeeScript 2.0.3
var arr, data, draw, fr, iLetter, iWord, limit, mousePressed, setup;

data = "Inför köttfri dag i skolan!\nPå vår skola serveras det varje dag någon typ av kött i matsalen. Är det inte\nhamburgare eller bacon så är det köttbullar och korvar av olika slag. Men\nbehöver vi verkligen ha kött varje dag? Nej, vi vill att skolan inför minst en\nköttfri dag en gång i veckan.\nVarför?\nFör det första är det inte miljövänligt att äta kött. Det krävs tio gånger\nmer energi för att producera kött än vad det krävs för att producera\ngrönsaker.\nFör det andra är det nyttigt att ha en köttfri dag. Enligt Livsmedelsverket\nkan vi sänka vårt intag av kött med hälften och fortfarande må bra.\nFör det tredje skulle en köttfri dag i veckan leda till att efterfrågan på\nkött skulle minska. Detta skulle i sin tur leda till bättre djurhållning och\nmindre lidande för djuren. En köttfri dag leder alltså till tre goda ting: Bättre\nmiljö, bättre hälsa och bättre djurhållning. Nu kanske några menar att det\nräcker med att använda ekologiskt kött istället för importerat. Men fakta\nkvarstår fortfarande. En köttfri dag i veckan är bättre! Däremot får skolan\ngärna servera ekologiskt kött de andra fyra dagarna!\nVår förhoppning är att alla skolor i kommunen från och med nästa\ntermin inför en köttfri dag. Vi uppmanar alla elevråd i kommunen att kräva\nen köttfri dag i skolan!\nMiljövännen, Hälsofreaket och Djurrättsaktivisten";

arr = null;

iWord = 0;

iLetter = 0;

limit = 0;

fr = 1;

setup = function setup() {
  createCanvas(200, 200);
  data = data.replace(/\n/g, " ");
  arr = data.split(' ');
  textAlign(CENTER, CENTER);
  textSize(20);
  return frameRate(fr);
};

draw = function draw() {
  if (iLetter >= limit && iWord < arr.length) {
    bg(0);
    fc(1, 1, 0);
    text(arr[iWord], 100, 100);
    iLetter = 0;
    limit = 1 + arr[iWord].length;
    iWord++;
    fc(0.5);
    text(fr + " tecken per sekund", 100, 180);
  } else {
    iLetter++;
  }
  fr = Math.ceil((1 + mouseX) / 10);
  return frameRate(fr);
};

mousePressed = function mousePressed() {
  return iWord = 0;
};
//# sourceMappingURL=sketch.js.map