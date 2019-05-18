# please note: p5.js has been patched by me to make this work.

range = _.range

```
function doNf0() {
  var num = arguments[0];
  num = num.toFixed(arguments[2]);  //
  var neg = num < 0;
  var n = neg ? num.toString().substring(1) : num.toString();
  var decimalInd = n.indexOf('.');
  var intPart = decimalInd !== -1 ? n.substring(0, decimalInd) : n;
  var decPart = decimalInd !== -1 ? n.substring(decimalInd + 1) : '';
  var str = neg ? '-' : '';
  if (arguments.length === 3) {
    var decimal = '';
    if (decimalInd !== -1 || arguments[2] - decPart.length > 0) {
      decimal = '.';
    }
    if (decPart.length > arguments[2]) {
      decPart = decPart.substring(0, arguments[2]);
    }
    for (var i = 0; i < arguments[1] - intPart.length; i++) {
      str += '0';
    }
    str += intPart;
    str += decimal;
    str += decPart;
    for (var j = 0; j < arguments[2] - decPart.length; j++) {
      str += '0';
    }
    return str;
  } else {
    for (var k = 0; k < Math.max(arguments[1] - intPart.length, 0); k++) {
      str += '0';
    }
    str += n;
    return str;
  }
}
```

doNf = ->
	a = arguments[0]
	neg = a < 0
	res = abs(a).toFixed (arguments[2] || 0)
	zeros = '0'.repeat (arguments[1] || 0)-res.indexOf '.'
	res = zeros + res
	if neg then '-' + res else res 

################

```
function doNfc0() {
  var num = arguments[0].toString();
  var dec = num.indexOf('.');
  var rem = dec !== -1 ? num.substring(dec) : '';
  var n = dec !== -1 ? num.substring(0, dec) : num;
  n = n.toString().replace(/\B(?=(\d{3})+(?!\d))/g, ',');
  if (arguments[1] === 0) {
    rem = '';
  }
  else if (arguments[1] !== undefined) {
    if (arguments[1] > rem.length) {
      rem+= dec === -1 ? '.' : '';
      var len = arguments[1] - rem.length + 1;
      for(var i =0; i< len; i++) {
        rem += '0';
      }
    } else {
      rem = rem.substring(0, arguments[1] + 1);
    }
  }
  return n + rem;
}
```
doNfc = ->
	a = arguments[0]
	b = arguments[1] || 0
	num = a.toFixed b
	d = num.indexOf '.'
	if d == -1 then d = num.length
	res = num.slice d
	for i in [d-3..1] by -3
		res = ',' + num.slice(i, i+3) + res 
	num.slice(0,i+3) + res 

setup = ->

	assrange = (c,d,a,b) ->
		for i in range 10
			assert b[i], doNf a[i],c,d 

	assrange0 = (c,d,a,b) ->
		for i in range 10
			assert b[i],doNf0 a[i],c,d 

	arr = [-0.51, -0.39, -0.3, -0.2, -0.1, 0.0, 0.1, 0.2, 0.29, 0.41]

	start = millis()
	for i in range 100000
		assrange 1,1,arr,["-0.5", "-0.4", "-0.3", "-0.2", "-0.1", "0.0", "0.1", "0.2", "0.3", "0.4"]
		assrange 2,1,arr,["-00.5", "-00.4", "-00.3", "-00.2", "-00.1", "00.0", "00.1", "00.2", "00.3", "00.4"]
		assrange 3,1,arr,["-000.5", "-000.4", "-000.3", "-000.2", "-000.1", "000.0", "000.1", "000.2", "000.3", "000.4"]
	print millis()-start 

	start = millis()
	for i in range 100000
		assrange0 1,1,arr,["-0.5", "-0.4", "-0.3", "-0.2", "-0.1", "0.0", "0.1", "0.2", "0.3", "0.4"]
		assrange0 2,1,arr,["-00.5", "-00.4", "-00.3", "-00.2", "-00.1", "00.0", "00.1", "00.2", "00.3", "00.4"]
		assrange0 3,1,arr,["-000.5", "-000.4", "-000.3", "-000.2", "-000.1", "000.0", "000.1", "000.2", "000.3", "000.4"]
	print millis()-start 

	start = millis()
	for i in range 100000
		assert '12,345', doNfc 12345
		assert '123,456', doNfc 123456
		assert '1,234,567.000', doNfc 1234567,3
		assert '1,234,567', doNfc 1234567
		assert '1,234,568', doNfc 1234567.89
		assert '1,234,567.9', doNfc 1234567.89,1
		assert '1,234,567.89', doNfc 1234567.89,2
		assert '-1,234,567', doNfc -1234567
		assert '-1,234,568', doNfc -1234567.89
		assert '-1,234,567.9', doNfc -1234567.89,1
		assert '-1,234,567.89', doNfc -1234567.89,2
		assert '-1.2345679', doNfc -1.23456789,7
	print millis()-start 

	start = millis()
	for i in range 100000
		assert '12,345', doNfc0 12345
		assert '123,456', doNfc0 123456
		assert '1,234,567.000', doNfc0 1234567,3
		assert '1,234,567', doNfc0 1234567
		assert '1,234,567', doNfc0 1234567
		assert '1,234,567.8', doNfc0 1234567.89,1
		assert '1,234,567.89', doNfc0 1234567.89,2
		assert '-1,234,567', doNfc0 -1234567
		assert '-1,234,567', doNfc0 -1234567
		assert '-1,234,567.8', doNfc0 -1234567.89,1
		assert '-1,234,567.89', doNfc0 -1234567.89,2
		assert '-1.2345679', doNfc -1.23456789,7
	print millis()-start 

	#assert doNf(arr,1,1), ["-0.5", "-0.4", "-0.3", "-0.2", "-0.1", "0.0", "0.1", "0.2", "0.3", "0.4"]
	# assert doNf(3.76,1,1), "3.8"
	# assert doNf(-3.76,1,1), "-3.8"

	# assert doNfp(arr,1,1), ["-0.5", "-0.4", "-0.3", "-0.2", "-0.1", "0.0", "+0.1", "+0.2", "+0.3", "+0.4"]
	# assert doNfp(3.76,1,1), "+3.8"
	# assert doNfp(-3.76,1,1), "-3.8"

	# assert doNfs(arr,1,1), ["-0.5", "-0.4", "-0.3", "-0.2", "-0.1", "0.0", " 0.1", " 0.2", " 0.3", " 0.4"]
	# assert doNfs(3.76,1,1), " 3.8"
	# assert doNfs(-3.76,1,1), "-3.8"

	# arr = [12567,-12567, 12345,-12345]

	# assert doNfc(arr,2), ["12,567.00", "-12,567.00", "12,345.00", "-12,345.00"]
	# assert doNfc(12567,2), "12,567.00"
	# assert doNfc(-12567,2), "-12,567.00"




	print 'Ready!'
