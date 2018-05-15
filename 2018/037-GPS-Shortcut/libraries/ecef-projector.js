/*
 * (C) 2015 Seth Lakowske

 * A projector that converts GPS->ECEF and ECEF->GPS
 *
 * Formulas from this paper:
 * Datum Transformations of GPS Positions
 * Application Note
 * 5th July 1999
 */

// var wgs84 = require('wgs84');
RADIUS = 6378137; // meter
FLATTENING = 1/298.257223560;
POLAR_RADIUS = 6356752.3; // meter

/*
 * Converts an angle in radians to degrees.
 */
function mydegrees(angle) {
    return angle * (180 / Math.PI);
}

/*
 * Converts an angle in degrees to radians.
 */
function myradians(angle) {
    return angle * (Math.PI / 180);
}

/*
 * Some constants we'll want to have on hand
 */
var a    = RADIUS;
var f    = FLATTENING;
var b    = POLAR_RADIUS;
var asqr = a*a;
var bsqr = b*b;

var e = Math.sqrt((asqr-bsqr)/asqr);
var eprime = Math.sqrt((asqr-bsqr)/bsqr);


/*
 * Convert GPS coordinates (degrees) to Cartesian coordinates (meters)
 */
function project(latitude, longitude, altitude) {
    return LLAToECEF(myradians(latitude), myradians(longitude), altitude);
}

/*
 * Convert Cartesian coordinates (meters) to GPS coordinates (degrees)
 */
function unproject(x, y, z) {
    var gps = ECEFToLLA(x, y, z);

    gps[0] = mydegrees(gps[0]);
    gps[1] = mydegrees(gps[1]);

    return gps;
}

function LLAToECEF(latitude, longitude, altitude) {
    //Auxiliary values first
    var N = getN(latitude);
    var ratio = (bsqr / asqr);

    //Now calculate the Cartesian coordinates
    var X = (N + altitude) * Math.cos(latitude) * Math.cos(longitude);
    var Y = (N + altitude) * Math.cos(latitude) * Math.sin(longitude);

    //Sine of latitude looks right here
    var Z = (ratio * N + altitude) * Math.sin(latitude);

    return [X, Y, Z];
}

function ECEFToLLA(X, Y, Z) {
    //Auxiliary values first
    var p = Math.sqrt(X*X + Y*Y);
    var theta = Math.atan((Z*a)/(p*b));

    var sintheta = Math.sin(theta);
    var costheta = Math.cos(theta);

    var num = Z + eprime * eprime * b * sintheta * sintheta * sintheta;
    var denom = p - e * e * a * costheta * costheta * costheta;

    //Now calculate LLA
    var latitude  = Math.atan(num/denom);
    var longitude = Math.atan(Y/X);
    var N = getN(latitude);
    var altitude  = (p / Math.cos(latitude)) - N;

    if (X < 0 && Y < 0) {
        longitude = longitude - Math.PI;
    }

    if (X < 0 && Y > 0) {
        longitude = longitude + Math.PI;
    }

    return [latitude, longitude, altitude];
}

function getN(latitude) {
    var sinlatitude = Math.sin(latitude);
    var denom = Math.sqrt(1-e*e*sinlatitude*sinlatitude);
    var N = a / denom;
    return N;
}

console.log([-2694044.411163704, -4266368.805505009, 3888310.602231939  ]);
console.log(project(37.8043722, -122.2708026, 0.0));
