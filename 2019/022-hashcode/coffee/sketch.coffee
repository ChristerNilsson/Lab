n = 5
arr = "#111 #222 #333 #444 #555 #666 #777 #888 #999 #aaa #bbb #ccc #ddd #eee".split ' '
marker = -1

setup = ->
	createCanvas n*250+1,n*200+1	

draw = ->
	for slice,index in slices
		sw 1
		[r1,c1,r2,c2,clr] = slice	
		sc if clr<8 then 1 else 0
		if marker == index 
			#print marker,index
			stroke 255,0,0
		fill arr[clr]
		rect n*c1,n*r1,n*c2-n*c1+n,n*r2-n*r1+n

		stroke 0,255,0
		sw 2
		for j in range r1,r2+1
			for i in range c1,c2+1
				point n*(i+0.5),n*(j+0.5)

mousePressed = ->
	for slice,index in slices
		[r1,c1,r2,c2,clr] = slice
		if n*c1-1 <= mouseX <= n*c2+1 and n*r1-1 <= mouseY <= n*r2+1
			marker = index
			print slice

# setup = ->
# 	createCanvas n*1000+1,n*1000+1	

# draw = ->
# 	for slice in slices
# 		sw 1
# 		[r1,c1,r2,c2,index] = slice	
# 		sc if index<8 then 1 else 0
# 		fill arr[index]
# 		rect n*c1,n*r1,n*c2-n*c1+n,n*r2-n*r1+n
# 		stroke 0,255,0
# 		sw 2
# 		for j in range r1,r2+1
# 			for i in range c1,c2+1
# 				point n*(i+0.5),n*(j+0.5)
