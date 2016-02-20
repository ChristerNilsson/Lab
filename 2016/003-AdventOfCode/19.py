# http://adventofcode.com/day/19
# Problem from Bertil Friman

import time
import random

input = '''Al => ThF
Al => ThRnFAr
B => BCa
B => TiB
B => TiRnFAr
Ca => CaCa
Ca => PB
Ca => PRnFAr
Ca => SiRnFYFAr
Ca => SiRnMgAr
Ca => SiTh
F => CaF
F => PMg
F => SiAl
H => CRnAlAr
H => CRnFYFYFAr
H => CRnFYMgAr
H => CRnMgYFAr
H => HCa
H => NRnFYFAr
H => NRnMgAr
H => NTh
H => OB
H => ORnFAr
Mg => BF
Mg => TiMg
N => CRnFAr
N => HSi
O => CRnFYFAr
O => CRnMgAr
O => HP
O => NRnFAr
O => OTi
P => CaP
P => PTi
P => SiRnFAr
Si => CaSi
Th => ThCa
Ti => BP
Ti => TiTi
e => HF
e => NAl
e => OMg'''

def splitify(a,b,s):
    arr = s.split(a)
    res = []
    for i in range(1,len(arr)):
        res.append(a.join(arr[:i]) + b + a.join(arr[i:]))
    return res
#assert 'OO'.split('O') == ['','','']
#assert splitify('O','HH','HOH') == ['HHHH']
#assert splitify('O','HH','OO') == ['HHO','OHH']

s = '0123456789'
assert s[:0] == ''
assert s[:1] == '0'
assert s[:9] == '012345678'
assert s[:10] == '0123456789'
assert s[0:] == '0123456789'
assert s[1:] == '123456789'
assert s[9:] == '9'
assert s[10:] == ''

start = time.clock()
operations = [line.split(' => ') for line in input.split('\n')]
s = 'CRnSiRnCaPTiMgYCaPTiRnFArSiThFArCaSiThSiThPBCaCaSiRnSiRnTiTiMgArPBCaPMgYPTiRnFArFArCaSiRnBPMgArPRnCaPTiRnFArCaSiThCaCaFArPBCaCaPTiTiRnFArCaSiRnSiAlYSiThRnFArArCaSiRnBFArCaCaSiRnSiThCaCaCaFYCaPTiBCaSiThCaSiThPMgArSiRnCaPBFYCaCaFArCaCaCaCaSiThCaSiRnPRnFArPBSiThPRnFArSiRnMgArCaFYFArCaSiRnSiAlArTiTiTiTiTiTiTiRnPMgArPTiTiTiBSiRnSiAlArTiTiRnPMgArCaFYBPBPTiRnSiRnMgArSiThCaFArCaSiThFArPRnFArCaSiRnTiBSiThSiRnSiAlYCaFArPRnFArSiThCaFArCaCaSiThCaCaCaSiRnPRnCaFArFYPMgArCaPBCaPBSiRnFYPBCaFArCaSiAl'
count = 0
while s != 'e':
    for a, b in operations:
        t = s.replace(b, a, 1)
        if s != t:
            count += 1
            s = t
print count,time.clock()-start  # 200 680 microsecs