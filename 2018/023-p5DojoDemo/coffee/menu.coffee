LINKS = 
	"p5Dojo"       : "https://github.com/ChristerNilsson/p5Dojo/blob/master/README.md#p5dojo"
	"p5Color"      : "https://christernilsson.github.io/p5Color"
	"Links" 			 : "https://christernilsson.github.io/Lab"

class Menu
	constructor : (@items, @table=null, @branch=[]) ->
		@state = 0
		@chapter = ''
		@exercise = ''
		@calls = {}
	rensa : -> @table.innerHTML = ""
	clear : -> @branch = []

	traverse : (items=@items, level=0, br=[]) ->
		if false == goDeeper @branch,br then return

		if level == 0 # chapter
			for key,i in _.keys items
				if i == @branch[level] or @branch.length == level
					@addTitle key, level, i, br.concat i
				children = items[key]
				@traverse children, level+1, br.concat i

		if level == 1 # exercise
			for key,i in _.keys items
				if i == @branch[level] or @branch.length == level
					@addTitle key, level, i, br.concat i
				keywords = items[key].k.split ' '
				keywords.sort()
				@traverse keywords, level+1, br.concat i

		if level == 2 
			# keywords
			for item in items 
				if item != '' then @addTitle item, level, i, br

			# commands
			@calls = decorate data[@chapter][@exercise].c
			for key of @calls
				if key != 'draw()' then @addCommand key, level, BLUE, YELLOW

			# renew
			if localStorage[@exercise + "/v"]? and localStorage[@exercise + "/v"] != data[@chapter][@exercise].v
				b = @addCommand "Renew", level, RED, WHITE
				b.onclick = ->
					print myCodeMirror.getValue() # Låt stå!
					exercise = data[meny.chapter][meny.exercise]
					myCodeMirror.setValue exercise.b
					localStorage[meny.exercise + "/" + 'v'] = exercise.v
					localStorage[meny.exercise + "/" + 'd'] = exercise.b

			# links
			if @exercise != ''
				for text,link of data[@chapter][@exercise].e
					b = @addCommand text, level, GREEN, BLACK
					do (link) -> b.onclick = -> window.open(link, '_blank').focus()
				for text,link of LINKS 
					b = @addCommand text, 0, DARKGREEN, WHITE
					do (link) -> b.onclick = -> window.open(link, '_blank').focus()

	handleRow : (b) ->
		tr = document.createElement "tr"
		addCell tr,b,100
		@table.appendChild tr

	lineCount : -> data[@chapter][@exercise].l

	addTitle : (title,level,i,br) ->
		if level == 2 then b = makeButton title, level, BLACK, YELLOW
		else if @branch[level] == i 
			if level==1 then b = makeButton "#{title} [#{@lineCount()}]", level, WHITE, BLACK
			else b = makeButton title, level, WHITE, BLACK
		else if @branch[level] == i then b = makeButton title, level, WHITE, BLACK
		else b = makeButton title, level, BLACK, WHITE
		b.branch = br

		b.onclick = => 
			if level == 0 then @sel1click b.value
			if level == 1 
				if b.style.backgroundColor == 'rgb(255, 255, 255)'
					@sel2click ""
				else
					@sel2click b.value				
			if level == 2 then @sel3click b.value
			if level in [0,1] then @branch = calcBranch @branch, b.branch
			updateTables()

		@handleRow b
		b

	addCommand : (title,level,color1, color2) ->
		b = makeButton title, level, color1, color2
		code = @calls[title]
		b.onclick = -> 
			if run1(code) == true
				run0 code
			compare()
		@handleRow b
		b

	setState : (st) ->
		@state = st

		#if st==2 then @calls = data[@chapter][@exercise].c else @calls = {}
		$('#input').hide()
		if _.size(@calls) > 0 then $('#input').show() 
		if st==2 then msg.show() else msg.hide()
		if st==2 then $(".CodeMirror").show() else $(".CodeMirror").hide()

		if st<=1
			@calls = {}
			tableClear()
			bg 0.5

		if st==1 then	@exercise = ""

	sel1click : (chapter) ->
		@chapter = chapter
		@exercise = ""
		@calls = {}
		@setState 1

	sel2click : (exercise) ->
		@exercise = exercise
		if @exercise == ""
			myCodeMirror.setValue ""
			bg 0.5
			return
		@calls = data[@chapter][@exercise].c
		@setState 2

		src = localStorage[@exercise + "/d"]
		if src == undefined or src == null or src == ''
			src = data[@chapter][@exercise].b
			localStorage[@exercise + "/d"] = src
			localStorage[@exercise + "/v"] = data[@chapter][@exercise].v
		myCodeMirror.setValue src

		tableClear()

		calls = data[@chapter][@exercise].c		
		if _.size(calls) > 0 
			code = @calls["draw()"]
		if run1(code) == true
			run0 code 

		myCodeMirror.focus()
		compare()

	sel3click : (keyword) ->
		url = buildLink keyword
		if url?
			win = window.open url, '_blank'
			win.focus()
	