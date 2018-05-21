url = "index.html"
seeds = "ABCDEFGHIJ"
with open("Shortcut-GPS.html", "w") as f:
	f.write("<h1>Shortcut GPS</h1>\n<table style='font-size:200%'>\n")
	f.write("<a href='https://github.com/ChristerNilsson/Lab/blob/master/2018/037-Shortcut-GPS/README.md#shortcut-gps' style='font-size:200%'>Instruktioner</a><br><br>\n")
	for radius1 in [10,20,50,100,200,500]:
		f.write(f"<tr><td><a href='{radius1}.html'>{radius1} meter</a></td></tr>\n")
		with open(f"{radius1}.html", "w") as g:
			g.write(f"<h1>{radius1} meter</h1>\n<table style='font-size:200%'>\n")
			for level in range(1,11):
				s1 = f"&speed1={round((level-1)*0.05/radius1,4)}"
				if level <= 5:
					s2 = "&speed2=0"
				else:
					s2 = f"&speed2={round((level-5)*0.01/(0.3*radius1),4)}"
				g.write('<tr>\n')
				for i in range(10):
					nr = str(level) + seeds[i]
					seed = round(0.1+0.1*i,1)
					g.write(f"<td><a href='{url}?radius1={radius1}&nr={nr}&level={level}&seed={seed}{s1}{s2}'>{nr}</a></td>\n")
				g.write('</tr>\n')
			g.write('</table>')
	f.write('</table>')
