XABOVE = 0 # "A" #BOVE"
XRIGHT = 1 # "R" #IGHT"
XLEFT  = 2 # "L" #EFT"
XBELOW = 3 # "B" #ELOW"

window.solution = []

directionToDelta = (direction) ->
	switch direction
		when XABOVE then [-1, 0]
		when XRIGHT then [0, 1]
		when XBELOW then [1, 0]
		when XLEFT  then [0, -1]

directionsAreOpposites = (a, b) ->
	[adr, adc] = directionToDelta a
	[bdr, bdc] = directionToDelta b
	(adr + bdr == 0) and (adc + bdc == 0)

INIT_GRID = [
	[1  , 2  , 3  , 4  ]
	[5  , 6  , 7  , 8  ]
	[9  , 10 , 11 , 12 ]
	[13 , 14 , 15 , 0  ]
]

print = console.log
range = _.range

