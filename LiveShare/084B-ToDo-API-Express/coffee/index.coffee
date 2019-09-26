fs = require 'fs'
_ = require 'lodash'
PATH = 'db.txt'

express = require 'express'
app = express()
app.use express.urlencoded { extended: false } # req.body

# Todo:
# ID   1..
# Text "Feed the Cat"
# Done false

class Database 
	constructor : () -> 
		@clear()
		@demo()

	read : -> Object.assign this, JSON.parse fs.readFileSync PATH,'utf-8'
	write : -> fs.writeFileSync PATH, JSON.stringify this

	add : (text) ->
		this.todos.push {id: ++@last, text: text, done: false}
		@write()

	clear : () ->
		this.todos = []
		this.last = 0
		@write()

	delete : (id) ->
	demo : ->
		@add text for text in 'buy food|fetch lamps|walk dog|feed cat|köp räksmörgåsar'.split '|'

db = new Database()

app.post '/todos/demo', (req, res) ->
	db.clear()
	db.demo()
	res.send db.todos

app.post '/todos', (req, res) ->
	db.add req.body.text
	res.send _.last db.todos

app.get '/todos', (req, res) -> res.send db.todos
app.get '/todos/:id', (req, res) -> res.send db.todos.find (todo) -> todo.id == parseInt req.params.id

app.put '/todos', (req, res) -> 
	todo = db.todos.find (todo) -> todo.id == parseInt req.body.id
	todo.text = req.body.text
	todo.done = JSON.parse req.body.done
	db.write()
	res.send todo

app.delete '/todos', (req, res) ->
	count = db.todos.length
	db.clear()
	res.send "#{count} items was deleted"
app.delete '/todos/:id', (req, res) ->
	id = parseInt req.params.id
	db.todos = db.todos.filter (todo) -> todo.id != id
	db.write()
	res.send "The item with id=#{id} was deleted"

PORT = process.env.PORT || 3000
app.listen PORT, -> console.log "Server started on port #{PORT}"
