// Generated by CoffeeScript 2.0.3
  // Yttre ringen hanterar måndag=1
  // Inre ringen hanterar fredag=5
  // Varje ämne har en egen färg
  // Pågående lektion markeras med ett streck.
  // I mitten visas tid kvar tills lektion börjar eller slutar.
  // Där visas även ämne, sal, starttid samt sluttid

  // Day Subject hhmm hhmm Room ;
  // Mo08300930MaS323 => Day=Mo start=0830 stopp=0930 Subject=Ma Room=S323
  //     0123456789012345
var arg, colors, draw, info, minutes, myarc, myline, pretty, rad, schema, setup, unpack,
  indexOf = [].indexOf,
  modulo = function(a, b) { return (+a % (b = +b) + b) % b; };

arg = 'Mo08300930MaS323;Mo09401040SvS218;Mo12401350FyS142;';

arg += 'Tu08300955EnS324;Tu12151325MaP957;';

arg += 'We10351125FyP315;We12151325MaQ323;We13501450IdQ957;';

arg += 'Th13001425EnQ232;Th14351555SvS546;';

arg += 'Fr08300930MaS434;Fr11051200FyP957';

// http://christernilsson.github.io/Lab/2017/082-CalendarClock/index.html?s=Mo08300930MaS323;Mo09401040SvS218;Mo12401350FyS142;Tu08300955EnS324;Tu12151325MaP957;We10351125FyP315;We12151325MaQ323;We13501450IdQ957;Th13001425EnQ232;Th14351555SvS546;Fr08300930MaS434;Fr11051200FyP957'
schema = [];

colors = {};

unpack = function(arg) {
  var arr, c, day, hhmm1, hhmm2, i, item, len, n, res, room, subject, t1, t2;
  arr = arg.split(';');
  res = [];
  for (i = 0, len = arr.length; i < len; i++) {
    item = arr[i];
    if (item.length === 0) {
      continue;
    }
    day = item.slice(0, 2);
    day = 1 + 'MoTuWeThFr'.indexOf(day) / 2;
    hhmm1 = item.slice(2, 6);
    hhmm2 = item.slice(6, 10);
    t1 = minutes(day, parseInt(hhmm1.slice(0, 2)), parseInt(hhmm1.slice(2, 4)));
    t2 = minutes(day, parseInt(hhmm2.slice(0, 2)), parseInt(hhmm2.slice(2, 4)));
    subject = item.slice(10, 12);
    room = item.slice(12, 16);
    res.push([subject, t1, t2, room, hhmm1, hhmm2]);
    print([subject, t1, t2, room, hhmm1, hhmm2]);
    if (indexOf.call(_.keys(colors), subject) < 0) {
      n = _.size(colors);
      if (n === 0) {
        c = [0, 0, 0];
      }
      if (n === 1) {
        c = [1, 0, 0];
      }
      if (n === 2) {
        c = [1, 1, 0];
      }
      if (n === 3) {
        c = [0, 1, 0];
      }
      if (n === 4) {
        c = [1, 1, 1];
      }
      if (n === 5) {
        c = [1, 0, 1];
      }
      if (n === 6) {
        c = [0, 0, 1];
      }
      if (n === 7) {
        c = [0, 1, 0];
      }
      colors[subject] = c;
    }
  }
  return res;
};

setup = function() {
  var params;
  createCanvas(windowWidth, windowHeight);
  fc();
  strokeCap(SQUARE);
  textAlign(CENTER, CENTER);
  frameRate(1);
  params = getURLParams();
  if (_.size(params) === 0) {
    return schema = unpack(arg);
  } else {
    return schema = unpack(params.s);
  }
};

minutes = function(d, h, m) {
  return 60 * (d * 24 + h) + m;
};

rad = function(minutes) {
  return radians(modulo(minutes / 2, 360) - 90);
};

myarc = function(start, stopp) {
  var day;
  day = int(start / 1440);
  return arc(0, 0, 2 * 110 - 20 * day, 2 * 110 - 20 * day, rad(start), rad(stopp));
};

myline = function(t) {
  var day;
  day = int(t / 1440);
  sw(11);
  return arc(0, 0, 2 * 110 - 20 * day, 2 * 110 - 20 * day, rad(t), rad(t + 1));
};

draw = function() {
  var b, g, hhmm1, hhmm2, i, item, j, k, len, len1, len2, nextstate, r, r1, r2, ref, ref1, room, start, state, stopp, subject, t, tday, v;
  r = 100;
  translate(width / 2, height / 2);
  scale(_.min([width, height]) / 220);
  bg(0.5);
  state = 0;
  sw(1);
  tday = (new Date()).getDay();
  t = minutes(tday, hour(), minute());
  // t = minutes 1,8,15
  r1 = 55;
  r2 = 105;
  sc(0.6);
  ref = range(0, 360, 30);
  for (i = 0, len = ref.length; i < len; i++) {
    v = ref[i];
    line(r1 * cos(radians(v)), r1 * sin(radians(v)), r2 * cos(radians(v)), r2 * sin(radians(v)));
  }
  ref1 = range(55, 110, 10);
  for (j = 0, len1 = ref1.length; j < len1; j++) {
    r = ref1[j];
    circle(0, 0, r);
  }
  for (k = 0, len2 = schema.length; k < len2; k++) {
    item = schema[k];
    [subject, start, stopp, room, hhmm1, hhmm2] = item;
    if (stopp <= t) {
      nextstate = 0;
    } else if (start >= t) {
      nextstate = 2;
    } else {
      nextstate = 1;
    }
    if (state === 0 && nextstate === 2) {
      info(subject, room, t - start, hhmm1, hhmm2);
    }
    state = nextstate;
    sw(9);
    fc();
    if (state === 0) {
      sc(0.6);
      myarc(start, stopp);
    }
    if (state === 2) {
      [r, g, b] = colors[subject];
      sc(r, g, b);
      myarc(start, stopp);
    }
    if (state === 1) {
      sc(0.6);
      myarc(start, t);
      [r, g, b] = colors[subject];
      sc(r, g, b);
      myarc(t, stopp);
      sw(3);
      [r, g, b] = colors[subject];
      sc(1 - r, 1 - g, 1 - b);
      myarc(t, stopp);
      info(subject, room, stopp - t, hhmm1, hhmm2);
    }
  }
  sc(0);
  return myline(t);
};

pretty = function(minutes) {
  var h, m;
  if (minutes < 60) {
    return minutes;
  }
  h = int(minutes / 60);
  m = minutes % 60;
  if (m < 10) {
    return h + ':0' + m;
  } else {
    return h + ':' + m;
  }
};

info = function(subject, room, tid, hhmm1, hhmm2) {
  var b, g, r;
  sc();
  if (tid < 0) {
    [r, g, b] = [0.75, 0.75, 0.75];
    tid = -tid;
  } else {
    [r, g, b] = [0, 0, 0];
  }
  fc(r, g, b);
  textSize(32);
  text(pretty(tid), 0, 0);
  [r, g, b] = colors[subject];
  fc(r, g, b);
  textSize(20);
  text(subject, 0, -28);
  fc(0);
  text(room, 0, 30);
  textSize(12);
  text(hhmm1, -30, -25);
  return text(hhmm2, 30, -25);
};

//# sourceMappingURL=data:application/json;base64,eyJ2ZXJzaW9uIjozLCJmaWxlIjoic2tldGNoLmpzIiwic291cmNlUm9vdCI6Ii4uIiwic291cmNlcyI6WyJjb2ZmZWVcXHNrZXRjaC5jb2ZmZWUiXSwibmFtZXMiOltdLCJtYXBwaW5ncyI6IjtBQUFBOzs7Ozs7Ozs7O0FBQUEsSUFBQSxHQUFBLEVBQUEsTUFBQSxFQUFBLElBQUEsRUFBQSxJQUFBLEVBQUEsT0FBQSxFQUFBLEtBQUEsRUFBQSxNQUFBLEVBQUEsTUFBQSxFQUFBLEdBQUEsRUFBQSxNQUFBLEVBQUEsS0FBQSxFQUFBLE1BQUE7RUFBQTs7O0FBVUEsR0FBQSxHQUFLOztBQUNMLEdBQUEsSUFBSzs7QUFDTCxHQUFBLElBQUs7O0FBQ0wsR0FBQSxJQUFLOztBQUNMLEdBQUEsSUFBSyxvQ0FkTDs7O0FBa0JBLE1BQUEsR0FBUzs7QUFDVCxNQUFBLEdBQVMsQ0FBQTs7QUFFVCxNQUFBLEdBQVMsUUFBQSxDQUFDLEdBQUQsQ0FBQTtBQUNSLE1BQUEsR0FBQSxFQUFBLENBQUEsRUFBQSxHQUFBLEVBQUEsS0FBQSxFQUFBLEtBQUEsRUFBQSxDQUFBLEVBQUEsSUFBQSxFQUFBLEdBQUEsRUFBQSxDQUFBLEVBQUEsR0FBQSxFQUFBLElBQUEsRUFBQSxPQUFBLEVBQUEsRUFBQSxFQUFBO0VBQUEsR0FBQSxHQUFNLEdBQUcsQ0FBQyxLQUFKLENBQVUsR0FBVjtFQUNOLEdBQUEsR0FBTTtFQUNOLEtBQUEscUNBQUE7O0lBQ0MsSUFBRyxJQUFJLENBQUMsTUFBTCxLQUFhLENBQWhCO0FBQXVCLGVBQXZCOztJQUNBLEdBQUEsR0FBTSxJQUFLO0lBQ1gsR0FBQSxHQUFNLENBQUEsR0FBSSxZQUFZLENBQUMsT0FBYixDQUFxQixHQUFyQixDQUFBLEdBQTRCO0lBQ3RDLEtBQUEsR0FBUSxJQUFLO0lBQ2IsS0FBQSxHQUFRLElBQUs7SUFDYixFQUFBLEdBQUssT0FBQSxDQUFRLEdBQVIsRUFBYSxRQUFBLENBQVMsS0FBTSxZQUFmLENBQWIsRUFBbUMsUUFBQSxDQUFTLEtBQU0sWUFBZixDQUFuQztJQUNMLEVB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c0NvbnRlbnQiOlsiIyBZdHRyZSByaW5nZW4gaGFudGVyYXIgbcOlbmRhZz0xXHJcbiMgSW5yZSByaW5nZW4gaGFudGVyYXIgZnJlZGFnPTVcclxuIyBWYXJqZSDDpG1uZSBoYXIgZW4gZWdlbiBmw6RyZ1xyXG4jIFDDpWfDpWVuZGUgbGVrdGlvbiBtYXJrZXJhcyBtZWQgZXR0IHN0cmVjay5cclxuIyBJIG1pdHRlbiB2aXNhcyB0aWQga3ZhciB0aWxscyBsZWt0aW9uIGLDtnJqYXIgZWxsZXIgc2x1dGFyLlxyXG4jIETDpHIgdmlzYXMgw6R2ZW4gw6RtbmUsIHNhbCwgc3RhcnR0aWQgc2FtdCBzbHV0dGlkXHJcblxyXG4jIERheSBTdWJqZWN0IGhobW0gaGhtbSBSb29tIDtcclxuIyBNbzA4MzAwOTMwTWFTMzIzID0+IERheT1NbyBzdGFydD0wODMwIHN0b3BwPTA5MzAgU3ViamVjdD1NYSBSb29tPVMzMjNcclxuIyAgICAgMDEyMzQ1Njc4OTAxMjM0NVxyXG5hcmcgPSdNbzA4MzAwOTMwTWFTMzIzO01vMDk0MDEwNDBTdlMyMTg7TW8xMjQwMTM1MEZ5UzE0MjsnXHJcbmFyZys9J1R1MDgzMDA5NTVFblMzMjQ7VHUxMjE1MTMyNU1hUDk1NzsnXHJcbmFyZys9J1dlMTAzNTExMjVGeVAzMTU7V2UxMjE1MTMyNU1hUTMyMztXZTEzNTAxNDUwSWRROTU3OydcclxuYXJnKz0nVGgxMzAwMTQyNUVuUTIzMjtUaDE0MzUxNTU1U3ZTNTQ2OydcclxuYXJnKz0nRnIwODMwMDkzME1hUzQzNDtGcjExMDUxMjAwRnlQOTU3J1xyXG5cclxuIyBodHRwOi8vY2hyaXN0ZXJuaWxzc29uLmdpdGh1Yi5pby9MYWIvMjAxNy8wODItQ2FsZW5kYXJDbG9jay9pbmRleC5odG1sP3M9TW8wODMwMDkzME1hUzMyMztNbzA5NDAxMDQwU3ZTMjE4O01vMTI0MDEzNTBGeVMxNDI7VHUwODMwMDk1NUVuUzMyNDtUdTEyMTUxMzI1TWFQOTU3O1dlMTAzNTExMjVGeVAzMTU7V2UxMjE1MTMyNU1hUTMyMztXZTEzNTAxNDUwSWRROTU3O1RoMTMwMDE0MjVFblEyMzI7VGgxNDM1MTU1NVN2UzU0NjtGcjA4MzAwOTMwTWFTNDM0O0ZyMTEwNTEyMDBGeVA5NTcnXHJcblxyXG5zY2hlbWEgPSBbXVxyXG5jb2xvcnMgPSB7fVxyXG5cclxudW5wYWNrID0gKGFyZykgLT5cclxuXHRhcnIgPSBhcmcuc3BsaXQgJzsnXHJcblx0cmVzID0gW11cclxuXHRmb3IgaXRlbSBpbiBhcnJcclxuXHRcdGlmIGl0ZW0ubGVuZ3RoPT0wIHRoZW4gY29udGludWVcclxuXHRcdGRheSA9IGl0ZW1bMC4uMV1cclxuXHRcdGRheSA9IDEgKyAnTW9UdVdlVGhGcicuaW5kZXhPZihkYXkpIC8gMlxyXG5cdFx0aGhtbTEgPSBpdGVtWzIuLjVdXHJcblx0XHRoaG1tMiA9IGl0ZW1bNi4uOV1cclxuXHRcdHQxID0gbWludXRlcyBkYXksIHBhcnNlSW50KGhobW0xWzAuLjFdKSxwYXJzZUludChoaG1tMVsyLi4zXSlcclxuXHRcdHQyID0gbWludXRlcyBkYXksIHBhcnNlSW50KGhobW0yWzAuLjFdKSxwYXJzZUludChoaG1tMlsyLi4zXSlcclxuXHRcdHN1YmplY3QgPSBpdGVtWzEwLi4xMV1cclxuXHRcdHJvb20gPSBpdGVtWzEyLi4xNV1cclxuXHRcdHJlcy5wdXNoIFtzdWJqZWN0LHQxLHQyLHJvb20saGhtbTEsaGhtbTJdXHJcblx0XHRwcmludCBbc3ViamVjdCx0MSx0Mixyb29tLGhobW0xLGhobW0yXVxyXG5cclxuXHRcdGlmIHN1YmplY3Qgbm90IGluIF8ua2V5cyBjb2xvcnNcclxuXHRcdFx0biA9IF8uc2l6ZSBjb2xvcnNcclxuXHRcdFx0aWYgbj09MCB0aGVuIGM9WzAsMCwwXVxyXG5cdFx0XHRpZiBuPT0xIHRoZW4gYz1bMSwwLDBdXHJcblx0XHRcdGlmIG49PTIgdGhlbiBjPVsxLDEsMF1cclxuXHRcdFx0aWYgbj09MyB0aGVuIGM9WzAsMSwwXVxyXG5cdFx0XHRpZiBuPT00IHRoZW4gYz1bMSwxLDFdXHJcblx0XHRcdGlmIG49PTUgdGhlbiBjPVsxLDAsMV1cclxuXHRcdFx0aWYgbj09NiB0aGVuIGM9WzAsMCwxXVxyXG5cdFx0XHRpZiBuPT03IHRoZW4gYz1bMCwxLDBdXHJcblx0XHRcdGNvbG9yc1tzdWJqZWN0XSA9IGNcclxuXHRyZXNcclxuXHJcbnNldHVwID0gLT5cclxuXHRjcmVhdGVDYW52YXMgd2luZG93V2lkdGgsd2luZG93SGVpZ2h0XHJcblxyXG5cdGZjKClcclxuXHRzdHJva2VDYXAgU1FVQVJFXHJcblx0dGV4dEFsaWduIENFTlRFUixDRU5URVJcclxuXHRmcmFtZVJhdGUgMVxyXG5cclxuXHRwYXJhbXMgPSBnZXRVUkxQYXJhbXMoKVxyXG5cdGlmIF8uc2l6ZShwYXJhbXMpID09IDBcclxuXHRcdHNjaGVtYSA9IHVucGFjayBhcmdcclxuXHRlbHNlXHJcblx0XHRzY2hlbWEgPSB1bnBhY2sgcGFyYW1zLnNcclxuXHJcbm1pbnV0ZXMgPSAoZCxoLG0pIC0+IDYwICogKGQqMjQgKyBoKSArIG1cclxucmFkID0gKG1pbnV0ZXMpIC0+IHJhZGlhbnMgbWludXRlcy8yICUlIDM2MCAtIDkwXHJcbm15YXJjID0gKHN0YXJ0LHN0b3BwKSAtPlxyXG5cdGRheSA9IGludCBzdGFydCAvIDE0NDBcclxuXHRhcmMgMCwwLDIqMTEwLTIwKmRheSwyKjExMC0yMCpkYXkscmFkKHN0YXJ0KSxyYWQoc3RvcHApXHJcblxyXG5teWxpbmUgPSAodCkgLT5cclxuXHRkYXkgPSBpbnQgdCAvIDE0NDBcclxuXHRzdyAxMVxyXG5cdGFyYyAwLDAsMioxMTAtMjAqZGF5LDIqMTEwLTIwKmRheSxyYWQodCkscmFkKHQrMSlcclxuXHJcbmRyYXcgPSAtPlxyXG5cdHIgPSAxMDBcclxuXHR0cmFuc2xhdGUgd2lkdGgvMixoZWlnaHQvMlxyXG5cdHNjYWxlIF8ubWluKFt3aWR0aCxoZWlnaHRdKS8yMjBcclxuXHRiZyAwLjVcclxuXHRzdGF0ZSA9IDBcclxuXHRzdyAxXHJcblxyXG5cdHRkYXkgPSAobmV3IERhdGUoKSkuZ2V0RGF5KClcclxuXHR0ID0gbWludXRlcyB0ZGF5LGhvdXIoKSxtaW51dGUoKVxyXG5cdCMgdCA9IG1pbnV0ZXMgMSw4LDE1XHJcblxyXG5cdHIxID0gNTVcclxuXHRyMiA9IDEwNVxyXG5cdHNjIDAuNlxyXG5cdGZvciB2IGluIHJhbmdlIDAsMzYwLDMwXHJcblx0XHRsaW5lIHIxKmNvcyhyYWRpYW5zKHYpKSxyMSpzaW4ocmFkaWFucyh2KSkscjIqY29zKHJhZGlhbnModikpLHIyKnNpbihyYWRpYW5zKHYpKVxyXG5cclxuXHRmb3IgciBpbiByYW5nZSA1NSwxMTAsMTBcclxuXHRcdGNpcmNsZSAwLDAsclxyXG5cclxuXHRmb3IgaXRlbSBpbiBzY2hlbWFcclxuXHRcdFtzdWJqZWN0LHN0YXJ0LHN0b3BwLHJvb20saGhtbTEsaGhtbTJdID0gaXRlbVxyXG5cclxuXHRcdGlmIHN0b3BwIDw9IHQgdGhlbiBuZXh0c3RhdGUgPSAwXHJcblx0XHRlbHNlIGlmIHN0YXJ0ID49IHQgdGhlbiBuZXh0c3RhdGUgPSAyXHJcblx0XHRlbHNlIG5leHRzdGF0ZSA9IDFcclxuXHJcblx0XHRpZiBzdGF0ZT09MCBhbmQgbmV4dHN0YXRlPT0yXHJcblx0XHRcdGluZm8gc3ViamVjdCwgcm9vbSwgdC1zdGFydCwgaGhtbTEsaGhtbTJcclxuXHRcdHN0YXRlID0gbmV4dHN0YXRlXHJcblxyXG5cdFx0c3cgOVxyXG5cdFx0ZmMoKVxyXG5cdFx0aWYgc3RhdGU9PTBcclxuXHRcdFx0c2MgMC42XHJcblx0XHRcdG15YXJjIHN0YXJ0LHN0b3BwXHJcblx0XHRpZiBzdGF0ZT09MlxyXG5cdFx0XHRbcixnLGJdID0gY29sb3JzW3N1YmplY3RdXHJcblx0XHRcdHNjIHIsZyxiXHJcblx0XHRcdG15YXJjIHN0YXJ0LHN0b3BwXHJcblx0XHRpZiBzdGF0ZT09MVxyXG5cdFx0XHRzYyAwLjZcclxuXHRcdFx0bXlhcmMgc3RhcnQsdFxyXG5cdFx0XHRbcixnLGJdID0gY29sb3JzW3N1YmplY3RdXHJcblx0XHRcdHNjIHIsZyxiXHJcblx0XHRcdG15YXJjIHQsc3RvcHBcclxuXHJcblx0XHRcdHN3IDNcclxuXHRcdFx0W3IsZyxiXSA9IGNvbG9yc1tzdWJqZWN0XVxyXG5cdFx0XHRzYyAxLXIsMS1nLDEtYlxyXG5cdFx0XHRteWFyYyB0LHN0b3BwXHJcblx0XHRcdGluZm8gc3ViamVjdCwgcm9vbSwgc3RvcHAtdCwgaGhtbTEsaGhtbTJcclxuXHRzYyAwXHJcblx0bXlsaW5lIHRcclxuXHJcbnByZXR0eSA9IChtaW51dGVzKSAtPlxyXG5cdGlmIG1pbnV0ZXM8NjAgdGhlbiByZXR1cm4gbWludXRlc1xyXG5cdGggPSBpbnQgbWludXRlcy82MFxyXG5cdG0gPSBtaW51dGVzJTYwXHJcblx0aWYgbTwxMCB0aGVuIGggKyAnOjAnICsgbSBlbHNlIGggKyAnOicgKyBtXHJcblxyXG5pbmZvID0gKHN1YmplY3Qscm9vbSx0aWQsaGhtbTEsaGhtbTIpIC0+XHJcblx0c2MoKVxyXG5cdGlmIHRpZDwwXHJcblx0XHRbcixnLGJdID0gWzAuNzUsMC43NSwwLjc1XVxyXG5cdFx0dGlkID0gLXRpZFxyXG5cdGVsc2VcclxuXHRcdFtyLGcsYl0gPSBbMCwwLDBdXHJcblx0ZmMgcixnLGJcclxuXHR0ZXh0U2l6ZSAzMlxyXG5cdHRleHQgcHJldHR5KHRpZCksMCwwXHJcblxyXG5cdFtyLGcsYl0gPSBjb2xvcnNbc3ViamVjdF1cclxuXHRmYyByLGcsYlxyXG5cdHRleHRTaXplIDIwXHJcblx0dGV4dCBzdWJqZWN0LDAsLTI4XHJcblxyXG5cdGZjIDBcclxuXHR0ZXh0IHJvb20sMCwzMFxyXG5cdHRleHRTaXplIDEyXHJcblx0dGV4dCBoaG1tMSwtMzAsLTI1XHJcblx0dGV4dCBoaG1tMiwzMCwtMjVcclxuIl19
//# sourceURL=C:\Lab\2017\082-CalendarClock\coffee\sketch.coffee