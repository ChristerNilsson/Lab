# stänger eller öppnar
calcBranch = (a,b) ->
	n = Math.min a.length,b.length
	for i in range n
		if a[i] != b[i] then return b
	if a.length < b.length then	b	else b.slice 0,n-1
assert [], calcBranch [0],[0]
assert [0], calcBranch [0,0],[0,0]
assert [], calcBranch [0,0],[0]
assert [0], calcBranch [],[0]
assert [0,0], calcBranch [0],[0,0]
assert [1], calcBranch [0],[1]
assert [0], calcBranch [1],[0]
assert [0,1], calcBranch [0,0],[0,1]
assert [0], calcBranch [1,0],[0]

goDeeper = (a,b) ->
	for i in range Math.min a.length,b.length
		if a[i] != b[i] then return false 
	a.length >= b.length
assert true,  goDeeper [],[]
assert true,  goDeeper [0],[0]
assert true,  goDeeper [0,0],[0,0]
assert true,  goDeeper [0],[]
assert true,  goDeeper [0,0],[0]
assert false, goDeeper [],[0]
assert false, goDeeper [0],[0,0]
assert false, goDeeper [0],[1]
assert false, goDeeper [1],[0]
assert false, goDeeper [0,0],[0,1]
assert false, goDeeper [1,0],[0]

makeButton = (value,bg,sc) ->
	res = document.createElement "input"
	res.type = 'button'
	res.value = value 
	res.style.cssText = "font-size:100%; white-space:normal; width:100%;" #  text-align:left
	res.style.backgroundColor = bg 
	res.style.color = sc
	res
