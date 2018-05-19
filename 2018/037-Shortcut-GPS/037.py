url = "index.html"

seeds = "ABCDEFGHIJ"

with open("Shortcut-GPS.html", "w") as f:
	f.write('<h1>Shortcut GPS</h1>\n')
	for radius1 in [20,50,100,200,500]:
		f.write(f"<a href='{radius1}.html'>{radius1} meter</a><br>\n")
		with open(f"{radius1}.html", "w") as g:
			g.write(f"<h1>{radius1} meter</h1>\n<table>\n")
			for level in range(1,11):
				s1 = f"&speed1={(level-1)*0.05/radius1}"
				if level <= 5:
					s2 = "&speed2=0"
				else:
					s2 = f"&speed2={(level-5)*0.01/(0.3*radius1)}"
				g.write('<tr>')
				for i in range(10):
					nr = str(level) + seeds[i]
					seed = 0.1+0.1*i
					g.write(f"<td><a href='{url}?radius1={radius1}&nr={nr}&level={level}&seed={seed}{s1}{s2}'>{nr}</a></td>")
				g.write('</tr>\n')
			g.write('</table>')
