render = (tag,attrs,children) ->
	res = (' ' + key + '="' + attr + '"' for key,attr of attrs).join ''
	"<#{tag}#{res}>#{(child for child in children).join('')}</#{tag}>\n"

button = (a,c) -> render 'button',a,c
div = (a,c) -> render 'div',a,c
strong = (a,c) -> render 'strong',a,c
li = (a,c) -> render 'li',a,c
h3 = (a,c) -> render 'h3',a,c
input = (a,c=[]) -> render 'input',a,c
checkbox = (a,c=[]) -> input (_.extend a, {type:'checkbox'}, if a.value then {checked:true}),c

many = (children,f) -> children.map(f).join ''

# checkbox är svår att avläsa. toggla och håll reda på tillståndet själv.

###############################

todos = (attrs,children=[]) ->
	div {},[
		h3 {},["Todo List (#{children.length})"]
		many children, (item) -> todo item
	]

todo = (props,children=[]) ->
	villkor1 = state.a and props.completed or state.b and not props.completed
	villkor2 = state.c==0 or state.c==props.userId
	if villkor1 and villkor2 
		div {},[
			checkbox {onchange:"state.toggle(#{props.id})", value: props.completed}
			strong {},[
				props.title
				" (#{props.userId})"
			]
		]
	else
		''

class State 
	constructor : (@todos) ->
		@a=false # completed
		@b=true # not completed
		@c=0 # userId

	init : ->
		@update 'body', 
			div {},[
				checkbox {onchange:"state.filter(!state.a,state.b,state.c)", value:@a},['completed']
				checkbox {onchange:"state.filter(state.a,!state.b,state.c)", value:@b},['not completed']
				button {onclick:"state.filter(state.a,state.b,state.c+1)"}, [@c]
				todos {},@todos
			]

	filter : (a,b,c) ->
		@a = a
		@b = b
		@c = c%11
		@init()

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
