for i in range(3):
	suffix = "ABC"[i]
	print(suffix+"<br>")
	for radius1 in [10,20,50,100,200,500]:
		print(str(radius1)+"<br>")
		for level in range(1,11):
			seed = [0.1,0.2,0.3][i]
			nr = str(level) + suffix
			url = "https://christernilsson.github.io/Lab/2018/037-Shortcut-GPS/index.html"
			#url = "file://C:/Lab/2018/037-Shortcut-GPS/index.html"
			print(f"<a href='{url}?radius1={radius1}&nr={nr}&level={level}&seed={seed}'>nr={nr} radius1={radius1} level={level} seed={seed}</a><br>")
