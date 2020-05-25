nilsson_version = "1.5" # getParameters with 0 parameters fixed 

# chai visar listinnehåll på ett bra sätt. 
# _.isEqual(a,b) fungerar också men det blir sämre listutskrifter
assert = (a, b, msg='Assert failure') -> chai.assert.deepEqual a, b, msg

fixColor = (args) ->
	n = args.length
	a = 1
	[r,g,b] = [args[0],args[0],args[0]] if n == 1
	[r,g,b,a] = [args[0],args[0],args[0],args[1]] if n == 2 
	[r,g,b] = args if n == 3
	[r,g,b,a] = args if n == 4
	return color 255 * r, 255 * g, 255 * b, 255 * a

fc = -> if arguments.length == 0 then noFill() else fill fixColor arguments
sc = -> if arguments.length == 0 then noStroke() else stroke fixColor arguments
bg = -> background fixColor arguments
sw = (n) -> strokeWeight n
circle = (x,y,r) -> ellipse x,y,2*r,2*r
rd = (degrees) -> rotate radians degrees
print = console.log
range = _.range # from underscore.coffee
merp = (y1,y2,i,x1=0,x2=1) -> map i,x1,x2,y1,y2

getParameters = (h = window.location.href) -> 
	h = decodeURI h
	arr = h.split('?')
	if arr.length != 2 then return {}
	s = arr[1]
	if s=='' then return {}
	_.object(f.split '=' for f in s.split('&'))
assert getParameters('http:\\christernilsson.github.io\Shortcut\www'), {}
assert getParameters('http:\\christernilsson.github.io\Shortcut\www?'), {}
assert getParameters('http:\\christernilsson.github.io\Shortcut\www?a=0&b=1'), {'a':'0', 'b':'1'}

compare = (a,b) ->
	if typeof a == "object" and typeof b == "object"
		for i in range Math.min a.length,b.length
			c = compare a[i],b[i]
			if c != 0 then return c
	else
		return (if a > b then -1 else (if a < b then 1 else 0))
	0
assert compare(12,13), 1
assert compare(12,12), 0
assert compare(13,12), -1
assert compare([1,11],[1,2]), -1
assert compare([1,11],[1,11]), 0
assert compare([1,2],[1,11]), 1
assert compare([1,'11'],[1,'2']), 1
assert compare([1,'11'],[1,'11']), 0
assert compare([1,'2'],[1,'11']), -1

bsort = (list,cmp=compare) ->
	for i in range list.length
		for j in range list.length-1
			[list[j], list[j+1]] = [list[j+1], list[j]] if cmp(list[j], list[j+1]) < 0
	list
assert bsort([1,8,2],compare), [1,2,8]
assert bsort([1,8,2],compare), [1,2,8]
assert bsort([[1],[8],[2]],compare), [[1],[2],[8]]
assert bsort([[2,1],[2,8],[2,2]],compare), [[2,1],[2,2],[2,8]]
assert bsort([[1,8], [1,7], [1,9]],compare), [[1,7], [1,8], [1,9]]
assert bsort([3,2,4,1], compare), [1,2,3,4]

