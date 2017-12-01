# render = (node) ->
# 	if Array.isArray node then return (render child for child in node).join ''
# 	if typeof node != 'object' then return node
# 	_props = (' ' + key + '="' + attr + '"' for key,attr of node.props).join ''
# 	"<#{node.tag}#{_props}>#{render node.children}</#{node.tag}>\n"

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

todos = (props,children=[]) ->
	[
		h3 "Todo List (#{children.length})"
		lst = (todo item for item in children when state.ok item)
		h3 lst.length
	]

todo = (props,children=[]) ->
	div {},
		checkbox onchange:"state.toggle(#{props.id})", value: props.completed
		strong "#{props.title} (#{props.userId})"

class State 
	constructor : (@todos) ->
		@a=false # completed
		@b=true # not completed
		@c=0 # userId

	init : ->
		start = millis()
		struktur = [
			checkbox onchange:"state.filter(!state.a,state.b,state.c)", value:@a,'completed'
			checkbox onchange:"state.filter(state.a,!state.b,state.c)", value:@b,'not completed'
			button onclick:"state.filter(state.a,state.b,state.c+1)", @c
			todos {},@todos
		]
		#print struktur
		@update 'body', render struktur
		print millis()-start

	filter : (a,b,c) ->
		@a = a
		@b = b
		@c = c%11
		@init()

	ok : (item) ->
		villkor1 = @a and item.completed or @b and not item.completed
		villkor2 = @c==0 or @c==item.userId
		villkor1 and villkor2

	toggle : (id) ->
		for item in @todos
			if item.id==id then item.completed = not item.completed
		@init()

	fix : (hash) -> @update key,value for key,value of hash
	update : (name,value) ->
		#print name,value 
		@[name] = value
		obj = document.getElementById name
		if obj then obj.innerHTML = value

state = null
setup = -> 
	state = new State data
	state.init()
