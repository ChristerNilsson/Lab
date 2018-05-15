# (C) 2015 Seth Lakowske

RADIUS = 6378137 # meter
FLATTENING = 1/298.257223560
POLAR_RADIUS = 6356752.3 # meter

mydegrees = (angle) -> angle * 180 / Math.PI
myradians = (angle) -> angle * Math.PI / 180

a    = RADIUS
f    = FLATTENING
b    = POLAR_RADIUS
asqr = a*a
bsqr = b*b

e = Math.sqrt (asqr-bsqr)/asqr
eprime = Math.sqrt (asqr-bsqr)/bsqr

project = (latitude, longitude, altitude) -> LLAToECEF myradians(latitude), myradians(longitude), altitude
unproject = (x, y, z) ->
    gps = ECEFToLLA x, y, z
    [mydegrees(gps[0]), mydegrees(gps[1])]

LLAToECEF = (latitude, longitude, altitude) ->
    N = getN latitude
    ratio = bsqr / asqr
    X = (N + altitude) * Math.cos(latitude) * Math.cos(longitude)
    Y = (N + altitude) * Math.cos(latitude) * Math.sin(longitude)
    Z = (ratio * N + altitude) * Math.sin(latitude)
    [X, Y, Z]

ECEFToLLA = (X, Y, Z) ->
    p = Math.sqrt X*X + Y*Y
    theta = Math.atan (Z*a)/(p*b)

    sintheta = Math.sin theta
    costheta = Math.cos theta

    num = Z + eprime * eprime * b * sintheta * sintheta * sintheta
    denom = p - e * e * a * costheta * costheta * costheta

    latitude  = Math.atan num/denom
    longitude = Math.atan Y/X
    N = getN latitude
    altitude  = (p / Math.cos(latitude)) - N

    if (X < 0 and Y < 0) then longitude -= Math.PI
    if (X < 0 and Y > 0) then longitude += Math.PI

    [latitude, longitude, altitude]

getN = (latitude) ->
    sinlatitude = Math.sin latitude
    denom = Math.sqrt 1-e*e*sinlatitude*sinlatitude
    a / denom

print [-2694044.411163704, -4266368.805505009, 3888310.602231939  ]
print project(37.8043722, -122.2708026, 0.0)
