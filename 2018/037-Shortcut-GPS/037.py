url = "index.html"
seeds = "ABCDEFGH"
with open("Shortcut-GPS.html", "w") as f:
	f.write("<head><link rel='stylesheet' href='shortcut.css'></head>\n")
	f.write("<h1>Shortcut GPS</h1>\n")
	f.write("<table style='font-size:400%'>\n")
	f.write("<tr><td><a href='https://github.com/ChristerNilsson/Lab/blob/master/2018/037-Shortcut-GPS/README.md#shortcut-gps'>Instruktioner</a></td></tr>\n")
	for radius1 in [10,20,50,100,200,500]:
		f.write(f"<tr><td><a href='{radius1}.html'>{radius1} meter</a></td></tr>\n")
		with open(f"{radius1}.html", "w") as g:
			g.write("<head><link rel='stylesheet' href='shortcut.css'></head>\n")
			g.write(f"<h1>{radius1} meter</h1>\n<table style='font-size:300%'>\n")
			for level in range(1,11):
				s1 = f"&speed1={round((level-1)*0.05/radius1,4)}"
				if level <= 5:
					s2 = "&speed2=0"
				else:
					s2 = f"&speed2={round((level-5)*0.01/(0.3*radius1),4)}"
				g.write('<tr>\n')
				g.write(f'<td>{level}</td>\n')
				for i in range(len(seeds)):
					nr = seeds[i]
					seed = round(0.1+0.1*i,1)
					g.write(f"<td><a href='{url}?radius1={radius1}&nr={str(level)+nr}&level={level}&seed={seed}{s1}{s2}'>{nr}</a></td>\n")
				g.write('</tr>\n')
			g.write('</table>')
	f.write('</table>')
