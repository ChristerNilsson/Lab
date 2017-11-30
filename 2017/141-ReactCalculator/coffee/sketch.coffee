render = (node) ->
	if Array.isArray node then return (render child for child in node).join ''
	if typeof node != 'object' then return node
	_props = (' ' + key + '="' + attr + '"' for key,attr of node.props).join ''
	"<#{node.tag}#{_props}>#{render node.children}</#{node.tag}>\n"

button = (p,c=[]) -> {props:p, children:c, tag: 'button'} 
div    = (p,c=[]) -> {props:p, children:c, tag: 'div'}
strong = (p,c=[]) -> {props:p, children:c, tag: 'strong'}
li     = (p,c=[]) -> {props:p, children:c, tag: 'li'}
h3     = (p,c=[]) -> {props:p, children:c, tag: 'h3'}
input  = (p,c=[]) -> {props:p, children:c, tag: 'input'}
table  = (p,c=[]) -> {props:p, children:c, tag: 'table'}
tr     = (p,c=[]) -> {props:p, children:c, tag: 'tr'}
td     = (p,c=[]) -> {props:p, children:c, tag: 'td'}

checkbox = (p,c=[]) -> input (_.extend p, {type:'checkbox'}, if p.value then {checked:true} else {}),c
# checkbox är svår att avläsa. toggla och håll reda på tillståndet själv.

###############################

# https://github.com/ahfarmer/calculator

class State 
	constructor : (@x,@y,@z,@t,@entering) ->
		struktur = [
			div {id:'dt'},@t
			div {id:'dz'},@z
			div {id:'dy'},@y
			div {id:'dx'},@x
			div {},[
				button {onclick: "state.calculate('clr')" }, "clr"
				button {onclick: "state.calculate('chs')"},  "chs"
				button {onclick: "state.calculate('%')"},   "%"
				button {onclick: "state.calculate('÷')" },  "÷"
			]
			div {},[
				button {onclick: "state.calculate('7')"}, "7"
				button {onclick: "state.calculate('8')"}, "8"
				button {onclick: "state.calculate('9')"}, "9"
				button {onclick: "state.calculate('x')"}, "x"
			]
			div {},[
				button {onclick:"state.calculate('4')" }, "4"
				button {onclick:"state.calculate('5')" }, "5"
				button {onclick:"state.calculate('6')" }, "6"
				button {onclick:"state.calculate('-')" }, "-"
			]
			div {},[ 
				button {onclick:"state.calculate('1')" }, "1"
				button {onclick:"state.calculate('2')" }, "2"
				button {onclick:"state.calculate('3')" }, "3"
				button {onclick:"state.calculate('+')" }, "+"
			]
			div {},[
				button {onclick:"state.calculate('0')" },   "0"
				button {onclick:"state.calculate('.')" },   "."
				button {onclick:"state.calculate('enter')" }, "enter"
			]
		]
		@update 'body', render struktur  

	calculate : (buttonName) -> 
		if buttonName == 'clr' then @fix {x:"0", y:"0", "z":0, t:"0", entering:false}
		if buttonName == 'enter' then @fix {x:@x, y:@x, z:@y, t:@z, entering:false }
		if buttonName == 'chs' then	@x = -@x
		if buttonName in "+-x÷%"
			x = parseFloat @x
			y = parseFloat @y
			if buttonName == '+' then @x = y+x
			if buttonName == '-' then @x = y-x
			if buttonName == 'x' then @x = y*x
			if buttonName == '÷' then @x = y/x
			if buttonName == '%' then @x = y%x
			@fix {x: @x.toString(), y:@z, z:@t, entering:false}

		if buttonName in "0123456789."
			if @entering
				if buttonName in '0123456789' or not @x.includes('.')
					@fix {x: @x + buttonName}
			else @fix {x: buttonName, y:@x, z:@y, t:@z, entering:true}

		@fix {dx:@x, dy:@y, dz:@z, dt:@t} # display

	fix : (hash) -> @update key,value for key,value of hash

	update : (name,value) ->
		print name,value 
		@[name] = value
		obj = document.getElementById name
		if obj then obj.innerHTML = value

state = null
setup = -> state = new State '3','2','1','0',false
