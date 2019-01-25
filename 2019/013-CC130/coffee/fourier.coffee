# Coding Challenge 130: Drawing with Fourier Transform and Epicycles
# Daniel Shiffman
# https://thecodingtrain.com/CodingChallenges/130-fourier-transform-drawing.html
# https://youtu.be/MY4luNgGfms
# https://editor.p5js.org/codingtrain/sketches/ldBlISrsQ

dft = (x) ->
	X = []
	N = x.length
	for k in range N
		re = 0
		im = 0
		for n in range N
			phi = (TWO_PI * k * n) / N
			re += x[n] * cos phi
			im -= x[n] * sin phi
		re = re / N
		im = im / N

		freq = k
		amp = sqrt re * re + im * im
		phase = atan2 im, re
		X[k] = { re, im, freq, amp, phase }
	X
