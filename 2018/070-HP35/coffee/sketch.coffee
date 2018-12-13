# http://home.citycable.ch/pierrefleur/Jacques-Laporte/Image_deluca/hp35_lcd.pde
# Copyright (c) 2011 DE LUCA Pietro, Italy 
# Redistribution and use in source and binary forms, with or without modification, are permitted provided that the following conditions are met:
# Redistributions of source code must retain the above copyright notice, this list of conditions and the following disclaimer.
# Redistributions in binary form must reproduce the above copyright notice, this list of conditions and the following disclaimer in the documentation and/or other materials provided with the distribution.
# The name of the author may not be used to endorse or promote products derived from this software without specific prior written permission.
# THIS SOFTWARE IS PROVIDED BY THE AUTHOR AS IS AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE ARE DISCLAIMED. IN NO EVENT SHALL THE AUTHOR BE LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES; LOSS OF USE, DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND ON ANY THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF THIS SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.

WSIZE = 14

buttons = []
lcd = null
keyboard = null
hp = null
x = 0 
y = 0

class LCD
	constructor : (@title,@x,@y) ->	@title = (letter for letter in @title)
	print : (m) -> @title[@index++] = m
	update : -> 
		@index = 0
		for i in range WSIZE-1, -1, -1
			if hp.b[i] >= 8 then @print ' '
			else if i in [2,13]
				@print if hp.a[i] >= 8 then '-' else ' '
			else @print hp.a[i]
			if hp.b[i] == 2 then @print '.'

	draw : ->
		push()
		fc 1,0,0
		sc()
		textFont 'monospace'
		textAlign LEFT,CENTER
		textSize 24
		text @title.join(''),@x,@y
		pop()

class Button 
	constructor : (@key_code,@title,@x,@y,@w=30) -> @h = 20
	inside : (x,y) -> @x-@w/2 < x < @x+@w/2 and @y-@h/2 < y < @y+@h/2 
	draw : ->
		textAlign CENTER,CENTER
		fc 1
		rect @x,@y,@w,@h
		fc 0
		if @title == '/'
			text ':',@x,@y+1
			text '-',@x,@y
		else
			text @title,@x,@y+1
		if @title == 'x y'
			line @x-1,@y-4,@x+1,@y-2
			line @x-1,@y  ,@x+1,@y-2
			line @x+1,@y+5,@x-1,@y+3
			line @x+1,@y+1,@x-1,@y+3

class KeyBoard # klarar bara ett tecken
	constructor : -> @buffer = []
	available : -> @buffer.length > 0 
	read : -> @buffer.pop()

setup = ->
	createCanvas 200,500
	rectMode CENTER

	hp = new HP35()
	lcd = new LCD '-1234567890.-35',0,17
	keyboard = new KeyBoard()

	x0 = 24
	x1 = x0+38
	x2 = x1+38
	x3 = x2+38
	x4 = 176

	y0=45
	y1=75
	y2=105
	y3=135
	y4=165
	y5=195
	y6=225
	y7=255

	x5 = 24
	x6 = x5+51
	x7 = x6+51
	x8 = 176

	buttons.push new Button 6,'x^y',x0,y0
	buttons.push new Button 4,'log',x1,y0
	buttons.push new Button 3,'ln',x2,y0
	buttons.push new Button 2,'e^x',x3,y0
	buttons.push new Button 0,'clr',x4,y0

	buttons.push new Button 46,'sqrt',x0,y1
	buttons.push new Button 44,'arc',x1,y1
	buttons.push new Button 43,'sin',x2,y1
	buttons.push new Button 42,'cos',x3,y1
	buttons.push new Button 40,'tan',x4,y1

	buttons.push new Button 14,'1/x',x0,y2
	buttons.push new Button 12,'x y',x1,y2
	buttons.push new Button 11,'rdn',x2,y2
	buttons.push new Button 10,'sto',x3,y2
	buttons.push new Button 8,'rcl',x4,y2

	buttons.push new Button 62,'enter',43,y3,68
	buttons.push new Button 59,'chs',x2,y3
	buttons.push new Button 58,'eex',x3,y3
	buttons.push new Button 56,'clx',x4,y3

	buttons.push new Button 54,'-',x5,y4
	buttons.push new Button 52,'7',x6,y4
	buttons.push new Button 51,'8',x7,y4
	buttons.push new Button 50,'9',x8,y4

	buttons.push new Button 22,'+',x5,y5
	buttons.push new Button 20,'4',x6,y5
	buttons.push new Button 19,'5',x7,y5
	buttons.push new Button 18,'6',x8,y5

	buttons.push new Button 30,'x',x5,y6
	buttons.push new Button 28,'1',x6,y6
	buttons.push new Button 27,'2',x7,y6
	buttons.push new Button 26,'3',x8,y6

	buttons.push new Button 38,'/',x5,y7
	buttons.push new Button 36,'0',x6,y7
	buttons.push new Button 35,'.',x7,y7
	buttons.push new Button 34,'pi',x8,y7

	frameRate 10

dump = (name,lst,y,n=14) ->
	if not hp.TRACE then return 
	fc 1,1,0
	text name,10,y
	for i in range n
		text lst[i], 30+(15-i)*10, y

dump1 = (prompt,value) ->
	if not hp.TRACE then return 
	text prompt,x,y
	text value,x+100,y
	y+=12

draw = ->
	bg 0
	lcd.draw()
	textSize 16	
	for button in buttons
		button.draw()

	textAlign LEFT,CENTER
	textSize 12

	y8=280

	dump 'a',hp.a,y8
	dump 'b',hp.b,y8+12
	dump 'c x',hp.c,y8+24
	dump 'd y',hp.d,y8+36
	dump 'e z',hp.e,y8+48
	dump 'f t',hp.f,y8+60
	dump 't',hp.t,y8+72
	dump 'm',hp.m,y8+84
	dump 's',hp.s,y8+96,12

	x = 10
	y = 395
	dump1 'p', hp.p
	dump1 'carry', hp.carry
	dump1 'offset:pc', "#{hp.offset}:#{hp.pc}"
	dump1 'display_enable',hp.display_enable
	dump1 'update_display',hp.update_display
	dump1 'op_code', hp.op_code
	dump1 'first', hp.first
	dump1 'last', hp.last
	dump1 'prevCarry', hp.prevCarry

	for i in range hp.SPEED
		hp.singleStep()

mousePressed = ->
	for button in buttons
		if button.inside mouseX,mouseY
			print '##########',button.title,'##########'
			return keyboard.buffer.push button.key_code
	hp.toggle()
