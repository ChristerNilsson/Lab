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

todos = (props,children=[]) ->
	[
		h3 {},"Todo List (#{children.length})"
		todo item for item in children when state.ok item
	]

todo = (props,children=[]) ->
	div {},[
		checkbox {onchange:"state.toggle(#{props.id})", value: props.completed}
		strong {}, "#{props.title} (#{props.userId})"
	]

class State 
	constructor : (@todos) ->
		@a=false # completed
		@b=true # not completed
		@c=0 # userId

	init : ->
		struktur = [
			checkbox {onchange:"state.filter(!state.a,state.b,state.c)", value:@a},'completed'
			checkbox {onchange:"state.filter(state.a,!state.b,state.c)", value:@b},'not completed'
			button {   onclick:"state.filter(state.a,state.b,state.c+1)"}, @c
			todos {},@todos
		]
		print struktur
		@update 'body', render struktur

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
		print name,value 
		@[name] = value
		obj = document.getElementById name
		if obj then obj.innerHTML = value

state = null
setup = -> 
	state = new State data
	state.init()
