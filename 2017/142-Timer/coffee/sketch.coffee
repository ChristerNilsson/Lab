render = (tag,attrs,children) ->
	res = (' ' + key + '="' + attr+ '"' for key,attr of attrs).join ''
	"<#{tag}#{res}>#{(child for child in children).join('')}</#{tag}>\n"

button = (a,c) -> render 'button',a,c
div = (a,c) -> render 'div',a,c
table = (a,c) -> render 'table',a,c
tr = (a,c) -> render 'tr',a,c
td = (a,c) -> render 'td',a,c

###############################

class State 
	constructor : ->
		@time = [0,0,0,0,0,0]
		@runState = 0 # 0=start 1=pause 2=resume
		@start = 0
		@memory = [0,0,0,0,0,0]
		print @update 'body', 
			div {}, [
				table {},[
					tr {style:"font-size:20px;"},[
						td {style:"width:90px"},[
							div {},['Hours']
							button {id:'d5', style:"font-size:30px; width:40px", onclick: "state.f(5,3)"}, [0] 
							button {id:'d4', style:"font-size:30px; width:40px", onclick: "state.f(4,10)"}, [0] 
						]
						td {style:"width:90px"},[
							div {},['Minutes']
							button {id:'d3', style:"font-size:30px; width:40px", onclick: "state.f(3,6)"}, [0] 
							button {id:'d2', style:"font-size:30px; width:40px", onclick: "state.f(2,10)"}, [0] 
						]
						td {style:"width:90px"},[
							div {},['Seconds']
							button {id:'d1', style:"font-size:30px; width:40px", onclick: "state.f(1,6)"}, [0] 
							button {id:'d0', style:"font-size:30px; width:40px", onclick: "state.f(0,10)"}, [0] 
						]
					]
				]
				div {}, [
					button {id:'bdone',style:"font-size:30px; width:135px", onclick: "state.done()"}, ["Done"]
					button {id:'brun', style:"font-size:30px; width:135px", onclick: "state.run()"},  ["Start"] 
				]
			]
	f : (i,n) -> 
		@time[i] = (@time[i]+1)%n
		@memory[i] = (@memory[i]+1)%n
		@fix {}
	run : -> 
		@runState = [1,2,1][@runState]
		if @runState == 1
			@enableMusic()
			@start = int millis()/1000
			@secs = 0
			for i in range 6
				@secs += [1,10,60,600,3600,36000][i] * @time[i]
	done : -> 
		@stopMusic()
		if not _.isEqual @time,@memory
			for i in range 6 
				@time[i] = @memory[i]
		else
			for i in range 6 
				@time[i] = 0
				@memory[i] = 0
		@runState=0
		@fix {}

	enableMusic : -> @music = true
	playMusic : -> if @music then audio.play()
	stopMusic : ->
		@music = false
		audio.pause()

	fix : (hash) -> 
		@update key,value for key,value of hash
		for d,i in 'd0 d1 d2 d3 d4 d5'.split ' '
			@update d,@time[i]
			@disable d,@runState==1
		if @runState==2 and _.isEqual @time, [0,0,0,0,0,0]
			@runState=0
			@playMusic()
		@disable 'bdone', @runState==1
		@disable 'brun', _.isEqual @time, [0,0,0,0,0,0]
		@update 'brun',['Start','Pause','Resume'][@runState]
		@bg 'brun',['lightgreen','red','lightgreen'][@runState]

	update : (id,value) ->
		@[id] = value
		obj = document.getElementById id
		if obj then obj.innerHTML = value

	disable : (id,value) -> document.getElementById(id).disabled = value
	bg : (id,value) -> document.getElementById(id).style.backgroundColor = value

	draw : ->
		if @runState==1
			s = @secs - (int(millis()/1000) - @start)
			if s==0 then @runState=2
			for i in range 6
				n = [36000,3600,600,60,10,1][i]
				@time[5-i] = int s / n
				s %= n
			@fix {secs : @secs}
		@fix {}

audio = new Audio 'music.mp3'
audio.play()

state = null
setup = -> state = new State
draw = ->	state.draw()
