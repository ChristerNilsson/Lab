render = (node) ->
	if Array.isArray node then return (render child for child in node).join ''
	if typeof node != 'object' then return node
	_props = (' ' + key + '="' + attr + '"' for key,attr of node.props).join ''
	"<#{node.tag}#{_props}>#{render node.children}</#{node.tag}>\n"

fix = (tag,...options) ->
	if typeof options[0] == 'object'
		props = options.shift() 
	else
		props = {}
	{tag:tag, props:props, children: if options.length==0 then [] else options}

a      = -> fix 'a',...arguments
button = -> fix 'button',...arguments
code   = -> fix 'code',...arguments
div    = -> fix 'div',...arguments
form   = -> fix 'form',...arguments
header = -> fix 'header',...arguments
h1     = -> fix 'h1',...arguments
h3     = -> fix 'h3',...arguments
img    = -> fix 'img',...arguments
input  = -> fix 'input',...arguments
label  = -> fix 'label',...arguments
li     = -> fix 'li',...arguments
option = -> fix 'option',...arguments
p      = -> fix 'p',...arguments
sel    = -> fix 'select',...arguments
strong = -> fix 'strong',...arguments
table  = -> fix 'table',...arguments
tr     = -> fix 'tr',...arguments
td     = -> fix 'td',...arguments

checkbox = (p,...options) -> input (_.extend p, {type:'checkbox'}, if p.value then {checked:true} else {}),...options
# checkbox är svår att avläsa. toggla och håll reda på tillståndet själv.

###############################

# https://github.com/ahfarmer/calculator

class State 
	constructor : (@x,@y,@z,@t,@entering) ->
		struktur = [
			div id:'dt', @t
			div id:'dz', @z
			div id:'dy', @y
			div id:'dx', @x
			div {},
				button onclick: "state.calculate('clr')", "clr"
				button onclick: "state.calculate('chs')", "chs"
				button onclick: "state.calculate('%')",   "%"
				button onclick: "state.calculate('÷')",   "÷"
			div {},
				button onclick: "state.calculate('7')", "7"
				button onclick: "state.calculate('8')", "8"
				button onclick: "state.calculate('9')", "9"
				button onclick: "state.calculate('x')", "x"
			div {},
				button onclick:"state.calculate('4')", "4"
				button onclick:"state.calculate('5')", "5"
				button onclick:"state.calculate('6')", "6"
				button onclick:"state.calculate('-')", "-"
			div {},
				button onclick:"state.calculate('1')", "1"
				button onclick:"state.calculate('2')", "2"
				button onclick:"state.calculate('3')", "3"
				button onclick:"state.calculate('+')", "+"
			div {},
				button onclick:"state.calculate('0')",   "0"
				button onclick:"state.calculate('.')",   "."
				button onclick:"state.calculate('enter')", "enter"
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
