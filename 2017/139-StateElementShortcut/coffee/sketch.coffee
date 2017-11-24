class Element 
	constructor : (@attrs, @children=[]) ->
	render : (tag) ->
		res = (' ' + key + '="' + attr + '"' for key,attr of @attrs)
		res = res.join ''
		"<#{tag}#{res}>#{(child.render() for child in @children).join('')}</#{tag}>\n"

class Button extends Element  
	render : -> super 'button'

class Div extends Element 
	render : -> super 'div'

class Table extends Element 
	render : -> super 'table'

class Tr extends Element 
	render : -> super 'tr'

class Td extends Element 
	render : -> super 'td'

class Text
	constructor : (@text) ->
	render : -> @text

class Data 
	constructor : (@name) ->
	render : -> state[@name]

###############################

class State 
	constructor : (@a,@b,@hist) ->
		view = 
			new Div {style:"font-size:30px"},[
				new Div {id:'a'},[new Text @a]
				new Div {id:'b'},[new Text @b]
				new Button {id:'bAdd',onclick:'state.add2()',style:"font-size:30px"},[new Text '+2']
				new Button {id:'bMul',onclick:'state.mul2()',style:"font-size:30px"},[new Text '*2']
				new Button {id:'bDiv',onclick:'state.div2()',style:"font-size:30px"},[new Text '/2']
				new Button {id:'bUndo',onclick:'state.undo()',style:"font-size:30px"},[new Text 'undo']
				new Button {id:'bNext',onclick:'state.next()',style:"font-size:30px"},[new Text 'next']
				new Div {id:'hist'},[new Text @hist]
			]
		@update 'body',view.render()

	add2 : ->
		@update 'hist', @hist.concat [@a] 
		@update 'a', @a+2
	mul2 : ->
		@update 'hist', @hist.concat [@a] 
		@update 'a', @a*2
	div2 : ->
		@update 'hist', @hist.concat [@a] 
		@update 'a', @a/2
	undo : ->
		if @hist.length == 0 then return
		@update 'a', @hist.pop()
		@update 'hist', @hist
	next : ->
		@update 'a', int 1 + 20 * random() 
		@update 'b', int 1 + 20 * random() 
		@update 'hist', []
	update : (name,value) ->
		print name,value 
		@[name] = value
		document.getElementById(name).innerHTML = value

state = null

setup = -> state = new State 7,1,[]
