'use strict';

// Generated by CoffeeScript 2.0.3
var ID_GUI, ID_GalaxiesColliding, ID_GameOfLife, ID_Girlang, ID_GoldenStar, ID_GreenEllipse, ID_GreenRect, ID_Grid, ID_GrowingCircles, ID_GrowingRedSquares, ID_GrowingSquares, ID_GuessANumber, ID_GuessANumberHex;

ID_GalaxiesColliding = {
  v: '2017-04-29',
  k: 'fc range for lerp rect if',
  l: 8,
  b: "# (David Larsson)\n",
  a: "for i in range 10\n	for j in range 10\n		fc()\n		if i-j in [-2,0,2] then fc 1,1,0\n		if i+j in [7,9,11] then fc 1,0,0\n		x = 20*i\n		y = 20*j\n		rect x,y, 20,20"
};

ID_GameOfLife = {
  v: '2017-04-29',
  k: 'bg range for [] operators if int class',
  l: 40,
  b: "class GameOfLife extends Application\n	reset : (n) ->\n		super\n	draw : ->\n	mousePressed : (mx,my) ->\n	tick : ->\napp = new GameOfLife\n",
  a: "class GameOfLife extends Application\n	reset : (n) ->\n		super\n		@n = n\n		@size = 200/@n\n		@matrix = {}\n		@ticks = 0\n		for [i,j] in [[0,0],[2,0],[1,1],[2,1],[1,2]]\n			@matrix[i+','+j] = 1\n	draw : ->\n		bg 0.5\n		for i in range @n\n			for j in range @n\n				if @matrix[i+','+j]==1\n					rect @size*i, @size*j, @size, @size\n	count : (x,y) ->\n		res = 0\n		for dx in [-1,0,1]\n			for dy in [-1,0,1]\n				i = (x+dx) %% @n\n				j = (y+dy) %% @n\n				res++ if @matrix[i+','+j]==1 and (dx!=0 or dy!=0)\n		res\n	tick : ->\n		@ticks++\n		m = {}\n		for i in range @n\n			for j in range @n\n				c = @count(i,j)\n				key = i+','+j\n				if @matrix[key] == 1\n					if 2 <= c <= 3 then m[key]=1\n				else\n					if c==3 then m[key]=1\n		@matrix = m\n	mousePressed : (mx,my) ->\n		i = int mx/@size\n		j = int my/@size\n		key = i+','+j\n		@matrix[key] = if @matrix[key] == 1 then undefined else 1\n\napp = new GameOfLife \"a\"\n",
  c: {
    app: "reset 10|reset 20|reset 40|tick()"
  },
  //	d : "reset 40|mousePressed 105,100|mousePressed 110,105|mousePressed 100,110|mousePressed 105,110|mousePressed 110,110|tick()|tick()|tick()|tick()|tick()|tick()|tick()|tick()"
  d: "reset 40|tick()|tick()|tick()|tick()|tick()|tick()|tick()|tick()",
  e: {
    Wikipedia: "https://en.wikipedia.org/wiki/Conway%27s_Game_of_Life"
  }
};

ID_Girlang = {
  v: '2018-02-11',
  k: 'sc bg sw range for line class',
  l: 15,
  b: "class Cartesius\n	constructor : (@r,@g,@b, @x,@y) ->\n	go : (dx,dy) ->\n\na = new Cartesius ...\nb = new Cartesius ...\nfor ...",
  a: "class Cartesius\n	constructor : (@r,@g,@b, @x,@y) ->\n	go : (dx,dy) ->\n		sc @r,@g,@b\n		line @x,@y,@x+dx,@y+dy\n		[@x,@y] = [@x+dx,@y+dy]\n\nbg 0\nr = new Cartesius 1,0,0, 10,0\ny = new Cartesius 1,1,0, 0,10\nsw 5\nfor i in range 9\n	r.go 0,20\n	y.go 20,0\n	y.go 0,20\n	r.go 20,0"
};

ID_GoldenStar = {
  v: '2017-09-30',
  k: 'bg fc range for triangle translate angleMode rotate cos sin class',
  l: 23,
  b: "class GoldenStar extends Application\n	reset : ->\n		super\n	draw  : ->\n	n     : (d) ->\n	outer : (d) ->\n	inner : (d) ->\napp = new GoldenStar",
  a: "class GoldenStar extends Application\n	reset : ->\n		super\n		@_X = 100\n		@_Y = 100\n		@_n = 4\n		@_outer = 100\n		@_inner = 25\n	n : (d) -> @_n = constrain @_n+d,3,12\n	outer : (d) -> @_outer = constrain @_outer+d, 0, 100\n	inner : (d) -> @_inner = constrain @_inner+d, 0, 100\n	draw : ->\n		bg 0\n		angleMode DEGREES\n		translate @_X,@_Y\n		v = 360/@_n\n		rotate -90\n		x1 = @_inner * cos v/2\n		y1 = @_inner * sin v/2\n		for i in range @_n\n			fc 1,1,0\n			triangle 0,0, @_outer,0, x1,y1\n			fc 1,0.7,0\n			triangle 0,0, @_outer,0, x1,-y1\n			rotate v\n\napp = new GoldenStar \"a\"",
  c: {
    app: "reset()|n -1|n +1|outer -1|outer +1|inner -1|inner +1"
  },
  d: "reset()|n -1|n +1|n +1|outer -10|outer +10|inner -1|inner +1"
};

ID_GreenEllipse = {
  v: '2017-04-29',
  k: 'fc ellipse',
  l: 2,
  b: "",
  a: "fc 0,1,0\nellipse 120,60, 60,40"
};

ID_GreenRect = {
  v: '2017-04-29',
  k: 'fc rect',
  l: 2,
  b: "",
  a: "fc 0,1,0\nrect 60,80, 40,50"
};

ID_Grid = {
  v: '2017-04-29',
  k: 'sc sw range for line',
  l: 5,
  b: "",
  a: "sc 1,1,0\nsw 2\nfor i in range 10,200,10\n	line 10,i,190,i\n	line i,190, i,10"
};

ID_GrowingCircles = {
  v: '2017-04-29',
  k: 'range fc circle for lerp',
  l: 6,
  b: "# LÄXA: Hela uppgiften",
  a: "for i in range 10\n	fc i/10.0,0,0\n	x = 10+20*i\n	y = 10\n	r = i\n	circle x,y,r"
};

ID_GrowingRedSquares = {
  v: '2017-04-29',
  k: 'fc range for lerp rect rectMode',
  l: 8,
  b: "",
  a: "rectMode CENTER\nfor i in range 10\n	fc i/10.0,0,0\n	x = 10+20*i\n	y = 10\n	w = 2*i\n	h = 2*i\n	rect x,y,w,h"
};

ID_GrowingSquares = {
  v: '2017-04-29',
  k: 'range rect rectMode for lerp',
  l: 7,
  b: "",
  a: "rectMode CENTER\nfor i in range 10\n	x = 10+20*i\n	y = 10\n	w = 2*i\n	h = 2*i\n	rect x,y, w,h"
};

ID_GuessANumber = {
  v: '2017-04-29',
  k: 'bg fc sc range text for if operators int class',
  l: 29,
  b: "class Guess extends Application\n	reset        : ->\n		super\n	draw         : ->\n	newGame : ->\n	mousePressed : (mx,my) ->\napp = new Guess",
  a: "class Guess extends Application\n	reset : ->\n		super\n		@N = 100\n		@seed = 0\n		@newGame()\n\n	randint : (n) -> int n * fraction 10000 * Math.sin @seed++\n\n	newGame : ->\n		@start = 0\n		@stopp = @N-1\n		@secret = @randint @N\n\n	draw : ->\n		bg 0.1\n		textAlign CENTER,CENTER\n		for i in range @N\n			if @start <= i <= @stopp then fc 1 else fc 0.5\n			sc()\n			x = i % 10\n			y = int i / 10\n			text i, 10 + 20 * x, 10 + 20 * y\n\n	mousePressed : (mx,my) ->\n		guess = int mx/20 + 10 * int my/20\n		if guess <= @secret then @start = guess+1\n		if guess >= @secret then @stopp = guess-1\n\napp = new Guess \"a\"",
  c: {
    app: "reset()|newGame()"
  },
  d: "reset()|mousePressed 75,75|mousePressed 100,125"
};

ID_GuessANumberHex = {
  v: '2017-05-11',
  k: 'bg fc sc range text for if operators int class',
  l: 33,
  b: "class GuessANumberHex extends Application\n	reset        : ->\n		super\n	draw         : ->\n	newGame : ->\n	mousePressed : (mx,my) ->\n	randint : (n) -> int n * fraction 10000 * Math.sin @seed++\napp = new GuessANumberHex",
  a: "class GuessANumberHex extends Application\n	reset : ->\n		super\n		@BASE = 16\n		@N = @BASE*@BASE\n		@S = 200 / @BASE\n		@seed = 1\n		@newGame()\n	randint : (n) -> int n * fraction 10000 * Math.sin @seed++\n	newGame : ->\n		@start = 0\n		@stopp = @N-1\n		@secret = @randint @N\n		@count = 0\n	draw : ->\n		bg 0\n		textAlign CENTER,CENTER\n		textSize 9\n		for i in range @N\n			if @start <= i <= @stopp then fc 1 else fc 0.5\n			sc()\n			x = i % @BASE\n			y = int i / @BASE\n			text hex(i,2), @S/2 + @S * x, @S/2 + @S * y\n		fc 1,1,1,0.5\n		textSize 100\n		text @count,100,100\n	mousePressed : (mx,my) ->\n		guess = int mx/@S + @BASE * int my/@S\n		@seed += mx % 2\n		@count++\n		if guess <= @secret then @start = guess+1\n		if guess >= @secret then @stopp = guess-1\n\napp = new GuessANumberHex \"a\"",
  c: {
    app: "reset()|newGame()"
  },
  d: "reset()|mousePressed 100,100|mousePressed 100,150|mousePressed 50,50"
};

ID_GUI = {
  v: '2017-09-29',
  k: 'bg fc sc text for if [] operators class',
  l: 30,
  b: "class GUI extends Application\n	reset : ->\n		super\n	draw : ->\n	up : ->\n	down : ->\n	left : ->\n	right : ->\napp = new GUI",
  a: "class GUI extends Application\n	reset : ->\n		super\n		@current = 0\n		@prompts = []\n		@labels = []\n		@values = []\n		@add 'Fan o--- -o-- --o- ---o'\n		@add 'Temp o----- -o---- --o--- ---o-- ----o- -----o'\n		@add 'Blink Off Left Right'\n		@add 'Music Beatles Jazz Rock Stones'\n		@add 'Radio P1 P2 P3 P4 P5'\n		@add 'Volume 0 1 2 3 4 5 6 7 8 9'\n		@add 'Wipers o--- -o-- --o- ---o'\n\n	add : (s) ->\n		arr = s.split ' '\n		@prompts.push arr.shift()\n		@labels.push arr\n		@values.push 0\n\n	draw : ->\n		bg 0.5\n		sc()\n		textSize 20\n		for prompt,i in @prompts\n			if @current == i then fc 1,1,0 else fc 0\n			text prompt,10,30+25*i\n			text @labels[i][@values[i]],120,30+25*i\n\n	up : -> @current = (@current - 1) %% @prompts.length\n	down : -> @current = (@current + 1) %% @prompts.length\n	left : -> @values[@current] = (@values[@current]-1) %% @labels[@current].length\n	right : -> @values[@current] = (@values[@current]+1) %% @labels[@current].length\n\napp = new GUI \"a\"",
  c: {
    app: "reset()|up()|down()|left()|right()"
  },
  d: "reset()|down()|up()|left()|left()|left()|left()"
};
//# sourceMappingURL=G.js.map
