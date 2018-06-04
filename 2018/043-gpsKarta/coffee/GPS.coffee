class GPS # hanterar GPS konvertering
	constructor : (@N,@O,@P,@Q,@w,@h) ->
		#@xo = @w/2
		#@yo = @h/2
		# p0 = LatLon @lat,@lon
		# p1 = p0.destinationPoint @h/2, 0
		# @lat2 = p1.lat
		# p2 = p0.destinationPoint @w/2, 90
		# @lon2 = p2.lon
		# p3 = p0.destinationPoint @h/2, 180
		# @lat1 = p3.lat
		# p4 = p0.destinationPoint @w/2, 270
		# @lon1 = p4.lon
	# toXY : (lat,lon) ->
	# 	x = @xo + SCALE * map lon, @lon1, @lon2, -@w/2, @w/2
	# 	y = @yo + SCALE * map lat, @lat2, @lat1, -@h/2, @h/2 # turned
	# 	{x,y}
	# toWGS84 : (x,y) -> # not used
	# 	lon = map (x-xo)/SCALE, -@w/2, @w/2, @lon1, @lon2
	# 	lat = map (y-yo)/SCALE, -@h/2, @h/2, @lat1, @lat2
	# 	{lat,lon}

	calcLon : (mlat,mlon,a,b) ->
		x = map mlon, a.lon,b.lon, a.x,b.x
		y = map mlon, a.lon,b.lon, a.y,b.y 
		lat = map mlon, a.lon,b.lon, a.lat,b.lat
		lon = mlon
		{lat,lon,x,y} 	

	calcLat : (mlat,mlon,a,b) ->
		x = map mlat, a.lat,b.lat, a.x,b.x
		y = map mlat, a.lat,b.lat, a.y,b.y
		lat = mlat
		lon = map mlat, a.lat,b.lat, a.lon,b.lon
		{lat,lon,x,y} 	

	gps2bmp : (mlat,mlon) ->
		q1 = @calcLon mlat,mlon,@N,@O
		q2 = @calcLon mlat,mlon,@Q,@P
		x = map mlat, q1.lat,q2.lat, q1.x, q2.x
		y = map mlat, q1.lat,q2.lat, q1.y, q2.y

		# q3 = calcLat mlat,mlon,N,Q
		# q4 = calcLat mlat,mlon,O,P
		# x2 = map mlon, q3.lon,q4.lon, q3.x, q4.x
		# y2 = map mlon, q3.lon,q4.lon, q3.y, q4.y
		{x,y}
		#[int(x1),int(y1)]

	check_gps2bmp : (p,error) ->
		[x,y] = gps2bmp p.lat,p.lon 
		assert error, [x-p.x, y-p.y]

