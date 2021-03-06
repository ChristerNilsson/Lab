'use strict';

// Generated by CoffeeScript 2.0.3
var ID_OlympicRingPrep, ID_OlympicRings, ID_OneDiceHistogram;

ID_OlympicRingPrep = {
  v: '2017-04-29',
  k: 'sc fc sw arc angleMode strokeCap class',
  l: 21,
  b: "class Ring extends Application\n	reset  : ->\n		super\n	draw   : ->\n	start  : (d) ->\n	stopp  : (d) ->\n	radius : (d) ->\n	width  : (d) ->\napp = new Ring",
  a: "class Ring extends Application\n	reset : ->\n		super\n		@_start = 3\n		@_stopp = 6\n		@_w = 5\n		@_radius = 50\n	start : (d) -> @_start+=d\n	stopp : (d) -> @_stopp+=d\n	radius : (d) -> @_radius+=d\n	width : (d) -> @_w+=d\n	draw : ->\n		hour = PI/6\n		strokeCap SQUARE\n		fc()\n		sw @_w\n		sc 1,1,0\n		arc 100,100,2*@_radius,2*@_radius,(@_start-3)*hour,(@_stopp-3)*hour\n\napp = new Ring \"a\"",
  c: {
    app: "reset()|start -1|start +1|stopp -1|stopp +1|radius -1|radius +1|width -1|width +1"
  },
  d: "reset()|start -1|start +1|stopp -1|stopp +1|radius -1|radius +1|width -1|width +1"
};

ID_OlympicRings = {
  v: '2017-04-29',
  k: 'sc bg fc sw arc strokeCap class',
  l: 24,
  b: "class Ring\n	constructor : (@x,@y,@r,@g,@b) ->\n	draw : (start=3,stopp=3,hour=PI/6) ->\n\nolympic = (x=100,y=100,radius=50,d=60,w=10) ->\n\nolympic()",
  a: "class Ring\n	constructor : (@x,@y,@radius, @r,@g,@b) ->\n	draw : (start=3,stopp=3,hour=PI/6) ->\n		sc @r,@g,@b\n		arc @x,@y,@radius,@radius,(start-3)*hour,(stopp-3)*hour\n\nolympic = (x=100,y=100,radius=50,d=60,w=10) ->\n	r1 = new Ring x-d,  y,     radius, 0,0,1\n	r2 = new Ring x,    y,     radius, 0,0,0\n	r3 = new Ring x+d,  y,     radius, 1,0,0\n	r4 = new Ring x-d/2,y+d/3, radius, 1,1,0\n	r5 = new Ring x+d/2,y+d/3, radius, 0,1,0\n\n	strokeCap SQUARE\n	bg 0.5\n	fc()\n	sw w\n\n	r1.draw()\n	r3.draw()\n	r4.draw()\n	r5.draw()\n	r1.draw 2,4\n	r2.draw()\n	r4.draw 12,2\n	r5.draw 8,10\n	r3.draw 6,8\n\nolympic()",
  e: {
    Wikipedia: "https://en.wikipedia.org/wiki/Olympic_symbols"
  }
};

ID_OneDiceHistogram = {
  v: '2017-04-29',
  k: 'fc sc range int random text for operators rect []',
  l: 17,
  b: "# OBS: På grund av random blir bitmapparna inte likadana\n\nh = 50\ncounts = Array(4).fill 150\nfor count,i in counts\n	y = h*i\n	rect 0,y,count,h\n	text y,0,y",
  a: "counts = Array(6).fill 0\ndice = -> int 6 * random()\nfor i in range 1000\n	counts[dice()]++\nh = int 200/6\nsc()\nfor count,i in counts\n	y = h*i\n	fc 1,1,0,0.5\n	sc 1,1,0\n	rect 0,y,count,h-3\n	fc 1,1,0\n	sc()\n	textAlign LEFT,CENTER\n	text i+1, 5,y+h/2\n	textAlign RIGHT,CENTER\n	text count, count-5,y+h/2"
};
//# sourceMappingURL=O.js.map
