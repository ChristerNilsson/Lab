{LocalStorage} = require 'node-localstorage'
_ = require 'lodash'

express = require 'express'
app = express()

# methodOverride is used for DELETE and PUT
methodOverride = require 'method-override'
app.use methodOverride '_method'

print = console.log

{a,button,div,form,h1,input,p,render,renderable,table,td,tr} = require 'teacup'

app.use express.urlencoded { extended: false }

st1 = 'display:inline-block; width:200px'

addHeader = (text1,text2,action,parent=null) ->
	p ->
		div style:st1, text1
		form action:action, method:"POST", ->
			input style:st1, name:'data'
			div style:st1,-> button text2
			if parent then input style:st1, name:'parent', value:parent

addDetail = (text1,text2,href,parent = null) -> 
	div ->
		form action:href + '?_method=DELETE', method:"POST", ->
			div style:st1, ->
				if href then a text1, href:href else div text1
			div style:st1, -> button text2
			if parent then input style:st1, name:'parent', value:parent

# GET

app.get '/', (req, res) -> res.redirect '/users'

app.get '/users', (req, res) ->
	res.send render ->
		addHeader 'Users', 'Add User', '/users'
		for key,user of db.users
			addDetail user.name, 'Delete', '/users/' + key

app.get '/users/:id', (req, res) ->
	id = parseInt req.params.id
	user = db.users[id]
	res.send render ->
		addHeader 'User ' + user.name, 'Add List', '/lists',id
		for key,list of db.lists
			if list.userId == id
				addDetail list.name, 'Delete', '/lists/' + key, id

app.get '/lists/:id', (req, res) ->
	id = parseInt req.params.id
	list = db.lists[id]
	res.send render ->
		addHeader 'List ' + list.name, 'Add Item', '/items',id
		for key,item of db.items
			if item.listId == id
				addDetail item.name, 'Delete', '/items/' + key, id

# POST

app.post '/users', (req, res) -> 
	addUser req.body.data
	res.redirect '/'

app.post '/lists', (req, res) -> 
	userId = parseInt req.body.parent
	addList userId, req.body.data
	res.redirect '/users/' + userId

app.post '/items', (req, res) -> 
	listId = parseInt req.body.parent
	addItem listId, req.body.data
	res.redirect '/lists/' + listId

# DELETE

app.delete '/users/:id', (req, res) -> 
	#print 'delete /users/:id'
	deleteUser parseInt req.params.id
	res.redirect '/users/'

app.delete '/lists/:id', (req, res) -> 
	#print 'delete /lists/:id',req.body.parent 
	deleteList parseInt req.params.id
	res.redirect '/users/' + req.body.parent

app.delete '/items/:id', (req, res) -> 
	#print 'delete /items/:id'
	deleteItem parseInt req.params.id
	res.redirect '/lists/' + req.body.parent

#

KEY = 'LocalStorage'
localStorage = null
db = {users:{}, lists:{}, items:{}}

addUser = (name) =>
	if _.size(db.users) == 0 then id = 1 else id  = 1 + parseInt _.max(_.keys db.users)
	db.users[id] = {name}
	localStorage.setItem 'users',JSON.stringify db.users

addList = (userId,name) =>
	if _.size(db.lists) == 0 then id = 1 else id  = 1 + parseInt _.max(_.keys db.lists)
	db.lists[id] = {userId,name}
	localStorage.setItem 'lists',JSON.stringify db.lists

addItem = (listId,name) =>
	if _.size(db.items) == 0 then id = 1 else id  = 1 + parseInt _.max(_.keys db.items)
	db.items[id] = {listId,name}
	localStorage.setItem 'items', JSON.stringify db.items

deleteUser = (id) =>	
	delete db.users[id]
	localStorage.setItem 'users', JSON.stringify db.users

deleteList = (id) =>	
	delete db.lists[id]
	localStorage.setItem 'lists', JSON.stringify db.lists

deleteItem = (id) =>	
	delete db.items[id]
	localStorage.setItem 'items', JSON.stringify db.items

open = =>
	localStorage = new LocalStorage KEY 
	db.users = JSON.parse localStorage.getItem 'users'
	db.lists = JSON.parse localStorage.getItem 'lists'
	db.items = JSON.parse localStorage.getItem 'items'

reset = =>
	localStorage = new LocalStorage KEY 
	localStorage.clear()

	addUser 'Christer'
	addUser 'Anna'
	
	addList 1,'home'
	addList 1,'work'
	addList 2,'home'
	addList 2,'work'

	addItem 1,'buy food'
	addItem 1,'fetch lamps'
	addItem 2,'walk dog'
	addItem 2,'feed cat'

reset()
#open()

console.log db

PORT = process.env.PORT || 3000
app.listen PORT, -> console.log "Server started on port #{PORT}"

Christer: 
	children:
		Home:
			children:
				BuyLamps: 
					marked:false
				FetchFood: 
					marked:false
		Work:
			children:
				WalkCat:
					marked:false
				FeedDog: 
					marked:false
Anna:  
	children:
		Home:
			children:
				BuyFood: 
					marked:false
				FetchLamps: 
					marked:false
		Work:
			children:
				WalkDog: 
					marked:false
				FeedCat: 
					marked:false
