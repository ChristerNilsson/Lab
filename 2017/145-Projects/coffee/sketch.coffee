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
# setState i React bör undersökas
# Gäller även this.refs samt ref.

###############################

addProject = (props,children=[]) ->
	div {},
		h3 "Add Project"
		div {},
			label "Title"
			input id:'title', type:"text"
		div {},
			label "Category"
			sel id:"category", 
				option {value:cat},cat for cat in props.categories
		button onclick:"state.addProject()", 'Submit'

project = (proj,children=[]) ->
	li {},
		strong {}, 
			"#{proj.title} (#{proj.category}) "
			a href:"#", onclick:"state.deleteProject(#{proj.id})", "Delete"

projects = (props,children=[]) -> 
	div {}, 
		addProject categories: ['Web Design', 'Web Development', 'Mobile Development']
		h3 "Latest Projects"
		project p for p in children

class State 
	constructor : (@projects) ->
			
	init : ->
		struktur = [projects {}, @projects]
		print  struktur
		@update 'body', render struktur

	addProject : ->
		obj1 = document.getElementById 'title'
		obj2 = document.getElementById 'category'
		p = {
			id: 99,
			title: obj1.value,
			category: obj2.value
		}
		@projects.push p 
		@init()

	deleteProject : (id) ->
		index = @projects.findIndex (x) -> x.id == id
		@projects.splice index, 1
		@init() #@setState {projects:projects}

	fix : (hash) -> @update key,value for key,value of hash
	update : (name,value) ->
		@[name] = value
		obj = document.getElementById name
		if obj then obj.innerHTML = value

data = [
	{
		id:1,
		title: 'Business Website',
		category: 'Web Design'
	}
	{
		id:2,
		title: 'Social App',
		category: 'Mobile Development'
	}
	{
		id:3,
		title: 'Ecommerce Shopping Cart',
		category: 'Web Development'
	}
]

state = null
setup = -> 
	state = new State data
	state.init()
