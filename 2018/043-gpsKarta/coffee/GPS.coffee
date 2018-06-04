class GPS # hanterar GPS konvertering
	constructor : (@nw,@ne,@se,@sw,@w,@h) ->

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
		q1 = @calcLon mlat,mlon,@nw,@ne
		q2 = @calcLon mlat,mlon,@sw,@se
		x = round map mlat, q1.lat,q2.lat, q1.x,q2.x
		y = round map mlat, q1.lat,q2.lat, q1.y,q2.y
		[x,y]

		# q3 = calcLat mlat,mlon,N,Q
		# q4 = calcLat mlat,mlon,O,P
		# x2 = map mlon, q3.lon,q4.lon, q3.x, q4.x
		# y2 = map mlon, q3.lon,q4.lon, q3.y, q4.y
		#[int(x1),int(y1)]

	check_gps2bmp : (p,error) ->
		[x,y] = @gps2bmp p.lat,p.lon 
		assert error, [x-p.x, y-p.y]

	calcx : (x,y,a,b) ->
		lon = map x, a.x,b.x, a.lon,b.lon
		lat = map x, a.x,b.x, a.lat,b.lat  
		{lat,lon,x,y} 	

	calcy : (x,y,a,b) ->
		lon = map y, a.y,b.y, a.lon,b.lon
		lat = map y, a.y,b.y, a.lat,b.lat  
		{lat,lon,x,y} 	

	bmp2gps : (mx,my) ->
		q1 = @calcx mx,0,@nw,@ne
		q2 = @calcx mx,HEIGHT,@sw,@se
		q = @calcy mx,my,q1,q2
		[myround(q.lat,6),myround(q.lon,6)]

	check_bmp2gps : (p,error) ->
		[lat,lon] = @bmp2gps p.x,p.y 
		assert error, [myround(100000*(lat-p.lat),6), myround(50000*(lon-p.lon),6)]
