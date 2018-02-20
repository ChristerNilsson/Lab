ID_nyheter =
	v:'2017-11-03'
	k:''
	l:0
	b:"""
# NYHETER 2017 NOV 03
#   LinearRegression
# NYHETER 2017 OKT 23
#   SingaporeMult
#   SingaporeMultComplex
#   SingaporeMultPolynom
# NYHETER 2017 OKT 19
#   2048
# NYHETER 2017 OKT 10
#   ChessOne
#   ChessMany
# NYHETER 2017 SEP 29
#   GUI
# NYHETER 2017 JUN 11
#   Tetramino
# NYHETER 2017 JUN 04
#   BeeHaiku3D
# NYHETER 2017 MAJ 27
#   ForthHaiku3D
# NYHETER 2017 MAJ 20
#   MineSweeper
#   Paint
# NYHETER 2017 MAJ 13
#   TowerOfHanoi
#   GuessANumberHex
#   Coordinator
#   Tetris
#   Blank
#   Angle
# NYHETER 2017 MAJ 06
#   Reversi
#   Shortcut2
# NYHETER 2017 APR 29
#   RubikCube
#   ForthHaiku
#   Sokoban
# NYHETER 2017 APR 22
#   BlackBox2D
#   GameOfLife
#   Moire
#   SuperCircle
#   CoffeescriptClock
# NYHETER 2017 APR 15
#   LinesOfCode
#   ColorPair
#   Snake Snake4
# NYHETER 2017 APR 08
#   OneDiceHistogram TwoDiceHistogram
#   ClickDetector IndianSun MultiTimer
#   Hex
#   Shortcut Complex
# NYHETER 2017 APR 01
#   RandomDice
#   Nand2TetrisALU
#   RubikSquare
# NYHETER 2017 MAR 26
#   Stopwatch
#   Korsord
#   EngineeringNotation
#   Nian
#   Kalkylator
# NYHETER 2017 MAR 19
#   PickingBerries
# NYHETER 2017 MAR 12
#   Roulette
# NYHETER 2017 MAR 05
#   TwoArcs
#   Girlang Braid OlympicRings
#   GoldenStar Alphanumeric BoardGame SevenSegment
#   Connect4 SpaceShip
#   RushHour ChessGame
"""
	a:"""
"""

ID_Asserts =
	v:'2017-04-29'
	k:''
	l:0
	b:"""
# Här kan du se några klargörande exempel.
# Om de två parametrarna till assert är olika, skrivs de ut till console.
# Du kan prova egna asserts här. Kontrollera med F12.

# + - * / // **  Operatorer
assert -10,  2 - 3 * 4
assert 2.75, 2 + 3 / 4
assert 32,   4 * 2 ** 3
assert 14,   2 + 3 * 4
assert 20,   (2+3) * 4
assert 1.75, 7 / 4
assert 1,    7 // 4
assert 2,    8 // 4

# % Resten vid heltalsdivision
assert  0,  2 % 2
assert  1,  1 % 2
assert  0,  0 % 2
assert -1, -1 % 2
assert -0, -2 % 2

# %% Resten vid heltalsdivision. Klarar även negativa tal.
assert 0,  2 %% 2
assert 1,  1 %% 2
assert 0,  0 %% 2
assert 1, -1 %% 2
assert 0, -2 %% 2

# Jämförelser
assert true,  1+2 < 4
assert true,  1+2 > 2
assert true,  1+2 == 3
assert false, 1+2 == 4
assert true,  1+2 != 4
assert true,  1+2 >= 3
assert true,  1+2 <= 4
assert true,  1 < 2 and 2 < 3
assert true,  1 < 2 < 3

# and or not  Logiska villkor
assert false, false and false
assert false, false and true
assert false, true and false
assert true,  true and true

assert false, false or false
assert true,  false or true
assert true,  true or false
assert true,  true or true

assert true,  not false
assert false, not true

# if then else
assert 4, if 3 > 4 then 3 else 4
assert 3, if 3 < 4 then 3 else 4

# '' "" strängar
assert 'Coffeescript',            'Coffee' + 'script'
assert 6,                         'Coffee'.length
assert 2,                         'Coffee'.indexOf 'f'
assert -1,                        'Coffee'.indexOf 'x'
assert 3,                         'Coffee'.lastIndexOf 'f'
assert 'script',                  'Coffeescript'.slice 6,12
assert 'script',                  'Coffeescript'.slice 6
assert 'COFFEESCRIPT',            'Coffeescript'.toUpperCase()
assert 'coffeescript',            'Coffeescript'.toLowerCase()
assert 's',                       'Coffeescript'[6]
assert 'script',                  'Coffeescript'[6..12]
assert 'pt',                      'Coffeescript'[-2..]
assert 'esc',                     'Coffeescript'[5..-5]
assert ['abra','ka','dabra'],     'abra ka dabra'.split ' '
assert ['C','o','f','f','e','e'], 'Coffee'.split ''
assert ['C','o','f','f','e','e'], 'Coffee'.split ''
assert 'Coffee',                  ' Coffee  '.trim()
assert 12,                        parseInt '12'
assert '12',                      12.toString()
assert 3.14,                      parseFloat '3.14'
assert '3.141592653589793',       Math.PI.toString()
assert 'coffee',                  "coffee"
assert true,                      'coffeescript'.includes 'coffee'
assert false,                     'coffeescript'.includes 'tea'

# []
assert true, 7 in [7,8]
assert [7,8],         (i for i in [7,8])
assert [[7,0],[8,1]], ([item,i] for item,i in [7,8])
assert [9,16,25],     (x*x for x in [3,4,5])
assert "1x2x3",       [1,2,3].join('x')
assert [3,2,1] ,      [1,2,3].reverse()
assert [1,2,3],       [2,1,3].sort()
assert 3,             [2,1,5].length

# {}
assert true,              'b' of {a:7,b:8}
assert ['a','b'],         (key for key of {a:7,b:8})
assert [['a',7],['b',8]], ([key,item] for key,item of {a:7,b:8})

# & | ^ ~ << >> Bit operationer
assert [0,0,0,1], [0&0, 0&1, 1&0, 1&1]       # and
assert [0,1,1,1], [0|0, 0|1, 1|0, 1|1]       # or
assert [0,1,1,0], [0^0, 0^1, 1^0, 1^1]       # xor
assert [-1,-2,-3],[~0, ~1, ~2]               # not
assert [1,2,4,8], [1<<0, 1<<1, 1<<2, 1<<3]   # shift left
assert [8,4,2,1], [8>>0, 8>>1, 8>>2, 8>>3]   # shift right

# lerp
assert  8, lerp 10,12,-1
assert 10, lerp 10,12,0
assert 11, lerp 10,12,0.5
assert 12, lerp 10,12,1
assert 14, lerp 10,12,2

# range
assert [0,1,2,3,4,5,6,7,8,9]  , range 10
assert [0,1,2,3,4]            , range 5
assert [1,2,3,4,5,6,7,8,9,10] , range 1,11
assert [0,2,4,6,8]            , range 0,10,2
assert [10,8,6,4,2]           , range 10,0,-2
assert [9,8,7,6,5,4,3,2,1,0]  , range 10-1,-1,-1

# [..] [...]  range operator
assert [0,1,2,3,4], [0..4]
assert [0,1,2,3,4], [0...5]
assert [6,7],       [5,6,7,8,9][1..2]
assert [5,6,7],     [5,6,7,8,9][..2]
assert [6,7,8,9],   [5,6,7,8,9][1..]
assert [5,6,7,8,9], [5,6,7,8,9][..]
assert [5,6,7],     [5,6,7,8,9][0..2]
assert [6,7],       [5,6,7,8,9][1...-2]
assert [8,9],       [5,6,7,8,9][-2..]

# _.  underscore
assert 1,                 _.min [2,1,3]
assert 3,                 _.max [2,1,3]
assert 2,                 _.first [2,1,3]
assert 3,                 _.last [2,1,3]
assert [1,3],             _.rest [2,1,3]
assert [['a',1],['b',2]], _.pairs {a:1, b:2}

assert true,              "abc" == "abc"
assert false,             [1,2] == [1,2]
assert true,              _.isEqual [1,2], [1,2]
assert false,              {a:1, b:2} == {a:1, b:2}
assert true,              _.isEqual {a:1, b:2}, {a:1, b:2}
assert [1,2],             [1,2]

assert [1,2,3],           _.sortBy [2,1,3]
assert ['abc','ba','d'],  _.sortBy ['ba','abc','d']
assert ['d','ba','abc'],  _.sortBy ['ba','abc','d'], 'length'
assert ['abc','ba','d'],  _.sortBy ['ba','abc','d'], (s) -> -s.length

assert {odd: 3, even: 2}, _.countBy [1,2,3,4,5], (num) -> if num % 2 == 0 then 'even' else 'odd'
assert [["m",3], ["l",4], ["c",5]],  _.zip ['m','l','c'], [3,4,5]
assert [['m','l','c'], [3,4,5]],  _.unzip [["m",3], ["l",4], ["c",5]]

assert [2, 4, 6],         _.filter [1,2,3,4,5,6], (num) -> num % 2 == 0
assert [1, 3, 5],         _.reject [1,2,3,4,5,6], (num) -> num % 2 == 0

assert false,             _.some [1>2, 1==2, 1>=2, 1!=1]
assert true,              _.some [1>2, 1==2, 1>=2, 1!=2]
assert false,             _.every [2,4,5], (num) -> num % 2 == 0
assert true,              _.every [2,4,6], (num) -> num % 2 == 0

assert ["a", "b", "c"],   _.keys   {a:1, b:2, c:3}
assert [1,2,3],           _.values {a:1, b:2, c:3}

"""
	a:""
	e:
		Wikipedia : "https://en.wikipedia.org/wiki/Assertion_(software_development)"
		p5Assert : 'https://christernilsson.github.io/p5Assert'

ID_LinesOfCode =
	v:'2017-05-13'
	k:'bg fc sc [] {} operators if parseInt _.max rect for text class'
	l:60
	b:"""
class LinesOfCode extends Application
	reset : -> super
	draw : ->
app = new LinesOfCode
"""
	a:"""
class LinesOfCode extends Application
	reset : ->
		super
		@chapter = -1
		@stat = {}
		@h = 13
		@total = 0
		for chapter,item1 of data
			if chapter not in ['Information','Exhibition']
				@stat[chapter] = {}
				for exercise,item2 of item1
					loc = item2.l
					@total += loc
					@stat[chapter][exercise] = loc
	draw : ->
		fc 1,1,0
		sc()
		if @chapter == -1 then @drawAll() else @drawChapter()
	drawAll : ->
		bg 0
		i = 0
		rects = []
		for chapter,item1 of @stat
			sum = 0
			for exercise,item2 of item1
				sum += item2
			i++
			textAlign LEFT
			text chapter,5,i*@h
			textAlign RIGHT
			text sum,195,i*@h
			rects.push sum
		@max = _.max rects
		@drawRects rects, @max
	drawChapter : ->
		bg 0.5
		i=0
		rects = []
		for chapter,item1 of @stat
			i++
			if i == @chapter
				j = 0
				for exercise,item2 of item1
					j++
					textAlign LEFT
					text exercise,5,j*@h
					textAlign RIGHT
					text item2,195,j*@h
					rects.push item2
		@drawRects rects, @max
	drawRects : (rects,m) ->
		fc 1,1,0,0.5
		sc 1,1,0
		for r,i in rects
			rect 0,3+@h*i, 200*r/m,@h-2
	mousePressed : (mx,my) ->
		if @chapter == -1
			@chapter = 1 + int my / @h
		else
			@chapter = -1

app = new LinesOfCode 'a'
"""
	c:
		app : "reset()"
	e:
		Wikipedia : "https://en.wikipedia.org/wiki/Source_lines_of_code"

