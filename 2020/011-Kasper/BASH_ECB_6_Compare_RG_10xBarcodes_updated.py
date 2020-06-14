### Associates 10X cell barcode with ECB seq cell barcode

### Remove barcodes from ECB defined barcodes if they are:
# ham 1 from more than 1 10X defined cell barcode
# more than 1 ham from any 10X defined barcode

import numpy as np
import time
import os
import sys

print('python version:',sys.version)
print('numpy version:',np.version.version)

os.chdir('.')

name = "ECB_data/Valid_cellBC_ECB_ham2_clean_RG"

def convertForw(str16): return ['ACGTN'.index(ch) for ch in str16]
assert convertForw('ACGT') == [0,1,2,3]
assert convertForw('AAAA') == [0,0,0,0]
assert convertForw('TTTT') == [3,3,3,3]

def convertBack(lst):	return ''.join(['ACGTN'[i] for i in lst])
assert convertBack([0,1,2,3]) == 'ACGT'
assert convertBack([0,0,0,0]) == 'AAAA'
assert convertBack([3,3,3,3]) == 'TTTT'

def make_bc10x():
	### Get all 10X defined cell barcodes
	with open("ECB_data/barcodes.tsv", "r") as fd:
		return [convertForw(line.split()[0][:-2]) for line in fd.readlines()]

def make_BCdic():
	### Get all ECB cell barcodes
	result = {}
	with open(name + ".txt", "r") as fd:
		for line in fd.readlines(): result[line[0:16]] = 0 ### 10X cell barcode
	return result

def hamming(bc,bc10x): # 'ACTGTGCACACTGTAC', list of list
	bc = convertForw(bc)
	bc = np.array(bc)
	diff = bc - bc10x
	return np.count_nonzero(diff, axis=1)

def count(arr,n): return np.count_nonzero(arr == n)

def testHamming(a,b,expected):
	b = [convertForw(item) for item in b]
	result = hamming(a,b)
	for i in range(len(a)):
		if expected[i] != result[i]: return False
	return True
assert testHamming('ACGT',['ACGT','AAGT','AAAT','AAAA','TGCA'],[0,1,2,3,4])

def handleOne(bc,bc10x):
	arrHamming = hamming(bc,bc10x)
	mindex = np.argmin(arrHamming)
	minHam = arrHamming[mindex]
	b = convertBack(bc10x[mindex])
	if minHam == 0: return b
	if minHam == 1:
		if count(arrHamming,1) == 1: return b  # if unique with distance 1
		return "Remove_multham1"
	if minHam == 2:
		if count(arrHamming,2) == 1: return b  # if unique with distance 2
		return "Remove_multham2"
	return "Remove_Minham"

def testHandleOne(a,b):
	b = [convertForw(item) for item in b]
	return handleOne(a,b)
assert testHandleOne('ACGT',['ACGT','AAGT','AAAT','AAAA','TGCA']) == 'ACGT'
assert testHandleOne('ACGT',['ACGT','ACGT']) == 'ACGT'
assert testHandleOne('ACGT',['AAGT','AAAT','AAAA','TGCA']) == 'AAGT'
assert testHandleOne('ACGT',['AAAT','AAAA','TGCA']) == "AAAT"
assert testHandleOne('ACGT',['AAGT','CCGT','AAAA','TGCA']) == "Remove_multham1"
assert testHandleOne('ACGT',['AAGT','AAGT']) == "Remove_multham1"
assert testHandleOne('ACGT',['AGCT','TTTT','AAAA','TGCA']) == 'AGCT'
assert testHandleOne('ACGT',['AGCT','CAGT','AAAA','TGCA']) == 'Remove_multham2'

start = time.time()

bc10x = make_bc10x()
bc10x = np.array(bc10x)

BCdic = make_BCdic()

hamAssociated = BCdic # copy.deepcopy(BCdic)

for bc in BCdic: # {}
	hamAssociated[bc] = handleOne(bc,bc10x)

with open(name + "_compared_10X_barcodes_1.txt", "w") as fout:
	fout.write("ECB_barcode\tAssociated_10X_barcode\n")
	for h in hamAssociated:
		fout.write(f"{h}\t{hamAssociated[h]}\n")

print(time.time()-start)
