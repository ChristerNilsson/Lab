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
	constructor : (@key_code,@title,@x,@y,@w=30) -> @h = 15
	inside : (x,y) -> @x-@w/2 < x < @x+@w/2 and @y-@h/2 < y < @y+@h/2 
	draw : ->
		textAlign CENTER,CENTER
		fc 1
		rect @x,@y,@w,@h
		fc 0
		text @title,@x,@y

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

	buttons.push new Button 6,'x^y',25,40,30-2
	buttons.push new Button 4,'log',65-3,40,30-2
	buttons.push new Button 3,'ln',105-6,40,30-2
	buttons.push new Button 2,'e^x',145-9,40,30-2
	buttons.push new Button 0,'CLR',185-12,40,30-2

	buttons.push new Button 46,'sqrt',25,60,30-2
	buttons.push new Button 44,'arc',65-3,60,30-2
	buttons.push new Button 43,'sin',105-6,60,30-2
	buttons.push new Button 42,'cos',145-9,60,30-2
	buttons.push new Button 40,'tan',185-12,60,30-2

	buttons.push new Button 14,'1/x',25,80,30-2
	buttons.push new Button 12,'x<>y',65-3,80,30-2
	buttons.push new Button 11,'RDN',105-6,80,30-2
	buttons.push new Button 10,'STO',145-9,80,30-2
	buttons.push new Button 8,'RCL',185-12,80,30-2

	buttons.push new Button 62,'ENTER',45-1,100,70-4
	buttons.push new Button 59,'CHS',105-6,100,30-2
	buttons.push new Button 58,'EEX',145-9,100,30-2
	buttons.push new Button 56,'CL x',185-12,100,30-2

	buttons.push new Button 54,'-',25,120
	buttons.push new Button 52,'7',75,120
	buttons.push new Button 51,'8',125,120
	buttons.push new Button 50,'9',175,120

	buttons.push new Button 22,'+',25,140
	buttons.push new Button 20,'4',75,140
	buttons.push new Button 19,'5',125,140
	buttons.push new Button 18,'6',175,140

	buttons.push new Button 30,'x',25,160
	buttons.push new Button 28,'1',75,160
	buttons.push new Button 27,'2',125,160
	buttons.push new Button 26,'3',175,160

	buttons.push new Button 38,'/',25,180
	buttons.push new Button 36,'0',75,180
	buttons.push new Button 35,'.',125,180
	buttons.push new Button 34,'pi',175,180

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
	for button in buttons
		button.draw()

	textAlign LEFT,CENTER

	dump 'a',hp.a,210
	dump 'b',hp.b,220
	dump 'c x',hp.c,230
	dump 'd y',hp.d,240
	dump 'e z',hp.e,250
	dump 'f t',hp.f,260
	dump 't',hp.t,270
	dump 'm',hp.m,280
	dump 's',hp.s,290,12

	for i in range hp.SPEED
		hp.singleStep()

	x = 5
	y = 310
	dump1 'p', hp.p
	dump1 'key_code', hp.key_code
	dump1 'carry', hp.carry
	dump1 'offset', hp.offset
	dump1 'display_enable',hp.display_enable
	dump1 'update_display',hp.update_display
	dump1 'op_code', hp.op_code
	dump1 'first', hp.first
	dump1 'last', hp.last
	dump1 'prevCarry', hp.prevCarry
	dump1 'ret', hp.ret

mousePressed = ->
	if mouseY < 20 then return hp.toggle()
	for button in buttons
		if button.inside mouseX,mouseY
			print '##########',button.title,'##########'
			keyboard.buffer.push button.key_code
