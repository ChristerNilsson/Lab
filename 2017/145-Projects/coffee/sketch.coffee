render = (node) ->
	if Array.isArray node then return (render child for child in node).join ''
	if typeof node != 'object' then return node
	_props = (' ' + key + '="' + attr + '"' for key,attr of node.props).join ''
	"<#{node.tag}#{_props}>#{render node.children}</#{node.tag}>\n"

a      = (p,c=[]) -> {props:p, children:c, tag: 'a'} 
button = (p,c=[]) -> {props:p, children:c, tag: 'button'} 
div    = (p,c=[]) -> {props:p, children:c, tag: 'div'}
form   = (p,c=[]) -> {props:p, children:c, tag: 'form'}
h3     = (p,c=[]) -> {props:p, children:c, tag: 'h3'}
input  = (p,c=[]) -> {props:p, children:c, tag: 'input'}
label  = (p,c=[]) -> {props:p, children:c, tag: 'label'}
li     = (p,c=[]) -> {props:p, children:c, tag: 'li'}
option = (p,c=[]) -> {props:p, children:c, tag: 'option'}
sel    = (p,c=[]) -> {props:p, children:c, tag: 'select'}
strong = (p,c=[]) -> {props:p, children:c, tag: 'strong'}
table  = (p,c=[]) -> {props:p, children:c, tag: 'table'}
tr     = (p,c=[]) -> {props:p, children:c, tag: 'tr'}
td     = (p,c=[]) -> {props:p, children:c, tag: 'td'}

checkbox = (p,c=[]) -> input (_.extend p, {type:'checkbox'}, if p.value then {checked:true} else {}),c

# checkbox är svår att avläsa. toggla och håll reda på tillståndet själv.
# setState i React bör undersökas
# Gäller även this.refs samt ref.

###############################

addProject = (props,children=[]) ->
	div {}, [
		h3 {},"Add Project"
		div {}, [
			label {}, "Title"
			input {id:'title', type:"text"}
		]
		div {},[
			label {}, "Category"
			sel {id:"category"}, [option {value:cat},cat for cat in props.categories]
		]
		button {onclick:"state.addProject()"}, 'Submit'
	]

project = (proj,children=[]) ->
	li {}, [
		strong {}, [
			"#{proj.title} (#{proj.category}) "
			a {href:"#", onclick:"state.deleteProject(#{proj.id})"}, "Delete"
		]
	]

projects = (props,children=[]) -> 
	div {}, [
		addProject {categories: ['Web Design', 'Web Development', 'Mobile Development']}
		h3 {}, "Latest Projects"
		project p for p in children
	]

class State 
	constructor : (@projects) ->
			
	init : ->
		struktur = [projects {}, @projects]
		#print render struktur
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
