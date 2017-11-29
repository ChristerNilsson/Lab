render = (tag,attrs,children) ->
	res = (' ' + key + '="' + attr + '"' for key,attr of attrs).join ''
	"<#{tag}#{res}>#{(child for child in children).join('')}</#{tag}>\n"

button = (attrs,children=[]) -> render 'button',attrs,children
div = (attrs,children=[]) -> render 'div',attrs,children

###############################

class State 
	constructor : (@time,@flag,@start,@memory) ->
		@update 'body', 
			div {style:"font-size:50px"}, [
				div {}, 
					for d,i in 'd5 d4 d3 d2 d1 d0'.split ' '
						button {style:"font-size:40px", id:d, onclick: "state.f(#{5-i},#{[3,10,6,10,6,10][i]})"}, ["0"] 
				div {}, [
					button {style:"font-size:40px; width:140px", id:'brun', onclick: "state.run()"},   ["run"]
					button {style:"font-size:40px; width:140px", id:'bclear',onclick: "state.clear()"}, ["clear"]
				]
			]
	f : (i,n) -> 
		@time[i] = (@time[i]+1)%n
		@memory[i] = (@memory[i]+1)%n
		@fix {}
	run : -> 
		@flag = not @flag
		if @flag
			@enableMusic()
			@start = int millis()/1000
			@secs = 0
			for i in range 6
				@secs += [1,10,60,600,3600,36000][i] * @time[i]
	clear : -> 
		@stopMusic()
		if not _.isEqual @time,@memory
			for i in range 6 
				@time[i] = @memory[i]
		else
			for i in range 6 
				@time[i] = 0
				@memory[i] = 0
		@fix {}

	enableMusic : ->
		@music = true
	playMusic : ->
		if @music then audio.play()
	stopMusic : ->
		@music = false
		audio.pause()

	fix : (hash) -> 
		@update key,value for key,value of hash
		for d,i in 'd0 d1 d2 d3 d4 d5'.split ' '
			@update d,@time[i]
			@disable d,@flag
		if not @flag and _.isEqual @time, [0,0,0,0,0,0]
			@playMusic()
		@disable 'brun', _.isEqual @time, [0,0,0,0,0,0]
		@disable 'bclear',@flag

	update : (name,value) ->
		@[name] = value
		obj = document.getElementById name
		if obj then obj.innerHTML = value

	disable : (name,value) -> document.getElementById(name).disabled = value

	draw : ->
		if @flag
			s = @secs - (int(millis()/1000) - @start)
			if s==0 then @flag=false 
			for i in range 6
				n = [36000,3600,600,60,10,1][i]
				@time[5-i] = int s / n
				s %= n
			@fix {secs : @secs}
			@fix {brun:'pause'}
		else
			@fix {brun:'run'}

audio = new Audio 'music.mp3'
audio.play()

state = null
setup = -> state = new State [0,0,0,0,0,0],false,0,[0,0,0,0,0,0]
draw = ->	state.draw()
