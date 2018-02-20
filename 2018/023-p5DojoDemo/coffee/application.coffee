class Application

	constructor : (@_name='b') ->
		classes = {}
		classes[klass.name] = klass for klass in @classes()

		_name = meny.exercise + "/" + @_name
		obj = localStorage.getItem _name
		if obj
			for key,value of JSON.parse obj
				@[key] = @deserialize value,classes

	classes : -> []

	deserialize : (obj,classes) ->
		if _.isObject(obj)
			if _.isArray(obj) then return (@deserialize(item,classes) for item in obj) # array
			if '_type' in _.keys(obj)
				if classes[obj["_type"]] == undefined
					print "Please define classes : -> [" + obj["_type"] + "] in your Application"
					return
				o = _.create classes[obj["_type"]].prototype, {}
				for key,value of obj
					o[key] = @deserialize(value,classes) if key != '_type'
				return o
			else # dict
				res = {}
				for key,value of obj
					res[key] = @deserialize(value,classes)
				return res
		return obj # catches Number, String, Boolean, null etc

	draw : ->

	mark : (obj=@) ->
		#if _.isNull(obj) then return
		if _.isArray(obj) then return	(@mark(item) for item in obj) # array
		if _.isObject(obj)
			obj['_type'] = obj.constructor.name if obj.constructor.name != 'Object'
			for value in _.values obj # annars kommer metoderna med.
				if value? then @mark value

	mousePressed : (mx,my) -> # print "mousePressed", mx, mx

	store : ->
		_name = meny.exercise + "/" + @_name
		@mark()
		obj = JSON.stringify @
		localStorage.setItem _name, obj
		fillTable meny.exercise + "/a", meny.exercise + "/b"

	readText : -> $('#input').val()
	readInt : -> parseInt @readText()
	readFloat : -> parseFloat @readText()
	reset :  ->
		for key in _.keys @
			if key != "_name" then delete @[key]
