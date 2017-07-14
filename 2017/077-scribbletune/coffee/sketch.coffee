# https://www.youtube.com/watch?v=dIiwFzFvsmw&t=589s

scribble = require 'scribbletune'
clip = (x) ->
	x.notes = x.notes.split ' '
	scribble.clip x
midi = (name,clips...) ->
	console.log clips.length
	res = []
	for c in clips
		res = res.concat c
	scribble.midi res, name+'.mid'
midiclip = (name,x) -> midi name, clip(x)

midiclip 'a',
	notes: 'c2 c#2 d2 d#2'
	pattern : 'x-x-x--x'
	sizzle : true
	shuffle: true

midiclip 'b',
	notes: 'c2 c#2 d2 d#2'
	pattern : 'x-x-xxxx'
	sizzle : true
	shuffle: true

midiclip 'c',
	notes: 'f#2'
	pattern : 'x-'.repeat 8

a = clip
	notes: 'f#3'
	pattern : 'x-'.repeat 8
	accentMap: [5,10,20,30,40,50,60,70,80,90,100,110,120,120,120,120]

midi 'verse',
	a
	a
