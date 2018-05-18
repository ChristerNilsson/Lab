# nr
# level
# seed
# radius1
# radius2
# speed1
# speed2
# cost

with open("Shortcut-GPS.html", "w") as f:
	f.write('<h1>Shortcut GPS</h1>\n')
	for i in range(3):
		suffix = "ABC"[i]
		for radius1 in [20,50,100,200,500]:
			f.write(f"<a href='{suffix}{radius1}.html'>{suffix}{radius1}</a><br>\n")
			with open(f"{suffix}{radius1}.html", "w") as g:
				g.write(f"<h1>{suffix}{radius1}</h1>\n")
				for level in range(1,21):
					seed = [0.1,0.2,0.3][i]
					nr = str(level) + suffix
					url = "index.html"
					s1=""
					s2=""
					if level <= 5:  s1 = "&speed1=0"
					if level <= 10: s2 = "&speed2=0"
					g.write(f"<a href='{url}?radius1={radius1}&nr={nr}&level={level}&seed={seed}{s1}{s2}'>level {level}</a><br>\n")
