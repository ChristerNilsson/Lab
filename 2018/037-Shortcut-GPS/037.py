url = "index.html"
with open("Shortcut-GPS.html", "w") as f:
	f.write('<h1>Shortcut GPS</h1>\n')
	for radius1 in [20,50,100,200,500]:
		f.write(f"<a href='{radius1}.html'>{radius1} meter</a><br>\n")
		with open(f"{radius1}.html", "w") as g:
			g.write(f"<h1>{radius1} meter</h1>\n<table>\n")
			for level in range(1,21):
				s1=""
				s2=""
				if level <= 5:  s1 = "&speed1=0"
				if level <= 10: s2 = "&speed2=0"
				g.write('<tr>')
				for i in range(3):
					nr = str(level) + "ABC"[i]
					seed = [0.1, 0.2, 0.3][i]
					g.write(f"<td><a href='{url}?radius1={radius1}&nr={nr}&level={level}&seed={seed}{s1}{s2}'>{nr}</a></td>")
				g.write('</tr>\n')
			g.write('</table>')
