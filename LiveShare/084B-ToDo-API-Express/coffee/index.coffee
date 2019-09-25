fs = require 'fs'
_ = require 'lodash'
PATH = 'db.txt'

express = require 'express'
app = express()
app.use express.urlencoded { extended: false } # req.body

class Database
	constructor : () -> 

	read : -> Object.assign @, JSON.parse fs.readFileSync PATH,'utf-8'
	write : -> fs.writeFileSync PATH, JSON.stringify @
	
	add : (text) =>	
	delete : (id) => 
	reset : => 
		@add text for text in 'buy food|fetch lamps|walk dog|feed cat|köp räksmörgåsar'.split '|'

db = new Database()

app.get '/reset', (req, res) ->	res.send 'reset'
app.get '/todos', (req, res) ->	
app.get '/todos/:id', (req, res) ->
app.delete '/todos/:id', (req, res) ->
app.post '/todos', (req, res) ->
app.put '/todos', (req, res) ->

PORT = process.env.PORT || 3000
app.listen PORT, -> console.log "Server started on port #{PORT}"
