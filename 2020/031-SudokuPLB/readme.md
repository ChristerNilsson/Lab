# https://github.com/attractivechaos/plb/blob/master/sudoku/incoming/sudoku-gh.js

20 times slower than 030 due to DLX used without knowledge about sudoku
This applies to easy problems.

Harder problems takes the double time.

Defined iter to be used as a replacement for javascript while:
```
for (var i = c.down; i != c; i = i.down)

iter = (dir, c, body) ->
	i = c[dir]
	while i != c
		body i
		i = i[dir]

```
Seems to double exec time.