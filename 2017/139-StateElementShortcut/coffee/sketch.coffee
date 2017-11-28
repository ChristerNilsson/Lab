render = (tag,attrs,children) ->
	res = (' ' + key + '="' + attr + '"' for key,attr of attrs).join ''
	"<#{tag}#{res}>#{(child for child in children).join('')}</#{tag}>\n"

button = (attrs,children) -> render 'button',attrs,children
div = (attrs,children) -> render 'div',attrs,children
table = (attrs,children) -> render 'table',attrs,children
tr = (attrs,children) -> render 'tr',attrs,children
td = (attrs,children) -> render 'td',attrs,children

###############################

class State 
	constructor : (@a,@b,@hist) ->
		@update 'body',
			div {style:"font-size:30px"},[
				div {id:'a'},[@a]
				div {id:'b'},[@b]
				button {id:'bAdd',onclick:'state.add2()',style:"font-size:30px"},['+2']
				button {id:'bMul',onclick:'state.mul2()',style:"font-size:30px"},['*2']
				button {id:'bDiv',onclick:'state.div2()',style:"font-size:30px"},['/2']
				button {id:'bUndo',onclick:'state.undo()',style:"font-size:30px"},['undo']
				button {id:'bNext',onclick:'state.next()',style:"font-size:30px"},['next']
				div {id:'hist'},[@hist]
			]

	add2 : -> @fix {'hist': @hist.concat([@a]), 'a': @a+2}
	mul2 : -> @fix {'hist': @hist.concat([@a]), 'a': @a*2}
	div2 : -> @fix {'hist': @hist.concat([@a]), 'a': @a/2}
	undo : -> @fix {'a': @hist.pop(), 'hist':@hist}
	next : -> @fix {'a': int(1 + 20 * random()),'b': int(1 + 20 * random()),'hist': []}
	fix : (hash) -> @update key,value for key,value of hash
	update : (name,value) ->
		print name,value 
		@[name] = value
		document.getElementById(name).innerHTML = value
		@disable 'bUndo',@hist.length==0 or @a==@b
		@disable 'bAdd', @a==@b
		@disable 'bMul', @a==@b
		@disable 'bDiv', @a==@b or @a%2==1
		@disable 'bNext', @a!=@b
	disable : (name,value) ->	document.getElementById(name).disabled = value

state = null
setup = -> state = new State 7,1,[]
